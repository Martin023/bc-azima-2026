#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185837 pageextension52185837 extends "Chart of Accounts (G/L)" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("Account Type")
        {
            ApplicationArea = Basic;
        }
        modify("Income/Balance")
        {
            ApplicationArea = Basic;
        }
        modify("Direct Posting")
        {
            ApplicationArea = Basic;
        }
        modify(Totaling)
        {
            ApplicationArea = Basic;
        }
        modify("Gen. Posting Type")
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
        modify("Net Change")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Net Change"(Control 16)".

        }
        modify("Balance at Date")
        {
            ApplicationArea = Basic;
        }
        modify(Balance)
        {
            ApplicationArea = Basic;
        }
        modify("Additional-Currency Net Change")
        {
            ApplicationArea = Basic;
        }
        modify("Add.-Currency Balance at Date")
        {
            ApplicationArea = Basic;
        }
        modify("Additional-Currency Balance")
        {
            ApplicationArea = Basic;
        }
        // modify(Control34)
        // {
        //     ApplicationArea = Basic;
        // }
        modify("Consol. Debit Acc.")
        {
            ApplicationArea = Basic;
        }
        modify("Consol. Credit Acc.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Account Type"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Income/Balance"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Direct Posting"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Totaling(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Posting Type"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Bus. Posting Group"(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Gen. Prod. Posting Group"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Bus. Posting Group"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Prod. Posting Group"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Net Change"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Balance at Date"(Control 59)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Balance(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Additional-Currency Net Change"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Add.-Currency Balance at Date"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Additional-Currency Balance"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Control34(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Consol. Debit Acc."(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Consol. Credit Acc."(Control 41)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(AccountGeneralLedgerEntries)
        {

            //Unsupported feature: Property Modification (Name) on "AccountGeneralLedgerEntries(Action 28)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Promoted) on "AccountGeneralLedgerEntries(Action 28)".


            //Unsupported feature: Property Modification (PromotedCategory) on "AccountGeneralLedgerEntries(Action 28)".

        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify("Dimensions-Single")
        {
            ApplicationArea = Basic;
        }
        modify("Dimensions-&Multiple")
        {
            ApplicationArea = Basic;
        }
        modify("E&xtended Texts")
        {
            ApplicationArea = Basic;
        }
        modify("Receivables-Payables")
        {
            ApplicationArea = Basic;
        }
        modify(NetChange)
        {

            //Unsupported feature: Property Modification (Name) on "NetChange(Action 5)".

            ApplicationArea = Basic;
        }
        modify("Budgeted Amount")
        {
            ApplicationArea = Basic;
        }
        modify("G/L &Account Balance")
        {
            ApplicationArea = Basic;
        }
        modify("G/L &Balance")
        {
            ApplicationArea = Basic;
        }
        modify("G/L Balance by &Dimension")
        {
            ApplicationArea = Basic;
        }
        modify("Indent Chart of Accounts")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "AccountGeneralLedgerEntries(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 25)".


        //Unsupported feature: Property Deletion (Promoted) on ""Co&mments"(Action 25)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Co&mments"(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimensions-Single"(Action 36)".


        //Unsupported feature: Property Deletion (Promoted) on ""Dimensions-Single"(Action 36)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Dimensions-Single"(Action 36)".


        //Unsupported feature: Code Modification on ""Dimensions-&Multiple"(Action 33).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(GLAcc);
            DefaultDimMultiple.SetMultiRecord(GLAcc,FIELDNO("No."));
            DefaultDimMultiple.RUNMODAL;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CurrPage.SETSELECTIONFILTER(GLAcc);
            DefaultDimMultiple.SetMultiGLAcc(GLAcc);
            DefaultDimMultiple.RUNMODAL;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimensions-&Multiple"(Action 33)".


        //Unsupported feature: Property Deletion (Promoted) on ""Dimensions-&Multiple"(Action 33)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Dimensions-&Multiple"(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E&xtended Texts"(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Receivables-Payables"(Action 27)".


        //Unsupported feature: Property Deletion (Promoted) on "NetChange(Action 5)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "NetChange(Action 5)".


        //Unsupported feature: Property Deletion (Promoted) on ""Budgeted Amount"(Action 7)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Budgeted Amount"(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""G/L &Account Balance"(Action 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""G/L &Balance"(Action 132)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""G/L Balance by &Dimension"(Action 126)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Indent Chart of Accounts"(Action 30)".


        //Unsupported feature: Property Deletion (Promoted) on ""Indent Chart of Accounts"(Action 30)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Indent Chart of Accounts"(Action 30)".

    }

    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
