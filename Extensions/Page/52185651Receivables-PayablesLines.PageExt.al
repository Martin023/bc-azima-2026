#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185651 pageextension52185651 extends "Receivables-Payables Lines" 
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
        modify(CustBalancesDue)
        {
            ApplicationArea = Basic;
        }
        modify(VendorBalancesDue)
        {
            ApplicationArea = Basic;
        }
        modify(ReceivablesPayables)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Start"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Name"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CustBalancesDue(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "VendorBalancesDue(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ReceivablesPayables(Control 12)".

    }
    var
        EntrdPeriodLength: Option Day,Week,Month,Quarter,Year,Period;


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
        EXIT(PeriodFormMgt.FindDate(Which,Rec,EntrdPeriodLength));
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
        EXIT(PeriodFormMgt.NextDate(Steps,Rec,EntrdPeriodLength));
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Set(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "Set(PROCEDURE 1)".

    //procedure Set();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        GLSetup.COPY(NewGLSetup);
        PeriodType := NewPeriodType;
        AmountType := NewAmountType;
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        GLSetup.COPY(NewGLSetup);
        EntrdPeriodLength := NewEntrdPeriodLength;
        AmountType := NewAmountType;
        CurrPage.UPDATE(FALSE);
        */
    //end;

    //Unsupported feature: Property Modification (Name) on "Set(PROCEDURE 1).NewPeriodType(Parameter 1001)".

}
