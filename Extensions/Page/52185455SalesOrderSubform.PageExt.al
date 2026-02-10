#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185455 pageextension52185455 extends "Sales Order Subform"
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
            // ShowMandatory = TypeChosen;
        }
        // modify("Cross-Reference No.")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("IC Partner Code")
        {
            ApplicationArea = Basic;
        }
        modify("IC Partner Ref. Type")
        {
            ApplicationArea = Basic;
        }
        modify("IC Partner Reference")
        {
            ApplicationArea = Basic;
        }
        modify("Variant Code")
        {
            ApplicationArea = Basic;
        }
        modify("Substitution Available")
        {
            ApplicationArea = Basic;
        }
        modify("Purchasing Code")
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
        // modify(Description)
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Drop Shipment")
        {
            ApplicationArea = Basic;
        }
        modify("Special Order")
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
        modify(Control50)
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
            //ShowMandatory = TypeChosen;
        }
        modify("Qty. to Assemble to Order")
        {
            ApplicationArea = Basic;
        }
        modify("Reserved Quantity")
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
        modify(SalesPriceExist)
        {
            ApplicationArea = Basic;
        }
        modify("Unit Price")
        {
            ApplicationArea = Basic;
            //ShowMandatory = TypeChosen;
        }
        modify("Line Discount %")
        {
            ApplicationArea = Basic;
        }
        modify("Line Amount")
        {
            ApplicationArea = Basic;
        }
        modify(SalesLineDiscExists)
        {
            ApplicationArea = Basic;
        }
        modify("Line Discount Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Prepayment %")
        {
            ApplicationArea = Basic;
        }
        modify("Prepmt. Line Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Prepmt. Amt. Inv.")
        {
            ApplicationArea = Basic;
        }
        // modify("Allow Invoice Disc.")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Inv. Discount Amount")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Qty. to Ship")
        {
            ApplicationArea = Basic;
        }
        modify("Quantity Shipped")
        {
            ApplicationArea = Basic;
        }
        modify("Qty. to Invoice")
        {
            ApplicationArea = Basic;
        }
        modify("Quantity Invoiced")
        {
            ApplicationArea = Basic;
        }
        modify("Prepmt Amt to Deduct")
        {
            ApplicationArea = Basic;
        }
        modify("Prepmt Amt Deducted")
        {
            ApplicationArea = Basic;
        }
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
        // modify("Requested Delivery Date")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Promised Delivery Date")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Planned Delivery Date")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Planned Shipment Date")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Shipment Date")
        {
            ApplicationArea = Basic;
        }
        modify("Shipping Agent Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shipping Agent Service Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shipping Time")
        {
            ApplicationArea = Basic;
        }
        modify("Work Type Code")
        {
            ApplicationArea = Basic;
        }
        modify("Whse. Outstanding Qty.")
        {
            ApplicationArea = Basic;
        }
        modify("Whse. Outstanding Qty. (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("ATO Whse. Outstanding Qty.")
        {
            ApplicationArea = Basic;
        }
        modify("ATO Whse. Outstd. Qty. (Base)")
        {
            ApplicationArea = Basic;
        }
        modify("Outbound Whse. Handling Time")
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
        modify("FA Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Depr. until FA Posting Date")
        {
            ApplicationArea = Basic;
        }
        // modify("<Depr. until FA Posting Date>")
        // {

        //     //Unsupported feature: Property Modification (Name) on ""<Depr. until FA Posting Date>"(Control 36)".

        //     ApplicationArea = Basic;
        // }
        modify("Use Duplication List")
        {
            ApplicationArea = Basic;
        }
        modify("Duplicate in Depreciation Book")
        {
            ApplicationArea = Basic;
        }
        modify("Appl.-from Item Entry")
        {
            ApplicationArea = Basic;
        }
        modify("Appl.-to Item Entry")
        {
            ApplicationArea = Basic;
        }
        // modify("Deferral Code")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 1 Code"(Control 32)".

        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 2 Code"(Control 34)".

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
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Line No.")
        {
            ApplicationArea = Basic;
        }
        modify("Invoice Discount Amount")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Invoice Discount Amount"(Control 43)".


            //Unsupported feature: Property Modification (AutoFormatExpr) on ""Invoice Discount Amount"(Control 43)".

            Style = Subordinate;
            //StyleExpr = RefreshMessageEnabled;
        }
        // modify("Invoice Disc. Pct.")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (DecimalPlaces) on ""Invoice Disc. Pct."(Control 41)".


        //     //Unsupported feature: Property Modification (SourceExpr) on ""Invoice Disc. Pct."(Control 41)".

        //     Editable = false;

        //     //Unsupported feature: Property Insertion (Visible) on ""Invoice Disc. Pct."(Control 41)".

        //     Style = Subordinate;
        //     StyleExpr = RefreshMessageEnabled;
        //}
        // modify("Total Amount Excl. VAT")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (AutoFormatExpr) on ""Total Amount Excl. VAT"(Control 27)".

        //    // CaptionClass = DocumentTotals.GetTotalExclVATCaption(SalesHeader."Currency Code");
        //     Style = Subordinate;
        //     StyleExpr = RefreshMessageEnabled;
        // }
        modify("Total VAT Amount")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (AutoFormatExpr) on ""Total VAT Amount"(Control 25)".

            //CaptionClass = DocumentTotals.GetTotalVATCaption(SalesHeader."Currency Code");
            Style = Subordinate;
            StyleExpr = RefreshMessageEnabled;
        }
        modify("Total Amount Incl. VAT")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (AutoFormatExpr) on ""Total Amount Incl. VAT"(Control 23)".

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
        SetLocationCodeMandatory;
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
        SetLocationCodeMandatory;

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
        NoOnAfterValidate;
        UpdateEditableOnRow;
        ShowShortcutDimCode(ShortcutDimCode);

        QuantityOnAfterValidate;
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



        //Unsupported feature: Code Modification on ""Cross-Reference No."(Control 68).OnLookup".

        //trigger "(Control 68)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CrossReferenceNoLookUp;
        NoOnAfterValidate;
        UpdateEditableOnRow;
        OnCrossReferenceNoOnLookup(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CrossReferenceNoLookUp;
        InsertExtendedText(FALSE);
        NoOnAfterValidate;
        */
        //end;


        //Unsupported feature: Code Modification on ""Cross-Reference No."(Control 68).OnValidate".

        //trigger "(Control 68)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Cross-Reference No."(Control 68)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""IC Partner Code"(Control 1136)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""IC Partner Ref. Type"(Control 130)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""IC Partner Reference"(Control 132)".



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
        VariantCodeOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Substitution Available"(Control 104)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchasing Code"(Control 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Nonstock(Control 70)".



        //Unsupported feature: Code Modification on ""VAT Prod. Posting Group"(Control 78).OnValidate".

        //trigger  Posting Group"(Control 78)()
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Prod. Posting Group"(Control 78)".

        // modify(Description)
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ShowMandatory) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Drop Shipment"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Special Order"(Control 106)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Return Reason Code"(Control 110)".



        //Unsupported feature: Code Modification on ""Location Code"(Control 42).OnValidate".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 42)".


        //Unsupported feature: Property Deletion (Visible) on ""Location Code"(Control 42)".


        //Unsupported feature: Property Deletion (Enabled) on ""Location Code"(Control 42)".


        //Unsupported feature: Property Deletion (Editable) on ""Location Code"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 114)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Control50(Control 50)".



        //Unsupported feature: Code Modification on "Quantity(Control 8).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        QuantityOnAfterValidate;
        DeltaUpdateTotals;
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


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Assemble to Order"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reserved Quantity"(Control 48)".



        //Unsupported feature: Code Modification on ""Unit of Measure Code"(Control 44).OnValidate".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 44)".


        //Unsupported feature: Property Deletion (Enabled) on ""Unit of Measure Code"(Control 44)".


        //Unsupported feature: Property Deletion (Editable) on ""Unit of Measure Code"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost (LCY)"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesPriceExist(Control 112)".



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



        //Unsupported feature: Code Modification on ""Line Amount"(Control 76).OnValidate".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Amount"(Control 76)".


        //Unsupported feature: Property Deletion (Enabled) on ""Line Amount"(Control 76)".


        //Unsupported feature: Property Deletion (Editable) on ""Line Amount"(Control 76)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""Line Amount"(Control 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesLineDiscExists(Control 116)".



        //Unsupported feature: Code Modification on ""Line Discount Amount"(Control 52).OnValidate".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount Amount"(Control 52)".



        //Unsupported feature: Code Insertion on ""Prepayment %"(Control 136)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Prepayment %"(Control 136)".



        //Unsupported feature: Code Insertion on ""Prepmt. Line Amount"(Control 138)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Prepmt. Line Amount"(Control 138)".



        //Unsupported feature: Code Insertion on ""Prepmt. Amt. Inv."(Control 140)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Prepmt. Amt. Inv."(Control 140)".

        // modify("Allow Invoice Disc.")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Invoice Disc."(Control 54)".

        // modify("Inv. Discount Amount")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Inv. Discount Amount"(Control 90)".

        modify("Inv. Disc. Amount to Invoice")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Ship"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity Shipped"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Invoice"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity Invoiced"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prepmt Amt to Deduct"(Control 142)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prepmt Amt Deducted"(Control 144)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Item Charge Assignment"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Assign"(Control 5800)".


        //Unsupported feature: Property Deletion (StyleExpr) on ""Qty. to Assign"(Control 5800)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Assigned"(Control 102)".

        // modify("Requested Delivery Date")
        // {
        //     Visible = false;
        // }

        // //Unsupported feature: Property Deletion (ToolTipML) on ""Requested Delivery Date"(Control 82)".

        // modify("Promised Delivery Date")
        // {
        //     Visible = false;
        // }

        // //Unsupported feature: Property Deletion (ToolTipML) on ""Promised Delivery Date"(Control 84)".

        // modify("Planned Delivery Date")
        // {
        //     Visible = false;
        // }

        // //Unsupported feature: Property Deletion (ToolTipML) on ""Planned Delivery Date"(Control 86)".

        // modify("Planned Shipment Date")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Planned Shipment Date"(Control 88)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Date"(Control 100)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Agent Code"(Control 92)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Agent Service Code"(Control 94)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Time"(Control 96)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Type Code"(Control 134)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Whse. Outstanding Qty."(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Whse. Outstanding Qty. (Base)"(Control 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ATO Whse. Outstanding Qty."(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ATO Whse. Outstd. Qty. (Base)"(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Outbound Whse. Handling Time"(Control 98)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Order No."(Control 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Order Line No."(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Posting Date"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Depr. until FA Posting Date"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""<Depr. until FA Posting Date>"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Use Duplication List"(Control 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Duplicate in Depreciation Book"(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-from Item Entry"(Control 108)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-to Item Entry"(Control 60)".

        // modify("Deferral Code")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Deferral Code"(Control 29)".


        //Unsupported feature: Property Deletion (Visible) on ""Deferral Code"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 34)".



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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 146)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line No."(Control 148)".

        modify("TotalSalesLine.""Line Amount""")
        {
            Visible = false;
        }


        //Unsupported feature: Code Insertion (VariableCollection) on ""Invoice Discount Amount"(Control 43).OnValidate".

        //trigger (Variable: SalesHeader)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""Invoice Discount Amount"(Control 43).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        DocumentTotals.SalesDocTotalsNotUpToDate;
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Discount Amount"(Control 43)".


        //Unsupported feature: Property Deletion (CaptionClass) on ""Invoice Discount Amount"(Control 43)".

        modify("Invoice Disc. Pct.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Disc. Pct."(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Amount Excl. VAT"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total VAT Amount"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Amount Incl. VAT"(Control 23)".

        addafter("Total Amount Incl. VAT")
        {
            field(RefreshTotals; RefreshMessageText)
            {
                ApplicationArea = Basic;
                DrillDown = true;
                Editable = false;
                Enabled = RefreshMessageEnabled;
                ShowCaption = false;

                trigger OnDrillDown()
                begin
                    //DocumentTotals.SalesRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalSalesLine);
                    CurrPage.Update(false);
                end;
            }
        }
        moveafter("Unit Price"; "Line Amount")
    }
    actions
    {

        //Unsupported feature: Property Modification (Level) on ""F&unctions"(Action 1906587504)".

        modify(GetPrice)
        {

            //Unsupported feature: Property Modification (Level) on "GetPrice(Action 1905623604)".

            ApplicationArea = Basic;
        }
        modify("Get Li&ne Discount")
        {

            //Unsupported feature: Property Modification (Level) on ""Get Li&ne Discount"(Action 1901770504)".

            ApplicationArea = Basic;
        }
        modify("ExplodeBOM_Functions")
        {

            //Unsupported feature: Property Modification (Level) on ""ExplodeBOM_Functions"(Action 1901741804)".

            ApplicationArea = Basic;
        }
        modify("Insert Ext. Texts")
        {

            //Unsupported feature: Property Modification (Level) on ""Insert Ext. Texts"(Action 1903099004)".

            ApplicationArea = Basic;
        }
        modify(Reserve)
        {

            //Unsupported feature: Property Modification (Level) on "Reserve(Action 1905427504)".

            ApplicationArea = Basic;
        }
        modify(OrderTracking)
        {

            //Unsupported feature: Property Modification (Level) on "OrderTracking(Action 1903502504)".

            ApplicationArea = Basic;
        }
        modify("Select Nonstoc&k Items")
        {

            //Unsupported feature: Property Modification (Level) on ""Select Nonstoc&k Items"(Action 1905968604)".


            //Unsupported feature: Property Modification (Name) on ""Select Nonstoc&k Items"(Action 1905968604)".

            Caption = 'Nonstoc&k Items';
            ApplicationArea = Basic;
        }
        modify("<Action3>")
        {
            ApplicationArea = Basic;
        }
        modify(ItemAvailabilityByPeriod)
        {

            //Unsupported feature: Property Modification (Name) on "ItemAvailabilityByPeriod(Action 1904522204)".

            ApplicationArea = Basic;
        }
        modify(ItemAvailabilityByVariant)
        {

            //Unsupported feature: Property Modification (Name) on "ItemAvailabilityByVariant(Action 1902056104)".

            ApplicationArea = Basic;
        }
        modify(ItemAvailabilityByLocation)
        {

            //Unsupported feature: Property Modification (Name) on "ItemAvailabilityByLocation(Action 1900639404)".

            ApplicationArea = Basic;
        }
        modify("BOM Level")
        {
            ApplicationArea = Basic;
        }
        modify("Reservation Entries")
        {

            //Unsupported feature: Property Modification (Level) on ""Reservation Entries"(Action 1900186704)".

            ApplicationArea = Basic;
        }
        modify(ItemTrackingLines)
        {

            //Unsupported feature: Property Modification (Level) on "ItemTrackingLines(Action 1905987604)".

            ApplicationArea = Basic;
        }
        modify(SelectItemSubstitution)
        {

            //Unsupported feature: Property Modification (Level) on "SelectItemSubstitution(Action 1901633104)".


            //Unsupported feature: Property Modification (Name) on "SelectItemSubstitution(Action 1901633104)".

            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {

            //Unsupported feature: Property Modification (Level) on "Dimensions(Action 1902085804)".

            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {

            //Unsupported feature: Property Modification (Level) on ""Co&mments"(Action 1903418704)".

            ApplicationArea = Basic;
        }
        modify("Item Charge &Assignment")
        {

            //Unsupported feature: Property Modification (Level) on ""Item Charge &Assignment"(Action 1907184504)".

            ApplicationArea = Basic;
        }
        modify(OrderPromising)
        {

            //Unsupported feature: Property Modification (Level) on "OrderPromising(Action 1905403704)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Modification (Level) on ""Assemble to Order"(Action 7)".

        modify(AssembleToOrderLines)
        {

            //Unsupported feature: Property Modification (Level) on "AssembleToOrderLines(Action 9)".

            ApplicationArea = Basic;
        }
        modify("Roll Up &Price")
        {

            //Unsupported feature: Property Modification (Level) on ""Roll Up &Price"(Action 11)".

            ApplicationArea = Basic;
        }
        modify("Roll Up &Cost")
        {

            //Unsupported feature: Property Modification (Level) on ""Roll Up &Cost"(Action 13)".

            ApplicationArea = Basic;
        }
        modify(DeferralSchedule)
        {

            //Unsupported feature: Property Modification (Level) on "DeferralSchedule(Action 31)".

            ApplicationArea = Basic;
        }
        modify("Purchase &Order")
        {
            ApplicationArea = Basic;
        }
        modify(OpenSpecialPurchaseOrder)
        {
            ApplicationArea = Basic;
        }
        modify(SelectMultiItems)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "GetPrice(Action 1905623604)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Get Li&ne Discount"(Action 1901770504)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ExplodeBOM_Functions"(Action 1901741804)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Insert Ext. Texts"(Action 1903099004)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reserve(Action 1905427504)".


        //Unsupported feature: Property Deletion (ToolTipML) on "OrderTracking(Action 1903502504)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Select Nonstoc&k Items"(Action 1905968604)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""<Action3>"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemAvailabilityByPeriod(Action 1904522204)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemAvailabilityByVariant(Action 1902056104)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemAvailabilityByLocation(Action 1900639404)".


        //Unsupported feature: Property Deletion (AccessByPermission) on ""BOM Level"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BOM Level"(Action 15)".

        modify("Related Information")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Reservation Entries"(Action 1900186704)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemTrackingLines(Action 1905987604)".



        //Unsupported feature: Code Modification on "SelectItemSubstitution(Action 1901633104).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SAVERECORD;
        ShowItemSub;
        CurrPage.UPDATE(TRUE);
        IF (Reserve = Reserve::Always) AND ("No." <> xRec."No.") THEN BEGIN
          AutoReserve;
          CurrPage.UPDATE(FALSE);
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ShowItemSub;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "SelectItemSubstitution(Action 1901633104)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1902085804)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 1903418704)".



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


        //Unsupported feature: Property Deletion (ToolTipML) on "OrderPromising(Action 1905403704)".

        modify(DocAttach)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "AssembleToOrderLines(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Roll Up &Price"(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Roll Up &Cost"(Action 13)".

        modify(DocumentLineTracking)
        {
            Visible = false;
        }


        //Unsupported feature: Code Modification on "DeferralSchedule(Action 31).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShowDeferralSchedule;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SalesHeader.GET("Document Type","Document No.");
        ShowDeferrals(SalesHeader."Posting Date",SalesHeader."Currency Code");
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "DeferralSchedule(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase &Order"(Action 1907981104)".


        //Unsupported feature: Property Deletion (ToolTipML) on "OpenSpecialPurchaseOrder(Action 1903192904)".

        modify(BlanketOrder)
        {
            Visible = false;
        }
        moveafter("&Line"; "Item Availability by")
    }

    var
        SalesHeader: Record "Sales Header";

    var
    //SalesCalcDiscByType: Codeunit "Sales - Calc Discount By Type";

    var

        ItemPanelVisible: Boolean;
        TypeChosen: Boolean;

    var
        TotalAmountStyle: Text;
        RefreshMessageEnabled: Boolean;
        RefreshMessageText: Text;


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetTotalSalesHeader;
    CalculateTotals;
    SetLocationCodeMandatory;
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
    SetLocationCodeMandatory;
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
    SetDefaultType;

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

    //Unsupported feature: Property Deletion (Attributes) on "CalcInvDisc(PROCEDURE 6)".



    //Unsupported feature: Code Modification on "CalcInvDisc(PROCEDURE 6)".

    //procedure CalcInvDisc();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SalesCalcDiscount.CalculateInvoiceDiscountOnLine(Rec);
    DocumentTotals.SalesDocTotalsNotUpToDate;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CODEUNIT.RUN(CODEUNIT::"Sales-Calc. Discount",Rec);
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "ExplodeBOM(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "ExplodeBOM(PROCEDURE 3)".

    //procedure ExplodeBOM();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Prepmt. Amt. Inv." <> 0 THEN
      ERROR(Text001);
    CODEUNIT.RUN(CODEUNIT::"Sales-Explode BOM",Rec);
    DocumentTotals.SalesDocTotalsNotUpToDate;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "OpenPurchOrderForm(PROCEDURE 4)".


    //Unsupported feature: Property Deletion (Attributes) on "OpenSpecialPurchOrderForm(PROCEDURE 14)".


    //Unsupported feature: Property Deletion (Attributes) on "InsertExtendedText(PROCEDURE 5)".



    //Unsupported feature: Code Modification on "InsertExtendedText(PROCEDURE 5)".

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

    //Unsupported feature: Property Deletion (Attributes) on "ShowNonstockItems(PROCEDURE 11)".


    //Unsupported feature: Property Deletion (Attributes) on "ShowTracking(PROCEDURE 13)".


    //Unsupported feature: Property Deletion (Attributes) on "ItemChargeAssgnt(PROCEDURE 5800)".


    //Unsupported feature: Property Deletion (Attributes) on "UpdateForm(PROCEDURE 12)".


    //Unsupported feature: Property Deletion (Attributes) on "ShowPrices(PROCEDURE 15)".


    //Unsupported feature: Property Deletion (Attributes) on "ShowLineDisc(PROCEDURE 16)".


    //Unsupported feature: Property Deletion (Attributes) on "OrderPromisingLine(PROCEDURE 17)".


    //Unsupported feature: Variable Insertion (Variable: InventorySetup) (VariableCollection) on "SetLocationCodeMandatory(PROCEDURE 22)".



    //Unsupported feature: Code Modification on "SetLocationCodeMandatory(PROCEDURE 22)".

    //procedure SetLocationCodeMandatory();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    LocationCodeMandatory := InventorySetup."Location Mandatory" AND (Type = Type::Item);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    InventorySetup.GET;
    LocationCodeMandatory := InventorySetup."Location Mandatory" AND (Type = Type::Item);
    */
    //end;

    //Unsupported feature: Property Modification (Name) on "DeltaUpdateTotals(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "DeltaUpdateTotals(PROCEDURE 2)".

    //procedure DeltaUpdateTotals();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DocumentTotals.SalesDeltaUpdateTotals(Rec,xRec,TotalSalesLine,VATAmount,InvoiceDiscountAmount,InvoiceDiscountPct);
    IF "Line Amount" <> xRec."Line Amount" THEN
      SendLineInvoiceDiscountResetNotification;
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

    local procedure TypeOnAfterValidate()
    begin
        ItemPanelVisible := Rec.Type = Rec.Type::Item;
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(false);
        if (Rec.Type = Rec.Type::"Charge (Item)") and (Rec."No." <> xRec."No.") and
           (xRec."No." <> '')
        then
            CurrPage.SaveRecord;

        SaveAndAutoAsmToOrder;

        if Rec.Reserve = Rec.Reserve::Always then begin
            CurrPage.SaveRecord;
            if (Rec."Outstanding Qty. (Base)" <> 0) and (Rec."No." <> xRec."No.") then begin
                Rec.AutoReserve;
                CurrPage.Update(false);
            end;
        end;
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(false);
    end;

    local procedure LocationCodeOnAfterValidate()
    begin
        SaveAndAutoAsmToOrder;

        if (Rec.Reserve = Rec.Reserve::Always) and
           (Rec."Outstanding Qty. (Base)" <> 0) and
           (Rec."Location Code" <> xRec."Location Code")
        then begin
            CurrPage.SaveRecord;
            Rec.AutoReserve;
            CurrPage.Update(false);
        end;
    end;

    local procedure ReserveOnAfterValidate()
    begin
        if (Rec.Reserve = Rec.Reserve::Always) and (Rec."Outstanding Qty. (Base)" <> 0) then begin
            CurrPage.SaveRecord;
            Rec.AutoReserve;
            CurrPage.Update(false);
        end;
    end;

    local procedure QuantityOnAfterValidate()
    var
        UpdateIsDone: Boolean;
    begin
        if Rec.Type = Rec.Type::Item then
            case Rec.Reserve of
                Rec.Reserve::Always:
                    begin
                        CurrPage.SaveRecord;
                        Rec.AutoReserve;
                        CurrPage.Update(false);
                        UpdateIsDone := true;
                    end;
                Rec.Reserve::Optional:
                    if (Rec.Quantity < xRec.Quantity) and (xRec.Quantity > 0) then begin
                        CurrPage.SaveRecord;
                        CurrPage.Update(false);
                        UpdateIsDone := true;
                    end;
            end;

        if (Rec.Type = Rec.Type::Item) and
           (Rec.Quantity <> xRec.Quantity) and
           not UpdateIsDone
        then
            CurrPage.Update(true);
    end;

    local procedure UnitofMeasureCodeOnAfterValida()
    begin
        if Rec.Reserve = Rec.Reserve::Always then begin
            CurrPage.SaveRecord;
            Rec.AutoReserve;
            CurrPage.Update(false);
        end;
    end;

    local procedure ShipmentDateOnAfterValidate()
    begin
        if (Rec.Reserve = Rec.Reserve::Always) and
           (Rec."Outstanding Qty. (Base)" <> 0) and
           (Rec."Shipment Date" <> xRec."Shipment Date")
        then begin
            CurrPage.SaveRecord;
            Rec.AutoReserve;
            CurrPage.Update(false);
        end;
    end;

    //Unsupported feature: Deletion (VariableCollection) on "CalcInvDisc(PROCEDURE 6).SalesCalcDiscount(Variable 1000)".

}
