#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185969 "Non Salaried Loans Granted"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Non Salaried Loans Granted.rdl';

    dataset
    {
        //dataitem(52185700;52185700)
        dataitem(Members; "Members")
        {
            column(ReportForNavId_30; 30)
            {
            }
            dataitem(Loans; Loans)
            {
                DataItemLink = "Member No." = field("No.");
                DataItemLinkReference = Members;
                RequestFilterFields = "Loan No.", "Loan Product Type", "Member No.";
                column(ReportForNavId_1; 1)
                {
                }
                column(SalNo; SalNo)
                {
                }
                column(SalDate; SalDate)
                {
                }
                column(SalAmnt; SalAmnt)
                {
                }
                column(LoanNo_Loans; Loans."Loan No.")
                {
                }
                column(Repayment; Loans.Repayment)
                {
                }
                column(ApplicationDate_Loans; Loans."Application Date")
                {
                }
                column(LoansCategorySASRA_Loans; Loans."Loans Category-SASRA")
                {
                }
                column(LoanProductType_Loans; Loans."Loan Product Type")
                {
                }
                column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
                {
                }
                column(MemberNo_Loans; Loans."Member No.")
                {
                }
                column(MemberName_Loans; Loans."Member Name")
                {
                }
                column(Installemnt; Loans.Installments)
                {
                }
                column(RequestedAmount; Loans."Requested Amount")
                {
                }
                column(ApprovedAmount; Loans."Approved Amount")
                {
                }
                column(OutBal; Loans."Outstanding Balance")
                {
                }
                column(OutInt; Loans."Outstanding Interest")
                {
                }
                column(OutBill; Loans."Outstanding Bills")
                {
                }
                column(Picture; Company.Picture)
                {
                }
                column(Address; Company.Address)
                {
                }
                column(Company_Name; Company.Name)
                {
                }
                column(EmployerLoanNo; Loans."Employer Loan No.")
                {
                }
                column(BatchNo_Loans; Loans."Batch No.")
                {
                }
                column(ShareBoostedAmount; Loans."Share Boosted Amount")
                {
                }
                column(ShareBoostedAmount1; Loans."Loans - Deposit Purchase")
                {
                }
                column(EmployerCode; Loans."Employer Code")
                {
                }
                column(AmntTp; AmntTp)
                {
                }
                column(StaffNo; Loans."Staff No")
                {
                }
                column(Days; Days)
                {
                }
                column(ProductType; ProductType)
                {
                }
                column(EmployerName; EmployerName)
                {
                }
                column(OutstandingBills_Loans; Loans."Outstanding Bills")
                {
                }
                column(AccountCategory; AccountCategory)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    AmntTp := 0;
                    EmployerName := '';
                    ProductType := '';
                    LoansTopup.Reset;
                    LoansTopup.SetRange("Loan No.", "Loan No.");
                    if LoansTopup.Find('-') then begin
                        LoansTopup.CalcSums("Total Top Up");
                        AmntTp := LoansTopup."Total Top Up";
                    end;

                    OtherCommitementsClearance.Reset;
                    OtherCommitementsClearance.SetRange("Loan No.", Loans."Loan No.");
                    if OtherCommitementsClearance.Find('-') then begin
                        OtherCommitementsClearance.CalcSums(Amount);
                        AmntTp := AmntTp + OtherCommitementsClearance.Amount;
                    end;

                    Days := 0;
                    if Loans."Disbursement Date" <> 0D then
                        Days := Today - Loans."Disbursement Date";
                    if ProductFactory.Get(Loans."Loan Product Type") then
                        ProductType := ProductFactory."Product Description";
                    if Customer.Get(Loans."Employer Code") then
                        EmployerName := Customer.Name;
                    if Member.Get(Loans."Member No.") then
                        AccountCategory := Member."Account Category";

                    SalAmnt := 0;
                    SalDate := 0D;
                    SalNo := '';
                    SalaryLines.Reset;
                    SalaryLines.SetRange("Member No.", Loans."Member No.");
                    SalaryLines.SetRange(Posted, true);
                    if SalaryLines.FindLast then begin

                        SalAmnt := SalaryLines.Amount;
                        SalDate := SalaryLines."Posting Date";
                        SalNo := SalaryLines."Salary Header No."

                    end;
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        Company.Get;
        //Company.CALCFIELDS(Company.Picture);
    end;

    var
        ProductType: Text;
        MemberBiodata: Text;
        Company: Record "Company Information";
        LoansTopup: Record "Loans Top up";
        AmntTp: Decimal;
        Days: Integer;
        OtherCommitementsClearance: Record "Other Commitements Clearance";
        Customer: Record Customer;
        EmployerName: Text;
        ProductFactory: Record "Product Factory";
        AccountCategory: enum "Account Category";//Option Member,"Staff Members","Board Members",Delegates;
        Member: Record "Members";
        SalaryLines: Record "Salary Lines";
        SalNo: Code[20];
        SalDate: Date;
        SalAmnt: Decimal;
}
