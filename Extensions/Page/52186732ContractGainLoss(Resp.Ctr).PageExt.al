#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186732 pageextension52186732 extends "Contract Gain/Loss (Resp.Ctr)"
{
    layout
    {
        modify(PeriodStart)
        {
            ApplicationArea = Basic;
        }
        modify(RespCrFilter)
        {
            ApplicationArea = Basic;
        }
        modify(PeriodType)
        {
            ApplicationArea = Basic;
        }
        modify(AmountType)
        {
            ApplicationArea = Basic;
        }
        modify("MATRIX_CaptionRange")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "PeriodStart(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RespCrFilter(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PeriodType(Control 1107)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AmountType(Control 1108)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""MATRIX_CaptionRange"(Control 1109)".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowMatrix(Action 77)".

        moveafter(ShowMatrix; "Next Set")
    }

    //Unsupported feature: Property Modification (Length) on ""MATRIX_CaptionSet"(Variable 1100)".

    //var
    //>>>> ORIGINAL VALUE:
    //"MATRIX_CaptionSet" : 80;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //"MATRIX_CaptionSet" : 1024;
    //Variable type has not been exported.

    var
        NoOfColumns: Integer;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF PeriodStart = 0D THEN
      PeriodStart := WORKDATE;
    MATRIX_GenerateColumnCaptions(SetWanted::Initial);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IF PeriodStart = 0D THEN
      PeriodStart := WORKDATE;
    NoOfColumns := GetMatrixDimension;
    MATRIX_GenerateColumnCaptions(SetWanted::Initial);
    */
    //end;

    local procedure GetMatrixDimension(): Integer
    begin
        //exit(ArrayLen(MATRIX_CaptionSet));
    end;

    //Unsupported feature: Move on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1107).CurrentMatrixRecordOrdinal(Variable 1000)".


    //Unsupported feature: Move on ""MATRIX_GenerateColumnCaptions"(PROCEDURE 1107).RecRef(Variable 1002)".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
