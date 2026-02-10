#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187100 pageextension52187100 extends "Resource Capacity Matrix" 
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
        modify(Card)
        {
            ApplicationArea = Basic;
        }
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
        modify("Ledger E&ntries")
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
        modify("&Set Capacity")
        {
            ApplicationArea = Basic;
        }
        modify("Resource A&vailability")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ledger E&ntries"(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Costs(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Prices(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Set Capacity"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource A&vailability"(Action 16)".

    }
    var
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";

    //Unsupported feature: Parameter Insertion (Parameter: PeriodType1) (ParameterCollection) on "Load(PROCEDURE 3)".


    //Unsupported feature: Property Deletion (Attributes) on "Load(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "Load(PROCEDURE 3)".

    //procedure Load();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        QtyType := QtyType1;
        COPYARRAY(MATRIX_ColumnCaption,MatrixColumns1,1);
        FOR i := 1 TO ARRAYLEN(MatrixRecords) DO
          MatrixRecords[i].COPY(MatrixRecords1[i]);
        MATRIX_NoOfMatrixColumns := NoOfMatrixColumns1;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        PeriodType := PeriodType1;
        #1..5
        */
    //end;


    //Unsupported feature: Code Modification on "MatrixOnDrillDown(PROCEDURE 4)".

    //procedure MatrixOnDrillDown();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        SetDateFilter(ColumnID);
        ResCapacityEntries.SETCURRENTKEY("Resource No.",Date);
        ResCapacityEntries.SETRANGE("Resource No.","No.");
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

    //Unsupported feature: Deletion (VariableCollection) on "MatrixOnDrillDown(PROCEDURE 4).IsHandled(Variable 1002)".

}
