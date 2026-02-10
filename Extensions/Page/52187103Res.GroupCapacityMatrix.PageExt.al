#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187103 pageextension52187103 extends "Res. Group Capacity Matrix" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(Field1)
        {
            ApplicationArea = Basic;
        }
        modify(Field2)
        {
            ApplicationArea = Basic;
        }
        modify(Field3)
        {
            ApplicationArea = Basic;
        }
        modify(Field4)
        {
            ApplicationArea = Basic;
        }
        modify(Field5)
        {
            ApplicationArea = Basic;
        }
        modify(Field6)
        {
            ApplicationArea = Basic;
        }
        modify(Field7)
        {
            ApplicationArea = Basic;
        }
        modify(Field8)
        {
            ApplicationArea = Basic;
        }
        modify(Field9)
        {
            ApplicationArea = Basic;
        }
        modify(Field10)
        {
            ApplicationArea = Basic;
        }
        modify(Field11)
        {
            ApplicationArea = Basic;
        }
        modify(Field12)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".

    }
    actions
    {
        modify(Statistics)
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify(Costs)
        {
            ApplicationArea = Basic;
        }
        modify(Prices)
        {
            ApplicationArea = Basic;
        }
        modify(ResGroupAvailability)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Costs(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Prices(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ResGroupAvailability(Action 13)".

    }

    //Unsupported feature: Property Modification (Id) on "PeriodFormMgt(Variable 1002)".

    //var
        //>>>> ORIGINAL VALUE:
        //PeriodFormMgt : 1002;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //PeriodFormMgt : 1079;
        //Variable type has not been exported.


    //Unsupported feature: Code Modification on "MatrixOnDrillDown(PROCEDURE 4)".

    //procedure MatrixOnDrillDown();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SetDateFilter(ColumnID);
        ResCapacityEntries.SETCURRENTKEY("Resource Group No.",Date);
        ResCapacityEntries.SETRANGE("Resource Group No.","No.");
        ResCapacityEntries.SETFILTER(Date,GETFILTER("Date Filter"));
        IsHandled := FALSE;
        OnAfterMatrixOnDrillDown(ResCapacityEntries,IsHandled);
        IF IsHandled THEN
          EXIT;

        PAGE.RUN(0,ResCapacityEntries);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        PAGE.RUN(0,ResCapacityEntries);
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Load(PROCEDURE 3)".


    //Unsupported feature: Deletion (VariableCollection) on "MatrixOnDrillDown(PROCEDURE 4).IsHandled(Variable 1002)".

}
