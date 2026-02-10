#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185989 "Account Transfer Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Account Transfer Report.rdl';

    dataset
    {
        dataitem("Account Transfer Source"; "Account Transfer Source")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(SourceNo; SourceNo)
            {
            }
            column(SourceName; SourceName)
            {
            }
            column(Sourceamnt; SourceAmnt)
            {
            }
            column(No; "Account Transfer Source"."No.")
            {
            }
            column(SourceAccountNo; "Account Transfer Source"."Source Account No.")
            {
            }
            column(SourceAccountNam; "Account Transfer Source"."Source Account Name")
            {
            }
            column(SourceTransactionType; "Account Transfer Source"."Source Transaction Type")
            {
            }
            column(SourceLoanNo; "Account Transfer Source"."Source Loan No.")
            {
            }
            column(SourceAmount; "Account Transfer Source"."Source Amount")
            {
            }
            column(SourceAccountType; "Account Transfer Source"."Source Account Type")
            {
            }
            column(ExternalDocumentNo; "Account Transfer Source"."External Document No.")
            {
            }
            column(EntryNo; "Account Transfer Source"."Entry No.")
            {
            }
            column(ProductName; "Account Transfer Source"."Product Name")
            {
            }
            column(Balance; "Account Transfer Source".Balance)
            {
            }
            column(AvailableBalance; "Account Transfer Source"."Available Balance")
            {
            }
            column(ProductCode; "Account Transfer Source"."Product Code")
            {
            }
            column(TransferType; "Account Transfer Source"."Transfer Type")
            {
            }
            column(MemberNo; "Account Transfer Source"."Member No.")
            {
            }
            dataitem("Account Transfer Destination"; "Account Transfer Destination")
            {
                column(ReportForNavId_17; 17)
                {
                }
                column(No1; "Account Transfer Destination"."No.")
                {
                }
                column(DestinationAccountType; "Account Transfer Destination"."Destination Account Type")
                {
                }
                column(DestinationAccountNo; "Account Transfer Destination"."Destination Account No.")
                {
                }
                column(DestinationLoanNo; "Account Transfer Destination"."Destination Loan No.")
                {
                }
                column(DestinationTransactionType; "Account Transfer Destination"."Destination Transaction Type")
                {
                }
                column(DestinationAccountName; "Account Transfer Destination"."Destination Account Name")
                {
                }
                column(DestinationAmount; "Account Transfer Destination"."Destination Amount")
                {
                }
                column(ExternalDocumentNo2; "Account Transfer Destination"."External Document No.")
                {
                }
                column(EntryNo2; "Account Transfer Destination"."Entry No.")
                {
                }
                column(ProductNam; "Account Transfer Destination"."Product Name")
                {
                }
                column(ProductCode2; "Account Transfer Destination"."Product Code")
                {
                }
                column(TransferType2; "Account Transfer Destination"."Transfer Type")
                {
                }
                column(MemberNo2; "Account Transfer Destination"."Member No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    AccountTransferSource.Reset;
                    AccountTransferSource.SetRange("No.", "Account Transfer Destination"."No.");
                    if AccountTransferSource.Find('-') then
                        SourceNo := AccountTransferSource."Source Account No.";
                    SourceName := AccountTransferSource."Source Account Name";
                    SourceAmnt := AccountTransferSource."Source Amount";
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

    var
        AccountTransferSource: Record "Account Transfer Source";
        SourceNo: Code[20];
        SourceName: Text[100];
        SourceAmnt: Decimal;
}
