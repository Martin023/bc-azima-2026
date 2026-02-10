#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185830 "Cheque Confirmation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Cheque Confirmation.rdl';

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            RequestFilterFields = "No.", "Date Filter";
            column(ReportForNavId_1102755019; 1102755019)
            {
            }
            dataitem("Payments Header"; "Payments Header")
            {
                DataItemLink = "Paying Bank Account" = field("No.");
                RequestFilterFields = "No.";
                column(ReportForNavId_1102755005; 1102755005)
                {
                }
                column(Payee_PaymentsHeader; "Payments Header".Payee)
                {
                }
                column(CompanyInfoName; CompanyInfo.Name)
                {
                }
                column(CompanyInfoAdd; CompanyInfo.Address)
                {
                }
                column(CompanyInfoAdd2; CompanyInfo."Address 2")
                {
                }
                column(CompanyInfoPhone; CompanyInfo."Phone No.")
                {
                }
                column(CompanyInfoPicture; CompanyInfo.Picture)
                {
                }
                column(SNo; SNo)
                {
                }
                column(BankName; Bank.Name)
                {
                }
                column(BankAdd; Bank.Address)
                {
                }
                column(BankCity; Bank.City)
                {
                }
                column(PaymentReleaseDate_PaymentsHeader; "Payments Header"."Payment Release Date")
                {
                }
                column(PaymentNarration_PaymentsHeader; "Payments Header"."Payment Narration")
                {
                }
                column(TotalPaymentAmount_PaymentsHeader; "Payments Header"."Total Payment Amount")
                {
                }
                column(PayingBankAccount_PaymentsHeader; "Payments Header"."Paying Bank Account")
                {
                }
                column(BankName_PaymentsHeader; "Payments Header"."Bank Name")
                {
                }
                column(ChequeNo_PaymentsHeader; "Payments Header"."Cheque No.")
                {
                }
                column(Date_PaymentsHeader; "Payments Header".Date)
                {
                }
                column(No_PaymentsHeader; "Payments Header"."No.")
                {
                }
                column(TotalNetAmount_PaymentsHeader; "Payments Header"."Total Net Amount")
                {
                }
                column(TotalNetAmount; TotalNetAmount)
                {
                }
                column(NumberText1; NumberText[1])
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Bank.Get("Paying Bank Account");
                    "Payments Header".TestField("Payments Header"."Cheque No.");
                    SNo += 1;
                    "Payments Header".CalcFields("Total Net Amount");
                    TotalNetAmount += "Total Net Amount";

                    // CheckReport.InitTextVariable;
                    // CheckReport.FormatNoText(NumberText, TotalNetAmount, '');
                end;

                trigger OnPreDataItem()
                begin
                    "Payments Header".SetFilter("Payment Release Date", "Bank Account".GetFilter("Date Filter"));
                end;
            }

            trigger OnPreDataItem()
            begin
                if "Bank Account".GetFilter("Bank Account"."Date Filter") = '' then
                    Error('Specify a date filter');
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

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
        SNo := 0;
    end;

    var
        CompanyInfo: Record "Company Information";
        Bank: Record "Bank Account";
        SNo: Integer;
        PaymentsHeader: Record "Payments Header";
        TotalNetAmount: Decimal;
        NumberText: array[2] of Text[120];
    //CheckReport: Report Check;
}
