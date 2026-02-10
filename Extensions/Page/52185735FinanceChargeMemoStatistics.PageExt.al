#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185735 pageextension52185735 extends "Finance Charge Memo Statistics" 
{
    layout
    {
        modify(Interest)
        {
            ApplicationArea = Basic;
        }
        modify("Additional Fee")
        {
            ApplicationArea = Basic;
        }
        modify(VatAmount)
        {
            ApplicationArea = Basic;
        }
        modify(FinChrgMemoTotal)
        {
            ApplicationArea = Basic;
        }
        modify("Cust.""Balance (LCY)""")
        {
            ApplicationArea = Basic;
        }
        modify("Cust.""Credit Limit (LCY)""")
        {
            ApplicationArea = Basic;
        }
        modify(CreditLimitLCYExpendedPct)
        {
            ToolTip = 'Expended % of Credit Limit (LCY)';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Interest(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Additional Fee"(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on "VatAmount(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "FinChrgMemoTotal(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cust.""Balance (LCY)"""(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cust.""Credit Limit (LCY)"""(Control 8)".

    }

    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CALCFIELDS("Interest Amount","VAT Amount");
        FinChrgMemoTotal := "Additional Fee" + "Interest Amount" + "VAT Amount";
        IF "Customer No." <> '' THEN BEGIN
          CustPostingGr.GET("Customer Posting Group");
          GLAcc.GET(CustPostingGr.GetInterestAccount);
          VATPostingSetup.GET("VAT Bus. Posting Group",GLAcc."VAT Prod. Posting Group");
          OnAfterGetVATPostingSetup(VATPostingSetup);
          VATInterest := VATPostingSetup."VAT %";
          GLAcc.GET(CustPostingGr.GetAdditionalFeeAccount);
          VATPostingSetup.GET("VAT Bus. Posting Group",GLAcc."VAT Prod. Posting Group");
          OnAfterGetVATPostingSetup(VATPostingSetup);
          Interest := (FinChrgMemoTotal - "Additional Fee" * (VATPostingSetup."VAT %" / 100 + 1)) /
            (VATInterest / 100 + 1);
          VatAmount := Interest * VATInterest / 100 +
        #15..21
          CreditLimitLCYExpendedPct := 0
        ELSE
          CreditLimitLCYExpendedPct := ROUND(Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" * 10000,1);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
          CustPostingGr.TESTFIELD("Interest Account");
          GLAcc.GET(CustPostingGr."Interest Account");
          VATPostingSetup.GET("VAT Bus. Posting Group",GLAcc."VAT Prod. Posting Group");
          VATInterest := VATPostingSetup."VAT %";
          GLAcc.GET(CustPostingGr."Additional Fee Account");
          VATPostingSetup.GET("VAT Bus. Posting Group",GLAcc."VAT Prod. Posting Group");
        #12..24
        */
    //end;
}
