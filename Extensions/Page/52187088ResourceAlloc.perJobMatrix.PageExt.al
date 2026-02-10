#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187088 pageextension52187088 extends "Resource Alloc. per Job Matrix" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Name")
        {
            ApplicationArea = Basic;
        }
        modify(Col1)
        {
            ApplicationArea = Basic;
        }
        modify(Col2)
        {
            ApplicationArea = Basic;
        }
        modify(Col3)
        {
            ApplicationArea = Basic;
        }
        modify(Col4)
        {
            ApplicationArea = Basic;
        }
        modify(Col5)
        {
            ApplicationArea = Basic;
        }
        modify(Col6)
        {
            ApplicationArea = Basic;
        }
        modify(Col7)
        {
            ApplicationArea = Basic;
        }
        modify(Col8)
        {
            ApplicationArea = Basic;
        }
        modify(Col9)
        {
            ApplicationArea = Basic;
        }
        modify(Col10)
        {
            ApplicationArea = Basic;
        }
        modify(Col11)
        {
            ApplicationArea = Basic;
        }
        modify(Col12)
        {
            ApplicationArea = Basic;
        }
        modify(Col13)
        {
            ApplicationArea = Basic;
        }
        modify(Col14)
        {
            ApplicationArea = Basic;
        }
        modify(Col15)
        {
            ApplicationArea = Basic;
        }
        modify(Col16)
        {
            ApplicationArea = Basic;
        }
        modify(Col17)
        {
            ApplicationArea = Basic;
        }
        modify(Col18)
        {
            ApplicationArea = Basic;
        }
        modify(Col19)
        {
            ApplicationArea = Basic;
        }
        modify(Col20)
        {
            ApplicationArea = Basic;
        }
        modify(Col21)
        {
            ApplicationArea = Basic;
        }
        modify(Col22)
        {
            ApplicationArea = Basic;
        }
        modify(Col23)
        {
            ApplicationArea = Basic;
        }
        modify(Col24)
        {
            ApplicationArea = Basic;
        }
        modify(Col25)
        {
            ApplicationArea = Basic;
        }
        modify(Col26)
        {
            ApplicationArea = Basic;
        }
        modify(Col27)
        {
            ApplicationArea = Basic;
        }
        modify(Col28)
        {
            ApplicationArea = Basic;
        }
        modify(Col29)
        {
            ApplicationArea = Basic;
        }
        modify(Col30)
        {
            ApplicationArea = Basic;
        }
        modify(Col31)
        {
            ApplicationArea = Basic;
        }
        modify(Col32)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Name"(Control 27)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "Load(PROCEDURE 1)".


    //Unsupported feature: Code Modification on "MatrixOnAfterGetRecord(PROCEDURE 4)".

    //procedure MatrixOnAfterGetRecord();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        MatrixRec.RESET;
        MatrixRec.SETRANGE("Job No.","No.");
        MatrixRec.SETRANGE(Type,MatrixRec.Type::Resource);
        MatrixRec.SETRANGE("Schedule Line",TRUE);
        IF GETFILTER("Resource Filter") <> '' THEN
          MatrixRec.SETFILTER("No.",GETRANGEMIN("Resource Filter"),GETRANGEMAX("Resource Filter"));
        FOR I := 1 TO ARRAYLEN(MatrixColumnDateFilters) DO BEGIN
          MatrixCellQuantity := 0;
          MatrixRec.SETRANGE(
            "Planning Date",GetStartDate(MatrixColumnDateFilters[I]."Period Start"),MatrixColumnDateFilters[I]."Period End");
          OnMatrixOnAfterGetRecordOnBeforeMatrixRecLoop(MatrixRec,MatrixCellQuantity);
          IF MatrixRec.FIND('-') THEN
            REPEAT
              MatrixCellQuantity += ROUND(MatrixRec.Quantity * MatrixRec."Qty. per Unit of Measure",UOMMgt.QtyRndPrecision)
            UNTIL MatrixRec.NEXT = 0;

          IF MatrixCellQuantity <> 0 THEN
        #18..20
        END;

        SetVisible;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..8
          MatrixRec.SETRANGE("Planning Date",GetStartDate(MatrixColumnDateFilters[I]."Period Start"),
            MatrixColumnDateFilters[I]."Period End");
          IF MatrixRec.FIND('-') THEN
            REPEAT
              MatrixCellQuantity += ROUND(MatrixRec.Quantity * MatrixRec."Qty. per Unit of Measure",0.00001)
        #15..23
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: PlanningLine) (VariableCollection) on "MatrixOnDrillDown(PROCEDURE 7)".


    //Unsupported feature: Variable Insertion (Variable: PlanningLineForm) (VariableCollection) on "MatrixOnDrillDown(PROCEDURE 7)".



    //Unsupported feature: Code Modification on "MatrixOnDrillDown(PROCEDURE 7)".

    //procedure MatrixOnDrillDown();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        JobPlanningLine.SETFILTER("No.",GETRANGEMIN("Resource Filter"),GETRANGEMAX("Resource Filter"));
        JobPlanningLine.SETRANGE(
          "Planning Date",GetStartDate(MatrixColumnDateFilters[Column]."Period Start"),
          MatrixColumnDateFilters[Column]."Period End");
        JobPlanningLine.SETRANGE("Job No.","No.");
        JobPlanningLine.SETRANGE(Type,JobPlanningLine.Type::Resource);
        JobPlanningLine.SETRANGE("Schedule Line",TRUE);
        IsHandled := FALSE;
        OnAfterMatrixOnDrillDown(JobPlanningLine,IsHandled);
        IF IsHandled THEN
          EXIT;

        PAGE.RUNMODAL(PAGE::"Job Planning Lines",JobPlanningLine);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        PlanningLine.SETFILTER("No.",GETRANGEMIN("Resource Filter"),GETRANGEMAX("Resource Filter"));
        PlanningLine.SETRANGE("Planning Date",GetStartDate(MatrixColumnDateFilters[Column]."Period Start"),
          MatrixColumnDateFilters[Column]."Period End");
        PlanningLine.SETRANGE("Job No.","No.");
        PlanningLine.SETRANGE(Type,PlanningLine.Type::Resource);
        PlanningLine.SETRANGE("Schedule Line",TRUE);
        PlanningLineForm.SETTABLEVIEW(PlanningLine);
        PlanningLineForm.RUNMODAL;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetVisible(PROCEDURE 8)".


    //Unsupported feature: Property Deletion (Attributes) on "OnAfterMatrixOnDrillDown(PROCEDURE 3)".


    //Unsupported feature: Property Modification (Name) on "OnAfterMatrixOnDrillDown(PROCEDURE 3)".


    //Unsupported feature: Property Deletion (Attributes) on "OnMatrixOnAfterGetRecordOnBeforeMatrixRecLoop(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Name) on "OnMatrixOnAfterGetRecordOnBeforeMatrixRecLoop(PROCEDURE 2)".


    local procedure MatrixOnAfterGetCurrRecord()
    begin
    end;

    //Unsupported feature: Deletion (VariableCollection) on "MatrixOnDrillDown(PROCEDURE 7).JobPlanningLine(Variable 1001)".


    //Unsupported feature: Deletion (VariableCollection) on "MatrixOnDrillDown(PROCEDURE 7).IsHandled(Variable 1002)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterMatrixOnDrillDown(PROCEDURE 3).JobPlanningLine(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnAfterMatrixOnDrillDown(PROCEDURE 3).IsHandled(Parameter 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnMatrixOnAfterGetRecordOnBeforeMatrixRecLoop(PROCEDURE 2).JobPlanningLine(Parameter 1000)".


    //Unsupported feature: Deletion (ParameterCollection) on "OnMatrixOnAfterGetRecordOnBeforeMatrixRecLoop(PROCEDURE 2).MatrixCellQuantity(Parameter 1001)".

}
