#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185774 pageextension52185774 extends "Items by Location" 
{

    //Unsupported feature: Property Modification (PageType) on ""Items by Location"(Page 491)".

    layout
    {
        modify(ShowInTransit)
        {
            ApplicationArea = Basic;
        }
        modify(ShowColumnName)
        {
            ApplicationArea = Basic;
        }
        modify("MATRIX_CaptionRange")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowInTransit(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowColumnName(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""MATRIX_CaptionRange"(Control 30)".

        modify(MatrixForm)
        {
            Visible = false;
        }
        addafter(Options)
        {
            group("Matrix Options")
            {
                Caption = 'Matrix Options';
            }
        }
    }
    actions
    {
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

        //Unsupported feature: Property Deletion (PromotedOnly) on ""Previous Set"(Action 31)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Next Set"(Action 32)".

        addfirst(Processing)
        {
            action(ShowMatrix)
            {
                ApplicationArea = Basic;
                Caption = 'Show Matrix';
                Image = ShowMatrix;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ItemsByLocationMatrix: Page "Items by Location Matrix";
                begin
                    //ItemsByLocationMatrix.Load(MATRIX_CaptionSet,MatrixRecords,MatrixRecord);
                    ItemsByLocationMatrix.SetRecord(Rec);
                    ItemsByLocationMatrix.RunModal;
                end;
            }
        }
    }


    //Unsupported feature: Property Modification (Length) on ""MATRIX_CaptionSet"(Variable 1008)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_CaptionSet" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_CaptionSet" : 1024;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on ""MATRIX_PKFirstRecInCurrSet"(Variable 1001)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_PKFirstRecInCurrSet" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_PKFirstRecInCurrSet" : 100;
        //Variable type has not been exported.

    var
        MatrixRecord: Record Location;


    //Unsupported feature: Code Modification on "SetColumns(PROCEDURE 6)".

    //procedure SetColumns();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TempMatrixLocation.SETRANGE("Use As In-Transit",ShowInTransit);

        CLEAR(MATRIX_CaptionSet);
        CLEAR(MatrixRecords);
        CurrentMatrixRecordOrdinal := 1;

        MatrixRecordRef.GETTABLE(TempMatrixLocation);
        MatrixRecordRef.SETTABLE(TempMatrixLocation);

        IF ShowColumnName THEN
          CaptionFieldNo := TempMatrixLocation.FIELDNO(Name)
        ELSE
          CaptionFieldNo := TempMatrixLocation.FIELDNO(Code);

        MatrixMgt.GenerateMatrixData(MatrixRecordRef,SetWanted,ARRAYLEN(MatrixRecords),CaptionFieldNo,MATRIX_PKFirstRecInCurrSet,
          MATRIX_CaptionSet,MATRIX_CaptionRange,MATRIX_CurrSetLength);

        IF MATRIX_CaptionSet[1] = '' THEN BEGIN
          MATRIX_CaptionSet[1] := UnspecifiedLocationCodeTxt;
          MATRIX_CaptionRange := STRSUBSTNO('%1%2',MATRIX_CaptionSet[1],MATRIX_CaptionRange);
        END;

        IF MATRIX_CurrSetLength > 0 THEN BEGIN
          TempMatrixLocation.SETPOSITION(MATRIX_PKFirstRecInCurrSet);
          TempMatrixLocation.FIND;
          REPEAT
            MatrixRecords[CurrentMatrixRecordOrdinal].COPY(TempMatrixLocation);
            CurrentMatrixRecordOrdinal := CurrentMatrixRecordOrdinal + 1;
          UNTIL (CurrentMatrixRecordOrdinal > MATRIX_CurrSetLength) OR (TempMatrixLocation.NEXT <> 1);
        END;

        UpdateMatrixSubform;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        MatrixRecord.SETRANGE("Use As In-Transit",ShowInTransit);
        #2..6
        MatrixRecordRef.GETTABLE(MatrixRecord);
        MatrixRecordRef.SETTABLE(MatrixRecord);

        IF ShowColumnName THEN
          CaptionFieldNo := MatrixRecord.FIELDNO(Name)
        ELSE
          CaptionFieldNo := MatrixRecord.FIELDNO(Code);
        #14..17
        IF MATRIX_CurrSetLength > 0 THEN BEGIN
          MatrixRecord.SETPOSITION(MATRIX_PKFirstRecInCurrSet);
          MatrixRecord.FIND;
          REPEAT
            MatrixRecords[CurrentMatrixRecordOrdinal].COPY(MatrixRecord);
            CurrentMatrixRecordOrdinal := CurrentMatrixRecordOrdinal + 1;
          UNTIL (CurrentMatrixRecordOrdinal > MATRIX_CurrSetLength) OR (MatrixRecord.NEXT <> 1);
        END;
        */
    //end;

    //Unsupported feature: Property Deletion (DataCaptionExpr).

}
