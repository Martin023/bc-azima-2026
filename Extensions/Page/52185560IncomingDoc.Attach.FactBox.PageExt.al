#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185560 pageextension52185560 extends "Incoming Doc. Attach. FactBox" 
{
    layout
    {
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify("Created Date-Time")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Created Date-Time"(Control 3)".

    }
    actions
    {
        modify(Export)
        {
            ApplicationArea = Basic;
        }
        modify(ImportNew)
        {
            ApplicationArea = Basic;
        }
        modify(IncomingDoc)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Export(Action 6)".


        //Unsupported feature: Property Deletion (Visible) on "Export(Action 6)".


        //Unsupported feature: Code Modification on "ImportNew(Action 8).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            IncomingDocumentAttachment.SETRANGE("Incoming Document Entry No.","Incoming Document Entry No.");
            IF GlobalRecordID.TABLENO <> 0 THEN
              MainRecordRef := GlobalRecordID.GETRECORD;
            IncomingDocumentAttachment.SetFiltersFromMainRecord(MainRecordRef,IncomingDocumentAttachment);

            // check MainRecordRef is initialized
            IF MainRecordRef.NUMBER <> 0 THEN
              IF NOT MainRecordRef.GET(MainRecordRef.RECORDID) THEN
                ERROR(CreateMainDocumentFirstErr);

            IF IncomingDocumentAttachment.Import THEN
              IF IncomingDocument.GET(IncomingDocumentAttachment."Incoming Document Entry No.") THEN
                LoadDataFromIncomingDocument(IncomingDocument);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            IncomingDocumentAttachment.SETRANGE("Incoming Document Entry No.","Incoming Document Entry No.");
            IncomingDocumentAttachment.SetFiltersFromMainRecord(MainRecordRef,IncomingDocumentAttachment);
            IF IncomingDocumentAttachment.Import THEN
              IF IncomingDocument.GET("Incoming Document Entry No.") THEN
                LoadDataFromIncomingDocument(IncomingDocument);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ImportNew(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "IncomingDoc(Action 10)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "LoadDataFromRecord(PROCEDURE 3)".



    //Unsupported feature: Code Modification on "LoadDataFromRecord(PROCEDURE 3)".

    //procedure LoadDataFromRecord();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT DataTypeManagement.GetRecordRef(MainRecordVariant,MainRecordRef) THEN
          EXIT;

        DELETEALL;

        IF NOT MainRecordRef.GET(MainRecordRef.RECORDID) THEN
          EXIT;

        IF GetIncomingDocumentRecord(MainRecordVariant,IncomingDocument) THEN
          InsertFromIncomingDocument(IncomingDocument,Rec);

        OnAfterLoadDataFromRecord(MainRecordRef);

        CurrPage.UPDATE(FALSE);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        DELETEALL;
        IF GetIncomingDocumentRecord(MainRecordVariant,IncomingDocument) THEN
          InsertFromIncomingDocument(IncomingDocument,Rec);
        CurrPage.UPDATE(FALSE);
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "LoadDataFromIncomingDocument(PROCEDURE 38)".


    //Unsupported feature: Property Deletion (Attributes) on "GetIncomingDocumentRecord(PROCEDURE 10)".



    //Unsupported feature: Code Modification on "GetIncomingDocumentRecord(PROCEDURE 10)".

    //procedure GetIncomingDocumentRecord();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        IF NOT DataTypeManagement.GetRecordRef(MainRecordVariant,MainRecordRef) THEN
          EXIT(FALSE);

        IF MainRecordRef.NUMBER = DATABASE::"Incoming Document" THEN BEGIN
          IncomingDocument.COPY(MainRecordVariant);
          EXIT(TRUE);
        END;

        EXIT(GetIncomingDocumentRecordFromRecordRef(IncomingDocument,MainRecordRef));
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..3
        CASE MainRecordRef.NUMBER OF
          DATABASE::"Incoming Document":
            BEGIN
              IncomingDocument.COPY(MainRecordVariant);
              EXIT(TRUE);
            END;
          ELSE BEGIN
            IF IncomingDocument.FindFromIncomingDocumentEntryNo(MainRecordRef,IncomingDocument) THEN
              EXIT(TRUE);
            IF IncomingDocument.FindByDocumentNoAndPostingDate(MainRecordRef,IncomingDocument) THEN
              EXIT(TRUE);
            EXIT(FALSE);
          END;
        END;
        */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "LoadDataFromRecord(PROCEDURE 3).DataTypeManagement(Variable 1002)".

}
