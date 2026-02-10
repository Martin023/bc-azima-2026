#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186866 pageextension52186866 extends "Whse. Phys. Invt. Journal"
{
    Caption = 'Whse. Phys. Invt. Journal';
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
        modify("Serial No.")
        {
            ApplicationArea = Basic;
            Editable = "Serial No.Editable";
        }
        modify("Lot No.")
        {
            ApplicationArea = Basic;
            Editable = "Lot No.Editable";
        }
        modify("Zone Code")
        {
            ApplicationArea = Basic;
        }
        modify("Bin Code")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. (Calculated) (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. (Phys. Inventory) (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. (Calculated)")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. (Phys. Inventory)")
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
        modify("Phys Invt Counting Period Type")
        {
            ApplicationArea = Basic;
        }
        modify("Phys Invt Counting Period Code")
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


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serial No."(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Lot No."(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Zone Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. (Calculated) (Base)"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. (Phys. Inventory) (Base)"(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. (Calculated)"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. (Phys. Inventory)"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reason Code"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Phys Invt Counting Period Type"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Phys Invt Counting Period Code"(Control 19)".


        //Unsupported feature: Property Deletion (ShowCaption) on "ItemDescription(Control 23)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
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

            //Unsupported feature: Property Modification (Promoted) on ""Ledger E&ntries"(Action 31)".


            //Unsupported feature: Property Modification (PromotedCategory) on ""Ledger E&ntries"(Action 31)".

        }
        modify("Bin Contents")
        {
            ApplicationArea = Basic;
        }
        modify("Calculate &Inventory")
        {
            ApplicationArea = Basic;
        }
        modify("&Calculate Counting Period")
        {
            ApplicationArea = Basic;
        }
        modify("&Print")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""&Print"(Action 50)".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 30)".


        //Unsupported feature: Property Deletion (Promoted) on "Card(Action 30)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Card(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warehouse Entries"(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ledger E&ntries"(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Contents"(Action 44)".


        //Unsupported feature: Property Deletion (Promoted) on ""Bin Contents"(Action 44)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Bin Contents"(Action 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Calculate &Inventory"(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Calculate Counting Period"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Print"(Action 50)".


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

    var

        "Serial No.Editable": Boolean;

        "Lot No.Editable": Boolean;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    LotNoEditable := TRUE;
    SerialNoEditable := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Lot No.Editable" := TRUE;
    "Serial No.Editable" := TRUE;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetControls(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "SetControls(PROCEDURE 1)".

    //procedure SetControls();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SerialNoEditable := NOT "Phys. Inventory";
    LotNoEditable := NOT "Phys. Inventory";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Serial No.Editable" := NOT "Phys. Inventory";
    "Lot No.Editable" := NOT "Phys. Inventory";
    */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
