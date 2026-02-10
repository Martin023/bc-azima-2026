#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185481 pageextension52185481 extends "Sales Quote Subform"
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
            ShowMandatory = TypeChosen;
        }
        // modify("Cross-Reference No.")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify("Substitution Available")
        {
            ApplicationArea = Basic;
        }
        modify(Nonstock)
        {
            ApplicationArea = Basic;
        }
        // modify("VAT Prod. Posting Group")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify(Description)
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
            ShowMandatory = TypeChosen;
        }
        modify("Qty. to Assemble to Order")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""Qty. to Assemble to Order"(Control 11)".

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
        modify(PriceExists)
        {
            ApplicationArea = Basic;
        }
        modify("Unit Price")
        {
            ApplicationArea = Basic;
            ShowMandatory = TypeChosen;
        }
        modify("Line Discount %")
        {
            ApplicationArea = Basic;
        }
        modify("Line Amount")
        {
            ApplicationArea = Basic;
        }
        modify(LineDiscExists)
        {
            ApplicationArea = Basic;
        }
        modify("Line Discount Amount")
        {
            ApplicationArea = Basic;
        }
        // modify("Allow Invoice Disc.")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Allow Item Charge Assignment")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. to Assign")
        {
            ApplicationArea = Basic;
            BlankZero = true;
        }
        modify("Qty. Assigned")
        {
            ApplicationArea = Basic;
        }
        modify("Shipping Agent Code")
        {

            //Unsupported feature: Property Modification (Level) on ""Shipping Agent Code"(Control 27)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Shipping Agent Code"(Control 27)".


            //Unsupported feature: Property Modification (Name) on ""Shipping Agent Code"(Control 27)".


            //Unsupported feature: Property Insertion (DrillDown) on ""Shipping Agent Code"(Control 27)".

            Enabled = RefreshMessageEnabled;
            Editable = false;
            ShowCaption = false;
        }
        modify("Work Type Code")
        {
            ApplicationArea = Basic;
        }
        modify("Blanket Order No.")
        {
            ApplicationArea = Basic;
        }
        modify("Blanket Order Line No.")
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
        modify(ShortcutDimCode3)
        {

            //Unsupported feature: Property Modification (Name) on "ShortcutDimCode3(Control 300)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on "ShortcutDimCode3(Control 300)".

        }
        modify(ShortcutDimCode4)
        {

            //Unsupported feature: Property Modification (Name) on "ShortcutDimCode4(Control 302)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on "ShortcutDimCode4(Control 302)".

        }
        modify(ShortcutDimCode5)
        {

            //Unsupported feature: Property Modification (Name) on "ShortcutDimCode5(Control 304)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on "ShortcutDimCode5(Control 304)".

        }
        modify(ShortcutDimCode6)
        {

            //Unsupported feature: Property Modification (Name) on "ShortcutDimCode6(Control 306)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on "ShortcutDimCode6(Control 306)".

        }
        modify(ShortcutDimCode7)
        {

            //Unsupported feature: Property Modification (Name) on "ShortcutDimCode7(Control 308)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on "ShortcutDimCode7(Control 308)".

        }
        modify(ShortcutDimCode8)
        {

            //Unsupported feature: Property Modification (Name) on "ShortcutDimCode8(Control 310)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on "ShortcutDimCode8(Control 310)".

        }
        modify("Invoice Discount Amount")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Invoice Discount Amount"(Control 47)".


            //Unsupported feature: Property Modification (AutoFormatExpr) on ""Invoice Discount Amount"(Control 47)".

            Style = Subordinate;
            StyleExpr = RefreshMessageEnabled;
        }
        // modify("Invoice Disc. Pct.")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (DecimalPlaces) on ""Invoice Disc. Pct."(Control 45)".


        //     //Unsupported feature: Property Modification (SourceExpr) on ""Invoice Disc. Pct."(Control 45)".

        //     Editable = false;

        //     //Unsupported feature: Property Insertion (Visible) on ""Invoice Disc. Pct."(Control 45)".

        //     Style = Subordinate;
        //     StyleExpr = RefreshMessageEnabled;
        // }
        modify("Total Amount Excl. VAT")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (AutoFormatExpr) on ""Total Amount Excl. VAT"(Control 33)".

            //CaptionClass = DocumentTotals.GetTotalExclVATCaption(SalesHeader."Currency Code");
            Style = Subordinate;
            StyleExpr = RefreshMessageEnabled;
        }
        modify("Total VAT Amount")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (AutoFormatExpr) on ""Total VAT Amount"(Control 31)".

            // CaptionClass = DocumentTotals.GetTotalVATCaption(SalesHeader."Currency Code");
            Style = Subordinate;
            StyleExpr = RefreshMessageEnabled;
        }
        modify("Total Amount Incl. VAT")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (AutoFormatExpr) on ""Total Amount Incl. VAT"(Control 29)".

            //CaptionClass = DocumentTotals.GetTotalInclVATCaption(SalesHeader."Currency Code");
            StyleExpr = TotalAmountStyle;
        }

        //Unsupported feature: Code Modification on "Type(Control 2).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        NoOnAfterValidate;
        UpdateEditableOnRow;
        UpdateTypeText;
        DeltaUpdateTotals;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TypeOnAfterValidate;
        NoOnAfterValidate;
        TypeChosen := HasTypeToFillMandatotyFields;

        IF xRec."No." <> '' THEN
          RedistributeTotalsOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 2)".

        modify(FilteredTypeField)
        {
            Visible = false;
        }


        //Unsupported feature: Code Modification on ""No."(Control 4).OnValidate".

        //trigger "(Control 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShowShortcutDimCode(ShortcutDimCode);
        NoOnAfterValidate;
        UpdateEditableOnRow;
        UpdateTypeText;
        DeltaUpdateTotals;

        CurrPage.UPDATE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ShowShortcutDimCode(ShortcutDimCode);
        NoOnAfterValidate;

        IF xRec."No." <> '' THEN
          RedistributeTotalsOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 4)".



        //Unsupported feature: Code Modification on ""Cross-Reference No."(Control 28).OnLookup".

        //trigger "(Control 28)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CrossReferenceNoLookUp;
        InsertExtendedText(FALSE);
        NoOnAfterValidate;
        UpdateEditableOnRow;
        OnCrossReferenceNoOnLookup(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        */
        //end;


        //Unsupported feature: Code Modification on ""Cross-Reference No."(Control 28).OnValidate".

        //trigger "(Control 28)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CrossReferenceNoOnAfterValidat;
        NoOnAfterValidate;
        UpdateEditableOnRow;
        DeltaUpdateTotals;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CrossReferenceNoOnAfterValidat;
        NoOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Cross-Reference No."(Control 28)".



        //Unsupported feature: Code Modification on ""Variant Code"(Control 30).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        VariantCodeOnAfterValidate;
        DeltaUpdateTotals;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        VariantCodeOnAfterValidate
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Substitution Available"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Nonstock(Control 48)".

        // modify("VAT Prod. Posting Group")
        // {
        //     Visible = false;
        // }

        // //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Prod. Posting Group"(Control 14)".

        // modify(Description)
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ShowMandatory) on "Description(Control 6)".



        //Unsupported feature: Code Modification on ""Location Code"(Control 24).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        LocationCodeOnAfterValidate;
        DeltaUpdateTotals;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        LocationCodeOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 24)".


        //Unsupported feature: Property Deletion (Enabled) on ""Location Code"(Control 24)".


        //Unsupported feature: Property Deletion (Editable) on ""Location Code"(Control 24)".



        //Unsupported feature: Code Modification on "Quantity(Control 8).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        QuantityOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        QuantityOnAfterValidate;
        RedistributeTotalsOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 8)".


        //Unsupported feature: Property Deletion (Enabled) on "Quantity(Control 8)".


        //Unsupported feature: Property Deletion (Editable) on "Quantity(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Assemble to Order"(Control 11)".


        //Unsupported feature: Property Deletion (Enabled) on ""Qty. to Assemble to Order"(Control 11)".


        //Unsupported feature: Property Deletion (Editable) on ""Qty. to Assemble to Order"(Control 11)".


        //Unsupported feature: Property Deletion (StyleExpr) on ""Qty. to Assemble to Order"(Control 11)".



        //Unsupported feature: Code Modification on ""Unit of Measure Code"(Control 34).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UnitofMeasureCodeOnAfterValida;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UnitofMeasureCodeOnAfterValida;
        RedistributeTotalsOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 34)".


        //Unsupported feature: Property Deletion (Enabled) on ""Unit of Measure Code"(Control 34)".


        //Unsupported feature: Property Deletion (Editable) on ""Unit of Measure Code"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost (LCY)"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PriceExists(Control 38)".



        //Unsupported feature: Code Modification on ""Unit Price"(Control 12).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DeltaUpdateTotals;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Price"(Control 12)".


        //Unsupported feature: Property Deletion (Enabled) on ""Unit Price"(Control 12)".


        //Unsupported feature: Property Deletion (Editable) on ""Unit Price"(Control 12)".



        //Unsupported feature: Code Modification on ""Line Discount %"(Control 16).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DeltaUpdateTotals;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount %"(Control 16)".


        //Unsupported feature: Property Deletion (Enabled) on ""Line Discount %"(Control 16)".


        //Unsupported feature: Property Deletion (Editable) on ""Line Discount %"(Control 16)".



        //Unsupported feature: Code Modification on ""Line Amount"(Control 50).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DeltaUpdateTotals;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Amount"(Control 50)".


        //Unsupported feature: Property Deletion (Enabled) on ""Line Amount"(Control 50)".


        //Unsupported feature: Property Deletion (Editable) on ""Line Amount"(Control 50)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""Line Amount"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LineDiscExists(Control 60)".



        //Unsupported feature: Code Modification on ""Line Discount Amount"(Control 64).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DeltaUpdateTotals;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount Amount"(Control 64)".

        // modify("Allow Invoice Disc.")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Invoice Disc."(Control 62)".

        modify("Inv. Discount Amount")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Item Charge Assignment"(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Assign"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Assigned"(Control 58)".



        //Unsupported feature: Code Insertion on "RefreshTotals(Control 27)".

        //trigger OnDrillDown()
        //begin
        /*
        DocumentTotals.SalesRedistributeInvoiceDiscountAmounts(Rec,VATAmount,TotalSalesLine);
        CurrPage.UPDATE(FALSE);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Agent Code"(Control 27)".


        //Unsupported feature: Property Deletion (Visible) on ""Shipping Agent Code"(Control 27)".

        modify("Shipping Agent Service Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Type Code"(Control 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Order No."(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Order Line No."(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-to Item Entry"(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 22)".



        //Unsupported feature: Code Modification on "ShortcutDimCode3(Control 300).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateShortcutDimension(3);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ValidateShortcutDimCode(3,ShortcutDimCode[3]);
        */
        //end;


        //Unsupported feature: Code Modification on "ShortcutDimCode4(Control 302).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateShortcutDimension(4);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ValidateShortcutDimCode(4,ShortcutDimCode[4]);
        */
        //end;


        //Unsupported feature: Code Modification on "ShortcutDimCode5(Control 304).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateShortcutDimension(5);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ValidateShortcutDimCode(5,ShortcutDimCode[5]);
        */
        //end;


        //Unsupported feature: Code Modification on "ShortcutDimCode6(Control 306).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateShortcutDimension(6);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ValidateShortcutDimCode(6,ShortcutDimCode[6]);
        */
        //end;


        //Unsupported feature: Code Modification on "ShortcutDimCode7(Control 308).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateShortcutDimension(7);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ValidateShortcutDimCode(7,ShortcutDimCode[7]);
        */
        //end;


        //Unsupported feature: Code Modification on "ShortcutDimCode8(Control 310).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateShortcutDimension(8);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ValidateShortcutDimCode(8,ShortcutDimCode[8]);
        */
        //end;
        modify("Subtotal Excl. VAT")
        {
            Visible = false;
        }


        //Unsupported feature: Code Insertion (VariableCollection) on ""Invoice Discount Amount"(Control 47).OnValidate".

        //trigger (Variable: SalesHeader)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""Invoice Discount Amount"(Control 47).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateInvoiceDiscountAmount;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SalesHeader.GET("Document Type","Document No.");
        SalesCalcDiscByType.ApplyInvDiscBasedOnAmt(TotalSalesLine."Inv. Discount Amount",SalesHeader);
        CurrPage.UPDATE(FALSE);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Discount Amount"(Control 47)".


        //Unsupported feature: Property Deletion (CaptionClass) on ""Invoice Discount Amount"(Control 47)".

        // modify("Invoice Disc. Pct.")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Disc. Pct."(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Amount Excl. VAT"(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total VAT Amount"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Amount Incl. VAT"(Control 29)".

        moveafter("Unit Price"; "Line Amount")
        moveafter("Qty. Assigned"; "Work Type Code")
    }
    actions
    {
        modify(InsertExtTexts)
        {

            //Unsupported feature: Property Modification (Level) on "InsertExtTexts(Action 17)".


            //Unsupported feature: Property Modification (Name) on "InsertExtTexts(Action 17)".

            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {

            //Unsupported feature: Property Modification (Level) on "Dimensions(Action 1907075804)".

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
        modify("Select Item Substitution")
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify("Item Charge &Assignment")
        {
            ApplicationArea = Basic;
        }
        modify("Item &Tracking Lines")
        {
            ApplicationArea = Basic;
        }
        modify("Select Nonstoc&k Items")
        {

            //Unsupported feature: Property Modification (Name) on ""Select Nonstoc&k Items"(Action 13)".

            Caption = 'Nonstoc&k Items';
            ApplicationArea = Basic;
        }
        modify("Assemble-to-Order Lines")
        {
            ApplicationArea = Basic;
        }
        modify("Roll Up &Price")
        {
            ApplicationArea = Basic;
        }
        modify("Roll Up &Cost")
        {
            ApplicationArea = Basic;
        }
        modify("Get &Price")
        {
            ApplicationArea = Basic;
        }
        modify("Get Li&ne Discount")
        {
            ApplicationArea = Basic;
        }
        modify("E&xplode BOM")
        {
            ApplicationArea = Basic;
        }
        modify(SelectMultiItems)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "InsertExtTexts(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1907075804)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Event(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Period(Action 1907981204)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Variant(Action 1903587104)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Location(Action 1903134404)".


        //Unsupported feature: Property Deletion (AccessByPermission) on ""BOM Level"(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BOM Level"(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Select Item Substitution"(Action 1901092104)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 1902027204)".



        //Unsupported feature: Code Modification on ""Item Charge &Assignment"(Action 1907184504).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ItemChargeAssgnt;
        SetItemChargeFieldsStyle;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ItemChargeAssgnt;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Item Charge &Assignment"(Action 1907184504)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item &Tracking Lines"(Action 1905987604)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Select Nonstoc&k Items"(Action 13)".

        modify(DocAttach)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Assemble-to-Order Lines"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Roll Up &Price"(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Roll Up &Cost"(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Get &Price"(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Get Li&ne Discount"(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E&xplode BOM"(Action 19)".

        //moveafter(ActionContainer1900000004;"&Line")
        moveafter("Select Item Substitution"; Dimensions)
        moveafter(Dimensions; "Co&mments")
        moveafter("Item &Tracking Lines"; "Assemble to Order")
    }

    var
        SalesHeader: Record "Sales Header";


    //Unsupported feature: Property Modification (Id) on "InvDiscAmountEditable(Variable 1007)".

    //var
    //>>>> ORIGINAL VALUE:
    //InvDiscAmountEditable : 1007;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //InvDiscAmountEditable : 1010;
    //Variable type has not been exported.

    var

        ItemPanelVisible: Boolean;

    var
        TotalAmountStyle: Text;
        RefreshMessageEnabled: Boolean;
        RefreshMessageText: Text;
        TypeChosen: Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetTotalSalesHeader;
    CalculateTotals;
    UpdateEditableOnRow;
    UpdateTypeText;
    SetItemChargeFieldsStyle;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF SalesHeader.GET("Document Type","Document No.") THEN;

    DocumentTotals.SalesUpdateTotalsControls(Rec,TotalSalesHeader,TotalSalesLine,RefreshMessageEnabled,
      TotalAmountStyle,RefreshMessageText,InvDiscAmountEditable,CurrPage.EDITABLE,VATAmount);

    TypeChosen := HasTypeToFillMandatotyFields;
    */
    //end;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ShowShortcutDimCode(ShortcutDimCode);
    UpdateTypeText;
    SetItemChargeFieldsStyle;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ShowShortcutDimCode(ShortcutDimCode);
    */
    //end;


    //Unsupported feature: Code Modification on "OnDeleteRecord".

    //trigger OnDeleteRecord(): Boolean
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
      COMMIT;
      IF NOT ReserveSalesLine.DeleteLineConfirm(Rec) THEN
        EXIT(FALSE);
      ReserveSalesLine.DeleteLine(Rec);
    END;
    DocumentTotals.SalesDocTotalsNotUpToDate;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    */
    //end;


    //Unsupported feature: Code Modification on "OnNewRecord".

    //trigger OnNewRecord(BelowxRec: Boolean)
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InitType;
    IF ApplicationAreaMgmtFacade.IsFoundationEnabled THEN
      IF xRec."Document No." = '' THEN
        Type := Type::Item;

    CLEAR(ShortcutDimCode);
    UpdateTypeText;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    InitType;
    CLEAR(ShortcutDimCode);
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "ApproveCalcInvDisc(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "ApproveCalcInvDisc(PROCEDURE 1)".

    //procedure ApproveCalcInvDisc();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CODEUNIT.RUN(CODEUNIT::"Sales-Disc. (Yes/No)",Rec);
    DocumentTotals.SalesDocTotalsNotUpToDate;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CODEUNIT.RUN(CODEUNIT::"Sales-Disc. (Yes/No)",Rec);
    */
    //end;


    //Unsupported feature: Code Modification on "ExplodeBOM(PROCEDURE 3)".

    //procedure ExplodeBOM();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CODEUNIT.RUN(CODEUNIT::"Sales-Explode BOM",Rec);
    DocumentTotals.SalesDocTotalsNotUpToDate;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CODEUNIT.RUN(CODEUNIT::"Sales-Explode BOM",Rec);
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "InsertExtendedText(PROCEDURE 4)".


    //Unsupported feature: Property Insertion (Local) on "InsertExtendedText(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "InsertExtendedText(PROCEDURE 4)".

    //procedure InsertExtendedText();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeInsertExtendedText(Rec);
    IF TransferExtendedText.SalesCheckIfAnyExtText(Rec,Unconditionally) THEN BEGIN
      CurrPage.SAVERECORD;
      COMMIT;
      TransferExtendedText.InsertSalesExtText(Rec);
    END;
    IF TransferExtendedText.MakeUpdate THEN
      UpdateForm(TRUE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #2..8
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "UpdateForm(PROCEDURE 12)".



    //Unsupported feature: Code Modification on "QuantityOnAfterValidate(PROCEDURE 19032465)".

    //procedure QuantityOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Reserve = Reserve::Always THEN BEGIN
      CurrPage.SAVERECORD;
      AutoReserve;
    END;
    DeltaUpdateTotals;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4

    IF (Type = Type::Item) AND
       (Quantity <> xRec.Quantity)
    THEN
      CurrPage.UPDATE(TRUE);
    */
    //end;


    //Unsupported feature: Code Modification on "UnitofMeasureCodeOnAfterValida(PROCEDURE 19057939)".

    //procedure UnitofMeasureCodeOnAfterValida();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Reserve = Reserve::Always THEN BEGIN
      CurrPage.SAVERECORD;
      AutoReserve;
    END;
    DeltaUpdateTotals;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    */
    //end;


    //Unsupported feature: Code Modification on "SaveAndAutoAsmToOrder(PROCEDURE 13)".

    //procedure SaveAndAutoAsmToOrder();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF (Type = Type::Item) AND IsAsmToOrderRequired THEN BEGIN
      CurrPage.SAVERECORD;
      AutoAsmToOrder;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
      CurrPage.UPDATE(FALSE);
    END;
    */
    //end;

    //Unsupported feature: Property Modification (Name) on "ValidateShortcutDimension(PROCEDURE 7)".



    //Unsupported feature: Code Modification on "ValidateShortcutDimension(PROCEDURE 7)".

    //procedure ValidateShortcutDimension();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ValidateShortcutDimCode(DimIndex,ShortcutDimCode[DimIndex]);
    AssembleToOrderLink.UpdateAsmDimFromSalesLine(Rec);

    OnAfterValidateShortcutDimCode(Rec,ShortcutDimCode,DimIndex);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CurrPage.SAVERECORD;

    SalesHeader.GET("Document Type","Document No.");
    IF DocumentTotals.SalesCheckNumberOfLinesLimit(SalesHeader) THEN
      DocumentTotals.SalesRedistributeInvoiceDiscountAmounts(Rec,VATAmount,TotalSalesLine);
    CurrPage.UPDATE;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "OnCrossReferenceNoOnLookup(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Name) on "OnCrossReferenceNoOnLookup(PROCEDURE 5)".



    //Unsupported feature: Code Modification on "OnCrossReferenceNoOnLookup(PROCEDURE 5)".

    //procedure OnCrossReferenceNoOnLookup();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CODEUNIT.RUN(CODEUNIT::"Sales-Calc. Discount",Rec);
    */
    //end;

    local procedure TypeOnAfterValidate()
    begin
        ItemPanelVisible := Rec.Type = Rec.Type::Item;
    end;

    //Unsupported feature: Deletion (ParameterCollection) on "ValidateShortcutDimension(PROCEDURE 7).DimIndex(Parameter 1000)".


    //Unsupported feature: Deletion (VariableCollection) on "ValidateShortcutDimension(PROCEDURE 7).AssembleToOrderLink(Variable 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnCrossReferenceNoOnLookup(PROCEDURE 5).SalesLine(Parameter 1000)".

}
