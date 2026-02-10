#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185994 "Delegates Loan Register New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Delegates Loan Register New.rdl';

    dataset
    {
        //  dataitem(52186063;52186063)
        dataitem("Delegates Memberss"; "Delegate Members")
        {
            // DataItemTableView = where(Type = filter(Normal), Retired = filter(True));
            column(ReportForNavId_39; 39)
            {
            }
            dataitem(Loans; "Loans")
            {
                // DataItemLink = "Member No." = field("Delegate MNO.");
                // DataItemTableView = where(Posted = filter(Yes), "Outstanding Balance" = filter(<> 0), "Member No." = filter(<> ""));
                RequestFilterFields = "Loan No.", "Loan Product Type", "Member No.";
                column(ReportForNavId_1; 1)
                {
                }
                column(LoanNo_Loans; Loans."Loan No.")
                {
                }
                column(ApplicationDate_Loans; Loans."Application Date")
                {
                }
                column(DisburmentDate; Loans."Disbursement Date")
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
                column(MaturityDate; Loans."Expected Date of Completion")
                {
                }
                column(LatestDatePaid; LatestDatePaid)
                {
                }
                column(LatestAmount; LatestAmount)
                {
                }
                column(LoanClassification; Loans."Loans Category-SASRA")
                {
                }
                column(Frequecy; Loans."Repayment Frequency")
                {
                }
                column(Interest; Loans.Interest)
                {
                }
                column(Installments; Loans.Installments)
                {
                }
                column(FirstRepaymentDate; Loans."Repayment Start Date")
                {
                }
                column(DaysArreas; DaysArreas)
                {
                }
                column(InterestCalculationMethod; Loans."Interest Calculation Method")
                {
                }
                column(DisbursementDate; Loans."Disbursement Date")
                {
                }
                column(Regname; Regname)
                {
                }
                column(SalaryPassesThruFOSA; SalaryPasses)
                {
                }
                column(DateLastCredited; DateLastCredited)
                {
                }
                column(RecoveryMode_Loans; Loans."Recovery Mode")
                {
                }

                trigger OnAfterGetRecord()
                begin

                    AmntTp := 0;
                    DaysArreas := 0;
                    LatestAmount := 0;
                    LatestDatePaid := 0D;
                    EmployerName := '';
                    ProductType := '';
                    SalaryPasses := '';
                    DateLastCredited := 0D;

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

                    CreditLedgerEntry.Reset;
                    CreditLedgerEntry.SetRange("Loan No", Loans."Loan No.");
                    CreditLedgerEntry.SetRange("Customer No.", Loans."Loan Account");
                    CreditLedgerEntry.SetRange("Transaction Type", CreditLedgerEntry."transaction type"::Repayment);
                    if CreditLedgerEntry.Find('+') then begin
                        LatestDatePaid := CreditLedgerEntry."Posting Date";
                        LatestAmount := Abs(CreditLedgerEntry.Amount);
                    end;



                    if Loans."Loans Category-SASRA" <> Loans."loans category-sasra"::Perfoming then begin
                        if LatestDatePaid <> 0D then
                            DaysArreas := Today - LatestDatePaid;
                    end;


                    delmbr.Reset;
                    delmbr.SetRange("Delegate MNO.", Loans."Member No.");
                    if delmbr.Find('-') then begin
                        // delmbr.CalcFields("Region Names");
                        // Regname := delmbr."Region Names";
                    end;

                    SavingsAccounts.Reset;
                    SavingsAccounts.SetRange("Member No.", Loans."Member No.");
                    SavingsAccounts.SetFilter("Product Type", '505');
                    if SavingsAccounts.Find('-') then begin
                        if SavingsAccounts."Salary Through FOSA" = true then begin
                            SalaryPasses := 'Yes';

                            //get last credit date
                            SalaryLines.Reset;
                            SalaryLines.SetRange("Account No.", SavingsAccounts."No.");
                            SalaryLines.SetRange(Posted, true);
                            SalaryLines.SetCurrentkey("No.");
                            if SalaryLines.Find('+') then
                                DateLastCredited := SalaryLines."Posting Date";
                        end else begin
                            SalaryPasses := 'No';
                            DateLastCredited := 0D;
                        end;
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
        CreditLedgerEntry: Record "Credit Ledger Entry";
        LatestDatePaid: Date;
        LatestAmount: Decimal;
        DaysArreas: Integer;
        delmbr: Record "Delegate Members";
        Regname: Text;
        SalaryPasses: Text;
        DateLastCredited: Date;
        SavingsAccounts: Record "Savings Accounts";
        SalaryLines: Record "Salary Lines";
}
