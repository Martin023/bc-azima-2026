#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187090 pageextension52187090 extends "Res. All. per Service  Matrix" 
{

    //Unsupported feature: Property Insertion (DataCaptionExpr) on ""Res. All. per Service  Matrix"(Page 9215)".

    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
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


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".

    }
    actions
    {
        modify("&Card")
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
        modify("Resource A&vailability")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""&Card"(Action 77)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Costs(Action 78)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Prices(Action 79)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource A&vailability"(Action 76)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "Load(PROCEDURE 1)".


    //Unsupported feature: Variable Insertion (Variable: PlanningLineForm) (VariableCollection) on "MatrixOnDrillDown(PROCEDURE 7)".


    //Unsupported feature: Code Modification on "MatrixOnDrillDown(PROCEDURE 7)".

    //procedure MatrixOnDrillDown();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF GETFILTER("Resource Filter") <> '' THEN
          PlanningLine.SETFILTER("Resource No.",GETRANGEMIN("Resource Filter"),
            GETRANGEMAX("Resource Filter"));
        PlanningLine.SETRANGE("Allocation Date",MatrixColumnDateFilters[Column]."Period Start",
          MatrixColumnDateFilters[Column]."Period End");
        PlanningLine.SETRANGE("Document Type","Document Type");
        PlanningLine.SETFILTER(Status,'%1|%2',PlanningLine.Status::Active,PlanningLine.Status::Finished);
        PlanningLine.SETRANGE("Document No.","No.");

        PAGE.RUNMODAL(PAGE::"Service Order Allocations",PlanningLine);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..8
        PlanningLineForm.SETTABLEVIEW(PlanningLine);
        PlanningLineForm.RUNMODAL;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetVisible(PROCEDURE 6)".


    local procedure MatrixOnFindRecord()
    begin
    end;

    local procedure MatrixOnNextRecord()
    begin
    end;

    local procedure MatrixOnAfterGetCurrRecord()
    begin
    end;

    local procedure Caption(): Text[100]
    begin
    end;
}
