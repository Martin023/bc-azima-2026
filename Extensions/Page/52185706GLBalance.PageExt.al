#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185706 pageextension52185706 extends "G/L Balance" 
{
    layout
    {
        modify(ClosingEntryFilter)
        {
            ApplicationArea = Basic;
        }
        modify(DebitCreditTotals)
        {
            ApplicationArea = Basic;
        }
        modify(PeriodType)
        {
            ToolTip = 'Day';
            ApplicationArea = Basic;
        }
        modify(AmountType)
        {
            ToolTip = 'Net Change';
            ApplicationArea = Basic;
        }
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
        modify("Debit Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Credit Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Net Change")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ClosingEntryFilter(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DebitCreditTotals(Control 27)".

        modify(DateFilter)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Income/Balance"(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Debit Amount"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Credit Amount"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Net Change"(Control 35)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

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

            //Unsupported feature: Property Insertion (PromotedCategory) on ""Ledger E&ntries"(Action 34)".

        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify(Dimensions)
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
        modify("Previous Period")
        {
            ToolTip = 'Previous Period';
            ApplicationArea = Basic;
        }
        modify("Next Period")
        {
            ToolTip = 'Next Period';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ledger E&ntries"(Action 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 184)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E&xtended Texts"(Action 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Receivables-Payables"(Action 41)".

    }

    //Unsupported feature: Code Modification on "FindPeriod(PROCEDURE 1)".

    //procedure FindPeriod();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF GETFILTER("Date Filter") <> '' THEN BEGIN
          Calendar.SETFILTER("Period Start",GETFILTER("Date Filter"));
          IF NOT PeriodFormMgt.FindDate('+',Calendar,PeriodType) THEN
        #4..38
            "Date Filter",
            GETRANGEMIN("Date Filter"),
            CLOSINGDATE(GETRANGEMAX("Date Filter")));
        DateFilter := GETFILTER("Date Filter");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..41
        */
    //end;
}
