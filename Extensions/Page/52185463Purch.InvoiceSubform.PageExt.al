// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185463 pageextension52185463 extends "Purch. Invoice Subform"
{
    layout
    {
        modify("Gen. Bus. Posting Group")
        {
            Visible = true;
        }
        modify("Gen. Prod. Posting Group")
        {
            ApplicationArea = Basic;
            Visible = true;
        }

        modify("Location Code")
        {
            Visible = true;
            ShowMandatory = true;
        }

        modify("Unit of Measure Code")
        {
            Visible = false;
        }

        modify("Matched Order Lines")
        {
            Visible = false;
        }

        modify("Tax Area Code")
        {
            Visible = false;
        }

        modify("Tax Group Code")
        {
            Visible = false;
        }

        modify("Qty. to Assign")
        {
            Visible = false;
        }

        modify("line Discount Amount")
        {
            Visible = false;
        }

        modify("Line Discount %")
        {
            Visible = false;
        }

    }
}

//         //Unsupported feature: Property Modification (Name) on "PurchDetailLine(Control 1)".

//         modify(Type)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(FilteredTypeField)
//         {

//             //Unsupported feature: Property Modification (Level) on "FilteredTypeField(Control 7)".


//             //Unsupported feature: Property Modification (Name) on "FilteredTypeField(Control 7)".

//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "FilteredTypeField(Control 7)".

//             Editable = false;

//             //Unsupported feature: Property Insertion (DrillDown) on "FilteredTypeField(Control 7)".

//             Enabled = RefreshMessageEnabled;
//             ShowCaption = false;
//         }
//         modify("No.")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on ""No."(Control 4)".


//             //Unsupported feature: Property Modification (Name) on ""No."(Control 4)".

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
//         }
//         modify("Bin Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Quantity)
//         {
//             ApplicationArea = Basic;
//             ShowMandatory = TypeChosen;
//         }
//         modify("Unit of Measure Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Unit of Measure")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Direct Unit Cost")
//         {
//             ApplicationArea = Basic;
//             ShowMandatory = TypeChosen;
//         }
//         modify("Indirect Cost %")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Unit Cost (LCY)")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Unit Price (LCY)")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Line Discount %")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Insertion (Visible) on ""Line Discount %"(Control 16)".

//         }
//         modify("Line Amount")
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
//         modify("Job Line Type")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Job Unit Price")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Job Line Amount")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Job Line Discount Amount")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Job Line Discount %")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Job Total Price")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Job Unit Price (LCY)")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Job Total Price (LCY)")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Job Line Amount (LCY)")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Job Line Disc. Amount (LCY)")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Prod. Order No.")
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
//         modify("Insurance No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Budgeted FA No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("FA Posting Type")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Depreciation Book Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Depr. until FA Posting Date")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Depr. Acquisition Cost")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Duplicate in Depreciation Book")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Use Duplication List")
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

//             //Unsupported feature: Property Modification (Visible) on ""Deferral Code"(Control 17)".

//         }
//         modify("Shortcut Dimension 1 Code")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 1 Code"(Control 62)".

//         }
//         modify("Shortcut Dimension 2 Code")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 2 Code"(Control 60)".

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
//         modify("Document No.")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on ""Document No."(Control 21)".


//             //Unsupported feature: Property Modification (Name) on ""Document No."(Control 21)".

//         }
//         modify("Line No.")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on ""Line No."(Control 23)".


//             //Unsupported feature: Property Modification (Name) on ""Line No."(Control 23)".

//             Caption = 'Detailed Description';
//         }
//         modify(AmountBeforeDiscount)
//         {

//             //Unsupported feature: Property Modification (Level) on "AmountBeforeDiscount(Control 25)".


//             //Unsupported feature: Property Modification (Name) on "AmountBeforeDiscount(Control 25)".

//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "AmountBeforeDiscount(Control 25)".

//             ShowMandatory = TypeChosen;
//         }
//         modify(InvoiceDiscountAmount)
//         {

