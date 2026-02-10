#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187102 pageextension52187102 extends "G/L Entries Dim. Overv. Matrix" 
{
    layout
    {
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("G/L Account No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Amount)
        {
            ApplicationArea = Basic;
        }
        modify("Entry No.")
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""G/L Account No."(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Amount(Control 15)".

        modify("Debit Amount")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 2)".


        //Unsupported feature: Code Modification on "Field1(Control 1366).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(1);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(1);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field2(Control 1367).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(2);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(2);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field3(Control 1368).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(3);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(3);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field4(Control 1369).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(4);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(4);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field5(Control 1370).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(5);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(5);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field6(Control 1371).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(6);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(6);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field7(Control 1372).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(7);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(7);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field8(Control 1373).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(8);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(8);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field9(Control 1374).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(9);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(9);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field10(Control 1375).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(10);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(10);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field11(Control 1376).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(11);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(11);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field12(Control 1377).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(12);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(12);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field13(Control 1378).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(13);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(13);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field14(Control 1379).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(14);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(14);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field15(Control 1380).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(15);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(15);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field16(Control 1381).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(16);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(16);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field17(Control 1382).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(17);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(17);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field18(Control 1383).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(18);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(18);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field19(Control 1384).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(19);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(19);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field20(Control 1385).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(20);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(20);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field21(Control 1386).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(21);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(21);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field22(Control 1387).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(22);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(22);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field23(Control 1388).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(23);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(23);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field24(Control 1389).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(24);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(24);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field25(Control 1390).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(25);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(25);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field26(Control 1391).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(26);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(26);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field27(Control 1392).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(27);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(27);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field28(Control 1393).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(28);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(28);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field29(Control 1394).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(29);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(29);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field30(Control 1395).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(30);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(30);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field31(Control 1396).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(31);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(31);
            MATRIX_OnLookup(Text);
            */
        //end;


        //Unsupported feature: Code Modification on "Field32(Control 1397).OnLookup".

        //trigger OnLookup(var Text: Text): Boolean
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(32);
            MATRIX_OnLookup;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MATRIX_UpdateMatrixRecord(32);
            MATRIX_OnLookup(Text);
            */
        //end;
    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("<Action16>")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""<Action16>"(Action 4)".

    }


    //Unsupported feature: Property Modification (Id) on "MatrixRecord(Variable 1005)".

    //var
        //>>>> ORIGINAL VALUE:
        //MatrixRecord : 1005;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //MatrixRecord : 1446;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on ""MATRIX_CellData"(Variable 1449)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_CellData" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_CellData" : 1024;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on ""MATRIX_ColumnCaptions"(Variable 1000)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_ColumnCaptions" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_ColumnCaptions" : 1024;
        //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        MATRIX_CurrentColumnOrdinal := 0;
        IF MATRIX_PKFirstCaptionInSet <> '' THEN
          MatrixRecord.SETPOSITION(MATRIX_PKFirstCaptionInSet);
        IF MATRIX_OnFindRecord('=') THEN BEGIN
          MATRIX_CurrentColumnOrdinal := 1;
          REPEAT
        #7..14
        END;

        MATRIX_CurrentColumnOrdinal := MATRIX_CurrentColumnOrdinal;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        MATRIX_CurrentColumnOrdinal := 0;
        MatrixRecord.SETPOSITION(MATRIX_PKFirstCaptionInSet);
        #4..17
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "Load(PROCEDURE 1)".


    //Unsupported feature: Parameter Insertion (Parameter: Text) (ParameterCollection) on ""MATRIX_OnLookup"(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (Attributes) on "SetTempGLEntry(PROCEDURE 3)".


    //Unsupported feature: Property Deletion (Attributes) on "SetColumnVisibility(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Length) on "Load(PROCEDURE 1)."NewMATRIX_Captions"(Parameter 1000)".


    //Unsupported feature: Property Insertion (Length) on "Load(PROCEDURE 1).PKFirstCaptionInSet(Parameter 1001)".

}
