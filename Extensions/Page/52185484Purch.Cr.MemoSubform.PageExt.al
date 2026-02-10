#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185484 pageextension52185484 extends "Purch. Cr. Memo Subform" 
{
    layout
    {
        // addafter("Shortcut Dimension 2 Code")
        // {
        //     // field("Gen. Bus. Posting Group";Rec."Gen. Bus. Posting Group")
        //     // {

        //     // }
        //      field("Gen. Prod. Posting Group";Rec."Gen. Prod. Posting Group")
        //     {

        //     }
        // }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        // modify(FilteredTypeField)
        // {

        //     //Unsupported feature: Property Modification (Name) on "FilteredTypeField(Control 29)".

        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (SourceExpr) on "FilteredTypeField(Control 29)".

        // }
        modify("No.")
        {
            ApplicationArea = Basic;
            ShowMandatory = TypeChosen;
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
        modify("Gen. Bus. Posting Group")
        {
            Visible=true;
        }
        modify("Gen. Prod. Posting Group")
        {
            ApplicationArea = Basic;
            Visible=true;
        }
        modify("Return Reason Code")
        {
            ApplicationArea = Basic;
        }
        // modify("Location Code")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Bin Code")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
            ShowMandatory = TypeChosen;
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
            ShowMandatory = TypeChosen;
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

            //Unsupported feature: Property Insertion (Visible) on ""Line Discount Amount"(Control 52)".

        }
        // modify("Allow Invoice Disc.")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Inv. Discount Amount")
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
        modify("Job No.")
        {
            ApplicationArea = Basic;
        }
        modify("Job Task No.")
        {
            ApplicationArea = Basic;
        }
        modify("Job Line Type")
        {
            ApplicationArea = Basic;
        }
        modify("Job Unit Price")
        {
            ApplicationArea = Basic;
        }
        modify("Job Line Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Job Line Discount Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Job Line Discount %")
        {
            ApplicationArea = Basic;
        }
        modify("Job Total Price")
        {
            ApplicationArea = Basic;
        }
        modify("Job Unit Price (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Job Total Price (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Job Line Amount (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Job Line Disc. Amount (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Prod. Order No.")
        {
            ApplicationArea = Basic;
        }
        modify("Insurance No.")
        {
            ApplicationArea = Basic;
        }
        modify("Budgeted FA No.")
        {
            ApplicationArea = Basic;
        }
        modify("FA Posting Type")
        {
            ApplicationArea = Basic;
        }
        modify("Depr. until FA Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Depreciation Book Code")
        {
            ApplicationArea = Basic;
        }
        modify("Depr. Acquisition Cost")
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
        // modify("Deferral Code")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 1 Code"(Control 64)".

        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Shortcut Dimension 2 Code"(Control 62)".

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

            //Unsupported feature: Property Modification (Name) on "AmountBeforeDiscount(Control 15)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "AmountBeforeDiscount(Control 15)".


            //Unsupported feature: Property Insertion (DrillDown) on "AmountBeforeDiscount(Control 15)".

            Enabled = RefreshMessageEnabled;
            ShowCaption = false;
        }
        modify("Invoice Discount Amount")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Invoice Discount Amount"(Control 39)".


            //Unsupported feature: Property Modification (AutoFormatExpr) on ""Invoice Discount Amount"(Control 39)".

            Style = Subordinate;
            StyleExpr = RefreshMessageEnabled;
        }
        // modify("Invoice Disc. Pct.")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (DecimalPlaces) on ""Invoice Disc. Pct."(Control 37)".


        //     //Unsupported feature: Property Modification (SourceExpr) on ""Invoice Disc. Pct."(Control 37)".


        //     //Unsupported feature: Property Insertion (Visible) on ""Invoice Disc. Pct."(Control 37)".

        //     Style = Subordinate;
        //     StyleExpr = RefreshMessageEnabled;
       // }
        modify("Total Amount Excl. VAT")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (AutoFormatExpr) on ""Total Amount Excl. VAT"(Control 21)".

           // CaptionClass = DocumentTotals.GetTotalExclVATCaption(PurchHeader."Currency Code");
            Style = Subordinate;
            StyleExpr = RefreshMessageEnabled;
        }
        modify("Total VAT Amount")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (AutoFormatExpr) on ""Total VAT Amount"(Control 19)".

            //CaptionClass = DocumentTotals.GetTotalVATCaption(PurchHeader."Currency Code");
            Style = Subordinate;
            StyleExpr = RefreshMessageEnabled;
        }
        modify("Total Amount Incl. VAT")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (AutoFormatExpr) on ""Total Amount Incl. VAT"(Control 17)".

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
            TypeChosen := HasTypeToFillMandatotyFields;

            IF xRec."No." <> '' THEN
              RedistributeTotalsOnAfterValidate;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 2)".

        // modify(FilteredTypeField)
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (CaptionML) on "FilteredTypeField(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on "FilteredTypeField(Control 29)".


        //Unsupported feature: Property Deletion (TableRelation) on "FilteredTypeField(Control 29)".


        //Unsupported feature: Property Deletion (Visible) on "FilteredTypeField(Control 29)".


        //Unsupported feature: Property Deletion (Editable) on "FilteredTypeField(Control 29)".


        //Unsupported feature: Property Deletion (LookupPageID) on "FilteredTypeField(Control 29)".



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



        //Unsupported feature: Code Modification on ""Cross-Reference No."(Control 72).OnLookup".

        //trigger "(Control 72)()
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


        //Unsupported feature: Code Modification on ""Cross-Reference No."(Control 72).OnValidate".

        //trigger "(Control 72)()
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Cross-Reference No."(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""IC Partner Code"(Control 82)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""IC Partner Ref. Type"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""IC Partner Reference"(Control 78)".

        // modify("Variant Code")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Nonstock(Control 74)".



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


        //Unsupported feature: Property Deletion (ShowMandatory) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Return Reason Code"(Control 56)".

        // modify("Location Code")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 60)".


        //Unsupported feature: Property Deletion (Enabled) on ""Location Code"(Control 60)".


        //Unsupported feature: Property Deletion (Editable) on ""Location Code"(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 38)".



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



        //Unsupported feature: Code Modification on ""Unit of Measure Code"(Control 36).OnValidate".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 36)".


        //Unsupported feature: Property Deletion (Enabled) on ""Unit of Measure Code"(Control 36)".


        //Unsupported feature: Property Deletion (Editable) on ""Unit of Measure Code"(Control 36)".



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



        //Unsupported feature: Code Insertion on ""Indirect Cost %"(Control 24)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            RedistributeTotalsOnAfterValidate;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Indirect Cost %"(Control 24)".



        //Unsupported feature: Code Insertion on ""Unit Cost (LCY)"(Control 58)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            RedistributeTotalsOnAfterValidate;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost (LCY)"(Control 58)".



        //Unsupported feature: Code Insertion on ""Unit Price (LCY)"(Control 68)".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //begin
            /*
            RedistributeTotalsOnAfterValidate;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Price (LCY)"(Control 68)".



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


        //Unsupported feature: Property Deletion (BlankZero) on ""Line Discount Amount"(Control 52)".


        //Unsupported feature: Property Deletion (Enabled) on ""Line Discount Amount"(Control 52)".


        //Unsupported feature: Property Deletion (Editable) on ""Line Discount Amount"(Control 52)".

        // modify("Allow Invoice Disc.")
        // {
        //     Visible = false;
        // }

        // //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Invoice Disc."(Control 50)".

        // modify("Inv. Discount Amount")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Inv. Discount Amount"(Control 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Item Charge Assignment"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Assign"(Control 48)".


        //Unsupported feature: Property Deletion (StyleExpr) on ""Qty. to Assign"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Assigned"(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job No."(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Task No."(Control 86)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Line Type"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Unit Price"(Control 90)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Line Amount"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Line Discount Amount"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Line Discount %"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Total Price"(Control 92)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Unit Price (LCY)"(Control 100)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Total Price (LCY)"(Control 102)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Line Amount (LCY)"(Control 104)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Line Disc. Amount (LCY)"(Control 106)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prod. Order No."(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Insurance No."(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Budgeted FA No."(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FA Posting Type"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Depr. until FA Posting Date"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Depreciation Book Code"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Depr. Acquisition Cost"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Order No."(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Order Line No."(Control 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appl.-to Item Entry"(Control 44)".

        // modify("Deferral Code")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Deferral Code"(Control 25)".


        //Unsupported feature: Property Deletion (Visible) on ""Deferral Code"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 62)".



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


        //Unsupported feature: Code Insertion on "RefreshTotals(Control 15)".

        //trigger OnDrillDown()
        //begin
            /*
            DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec,VATAmount,TotalPurchaseLine);
            CurrPage.UPDATE(FALSE);
            */
        //end;

        //Unsupported feature: Property Deletion (CaptionML) on "AmountBeforeDiscount(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AmountBeforeDiscount(Control 15)".


        //Unsupported feature: Property Deletion (AutoFormatType) on "AmountBeforeDiscount(Control 15)".


        //Unsupported feature: Property Deletion (AutoFormatExpr) on "AmountBeforeDiscount(Control 15)".


        //Unsupported feature: Property Deletion (CaptionClass) on "AmountBeforeDiscount(Control 15)".



        //Unsupported feature: Code Insertion (VariableCollection) on ""Invoice Discount Amount"(Control 39).OnValidate".

        //trigger (Variable: PurchaseHeader)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Invoice Discount Amount"(Control 39).OnValidate".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Discount Amount"(Control 39)".


        //Unsupported feature: Property Deletion (CaptionClass) on ""Invoice Discount Amount"(Control 39)".

        modify("Invoice Disc. Pct.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Disc. Pct."(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Amount Excl. VAT"(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total VAT Amount"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Amount Incl. VAT"(Control 17)".

        addafter(FilteredTypeField)
        {
            // field("Gen. Prod. Posting Group";Rec."Gen. Prod. Posting Group")
            // {
            //     ApplicationArea = Basic;
            // }
        }
        moveafter(Type;"No.")
        moveafter("Unit Price (LCY)";"Line Amount")
        moveafter("Line Amount";"Line Discount %")
        moveafter("Line Discount %";"Line Discount Amount")
        moveafter(Control41;"Invoice Discount Amount")
    }
    actions
    {
        modify(InsertExtTexts)
        {

            //Unsupported feature: Property Modification (Level) on "InsertExtTexts(Action 1901742204)".


            //Unsupported feature: Property Modification (Name) on "InsertExtTexts(Action 1901742204)".

            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {

            //Unsupported feature: Property Modification (Level) on "Dimensions(Action 1902740304)".

            ApplicationArea = Basic;
        }
        modify(DeferralSchedule)
        {

            //Unsupported feature: Property Modification (Level) on "DeferralSchedule(Action 27)".

            ApplicationArea = Basic;
        }
        modify("E&xplode BOM")
        {
            ApplicationArea = Basic;
        }
        modify(GetReturnShipmentLines)
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

        //Unsupported feature: Property Deletion (ToolTipML) on "InsertExtTexts(Action 1901742204)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1902740304)".



        //Unsupported feature: Code Modification on "DeferralSchedule(Action 27).OnAction".

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
            PurchHeader.GET("Document Type","Document No.");
            ShowDeferrals(PurchHeader."Posting Date",PurchHeader."Currency Code");
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "DeferralSchedule(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E&xplode BOM"(Action 1903098704)".


        //Unsupported feature: Property Deletion (ToolTipML) on "GetReturnShipmentLines(Action 1907528504)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Event(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Period(Action 1903587104)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Variant(Action 1903193004)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Location(Action 1900296704)".


        //Unsupported feature: Property Deletion (AccessByPermission) on ""BOM Level"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BOM Level"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 1902395304)".



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

        modify(DocAttach)
        {
            Visible = false;
        }
        // moveafter(ActionContainer1900000004;"F&unctions")
        // moveafter("Insert &Ext. Texts";GetReturnShipmentLines)
        moveafter(Dimensions;"Co&mments")
    }

    var
        PurchaseHeader: Record "Purchase Header";


    //Unsupported feature: Property Modification (Id) on "InvDiscAmountEditable(Variable 1007)".

    //var
        //>>>> ORIGINAL VALUE:
        //InvDiscAmountEditable : 1007;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //InvDiscAmountEditable : 1010;
        //Variable type has not been exported.

    var
        PurchHeader: Record "Purchase Header";

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
        GetTotalPurchHeader;
        CalculateTotals;
        UpdateEditableOnRow;
        UpdateTypeText;
        SetItemChargeFieldsStyle;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        TypeChosen := HasTypeToFillMandatotyFields;
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
        CLEAR(DocumentTotals);
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

    //Unsupported feature: Property Deletion (Attributes) on "CalcInvDisc(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "CalcInvDisc(PROCEDURE 1)".

    //procedure CalcInvDisc();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount",Rec);
        DocumentTotals.PurchaseDocTotalsNotUpToDate;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount",Rec);
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "ExplodeBOM(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "ExplodeBOM(PROCEDURE 3)".

    //procedure ExplodeBOM();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
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

    //Unsupported feature: Property Deletion (Attributes) on "GetReturnShipment(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "GetReturnShipment(PROCEDURE 2)".

    //procedure GetReturnShipment();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"Purch.-Get Return Shipments",Rec);
        DocumentTotals.PurchaseDocTotalsNotUpToDate;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"Purch.-Get Return Shipments",Rec);
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "InsertExtendedText(PROCEDURE 5)".



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

    //Unsupported feature: Property Deletion (Attributes) on "ItemChargeAssgnt(PROCEDURE 5800)".


    //Unsupported feature: Property Deletion (Attributes) on "OpenItemTrackingLines(PROCEDURE 6500)".


    //Unsupported feature: Property Deletion (Attributes) on "UpdateForm(PROCEDURE 12)".


    //Unsupported feature: Property Deletion (Attributes) on "SetUpdateAllowed(PROCEDURE 4)".


    //Unsupported feature: Property Deletion (Attributes) on "UpdateAllowed(PROCEDURE 9)".


    //Unsupported feature: Property Deletion (Attributes) on "ShowLineComments(PROCEDURE 10)".


    //Unsupported feature: Property Modification (Name) on "DeltaUpdateTotals(PROCEDURE 8)".



    //Unsupported feature: Code Modification on "DeltaUpdateTotals(PROCEDURE 8)".

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
        CurrPage.SAVERECORD;

        PurchHeader.GET("Document Type","Document No.");
        IF DocumentTotals.PurchaseCheckNumberOfLinesLimit(PurchHeader) THEN
          DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec,VATAmount,TotalPurchaseLine);
        CurrPage.UPDATE;
        */
    //end;
}
