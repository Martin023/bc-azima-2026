#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186611 pageextension52186611 extends "Service Item Worksheet Subform"
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
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Work Type Code")
        {
            ApplicationArea = Basic;
        }
        modify(Control86)
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
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure")
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
        modify("Fault Reason Code")
        {
            ApplicationArea = Basic;
        }
        modify("Fault Area Code")
        {
            ApplicationArea = Basic;
        }
        modify("Symptom Code")
        {
            ApplicationArea = Basic;
        }
        modify("Fault Code")
        {
            ApplicationArea = Basic;
        }
        modify("Resolution Code")
        {
            ApplicationArea = Basic;
        }
        modify("Serv. Price Adjmt. Gr. Code")
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
        modify("Line Discount Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Line Discount Type")
        {
            ApplicationArea = Basic;
        }
        modify("Line Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Exclude Warranty")
        {
            ApplicationArea = Basic;
        }
        modify("Exclude Contract Discount")
        {
            ApplicationArea = Basic;
        }
        modify(Warranty)
        {
            ApplicationArea = Basic;
        }
        modify("Warranty Disc. %")
        {
            ApplicationArea = Basic;
        }
        modify("Contract No.")
        {
            ApplicationArea = Basic;
        }
        modify("Contract Disc. %")
        {
            ApplicationArea = Basic;
        }
        modify("VAT %")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Base Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Amount Including VAT")
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Bus. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Bus. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Prod. Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Planned Delivery Date")
        {
            ApplicationArea = Basic;
        }
        modify("Needed by Date")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[3]")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[4]")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[5]")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[6]")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[7]")
        {
            ApplicationArea = Basic;
        }
        modify("ShortcutDimCode[8]")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Modification on "Type(Control 8).OnValidate".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Nonstock(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Type Code"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Control86(Control 86)".



        //Unsupported feature: Code Modification on ""Location Code"(Control 56).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ("Location Code" <> '') AND (Type = Type::Item) THEN
          IF Item.GET("No.") THEN
            Item.TESTFIELD(Type,Item.Type::Inventory);

        LocationCodeOnAfterValidate;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        LocationCodeOnAfterValidate;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bin Code"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure"(Control 90)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reserved Quantity"(Control 88)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fault Reason Code"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fault Area Code"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Symptom Code"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fault Code"(Control 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resolution Code"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serv. Price Adjmt. Gr. Code"(Control 74)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Price"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount %"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount Amount"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount Type"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Amount"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Exclude Warranty"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Exclude Contract Discount"(Control 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Warranty(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warranty Disc. %"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract No."(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract Disc. %"(Control 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT %"(Control 68)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Base Amount"(Control 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount Including VAT"(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Bus. Posting Group"(Control 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Prod. Posting Group"(Control 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Bus. Posting Group"(Control 82)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Prod. Posting Group"(Control 84)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Planned Delivery Date"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Needed by Date"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 100)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 102)".

    }
    actions
    {
        modify("Insert Ext. Texts")
        {
            ApplicationArea = Basic;
        }
        modify("Insert Starting Fee")
        {
            ApplicationArea = Basic;
        }
        modify("Insert Travel Fee")
        {
            ApplicationArea = Basic;
        }
        modify(Reserve)
        {
            ApplicationArea = Basic;
        }
        modify("Order Tracking")
        {
            ApplicationArea = Basic;
        }
        modify("&Catalog Items")
        {
            Caption = '&Nonstock Items';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""&Catalog Items"(Action 1901742204)".

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
        modify("Select Item Substitution")
        {
            ApplicationArea = Basic;
        }
        modify("&Fault/Resol. Codes Relationships")
        {
            ApplicationArea = Basic;
        }
        modify("Item &Tracking Lines")
        {
            ApplicationArea = Basic;
        }
        modify("Order &Promising Line")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Insert Ext. Texts"(Action 1903098804)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Insert Starting Fee"(Action 1900545204)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Insert Travel Fee"(Action 1902085804)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reserve(Action 1903984904)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order Tracking"(Action 1904320404)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Catalog Items"(Action 1901742204)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Event(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Period(Action 1903099904)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Variant(Action 1900546304)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Location(Action 1900296704)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BOM Level"(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1907981204)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Select Item Substitution"(Action 1900545004)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Fault/Resol. Codes Relationships"(Action 1903098604)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Item &Tracking Lines"(Action 1907838004)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order &Promising Line"(Action 5)".

        addafter("Item &Tracking Lines")
        {
            separator(Action3)
            {
            }
        }
    }

    var
        ServHeader: Record "Service Header";
        SalesPriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";

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


    //Unsupported feature: Code Modification on "OnInsertRecord".

    //trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    //>>>> ORIGINAL CODE:
    //begin
    /*
    "Line No." := GetLineNo;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "Line No." := GetNextLineNo(xRec,BelowxRec);
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetValues(PROCEDURE 1)".



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
      CurrPage.UPDATE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #2..7
    */
    //end;

    local procedure ShowPrices()
    begin
        ServHeader.Get(Rec."Document Type", Rec."Document No.");
        Clear(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetServLinePrice(ServHeader, Rec);
    end;

    local procedure ShowLineDisc()
    begin
        ServHeader.Get(Rec."Document Type", Rec."Document No.");
        Clear(SalesPriceCalcMgt);
        SalesPriceCalcMgt.GetServLineLineDisc(ServHeader, Rec);
    end;

    local procedure InfopaneEnable(Value: Boolean)
    begin
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
    end;

    local procedure TypeOnAfterValidate()
    begin
        InfopaneEnable((Rec.Type = Rec.Type::Item) and (Rec."No." <> ''));
    end;

    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(false);
        InfopaneEnable((Rec.Type = Rec.Type::Item) and (Rec."No." <> ''));

        if (Rec.Reserve = Rec.Reserve::Always) and
           (Rec."Outstanding Qty. (Base)" <> 0) and
           (Rec."No." <> xRec."No.")
        then begin
            CurrPage.SaveRecord;
            Rec.AutoReserve;
            CurrPage.Update(false);
        end;
    end;

    local procedure LocationCodeOnAfterValidate()
    begin
        if (Rec.Reserve = Rec.Reserve::Always) and
           (Rec."Outstanding Qty. (Base)" <> 0) and
           (Rec."Location Code" <> xRec."Location Code")
        then begin
            CurrPage.SaveRecord;
            Rec.AutoReserve;
            CurrPage.Update(false);
        end;
    end;

    local procedure QuantityOnAfterValidate()
    begin
        if Rec.Type = Rec.Type::Item then
            case Rec.Reserve of
                Rec.Reserve::Always:
                    begin
                        CurrPage.SaveRecord;
                        Rec.AutoReserve;
                        CurrPage.Update(false);
                    end;
                Rec.Reserve::Optional:
                    if (Rec.Quantity < xRec.Quantity) and (xRec.Quantity > 0) then begin
                        CurrPage.SaveRecord;
                        CurrPage.Update(false);
                    end;
            end;
    end;

    local procedure PostingDateOnAfterValidate()
    begin
        if (Rec.Reserve = Rec.Reserve::Always) and
           (Rec."Outstanding Qty. (Base)" <> 0) and
           (Rec."Posting Date" <> xRec."Posting Date")
        then begin
            CurrPage.SaveRecord;
            Rec.AutoReserve;
            CurrPage.Update(false);
        end;
    end;
}
