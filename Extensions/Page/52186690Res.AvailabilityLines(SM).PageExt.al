#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186690 pageextension52186690 extends "Res. Availability Lines (SM)" 
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
        modify(Capacity)
        {
            ApplicationArea = Basic;
        }
        modify("Res.""Qty. on Service Order""")
        {
            ApplicationArea = Basic;
        }
        modify(NetAvailability)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Start"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Name"(Control 14)".


        //Unsupported feature: Code Modification on "Capacity(Control 4).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ResCapacityEntry.SETRANGE("Resource No.",Res."No.");
            ResCapacityEntry.SETRANGE(Date,"Period Start","Period End");
            IsHandled := FALSE;
            OnAfterCapacityOnDrillDown(ResCapacityEntry,IsHandled);
            IF IsHandled THEN
              EXIT;

            PAGE.RUNMODAL(0,ResCapacityEntry);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ResCapacityEntry.SETRANGE("Resource No.",Res."No.");
            ResCapacityEntry.SETRANGE(Date,"Period Start","Period End");
            PAGE.RUNMODAL(0,ResCapacityEntry);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Capacity(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Res.""Qty. on Service Order"""(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NetAvailability(Control 18)".

    }

    var
        ResPeriodLength: Option Day,Week,Month,Quarter,Year,Period;


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
        EXIT(PeriodFormMgt.FindDate(Which,Rec,ResPeriodLength));
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
        EXIT(PeriodFormMgt.NextDate(Steps,Rec,ResPeriodLength));
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Set(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "Set(PROCEDURE 1)".

    //procedure Set();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Res.COPY(NewRes);
        PeriodType := NewPeriodType;
        AmountType := NewAmountType;
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        Res.COPY(NewRes);
        ResPeriodLength := NewResPeriodLength;
        AmountType := NewAmountType;
        CurrPage.UPDATE(FALSE);
        */
    //end;

    //Unsupported feature: Property Modification (Name) on "Set(PROCEDURE 1).NewPeriodType(Parameter 1001)".

}
