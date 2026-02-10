#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187124 pageextension52187124 extends "Transfer Routes Matrix" 
{

    //Unsupported feature: Property Modification (PageType) on ""Transfer Routes Matrix"(Page 9285)".

    layout
    {
        modify("Code")
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

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 3)".

    }

    //Unsupported feature: Property Modification (Id) on "MatrixRecords(Variable 1000)".

    //var
        //>>>> ORIGINAL VALUE:
        //MatrixRecords : 1000;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //MatrixRecords : 1084;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on "Specification(Variable 1080)".

    //var
        //>>>> ORIGINAL VALUE:
        //Specification : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //Specification : 250;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on ""MATRIX_CellData"(Variable 1086)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_CellData" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_CellData" : 1024;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on ""MATRIX_CaptionSet"(Variable 1087)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_CaptionSet" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_CaptionSet" : 1024;
        //Variable type has not been exported.

    //Unsupported feature: Property Deletion (Attributes) on "Load(PROCEDURE 1088)".



    //Unsupported feature: Code Modification on ""MATRIX_OnAfterGetRecord"(PROCEDURE 1091)".

    //procedure "MATRIX_OnAfterGetRecord"();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ShowRouteSpecification(MATRIX_ColumnOrdinal);
        IF (FORMAT(Specification) = '') AND (MatrixRecords[MATRIX_ColumnOrdinal].Code <> Code) THEN
          Specification := '...';

        MATRIX_CellData[MATRIX_ColumnOrdinal] := FORMAT(Specification);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ShowRouteSpecification(MATRIX_ColumnOrdinal);
        MATRIX_CellData[MATRIX_ColumnOrdinal] := FORMAT(Specification);
        */
    //end;


    //Unsupported feature: Code Modification on ""MATRIX_OnAssistEdit"(PROCEDURE 10)".

    //procedure "MATRIX_OnAssistEdit"();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF MatrixRecords[MATRIX_ColumnOrdinal].Code <> Code THEN BEGIN
          IF NOT TransferRoute.GET(Code,MatrixRecords[MATRIX_ColumnOrdinal].Code) THEN BEGIN
            TransferRoute.INIT;
            TransferRoute.VALIDATE("Transfer-from Code",Code);
            TransferRoute.VALIDATE("Transfer-to Code",MatrixRecords[MATRIX_ColumnOrdinal].Code);
            TransferRoute.INSERT;
            COMMIT;
          END;
          PAGE.RUNMODAL(PAGE::"Transfer Route Specification",TransferRoute);
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF MatrixRecords[MATRIX_ColumnOrdinal].Code <> Code THEN BEGIN
          TransferRoute.SETRANGE("Transfer-from Code",Code);
          TransferRoute.SETRANGE("Transfer-to Code",MatrixRecords[MATRIX_ColumnOrdinal].Code);
          PAGE.RUNMODAL(PAGE::"Transfer Route Specification",TransferRoute);
        END;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetColumnVisibility(PROCEDURE 1)".

}
