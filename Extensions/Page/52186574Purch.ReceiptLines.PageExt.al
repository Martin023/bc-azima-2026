#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186574 pageextension52186574 extends "Purch. Receipt Lines"
{
    layout
    {
        modify("Document No.")
        {
            ApplicationArea = Basic;
            HideValue = "Document No.HideValue";
        }
        modify("Buy-from Vendor No.")
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure")
        {
            ApplicationArea = Basic;
        }
        modify("Direct Unit Cost")
        {
            ApplicationArea = Basic;
        }
        modify("Unit Cost (LCY)")
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
        modify("Indirect Cost %")
        {
            ApplicationArea = Basic;
        }
        modify("Quantity Invoiced")
        {
            ApplicationArea = Basic;
        }
        modify("Order No.")
        {
            ApplicationArea = Basic;
        }
        modify("Order Line No.")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Unit Cost")
        {
            ApplicationArea = Basic;
        }
        modify("Prod. Order No.")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. per Unit of Measure")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Vendor No."(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Direct Unit Cost"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost (LCY)"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Indirect Cost %"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity Invoiced"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order No."(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order Line No."(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor Item No."(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prod. Order No."(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. per Unit of Measure"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 44)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Show Document")
        {
            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("Item &Tracking Lines")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Show Document"(Action 50)".


        //Unsupported feature: Property Deletion (Promoted) on ""Show Document"(Action 50)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Show Document"(Action 50)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Show Document"(Action 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 51)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 51)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 51)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Dimensions(Action 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item &Tracking Lines"(Action 6500)".


        //Unsupported feature: Property Deletion (Promoted) on ""Item &Tracking Lines"(Action 6500)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Item &Tracking Lines"(Action 6500)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Item &Tracking Lines"(Action 6500)".

    }
    var

        "Document No.HideValue": Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DocumentNoHideValue := FALSE;
    DocumentNoOnFormat;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Document No.HideValue" := FALSE;
    DocumentNoOnFormat;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Initialize(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "Initialize(PROCEDURE 1)".

    //procedure Initialize();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ItemChargeAssgntPurch := NewItemChargeAssgntPurch;
    UnitCost := NewUnitCost;
    OnAfterInitialize(ItemChargeAssgntPurch,UnitCost);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ItemChargeAssgntPurch := NewItemChargeAssgntPurch;
    UnitCost := NewUnitCost;
    */
    //end;


    //Unsupported feature: Code Modification on "DocumentNoOnFormat(PROCEDURE 19001080)".

    //procedure DocumentNoOnFormat();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF NOT IsFirstDocLine THEN
      DocumentNoHideValue := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF NOT IsFirstDocLine THEN
      "Document No.HideValue" := TRUE;
    */
    //end;

    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
