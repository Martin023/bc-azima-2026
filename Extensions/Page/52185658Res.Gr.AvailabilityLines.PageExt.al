#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185658 pageextension52185658 extends "Res. Gr. Availability Lines" 
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
        modify("ResGr.""Qty. on Order (Job)""")
        {
            ApplicationArea = Basic;
        }
        modify("ResGr.""Qty. on Service Order""")
        {
            ApplicationArea = Basic;
        }
        modify(CapacityAfterOrders)
        {
            ApplicationArea = Basic;
        }
        modify("ResGr.""Qty. Quoted (Job)""")
        {
            ApplicationArea = Basic;
        }
        modify(CapacityAfterQuotes)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Start"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Name"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Capacity(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ResGr.""Qty. on Order (Job)"""(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ResGr.""Qty. on Service Order"""(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CapacityAfterOrders(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ResGr.""Qty. Quoted (Job)"""(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CapacityAfterQuotes(Control 12)".

    }
    var
        ResGrPeriodLength: Option Day,Week,Month,Quarter,Year,Period;


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
        ResGr.CALCFIELDS(Capacity,"Qty. on Order (Job)","Qty. Quoted (Job)","Qty. on Service Order");
        CapacityAfterOrders := ResGr.Capacity - ResGr."Qty. on Order (Job)" - ResGr."Qty. on Service Order";
        CapacityAfterQuotes := CapacityAfterOrders - ResGr."Qty. Quoted (Job)";
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
        EXIT(PeriodFormMgt.FindDate(Which,Rec,ResGrPeriodLength));
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
        EXIT(PeriodFormMgt.NextDate(Steps,Rec,ResGrPeriodLength));
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Set(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "Set(PROCEDURE 1)".

    //procedure Set();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ResGr.COPY(NewResGr);
        PeriodType := NewPeriodType;
        AmountType := NewAmountType;
        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ResGr.COPY(NewResGr);
        ResGrPeriodLength := NewResGrPeriodLength;
        AmountType := NewAmountType;
        CurrPage.UPDATE(FALSE);
        */
    //end;

    //Unsupported feature: Property Modification (Name) on "Set(PROCEDURE 1).NewPeriodType(Parameter 1001)".

}
