#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186771 pageextension52186771 extends "Sales Return Order Subform"
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
        modify("IC Partner Ref. Type")
        {
            ApplicationArea = Basic;
        }
        modify("IC Partner Reference")
        {
            ApplicationArea = Basic;
        }
        // modify("Variant Code")
        // {
        //     ApplicationArea = Basic;
        // }
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
        modify("Return Reason Code")
        {
            ApplicationArea = Basic;
        }
        // modify("Location Code")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (Visible) on ""Location Code"(Control 72)".

        // }
        modify("Bin Code")
        {
            ApplicationArea = Basic;
        }
        modify(Control28)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on "Control28(Control 28)".

        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
            ShowMandatory = TypeChosen;
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
        modify("Line Discount Amount")
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
        modify("Return Qty. to Receive")
        {
            ApplicationArea = Basic;
        }
        modify("Return Qty. Received")
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
        // modify("Shipment Date")
        // {
        //     ApplicationArea = Basic;
        // }
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
        modify("Blanket Order No.")
        {
            ApplicationArea = Basic;
        }
        modify("Blanket Order Line No.")
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
        modify("Returns Deferral Start Date")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 1 Code"(Control 76)".

        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 2 Code"(Control 74)".

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
        modify(SubtotalExclVAT)
        {

            //Unsupported feature: Property Modification (Name) on "SubtotalExclVAT(Control 7)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "SubtotalExclVAT(Control 7)".


            //Unsupported feature: Property Insertion (DrillDown) on "SubtotalExclVAT(Control 7)".

            Enabled = RefreshMessageEnabled;
            ShowCaption = false;
        }
        modify("Invoice Discount Amount")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Invoice Discount Amount"(Control 31)".


            //Unsupported feature: Property Modification (AutoFormatExpr) on ""Invoice Discount Amount"(Control 31)".

            Style = Subordinate;
            StyleExpr = RefreshMessageEnabled;
        }
        // modify("Invoice Disc. Pct.")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (DecimalPlaces) on ""Invoice Disc. Pct."(Control 29)".


        //     //Unsupported feature: Property Modification (SourceExpr) on ""Invoice Disc. Pct."(Control 29)".

        //     Editable = false;

        //     //Unsupported feature: Property Insertion (Visible) on ""Invoice Disc. Pct."(Control 29)".

        //     Style = Subordinate;
        //     StyleExpr = RefreshMessageEnabled;
        // }
        modify("Total Amount Excl. VAT")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (AutoFormatExpr) on ""Total Amount Excl. VAT"(Control 13)".

            //CaptionClass = DocumentTotals.GetTotalExclVATCaption(SalesHeader."Currency Code");
            Style = Subordinate;
            StyleExpr = RefreshMessageEnabled;
        }
        modify("Total VAT Amount")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (AutoFormatExpr) on ""Total VAT Amount"(Control 11)".

            //CaptionClass = DocumentTotals.GetTotalVATCaption(SalesHeader."Currency Code");
            Style = Subordinate;
            StyleExpr = RefreshMessageEnabled;
        }
        modify("Total Amount Incl. VAT")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (AutoFormatExpr) on ""Total Amount Incl. VAT"(Control 9)".

            // CaptionClass = DocumentTotals.GetTotalInclVATCaption(SalesHeader."Currency Code");
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
        NoOnAfterValidate;
        UpdateEditableOnRow;
        ShowShortcutDimCode(ShortcutDimCode);

        QuantityOnAfterValidate;
        UpdateTypeText;
        DeltaUpdateTotals;
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



        //Unsupported feature: Code Modification on ""Cross-Reference No."(Control 34).OnLookup".

        //trigger "(Control 34)()
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
        */
        //end;


        //Unsupported feature: Code Modification on ""Cross-Reference No."(Control 34).OnValidate".

        //trigger "(Control 34)()
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
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Cross-Reference No."(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""IC Partner Ref. Type"(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""IC Partner Reference"(Control 68)".

        modify("Variant Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Nonstock(Control 38)".



        //Unsupported feature: Code Modification on ""VAT Prod. Posting Group"(Control 58).OnValidate".

        //trigger  Posting Group"(Control 58)()
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Prod. Posting Group"(Control 58)".

        modify(Description)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ShowMandatory) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Return Reason Code"(Control 66)".

        modify("Location Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 72)".


        //Unsupported feature: Property Deletion (Enabled) on ""Location Code"(Control 72)".


        //Unsupported feature: Property Deletion (Editable) on ""Location Code"(Control 72)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""Location Code"(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Control28(Control 28)".



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



        //Unsupported feature: Code Modification on ""Unit of Measure Code"(Control 22).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        UnitofMeasureCodeOnAfterValida;
        DeltaUpdateTotals;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        UnitofMeasureCodeOnAfterValida;
        RedistributeTotalsOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 22)".


        //Unsupported feature: Property Deletion (Enabled) on ""Unit of Measure Code"(Control 22)".


        //Unsupported feature: Property Deletion (Editable) on ""Unit of Measure Code"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost (LCY)"(Control 70)".



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



        //Unsupported feature: Code Modification on ""Line Amount"(Control 92).OnValidate".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Amount"(Control 92)".


        //Unsupported feature: Property Deletion (Enabled) on ""Line Amount"(Control 92)".


        //Unsupported feature: Property Deletion (Editable) on ""Line Amount"(Control 92)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""Line Amount"(Control 92)".



        //Unsupported feature: Code Modification on ""Line Discount Amount"(Control 56).OnValidate".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount Amount"(Control 56)".

        modify("Allow Invoice Disc.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Invoice Disc."(Control 54)".

        modify("Inv. Discount Amount")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Inv. Discount Amount"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Return Qty. to Receive"(Control 82)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Return Qty. Received"(Control 84)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Invoice"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity Invoiced"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Item Charge Assignment"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Assign"(Control 52)".


        //Unsupported feature: Property Deletion (StyleExpr) on ""Qty. to Assign"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Assigned"(Control 60)".

        modify("Requested Delivery Date")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Requested Delivery Date"(Control 78)".

        modify("Promised Delivery Date")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Promised Delivery Date"(Control 80)".

        modify("Planned Delivery Date")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Planned Delivery Date"(Control 94)".

        modify("Planned Shipment Date")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Planned Shipment Date"(Control 96)".

        modify("Shipment Date")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Date"(Control 98)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Agent Code"(Control 100)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Agent Service Code"(Control 102)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipping Time"(Control 104)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Order No."(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Order Line No."(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-from Item Entry"(Control 5810)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-to Item Entry"(Control 48)".

        modify("Deferral Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Deferral Code"(Control 17)".


        //Unsupported feature: Property Deletion (Visible) on ""Deferral Code"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Returns Deferral Start Date"(Control 21)".


        //Unsupported feature: Property Deletion (Visible) on ""Returns Deferral Start Date"(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 74)".



        //Unsupported feature: Code Modification on "ShortcutDimCode3(Control 300).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateShortcutDimCode(3,ShortcutDimCode[3]);

        OnAfterValidateShortcutDimCode(Rec,ShortcutDimCode,3);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ValidateShortcutDimCode(3,ShortcutDimCode[3]);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ShortcutDimCode3(Control 300)".



        //Unsupported feature: Code Modification on "ShortcutDimCode4(Control 302).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateShortcutDimCode(4,ShortcutDimCode[4]);

        OnAfterValidateShortcutDimCode(Rec,ShortcutDimCode,4);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ValidateShortcutDimCode(4,ShortcutDimCode[4]);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ShortcutDimCode4(Control 302)".



        //Unsupported feature: Code Modification on "ShortcutDimCode5(Control 304).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateShortcutDimCode(5,ShortcutDimCode[5]);

        OnAfterValidateShortcutDimCode(Rec,ShortcutDimCode,5);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ValidateShortcutDimCode(5,ShortcutDimCode[5]);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ShortcutDimCode5(Control 304)".



        //Unsupported feature: Code Modification on "ShortcutDimCode6(Control 306).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateShortcutDimCode(6,ShortcutDimCode[6]);

        OnAfterValidateShortcutDimCode(Rec,ShortcutDimCode,6);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ValidateShortcutDimCode(6,ShortcutDimCode[6]);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ShortcutDimCode6(Control 306)".



        //Unsupported feature: Code Modification on "ShortcutDimCode7(Control 308).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateShortcutDimCode(7,ShortcutDimCode[7]);

        OnAfterValidateShortcutDimCode(Rec,ShortcutDimCode,7);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ValidateShortcutDimCode(7,ShortcutDimCode[7]);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ShortcutDimCode7(Control 308)".



        //Unsupported feature: Code Modification on "ShortcutDimCode8(Control 310).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateShortcutDimCode(8,ShortcutDimCode[8]);

        OnAfterValidateShortcutDimCode(Rec,ShortcutDimCode,8);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ValidateShortcutDimCode(8,ShortcutDimCode[8]);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ShortcutDimCode8(Control 310)".



        //Unsupported feature: Code Insertion on "RefreshTotals(Control 7)".

        //trigger OnDrillDown()
        //begin
        /*
        DocumentTotals.SalesRedistributeInvoiceDiscountAmounts(Rec,VATAmount,TotalSalesLine);
        CurrPage.UPDATE(FALSE);
        */
        //end;

        //Unsupported feature: Property Deletion (CaptionML) on "SubtotalExclVAT(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SubtotalExclVAT(Control 7)".


        //Unsupported feature: Property Deletion (AutoFormatType) on "SubtotalExclVAT(Control 7)".


        //Unsupported feature: Property Deletion (AutoFormatExpr) on "SubtotalExclVAT(Control 7)".


        //Unsupported feature: Property Deletion (CaptionClass) on "SubtotalExclVAT(Control 7)".



        //Unsupported feature: Code Insertion (VariableCollection) on ""Invoice Discount Amount"(Control 31).OnValidate".

        //trigger (Variable: SalesHeader)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""Invoice Discount Amount"(Control 31).OnValidate".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Discount Amount"(Control 31)".


        //Unsupported feature: Property Deletion (CaptionClass) on ""Invoice Discount Amount"(Control 31)".

        modify("Invoice Disc. Pct.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Disc. Pct."(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Amount Excl. VAT"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total VAT Amount"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Amount Incl. VAT"(Control 9)".

        moveafter("Unit Price"; "Line Amount")
        moveafter(Control33; "Invoice Discount Amount")
    }
    actions
    {
        modify("E&xplode BOM")
        {
            ApplicationArea = Basic;
        }
        modify("Insert &Ext. Texts")
        {
            ApplicationArea = Basic;
        }
        modify(Reserve)
        {

            //Unsupported feature: Property Modification (Name) on "Reserve(Action 1902085804)".

            ApplicationArea = Basic;
        }
        modify("Order &Tracking")
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
        modify(Comments)
        {

            //Unsupported feature: Property Modification (Name) on "Comments(Action 1900525904)".

            ApplicationArea = Basic;
        }
        modify("Item Charge &Assignment")
        {
            ApplicationArea = Basic;
        }
        modify(ItemTrackingLines)
        {

            //Unsupported feature: Property Modification (Name) on "ItemTrackingLines(Action 1905987604)".

            ApplicationArea = Basic;
        }
        modify(DeferralSchedule)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""E&xplode BOM"(Action 1901991504)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Insert &Ext. Texts"(Action 1901991804)".



        //Unsupported feature: Code Modification on "Reserve(Action 1902085804).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        PageShowReservation;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ShowReservation;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Reserve(Action 1902085804)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order &Tracking"(Action 1906421304)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Event(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Period(Action 1903587104)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Variant(Action 1903193004)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Location(Action 1901743104)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BOM Level"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1902740304)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Comments(Action 1900525904)".



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


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemTrackingLines(Action 1905987604)".

        modify(DocumentLineTracking)
        {
            Visible = false;
        }


        //Unsupported feature: Code Modification on "DeferralSchedule(Action 19).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ShowDeferrals("Posting Date","Currency Code") THEN BEGIN
          "Returns Deferral Start Date" :=
            DeferralUtilities.GetDeferralStartDate(DeferralUtilities.GetSalesDeferralDocType,"Document Type",
              "Document No.","Line No.","Deferral Code","Posting Date");
          CurrPage.SAVERECORD;
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SalesHeader.GET("Document Type","Document No.");
        IF ShowDeferrals(SalesHeader."Posting Date",SalesHeader."Currency Code") THEN BEGIN
          "Returns Deferral Start Date" :=
            DeferralUtilities.GetDeferralStartDate(DeferralUtilities.GetSalesDeferralDocType,"Document Type",
              "Document No.","Line No.","Deferral Code",SalesHeader."Posting Date");
          CurrPage.SAVERECORD;
        END;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "DeferralSchedule(Action 19)".

        modify(DocAttach)
        {
            Visible = false;
        }
    }

    var
        SalesHeader: Record "Sales Header";


    //Unsupported feature: Property Modification (Id) on "ShortcutDimCode(Variable 1017)".

    //var
    //>>>> ORIGINAL VALUE:
    //ShortcutDimCode : 1017;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ShortcutDimCode : 1001;
    //Variable type has not been exported.

    var
    //SalesHeader: Record "Sales Header";

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
    SetLocationCodeMandatory;
    UpdateEditableOnRow;
    UpdateTypeText;
    SetItemChargeFieldsStyle;
    UpdateCurrency;
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

    // Default to Item for the first line and to previous line type for the others
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

    //Unsupported feature: Property Deletion (Attributes) on "CalcInvDisc(PROCEDURE 6)".


    //Unsupported feature: Property Insertion (Local) on "CalcInvDisc(PROCEDURE 6)".



    //Unsupported feature: Code Modification on "CalcInvDisc(PROCEDURE 6)".

    //procedure CalcInvDisc();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CODEUNIT.RUN(CODEUNIT::"Sales-Calc. Discount",Rec);
    DocumentTotals.SalesDocTotalsNotUpToDate;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CODEUNIT.RUN(CODEUNIT::"Sales-Calc. Discount",Rec);
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

    //Unsupported feature: Property Deletion (Attributes) on "InsertExtendedText(PROCEDURE 5)".


    //Unsupported feature: Property Insertion (Local) on "InsertExtendedText(PROCEDURE 5)".



    //Unsupported feature: Code Modification on "InsertExtendedText(PROCEDURE 5)".

    //procedure InsertExtendedText();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsHandled := FALSE;
    OnBeforeInsertExtendedText(Rec,IsHandled);
    IF IsHandled THEN
      EXIT;

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
    #6..12
    */
    //end;

    //Unsupported feature: Property Modification (Name) on "PageShowReservation(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (Attributes) on "UpdateForm(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Name) on "DeltaUpdateTotals(PROCEDURE 8)".



    //Unsupported feature: Code Modification on "DeltaUpdateTotals(PROCEDURE 8)".

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

    //Unsupported feature: Property Modification (Name) on "UpdateCurrency(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "UpdateCurrency(PROCEDURE 4)".

    //procedure UpdateCurrency();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF Currency.Code <> TotalSalesHeader."Currency Code" THEN
      IF NOT Currency.GET(TotalSalesHeader."Currency Code") THEN BEGIN
        CLEAR(Currency);
        Currency.InitRoundingPrecision;
      END
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ShowLineComments;
    */
    //end;

    local procedure OpenItemTrackingLines()
    begin
        Rec.OpenItemTrackingLines;
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(false);
        if (Rec.Type = Rec.Type::"Charge (Item)") and (Rec."No." <> xRec."No.") and
           (xRec."No." <> '')
        then
            CurrPage.SaveRecord;

        if (Rec.Reserve = Rec.Reserve::Always) and
           (Rec."Outstanding Qty. (Base)" <> 0) and
           (Rec."No." <> xRec."No.")
        then begin
            CurrPage.SaveRecord;
            Rec.AutoReserve;
            CurrPage.Update(false);
        end;
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(false);
    end;

    local procedure ReserveOnAfterValidate()
    begin
        if (Rec.Reserve = Rec.Reserve::Always) and (Rec."Outstanding Qty. (Base)" <> 0) then begin
            CurrPage.SaveRecord;
            Rec.AutoReserve;
        end;
    end;

    local procedure QuantityOnAfterValidate()
    begin
        if Rec.Reserve = Rec.Reserve::Always then begin
            CurrPage.SaveRecord;
            Rec.AutoReserve;
        end;
    end;

    local procedure UnitofMeasureCodeOnAfterValida()
    begin
        if Rec.Reserve = Rec.Reserve::Always then begin
            CurrPage.SaveRecord;
            Rec.AutoReserve;
        end;
    end;

    //Unsupported feature: Deletion (VariableCollection) on "InsertExtendedText(PROCEDURE 5).IsHandled(Variable 1001)".

}