//             //Unsupported feature: Property Modification (Name) on "InvoiceDiscountAmount(Control 31)".

//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (SourceExpr) on "InvoiceDiscountAmount(Control 31)".


//             //Unsupported feature: Property Modification (AutoFormatExpr) on "InvoiceDiscountAmount(Control 31)".

//             Style = Subordinate;
//             StyleExpr = RefreshMessageEnabled;
//         }
//         modify("Invoice Disc. Pct.")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (DecimalPlaces) on ""Invoice Disc. Pct."(Control 29)".


//             //Unsupported feature: Property Modification (SourceExpr) on ""Invoice Disc. Pct."(Control 29)".

//             Editable = false;

//             //Unsupported feature: Property Insertion (Visible) on ""Invoice Disc. Pct."(Control 29)".

//             Style = Subordinate;
//             StyleExpr = RefreshMessageEnabled;
//         }
//         modify("Total Amount Excl. VAT")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (AutoFormatExpr) on ""Total Amount Excl. VAT"(Control 13)".

//             CaptionClass = DocumentTotals.GetTotalExclVATCaption(PurchHeader."Currency Code");
//             Style = Subordinate;
//             StyleExpr = RefreshMessageEnabled;
//         }
//         modify("Total VAT Amount")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (AutoFormatExpr) on ""Total VAT Amount"(Control 11)".

//             CaptionClass = DocumentTotals.GetTotalVATCaption(PurchHeader."Currency Code");
//             Style = Subordinate;
//             StyleExpr = RefreshMessageEnabled;
//         }
//         modify("Total Amount Incl. VAT")
//         {

//             //Unsupported feature: Property Modification (Name) on ""Total Amount Incl. VAT"(Control 9)".

//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Code Modification on "Type(Control 2).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             NoOnAfterValidate;

//             UpdateEditableOnRow;
//             UpdateTypeText;
//             DeltaUpdateTotals;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             NoOnAfterValidate;
//             TypeChosen := HasTypeToFillMandatotyFields;

//             IF xRec."No." <> '' THEN
//               RedistributeTotalsOnAfterValidate;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 2)".



//         //Unsupported feature: Code Insertion on "RefreshTotals(Control 7)".

//         //trigger OnDrillDown()
//         //begin
//             /*
//             DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec,VATAmount,TotalPurchaseLine);
//             CurrPage.UPDATE(FALSE);
//             */
//         //end;
//         modify(FilteredTypeField)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (CaptionML) on "FilteredTypeField(Control 7)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "FilteredTypeField(Control 7)".


//         //Unsupported feature: Property Deletion (TableRelation) on "FilteredTypeField(Control 7)".


//         //Unsupported feature: Property Deletion (Visible) on "FilteredTypeField(Control 7)".


//         //Unsupported feature: Property Deletion (LookupPageID) on "FilteredTypeField(Control 7)".

//         modify("No.")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 4)".


//         //Unsupported feature: Property Deletion (ShowMandatory) on ""No."(Control 4)".

//         modify("Cross-Reference No.")
//         {
//             Visible = false;
//         }
//         modify("IC Partner Code")
//         {
//             Visible = false;
//         }
//         modify("IC Partner Ref. Type")
//         {
//             Visible = false;
//         }
//         modify("IC Partner Reference")
//         {
//             Visible = false;
//         }
//         modify("Variant Code")
//         {
//             Visible = false;
//         }
//         modify(Nonstock)
//         {
//             Visible = false;
//         }


//         //Unsupported feature: Code Modification on ""VAT Prod. Posting Group"(Control 14).OnValidate".

//         //trigger  Posting Group"(Control 14)()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             DeltaUpdateTotals;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             RedistributeTotalsOnAfterValidate;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Prod. Posting Group"(Control 14)".

//         modify(Description)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (CaptionML) on "Description(Control 6)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


