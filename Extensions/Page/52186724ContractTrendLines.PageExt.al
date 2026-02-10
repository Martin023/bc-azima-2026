#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186724 pageextension52186724 extends "Contract Trend Lines" 
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
        modify("ServContract.""Contract Prepaid Amount""")
        {
            ApplicationArea = Basic;
        }
        modify("ServContract.""Contract Invoice Amount""")
        {
            ApplicationArea = Basic;
        }
        modify("ServContract.""Contract Cost Amount""")
        {
            ApplicationArea = Basic;
        }
        modify("ServContract.""Contract Discount Amount""")
        {
            ApplicationArea = Basic;
        }
        modify(ProfitAmount)
        {
            ApplicationArea = Basic;
        }
        modify(ProfitPct)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "ProfitPct(Control 16)".


            //Unsupported feature: Property Modification (Name) on "ProfitPct(Control 16)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Start"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Name"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ServContract.""Contract Prepaid Amount"""(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ServContract.""Contract Invoice Amount"""(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ServContract.""Contract Cost Amount"""(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ServContract.""Contract Discount Amount"""(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ProfitAmount(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ProfitPct(Control 16)".

    }
    var
        ServItemPeriodLength: Option Day,Week,Month,Quarter,Year,Period;

    var
        "Profit%": Decimal;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SetDateFilter;
        ServContract.CALCFIELDS(
          "Contract Invoice Amount",
          "Contract Discount Amount",
          "Contract Cost Amount",
          "Contract Prepaid Amount");
        ProfitAmount := ServContract."Contract Invoice Amount" - ServContract."Contract Cost Amount";
        IF ServContract."Contract Invoice Amount" <> 0 THEN
          ProfitPct := ROUND((ProfitAmount / ServContract."Contract Invoice Amount") * 100,0.01)
        ELSE
          ProfitPct := 0;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..8
          "Profit%" := ROUND((ProfitAmount / ServContract."Contract Invoice Amount") * 100,0.01)
        ELSE
          "Profit%" := 0;
        */
    //end;


    //Unsupported feature: Code Modification on "OnFindRecord".

    //trigger OnFindRecord()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        EXIT(PeriodFormMgt.FindDate(Which,Rec,PeriodType));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        EXIT(PeriodFormMgt.FindDate(Which,Rec,ServItemPeriodLength));
        */
    //end;


    //Unsupported feature: Code Modification on "OnNextRecord".

    //trigger OnNextRecord()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        EXIT(PeriodFormMgt.NextDate(Steps,Rec,PeriodType));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        EXIT(PeriodFormMgt.NextDate(Steps,Rec,ServItemPeriodLength));
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Set(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "Set(PROCEDURE 1)".

    //procedure Set();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ServContract.COPY(NewServContract);
        PeriodType := NewPeriodType;
        AmountType := NewAmountType;
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ServContract.COPY(NewServContract);
        ServItemPeriodLength := NewServItemPeriodLength;
        AmountType := NewAmountType;
        CurrPage.UPDATE(FALSE);
        */
    //end;

    //Unsupported feature: Property Modification (Name) on "Set(PROCEDURE 1).NewPeriodType(Parameter 1001)".

}
