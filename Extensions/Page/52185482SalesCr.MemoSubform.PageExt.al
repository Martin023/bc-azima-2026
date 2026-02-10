// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52185482 pageextension52185482 extends "Sales Cr. Memo Subform"
// {
//     layout
//     {
//         modify(Type)
//         {
//             ApplicationArea = Basic;
//         }
//         // modify(FilteredTypeField)
//         // {

//         //     //Unsupported feature: Property Modification (Level) on "FilteredTypeField(Control 9)".


//         //     //Unsupported feature: Property Modification (Name) on "FilteredTypeField(Control 9)".

//         //     ApplicationArea = Basic;

//         //     //Unsupported feature: Property Modification (SourceExpr) on "FilteredTypeField(Control 9)".

//         //     Editable = false;

//         //     //Unsupported feature: Property Insertion (DrillDown) on "FilteredTypeField(Control 9)".

//         //     Enabled = RefreshMessageEnabled;
//         //     ShowCaption = false;
//         // }
//         modify("No.")
//         {
//             ApplicationArea = Basic;
//             ShowMandatory = TypeChosen;
//         }
//         modify("Cross-Reference No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("IC Partner Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("IC Partner Ref. Type")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("IC Partner Reference")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Variant Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Nonstock)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("VAT Prod. Posting Group")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Description)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Return Reason Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Location Code")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Insertion (Visible) on ""Location Code"(Control 72)".

//         }
//         modify("Bin Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Reserve)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Quantity)
//         {
//             ApplicationArea = Basic;
//             ShowMandatory = TypeChosen;
//         }
//         modify("Reserved Quantity")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Unit of Measure Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Unit of Measure")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Unit Cost (LCY)")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Unit Price")
//         {
//             ApplicationArea = Basic;
//             ShowMandatory = TypeChosen;
//         }
//         modify("Line Amount")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Line Discount %")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Line Discount Amount")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Allow Invoice Disc.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Inv. Discount Amount")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Allow Item Charge Assignment")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Qty. to Assign")
//         {
//             ApplicationArea = Basic;
//             BlankZero = true;
//         }
//         modify("Qty. Assigned")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Job No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Job Task No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Tax Category")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Work Type Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Blanket Order No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Blanket Order Line No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Appl.-from Item Entry")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Appl.-to Item Entry")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Deferral Code")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Insertion (TableRelation) on ""Deferral Code"(Control 23)".

//             Enabled = (Type <> Type::"Fixed Asset") and (Type <> Type::" ");
//         }
//         modify("Shortcut Dimension 1 Code")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 1 Code"(Control 76)".

//         }
//         modify("Shortcut Dimension 2 Code")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 2 Code"(Control 74)".

//         }
//         modify(ShortcutDimCode3)
//         {

//             //Unsupported feature: Property Modification (Name) on "ShortcutDimCode3(Control 300)".

//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Visible) on "ShortcutDimCode3(Control 300)".

//         }
//         modify(ShortcutDimCode4)
//         {

//             //Unsupported feature: Property Modification (Name) on "ShortcutDimCode4(Control 302)".

//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Visible) on "ShortcutDimCode4(Control 302)".

//         }
//         modify(ShortcutDimCode5)
//         {

//             //Unsupported feature: Property Modification (Name) on "ShortcutDimCode5(Control 304)".

//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Visible) on "ShortcutDimCode5(Control 304)".

//         }
//         modify(ShortcutDimCode6)
//         {

//             //Unsupported feature: Property Modification (Name) on "ShortcutDimCode6(Control 306)".

//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Visible) on "ShortcutDimCode6(Control 306)".

//         }
//         modify(ShortcutDimCode7)
//         {

//             //Unsupported feature: Property Modification (Name) on "ShortcutDimCode7(Control 308)".

//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Visible) on "ShortcutDimCode7(Control 308)".

//         }
//         modify(ShortcutDimCode8)
//         {

//             //Unsupported feature: Property Modification (Name) on "ShortcutDimCode8(Control 310)".

//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Visible) on "ShortcutDimCode8(Control 310)".

//         }
//         modify("Invoice Discount Amount")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on ""Invoice Discount Amount"(Control 33)".


