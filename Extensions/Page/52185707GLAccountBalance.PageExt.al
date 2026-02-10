#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185707 pageextension52185707 extends "G/L Account Balance" 
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

        //Unsupported feature: Property Deletion (ToolTipML) on "ClosingEntryFilter(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DebitCreditTotals(Control 2)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "GLBalanceLines(Control 5)".

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

            //Unsupported feature: Property Insertion (PromotedCategory) on ""Ledger E&ntries"(Action 29)".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ledger E&ntries"(Action 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 184)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E&xtended Texts"(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Receivables-Payables"(Action 32)".

    }
}
