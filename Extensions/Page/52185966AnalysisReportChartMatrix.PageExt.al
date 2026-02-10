#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185966 pageextension52185966 extends "Analysis Report Chart Matrix" 
{
    layout
    {
        modify("<Row No.>")
        {
            ApplicationArea = Basic;
        }
        modify("<Description>")
        {
            ApplicationArea = Basic;
        }
        modify(Column1)
        {

            //Unsupported feature: Property Modification (Name) on "Column1(Control 14)".

            ApplicationArea = Basic;
        }
        modify(Column2)
        {

            //Unsupported feature: Property Modification (Name) on "Column2(Control 13)".

            ApplicationArea = Basic;
        }
        modify(Column3)
        {

            //Unsupported feature: Property Modification (Name) on "Column3(Control 12)".

            ApplicationArea = Basic;
        }
        modify(Column4)
        {

            //Unsupported feature: Property Modification (Name) on "Column4(Control 11)".

            ApplicationArea = Basic;
        }
        modify(Column5)
        {

            //Unsupported feature: Property Modification (Name) on "Column5(Control 10)".

            ApplicationArea = Basic;
        }
        modify(Column6)
        {

            //Unsupported feature: Property Modification (Name) on "Column6(Control 9)".

            ApplicationArea = Basic;
        }
        modify(Column7)
        {

            //Unsupported feature: Property Modification (Name) on "Column7(Control 8)".

            ApplicationArea = Basic;
        }
        modify(Column8)
        {

            //Unsupported feature: Property Modification (Name) on "Column8(Control 7)".

            ApplicationArea = Basic;
        }
        modify(Column9)
        {

            //Unsupported feature: Property Modification (Name) on "Column9(Control 6)".

            ApplicationArea = Basic;
        }
        modify(Column10)
        {

            //Unsupported feature: Property Modification (Name) on "Column10(Control 5)".

            ApplicationArea = Basic;
        }
        modify(Column11)
        {

            //Unsupported feature: Property Modification (Name) on "Column11(Control 3)".

            ApplicationArea = Basic;
        }
        modify(Column12)
        {

            //Unsupported feature: Property Modification (Name) on "Column12(Control 4)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""<Row No.>"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""<Description>"(Control 15)".

    }
    actions
    {
        modify(ShowAll)
        {
            ApplicationArea = Basic;
        }
        modify(ShowNone)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowAll(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShowNone(Action 18)".

    }

    //Unsupported feature: Property Modification (Length) on "AnalysisLineDescription(Variable 1004)".

    //var
        //>>>> ORIGINAL VALUE:
        //AnalysisLineDescription : 100;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //AnalysisLineDescription : 80;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on "ColumnCaptions(Variable 1002)".

    //var
        //>>>> ORIGINAL VALUE:
        //ColumnCaptions : 100;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ColumnCaptions : 80;
        //Variable type has not been exported.

    //Unsupported feature: Property Deletion (Attributes) on "SetFilters(PROCEDURE 1)".



    //Unsupported feature: Code Modification on "UpdateColumnCaptions(PROCEDURE 19)".

    //procedure UpdateColumnCaptions();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CLEAR(ColumnCaptions);
        AnalysisReportChartSetup.FilterAnalysisColumn(AnalysisColumn);

        IF AnalysisColumn.FINDSET THEN
          REPEAT
            ColumnNo := ColumnNo + 1;
            ColumnCaptions[ColumnNo] := AnalysisColumn."Column Header";
            ColumnLineNos[ColumnNo] := AnalysisColumn."Line No.";
          UNTIL (AnalysisColumn.NEXT = 0) OR (ColumnNo = ARRAYLEN(ColumnCaptions));
        MaxColumns := ColumnNo;
        // Set unused columns to blank to prevent RTC to display control ID as caption
        FOR i := MaxColumns + 1 TO ARRAYLEN(ColumnCaptions) DO
          ColumnCaptions[i] := ' ';
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..6
            IF ColumnNo <= ARRAYLEN(ColumnCaptions) THEN BEGIN
              ColumnCaptions[ColumnNo] := AnalysisColumn."Column Header";
              ColumnLineNos[ColumnNo] := AnalysisColumn."Line No.";
            END;
          UNTIL AnalysisColumn.NEXT = 0;
        #10..13
        */
    //end;
}
