#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185545 pageextension52185545 extends "Standard Sales Code Subform"
{
    layout
    {
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        // modify("No.")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        // modify(Description)
        // {
        //     ApplicationArea = Basic;
        // }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify("Amount Excl. VAT")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 1 Code"(Control 14)".

        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 2 Code"(Control 16)".

        }
        modify("ShortcutDimCode[3]")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""ShortcutDimCode[3]"(Control 300)".

        }
        modify("ShortcutDimCode[4]")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""ShortcutDimCode[4]"(Control 302)".

        }
        modify("ShortcutDimCode[5]")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""ShortcutDimCode[5]"(Control 304)".

        }
        modify("ShortcutDimCode[6]")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""ShortcutDimCode[6]"(Control 306)".

        }
        modify("ShortcutDimCode[7]")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""ShortcutDimCode[7]"(Control 308)".

        }
        modify("ShortcutDimCode[8]")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""ShortcutDimCode[8]"(Control 310)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 2)".

        modify(FilteredTypeField)
        {
            Visible = false;
        }
        modify("No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 18)".

        modify(Description)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount Excl. VAT"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 16)".

    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1900206304)".


        //Unsupported feature: Property Deletion (Scope) on "Dimensions(Action 1900206304)".

    }

    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ShowShortcutDimCode(ShortcutDimCode);
    UpdateTypeText;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ShowShortcutDimCode(ShortcutDimCode);
    */
    //end;


    //Unsupported feature: Code Modification on "OnNewRecord".

    //trigger OnNewRecord(BelowxRec: Boolean)
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF ApplicationAreaMgmtFacade.IsAdvancedEnabled THEN
      Type := xRec.Type;

    IF ApplicationAreaMgmtFacade.IsFoundationEnabled THEN
      Type := Type::Item;
    UpdateTypeText;

    CLEAR(ShortcutDimCode);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    Type := xRec.Type;
    CLEAR(ShortcutDimCode);
    */
    //end;
}
