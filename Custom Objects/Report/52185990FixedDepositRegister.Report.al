#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185990 "Fixed Deposit Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Savings Contribution Variance.rdl';

    dataset
    {
        dataitem("Savings Accounts"; "Savings Accounts")
        {
            RequestFilterFields = "No.", "Product Type", "Employer Code", "ID No.", "Payroll/Staff No.", Status;
            column(ReportForNavId_1; 1)
            {
            }
            column(No_SavingsAccounts; "Savings Accounts"."No.")
            {
            }
            column(Status_SavingsAccounts; "Savings Accounts".Status)
            {
            }
            column(MemberNo_SavingsAccounts; "Savings Accounts"."Member No.")
            {
            }
            column(ProductName_SavingsAccounts; "Savings Accounts"."Product Name")
            {
            }
            column(Name_SavingsAccounts; "Savings Accounts".Name)
            {
            }
            column(EmployerCode_SavingsAccounts; "Savings Accounts"."Employer Code")
            {
            }
            column(DateofBirth_SavingsAccounts; "Savings Accounts"."Date of Birth")
            {
            }
            column(HomeAddress_SavingsAccounts; "Savings Accounts"."Home Address")
            {
            }
            column(PayrollStaffNo_SavingsAccounts; "Savings Accounts"."Payroll/Staff No.")
            {
            }
            column(IDNo_SavingsAccounts; "Savings Accounts"."ID No.")
            {
            }
            column(BalanceLCY_SavingsAccounts; "Savings Accounts"."Balance (LCY)")
            {
            }
            column(ActualCont; ActualCont)
            {
            }
            column(RequiredCont; RequiredCont)
            {
            }
            column(Variance; Variance)
            {
            }
            column(LastContDate; LastContDate)
            {
            }
            column(MonthsinDefault; MonthsinDefault)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SavingsLedgerEntry.Reset;
                SavingsLedgerEntry.SetRange("Customer No.", "Savings Accounts"."No.");
                SavingsLedgerEntry.SetRange(Reversed, false);
                SavingsLedgerEntry.SetRange("Member No.", "Savings Accounts"."Member No.");
                if SavingsLedgerEntry.FindLast then begin
                    ActualCont := SavingsLedgerEntry."Credit Amount (LCY)";
                    LastContDate := SavingsLedgerEntry."Posting Date";
                end;
                ProductFactory.Reset;
                ProductFactory.SetRange("Product ID", "Savings Accounts"."Product Type");
                if ProductFactory.Find('-') then begin
                    RequiredCont := ProductFactory."Minimum Contribution";
                end;
                Variance := ActualCont - RequiredCont;
                if Variance > 0 then
                    Variance := 0
                else
                    Variance := ActualCont - RequiredCont;
            end;
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

    var
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        ActualCont: Decimal;
        RequiredCont: Decimal;
        Variance: Decimal;
        ProductFactory: Record "Product Factory";
        LastContDate: Date;
        MonthsinDefault: Integer;
}
