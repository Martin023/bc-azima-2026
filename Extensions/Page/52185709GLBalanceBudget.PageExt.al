#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185709 pageextension52185709 extends "G/L Balance/Budget" 
{
    layout
    {
        modify(ClosingEntryFilter)
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
        modify("Budgeted Debit Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Budgeted Credit Amount")
        {
            ApplicationArea = Basic;
        }
        modify("Budgeted Amount")
        {
            ApplicationArea = Basic;
        }
        modify(BudgetPct)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ClosingEntryFilter(Control 40)".

        modify(DateFilter)
        {
            Visible = false;
        }
        modify(GLAccFilter)
        {
            Visible = false;
        }
        modify(GLAccCategory)
        {
            Visible = false;
        }
        modify(IncomeBalGLAccFilter)
        {
            Visible = false;
        }
        modify(GlobalDim1Filter)
        {
            Visible = false;
        }
        modify(GlobalDim2Filter)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Income/Balance"(Control 1)".


        //Unsupported feature: Property Deletion (Visible) on ""Income/Balance"(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Debit Amount"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Credit Amount"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Net Change"(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Budgeted Debit Amount"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Budgeted Credit Amount"(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Budgeted Amount"(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BudgetPct(Control 26)".


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
        modify("Copy Budget")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ledger E&ntries"(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 184)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E&xtended Texts"(Action 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Copy Budget"(Action 47)".

    }

    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GLSetup.GET;
        InitDefaultFilters;
        CODEUNIT.RUN(CODEUNIT::"GLBudget-Open",Rec);
        FindPeriod('');
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"GLBudget-Open",Rec);
        FindPeriod('');
        */
    //end;


    //Unsupported feature: Code Modification on "FindPeriod(PROCEDURE 1)".

    //procedure FindPeriod();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF GETFILTER("Date Filter") <> '' THEN BEGIN
          Calendar.SETFILTER("Period Start",GETFILTER("Date Filter"));
          IF NOT PeriodFormMgt.FindDate('+',Calendar,PeriodType) THEN
        #4..32
            "Date Filter",
            GETRANGEMIN("Date Filter"),
            CLOSINGDATE(GETRANGEMAX("Date Filter")));
        DateFilter := GETFILTER("Date Filter");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..35
        */
    //end;
}