//             //Unsupported feature: Property Modification (AutoFormatExpr) on ""Invoice Discount Amount"(Control 33)".

//             Style = Subordinate;
//             StyleExpr = RefreshMessageEnabled;
//         }
//         modify("Invoice Disc. Pct.")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (DecimalPlaces) on ""Invoice Disc. Pct."(Control 31)".


//             //Unsupported feature: Property Modification (SourceExpr) on ""Invoice Disc. Pct."(Control 31)".

//             Editable = false;

//             //Unsupported feature: Property Insertion (Visible) on ""Invoice Disc. Pct."(Control 31)".

//             Style = Subordinate;
//             StyleExpr = RefreshMessageEnabled;
//         }
//         modify("Total Amount Excl. VAT")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (AutoFormatExpr) on ""Total Amount Excl. VAT"(Control 15)".

//             CaptionClass = DocumentTotals.GetTotalExclVATCaption(SalesHeader."Currency Code");
//             Style = Subordinate;
//             StyleExpr = RefreshMessageEnabled;
//         }
//         modify("Total VAT Amount")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (AutoFormatExpr) on ""Total VAT Amount"(Control 13)".

//             CaptionClass = DocumentTotals.GetTotalVATCaption(SalesHeader."Currency Code");
//             Style = Subordinate;
//             StyleExpr = RefreshMessageEnabled;
//         }
//         modify("Total Amount Incl. VAT")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (AutoFormatExpr) on ""Total Amount Incl. VAT"(Control 11)".

//             CaptionClass = DocumentTotals.GetTotalInclVATCaption(SalesHeader."Currency Code");
//             StyleExpr = TotalAmountStyle;
//         }

//         //Unsupported feature: Code Modification on "Type(Control 2).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         NoOnAfterValidate;
//         UpdateEditableOnRow;
//         UpdateTypeText;
//         DeltaUpdateTotals;
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         NoOnAfterValidate;
//         TypeChosen := HasTypeToFillMandatotyFields;

//         IF xRec."No." <> '' THEN
//           RedistributeTotalsOnAfterValidate;
//         */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 2)".



//         //Unsupported feature: Code Insertion on "RefreshTotals(Control 9)".

//         //trigger OnDrillDown()
//         //begin
//         /*
//         DocumentTotals.SalesRedistributeInvoiceDiscountAmounts(Rec,VATAmount,TotalSalesLine);
//         CurrPage.UPDATE(FALSE);
//         */
//         //end;
//         modify(FilteredTypeField)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (CaptionML) on "FilteredTypeField(Control 9)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "FilteredTypeField(Control 9)".


//         //Unsupported feature: Property Deletion (TableRelation) on "FilteredTypeField(Control 9)".


//         //Unsupported feature: Property Deletion (Visible) on "FilteredTypeField(Control 9)".


//         //Unsupported feature: Property Deletion (LookupPageID) on "FilteredTypeField(Control 9)".



//         //Unsupported feature: Code Modification on ""No."(Control 4).OnValidate".

//         //trigger "(Control 4)()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         ShowShortcutDimCode(ShortcutDimCode);
//         NoOnAfterValidate;
//         UpdateEditableOnRow;
//         UpdateTypeText;
//         DeltaUpdateTotals;
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         ShowShortcutDimCode(ShortcutDimCode);
//         NoOnAfterValidate;

//         IF xRec."No." <> '' THEN
//           RedistributeTotalsOnAfterValidate;
//         */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 4)".



//         //Unsupported feature: Code Modification on ""Cross-Reference No."(Control 34).OnLookup".

//         //trigger "(Control 34)()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         CrossReferenceNoLookUp;
//         InsertExtendedText(FALSE);
//         NoOnAfterValidate;
//         UpdateEditableOnRow;
//         OnCrossReferenceNoOnLookup(Rec);
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         #1..3
//         */
//         //end;


//         //Unsupported feature: Code Modification on ""Cross-Reference No."(Control 34).OnValidate".

//         //trigger "(Control 34)()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         CrossReferenceNoOnAfterValidat;
//         NoOnAfterValidate;
//         UpdateEditableOnRow;
//         DeltaUpdateTotals;
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         CrossReferenceNoOnAfterValidat;
//         NoOnAfterValidate;
//         */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Cross-Reference No."(Control 34)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""IC Partner Code"(Control 46)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""IC Partner Ref. Type"(Control 40)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""IC Partner Reference"(Control 42)".

