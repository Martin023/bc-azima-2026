namespace KenpipeCBS.KenpipeCBS;
using Microsoft.Bank.Check;

report 52185460 "Inter Bank Cheque"
{
    ApplicationArea = All;
    Caption = 'Inter Bank Cheque';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-azima-2026/Layout/Inter Bank Cheque Print.rdl';
    dataset
    {
        dataitem(InterBankTransfers; "InterBank Transfers")
        {
            column(FromNo; "From No")
            {
            }
            column(PayingBankAccountName; "Paying  Bank Account Name")
            {
            }
            column(PayingAccount; "Paying Account")
            {
            }
            column(Posted; Posted)
            {
            }
            column(ReceivingBankAccountName; "Receiving Bank Account Name")
            {
            }
            column(ReceivingAccount; "Receiving Account")
            {
            }
            column(ReceivedFrom; "Received From")
            {
            }
            column(ReceivingDepartmentName; "Receiving Department Name")
            {
            }
            column(ReceivingDepotCode; "Receiving Depot Code")
            {
            }
            column(ReceivingDepotName; "Receiving Depot Name")
            {
            }
            column(RequestAmtLCY; "Request Amt LCY")
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(ShortcutDimension3Code; "Shortcut Dimension 3 Code")
            {
            }
            column(Status; Status)
            {
            }
            column(Amount; Amount)
            {
            }
            column(NumberText_1__Control1102755016; NumberText[1])
            {
            }
            column(Date_Posted; "Date Posted")
            {

            }
            column(Date; Date)
            {

            }

            trigger OnAfterGetRecord()
            begin
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, (ROUND(Amount, 0.01, '=')), '');
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        CheckReport: Report Check;
        NumberText: array[2] of Text;
}
