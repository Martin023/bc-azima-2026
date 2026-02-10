#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185674 pageextension52185674 extends "Bank Account Balance Lines" 
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
        modify(NetChange)
        {
            ApplicationArea = Basic;
        }
        modify("BankAcc.""Net Change (LCY)""")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Start"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Name"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NetChange(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BankAcc.""Net Change (LCY)"""(Control 6)".

    }
    var
        BankAccPeriodLength: Option Day,Week,Month,Quarter,Year,Period;


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
        EXIT(PeriodFormMgt.FindDate(Which,Rec,BankAccPeriodLength));
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
        EXIT(PeriodFormMgt.NextDate(Steps,Rec,BankAccPeriodLength));
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Set(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "Set(PROCEDURE 1)".

    //procedure Set();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        BankAcc.COPY(NewBankAcc);
        PeriodType := NewPeriodType;
        AmountType := NewAmountType;
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        BankAcc.COPY(NewBankAcc);
        BankAccPeriodLength := NewBankAccPeriodLength;
        AmountType := NewAmountType;
        CurrPage.UPDATE(FALSE);
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetDateFilter(PROCEDURE 5)".


    //Unsupported feature: Property Modification (Name) on "Set(PROCEDURE 1).NewPeriodType(Parameter 1001)".

}
