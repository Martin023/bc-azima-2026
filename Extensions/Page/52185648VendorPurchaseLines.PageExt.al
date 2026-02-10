#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185648 pageextension52185648 extends "Vendor Purchase Lines" 
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
        modify("Vend.""Purchases (LCY)""")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Start"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Name"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "BalanceDueLCY(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vend.""Purchases (LCY)"""(Control 8)".

    }
    var
        VendPeriodLength: Option Day,Week,Month,Quarter,Year,Period;


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
        EXIT(PeriodFormMgt.FindDate(Which,Rec,VendPeriodLength));
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
        EXIT(PeriodFormMgt.NextDate(Steps,Rec,VendPeriodLength));
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Set(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "Set(PROCEDURE 1)".

    //procedure Set();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Vend.COPY(NewVend);
        PeriodType := NewPeriodType;
        AmountType := NewAmountType;
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        Vend.COPY(NewVend);
        VendPeriodLength := NewVendPeriodLength;
        AmountType := NewAmountType;
        CurrPage.UPDATE(FALSE);
        */
    //end;

    //Unsupported feature: Property Modification (Name) on "Set(PROCEDURE 1).NewPeriodType(Parameter 1001)".

}
