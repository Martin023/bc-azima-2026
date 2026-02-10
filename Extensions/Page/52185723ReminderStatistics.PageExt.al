#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185723 pageextension52185723 extends "Reminder Statistics" 
{
    layout
    {
        modify("Remaining Amount")
        {
            ApplicationArea = Basic;
        }
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
        modify("Add. Fee per Line")
        {
            ApplicationArea = Basic;
        }
        modify(ReminderTotal)
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Remaining Amount"(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Interest(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Additional Fee"(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on "VatAmount(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Add. Fee per Line"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ReminderTotal(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cust.""Balance (LCY)"""(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cust.""Credit Limit (LCY)"""(Control 8)".

    }

    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CALCFIELDS("Interest Amount","VAT Amount","Add. Fee per Line");
        ReminderTotal := "Remaining Amount" + "Additional Fee" + "Interest Amount" + "VAT Amount" + "Add. Fee per Line";
        VatAmount := "VAT Amount";
        #4..6
          IF ReminderLevel."Calculate Interest" AND ("VAT Amount" <> 0) THEN BEGIN
            GLAcc.GET(CustPostingGr."Interest Account");
            VATPostingSetup.GET("VAT Bus. Posting Group",GLAcc."VAT Prod. Posting Group");
            OnAfterGetVATPostingSetup(VATPostingSetup);
            VATInterest := VATPostingSetup."VAT %";
            IF GLAcc.GET(CustPostingGr."Additional Fee Account") THEN BEGIN
              VATPostingSetup.GET("VAT Bus. Posting Group",GLAcc."VAT Prod. Posting Group");
              OnAfterGetVATPostingSetup(VATPostingSetup);
            END;
            Interest :=
              (ReminderTotal -
               "Remaining Amount" - ("Additional Fee" + "Add. Fee per Line") * (VATPostingSetup."VAT %" / 100 + 1)) /
        #19..28
          CreditLimitLCYExpendedPct := 0
        ELSE
          CreditLimitLCYExpendedPct := ROUND(Cust."Balance (LCY)" / Cust."Credit Limit (LCY)" * 10000,1);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..9
            VATInterest := VATPostingSetup."VAT %";
            IF GLAcc.GET(CustPostingGr."Additional Fee Account") THEN
              VATPostingSetup.GET("VAT Bus. Posting Group",GLAcc."VAT Prod. Posting Group");
        #16..31
        */
    //end;
}
