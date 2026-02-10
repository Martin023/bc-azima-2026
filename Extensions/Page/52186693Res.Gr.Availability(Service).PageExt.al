#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186693 pageextension52186693 extends "Res.Gr. Availability (Service)" 
{
    layout
    {
        modify(PeriodType)
        {
            ApplicationArea = Basic;
        }
        modify(DateFilter)
        {
            ApplicationArea = Basic;
        }
        modify(ColumnsSet)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "PeriodType(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DateFilter(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ColumnsSet(Control 2)".

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

        //Unsupported feature: Code Modification on "ShowMatrix(Action 77).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            MatrixForm.SetData(
              CurrentDocumentType,CurrentDocumentNo,CurrentEntryNo,
              MatrixColumnCaptions,MatrixRecords,PeriodType);
            MatrixForm.SETTABLEVIEW(Rec);
            MatrixForm.RUNMODAL;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            MatrixForm.SetData(CurrentDocumentType,CurrentDocumentNo,CurrentServItemLineNo,CurrentEntryNo,
              MatrixColumnCaptions,MatrixRecords,Periods,PeriodType);
            MatrixForm.SETTABLEVIEW(Rec);
            MatrixForm.RUNMODAL;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowMatrix(Action 77)".

        moveafter(ShowMatrix;"Next Set")
    }

    var
        ServHeader: Record "Service Header";
        ServItemLine: Record "Service Item Line";
        ServOrderAllocMgt: Codeunit ServAllocationManagement;
    var
        CurrentServItemLineNo: Integer;

    var
        SelectedResource: Code[20];

    var
        QualifiedForServItems: Option "Selected Service Item","All Service Items in Order";
        Qualified: Boolean;

    var
        ArrayLength: Integer;
        InternalDateFilter: Text[30];
        Periods: Integer;
        SelectedRes: Code[20];


    //Unsupported feature: Code Insertion on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //begin
        /*
        SelectedResource := "No.";
        */
    //end;


    //Unsupported feature: Code Insertion on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //var
        //QualifiedForAll: Boolean;
    //begin
        /*
        SelectedRes := "No.";

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


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ServMgtSetup.GET;
        SetColumns(SetWanted::Initial);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ServMgtSetup.GET;
        ArrayLength := 32;
        SetColumns(SetWanted::Initial);
        */
    //end;

    //Unsupported feature: Parameter Insertion (Parameter: ServItemLineNo) (ParameterCollection) on "SetData(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (Attributes) on "SetData(PROCEDURE 2)".



    //Unsupported feature: Code Modification on "SetData(PROCEDURE 2)".

    //procedure SetData();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CurrentDocumentType := DocumentType;
        CurrentDocumentNo := DocumentNo;
        CurrentEntryNo := EntryNo;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CurrentDocumentType := DocumentType;
        CurrentDocumentNo := DocumentNo;
        CurrentServItemLineNo := ServItemLineNo;
        CurrentEntryNo := EntryNo;
        */
    //end;


    //Unsupported feature: Code Modification on "DateControl(PROCEDURE 6)".

    //procedure DateControl();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        TextManagement.MakeDateFilter(DateFilter);
        ResRec2.SETFILTER("Date Filter",DateFilter);
        DateFilter := ResRec2.GETFILTER("Date Filter");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        IF ApplicationManagement.MakeDateFilter(DateFilter) = 0 THEN;
        ResRec2.SETFILTER("Date Filter",DateFilter);
        DateFilter := ResRec2.GETFILTER("Date Filter");
        InternalDateFilter := DateFilter;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetColumns(PROCEDURE 11)".

}
