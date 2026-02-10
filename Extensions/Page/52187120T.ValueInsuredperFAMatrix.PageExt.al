#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187120 pageextension52187120 extends "T. Value Insured per FA Matrix" 
{
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".

    }

    //Unsupported feature: Property Modification (Length) on ""MATRIX_CaptionSet"(Variable 1087)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_CaptionSet" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_CaptionSet" : 1024;
        //Variable type has not been exported.

    var
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";

    var
        AmountType: Option "Net Change","Balance at Date";

    //Unsupported feature: Parameter Insertion (Parameter: PeriodTypeLocal) (ParameterCollection) on "Load(PROCEDURE 1093)".


    //Unsupported feature: Parameter Insertion (Parameter: AmountTypeLocal) (ParameterCollection) on "Load(PROCEDURE 1093)".


    //Unsupported feature: Property Deletion (Attributes) on "Load(PROCEDURE 1093)".



    //Unsupported feature: Code Modification on "Load(PROCEDURE 1093)".

    //procedure Load();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        COPYARRAY(MATRIX_CaptionSet,MatrixColumns1,1);
        COPYARRAY(MatrixRecords,MatrixRecords1,1);
        MATRIX_CurrentNoOfMatrixColumn := CurrentNoOfMatrixColumns;
        DateFilter := DateFilterLocal;
        RoundingFactor := RoundingFactorLocal;
        RoundingFactorFormatString := MatrixMgt.GetFormatString(RoundingFactor,FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..5
        PeriodType := PeriodTypeLocal;
        AmountType := AmountTypeLocal;
        RoundingFactorFormatString := MatrixMgt.GetFormatString(RoundingFactor,FALSE);
        */
    //end;

    //Unsupported feature: Variable Insertion (Variable: DrillDownForm) (VariableCollection) on ""MATRIX_OnDrillDown"(PROCEDURE 1094)".



    //Unsupported feature: Code Modification on ""MATRIX_OnDrillDown"(PROCEDURE 1094)".

    //procedure "MATRIX_OnDrillDown"();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        InsCov.SETFILTER("Posting Date",DateFilter);
        InsCov.SETRANGE("Insurance No.",MatrixRecords[MATRIX_ColumnOrdinal]."No.");
        InsCov.SETRANGE("Disposed FA",FALSE);
        InsCov.SETRANGE("FA No.","No.");

        PAGE.RUNMODAL(PAGE::"Ins. Coverage Ledger Entries",InsCov);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..4
        DrillDownForm.SETTABLEVIEW(InsCov);
        DrillDownForm.RUNMODAL;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetVisible(PROCEDURE 6)".

}
