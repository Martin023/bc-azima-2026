#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187121 pageextension52187121 extends "FA Posting Types Overv. Matrix" 
{
    layout
    {
        modify("FA No.")
        {
            ApplicationArea = Basic;
        }
        modify("Depreciation Book Code")
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""FA No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Depreciation Book Code"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".

    }
    actions
    {
        modify("Ledger E&ntries")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (PromotedCategory) on ""Ledger E&ntries"(Action 8)".

        }
        modify("Error Ledger Entries")
        {
            ApplicationArea = Basic;
        }
        modify("Maintenance Ledger Entries")
        {
            ApplicationArea = Basic;
        }
        modify(Statistics)
        {
            ApplicationArea = Basic;
        }
        modify("Main &Asset Statistics")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Code Insertion (VariableCollection) on ""Ledger E&ntries"(Action 8).OnAction".

        //trigger (Variable: frmFALedgEntr)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on ""Ledger E&ntries"(Action 8).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            FALedgEntry.SETRANGE("FA No.","FA No.");
            FALedgEntry.SETRANGE("Depreciation Book Code","Depreciation Book Code");
            FALedgEntry.SETCURRENTKEY("FA No.","Depreciation Book Code");

            PAGE.RUN(PAGE::"FA Ledger Entries",FALedgEntry);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
            frmFALedgEntr.SETTABLEVIEW(FALedgEntry);
            frmFALedgEntr.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Ledger E&ntries"(Action 8)".



        //Unsupported feature: Code Modification on ""Error Ledger Entries"(Action 9).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            FALedgEntry.SETRANGE("Canceled from FA No.","FA No.");
            FALedgEntry.SETRANGE("Depreciation Book Code","Depreciation Book Code");
            FALedgEntry.SETCURRENTKEY("Canceled from FA No.","Depreciation Book Code");

            PAGE.RUN(PAGE::"FA Error Ledger Entries",FALedgEntry);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
            frmFAErrLedgEntr.SETTABLEVIEW(FALedgEntry);
            frmFAErrLedgEntr.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Error Ledger Entries"(Action 9)".



        //Unsupported feature: Code Modification on ""Maintenance Ledger Entries"(Action 10).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MaintLedgEntry.SETRANGE("FA No.","FA No.");
            MaintLedgEntry.SETRANGE("Depreciation Book Code","Depreciation Book Code");
            MaintLedgEntry.SETCURRENTKEY("FA No.","Depreciation Book Code");

            PAGE.RUN(PAGE::"Maintenance Ledger Entries",MaintLedgEntry);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            #1..3
            frmMaintLedgEntr.SETTABLEVIEW(MaintLedgEntry);
            frmMaintLedgEntr.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Maintenance Ledger Entries"(Action 10)".



        //Unsupported feature: Code Modification on "Statistics(Action 12).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            FADeprBook.SETRANGE("FA No.","FA No.");
            FADeprBook.SETRANGE("Depreciation Book Code","Depreciation Book Code");

            PAGE.RUN(PAGE::"Fixed Asset Statistics",FADeprBook);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            FADeprBook.SETRANGE("FA No.","FA No.");
            FADeprBook.SETRANGE("Depreciation Book Code","Depreciation Book Code");
            frmFAStat.SETTABLEVIEW(FADeprBook);
            frmFAStat.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 12)".



        //Unsupported feature: Code Modification on ""Main &Asset Statistics"(Action 13).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            FADeprBook.SETRANGE("FA No.","FA No.");
            FADeprBook.SETRANGE("Depreciation Book Code","Depreciation Book Code");

            PAGE.RUN(PAGE::"Main Asset Statistics",FADeprBook);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            FADeprBook.SETRANGE("FA No.","FA No.");
            FADeprBook.SETRANGE("Depreciation Book Code","Depreciation Book Code");
            frmMainAssetStat.SETTABLEVIEW(FADeprBook);
            frmMainAssetStat.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Main &Asset Statistics"(Action 13)".

    }

    var
        frmFALedgEntr: Page "FA Ledger Entries";

    var
        frmFAErrLedgEntr: Page "FA Error Ledger Entries";

    var
        frmMaintLedgEntr: Page "Maintenance Ledger Entries";

    var
        frmFAStat: Page "Fixed Asset Statistics";

    var
        frmMainAssetStat: Page "Main Asset Statistics";


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
        FOR i := 1 TO CurrentNoOfMatrixColumns DO BEGIN
          MATRIX_CaptionSet[i] := MatrixColumns1[i];
          MatrixRecords[i] := MatrixRecords1[i];
        END;
        MATRIX_CurrentNoOfMatrixColumn := CurrentNoOfMatrixColumns;
        DateFilter := DateFilterLocal;
        RoundingFactor := RoundingFactorLocal;
        RoundingFactorFormatString := MatrixMgt.GetFormatString(RoundingFactor,FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..7
        PeriodType := PeriodTypeLocal;
        AmountType := AmountTypeLocal;
        RoundingFactorFormatString := MatrixMgt.GetFormatString(RoundingFactor,FALSE);
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetVisible(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Length) on "Load(PROCEDURE 1093).MatrixColumns1(Parameter 1005)".


    //Unsupported feature: Property Insertion (Length) on "Load(PROCEDURE 1093).DateFilterLocal(Parameter 1003)".

}