//         //Unsupported feature: Property Deletion (ShowMandatory) on "Description(Control 6)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Return Reason Code"(Control 78)".

//         modify("Location Code")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 58)".


//         //Unsupported feature: Property Deletion (Enabled) on ""Location Code"(Control 58)".


//         //Unsupported feature: Property Deletion (Editable) on ""Location Code"(Control 58)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 80)".



//         //Unsupported feature: Code Modification on "Quantity(Control 8).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             DeltaUpdateTotals;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             RedistributeTotalsOnAfterValidate;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 8)".


//         //Unsupported feature: Property Deletion (Enabled) on "Quantity(Control 8)".


//         //Unsupported feature: Property Deletion (Editable) on "Quantity(Control 8)".



//         //Unsupported feature: Code Modification on ""Unit of Measure Code"(Control 34).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             DeltaUpdateTotals;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             RedistributeTotalsOnAfterValidate;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 34)".


//         //Unsupported feature: Property Deletion (Enabled) on ""Unit of Measure Code"(Control 34)".


//         //Unsupported feature: Property Deletion (Editable) on ""Unit of Measure Code"(Control 34)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure"(Control 10)".



//         //Unsupported feature: Code Modification on ""Direct Unit Cost"(Control 12).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             DeltaUpdateTotals;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             RedistributeTotalsOnAfterValidate;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Direct Unit Cost"(Control 12)".


//         //Unsupported feature: Property Deletion (Enabled) on ""Direct Unit Cost"(Control 12)".


//         //Unsupported feature: Property Deletion (Editable) on ""Direct Unit Cost"(Control 12)".



//         //Unsupported feature: Code Insertion on ""Indirect Cost %"(Control 68)".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //begin
//             /*
//             RedistributeTotalsOnAfterValidate;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Indirect Cost %"(Control 68)".



//         //Unsupported feature: Code Insertion on ""Unit Cost (LCY)"(Control 56)".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //begin
//             /*
//             RedistributeTotalsOnAfterValidate;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost (LCY)"(Control 56)".



//         //Unsupported feature: Code Insertion on ""Unit Price (LCY)"(Control 66)".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //begin
//             /*
//             RedistributeTotalsOnAfterValidate;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Price (LCY)"(Control 66)".



//         //Unsupported feature: Code Modification on ""Line Discount %"(Control 16).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             DeltaUpdateTotals;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             RedistributeTotalsOnAfterValidate;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount %"(Control 16)".


//         //Unsupported feature: Property Deletion (Enabled) on ""Line Discount %"(Control 16)".


//         //Unsupported feature: Property Deletion (Editable) on ""Line Discount %"(Control 16)".



//         //Unsupported feature: Code Modification on ""Line Amount"(Control 52).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             DeltaUpdateTotals;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             RedistributeTotalsOnAfterValidate;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Line Amount"(Control 52)".


//         //Unsupported feature: Property Deletion (Enabled) on ""Line Amount"(Control 52)".


//         //Unsupported feature: Property Deletion (Editable) on ""Line Amount"(Control 52)".


//         //Unsupported feature: Property Deletion (ShowMandatory) on ""Line Amount"(Control 52)".



//         //Unsupported feature: Code Modification on ""Line Discount Amount"(Control 48).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             DeltaUpdateTotals;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             RedistributeTotalsOnAfterValidate;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount Amount"(Control 48)".

//         modify("Allow Invoice Disc.")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Invoice Disc."(Control 46)".

//         modify("Inv. Discount Amount")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Inv. Discount Amount"(Control 36)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Item Charge Assignment"(Control 32)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Assign"(Control 44)".


