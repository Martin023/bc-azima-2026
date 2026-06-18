#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186451 pageextension52186451 extends "FA Ledger Entries"
{
    layout
    {
        modify("FA Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("FA No.")
        {
            ApplicationArea = Basic;
        }
        modify("Depreciation Book Code")
        {
            ApplicationArea = Basic;
        }
        modify("FA Posting Category")
        {
            ApplicationArea = Basic;
        }
        modify("FA Posting Type")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Global Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Global Dimension 2 Code")
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify("Reclassification Entry")
        {
            ApplicationArea = Basic;
        }
        modify("Index Entry")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Depreciation Days")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Account Type")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("User ID")
        {
            ApplicationArea = Basic;
        }
        modify("Source Code")
        {
            ApplicationArea = Basic;
        }
        modify("Reason Code")
        {
            ApplicationArea = Basic;
        }
        modify(Reversed)
        {
            ApplicationArea = Basic;
        }
        modify("Reversed by Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Reversed Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("G/L Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }



        modify("Dimension Set ID")
        {
            Visible = false;
        }
        movebefore(Amount; "Credit Amount")
        movebefore(Amount; "Debit Amount")
        moveafter(Amount; RunningBalance)

        modify("Credit Amount")
        {
            Visible = true;
        }
        modify("Debit Amount")
        {
            Visible = true;
        }

        modify(RunningBalance)
        {
            Visible = true;
        }

    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify(CancelEntries)
        {
            ApplicationArea = Basic;
        }
        modify(ReverseTransaction)
        {
            ApplicationArea = Basic;
        }
        modify("&Navigate")
        {
            ApplicationArea = Basic;
        }

        modify(SetDimensionFilter)
        {
            Visible = false;
        }

    }

}