//         modify("Variant Code")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 18)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Nonstock(Control 38)".



//         //Unsupported feature: Code Modification on ""VAT Prod. Posting Group"(Control 58).OnValidate".

//         //trigger  Posting Group"(Control 58)()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         DeltaUpdateTotals;
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         RedistributeTotalsOnAfterValidate;
//         */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Prod. Posting Group"(Control 58)".

//         modify(Description)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


//         //Unsupported feature: Property Deletion (ShowMandatory) on "Description(Control 6)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Return Reason Code"(Control 24)".

//         modify("Location Code")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 72)".


//         //Unsupported feature: Property Deletion (Enabled) on ""Location Code"(Control 72)".


//         //Unsupported feature: Property Deletion (Editable) on ""Location Code"(Control 72)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 50)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Reserve(Control 28)".



//         //Unsupported feature: Code Modification on "Quantity(Control 8).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         QuantityOnAfterValidate;
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         QuantityOnAfterValidate;
//         RedistributeTotalsOnAfterValidate;
//         */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 8)".


//         //Unsupported feature: Property Deletion (Enabled) on "Quantity(Control 8)".


//         //Unsupported feature: Property Deletion (Editable) on "Quantity(Control 8)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Reserved Quantity"(Control 26)".



//         //Unsupported feature: Code Modification on ""Unit of Measure Code"(Control 22).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         UnitofMeasureCodeOnAfterValida;
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         UnitofMeasureCodeOnAfterValida;
//         RedistributeTotalsOnAfterValidate;
//         */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 22)".


//         //Unsupported feature: Property Deletion (Enabled) on ""Unit of Measure Code"(Control 22)".


//         //Unsupported feature: Property Deletion (Editable) on ""Unit of Measure Code"(Control 22)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure"(Control 10)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost (LCY)"(Control 70)".



//         //Unsupported feature: Code Modification on ""Unit Price"(Control 12).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         DeltaUpdateTotals;
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         RedistributeTotalsOnAfterValidate;
//         */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Price"(Control 12)".


//         //Unsupported feature: Property Deletion (Enabled) on ""Unit Price"(Control 12)".


//         //Unsupported feature: Property Deletion (Editable) on ""Unit Price"(Control 12)".



//         //Unsupported feature: Code Modification on ""Line Amount"(Control 92).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         DeltaUpdateTotals;
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         RedistributeTotalsOnAfterValidate;
//         */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Line Amount"(Control 92)".


//         //Unsupported feature: Property Deletion (BlankZero) on ""Line Amount"(Control 92)".


//         //Unsupported feature: Property Deletion (Enabled) on ""Line Amount"(Control 92)".


//         //Unsupported feature: Property Deletion (Editable) on ""Line Amount"(Control 92)".


//         //Unsupported feature: Property Deletion (ShowMandatory) on ""Line Amount"(Control 92)".



//         //Unsupported feature: Code Modification on ""Line Discount %"(Control 16).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         DeltaUpdateTotals;
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         RedistributeTotalsOnAfterValidate;
//         */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount %"(Control 16)".


//         //Unsupported feature: Property Deletion (Enabled) on ""Line Discount %"(Control 16)".


//         //Unsupported feature: Property Deletion (Editable) on ""Line Discount %"(Control 16)".



//         //Unsupported feature: Code Modification on ""Line Discount Amount"(Control 56).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         DeltaUpdateTotals;
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         RedistributeTotalsOnAfterValidate;
//         */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount Amount"(Control 56)".

//         modify("Allow Invoice Disc.")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Invoice Disc."(Control 54)".

//         modify("Inv. Discount Amount")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Inv. Discount Amount"(Control 20)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Item Charge Assignment"(Control 14)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Assign"(Control 52)".


//         //Unsupported feature: Property Deletion (StyleExpr) on ""Qty. to Assign"(Control 52)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Assigned"(Control 60)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Job No."(Control 44)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Job Task No."(Control 3)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Tax Category"(Control 21)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Work Type Code"(Control 62)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Order No."(Control 30)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Order Line No."(Control 32)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-from Item Entry"(Control 5810)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-to Item Entry"(Control 48)".