//         //Unsupported feature: Property Deletion (StyleExpr) on ""Qty. to Assign"(Control 44)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Assigned"(Control 42)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Job No."(Control 38)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Job Task No."(Control 90)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Job Line Type"(Control 86)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Job Unit Price"(Control 92)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Job Line Amount"(Control 104)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Job Line Discount Amount"(Control 108)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Job Line Discount %"(Control 106)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Job Total Price"(Control 94)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Job Unit Price (LCY)"(Control 96)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Job Total Price (LCY)"(Control 98)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Job Line Amount (LCY)"(Control 100)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Job Line Disc. Amount (LCY)"(Control 102)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Prod. Order No."(Control 50)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Order No."(Control 64)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Order Line No."(Control 70)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Insurance No."(Control 18)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Budgeted FA No."(Control 28)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""FA Posting Type"(Control 20)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Depreciation Book Code"(Control 26)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Depr. until FA Posting Date"(Control 22)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Depr. Acquisition Cost"(Control 24)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Duplicate in Depreciation Book"(Control 54)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Use Duplication List"(Control 76)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-to Item Entry"(Control 40)".

//         modify("Deferral Code")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Deferral Code"(Control 17)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 62)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 60)".



//         //Unsupported feature: Code Modification on "ShortcutDimCode3(Control 300).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             ValidateShortcutDimCode(3,ShortcutDimCode[3]);

//             OnAfterValidateShortcutDimCode(Rec,ShortcutDimCode,3);
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             ValidateShortcutDimCode(3,ShortcutDimCode[3]);
//             */
//         //end;


//         //Unsupported feature: Code Modification on "ShortcutDimCode4(Control 302).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             ValidateShortcutDimCode(4,ShortcutDimCode[4]);

//             OnAfterValidateShortcutDimCode(Rec,ShortcutDimCode,4);
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             ValidateShortcutDimCode(4,ShortcutDimCode[4]);
//             */
//         //end;


//         //Unsupported feature: Code Modification on "ShortcutDimCode5(Control 304).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             ValidateShortcutDimCode(5,ShortcutDimCode[5]);

//             OnAfterValidateShortcutDimCode(Rec,ShortcutDimCode,5);
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             ValidateShortcutDimCode(5,ShortcutDimCode[5]);
//             */
//         //end;


//         //Unsupported feature: Code Modification on "ShortcutDimCode6(Control 306).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             ValidateShortcutDimCode(6,ShortcutDimCode[6]);

//             OnAfterValidateShortcutDimCode(Rec,ShortcutDimCode,6);
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             ValidateShortcutDimCode(6,ShortcutDimCode[6]);
//             */
//         //end;


//         //Unsupported feature: Code Modification on "ShortcutDimCode7(Control 308).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             ValidateShortcutDimCode(7,ShortcutDimCode[7]);

//             OnAfterValidateShortcutDimCode(Rec,ShortcutDimCode,7);
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             ValidateShortcutDimCode(7,ShortcutDimCode[7]);
//             */
//         //end;


//         //Unsupported feature: Code Modification on "ShortcutDimCode8(Control 310).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             ValidateShortcutDimCode(8,ShortcutDimCode[8]);

//             OnAfterValidateShortcutDimCode(Rec,ShortcutDimCode,8);
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             ValidateShortcutDimCode(8,ShortcutDimCode[8]);
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 21)".


//         //Unsupported feature: Property Deletion (Visible) on ""Document No."(Control 21)".


//         //Unsupported feature: Property Deletion (Editable) on ""Document No."(Control 21)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Line No."(Control 23)".


//         //Unsupported feature: Property Deletion (Visible) on ""Line No."(Control 23)".


//         //Unsupported feature: Property Deletion (Editable) on ""Line No."(Control 23)".



//         //Unsupported feature: Code Insertion on ""No."(Control 25)".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //begin
//             /*
//             ShowShortcutDimCode(ShortcutDimCode);
//             NoOnAfterValidate;

//             IF xRec."No." <> '' THEN
//               RedistributeTotalsOnAfterValidate;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (CaptionML) on "AmountBeforeDiscount(Control 25)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "AmountBeforeDiscount(Control 25)".


//         //Unsupported feature: Property Deletion (AutoFormatType) on "AmountBeforeDiscount(Control 25)".


