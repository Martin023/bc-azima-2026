#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186864 pageextension52186864 extends "Whse. Item Journal" 
{
    Caption = 'Whse. Item Journal';
    layout
    {
        modify(CurrentJnlBatchName)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentLocationCode)
        {
            ApplicationArea = Basic;
        }
        modify("Registering Date")
        {
            ApplicationArea = Basic;
        }
        modify("Whse. Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Zone Code")
        {
            ApplicationArea = Basic;
        }
        modify("Bin Code")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify("Reason Code")
        {
            ApplicationArea = Basic;
        }
        modify(ItemDescription)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentJnlBatchName(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentLocationCode(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Registering Date"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Whse. Document No."(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item No."(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Zone Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reason Code"(Control 2)".


        //Unsupported feature: Property Deletion (ShowCaption) on "ItemDescription(Control 23)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Item &Tracking Lines")
        {
            ApplicationArea = Basic;
        }
        modify(Card)
        {
            ApplicationArea = Basic;
        }
        modify("Warehouse Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Ledger E&ntries")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Promoted) on ""Ledger E&ntries"(Action 41)".


            //Unsupported feature: Property Modification (PromotedCategory) on ""Ledger E&ntries"(Action 41)".

        }
        modify("Bin Contents")
        {
            ApplicationArea = Basic;
        }
        modify("Reservation Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Test Report")
        {
            ApplicationArea = Basic;
        }
        modify("&Register")
        {
            ApplicationArea = Basic;
        }
        modify("Register and &Print")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Item &Tracking Lines"(Action 16)".


        //Unsupported feature: Property Deletion (Promoted) on ""Item &Tracking Lines"(Action 16)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Item &Tracking Lines"(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 8)".


        //Unsupported feature: Property Deletion (Promoted) on "Card(Action 8)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Card(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warehouse Entries"(Action 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ledger E&ntries"(Action 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Contents"(Action 42)".


        //Unsupported feature: Property Deletion (Promoted) on ""Bin Contents"(Action 42)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Bin Contents"(Action 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reservation Entries"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Test Report"(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Register"(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Register and &Print"(Action 35)".

    }

    //Unsupported feature: Property Modification (Length) on "ItemDescription(Variable 1004)".

    //var
        //>>>> ORIGINAL VALUE:
        //ItemDescription : 100;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ItemDescription : 50;
        //Variable type has not been exported.

    local procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SaveRecord;
        // Rec.SetName(CurrentJnlBatchName,CurrentLocationCode,Rec);
        CurrPage.Update(false);
    end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
