#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185788 pageextension52185788 extends "Blanket Sales Order Subform" 
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
        modify("Variant Code")
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
        modify("Qty. to Assemble to Order")
        {
            ApplicationArea = Basic;
        }
        modify("Work Type Code")
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
        modify(PriceExists)
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
        modify("Qty. to Ship")
        {
            ApplicationArea = Basic;
        }
        modify("Quantity Shipped")
        {
            ApplicationArea = Basic;
        }
        modify("Quantity Invoiced")
        {
            ApplicationArea = Basic;
        }
        modify("Shipment Date")
        {
            ApplicationArea = Basic;
        }
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
        modify(SubtotalExclVAT)
        {

            //Unsupported feature: Property Modification (Name) on "SubtotalExclVAT(Control 27)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "SubtotalExclVAT(Control 27)".


            //Unsupported feature: Property Insertion (DrillDown) on "SubtotalExclVAT(Control 27)".

            Enabled = RefreshMessageEnabled;
            ShowCaption = false;
        }
        modify("Invoice Discount Amount")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Invoice Discount Amount"(Control 48)".


            //Unsupported feature: Property Modification (AutoFormatExpr) on ""Invoice Discount Amount"(Control 48)".

            Style = Subordinate;
            StyleExpr = RefreshMessageEnabled;
        }
        // modify("Invoice Disc. Pct.")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (SourceExpr) on ""Invoice Disc. Pct."(Control 47)".

        //     Editable = false;

        //     //Unsupported feature: Property Insertion (Visible) on ""Invoice Disc. Pct."(Control 47)".

        //     Style = Subordinate;
        //     StyleExpr = RefreshMessageEnabled;
        // }
        modify("Total Amount Excl. VAT")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (AutoFormatExpr) on ""Total Amount Excl. VAT"(Control 33)".

            // CaptionClass = DocumentTotals.GetTotalExclVATCaption(SalesHeader."Currency Code");
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



        //Unsupported feature: Code Modification on ""No."(Control 4).OnValidate".

        //trigger "(Control 4)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ShowShortcutDimCode(ShortcutDimCode);
            NoOnAfterValidate;
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



        //Unsupported feature: Code Modification on ""Cross-Reference No."(Control 26).OnLookup".

        //trigger "(Control 26)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CrossReferenceNoLookUp;
            InsertExtendedText(FALSE);
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


        //Unsupported feature: Code Modification on ""Cross-Reference No."(Control 26).OnValidate".

        //trigger "(Control 26)()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CrossReferenceNoOnAfterValidat;
            DeltaUpdateTotals;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CrossReferenceNoOnAfterValidat;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Cross-Reference No."(Control 26)".



        //Unsupported feature: Code Modification on ""Variant Code"(Control 22).OnValidate".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 22)".



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

        modify(Description)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".



        //Unsupported feature: Code Modification on ""Location Code"(Control 36).OnValidate".

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
            LocationCodeOnAfterValidate
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 36)".



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


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Assemble to Order"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Type Code"(Control 42)".



        //Unsupported feature: Code Modification on ""Unit of Measure Code"(Control 10).OnValidate".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost (LCY)"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PriceExists(Control 30)".



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



        //Unsupported feature: Code Modification on ""Line Amount"(Control 28).OnValidate".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Amount"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on "LineDiscExists(Control 40)".



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

        modify("Allow Invoice Disc.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Invoice Disc."(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Ship"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity Shipped"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity Invoiced"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Date"(Control 90)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 34)".



        //Unsupported feature: Code Modification on ""ShortcutDimCode[3]"(Control 300).OnValidate".

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


        //Unsupported feature: Code Modification on ""ShortcutDimCode[4]"(Control 302).OnValidate".

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


        //Unsupported feature: Code Modification on ""ShortcutDimCode[5]"(Control 304).OnValidate".

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


        //Unsupported feature: Code Modification on ""ShortcutDimCode[6]"(Control 306).OnValidate".

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


        //Unsupported feature: Code Modification on ""ShortcutDimCode[7]"(Control 308).OnValidate".

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


        //Unsupported feature: Code Modification on ""ShortcutDimCode[8]"(Control 310).OnValidate".

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


        //Unsupported feature: Code Insertion on "RefreshTotals(Control 27)".

        //trigger OnDrillDown()
        //begin
            /*
            DocumentTotals.SalesRedistributeInvoiceDiscountAmounts(Rec,VATAmount,TotalSalesLine);
            CurrPage.UPDATE(FALSE);
            */
        //end;

        //Unsupported feature: Property Deletion (CaptionML) on "SubtotalExclVAT(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SubtotalExclVAT(Control 27)".


        //Unsupported feature: Property Deletion (AutoFormatType) on "SubtotalExclVAT(Control 27)".


        //Unsupported feature: Property Deletion (AutoFormatExpr) on "SubtotalExclVAT(Control 27)".


        //Unsupported feature: Property Deletion (CaptionClass) on "SubtotalExclVAT(Control 27)".



        //Unsupported feature: Code Insertion (VariableCollection) on ""Invoice Discount Amount"(Control 48).OnValidate".

        //trigger (Variable: SalesHeader)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Invoice Discount Amount"(Control 48).OnValidate".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Discount Amount"(Control 48)".


        //Unsupported feature: Property Deletion (CaptionClass) on ""Invoice Discount Amount"(Control 48)".

        modify("Invoice Disc. Pct.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Disc. Pct."(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Amount Excl. VAT"(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total VAT Amount"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Amount Incl. VAT"(Control 29)".

        moveafter("Unit Price";"Line Amount")
        moveafter(Control49;"Invoice Discount Amount")
    }
    actions
    {
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
        modify(Orders)
        {
            ApplicationArea = Basic;
        }
        modify(Invoices)
        {
            ApplicationArea = Basic;
        }
        modify("Return Orders")
        {
            ApplicationArea = Basic;
        }
        modify("Credit Memos")
        {
            ApplicationArea = Basic;
        }
        modify(Shipments)
        {
            ApplicationArea = Basic;
        }
        modify(Action1901092104)
        {
            ApplicationArea = Basic;
        }
        modify("Return Receipts")
        {
            ApplicationArea = Basic;
        }
        modify(Action1901033504)
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
        // modify("Get &Price")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Get Li&ne Discount")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("E&xplode BOM")
        {
            ApplicationArea = Basic;
        }
        modify("Insert &Ext. Texts")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Event(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Period(Action 1900544904)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Variant(Action 1901991304)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Location(Action 1901652204)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BOM Level"(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Orders(Action 1907075804)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Invoices(Action 1900639404)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Return Orders"(Action 1906421304)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Credit Memos"(Action 1900609704)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Shipments(Action 1904945204)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Action1901092104(Action 1901092104)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Return Receipts"(Action 1903984904)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Action1901033504(Action 1901033504)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1900186704)".

        modify(DocAttach)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 1900978604)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assemble-to-Order Lines"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Roll Up &Price"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Roll Up &Cost"(Action 9)".

        modify(DocumentLineTracking)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Get &Price"(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Get Li&ne Discount"(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E&xplode BOM"(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Insert &Ext. Texts"(Action 11)".

    }

    var
        SalesHeader: Record "Sales Header";


    //Unsupported feature: Property Modification (Id) on "CurrentSalesLine(Variable 1005)".

    //var
        //>>>> ORIGINAL VALUE:
        //CurrentSalesLine : 1005;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CurrentSalesLine : 1001;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "SalesLine(Variable 1001)".

    //var
        //>>>> ORIGINAL VALUE:
        //SalesLine : 1001;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //SalesLine : 1005;
        //Variable type has not been exported.

    var
        SalesCalcDiscByType: Codeunit "Sales - Calc Discount By Type";

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
        UpdateEditableOnRow;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF SalesHeader.GET("Document Type","Document No.") THEN;

        DocumentTotals.SalesUpdateTotalsControls(Rec,TotalSalesHeader,TotalSalesLine,RefreshMessageEnabled,
          TotalAmountStyle,RefreshMessageText,InvDiscAmountEditable,CurrPage.EDITABLE,VATAmount);
        */
    //end;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ShowShortcutDimCode(ShortcutDimCode);
        CLEAR(DocumentTotals);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ShowShortcutDimCode(ShortcutDimCode);
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "ApproveCalcInvDisc(PROCEDURE 6)".



    //Unsupported feature: Code Modification on "ApproveCalcInvDisc(PROCEDURE 6)".

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

    //Unsupported feature: Property Deletion (Attributes) on "InsertExtendedText(PROCEDURE 5)".


    //Unsupported feature: Property Insertion (Local) on "InsertExtendedText(PROCEDURE 5)".



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

    //Unsupported feature: Property Deletion (Attributes) on "UpdateForm(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Name) on "DeltaUpdateTotals(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "DeltaUpdateTotals(PROCEDURE 1)".

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
        CODEUNIT.RUN(CODEUNIT::"Sales-Calc. Discount",Rec);
        */
    //end;

    //Unsupported feature: Property Modification (Name) on "UpdateEditableOnRow(PROCEDURE 8)".



    //Unsupported feature: Code Modification on "UpdateEditableOnRow(PROCEDURE 8)".

    //procedure UpdateEditableOnRow();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        InvDiscAmountEditable := CurrPage.EDITABLE AND NOT SalesReceivablesSetup."Calc. Inv. Discount";
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
}
