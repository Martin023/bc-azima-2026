#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185483 pageextension52185483 extends "Purchase Quote Subform"
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
        // modify("Cross-Reference No.")
        // {
        //     ApplicationArea = Basic;
        // }
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
        modify("Location Code")
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
        modify("Direct Unit Cost")
        {
            ApplicationArea = Basic;
        }
        modify("Indirect Cost %")
        {
            ApplicationArea = Basic;
        }
        modify("Unit Cost (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Unit Price (LCY)")
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
        // modify("Allow Invoice Disc.")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Allow Item Charge Assignment")
        {
            ApplicationArea = Basic;
        }
        // modify("Qty. to Assign")
        // {
        //     ApplicationArea = Basic;
        //     BlankZero = true;
        // }
        // modify("Qty. Assigned")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Prod. Order No.")
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

            //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 1 Code"(Control 66)".

        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 2 Code"(Control 64)".

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
        modify(AmountBeforeDiscount)
        {

            //Unsupported feature: Property Modification (Name) on "AmountBeforeDiscount(Control 9)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "AmountBeforeDiscount(Control 9)".


            //Unsupported feature: Property Insertion (DrillDown) on "AmountBeforeDiscount(Control 9)".

            Enabled = RefreshMessageEnabled;
            ShowCaption = false;
        }
        modify("Invoice Discount Amount")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Invoice Discount Amount"(Control 33)".


            //Unsupported feature: Property Modification (AutoFormatExpr) on ""Invoice Discount Amount"(Control 33)".

            Style = Subordinate;
            StyleExpr = RefreshMessageEnabled;
        }
        // modify("Invoice Disc. Pct.")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (DecimalPlaces) on ""Invoice Disc. Pct."(Control 27)".


        //     //Unsupported feature: Property Modification (SourceExpr) on ""Invoice Disc. Pct."(Control 27)".

        //     Editable = false;

        //     //Unsupported feature: Property Insertion (Visible) on ""Invoice Disc. Pct."(Control 27)".

        //     Style = Subordinate;
        //     StyleExpr = RefreshMessageEnabled;
        // }
        modify("Total Amount Excl. VAT")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (AutoFormatExpr) on ""Total Amount Excl. VAT"(Control 11)".

            //CaptionClass = DocumentTotals.GetTotalExclVATCaption(PurchHeader."Currency Code");
            Style = Subordinate;
            StyleExpr = RefreshMessageEnabled;
        }
        modify("Total VAT Amount")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (AutoFormatExpr) on ""Total VAT Amount"(Control 13)".

            //CaptionClass = DocumentTotals.GetTotalVATCaption(PurchHeader."Currency Code");
            Style = Subordinate;
            StyleExpr = RefreshMessageEnabled;
        }
        modify("Total Amount Incl. VAT")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (AutoFormatExpr) on ""Total Amount Incl. VAT"(Control 7)".

            //CaptionClass = DocumentTotals.GetTotalInclVATCaption(PurchHeader."Currency Code");
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
        NoOnAfterValidate;
        IF xRec."No." <> '' THEN
          RedistributeTotalsOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 2)".

        modify(FilteredTypeField)
        {
            Visible = false;
        }
        modify("Description 2")
        {
            Visible = True;
        }


        //Unsupported feature: Code Modification on ""No."(Control 4).OnValidate".

        //trigger "(Control 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShowShortcutDimCode(ShortcutDimCode);
        NoOnAfterValidate;

        UpdateTypeText;
        DeltaUpdateTotals;

        CurrPage.UPDATE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        IF xRec."No." <> '' THEN
          RedistributeTotalsOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 4)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""No."(Control 4)".



        //Unsupported feature: Code Modification on ""Cross-Reference No."(Control 36).OnLookup".

        //trigger "(Control 36)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CrossReferenceNoLookUp;
        InsertExtendedText(FALSE);
        NoOnAfterValidate;
        OnCrossReferenceNoOnLookup(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..3
        */
        //end;


        //Unsupported feature: Code Modification on ""Cross-Reference No."(Control 36).OnValidate".

        //trigger "(Control 36)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CrossReferenceNoOnAfterValidat;
        NoOnAfterValidate;
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Cross-Reference No."(Control 36)".

        // modify("Variant Code")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Nonstock(Control 38)".



        //Unsupported feature: Code Modification on ""VAT Prod. Posting Group"(Control 14).OnValidate".

        //trigger  Posting Group"(Control 14)()
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Prod. Posting Group"(Control 14)".

        // modify(Description)
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 62)".


        //Unsupported feature: Property Deletion (Enabled) on ""Location Code"(Control 62)".


        //Unsupported feature: Property Deletion (Editable) on ""Location Code"(Control 62)".



        //Unsupported feature: Code Modification on "Quantity(Control 8).OnValidate".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 8)".


        //Unsupported feature: Property Deletion (Enabled) on "Quantity(Control 8)".


        //Unsupported feature: Property Deletion (Editable) on "Quantity(Control 8)".


        //Unsupported feature: Property Deletion (ShowMandatory) on "Quantity(Control 8)".



        //Unsupported feature: Code Modification on ""Unit of Measure Code"(Control 24).OnValidate".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 24)".


        //Unsupported feature: Property Deletion (Enabled) on ""Unit of Measure Code"(Control 24)".


        //Unsupported feature: Property Deletion (Editable) on ""Unit of Measure Code"(Control 24)".



        //Unsupported feature: Code Insertion on ""Unit of Measure"(Control 10)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure"(Control 10)".



        //Unsupported feature: Code Modification on ""Direct Unit Cost"(Control 12).OnValidate".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Direct Unit Cost"(Control 12)".


        //Unsupported feature: Property Deletion (Enabled) on ""Direct Unit Cost"(Control 12)".


        //Unsupported feature: Property Deletion (Editable) on ""Direct Unit Cost"(Control 12)".


        //Unsupported feature: Property Deletion (ShowMandatory) on ""Direct Unit Cost"(Control 12)".



        //Unsupported feature: Code Insertion on ""Indirect Cost %"(Control 58)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Indirect Cost %"(Control 58)".



        //Unsupported feature: Code Insertion on ""Unit Cost (LCY)"(Control 56)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost (LCY)"(Control 56)".



        //Unsupported feature: Code Insertion on ""Unit Price (LCY)"(Control 60)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
        /*
        RedistributeTotalsOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Price (LCY)"(Control 60)".


        //Unsupported feature: Property Deletion (BlankZero) on ""Unit Price (LCY)"(Control 60)".



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



        //Unsupported feature: Code Modification on ""Line Amount"(Control 30).OnValidate".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Amount"(Control 30)".


        //Unsupported feature: Property Deletion (Enabled) on ""Line Amount"(Control 30)".


        //Unsupported feature: Property Deletion (Editable) on ""Line Amount"(Control 30)".



        //Unsupported feature: Code Modification on ""Line Discount Amount"(Control 50).OnValidate".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount Amount"(Control 50)".

        // modify("Allow Invoice Disc.")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Invoice Disc."(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Item Charge Assignment"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Assign"(Control 32)".


        //Unsupported feature: Property Deletion (StyleExpr) on ""Qty. to Assign"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Assigned"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prod. Order No."(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Order No."(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Order Line No."(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-to Item Entry"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 64)".



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


        //Unsupported feature: Code Insertion on "RefreshTotals(Control 9)".

        //trigger OnDrillDown()
        //begin
        /*
        DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec,VATAmount,TotalPurchaseLine);
        CurrPage.UPDATE(FALSE);
        */
        //end;

        //Unsupported feature: Property Deletion (CaptionML) on "AmountBeforeDiscount(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AmountBeforeDiscount(Control 9)".


        //Unsupported feature: Property Deletion (AutoFormatType) on "AmountBeforeDiscount(Control 9)".


        //Unsupported feature: Property Deletion (AutoFormatExpr) on "AmountBeforeDiscount(Control 9)".


        //Unsupported feature: Property Deletion (CaptionClass) on "AmountBeforeDiscount(Control 9)".



        //Unsupported feature: Code Insertion (VariableCollection) on ""Invoice Discount Amount"(Control 33).OnValidate".

        //trigger (Variable: PurchaseHeader)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on ""Invoice Discount Amount"(Control 33).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ValidateInvoiceDiscountAmount;
        DocumentTotals.PurchaseDocTotalsNotUpToDate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        PurchaseHeader.GET("Document Type","Document No.");
        PurchCalcDiscByType.ApplyInvDiscBasedOnAmt(TotalPurchaseLine."Inv. Discount Amount",PurchaseHeader);
        CurrPage.UPDATE(FALSE);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Discount Amount"(Control 33)".


        //Unsupported feature: Property Deletion (CaptionClass) on ""Invoice Discount Amount"(Control 33)".

        // modify("Invoice Disc. Pct.")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Disc. Pct."(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Amount Excl. VAT"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total VAT Amount"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Amount Incl. VAT"(Control 7)".

        addafter(Type)
        {
            field("Expense Code"; Rec."Expense Code")
            {
                ApplicationArea = Basic;
            }
        }
        moveafter("Unit Price (LCY)"; "Line Amount")
        moveafter(Control31; "Invoice Discount Amount")
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
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify(ItemChargeAssignment)
        {

            //Unsupported feature: Property Modification (Name) on "ItemChargeAssignment(Action 1907184504)".

            ApplicationArea = Basic;
        }
        modify("Item Tracking Lines")
        {

            //Unsupported feature: Property Modification (Name) on ""Item Tracking Lines"(Action 1905987604)".

            ApplicationArea = Basic;
        }
        modify(SelectMultiItems)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""E&xplode BOM"(Action 1901991404)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Insert &Ext. Texts"(Action 1900295904)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Event(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Period(Action 1900609704)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Variant(Action 1904945204)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Location(Action 1902740304)".


        //Unsupported feature: Property Deletion (AccessByPermission) on ""BOM Level"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BOM Level"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1901033504)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 1901288104)".



        //Unsupported feature: Code Modification on "ItemChargeAssignment(Action 1907184504).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShowItemChargeAssgnt;
        SetItemChargeFieldsStyle;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ItemChargeAssgnt;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ItemChargeAssignment(Action 1907184504)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item Tracking Lines"(Action 1905987604)".

        modify(DocAttach)
        {
            Visible = false;
        }
    }

    var
        PurchaseHeader: Record "Purchase Header";


    //Unsupported feature: Property Modification (Id) on "TotalPurchaseHeader(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //TotalPurchaseHeader : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TotalPurchaseHeader : 1013;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "TotalPurchaseLine(Variable 1001)".

    //var
    //>>>> ORIGINAL VALUE:
    //TotalPurchaseLine : 1001;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TotalPurchaseLine : 1012;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "TransferExtendedText(Variable 1006)".

    //var
    //>>>> ORIGINAL VALUE:
    //TransferExtendedText : 1006;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //TransferExtendedText : 1002;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ItemAvailFormsMgt(Variable 1007)".

    //var
    //>>>> ORIGINAL VALUE:
    //ItemAvailFormsMgt : 1007;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ItemAvailFormsMgt : 1004;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "PurchCalcDiscByType(Variable 1009)".

    //var
    //>>>> ORIGINAL VALUE:
    //PurchCalcDiscByType : 1009;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //PurchCalcDiscByType : 1016;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "DocumentTotals(Variable 1010)".

    //var
    //>>>> ORIGINAL VALUE:
    //DocumentTotals : 1010;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //DocumentTotals : 1015;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "ShortcutDimCode(Variable 1011)".

    //var
    //>>>> ORIGINAL VALUE:
    //ShortcutDimCode : 1011;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //ShortcutDimCode : 1003;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "VATAmount(Variable 1012)".

    //var
    //>>>> ORIGINAL VALUE:
    //VATAmount : 1012;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //VATAmount : 1011;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "InvDiscAmountEditable(Variable 1018)".

    //var
    //>>>> ORIGINAL VALUE:
    //InvDiscAmountEditable : 1018;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //InvDiscAmountEditable : 1010;
    //Variable type has not been exported.

    var
        PurchHeader: Record "Purchase Header";

    var
        UpdateAllowedVar: Boolean;
        Text000: label 'Unable to run this function while in View mode.';

    var
        TotalAmountStyle: Text;
        RefreshMessageEnabled: Boolean;
        RefreshMessageText: Text;


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    GetTotalsPurchaseHeader;
    CalculateTotals;
    UpdateEditableOnRow;
    UpdateTypeText;
    SetItemChargeFieldsStyle;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF PurchHeader.GET("Document Type","Document No.") THEN;

    DocumentTotals.PurchaseUpdateTotalsControls(Rec,TotalPurchaseHeader,TotalPurchaseLine,RefreshMessageEnabled,
      TotalAmountStyle,RefreshMessageText,InvDiscAmountEditable,VATAmount);
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
      IF NOT ReservePurchLine.DeleteLineConfirm(Rec) THEN
        EXIT(FALSE);
      ReservePurchLine.DeleteLine(Rec);
    END;
    DocumentTotals.PurchaseDocTotalsNotUpToDate;
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

    //Unsupported feature: Property Deletion (Attributes) on "ApproveCalcInvDisc(PROCEDURE 6)".



    //Unsupported feature: Code Modification on "ApproveCalcInvDisc(PROCEDURE 6)".

    //procedure ApproveCalcInvDisc();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)",Rec);
    DocumentTotals.PurchaseDocTotalsNotUpToDate;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)",Rec);
    */
    //end;


    //Unsupported feature: Code Modification on "ExplodeBOM(PROCEDURE 3)".

    //procedure ExplodeBOM();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF "Prepmt. Amt. Inv." <> 0 THEN
      ERROR(CannotUseBOMErr);
    CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM",Rec);
    DocumentTotals.PurchaseDocTotalsNotUpToDate;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM",Rec);
    */
    //end;


    //Unsupported feature: Code Modification on "InsertExtendedText(PROCEDURE 5)".

    //procedure InsertExtendedText();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OnBeforeInsertExtendedText(Rec);
    IF TransferExtendedText.PurchCheckIfAnyExtText(Rec,Unconditionally) THEN BEGIN
      CurrPage.SAVERECORD;
      TransferExtendedText.InsertPurchExtText(Rec);
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


    //Unsupported feature: Property Modification (Name) on "DeltaUpdateTotals(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "DeltaUpdateTotals(PROCEDURE 1)".

    //procedure DeltaUpdateTotals();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    DocumentTotals.PurchaseDeltaUpdateTotals(Rec,xRec,TotalPurchaseLine,VATAmount,InvoiceDiscountAmount,InvoiceDiscountPct);
    IF "Line Amount" <> xRec."Line Amount" THEN
      SendLineInvoiceDiscountResetNotification;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount",Rec);
    */
    //end;

    //Unsupported feature: Property Modification (Name) on "UpdateEditableOnRow(PROCEDURE 4)".



    //Unsupported feature: Code Modification on "UpdateEditableOnRow(PROCEDURE 4)".

    //procedure UpdateEditableOnRow();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsCommentLine := Type = Type::" ";
    UnitofMeasureCodeIsChangeable := NOT IsCommentLine;

    CurrPageIsEditable := CurrPage.EDITABLE;
    InvDiscAmountEditable := CurrPageIsEditable AND NOT PurchasesPayablesSetup."Calc. Inv. Discount";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    ShowLineComments;
    */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: UpdateAllowed) (ParameterCollection) on "SetUpdateAllowed(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (Local) on "SetDimensionsVisibility(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Name) on "SetDimensionsVisibility(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "SetDimensionsVisibility(PROCEDURE 2)".

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
    UpdateAllowedVar := UpdateAllowed;
    */
    //end;

    local procedure ItemChargeAssgnt()
    begin
        Rec.ShowItemChargeAssgnt;
    end;

    local procedure OpenItemTrackingLines()
    begin
        Rec.OpenItemTrackingLines;
    end;

    local procedure UpdateAllowed(): Boolean
    begin
        if UpdateAllowedVar = false then begin
            Message(Text000);
            exit(false);
        end;
        exit(true);
    end;

    local procedure ShowPrices()
    var
        PurchHeader: Record "Purchase Header";
        PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
    begin
        PurchHeader.Get(Rec."Document Type", Rec."Document No.");
        Clear(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLinePrice(PurchHeader, Rec);
    end;

    local procedure ShowLineDisc()
    var
        PurchHeader: Record "Purchase Header";
        PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";
    begin
        PurchHeader.Get(Rec."Document Type", Rec."Document No.");
        Clear(PurchPriceCalcMgt);
        PurchPriceCalcMgt.GetPurchLineLineDisc(PurchHeader, Rec);
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(false);
        if (Rec.Type = Rec.Type::"Charge (Item)") and (Rec."No." <> xRec."No.") and
           (xRec."No." <> '')
        then
            CurrPage.SaveRecord;
    end;

    local procedure CrossReferenceNoOnAfterValidat()
    begin
        InsertExtendedText(false);
    end;

    local procedure RedistributeTotalsOnAfterValidate()
    begin
        CurrPage.SaveRecord;

        // PurchHeader.Get(Rec."Document Type",Rec."Document No.");
        // if DocumentTotals.PurchaseCheckNumberOfLinesLimit(PurchHeader) then
        //   DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec,VATAmount,TotalPurchaseLine);
        CurrPage.Update;
    end;

    //Unsupported feature: Deletion (VariableCollection) on "SetDimensionsVisibility(PROCEDURE 2).DimMgt(Variable 1000)".

}
