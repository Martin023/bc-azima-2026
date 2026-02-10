#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187174 pageextension52187174 extends "VAT Amount Lines"
{
    layout
    {
        modify("VAT Identifier")
        {
            ApplicationArea = Basic;
        }
        modify("VAT %")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Calculation Type")
        {
            ApplicationArea = Basic;
        }
        modify("Line Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Inv. Disc. Base Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Invoice Discount Amount")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Base")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Amount")
        {
            ApplicationArea = Basic;
            Editable = "VAT AmountEditable";
        }
        modify("Calculated VAT Amount")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Difference")
        {
            ApplicationArea = Basic;
        }
        modify("Amount Including VAT")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Identifier"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT %"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Calculation Type"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Line Amount"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inv. Disc. Base Amount"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Discount Amount"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Base"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Amount"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Calculated VAT Amount"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Difference"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount Including VAT"(Control 22)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    var

        "VAT AmountEditable": Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    VATAmountEditable := AllowVATDifference AND NOT "Includes Prepayment";
    InvoiceDiscountAmountEditable := AllowInvDisc AND NOT "Includes Prepayment";
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    "VAT AmountEditable" := AllowVATDifference AND NOT "Includes Prepayment";
    InvoiceDiscountAmountEditable := AllowInvDisc AND NOT "Includes Prepayment";
    */
    //end;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    InvoiceDiscountAmountEditable := TRUE;
    VATAmountEditable := TRUE;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    InvoiceDiscountAmountEditable := TRUE;
    "VAT AmountEditable" := TRUE;
    */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetTempVATAmountLine(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "GetTempVATAmountLine(PROCEDURE 5)".


    //Unsupported feature: Property Deletion (Attributes) on "InitGlobals(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "InitGlobals(PROCEDURE 2)".

    //procedure InitGlobals();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CurrencyCode := NewCurrencyCode;
    AllowVATDifference := NewAllowVATDifference;
    AllowVATDifferenceOnThisTab := NewAllowVATDifferenceOnThisTab;
    PricesIncludingVAT := NewPricesIncludingVAT;
    AllowInvDisc := NewAllowInvDisc;
    VATBaseDiscPct := NewVATBaseDiscPct;
    VATAmountEditable := AllowVATDifference;
    InvoiceDiscountAmountEditable := AllowInvDisc;
    IF CurrencyCode = '' THEN
      Currency.InitRoundingPrecision
    ELSE
      Currency.GET(CurrencyCode);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..6
    "VAT AmountEditable" := AllowVATDifference;
    #8..12
    */
    //end;


    //Unsupported feature: Code Modification on "FormCheckVATDifference(PROCEDURE 4)".

    //procedure FormCheckVATDifference();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CheckVATDifference(CurrencyCode,AllowVATDifference);
    VATAmountLine2 := TempVATAmountLine;
    TotalVATDifference := ABS("VAT Difference") - ABS(xRec."VAT Difference");
    IF TempVATAmountLine.FIND('-') THEN
    #5..9
      ERROR(
        Text001,FIELDCAPTION("VAT Difference"),
        Currency."Max. VAT Difference Allowed",Currency.FIELDCAPTION("Max. VAT Difference Allowed"));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CheckVATDifference(CurrencyCode,AllowVATDifference,PricesIncludingVAT);
    #2..12
    */
    //end;
}
