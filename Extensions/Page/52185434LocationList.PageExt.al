#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185434 pageextension52185434 extends "Location List" 
{
    Caption = 'Location List';
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("&Resource Locations")
        {
            ApplicationArea = Basic;
        }
        modify("&Zones")
        {
            ApplicationArea = Basic;
        }
        modify("&Bins")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer Order")
        {
            ApplicationArea = Basic;
        }
        modify("Create Warehouse location")
        {
            ApplicationArea = Basic;
        }
        modify("Inventory - Inbound Transfer")
        {
            ApplicationArea = Basic;
        }
        modify(Action1907283206)
        {
            ApplicationArea = Basic;
        }
        modify("Transfer Shipment")
        {
            ApplicationArea = Basic;
        }
        modify("Transfer Receipt")
        {
            ApplicationArea = Basic;
        }
        modify("Items with Negative Inventory")
        {
            Caption = 'Check on Negative Inventory';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Promoted) on ""Items with Negative Inventory"(Action 1907335806)".


            //Unsupported feature: Property Modification (Name) on ""Items with Negative Inventory"(Action 1907335806)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Resource Locations"(Action 10)".


        //Unsupported feature: Property Deletion (Promoted) on ""&Resource Locations"(Action 10)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""&Resource Locations"(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Zones"(Action 7300)".


        //Unsupported feature: Property Deletion (Promoted) on ""&Zones"(Action 7300)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""&Zones"(Action 7300)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Bins"(Action 11)".


        //Unsupported feature: Property Deletion (Promoted) on ""&Bins"(Action 11)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""&Bins"(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer Order"(Action 1907283205)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Warehouse location"(Action 1900888104)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inventory - Inbound Transfer"(Action 1901320106)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Action1907283206(Action 1907283206)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer Shipment"(Action 1904855606)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Transfer Receipt"(Action 1901432206)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Items with Negative Inventory"(Action 1907335806)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Items with Negative Inventory"(Action 1907335806)".

        addafter("&Resource Locations")
        {
            separator(Action7301)
            {
            }
        }
    }

    //Unsupported feature: Property Deletion (Attributes) on "GetSelectionFilter(PROCEDURE 3)".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
