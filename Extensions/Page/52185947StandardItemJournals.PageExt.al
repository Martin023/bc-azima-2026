#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185947 pageextension52185947 extends "Standard Item Journals" 
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
        modify("&Show Journal")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on ""&Show Journal"(Action 12).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            StdItemJnl.SETRANGE("Journal Template Name","Journal Template Name");
            StdItemJnl.SETRANGE(Code,Code);

            PAGE.RUN(PAGE::"Standard Item Journal",StdItemJnl);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            StdItemJnl.SETRANGE("Journal Template Name","Journal Template Name");
            StdItemJnl.SETRANGE(Code,Code);
            StdItemJnlForm.SETTABLEVIEW(StdItemJnl);
            StdItemJnlForm.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Show Journal"(Action 12)".

    }

    var
        StdItemJnlForm: Page "Standard Item Journal";
}