//         //Unsupported feature: Property Deletion (AutoFormatExpr) on "AmountBeforeDiscount(Control 25)".


//         //Unsupported feature: Property Deletion (CaptionClass) on "AmountBeforeDiscount(Control 25)".


//         //Unsupported feature: Property Deletion (Editable) on "AmountBeforeDiscount(Control 25)".



//         //Unsupported feature: Code Insertion (VariableCollection) on ""Invoice Discount Amount"(Control 31).OnValidate".

//         //trigger (Variable: PurchaseHeader)()
//         //Parameters and return type have not been exported.
//         //begin
//             /*
//             */
//         //end;


//         //Unsupported feature: Code Modification on "InvoiceDiscountAmount(Control 31).OnValidate".

//         //trigger OnValidate()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             DocumentTotals.PurchaseDocTotalsNotUpToDate;
//             ValidateInvoiceDiscountAmount;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             PurchaseHeader.GET("Document Type","Document No.");
//             PurchCalcDiscByType.ApplyInvDiscBasedOnAmt(TotalPurchaseLine."Inv. Discount Amount",PurchaseHeader);
//             CurrPage.UPDATE(FALSE);
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "InvoiceDiscountAmount(Control 31)".


//         //Unsupported feature: Property Deletion (CaptionClass) on "InvoiceDiscountAmount(Control 31)".

//         modify("Invoice Disc. Pct.")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Disc. Pct."(Control 29)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Total Amount Excl. VAT"(Control 13)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Total VAT Amount"(Control 11)".


//         //Unsupported feature: Property Deletion (CaptionML) on ""Total Amount Incl. VAT"(Control 9)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Total Amount Incl. VAT"(Control 9)".


//         //Unsupported feature: Property Deletion (AutoFormatType) on ""Total Amount Incl. VAT"(Control 9)".


//         //Unsupported feature: Property Deletion (AutoFormatExpr) on ""Total Amount Incl. VAT"(Control 9)".


//         //Unsupported feature: Property Deletion (CaptionClass) on ""Total Amount Incl. VAT"(Control 9)".


//         //Unsupported feature: Property Deletion (Editable) on ""Total Amount Incl. VAT"(Control 9)".

//         addafter("No.")
//         {
//             field("Gen. Prod. Posting Group";Rec."Gen. Prod. Posting Group")
//             {
//                 ApplicationArea = Basic;
//             }
//             field("VAT Bus. Posting Group";Rec."VAT Bus. Posting Group")
//             {
//                 ApplicationArea = Basic;
//             }
//         }
//         moveafter(Type;AmountBeforeDiscount)
//         moveafter("No.";"Document No.")
//         moveafter("Expense Code";"VAT Prod. Posting Group")
//         moveafter("VAT Prod. Posting Group";"No.")
//         moveafter("Gen. Bus. Posting Group";Description)
//         moveafter(Description;"Line No.")
//         moveafter("Description 2";"Return Reason Code")
//         moveafter("Unit Price (LCY)";"Line Amount")
//         moveafter("Line Amount";"Line Discount %")
//         moveafter("Line Discount %";"Line Discount Amount")
//         moveafter("ShortcutDimCode[8]";Control39)
//         moveafter(Control33;InvoiceDiscountAmount)
//     }
//     actions
//     {

//         //Unsupported feature: Property Modification (Level) on ""F&unctions"(Action 1906587504)".

//         modify("E&xplode BOM")
//         {

//             //Unsupported feature: Property Modification (Level) on ""E&xplode BOM"(Action 1900205804)".

//             ApplicationArea = Basic;
//         }
//         modify(InsertExtTexts)
//         {

//             //Unsupported feature: Property Modification (Level) on "InsertExtTexts(Action 1903099004)".


//             //Unsupported feature: Property Modification (Name) on "InsertExtTexts(Action 1903099004)".

//             ApplicationArea = Basic;
//         }
//         modify(GetReceiptLines)
//         {

