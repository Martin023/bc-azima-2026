#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187126 pageextension52187126 extends "Work Center Calendar Matrix" 
{
    layout
    {
        modify("No.")
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

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 6)".

    }
    actions
    {
        modify("Capacity Ledger E&ntries")
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify("Lo&ad")
        {
            ApplicationArea = Basic;
        }
        modify(Statistics)
        {
            ApplicationArea = Basic;
        }
        modify("A&bsence")
        {
            ApplicationArea = Basic;
        }
        modify("Ta&sk List")
        {
            ApplicationArea = Basic;
        }
        modify(Calculate)
        {
            ApplicationArea = Basic;
        }
        modify(Recalculate)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Capacity Ledger E&ntries"(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Lo&ad"(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""A&bsence"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ta&sk List"(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Calculate(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Recalculate(Action 14)".

        addafter("Lo&ad")
        {
            separator(Action12)
            {
            }
        }
    }


    //Unsupported feature: Property Modification (Length) on ""MATRIX_CaptionSet"(Variable 1084)".

    //var
        //>>>> ORIGINAL VALUE:
        //"MATRIX_CaptionSet" : 80;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //"MATRIX_CaptionSet" : 1024;
        //Variable type has not been exported.

    //Unsupported feature: Property Deletion (Attributes) on "Load(PROCEDURE 1086)".


    //Unsupported feature: Variable Insertion (Variable: CalendarEntries) (VariableCollection) on ""MATRIX_OnDrillDown"(PROCEDURE 1087)".



    //Unsupported feature: Code Modification on ""MATRIX_OnDrillDown"(PROCEDURE 1087)".

    //procedure "MATRIX_OnDrillDown"();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CalendarEntry.SETRANGE("Capacity Type",CalendarEntry."Capacity Type"::"Work Center");
        CalendarEntry.SETRANGE("No.","No.");

        #4..6
          CalendarEntry.SETRANGE(Date,
            MatrixRecords[MATRIX_ColumnOrdinal]."Period Start",MatrixRecords[MATRIX_ColumnOrdinal]."Period End");

        PAGE.RUNMODAL(PAGE::"Calendar Entries",CalendarEntry);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..9
        CalendarEntries.SETTABLEVIEW(CalendarEntry);
        CalendarEntries.RUNMODAL;
        // PAGE.RUNMODAL(99000759,CalendarEntry);
        */
    //end;
}
