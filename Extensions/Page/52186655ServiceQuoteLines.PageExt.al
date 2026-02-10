#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186655 pageextension52186655 extends "Service Quote Lines"
{
    layout
    {
        modify(SelectionFilter)
        {
            ApplicationArea = Basic;
        }
        modify("Service Item Line No.")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item Serial No.")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item Line Description")
        {
            ApplicationArea = Basic;
        }
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
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Nonstock)
        {
            ApplicationArea = Basic;
        }
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify("Description 2")
        {
            ApplicationArea = Basic;
        }
        modify("Substitution Available")
        {
            ApplicationArea = Basic;
        }
        modify("Work Type Code")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
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

            //Unsupported feature: Property Modification (Visible) on ""Fault Area Code"(Control 20)".

        }
        modify("Symptom Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Symptom Code"(Control 60)".

        }
        modify("Fault Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Fault Code"(Control 76)".

        }
        modify("Resolution Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Resolution Code"(Control 119)".

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
        modify("Allow Invoice Disc.")
        {
            ApplicationArea = Basic;
        }
        modify("Inv. Discount Amount")
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
        modify("Unit Cost (LCY)")
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
        modify("Posting Group")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
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

        //Unsupported feature: Property Deletion (ToolTipML) on "SelectionFilter(Control 107)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item Line No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item Serial No."(Control 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item Line Description"(Control 22)".


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


        //Unsupported feature: Property Deletion (ToolTipML) on ""Variant Code"(Control 93)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Nonstock(Control 112)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 128)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Description 2"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Substitution Available"(Control 79)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Type Code"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fault Reason Code"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fault Area Code"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Symptom Code"(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fault Code"(Control 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resolution Code"(Control 119)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serv. Price Adjmt. Gr. Code"(Control 121)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Price"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount %"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount Amount"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Discount Type"(Control 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Invoice Disc."(Control 135)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inv. Discount Amount"(Control 137)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Amount"(Control 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Exclude Warranty"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Exclude Contract Discount"(Control 117)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Warranty(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warranty Disc. %"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract No."(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract Disc. %"(Control 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT %"(Control 100)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Base Amount"(Control 105)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount Including VAT"(Control 103)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit Cost (LCY)"(Control 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Bus. Posting Group"(Control 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Prod. Posting Group"(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Group"(Control 66)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 68)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 74)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1904739907(Control 1904739907)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Dimensions)
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
        modify(ItemTrackingLines)
        {
            ApplicationArea = Basic;
        }
        modify("Select Item &Substitution")
        {
            ApplicationArea = Basic;
        }
        modify(CalculateInvoiceDiscount)
        {
            ApplicationArea = Basic;
        }
        modify("Get Price")
        {
            ApplicationArea = Basic;
        }
        modify("Get Li&ne Discount")
        {
            ApplicationArea = Basic;
        }
        modify("Insert &Ext. Texts")
        {
            ApplicationArea = Basic;
        }
        modify("Insert &Starting Fee")
        {
            ApplicationArea = Basic;
        }
        modify("Insert &Travel Fee")
        {
            ApplicationArea = Basic;
        }
        modify("Split &Resource Line")
        {
            ApplicationArea = Basic;
        }
        modify("Ca&talog Items")
        {
            Caption = 'Nonstoc&k Items';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Ca&talog Items"(Action 17)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 116)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Event(Action 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Period(Action 125)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Variant(Action 126)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Location(Action 127)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BOM Level"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ItemTrackingLines(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Select Item &Substitution"(Action 132)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CalculateInvoiceDiscount(Action 111)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Get Price"(Action 123)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Get Li&ne Discount"(Action 124)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Insert &Ext. Texts"(Action 97)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Insert &Starting Fee"(Action 98)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Insert &Travel Fee"(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Split &Resource Line"(Action 99)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ca&talog Items"(Action 17)".

        addafter(Dimensions)
        {
            separator(Action129)
            {
                Caption = '';
            }
        }
        addafter(ItemTrackingLines)
        {
            separator(Action130)
            {
                Caption = '';
            }
        }
        addafter("Get Li&ne Discount")
        {
            separator(Action131)
            {
            }
        }
    }

    var

        "Fault Area CodeVisible": Boolean;

        "Symptom CodeVisible": Boolean;

        "Fault CodeVisible": Boolean;

        "Resolution CodeVisible": Boolean;

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

        IPSalesLineDisctextboxEnable: Boolean;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CLEAR(SelectionFilter);
    SetSelectionFilter;

    ServMgtSetup.GET;
    CASE ServMgtSetup."Fault Reporting Level" OF
      ServMgtSetup."Fault Reporting Level"::None:
        BEGIN
          FaultAreaCodeVisible := FALSE;
          SymptomCodeVisible := FALSE;
          FaultCodeVisible := FALSE;
          ResolutionCodeVisible := FALSE;
        END;
      ServMgtSetup."Fault Reporting Level"::Fault:
        BEGIN
          FaultAreaCodeVisible := FALSE;
          SymptomCodeVisible := FALSE;
          FaultCodeVisible := TRUE;
          ResolutionCodeVisible := TRUE;
        END;
      ServMgtSetup."Fault Reporting Level"::"Fault+Symptom":
        BEGIN
          FaultAreaCodeVisible := FALSE;
          SymptomCodeVisible := TRUE;
          FaultCodeVisible := TRUE;
          ResolutionCodeVisible := TRUE;
        END;
      ServMgtSetup."Fault Reporting Level"::"Fault+Symptom+Area (IRIS)":
        BEGIN
          FaultAreaCodeVisible := TRUE;
          SymptomCodeVisible := TRUE;
          FaultCodeVisible := TRUE;
          ResolutionCodeVisible := TRUE;
        END;
    END;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
          "Fault Area CodeVisible" := FALSE;
          "Symptom CodeVisible" := FALSE;
          "Fault CodeVisible" := FALSE;
          "Resolution CodeVisible" := FALSE;
    #12..14
          "Fault Area CodeVisible" := FALSE;
          "Symptom CodeVisible" := FALSE;
          "Fault CodeVisible" := TRUE;
          "Resolution CodeVisible" := TRUE;
    #19..21
          "Fault Area CodeVisible" := FALSE;
          "Symptom CodeVisible" := TRUE;
          "Fault CodeVisible" := TRUE;
          "Resolution CodeVisible" := TRUE;
    #26..28
          "Fault Area CodeVisible" := TRUE;
          "Symptom CodeVisible" := TRUE;
          "Fault CodeVisible" := TRUE;
          "Resolution CodeVisible" := TRUE;
        END;
    END;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Initialize(PROCEDURE 5)".


    //Unsupported feature: Property Deletion (Attributes) on "SetSelectionFilter(PROCEDURE 2)".



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


    //Unsupported feature: Code Modification on "NoOnAfterValidate(PROCEDURE 19066594)".

    //procedure NoOnAfterValidate();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InsertExtendedText(FALSE);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    InsertExtendedText(FALSE);
    InfopaneEnable((Type = Type::Item) AND ("No." <> ''));
    */
    //end;

    local procedure CalcInvDisc(var ServLine: Record "Service Line")
    begin
        Codeunit.Run(Codeunit::"Service-Calc. Discount", ServLine);
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
        IPSalesLineDisctextboxEnable := Value;
    end;

    local procedure TypeOnAfterValidate()
    begin
        InfopaneEnable((Rec.Type = Rec.Type::Item) and (Rec."No." <> ''));
    end;
}