//             //Unsupported feature: Property Modification (Level) on "GetReceiptLines(Action 1901652204)".

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
//         modify(Dimensions)
//         {

//             //Unsupported feature: Property Modification (Level) on "Dimensions(Action 1904974904)".

//             ApplicationArea = Basic;
//         }
//         modify("Co&mments")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Co&mments"(Action 1901431304)".

//             ApplicationArea = Basic;
//         }
//         modify(ItemChargeAssignment)
//         {

//             //Unsupported feature: Property Modification (Level) on "ItemChargeAssignment(Action 1907184504)".

//             ApplicationArea = Basic;
//         }
//         modify("Item &Tracking Lines")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Item &Tracking Lines"(Action 1905987604)".

//             ApplicationArea = Basic;
//         }
//         modify(DeferralSchedule)
//         {

//             //Unsupported feature: Property Modification (Level) on "DeferralSchedule(Action 19)".

//             ApplicationArea = Basic;
//         }
//         modify(SelectMultiItems)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""E&xplode BOM"(Action 1900205804)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "InsertExtTexts(Action 1903099004)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "GetReceiptLines(Action 1901652204)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Event(Action 5)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Period(Action 1901092104)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Variant(Action 1905427604)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Location(Action 1907075804)".


//         //Unsupported feature: Property Deletion (AccessByPermission) on ""BOM Level"(Action 3)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""BOM Level"(Action 3)".

//         modify("Related Information")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1904974904)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 1901431304)".



//         //Unsupported feature: Code Modification on "ItemChargeAssignment(Action 1907184504).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             ShowItemChargeAssgnt;
//             SetItemChargeFieldsStyle;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             ShowItemChargeAssgnt;
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "ItemChargeAssignment(Action 1907184504)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Item &Tracking Lines"(Action 1905987604)".



//         //Unsupported feature: Code Modification on "DeferralSchedule(Action 19).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//             /*
//             ShowDeferralSchedule;
//             */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//             /*
//             PurchHeader.GET("Document Type","Document No.");
//             ShowDeferrals(PurchHeader."Posting Date",PurchHeader."Currency Code");
//             */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on "DeferralSchedule(Action 19)".

//         modify(DocAttach)
//         {
//             Visible = false;
//         }
//         moveafter(ActionContainer1900000004;"F&unctions")
//     }

//     var
//         PurchaseHeader: Record "Purchase Header";


//     //Unsupported feature: Property Modification (Id) on "VATAmount(Variable 1031)".

//     //var
//         //>>>> ORIGINAL VALUE:
//         //VATAmount : 1031;
//         //Variable type has not been exported.
//         //>>>> MODIFIED VALUE:
//         //VATAmount : 1017;
//         //Variable type has not been exported.

//     var
//         PurchHeader: Record "Purchase Header";

//     var
//         PurchPriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";

//     var
//         UpdateAllowedVar: Boolean;
//         Text000: label 'Unable to run this function while in View mode.';

//     var
//         TotalAmountStyle: Text;
//         RefreshMessageEnabled: Boolean;
//         RefreshMessageText: Text;
//         TypeChosen: Boolean;


//     //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

//     //trigger OnAfterGetCurrRecord()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         GetTotalPurchHeader;
//         CalculateTotals;
//         UpdateEditableOnRow;
//         UpdateTypeText;
//         SetItemChargeFieldsStyle;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         IF PurchHeader.GET("Document Type","Document No.") THEN;

//         DocumentTotals.PurchaseUpdateTotalsControls(Rec,TotalPurchaseHeader,TotalPurchaseLine,RefreshMessageEnabled,
//           TotalAmountStyle,RefreshMessageText,InvDiscAmountEditable,VATAmount);
//         */
//     //end;


//     //Unsupported feature: Code Modification on "OnAfterGetRecord".

