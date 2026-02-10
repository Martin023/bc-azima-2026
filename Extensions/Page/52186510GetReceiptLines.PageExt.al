#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186510 pageextension52186510 extends "Get Receipt Lines"
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
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
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
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure")
        {
            ApplicationArea = Basic;
        }
        modify("Appl.-to Item Entry")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Job No.")
        {
            ApplicationArea = Basic;
        }
        modify("Prod. Order No.")
        {
            ApplicationArea = Basic;
        }
        modify("Expected Receipt Date")
        {
            ApplicationArea = Basic;
        }
        modify("Quantity Invoiced")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. Rcd. Not Invoiced")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Vendor No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-to Item Entry"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job No."(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prod. Order No."(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expected Receipt Date"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity Invoiced"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Rcd. Not Invoiced"(Control 20)".


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
        modify("Item &Tracking Entries")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Show Document"(Action 46)".


        //Unsupported feature: Property Deletion (Promoted) on ""Show Document"(Action 46)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Show Document"(Action 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 47)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 47)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item &Tracking Entries"(Action 28)".


        //Unsupported feature: Property Deletion (Promoted) on ""Item &Tracking Entries"(Action 28)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Item &Tracking Entries"(Action 28)".

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

    //Unsupported feature: Property Deletion (Attributes) on "SetPurchHeader(PROCEDURE 1)".



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
