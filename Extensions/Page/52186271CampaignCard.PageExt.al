#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186271 pageextension52186271 extends "Campaign Card"
{
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
        modify("Salesperson Code")
        {
            ApplicationArea = Basic;
        }
        modify("Last Date Modified")
        {
            ApplicationArea = Basic;
        }
        modify(Activated)
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Status Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Date"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ending Date"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Date Modified"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Activated(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 1 Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 2 Code"(Control 18)".


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

            //Unsupported feature: Property Modification (PromotedCategory) on "Statistics(Action 36)".

        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("T&asks")
        {
            Caption = 'T&o-dos';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""T&asks"(Action 38)".

        }
        modify("S&egments")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""S&egments"(Action 39)".

        }
        // modify("Oppo&rtunities")
        // {

        //     //Unsupported feature: Property Modification (Level) on ""Oppo&rtunities"(Action 40)".

        //     Caption = 'List';
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (Name) on ""Oppo&rtunities"(Action 40)".

        // }
        modify("Sales &Prices")
        {
            ApplicationArea = Basic;
        }
        modify("Sales &Line Discounts")
        {
            ApplicationArea = Basic;
        }
        modify(ActivateSalesPricesLineDisc)
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

            //Unsupported feature: Property Insertion (Promoted) on ""Campaign Details"(Action 1904094006)".


            //Unsupported feature: Property Insertion (PromotedCategory) on ""Campaign Details"(Action 1904094006)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""E&ntries"(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 35)".


        //Unsupported feature: Property Deletion (Promoted) on ""Co&mments"(Action 35)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Co&mments"(Action 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 36)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Statistics(Action 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 37)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 37)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Dimensions(Action 37)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""T&asks"(Action 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""S&egments"(Action 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Oppo&rtunities"(Action 40)".


        //Unsupported feature: Property Deletion (Promoted) on ""Oppo&rtunities"(Action 40)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Oppo&rtunities"(Action 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales &Prices"(Action 27)".


        //Unsupported feature: Property Deletion (Promoted) on ""Sales &Prices"(Action 27)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Sales &Prices"(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales &Line Discounts"(Action 28)".


        //Unsupported feature: Property Deletion (Promoted) on ""Sales &Line Discounts"(Action 28)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Sales &Line Discounts"(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ActivateSalesPricesLineDisc(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Deactivate Sales Prices/Line Discounts"(Action 23)".


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

    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
