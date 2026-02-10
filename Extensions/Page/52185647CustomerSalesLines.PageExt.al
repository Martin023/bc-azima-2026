#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185647 pageextension52185647 extends "Customer Sales Lines" 
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
        modify(BalanceDueLCY)
        {
            ApplicationArea = Basic;
        }
        modify("Cust.""Sales (LCY)""")
        {
            ApplicationArea = Basic;
        }
        modify("Cust.""Profit (LCY)""")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Start"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Name"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BalanceDueLCY(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cust.""Sales (LCY)"""(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cust.""Profit (LCY)"""(Control 10)".

    }
    var
        CustPeriodLength: Option Day,Week,Month,Quarter,Year,Period;


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
        EXIT(PeriodFormMgt.FindDate(Which,Rec,CustPeriodLength));
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
        EXIT(PeriodFormMgt.NextDate(Steps,Rec,CustPeriodLength));
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Set(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "Set(PROCEDURE 1)".

    //procedure Set();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Cust.COPY(NewCust);
        PeriodType := NewPeriodType;
        AmountType := NewAmountType;
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        Cust.COPY(NewCust);
        CustPeriodLength := NewCustPeriodLength;
        AmountType := NewAmountType;
        CurrPage.UPDATE(FALSE);
        */
    //end;

    //Unsupported feature: Property Modification (Name) on "Set(PROCEDURE 1).NewPeriodType(Parameter 1001)".

}
