#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185668 pageextension52185668 extends "Bank Account Ledger Entries"
{
    Editable = true;


    layout
    {
        addafter(Open)
        {
            field("User ID."; Rec."User ID")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Document No.")
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = Basic;
                Visible = true;
            }
        }

        modify(Control1)
        {
            Editable = true;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Document Type")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Bank Account No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
            Editable = true;
        }
        modify("Global Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Global Dimension 2 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Our Contact Code")
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
            visible = false;
        }
        modify("Amount (LCY)")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Debit Amount")
        {
            ApplicationArea = Basic;
            Visible = true;

        }
        modify("Remaining Amount")
        {
            ApplicationArea = Basic;
            Visible = false;
        }
        modify("Bal. Account Type")
        {
            ApplicationArea = Basic;
        }
        modify("Bal. Account No.")
        {
            ApplicationArea = Basic;
        }
        modify(Open)
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
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }


        modify("Dimension Set ID")
        {
            Visible = false;
        }

        modify("Credit Amount")
        {
            ApplicationArea = Basic;
            Visible = true;
        }
        moveafter(Description; "Debit Amount")
        moveafter("Debit Amount"; "Credit Amount")
        moveafter(RunningBalance; "Global Dimension 1 Code")
        moveafter("Global Dimension 1 Code"; "Global Dimension 2 Code")
        //movebefore("Entry No."; "User ID")
        moveafter(Amount; "Amount (LCY)")
    }
    actions
    {
        modify("Check Ledger E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("Reverse Transaction")
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


    views
    {
        addfirst
        {
            view(AddFromVSC)
            {
                Caption = 'Add From Visual Studio Code';
                OrderBy = ascending("Posting Date");
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("Entry No.", "Posting Date");
        Rec.Ascending(true);
    end;

}

