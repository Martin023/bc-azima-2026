#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186105 pageextension52186105 extends "Cost Type Balance/Budget" 
{
    layout
    {
        modify(BudgetFilter)
        {
            ApplicationArea = Basic;
        }
        modify(CostCenterFilter)
        {
            ApplicationArea = Basic;
        }
        modify(CostObjectFilter)
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
        modify(Number)
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("Net Change")
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
        modify("Budget Amount")
        {
            ApplicationArea = Basic;
        }
        modify(BudgetPct)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "BudgetFilter(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CostCenterFilter(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CostObjectFilter(Control 9)".

        modify(DateFilter)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Number(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Net Change"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Debit Amount"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Credit Amount"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Budget Amount"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BudgetPct(Control 19)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Card)
        {
            ApplicationArea = Basic;
        }
        modify("Cost E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify(PreviousPeriod)
        {
            ToolTip = 'Previous Period';
            ApplicationArea = Basic;
        }
        modify(NextPeriod)
        {
            ToolTip = 'Next Period';
            ApplicationArea = Basic;
        }
        modify("Copy Budget")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cost E&ntries"(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Copy Budget"(Action 47)".

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
        #4..11
            SETRANGE("Date Filter",Calendar."Period Start",Calendar."Period End")
        ELSE
          SETRANGE("Date Filter",0D,Calendar."Period End");
        DateFilter := GETFILTER("Date Filter");
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..14

        CurrPage.UPDATE(FALSE);
        */
    //end;
}
