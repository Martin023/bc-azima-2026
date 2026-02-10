#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185809 "Vendor Payment Advice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Vendor Payment Advice.rdl';
    Caption = 'Vendor Payment Advice';

    dataset
    {
        dataitem("Payments Header"; "Payments Header")
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(No_PaymentsHeader; "Payments Header"."No.")
            {
            }
            column(Date_PaymentsHeader; "Payments Header".Date)
            {
            }
            column(CurrencyCode_PaymentsHeader; "Payments Header"."Currency Code")
            {
            }
            column(Payee_PaymentsHeader; "Payments Header".Payee)
            {
            }
            column(PayingBankAccount_PaymentsHeader; "Payments Header"."Paying Bank Account")
            {
            }
            column(ChequeNo_PaymentsHeader; "Payments Header"."Cheque No.")
            {
            }
            // column(CompanyInfo_Name; CompanyInfo.Name)
            // {
            // }
            // column(CompanyInfo_Add; CompanyInfo.Address)
            // {
            // }
            // column(CompanyInfo_Picture; CompanyInfo.Picture)
            // {
            // }
            // column(NumberText; NumberText[1])
            // {
            // }
            // column(BankName_PaymentsHeader; "Payments Header"."Bank Name")
            // {
            // }
            dataitem("Payment Line"; "Payment Line")
            {
                DataItemLink = No = field("No.");
                column(ReportForNavId_2; 2)
                {
                }
                column(NetAmountLCY_PaymentLine; "Payment Line"."NetAmount LCY")
                {
                }
                column(NetAmount_PaymentLine; "Payment Line"."Net Amount")
                {
                }
                column(Amount_PaymentLine; "Payment Line".Amount)
                {
                }
                column(AccountName_PaymentLine; "Payment Line"."Account Name")
                {
                }
                column(AccountNo_PaymentLine; "Payment Line"."Account No.")
                {
                }
                column(AppliestoID_PaymentLine; "Payment Line"."Applies-to ID")
                {
                }
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Applies-to ID" = field("No.");
                column(ReportForNavId_1102755000; 1102755000)
                {
                }
                column(LPONo; LPONo)
                {
                }
                column(DocumentNo_VendorLedgerEntry; "Vendor Ledger Entry"."Document No.")
                {
                }
                column(Amount_VendorLedgerEntry; "Vendor Ledger Entry".Amount)
                {
                }
                column(OriginalAmtLCY_VendorLedgerEntry; "Vendor Ledger Entry"."Original Amt. (LCY)")
                {
                }
                column(RemainingAmount_VendorLedgerEntry; "Vendor Ledger Entry"."Remaining Amount")
                {
                }
                column(VendorName; VendorName)
                {
                }
                column(VendorAddress; VendorAddress)
                {
                }
                column(VendorPhone; VendorPhone)
                {
                }
                column(VendorNo_VendorLedgerEntry; "Vendor Ledger Entry"."Vendor No.")
                {
                }
                column(AmounttoApply_VendorLedgerEntry; "Vendor Ledger Entry"."Amount to Apply")
                {
                }
                column(Sno; SNo)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //VendLedger.RESET;
                    //VendLedger.SETRANGE("Applies-to ID",No);
                    //IF VendLedger.FINDFIRST THEN
                    if PurchInv.Get("Vendor Ledger Entry"."Document No.") then begin
                        PurchInv.CalcFields("Amount Including VAT");
                        InvoiceAmount := PurchInv."Amount Including VAT";
                        VendorInvoiceNo := PurchInv."Vendor Invoice No.";
                        LPONo := PurchInv."Order No.";

                    end;

                    if Vendor.Get("Vendor Ledger Entry"."Vendor No.") then begin
                        VendorName := Vendor.Name;
                        VendorAddress := Vendor.Address;
                        VendorPhone := Vendor."Phone No.";
                    end;

                    "Vendor Ledger Entry"."Original Amt. (LCY)" := -1 * "Vendor Ledger Entry"."Original Amt. (LCY)";
                    "Vendor Ledger Entry"."Amount to Apply" := -1 * "Vendor Ledger Entry"."Amount to Apply";
                    SNo += 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //Amount into words
                "Payments Header".CalcFields("Total Net Amount");
                // CheckReport.InitTextVariable;
                // CheckReport.FormatNoText(NumberText, "Total Net Amount", '');
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
    end;

    var
        Vendor: Record Vendor;
        VendorName: Text;
        VendorAddress: Text;
        VendorPhone: Code[30];
        CompanyInfo: Record "Company Information";
        NumberText: array[2] of Text[120];
        //CheckReport: Report Check;
        PurchInv: Record "Purch. Inv. Header";
        InvoiceAmount: Decimal;
        VendorInvoiceNo: Code[20];
        LPONo: Code[20];
        VendLedger: Record "Vendor Ledger Entry";
        SNo: Integer;
}