//     //trigger OnAfterGetRecord()
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         ShowShortcutDimCode(ShortcutDimCode);
//         UpdateTypeText;
//         SetItemChargeFieldsStyle;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         ShowShortcutDimCode(ShortcutDimCode);
//         TypeChosen := HasTypeToFillMandatotyFields;
//         */
//     //end;


//     //Unsupported feature: Code Modification on "OnDeleteRecord".

//     //trigger OnDeleteRecord(): Boolean
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         IF (Quantity <> 0) AND ItemExists("No.") THEN BEGIN
//           COMMIT;
//           IF NOT ReservePurchLine.DeleteLineConfirm(Rec) THEN
//             EXIT(FALSE);
//           ReservePurchLine.DeleteLine(Rec);
//         END;
//         DocumentTotals.PurchaseDocTotalsNotUpToDate;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         #1..6
//         */
//     //end;


//     //Unsupported feature: Code Modification on "OnNewRecord".

//     //trigger OnNewRecord(BelowxRec: Boolean)
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         InitType;
//         // Default to Item for the first line and to previous line type for the others
//         IF ApplicationAreaMgmtFacade.IsFoundationEnabled THEN
//           IF xRec."Document No." = '' THEN
//             Type := Type::Item;

//         CLEAR(ShortcutDimCode);
//         UpdateTypeText;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         InitType;
//         CLEAR(ShortcutDimCode);
//         */
//     //end;

//     //Unsupported feature: Property Deletion (Attributes) on "ApproveCalcInvDisc(PROCEDURE 7)".



//     //Unsupported feature: Code Modification on "ApproveCalcInvDisc(PROCEDURE 7)".

//     //procedure ApproveCalcInvDisc();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)",Rec);
//         DocumentTotals.PurchaseDocTotalsNotUpToDate;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         CODEUNIT.RUN(CODEUNIT::"Purch.-Disc. (Yes/No)",Rec);
//         */
//     //end;


//     //Unsupported feature: Code Modification on "ExplodeBOM(PROCEDURE 3)".

//     //procedure ExplodeBOM();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM",Rec);
//         DocumentTotals.PurchaseDocTotalsNotUpToDate;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         CODEUNIT.RUN(CODEUNIT::"Purch.-Explode BOM",Rec);
//         */
//     //end;


//     //Unsupported feature: Code Modification on "GetReceipt(PROCEDURE 4)".

//     //procedure GetReceipt();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         CODEUNIT.RUN(CODEUNIT::"Purch.-Get Receipt",Rec);
//         DocumentTotals.PurchaseDocTotalsNotUpToDate;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         CODEUNIT.RUN(CODEUNIT::"Purch.-Get Receipt",Rec);
//         */
//     //end;

//     //Unsupported feature: Property Deletion (Attributes) on "InsertExtendedText(PROCEDURE 6)".


//     //Unsupported feature: Property Insertion (Local) on "InsertExtendedText(PROCEDURE 6)".



//     //Unsupported feature: Code Modification on "InsertExtendedText(PROCEDURE 6)".

//     //procedure InsertExtendedText();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         OnBeforeInsertExtendedText(Rec);
//         IF TransferExtendedText.PurchCheckIfAnyExtText(Rec,Unconditionally) THEN BEGIN
//           CurrPage.SAVERECORD;
//           TransferExtendedText.InsertPurchExtText(Rec);
//         END;
//         IF TransferExtendedText.MakeUpdate THEN
//           UpdateForm(TRUE);
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         #2..7
//         */
//     //end;

//     //Unsupported feature: Property Deletion (Attributes) on "UpdateForm(PROCEDURE 12)".



//     //Unsupported feature: Code Modification on "NoOnAfterValidate(PROCEDURE 19066594)".

//     //procedure NoOnAfterValidate();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         UpdateEditableOnRow;
//         InsertExtendedText(FALSE);
//         IF (Type = Type::"Charge (Item)") AND ("No." <> xRec."No.") AND
//            (xRec."No." <> '')
//         THEN
//           CurrPage.SAVERECORD;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         #2..6
//         */
//     //end;

