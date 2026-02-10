#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186636 pageextension52186636 extends "Service Invoice Subform"
{
    layout
    {
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
        modify(Nonstock)
        {
            ApplicationArea = Basic;
        }
        modify("VAT Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Return Reason Code")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
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
        modify("Unit of Measure")
        {
            ApplicationArea = Basic;
        }
        modify("Unit Cost (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Unit Price")
        {
            ApplicationArea = Basic;
        }
        modify("Line Discount %")
        {
            ApplicationArea = Basic;
        }
        modify("Line Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Line Discount Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Invoice Disc.")
        {
            ApplicationArea = Basic;
        }
        modify("Inv. Discount Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Serv. Price Adjmt. Gr. Code")
        {
            ApplicationArea = Basic;
        }
        modify("Contract No.")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Appl.-to Service Entry")
        {
            ApplicationArea = Basic;
        }
        modify("Work Type Code")
        {
            ApplicationArea = Basic;
        }
        modify("Appl.-to Item Entry")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 1 Code"(Control 20)".

        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 2 Code"(Control 22)".

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

        //Unsupported feature: Code Modification on "Type(Control 2).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        NoOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TypeOnAfterValidate;
        NoOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Nonstock(Control 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Prod. Posting Group"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Return Reason Code"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost (LCY)"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Price"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount %"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Amount"(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount Amount"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Invoice Disc."(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inv. Discount Amount"(Control 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serv. Price Adjmt. Gr. Code"(Control 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract No."(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item No."(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-to Service Entry"(Control 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Type Code"(Control 102)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-to Item Entry"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 22)".

        moveafter("Unit Price"; "Line Amount")
    }
    actions
    {
        modify("Get &Price")
        {
            ApplicationArea = Basic;
        }
        modify("Get Li&ne Discount")
        {
            ApplicationArea = Basic;
        }
        modify("Insert &Ext. Texts")
        {
            ApplicationArea = Basic;
        }
        modify(GetShipmentLines)
        {
            ApplicationArea = Basic;
        }
        modify("Event")
        {
            ApplicationArea = Basic;
        }
        modify(Period)
        {
            ApplicationArea = Basic;
        }
        modify(Variant)
        {
            ApplicationArea = Basic;
        }
        modify(Location)
        {
            ApplicationArea = Basic;
        }
        modify("BOM Level")
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Get &Price"(Action 1903079504)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Get Li&ne Discount"(Action 1907415004)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Insert &Ext. Texts"(Action 1900206204)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GetShipmentLines(Action 1900545004)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Event(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Period(Action 1900639404)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Variant(Action 1904974904)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Location(Action 1904945204)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BOM Level"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1904522204)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item &Tracking Lines"(Action 1905987604)".

    }

    var

        IPItemEnable: Boolean;

        IPItemButtonEnable: Boolean;

        IPItemCommentPBEnable: Boolean;

        IPAvailabilityEnable: Boolean;

        IPAvailabilityTextboxEnable: Boolean;

        IPSubstitEnable: Boolean;

        IPSubstitTextboxEnable: Boolean;

        IPSalesPriceEnable: Boolean;

        IPSalesPriceTextboxEnable: Boolean;

        IPSalesLineDiscEnable: Boolean;

        IPSalesLineDiscTextboxEnable: Boolean;

    //Unsupported feature: Property Deletion (Attributes) on "ApproveCalcInvDisc(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "GetShipment(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "InsertExtendedText(PROCEDURE 7)".

    //procedure InsertExtendedText();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeInsertExtendedText(Rec);
    IF TransferExtendedText.ServCheckIfAnyExtText(Rec,Unconditionally) THEN BEGIN
      CurrPage.SAVERECORD;
      TransferExtendedText.InsertServExtText(Rec);
    END;
    IF TransferExtendedText.MakeUpdate THEN
      UpdateForm(TRUE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #2..7
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "UpdateForm(PROCEDURE 12)".



    //Unsupported feature: Code Modification on "NoOnAfterValidate(PROCEDURE 19066594)".

    //procedure NoOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InsertExtendedText(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    InsertExtendedText(FALSE);
    InfopaneEnable((Type = Type::Item) AND ("No." <> ''));
    */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: Value) (ParameterCollection) on "InfopaneEnable(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Name) on "SetDimensionsVisibility(PROCEDURE 5)".



    //Unsupported feature: Code Modification on "SetDimensionsVisibility(PROCEDURE 5)".

    //procedure SetDimensionsVisibility();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DimVisible1 := FALSE;
    DimVisible2 := FALSE;
    DimVisible3 := FALSE;
    DimVisible4 := FALSE;
    DimVisible5 := FALSE;
    DimVisible6 := FALSE;
    DimVisible7 := FALSE;
    DimVisible8 := FALSE;

    DimMgt.UseShortcutDims(
      DimVisible1,DimVisible2,DimVisible3,DimVisible4,DimVisible5,DimVisible6,DimVisible7,DimVisible8);

    CLEAR(DimMgt);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IPItemEnable := Value;
    IPItemButtonEnable := Value;
    IPItemCommentPBEnable := Value;
    IPAvailabilityEnable := Value;
    IPAvailabilityTextboxEnable := Value;
    IPSubstitEnable := Value;
    IPSubstitTextboxEnable := Value;
    IPSalesPriceEnable := Value;
    IPSalesPriceTextboxEnable := Value;
    IPSalesLineDiscEnable := Value;
    IPSalesLineDiscTextboxEnable := Value;
    */
    //end;

    local procedure CalcInvDisc()
    begin
        Codeunit.Run(Codeunit::"Service-Calc. Discount", Rec);
    end;

    local procedure TypeOnAfterValidate()
    begin
        // InfopaneEnable((Rec.Type = Rec.Type::Item) and (Rec."No." <> ''));
    end;

    //Unsupported feature: Deletion (VariableCollection) on "SetDimensionsVisibility(PROCEDURE 5).DimMgt(Variable 1000)".

}
