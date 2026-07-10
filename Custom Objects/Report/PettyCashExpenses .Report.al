#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006
Report 52185508 "Petty Cash Expenses Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/PettyCashExpensesReport.rdl';
    Caption = 'Petty Cash Expenses Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = Basic, Suite;

    dataset
    {
        dataitem(PaymentsHeader; "Payments Header")
        {
            // We only want Posted Petty Cash transactions
            DataItemTableView = sorting("No.") where("Payment Type" = const("Petty Cash"), Posted = const(true));
            RequestFilterFields = "No.", Date, "Paying Bank Account", Cashier;

            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Address; CompanyAddress) { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(PrintingDate; PrintingDate) { }
            column(PrintingTime; PrintingTime) { }
            column(PrintedBy; PrintedBy) { }
            
            column(No_PaymentsHeader; "No.") { }
            column(Date_PaymentsHeader; Format(Date, 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(Payee_PaymentsHeader; Payee) { }
            column(PaymentNarration_PaymentsHeader; "Payment Narration") { }
            column(Cashier_PaymentsHeader; Cashier) { }
            column(PayingBankAccount_PaymentsHeader; "Paying Bank Account") { }
            column(TotalNetAmount_PaymentsHeader; "Total Net Amount") { }

            dataitem(PaymentLine; "Payment Line")
            {
                DataItemLink = No = field("No.");
                
                column(AccountType_PaymentLine; Format("Account Type")) { }
                column(AccountNo_PaymentLine; "Account No.") { }
                column(AccountName_PaymentLine; "Account Name") { }
                column(NetAmount_PaymentLine; "Net Amount") { }
            }
        }
    }

    requestpage
    {
        SaveValues = true;
        layout { }
        actions { }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        CompanyAddress := CompanyInfo.Address + ' - ' + CompanyInfo.City;
        PrintingDate := Format(Today, 0, '<Day,2>/<Month,2>/<Year4>');
        PrintingTime := Format(Time);
        PrintedBy := UserId;
    end;

    var
        CompanyInfo: Record "Company Information";
        CompanyAddress: Text;
        PrintingDate: Text;
        PrintingTime: Text;
        PrintedBy: Text;
}