//     //Unsupported feature: Property Modification (Name) on "DeltaUpdateTotals(PROCEDURE 1)".



//     //Unsupported feature: Code Modification on "DeltaUpdateTotals(PROCEDURE 1)".

//     //procedure DeltaUpdateTotals();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         DocumentTotals.PurchaseDeltaUpdateTotals(Rec,xRec,TotalPurchaseLine,VATAmount,InvoiceDiscountAmount,InvoiceDiscountPct);
//         IF "Line Amount" <> xRec."Line Amount" THEN
//           SendLineInvoiceDiscountResetNotification;
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount",Rec);
//         */
//     //end;

//     //Unsupported feature: Parameter Insertion (Parameter: UpdateAllowed) (ParameterCollection) on "SetUpdateAllowed(PROCEDURE 2)".


//     //Unsupported feature: Property Deletion (Local) on "SetItemChargeFieldsStyle(PROCEDURE 2)".


//     //Unsupported feature: Property Modification (Name) on "SetItemChargeFieldsStyle(PROCEDURE 2)".



//     //Unsupported feature: Code Modification on "SetItemChargeFieldsStyle(PROCEDURE 2)".

//     //procedure SetItemChargeFieldsStyle();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         ItemChargeStyleExpression := '';
//         IF AssignedItemCharge THEN
//           ItemChargeStyleExpression := 'Unfavorable';
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         UpdateAllowedVar := UpdateAllowed;
//         */
//     //end;

//     //Unsupported feature: ReturnValue Insertion (ReturnValue: <Blank>) (ReturnValueCollection) on "UpdateAllowed(PROCEDURE 5)".


//     //Unsupported feature: Property Deletion (Attributes) on "OnCrossReferenceNoOnLookup(PROCEDURE 5)".


//     //Unsupported feature: Property Modification (Name) on "OnCrossReferenceNoOnLookup(PROCEDURE 5)".



//     //Unsupported feature: Code Modification on "OnCrossReferenceNoOnLookup(PROCEDURE 5)".

//     //procedure OnCrossReferenceNoOnLookup();
//     //Parameters and return type have not been exported.
//     //>>>> ORIGINAL CODE:
//     //begin
//         /*
//         */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//         /*
//         IF UpdateAllowedVar = FALSE THEN BEGIN
//           MESSAGE(Text000);
//           EXIT(FALSE);
//         END;
//         EXIT(TRUE);
//         */
//     //end;

//     local procedure ItemChargeAssgnt()
//     begin
//         Rec.ShowItemChargeAssgnt;
//     end;

//     local procedure ShowPrices()
//     begin
//         PurchHeader.Get(Rec."Document Type",Rec."Document No.");
//         Clear(PurchPriceCalcMgt);
//         PurchPriceCalcMgt.GetPurchLinePrice(PurchHeader,Rec);
//     end;

//     local procedure ShowLineDisc()
//     begin
//         PurchHeader.Get(Rec."Document Type",Rec."Document No.");
//         Clear(PurchPriceCalcMgt);
//         PurchPriceCalcMgt.GetPurchLineLineDisc(PurchHeader,Rec);
//     end;

//     local procedure CrossReferenceNoOnAfterValidat()
//     begin
//         InsertExtendedText(false);
//     end;

//     local procedure RedistributeTotalsOnAfterValidate()
//     begin
//         CurrPage.SaveRecord;

//         PurchHeader.Get(Rec."Document Type",Rec."Document No.");
//         if DocumentTotals.PurchaseCheckNumberOfLinesLimit(PurchHeader) then
//           DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec,VATAmount,TotalPurchaseLine);
//         CurrPage.Update;
//     end;

//     //Unsupported feature: Deletion (ParameterCollection) on "OnCrossReferenceNoOnLookup(PROCEDURE 5).PurchaseLine(Parameter 1000)".

// }
