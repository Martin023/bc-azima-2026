#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185501 pageextension52185501 extends "General Ledger Setup"
{
    layout
    {
        modify("Allow Posting From")
        {
            ApplicationArea = Basic;
        }
        modify("Allow Posting To")
        {
            ApplicationArea = Basic;
        }
        modify("Register Time")
        {
            ApplicationArea = Basic;
        }
        modify("Local Address Format")
        {
            ApplicationArea = Basic;
        }
        modify("Local Cont. Addr. Format")
        {
            ApplicationArea = Basic;
        }
        modify("Inv. Rounding Precision (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Inv. Rounding Type (LCY)")
        {
            ApplicationArea = Basic;
        }
        modify("Allow G/L Acc. Deletion Before")
        {
            ApplicationArea = Basic;
        }
        modify("Check G/L Account Usage")
        {
            ApplicationArea = Basic;
        }
        modify("EMU Currency")
        {
            ApplicationArea = Basic;
        }
        modify("LCY Code")
        {
            ApplicationArea = Basic;
        }
        modify("Pmt. Disc. Excl. VAT")
        {
            ApplicationArea = Basic;
        }
        modify("Adjust for Payment Disc.")
        {
            ApplicationArea = Basic;
        }
        modify("Unrealized VAT")
        {
            ApplicationArea = Basic;
        }
        modify("Prepayment Unrealized VAT")
        {
            ApplicationArea = Basic;
        }
        modify("Max. VAT Difference Allowed")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Rounding Type")
        {
            ApplicationArea = Basic;
        }
        modify("Bank Account Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to/Sell-to VAT Calc.")
        {
            ApplicationArea = Basic;
        }
        modify("Print VAT specification in LCY")
        {
            ApplicationArea = Basic;
        }

        modify("Show Amounts")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Show Amounts"(Control 11)".


            //Unsupported feature: Property Modification (Name) on ""Show Amounts"(Control 11)".

        }

        //Unsupported feature: Property Modification (Name) on "Control1900309501(Control 1900309501)".

        modify("Global Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Global Dimension 2 Code")
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
        modify("Shortcut Dimension 3 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 4 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 5 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 6 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 7 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 8 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Additional Reporting Currency")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Exchange Rate Adjustment")
        {
            ApplicationArea = Basic;
        }
        modify("Appln. Rounding Precision")
        {
            ApplicationArea = Basic;
        }
        modify("Pmt. Disc. Tolerance Warning")
        {
            ApplicationArea = Basic;
        }
        modify("Pmt. Disc. Tolerance Posting")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Discount Grace Period")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Tolerance Warning")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Tolerance Posting")
        {
            ApplicationArea = Basic;
        }
        modify("Payment Tolerance %")
        {
            ApplicationArea = Basic;
        }
        modify("Max. Payment Tolerance Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Payroll Trans. Import Format")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Posting From"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow Posting To"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Register Time"(Control 43)".


        //Unsupported feature: Property Deletion (Importance) on ""Register Time"(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Local Address Format"(Control 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Local Cont. Addr. Format"(Control 73)".


        //Unsupported feature: Property Deletion (Importance) on ""Local Cont. Addr. Format"(Control 73)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inv. Rounding Precision (LCY)"(Control 77)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inv. Rounding Type (LCY)"(Control 75)".

        modify(AmountRoundingPrecision)
        {
            Visible = false;
        }
        modify(AmountDecimalPlaces)
        {
            Visible = false;
        }
        modify(UnitAmountRoundingPrecision)
        {
            Visible = false;
        }
        modify(UnitAmountDecimalPlaces)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Allow G/L Acc. Deletion Before"(Control 55)".


        //Unsupported feature: Property Deletion (Importance) on ""Allow G/L Acc. Deletion Before"(Control 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Check G/L Account Usage"(Control 60)".


        //Unsupported feature: Property Deletion (Importance) on ""Check G/L Account Usage"(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""EMU Currency"(Control 14)".


        //Unsupported feature: Property Deletion (Importance) on ""EMU Currency"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""LCY Code"(Control 18)".

        modify("Local Currency Symbol")
        {
            Visible = true;
        }
        modify("Local Currency Description")
        {
            Visible = true;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Pmt. Disc. Excl. VAT"(Control 49)".


        //Unsupported feature: Property Deletion (Importance) on ""Pmt. Disc. Excl. VAT"(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Adjust for Payment Disc."(Control 47)".


        //Unsupported feature: Property Deletion (Importance) on ""Adjust for Payment Disc."(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unrealized VAT"(Control 21)".


        //Unsupported feature: Property Deletion (Importance) on ""Unrealized VAT"(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prepayment Unrealized VAT"(Control 86)".


        //Unsupported feature: Property Deletion (Importance) on ""Prepayment Unrealized VAT"(Control 86)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Max. VAT Difference Allowed"(Control 5)".


        //Unsupported feature: Property Deletion (Importance) on ""Max. VAT Difference Allowed"(Control 5)".

        modify("Tax Invoice Renaming Threshold")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Rounding Type"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bank Account Nos."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to/Sell-to VAT Calc."(Control 82)".


        //Unsupported feature: Property Deletion (Importance) on ""Bill-to/Sell-to VAT Calc."(Control 82)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Print VAT specification in LCY"(Control 84)".


        //Unsupported feature: Property Deletion (Importance) on ""Print VAT specification in LCY"(Control 84)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Use Legacy G/L Entry Locking"(Control 4)".


        //Unsupported feature: Property Deletion (Importance) on ""Use Legacy G/L Entry Locking"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Show Amounts"(Control 11)".


        //Unsupported feature: Property Deletion (Importance) on ""Show Amounts"(Control 11)".

        // modify("SEPA Non-Euro Export")
        // {
        //     Visible = false;
        // }
        // modify("SEPA Export w/o Bank Acc. Data")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 1 Code"(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Global Dimension 2 Code"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 36)".


        //Unsupported feature: Property Deletion (Importance) on ""Shortcut Dimension 1 Code"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 34)".


        //Unsupported feature: Property Deletion (Importance) on ""Shortcut Dimension 2 Code"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 3 Code"(Control 32)".


        //Unsupported feature: Property Deletion (Importance) on ""Shortcut Dimension 3 Code"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 4 Code"(Control 30)".


        //Unsupported feature: Property Deletion (Importance) on ""Shortcut Dimension 4 Code"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 5 Code"(Control 28)".


        //Unsupported feature: Property Deletion (Importance) on ""Shortcut Dimension 5 Code"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 6 Code"(Control 26)".


        //Unsupported feature: Property Deletion (Importance) on ""Shortcut Dimension 6 Code"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 7 Code"(Control 23)".


        //Unsupported feature: Property Deletion (Importance) on ""Shortcut Dimension 7 Code"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 8 Code"(Control 22)".


        //Unsupported feature: Property Deletion (Importance) on ""Shortcut Dimension 8 Code"(Control 22)".

        modify("Acc. Sched. for Balance Sheet")
        {
            Visible = false;
        }
        modify("Acc. Sched. for Income Stmt.")
        {
            Visible = false;
        }
        modify("Acc. Sched. for Cash Flow Stmt")
        {
            Visible = false;
        }
        modify("Acc. Sched. for Retained Earn.")
        {
            Visible = false;
        }

        //Unsupported feature: Code Modification on ""Additional Reporting Currency"(Control 12).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF "Additional Reporting Currency" <> xRec."Additional Reporting Currency" THEN BEGIN
          IF "Additional Reporting Currency" = '' THEN
            Confirmed := ConfirmManagement.ConfirmProcess(Text002,TRUE)
          ELSE
            Confirmed := ConfirmManagement.ConfirmProcess(Text003,TRUE);
          IF NOT Confirmed THEN
            ERROR('');
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF "Additional Reporting Currency" <> xRec."Additional Reporting Currency" THEN BEGIN
          IF "Additional Reporting Currency" = '' THEN
            Confirmed := CONFIRM(Text002,FALSE)
          ELSE
            Confirmed := CONFIRM(Text003,FALSE);
        #6..8
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Additional Reporting Currency"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Exchange Rate Adjustment"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Appln. Rounding Precision"(Control 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pmt. Disc. Tolerance Warning"(Control 72)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pmt. Disc. Tolerance Posting"(Control 51)".



        //Unsupported feature: Code Modification on ""Payment Discount Grace Period"(Control 62).OnValidate".

        //trigger OnValidate()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ConfirmManagement.ConfirmProcess(Text001,TRUE) THEN
          PaymentToleranceMgt.CalcGracePeriodCVLedgEntry("Payment Discount Grace Period");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF CONFIRM(Text001,TRUE) THEN
          PaymentToleranceMgt.CalcGracePeriodCVLedgEntry("Payment Discount Grace Period");
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Discount Grace Period"(Control 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Tolerance Warning"(Control 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Tolerance Posting"(Control 70)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Tolerance %"(Control 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Max. Payment Tolerance Amount"(Control 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Payroll Trans. Import Format"(Control 9)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addafter("Allow Posting To")
        {
            // field("Allow Posting From [Time ]";"Allow Posting From [Time]")
            // {
            //     ApplicationArea = Basic;
            // }
            // field("Allow Posting To [Time ]";"Allow Posting To [Time]")
            // {
            //     ApplicationArea = Basic;
            // }
        }
        addafter(General)
        {
            group(Numbering)
            {
                Caption = 'Numbering';
            }
        }
        addafter("Bank Account Nos.")
        {
            field("Vote Transfer Nos ."; rec."Vote Transfer Nos.")
            {
                ApplicationArea = Basic;
            }
        }
        addafter("Payment Discount Grace Period")
        {
            field("SMS Sender ID"; Rec."SMS Sender ID")
            {
                ApplicationArea = BASIC;
            }
            field("SMS Sender Name"; Rec."SMS Sender Name")
            {
                ApplicationArea = BASIC;
            }
            field("EMAIL Sender Name"; Rec."EMAIL Sender Name")
            {
                ApplicationArea = BASIC;
            }
            field("EMAIL Sender Address"; Rec."EMAIL Sender Address")
            {
                ApplicationArea = BASIC;
            }
        }
        moveafter("VAT Rounding Type"; "Bill-to/Sell-to VAT Calc.")
        moveafter("Bank Account Nos."; Control1900309501)
    }
    actions
    {
        modify(ChangeGlobalDimensions)
        {

            //Unsupported feature: Property Modification (Name) on "ChangeGlobalDimensions(Action 44)".


            //Unsupported feature: Property Modification (AccessByPermission) on "ChangeGlobalDimensions(Action 44)".

            ApplicationArea = Basic;
        }
        modify("Change Payment &Tolerance")
        {
            ApplicationArea = Basic;
        }


        //Unsupported feature: Code Insertion on ""Change Global Dimensions"(Action 44)".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //begin
        /*
        REPORT.RUNMODAL(REPORT::"Change Global Dimensions");
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ChangeGlobalDimensions(Action 44)".


        //Unsupported feature: Property Deletion (RunObject) on "ChangeGlobalDimensions(Action 44)".


        //Unsupported feature: Property Deletion (Promoted) on "ChangeGlobalDimensions(Action 44)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "ChangeGlobalDimensions(Action 44)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "ChangeGlobalDimensions(Action 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Change Payment &Tolerance"(Action 2)".

        // modify(ActionContainer13)
        // {
        //     Visible = false;
        // }
        modify("Accounting Periods")
        {
            Visible = false;
        }
        modify(Dimensions)
        {
            Visible = false;
        }
        modify("User Setup")
        {
            Visible = false;
        }
        modify("Cash Flow Setup")
        {
            Visible = false;
        }
        modify("Bank Export/Import Setup")
        {
            Visible = false;
        }
        modify("General Ledger Posting")
        {
            Visible = false;
        }
        modify("General Posting Setup")
        {
            Visible = false;
        }
        modify("Gen. Business Posting Groups")
        {
            Visible = false;
        }
        modify("Gen. Product Posting Groups")
        {
            Visible = false;
        }
        modify("VAT Posting")
        {
            Visible = false;
        }
        modify("VAT Posting Setup")
        {
            Visible = false;
        }
        modify("VAT Business Posting Groups")
        {
            Visible = false;
        }
        modify("VAT Product Posting Groups")
        {
            Visible = false;
        }
        modify("VAT Report Setup")
        {
            Visible = false;
        }
        modify("Bank Posting")
        {
            Visible = false;
        }
        modify("Bank Account Posting Groups")
        {
            Visible = false;
        }
        modify("Journal Templates")
        {
            Visible = false;
        }
        modify("General Journal Templates")
        {
            Visible = false;
        }
        modify("VAT Statement Templates")
        {
            Visible = false;
        }
        // modify("Intrastat Templates")
        // {
        //     Visible = false;
        // }
    }


    //Unsupported feature: Property Modification (Id) on ""Change Payment &Tolerance"(Action 2).OnAction.ChangePmtTol(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //"Change Payment &Tolerance" : 1000;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"Change Payment &Tolerance" : 1001;
    //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    RESET;
    IF NOT GET THEN BEGIN
      INIT;
      INSERT;
    END;
    xGeneralLedgerSetup := Rec;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..5
    */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
