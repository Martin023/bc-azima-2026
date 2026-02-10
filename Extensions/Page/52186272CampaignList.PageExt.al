#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186272 pageextension52186272 extends "Campaign List" 
{
    Caption = 'Campaign List';
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Salesperson Code")
        {
            ApplicationArea = Basic;
        }
        modify("Status Code")
        {
            ApplicationArea = Basic;
        }
        modify("Starting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Ending Date")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Status Code"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Date"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ending Date"(Control 8)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify(Statistics)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Statistics(Action 26)".

        }
        modify("Dimensions-Single")
        {
            ApplicationArea = Basic;
        }
        modify("Dimensions-&Multiple")
        {
            ApplicationArea = Basic;
        }
        modify("T&asks")
        {
            Caption = 'T&o-dos';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""T&asks"(Action 28)".

        }
        modify("S&egments")
        {
            ApplicationArea = Basic;
        }
        // modify("Oppo&rtunities")
        // {

        //     //Unsupported feature: Property Modification (Level) on ""Oppo&rtunities"(Action 30)".

        //     Caption = 'List';
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (Name) on ""Oppo&rtunities"(Action 30)".

        // }
        modify("Sales &Prices")
        {
            ApplicationArea = Basic;
        }
        modify("Sales &Line Discounts")
        {
            ApplicationArea = Basic;
        }
        modify("&Activate Sales Prices/Line Discounts")
        {
            ApplicationArea = Basic;
        }
        modify("&Deactivate Sales Prices/Line Discounts")
        {
            ApplicationArea = Basic;
        }
        modify("Campaign Details")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""E&ntries"(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 25)".


        //Unsupported feature: Property Deletion (Promoted) on ""Co&mments"(Action 25)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Co&mments"(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 26)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Statistics(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimensions-Single"(Action 27)".


        //Unsupported feature: Property Deletion (Promoted) on ""Dimensions-Single"(Action 27)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Dimensions-Single"(Action 27)".


        //Unsupported feature: Code Modification on ""Dimensions-&Multiple"(Action 18).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(Campaign);
            DefaultDimMultiple.SetMultiRecord(Campaign,FIELDNO("No."));
            DefaultDimMultiple.RUNMODAL;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(Campaign);
            DefaultDimMultiple.SetMultiCampaign(Campaign);
            DefaultDimMultiple.RUNMODAL;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimensions-&Multiple"(Action 18)".


        //Unsupported feature: Property Deletion (Promoted) on ""Dimensions-&Multiple"(Action 18)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Dimensions-&Multiple"(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""T&asks"(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""S&egments"(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Oppo&rtunities"(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales &Prices"(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales &Line Discounts"(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Activate Sales Prices/Line Discounts"(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Deactivate Sales Prices/Line Discounts"(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign Details"(Action 1904094006)".

        addafter("S&egments")
        {
            // group("Oppo&rtunities")
            // {
            //     Caption = 'Oppo&rtunities';
            //     Image = OpportunityList;
            // }
        }
    }

    //Unsupported feature: Property Deletion (Attributes) on "GetSelectionFilter(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
