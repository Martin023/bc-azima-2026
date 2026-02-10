#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185708 pageextension52185708 extends "G/L Account Balance Lines" 
{
    layout
    {
        modify("Period Start")
        {
            ApplicationArea = Basic;
        }
        modify("Period Name")
        {
            ApplicationArea = Basic;
        }
        modify(DebitAmount)
        {
            ApplicationArea = Basic;
        }
        modify(CreditAmount)
        {
            ApplicationArea = Basic;
        }
        modify(NetChange)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Start"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Name"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DebitAmount(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CreditAmount(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NetChange(Control 10)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "Set(PROCEDURE 1)".


    //Unsupported feature: Code Modification on "BalanceDrillDown(PROCEDURE 3)".

    //procedure BalanceDrillDown();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IsHandled := FALSE;
        OnBeforeBalanceDrillDown(GLAcc,GLPeriodLength,AmountType,ClosingEntryFilter,DebitCreditTotals,IsHandled);
        IF IsHandled THEN
          EXIT;

        SetDateFilter;
        GLEntry.RESET;
        GLEntry.SETCURRENTKEY("G/L Account No.","Posting Date");
        #9..13
        GLEntry.SETFILTER("Global Dimension 2 Code",GLAcc.GETFILTER("Global Dimension 2 Filter"));
        GLEntry.SETFILTER("Business Unit Code",GLAcc.GETFILTER("Business Unit Filter"));
        PAGE.RUN(0,GLEntry);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #6..16
        */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "BalanceDrillDown(PROCEDURE 3).IsHandled(Variable 1001)".

}
