#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186776 pageextension52186776 extends "Purchase Return Order Subform" 
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
        // }
        modify("Bin Code")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
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
        // modify("Inv. Discount Amount")
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Return Qty. to Ship")
        {
            ApplicationArea = Basic;
        }
        modify("Return Qty. Shipped")
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

            //Unsupported feature: Property Modification (Name) on "AmountBeforeDiscount(Control 13)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "AmountBeforeDiscount(Control 13)".


            //Unsupported feature: Property Insertion (DrillDown) on "AmountBeforeDiscount(Control 13)".

            Enabled = RefreshMessageEnabled;
            ShowCaption = false;
        }
        modify("Invoice Discount Amount")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Invoice Discount Amount"(Control 37)".


            //Unsupported feature: Property Modification (AutoFormatExpr) on ""Invoice Discount Amount"(Control 37)".

            Style = Subordinate;
            StyleExpr = RefreshMessageEnabled;
        }
        // modify("Invoice Disc. Pct.")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (DecimalPlaces) on ""Invoice Disc. Pct."(Control 35)".


        //     //Unsupported feature: Property Modification (SourceExpr) on ""Invoice Disc. Pct."(Control 35)".

        //     Editable = false;

        //     //Unsupported feature: Property Insertion (Visible) on ""Invoice Disc. Pct."(Control 35)".

        //     Style = Subordinate;
        //     StyleExpr = RefreshMessageEnabled;
        // }
        modify("Total Amount Excl. VAT")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (AutoFormatExpr) on ""Total Amount Excl. VAT"(Control 19)".

          //  CaptionClass = DocumentTotals.GetTotalExclVATCaption(PurchHeader."Currency Code");
            Style = Subordinate;
            StyleExpr = RefreshMessageEnabled;
        }
        modify("Total VAT Amount")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (AutoFormatExpr) on ""Total VAT Amount"(Control 17)".

            //CaptionClass = DocumentTotals.GetTotalVATCaption(PurchHeader."Currency Code");
            Style = Subordinate;
            StyleExpr = RefreshMessageEnabled;
        }
        modify("Total Amount Incl. VAT")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (AutoFormatExpr) on ""Total Amount Incl. VAT"(Control 15)".

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
            CrossReferenceNoLookUp;
            InsertExtendedText(FALSE);
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
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Cross-Reference No."(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""IC Partner Ref. Type"(Control 88)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""IC Partner Reference"(Control 90)".

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

        // //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        // //Unsupported feature: Property Deletion (ToolTipML) on ""Return Reason Code"(Control 82)".

        // modify("Location Code")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 60)".


        //Unsupported feature: Property Deletion (Enabled) on ""Location Code"(Control 60)".


        //Unsupported feature: Property Deletion (Editable) on ""Location Code"(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 86)".



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


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reserved Quantity"(Control 84)".



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


        //Unsupported feature: Property Deletion (Visible) on ""Unit of Measure Code"(Control 36)".


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


        //Unsupported feature: Property Deletion (ShowMandatory) on ""Direct Unit Cost"(Control 12)".



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


        //Unsupported feature: Property Deletion (BlankZero) on ""Unit Price (LCY)"(Control 68)".



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

        modify("Allow Invoice Disc.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Invoice Disc."(Control 50)".

        // modify("Inv. Discount Amount")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Inv. Discount Amount"(Control 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Return Qty. to Ship"(Control 56)".


        //Unsupported feature: Property Deletion (Enabled) on ""Return Qty. to Ship"(Control 56)".


        //Unsupported feature: Property Deletion (Editable) on ""Return Qty. to Ship"(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Return Qty. Shipped"(Control 78)".


        //Unsupported feature: Property Deletion (Enabled) on ""Return Qty. Shipped"(Control 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Invoice"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Quantity Invoiced"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Item Charge Assignment"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. to Assign"(Control 48)".


        //Unsupported feature: Property Deletion (StyleExpr) on ""Qty. to Assign"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Qty. Assigned"(Control 54)".


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


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job No."(Control 5)".


        //Unsupported feature: Property Deletion (Visible) on ""Job No."(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Task No."(Control 11)".


        //Unsupported feature: Property Deletion (Visible) on ""Job Task No."(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Line Type"(Control 9)".


        //Unsupported feature: Property Deletion (Visible) on ""Job Line Type"(Control 9)".

        // modify("Deferral Code")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Deferral Code"(Control 23)".


        //Unsupported feature: Property Deletion (Visible) on ""Deferral Code"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Returns Deferral Start Date"(Control 25)".


        //Unsupported feature: Property Deletion (Visible) on ""Returns Deferral Start Date"(Control 25)".


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



        //Unsupported feature: Code Insertion on "RefreshTotals(Control 13)".

        //trigger OnDrillDown()
        //begin
            /*
            DocumentTotals.PurchaseRedistributeInvoiceDiscountAmounts(Rec,VATAmount,TotalPurchaseLine);
            CurrPage.UPDATE(FALSE);
            */
        //end;

        //Unsupported feature: Property Deletion (CaptionML) on "AmountBeforeDiscount(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AmountBeforeDiscount(Control 13)".


        //Unsupported feature: Property Deletion (AutoFormatType) on "AmountBeforeDiscount(Control 13)".


        //Unsupported feature: Property Deletion (AutoFormatExpr) on "AmountBeforeDiscount(Control 13)".


        //Unsupported feature: Property Deletion (CaptionClass) on "AmountBeforeDiscount(Control 13)".



        //Unsupported feature: Code Insertion (VariableCollection) on ""Invoice Discount Amount"(Control 37).OnValidate".

        //trigger (Variable: PurchaseHeader)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Invoice Discount Amount"(Control 37).OnValidate".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Discount Amount"(Control 37)".


        //Unsupported feature: Property Deletion (CaptionClass) on ""Invoice Discount Amount"(Control 37)".

        // modify("Invoice Disc. Pct.")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Disc. Pct."(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Amount Excl. VAT"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total VAT Amount"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Total Amount Incl. VAT"(Control 15)".

        moveafter("Unit Price (LCY)";"Line Amount")
        moveafter(Control39;"Invoice Discount Amount")
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

            //Unsupported feature: Property Modification (Name) on "Reserve(Action 1902479904)".

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

            //Unsupported feature: Property Modification (Name) on "Comments(Action 1900920004)".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""E&xplode BOM"(Action 1903098704)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Insert &Ext. Texts"(Action 1901742204)".



        //Unsupported feature: Code Modification on "Reserve(Action 1902479904).OnAction".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "Reserve(Action 1902479904)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order &Tracking"(Action 1906421304)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Event(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Period(Action 1903587104)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Variant(Action 1903193004)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Location(Action 1900296704)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BOM Level"(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1902740304)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Comments(Action 1900920004)".



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

        //Unsupported feature: Property Deletion (ToolTipML) on "DeferralSchedule(Action 27)".

        modify(DocAttach)
        {
            Visible = false;
        }
    }

    var
        PurchaseHeader: Record "Purchase Header";


    //Unsupported feature: Property Modification (Id) on "PurchCalcDiscByType(Variable 1020)".

    //var
        //>>>> ORIGINAL VALUE:
        //PurchCalcDiscByType : 1020;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //PurchCalcDiscByType : 1014;
        //Variable type has not been exported.

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
        UpdateCurrency;
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
          ERROR(ConnotExplodeBOMErr);
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

    //Unsupported feature: Property Deletion (Attributes) on "InsertExtendedText(PROCEDURE 5)".


    //Unsupported feature: Property Insertion (Local) on "InsertExtendedText(PROCEDURE 5)".



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

    //Unsupported feature: Property Modification (Name) on "PageShowReservation(PROCEDURE 9)".


    //Unsupported feature: Property Deletion (Attributes) on "UpdateForm(PROCEDURE 12)".


    //Unsupported feature: Property Modification (Name) on "UpdateCurrency(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "UpdateCurrency(PROCEDURE 1)".

    //procedure UpdateCurrency();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF Currency.Code <> TotalPurchaseHeader."Currency Code" THEN
          IF NOT Currency.GET(TotalPurchaseHeader."Currency Code") THEN BEGIN
            CLEAR(Currency);
            Currency.InitRoundingPrecision;
          END
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"Purch.-Calc.Discount",Rec);
        */
    //end;

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
}
