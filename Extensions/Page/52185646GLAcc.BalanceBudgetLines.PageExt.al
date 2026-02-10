#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185646 pageextension52185646 extends "G/L Acc. Balance/Budget Lines" 
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
            Caption = 'Debit Amount';
            ApplicationArea = Basic;
        }
        modify(CreditAmount)
        {

            //Unsupported feature: Property Modification (Name) on "CreditAmount(Control 2)".

            Caption = 'Credit Amount';
            ApplicationArea = Basic;
        }
        modify(NetChange)
        {

            //Unsupported feature: Property Modification (Name) on "NetChange(Control 10)".

            ApplicationArea = Basic;
        }
        modify(BudgetedDebitAmount)
        {

            //Unsupported feature: Property Modification (Name) on "BudgetedDebitAmount(Control 6)".

            ApplicationArea = Basic;
        }
        modify(BudgetedCreditAmount)
        {

            //Unsupported feature: Property Modification (Name) on "BudgetedCreditAmount(Control 8)".

            ApplicationArea = Basic;
        }
        modify(BudgetedAmount)
        {

            //Unsupported feature: Property Modification (Name) on "BudgetedAmount(Control 18)".

            ApplicationArea = Basic;
        }
        modify(BudgetPct)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Start"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Name"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DebitAmount(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CreditAmount(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NetChange(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BudgetedDebitAmount(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BudgetedCreditAmount(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BudgetedAmount(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BudgetPct(Control 12)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "Set(PROCEDURE 1)".


    //Unsupported feature: Code Modification on "Set(PROCEDURE 1)".

    //procedure Set();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GLAcc.COPY(NewGLAcc);

        IF GLAcc.GETFILTER("Date Filter") <> '' THEN BEGIN
          FILTERGROUP(2);
          SETFILTER("Period Start",GLAcc.GETFILTER("Date Filter"));
          FILTERGROUP(0);
        END;

        GLPeriodLength := NewGLPeriodLength;
        AmountType := NewAmountType;
        ClosingEntryFilter := NewClosingEntryFilter;
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GLAcc.COPY(NewGLAcc);
        #9..12
        */
    //end;


    //Unsupported feature: Code Modification on "CalcFormFields(PROCEDURE 5)".

    //procedure CalcFormFields();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GLAcc.CALCFIELDS("Net Change","Debit Amount","Credit Amount","Budgeted Amount");
        GLAcc."Budgeted Debit Amount" := GLAcc."Budgeted Amount";
        GLAcc."Budgeted Credit Amount" := -GLAcc."Budgeted Amount";
        IF GLAcc."Budgeted Amount" = 0 THEN
          BudgetPct := 0
        ELSE
          BudgetPct := ROUND(GLAcc."Net Change" / GLAcc."Budgeted Amount" * 100);

        OnAfterCalcFormFields(GLAcc,BudgetPct);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GLAcc.CALCFIELDS("Net Change","Budgeted Amount");
        GLAcc."Debit Amount" := GLAcc."Net Change";
        GLAcc."Credit Amount" := -GLAcc."Net Change";
        #2..6
          BudgetPct := GLAcc."Net Change" / GLAcc."Budgeted Amount" * 100;
        */
    //end;
}
