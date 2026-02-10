#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185788 "Daily Cashier Summary 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Daily Cashier Summary 2.rdl';

    dataset
    {
        dataitem("Bank Account"; "Bank Account")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(OpBal; OpBal)
            {
            }
            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                column(ReportForNavId_1102755000; 1102755000)
                {
                }
            }
            dataitem(Receipts; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("No."), "Posting Date" = field("Date Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter");
                DataItemTableView = where("Document Type" = const(" "), Amount = filter(> 0));
                column(ReportForNavId_1102755001; 1102755001)
                {
                }
                column(EntryNo_Receipts; Receipts."Entry No.")
                {
                }
                column(PostingDate_Receipts; Receipts."Posting Date")
                {
                }
                column(DocumentNo_Receipts; Receipts."Document No.")
                {
                }
                column(Description_Receipts; Receipts.Description)
                {
                }
                column(BalAccountNo_Receipts; Receipts."Bal. Account No.")
                {
                }
                column(Amount_Receipts; Receipts.Amount)
                {
                }
                column(UserID_Receipts; Receipts."User ID")
                {
                }
            }
            dataitem(Other_Payments; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("No."), "Posting Date" = field("Date Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter");
                DataItemTableView = where("Document Type" = filter(<> Invoice), Amount = filter(< 0));
                column(ReportForNavId_1102755002; 1102755002)
                {
                }
                column(EntryNo_OtherPayments; Other_Payments."Entry No.")
                {
                }
                column(PostingDate_OtherPayments; Other_Payments."Posting Date")
                {
                }
                column(DocumentNo_OtherPayments; Other_Payments."Document No.")
                {
                }
                column(Description_OtherPayments; Other_Payments.Description)
                {
                }
                column(UserID_OtherPayments; Other_Payments."User ID")
                {
                }
                column(BalAccountNo_OtherPayments; Other_Payments."Bal. Account No.")
                {
                }
                column(Amount_OtherPayments; Other_Payments.Amount)
                {
                }
            }
            dataitem(IOU_Payments; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("No."), "Posting Date" = field("Date Filter"), "Global Dimension 2 Code" = field("Global Dimension 2 Filter"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter");
                DataItemTableView = where("Document Type" = const(Invoice), Amount = filter(< 0));
                column(ReportForNavId_1102755003; 1102755003)
                {
                }
                column(EntryNo_IOUPayments; IOU_Payments."Entry No.")
                {
                }
                column(Amount_IOUPayments; IOU_Payments.Amount)
                {
                }
                column(PostingDate_IOUPayments; IOU_Payments."Posting Date")
                {
                }
                column(DocumentNo_IOUPayments; IOU_Payments."Document No.")
                {
                }
                column(Description_IOUPayments; IOU_Payments.Description)
                {
                }
                column(UserID_IOUPayments; IOU_Payments."User ID")
                {
                }
                column(BalAccountNo_IOUPayments; IOU_Payments."Bal. Account No.")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                MoneyInBal := 0;
                MoneyOutBal := 0;
                MoneyOutBal2 := 0;

                //get the opening balance
                OpBal := 0;
                MinDate := "Bank Account".GetRangeMin("Bank Account"."Date Filter");
                if MinDate <> 0D then begin
                    BankAcc.Reset;
                    BankAcc.Get("Bank Account"."No.");
                    BankAcc.SetFilter(BankAcc."Date Filter", '..' + Format(MinDate - 1));
                    BankAcc.SetFilter(BankAcc."Global Dimension 1 Filter", "Bank Account".GetFilter("Bank Account"."Global Dimension 1 Filter"));
                    BankAcc.SetFilter(BankAcc."Global Dimension 2 Filter", "Bank Account".GetFilter("Bank Account"."Global Dimension 2 Filter"));
                    BankAcc.CalcFields(BankAcc."Net Change");
                    OpBal := BankAcc."Net Change";
                end;
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
        MoneyInBal: Decimal;
        MoneyOutBal: Decimal;
        MinDate: Date;
        OpBal: Decimal;
        BankAcc: Record "Bank Account";
        CompanyInfo: Record "Company Information";
        MoneyOutBal2: Decimal;
}
