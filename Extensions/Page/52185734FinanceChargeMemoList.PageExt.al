#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185734 pageextension52185734 extends "Finance Charge Memo List" 
{
    Caption = 'Finance Charge Memo List';
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Interest Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Post Code")
        {
            ApplicationArea = Basic;
        }
        modify(City)
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Assigned User ID")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Interest Amount"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post Code"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on "City(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assigned User ID"(Control 31)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify("C&ustomer")
        {
            ApplicationArea = Basic;
        }
        modify(Statistics)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Statistics(Action 9)".

        }
        modify("Create Finance Charge Memos")
        {
            ApplicationArea = Basic;
        }
        modify("Suggest Fin. Charge Memo Lines")
        {
            ApplicationArea = Basic;
        }
        modify("Update Finance Charge Text")
        {
            ApplicationArea = Basic;
        }
        modify("Test Report")
        {
            ApplicationArea = Basic;
        }
        modify(Issue)
        {
            ApplicationArea = Basic;
        }
        modify("Finance Charge Memo Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Customer - Balance to Date")
        {
            ApplicationArea = Basic;
        }
        modify("Customer - Detail Trial Bal.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 13)".


        //Unsupported feature: Property Deletion (Promoted) on ""Co&mments"(Action 13)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Co&mments"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""C&ustomer"(Action 18)".


        //Unsupported feature: Property Deletion (Promoted) on ""C&ustomer"(Action 18)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""C&ustomer"(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 9)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Statistics(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Finance Charge Memos"(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Suggest Fin. Charge Memo Lines"(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Update Finance Charge Text"(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Test Report"(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Issue(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Finance Charge Memo Nos."(Action 1902355906)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer - Balance to Date"(Action 1902299006)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer - Detail Trial Bal."(Action 1906871306)".

        addafter("Finance Charge Memo Nos.")
        {
            action("Finance Charge Memo Test")
            {
                ApplicationArea = Basic;
                Caption = 'Finance Charge Memo Test';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Finance Charge Memo - Test";
            }
        }
    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
