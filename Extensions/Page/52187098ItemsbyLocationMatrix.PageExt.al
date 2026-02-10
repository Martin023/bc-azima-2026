#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187098 pageextension52187098 extends "Items by Location Matrix" 
{

    //Unsupported feature: Property Modification (PageType) on ""Items by Location Matrix"(Page 9231)".

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
        modify(Field13)
        {
            ApplicationArea = Basic;
        }
        modify(Field14)
        {
            ApplicationArea = Basic;
        }
        modify(Field15)
        {
            ApplicationArea = Basic;
        }
        modify(Field16)
        {
            ApplicationArea = Basic;
        }
        modify(Field17)
        {
            ApplicationArea = Basic;
        }
        modify(Field18)
        {
            ApplicationArea = Basic;
        }
        modify(Field19)
        {
            ApplicationArea = Basic;
        }
        modify(Field20)
        {
            ApplicationArea = Basic;
        }
        modify(Field21)
        {
            ApplicationArea = Basic;
        }
        modify(Field22)
        {
            ApplicationArea = Basic;
        }
        modify(Field23)
        {
            ApplicationArea = Basic;
        }
        modify(Field24)
        {
            ApplicationArea = Basic;
        }
        modify(Field25)
        {
            ApplicationArea = Basic;
        }
        modify(Field26)
        {
            ApplicationArea = Basic;
        }
        modify(Field27)
        {
            ApplicationArea = Basic;
        }
        modify(Field28)
        {
            ApplicationArea = Basic;
        }
        modify(Field29)
        {
            ApplicationArea = Basic;
        }
        modify(Field30)
        {
            ApplicationArea = Basic;
        }
        modify(Field31)
        {
            ApplicationArea = Basic;
        }
        modify(Field32)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".

    }
    actions
    {

        //Unsupported feature: Property Modification (ActionContainerType) on "ActionContainer1900000003(Action 1900000003)".


        //Unsupported feature: Property Insertion (Level) on "ActionContainer1900000003(Action 1900000003)".

        modify("<Action3>")
        {
            ApplicationArea = Basic;
        }
        modify(Period)
        {
            ApplicationArea = Basic;
        }
        modify(Variant)
        {
            ApplicationArea = Basic;
        }
        modify(Location)
        {
            ApplicationArea = Basic;
        }
        modify("BOM Level")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""<Action3>"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Period(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Variant(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Location(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BOM Level"(Action 6)".

    }
    var
        MatrixRecord: Record Location;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        MATRIX_CurrentColumnOrdinal := 0;
        IF TempMatrixLocation.FINDSET THEN
          REPEAT
            MATRIX_CurrentColumnOrdinal := MATRIX_CurrentColumnOrdinal + 1;
            MATRIX_OnAfterGetRecord(MATRIX_CurrentColumnOrdinal);
          UNTIL (TempMatrixLocation.NEXT = 0) OR (MATRIX_CurrentColumnOrdinal = MATRIX_NoOfMatrixColumns);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        MATRIX_CurrentColumnOrdinal := 0;
        IF MatrixRecord.FIND('-') THEN
        #3..5
          UNTIL (MatrixRecord.NEXT(1) = 0) OR (MATRIX_CurrentColumnOrdinal = MATRIX_NoOfMatrixColumns);
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: Item) (VariableCollection) on ""MATRIX_OnAfterGetRecord"(PROCEDURE 1047)".



    //Unsupported feature: Code Modification on ""MATRIX_OnAfterGetRecord"(PROCEDURE 1047)".

    //procedure "MATRIX_OnAfterGetRecord"();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TempItem.COPY(Rec);
        TempItem.SETRANGE("Location Filter",MatrixRecords[ColumnID].Code);
        TempItem.CALCFIELDS(Inventory);
        MATRIX_CellData[ColumnID] := TempItem.Inventory;
        SetVisible;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        Item.COPY(Rec);
        Item.SETRANGE("Location Filter",MatrixRecords[ColumnID].Code);
        Item.CALCFIELDS(Inventory);
        MATRIX_CellData[ColumnID] := Item.Inventory;
        SetVisible;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Load(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "Load(PROCEDURE 3)".

    //procedure Load();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        MATRIX_CurrSetLength := CurrSetLength;
        COPYARRAY(MATRIX_ColumnCaption,MatrixColumns1,1);
        COPYARRAY(MatrixRecords,MatrixRecords1,1);
        TempMatrixLocation.COPY(MatrixRecord1,TRUE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        COPYARRAY(MATRIX_ColumnCaption,MatrixColumns1,1);
        COPYARRAY(MatrixRecords,MatrixRecords1,1);
        MatrixRecord.COPY(MatrixRecord1);
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetVisible(PROCEDURE 6)".



    //Unsupported feature: Code Modification on "SetVisible(PROCEDURE 6)".

    //procedure SetVisible();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        Field1Visible := MATRIX_CurrSetLength > 0;
        Field2Visible := MATRIX_CurrSetLength > 1;
        Field3Visible := MATRIX_CurrSetLength > 2;
        Field4Visible := MATRIX_CurrSetLength > 3;
        Field5Visible := MATRIX_CurrSetLength > 4;
        Field6Visible := MATRIX_CurrSetLength > 5;
        Field7Visible := MATRIX_CurrSetLength > 6;
        Field8Visible := MATRIX_CurrSetLength > 7;
        Field9Visible := MATRIX_CurrSetLength > 8;
        Field10Visible := MATRIX_CurrSetLength > 9;
        Field11Visible := MATRIX_CurrSetLength > 10;
        Field12Visible := MATRIX_CurrSetLength > 11;
        Field13Visible := MATRIX_CurrSetLength > 12;
        Field14Visible := MATRIX_CurrSetLength > 13;
        Field15Visible := MATRIX_CurrSetLength > 14;
        Field16Visible := MATRIX_CurrSetLength > 15;
        Field17Visible := MATRIX_CurrSetLength > 16;
        Field18Visible := MATRIX_CurrSetLength > 17;
        Field19Visible := MATRIX_CurrSetLength > 18;
        Field20Visible := MATRIX_CurrSetLength > 19;
        Field21Visible := MATRIX_CurrSetLength > 20;
        Field22Visible := MATRIX_CurrSetLength > 21;
        Field23Visible := MATRIX_CurrSetLength > 22;
        Field24Visible := MATRIX_CurrSetLength > 23;
        Field25Visible := MATRIX_CurrSetLength > 24;
        Field26Visible := MATRIX_CurrSetLength > 25;
        Field27Visible := MATRIX_CurrSetLength > 26;
        Field28Visible := MATRIX_CurrSetLength > 27;
        Field29Visible := MATRIX_CurrSetLength > 28;
        Field30Visible := MATRIX_CurrSetLength > 29;
        Field31Visible := MATRIX_CurrSetLength > 30;
        Field32Visible := MATRIX_CurrSetLength > 31;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        Field1Visible := MATRIX_ColumnCaption[1] <> '';
        Field2Visible := MATRIX_ColumnCaption[2] <> '';
        Field3Visible := MATRIX_ColumnCaption[3] <> '';
        Field4Visible := MATRIX_ColumnCaption[4] <> '';
        Field5Visible := MATRIX_ColumnCaption[5] <> '';
        Field6Visible := MATRIX_ColumnCaption[6] <> '';
        Field7Visible := MATRIX_ColumnCaption[7] <> '';
        Field8Visible := MATRIX_ColumnCaption[8] <> '';
        Field9Visible := MATRIX_ColumnCaption[9] <> '';
        Field10Visible := MATRIX_ColumnCaption[10] <> '';
        Field11Visible := MATRIX_ColumnCaption[11] <> '';
        Field12Visible := MATRIX_ColumnCaption[12] <> '';
        Field13Visible := MATRIX_ColumnCaption[13] <> '';
        Field14Visible := MATRIX_ColumnCaption[14] <> '';
        Field15Visible := MATRIX_ColumnCaption[15] <> '';
        Field16Visible := MATRIX_ColumnCaption[16] <> '';
        Field17Visible := MATRIX_ColumnCaption[17] <> '';
        Field18Visible := MATRIX_ColumnCaption[18] <> '';
        Field19Visible := MATRIX_ColumnCaption[19] <> '';
        Field20Visible := MATRIX_ColumnCaption[20] <> '';
        Field21Visible := MATRIX_ColumnCaption[21] <> '';
        Field22Visible := MATRIX_ColumnCaption[22] <> '';
        Field23Visible := MATRIX_ColumnCaption[23] <> '';
        Field24Visible := MATRIX_ColumnCaption[24] <> '';
        Field25Visible := MATRIX_ColumnCaption[25] <> '';
        Field26Visible := MATRIX_ColumnCaption[26] <> '';
        Field27Visible := MATRIX_ColumnCaption[27] <> '';
        Field28Visible := MATRIX_ColumnCaption[28] <> '';
        Field29Visible := MATRIX_ColumnCaption[29] <> '';
        Field30Visible := MATRIX_ColumnCaption[30] <> '';
        Field31Visible := MATRIX_ColumnCaption[31] <> '';
        Field32Visible := MATRIX_ColumnCaption[32] <> '';
        */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on ""MATRIX_OnAfterGetRecord"(PROCEDURE 1047).TempItem(Variable 1001)".


    //Unsupported feature: Deletion (ParameterCollection) on "Load(PROCEDURE 3).CurrSetLength(Parameter 1003)".

}