//         modify("Deferral Code")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Deferral Code"(Control 23)".


//         //Unsupported feature: Property Deletion (Visible) on ""Deferral Code"(Control 23)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 76)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 74)".



//         //Unsupported feature: Code Modification on "ShortcutDimCode3(Control 300).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         ValidateShortcutDimCode(3,ShortcutDimCode[3]);

//         OnAfterValidateShortcutDimCode(Rec,ShortcutDimCode,3);
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         ValidateShortcutDimCode(3,ShortcutDimCode[3]);
//         */
//         //end;


//         //Unsupported feature: Code Modification on "ShortcutDimCode4(Control 302).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         ValidateShortcutDimCode(4,ShortcutDimCode[4]);

//         OnAfterValidateShortcutDimCode(Rec,ShortcutDimCode,4);
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         ValidateShortcutDimCode(4,ShortcutDimCode[4]);
//         */
//         //end;


//         //Unsupported feature: Code Modification on "ShortcutDimCode5(Control 304).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         ValidateShortcutDimCode(5,ShortcutDimCode[5]);

//         OnAfterValidateShortcutDimCode(Rec,ShortcutDimCode,5);
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         ValidateShortcutDimCode(5,ShortcutDimCode[5]);
//         */
//         //end;


//         //Unsupported feature: Code Modification on "ShortcutDimCode6(Control 306).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         ValidateShortcutDimCode(6,ShortcutDimCode[6]);

//         OnAfterValidateShortcutDimCode(Rec,ShortcutDimCode,6);
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         ValidateShortcutDimCode(6,ShortcutDimCode[6]);
//         */
//         //end;


//         //Unsupported feature: Code Modification on "ShortcutDimCode7(Control 308).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         ValidateShortcutDimCode(7,ShortcutDimCode[7]);

//         OnAfterValidateShortcutDimCode(Rec,ShortcutDimCode,7);
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         ValidateShortcutDimCode(7,ShortcutDimCode[7]);
//         */
//         //end;


//         //Unsupported feature: Code Modification on "ShortcutDimCode8(Control 310).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         ValidateShortcutDimCode(8,ShortcutDimCode[8]);

//         OnAfterValidateShortcutDimCode(Rec,ShortcutDimCode,8);
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         ValidateShortcutDimCode(8,ShortcutDimCode[8]);
//         */
//         //end;
//         modify("TotalSalesLine.""Line Amount""")
//         {
//             Visible = false;
//         }


//         //Unsupported feature: Code Modification on ""Invoice Discount Amount"(Control 33).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         DocumentTotals.SalesDocTotalsNotUpToDate;
//         ValidateInvoiceDiscountAmount;
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         SalesHeader.GET("Document Type","Document No.");
//         SalesCalcDiscByType.ApplyInvDiscBasedOnAmt(TotalSalesLine."Inv. Discount Amount",SalesHeader);
//         CurrPage.UPDATE(FALSE);
//         */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Discount Amount"(Control 33)".


//         //Unsupported feature: Property Deletion (CaptionClass) on ""Invoice Discount Amount"(Control 33)".

//         modify("Invoice Disc. Pct.")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Disc. Pct."(Control 31)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Total Amount Excl. VAT"(Control 15)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Total VAT Amount"(Control 13)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Total Amount Incl. VAT"(Control 11)".

//         moveafter(Type; "No.")
//     }
//     actions
//     {
//         modify(InsertExtTexts)
//         {

//             //Unsupported feature: Property Modification (Level) on "InsertExtTexts(Action 1902056104)".


//             //Unsupported feature: Property Modification (Name) on "InsertExtTexts(Action 1902056104)".

//             ApplicationArea = Basic;
//         }
//         modify(Dimensions)
//         {

//             //Unsupported feature: Property Modification (Level) on "Dimensions(Action 1902740304)".

//             ApplicationArea = Basic;
//         }
//         modify(DeferralSchedule)
//         {

//             //Unsupported feature: Property Modification (Level) on "DeferralSchedule(Action 19)".

