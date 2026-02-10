#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185642 "FOSA Loan Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/FOSA Loan Register.rdl';

    dataset
    {
        //dataitem(Members;Members)

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
                column(CompanyTelephone; Company."Phone No.")
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
                        "Source Unit" := ProductFactory."Source Unit";
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
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
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
        //AccountCategory: Enum "Account Category";
        Member: Record "Members";
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
