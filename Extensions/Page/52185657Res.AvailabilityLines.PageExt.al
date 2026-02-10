#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185657 pageextension52185657 extends "Res. Availability Lines" 
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

            //Unsupported feature: Property Modification (SourceExpr) on "Capacity(Control 4)".

        }
        modify("Resource.""Qty. on Order (Job)""")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Resource.""Qty. on Order (Job)"""(Control 6)".


            //Unsupported feature: Property Modification (Name) on ""Resource.""Qty. on Order (Job)"""(Control 6)".

        }
        modify(CapacityAfterOrders)
        {
            ApplicationArea = Basic;
        }
        modify("Resource.""Qty. Quoted (Job)""")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Resource.""Qty. Quoted (Job)"""(Control 10)".


            //Unsupported feature: Property Modification (Name) on ""Resource.""Qty. Quoted (Job)"""(Control 10)".

        }
        modify(CapacityAfterQuotes)
        {
            ApplicationArea = Basic;
        }
        modify("Resource.""Qty. on Service Order""")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Resource.""Qty. on Service Order"""(Control 16)".


            //Unsupported feature: Property Modification (Name) on ""Resource.""Qty. on Service Order"""(Control 16)".

        }
        modify(NetAvailability)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Start"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Name"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Capacity(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource.""Qty. on Order (Job)"""(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CapacityAfterOrders(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource.""Qty. Quoted (Job)"""(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CapacityAfterQuotes(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource.""Qty. on Service Order"""(Control 16)".

        modify(QtyOnAssemblyOrder)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "NetAvailability(Control 18)".

    }

    //Unsupported feature: Property Modification (Id) on "CapacityAfterOrders(Variable 1002)".

    //var
        //>>>> ORIGINAL VALUE:
        //CapacityAfterOrders : 1002;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CapacityAfterOrders : 1000;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Id) on "NetAvailability(Variable 1000)".

    //var
        //>>>> ORIGINAL VALUE:
        //NetAvailability : 1000;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //NetAvailability : 1002;
        //Variable type has not been exported.

    var
        ResPeriodLength: Option Day,Week,Month,Quarter,Year,Period;

    var
        Res: Record Resource;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SetDateFilter;
        CalcLine;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        SetDateFilter;
        Res.CALCFIELDS(Capacity,"Qty. on Order (Job)","Qty. Quoted (Job)","Qty. on Service Order");
        CapacityAfterOrders := Res.Capacity - Res."Qty. on Order (Job)";
        CapacityAfterQuotes := CapacityAfterOrders - Res."Qty. Quoted (Job)";
        NetAvailability := CapacityAfterQuotes - Res."Qty. on Service Order";
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
        Resource.COPY(NewRes);
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


    //Unsupported feature: Code Modification on "SetDateFilter(PROCEDURE 4)".

    //procedure SetDateFilter();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF AmountType = AmountType::"Net Change" THEN
          Resource.SETRANGE("Date Filter","Period Start","Period End")
        ELSE
          Resource.SETRANGE("Date Filter",0D,"Period End");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF AmountType = AmountType::"Net Change" THEN
          Res.SETRANGE("Date Filter","Period Start","Period End")
        ELSE
          Res.SETRANGE("Date Filter",0D,"Period End");
        */
    //end;

    //Unsupported feature: Property Modification (Name) on "Set(PROCEDURE 1).NewPeriodType(Parameter 1001)".

}
