#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185531 pageextension52185531 extends "G/L Account Balance/Budget" 
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

        //Unsupported feature: Property Deletion (ToolTipML) on "ClosingEntryFilter(Control 19)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "GLBalanceLines(Control 5)".

        modify(Filters)
        {
            Visible = false;
        }
        modify(DateFilter)
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
        modify("Copy Budget")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ledger E&ntries"(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 184)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E&xtended Texts"(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Copy Budget"(Action 28)".

    }

    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GLSetup.GET;
        GLBudgetOpen.RUN(Rec);
        GLBudgetOpen.SetupFiltersOnGLAccBudgetPage(
          GlobalDim1Filter,GlobalDim2Filter,GlobalDim1FilterEnable,GlobalDim2FilterEnable,
          PeriodType,DateFilter,Rec);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CODEUNIT.RUN(CODEUNIT::"GLBudget-Open",Rec);
        */
    //end;
}
