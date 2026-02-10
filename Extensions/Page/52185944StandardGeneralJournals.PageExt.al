#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185944 pageextension52185944 extends "Standard General Journals" 
{
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(ShowJournal)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on "ShowJournal(Action 12).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            StdGenJnl.SETRANGE("Journal Template Name","Journal Template Name");
            StdGenJnl.SETRANGE(Code,Code);

            PAGE.RUN(PAGE::"Standard General Journal",StdGenJnl);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            StdGenJnl.SETRANGE("Journal Template Name","Journal Template Name");
            StdGenJnl.SETRANGE(Code,Code);
            StdGenJnlForm.SETTABLEVIEW(StdGenJnl);
            StdGenJnlForm.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowJournal(Action 12)".

    }

    var
        StdGenJnlForm: Page "Standard General Journal";
}
