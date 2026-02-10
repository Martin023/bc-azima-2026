#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185836 pageextension52185836 extends "Chart of Accs. (Analysis View)" 
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
        modify("Income/Balance")
        {
            ApplicationArea = Basic;
        }
        modify("Account Type")
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
        modify("Budgeted Amount")
        {
            ApplicationArea = Basic;
        }
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


        //Unsupported feature: Property Deletion (ToolTipML) on ""Income/Balance"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Account Type"(Control 8)".


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


        //Unsupported feature: Property Deletion (ToolTipML) on ""Budgeted Amount"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Consol. Debit Acc."(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Consol. Credit Acc."(Control 41)".

    }
    actions
    {
        modify(Card)
        {
            ApplicationArea = Basic;
        }
        modify("Ledger E&ntries")
        {
            ApplicationArea = Basic;
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

        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ledger E&ntries"(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimensions-Single"(Action 84)".


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


        //Unsupported feature: Property Deletion (ToolTipML) on ""E&xtended Texts"(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Receivables-Payables"(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""G/L &Account Balance"(Action 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""G/L &Balance"(Action 132)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""G/L Balance by &Dimension"(Action 126)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Indent Chart of Accounts"(Action 30)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "InsertTempGLAccAnalysisViews(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "InsertTempCFAccountAnalysisVie(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "InsertTempCFAccountAnalysisVie(PROCEDURE 2)".

    //procedure InsertTempCFAccountAnalysisVie();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF CFAccount.FIND('-') THEN
          REPEAT
            INIT;
        #4..6
            Blocked := CFAccount.Blocked;
            "New Page" := CFAccount."New Page";
            "No. of Blank Lines" := CFAccount."No. of Blank Lines";
            VALIDATE(Indentation,CFAccount.Indentation);
            "Last Date Modified" := CFAccount."Last Date Modified";
            Totaling := CFAccount.Totaling;
            Comment := CFAccount.Comment;
            "Account Source" := "Account Source"::"Cash Flow Account";
            INSERT;
          UNTIL CFAccount.NEXT = 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..9
            Indentation := CFAccount.Indentation;
        #11..16
        */
    //end;
}
