#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185995 pageextension52185995 extends "Cash Flow Availability Lines" 
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
        modify(Receivables)
        {
            ApplicationArea = Basic;
        }
        modify(SalesOrders)
        {
            ApplicationArea = Basic;
        }
        modify(ServiceOrders)
        {
            ApplicationArea = Basic;
        }
        modify(SalesofFixedAssets)
        {
            ApplicationArea = Basic;
        }
        modify(ManualRevenues)
        {
            Caption = 'Cash Flow Manual Expenses';
            ApplicationArea = Basic;
        }
        modify(Payables)
        {
            ApplicationArea = Basic;
        }
        modify(PurchaseOrders)
        {
            ApplicationArea = Basic;
        }
        modify(BudgetedFixedAssets)
        {
            ApplicationArea = Basic;
        }
        modify(ManualExpenses)
        {
            ApplicationArea = Basic;
        }
        modify(Budget)
        {
            ApplicationArea = Basic;
        }
        modify(Total)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Start"(Control 1001)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Name"(Control 1003)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Receivables(Control 1005)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesOrders(Control 1007)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ServiceOrders(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesofFixedAssets(Control 1009)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ManualRevenues(Control 1011)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Payables(Control 1013)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PurchaseOrders(Control 1015)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BudgetedFixedAssets(Control 1017)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ManualExpenses(Control 1019)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Budget(Control 3)".

        modify(Job)
        {
            Visible = false;
        }
        modify(Tax)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Total(Control 1021)".

    }

    //Unsupported feature: Property Modification (Dimensions) on "Amounts(Variable 1004)".

    //var
        //>>>> ORIGINAL VALUE:
        //Amounts : 15;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Amounts : 11;
        //Variable type has not been exported.

    var
        CFPeriodLength: Option Day,Week,Month,Quarter,Year,Period;


    //Unsupported feature: Code Modification on "OnFindRecord".

    //trigger OnFindRecord()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        EXIT(PeriodFormManagement.FindDate(Which,Rec,PeriodType));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        EXIT(PeriodFormManagement.FindDate(Which,Rec,CFPeriodLength));
        */
    //end;


    //Unsupported feature: Code Modification on "OnNextRecord".

    //trigger OnNextRecord()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        EXIT(PeriodFormManagement.NextDate(Steps,Rec,PeriodType));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        EXIT(PeriodFormManagement.NextDate(Steps,Rec,CFPeriodLength));
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Set(PROCEDURE 1000)".



    //Unsupported feature: Code Modification on "Set(PROCEDURE 1000)".

    //procedure Set();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CashFlowForecast.COPY(NewCashFlowForecast);
        CashFlowForecast2.COPY(NewCashFlowForecast);
        PeriodType := NewPeriodType;
        AmountType := NewAmountType;
        CurrPage.UPDATE(FALSE);
        RoundingFactor := RoundingFactor2;
        RoundingFactorFormatString := MatrixMgt.GetFormatString(RoundingFactor,FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CashFlowForecast.COPY(NewCashFlowForecast);
        CashFlowForecast2.COPY(NewCashFlowForecast);
        CFPeriodLength := NewCashFlowPeriodLength;
        #4..7
        */
    //end;

    //Unsupported feature: Property Modification (Name) on "Set(PROCEDURE 1000).NewPeriodType(Parameter 1001)".

}
