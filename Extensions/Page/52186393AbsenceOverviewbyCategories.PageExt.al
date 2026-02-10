#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186393 pageextension52186393 extends "Absence Overview by Categories" 
{
    layout
    {
        modify(EmployeeNoFilter)
        {
            ApplicationArea = Basic;
        }
        modify(PeriodType)
        {
            ApplicationArea = Basic;
        }
        modify(AbsenceAmountType)
        {
            ApplicationArea = Basic;
        }
        modify("MATRIX_CaptionRange")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "EmployeeNoFilter(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PeriodType(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AbsenceAmountType(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""MATRIX_CaptionRange"(Control 10)".

    }
    actions
    {
        modify(ShowMatrix)
        {
            ApplicationArea = Basic;
        }
        modify("Previous Set")
        {
            ToolTip = 'Previous Set';
            ApplicationArea = Basic;
        }
        modify("Next Set")
        {
            ToolTip = 'Next Set';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowMatrix(Action 1)".

    }

    //Unsupported feature: Property Modification (Length) on ""MATRIX_CaptionSet"(Variable 1057)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_CaptionSet" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_CaptionSet" : 1024;
        //Variable type has not been exported.

    local procedure MatrixUpdate(NewAbsenceType: Option "Absence to Date","Absence at Date";NewPeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";NewEmployeeNoFilter: Text[250])
    begin
        // AbsenceAmountType := NewAbsenceType;
        // PeriodType := NewPeriodType;
        // EmployeeNoFilter := NewEmployeeNoFilter;
    end;

    //Unsupported feature: Move on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1107).CurrentMatrixRecordOrdinal(Variable 1000)".


    //Unsupported feature: Move on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1107).RecRef(Variable 1002)".

}