//             ApplicationArea = Basic;
//         }
//         modify("E&xplode BOM")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Get Return &Receipt Lines")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Event")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Period)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Variant)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Location)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("BOM Level")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Co&mments")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Item Charge &Assignment")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(ItemTrackingLines)
//         {
//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "InsertExtTexts(Action 1902056104)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1902740304)".



//         //Unsupported feature: Code Modification on "DeferralSchedule(Action 19).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         ShowDeferralSchedule;
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         SalesHeader.GET("Document Type","Document No.");
//         ShowDeferrals(SalesHeader."Posting Date",SalesHeader."Currency Code");
//         */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "DeferralSchedule(Action 19)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""E&xplode BOM"(Action 1904522204)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Get Return &Receipt Lines"(Action 1901991804)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Event(Action 5)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Period(Action 1903587104)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Variant(Action 1903193004)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Location(Action 1901743104)".


//         //Unsupported feature: Property Deletion (AccessByPermission) on ""BOM Level"(Action 7)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""BOM Level"(Action 7)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 1907838004)".



//         //Unsupported feature: Code Modification on ""Item Charge &Assignment"(Action 1907184504).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         ItemChargeAssgnt;
//         SetItemChargeFieldsStyle
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         ItemChargeAssgnt;
//         */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Item Charge &Assignment"(Action 1907184504)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "ItemTrackingLines(Action 1905987604)".

//         modify(DocAttach)
//         {
//             Visible = false;
//         }
//         moveafter(ActionContainer1900000004; "F&unctions")
//         moveafter("Insert &Ext. Texts"; "Get Return &Receipt Lines")
//         moveafter(Dimensions; "Co&mments")
//     }

//     var
//         SalesHeader: Record "Sales Header";

//     var
//         SalesCalcDiscByType: Codeunit "Sales - Calc Discount By Type";

//     var
//         TotalAmountStyle: Text;
//         RefreshMessageEnabled: Boolean;
//         RefreshMessageText: Text;
//         TypeChosen: Boolean;


//     //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

//     //trigger OnAfterGetCurrRecord()
//     //>>>> ORIGINAL CODE:
//     //begin
//     /*
//     GetTotalSalesHeader;
//     CalculateTotals;
//     UpdateEditableOnRow;
//     UpdateTypeText;
//     SetItemChargeFieldsStyle;
//     */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//     /*
//     IF SalesHeader.GET("Document Type","Document No.") THEN;

//     DocumentTotals.SalesUpdateTotalsControls(Rec,TotalSalesHeader,TotalSalesLine,RefreshMessageEnabled,
//       TotalAmountStyle,RefreshMessageText,InvDiscAmountEditable,CurrPage.EDITABLE,VATAmount);

//     TypeChosen := HasTypeToFillMandatotyFields;
//     */
//     //end;


//     //Unsupported feature: Code Modification on "OnAfterGetRecord".

//     //trigger OnAfterGetRecord()
//     //>>>> ORIGINAL CODE:
//     //begin
//     /*
//     ShowShortcutDimCode(ShortcutDimCode);
//     UpdateTypeText;
//     SetItemChargeFieldsStyle
//     */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//     /*
//     ShowShortcutDimCode(ShortcutDimCode);
//     */
//     //end;


//     //Unsupported feature: Code Modification on "OnDeleteRecord".

//     //trigger OnDeleteRecord(): Boolean
//     //>>>> ORIGINAL CODE:
//     //begin
//     /*
//     IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
//       COMMIT;
//       IF NOT ReserveSalesLine.DeleteLineConfirm(Rec) THEN
//         EXIT(FALSE);
//       ReserveSalesLine.DeleteLine(Rec);
//     END;
//     DocumentTotals.SalesDocTotalsNotUpToDate;
//     */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//     /*
//     #1..6
//     */
//     //end;


//     //Unsupported feature: Code Modification on "OnNewRecord".

//     //trigger OnNewRecord(BelowxRec: Boolean)
//     //>>>> ORIGINAL CODE:
//     //begin
//     /*
//     InitType;

//     // Default to Inventory for the first line and to previous line type for the others
//     IF ApplicationAreaMgmtFacade.IsFoundationEnabled THEN
//       IF xRec."Document No." = '' THEN
//         Type := Type::Item;

