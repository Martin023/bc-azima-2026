#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187093 pageextension52187093 extends "Res. Gr. Avail. (Serv.) Matrix" 
{

    //Unsupported feature: Property Insertion (DataCaptionExpr) on ""Res. Gr. Avail. (Serv.) Matrix"(Page 9221)".

    layout
    {
        modify(Qtytoallocate)
        {
            ApplicationArea = Basic;
        }
        modify(SelectDate)
        {
            ApplicationArea = Basic;
        }
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

        //Unsupported feature: Property Deletion (ToolTipML) on "Qtytoallocate(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SelectDate(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 6)".

    }
    actions
    {
        modify(Allocate)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Allocate(Action 15)".

    }
    var
        QualifiedForAll: Boolean;

    var
        ServHeader: Record "Service Header";
        ServItemLine: Record "Service Item Line";

    var
        CurrentServItemLineNo: Integer;

    var
        QualifiedForServItems: Option "Selected Service Item","All Service Items in Order";

    var
        Qualified: Boolean;


    //Unsupported feature: Code Insertion (VariableCollection) on "OnAfterGetRecord".

    //trigger (Variable: QualifiedForAll)()
    //Parameters and return type have not been exported.
    //begin
        /*
        */
    //end;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        MatrixOnAfterGetRecord;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        MatrixOnAfterGetRecord;

        IF QualifiedForServItems = QualifiedForServItems::"Selected Service Item" THEN BEGIN
          IF ServItemLine.GET(CurrentDocumentType,CurrentDocumentNo,CurrentServItemLineNo) THEN
            Qualified := ServOrderAllocMgt.QualifiedForServiceItemLine(ServItemLine,"No.")
          ELSE
            Qualified := FALSE;
        END ELSE BEGIN
          QualifiedForAll := TRUE;
          ServItemLine.SETRANGE("Document Type",ServHeader."Document Type");
          ServItemLine.SETRANGE("Document No.",ServHeader."No.");
          IF ServItemLine.FIND('-') THEN
            REPEAT
              QualifiedForAll := ServOrderAllocMgt.QualifiedForServiceItemLine(ServItemLine,"No.")
            UNTIL (QualifiedForAll = FALSE) OR (ServItemLine.NEXT = 0);
          IF QualifiedForAll THEN
            Qualified := TRUE
          ELSE
            Qualified := FALSE;
        END;
        */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: ServItemLineNo) (ParameterCollection) on "SetData(PROCEDURE 1109)".


    //Unsupported feature: Parameter Insertion (Parameter: Periods) (ParameterCollection) on "SetData(PROCEDURE 1109)".


    //Unsupported feature: Property Deletion (Attributes) on "SetData(PROCEDURE 1109)".



    //Unsupported feature: Code Modification on "SetData(PROCEDURE 1109)".

    //procedure SetData();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrentDocumentType := DocumentType;
        CurrentDocumentNo := DocumentNo;
        CurrentEntryNo := EntryNo;
        COPYARRAY(MatrixColumnCaptions,NewMatrixColumnCaptions,1);
        COPYARRAY(MatrixColumnDateFilters,NewMatrixDateFilters,1);
        PeriodType := Period;
        SelectedDate := NewMatrixDateFilters[1]."Period Start";
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CurrentDocumentType := DocumentType;
        CurrentDocumentNo := DocumentNo;
        CurrentServItemLineNo := ServItemLineNo;
        #3..7
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetVisible(PROCEDURE 6)".


    local procedure Caption(): Text[100]
    begin
    end;

    local procedure MatrixOnFindRecord()
    begin
    end;

    local procedure MatrixOnNextRecord()
    begin
    end;

    local procedure MatrixOnAfterGetCurrRecord()
    begin
    end;

    local procedure FindSelectedDate()
    begin
    end;
}