//     CLEAR(ShortcutDimCode);
//     UpdateTypeText;
//     */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//     /*
//     InitType;
//     CLEAR(ShortcutDimCode);
//     */
//     //end;

//     //Unsupported feature: Property Deletion (Attributes) on "ApproveCalcInvDisc(PROCEDURE 1)".



//     //Unsupported feature: Code Modification on "ApproveCalcInvDisc(PROCEDURE 1)".

//     //procedure ApproveCalcInvDisc();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//     /*
//     CODEUNIT.RUN(CODEUNIT::"Sales-Disc. (Yes/No)",Rec);
//     DocumentTotals.SalesDocTotalsNotUpToDate;
//     */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//     /*
//     CODEUNIT.RUN(CODEUNIT::"Sales-Disc. (Yes/No)",Rec);
//     */
//     //end;


//     //Unsupported feature: Code Modification on "ExplodeBOM(PROCEDURE 3)".

//     //procedure ExplodeBOM();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//     /*
//     CODEUNIT.RUN(CODEUNIT::"Sales-Explode BOM",Rec);
//     DocumentTotals.SalesDocTotalsNotUpToDate;
//     */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//     /*
//     CODEUNIT.RUN(CODEUNIT::"Sales-Explode BOM",Rec);
//     */
//     //end;


//     //Unsupported feature: Code Modification on "GetReturnReceipt(PROCEDURE 2)".

//     //procedure GetReturnReceipt();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//     /*
//     CODEUNIT.RUN(CODEUNIT::"Sales-Get Return Receipts",Rec);
//     DocumentTotals.SalesDocTotalsNotUpToDate;
//     */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//     /*
//     CODEUNIT.RUN(CODEUNIT::"Sales-Get Return Receipts",Rec);
//     */
//     //end;


//     //Unsupported feature: Code Modification on "InsertExtendedText(PROCEDURE 5)".

//     //procedure InsertExtendedText();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//     /*
//     OnBeforeInsertExtendedText(Rec);
//     IF TransferExtendedText.SalesCheckIfAnyExtText(Rec,Unconditionally) THEN BEGIN
//       CurrPage.SAVERECORD;
//       COMMIT;
//       TransferExtendedText.InsertSalesExtText(Rec);
//     END;
//     IF TransferExtendedText.MakeUpdate THEN
//       UpdateForm(TRUE);
//     */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//     /*
//     #2..8
//     */
//     //end;

//     //Unsupported feature: Property Deletion (Attributes) on "UpdateForm(PROCEDURE 12)".


//     local procedure NoOnAfterValidate()
//     begin
//         InsertExtendedText(false);
//         if (Rec.Type = Rec.Type::"Charge (Item)") and (Rec."No." <> xRec."No.") and
//            (xRec."No." <> '')
//         then
//             CurrPage.SaveRecord;
//     end;

//     local procedure CrossReferenceNoOnAfterValidat()
//     begin
//         InsertExtendedText(false);
//     end;

//     local procedure ReserveOnAfterValidate()
//     begin
//         if (Rec.Reserve = Rec.Reserve::Always) and (Rec."Outstanding Qty. (Base)" <> 0) then begin
//             CurrPage.SaveRecord;
//             Rec.AutoReserve;
//         end;
//     end;

//     local procedure QuantityOnAfterValidate()
//     begin
//         if Rec.Reserve = Rec.Reserve::Always then begin
//             CurrPage.SaveRecord;
//             Rec.AutoReserve;
//         end;
//     end;

//     local procedure UnitofMeasureCodeOnAfterValida()
//     begin
//         if Rec.Reserve = Rec.Reserve::Always then begin
//             CurrPage.SaveRecord;
//             Rec.AutoReserve;
//         end;
//     end;

//     local procedure RedistributeTotalsOnAfterValidate()
//     begin
//         CurrPage.SaveRecord;

//         SalesHeader.Get(Rec."Document Type", Rec."Document No.");
//         if DocumentTotals.SalesCheckNumberOfLinesLimit(SalesHeader) then
//             DocumentTotals.SalesRedistributeInvoiceDiscountAmounts(Rec, VATAmount, TotalSalesLine);
//         CurrPage.Update;
//     end;
// }
