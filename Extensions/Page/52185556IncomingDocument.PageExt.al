#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185556 pageextension52185556 extends "Incoming Document"
{

    //Unsupported feature: Property Modification (PromotedActionCategoriesML) on ""Incoming Document"(Page 189)".

    layout
    {
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(URL)
        {
            ApplicationArea = Basic;
        }
        modify(MainAttachment)
        {
            ApplicationArea = Basic;
        }
        modify("Data Exchange Type")
        {
            ApplicationArea = Basic;
        }
        modify("Record")
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
        // modify(Control16)
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (Name) on "Control16(Control 16)".

        // }
        modify("OCR Status")
        {
            ApplicationArea = Basic;
        }
        modify("Job Queue Status")
        {
            ApplicationArea = Basic;
        }
        modify("OCR Service Doc. Template Code")
        {
            ApplicationArea = Basic;
        }
        modify("OCR Service Doc. Template Name")
        {
            ApplicationArea = Basic;
        }
        modify(OCRResultFileName)
        {
            ApplicationArea = Basic;
        }
        modify("Created Date-Time")
        {
            ApplicationArea = Basic;
        }
        modify("Created By User Name")
        {
            ApplicationArea = Basic;
        }
        modify(Released)
        {
            ApplicationArea = Basic;
        }
        modify("Released Date-Time")
        {
            ApplicationArea = Basic;
        }
        modify("Released By User Name")
        {
            ApplicationArea = Basic;
        }
        modify("Last Date-Time Modified")
        {
            ApplicationArea = Basic;
        }
        modify("Last Modified By User Name")
        {
            ApplicationArea = Basic;
        }
        modify(Posted)
        {
            ApplicationArea = Basic;
        }
        modify("Posted Date-Time")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor Name")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor VAT Registration No.")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor IBAN")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor Bank Branch No.")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor Bank Account No.")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor Invoice No.")
        {
            ApplicationArea = Basic;
        }
        modify("Order No.")
        {
            ApplicationArea = Basic;
        }
        modify("Document Date")
        {
            ApplicationArea = Basic;
        }
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Amount Excl. VAT")
        {
            ApplicationArea = Basic;
        }
        modify("Amount Incl. VAT")
        {
            ApplicationArea = Basic;
        }
        modify("VAT Amount")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "URL(Control 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on "MainAttachment(Control 90)".


        //Unsupported feature: Property Deletion (Enabled) on "MainAttachment(Control 90)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Data Exchange Type"(Control 115)".


        //Unsupported feature: Code Modification on "Record(Control 58).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShowRecord;
        CurrPage.UPDATE;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ShowNAVRecord;
        CurrPage.UPDATE;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Record(Control 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Control16(Control 16)".



        //Unsupported feature: Code Modification on ""OCR Status"(Control 87).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT OCRServiceSetup.ISEMPTY THEN
          HYPERLINK(OCRServiceMgt.GetStatusHyperLink(Rec));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF NOT OCRServiceSetup.FINDFIRST THEN
          EXIT;

        IF OCRServiceSetup.Enabled AND (OCRServiceSetup."Login URL" <> '') THEN
          HYPERLINK(OCRServiceSetup."Login URL");
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""OCR Status"(Control 87)".

        modify("OCR Track ID")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Queue Status"(Control 84)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""OCR Service Doc. Template Code"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""OCR Service Doc. Template Name"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on "OCRResultFileName(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Created Date-Time"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Created By User Name"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Released(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Released Date-Time"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Released By User Name"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Date-Time Modified"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Modified By User Name"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Posted(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Date-Time"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 18)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "SupportingAttachments(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor Name"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor VAT Registration No."(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor IBAN"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor Bank Branch No."(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor Bank Account No."(Control 28)".

        modify("Vendor Phone No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor Invoice No."(Control 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order No."(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 61)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount Excl. VAT"(Control 62)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount Incl. VAT"(Control 63)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""VAT Amount"(Control 34)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "ErrorMessagesPart(Control 20)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "WorkflowStatus(Control 83)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control38(Control 38)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control39(Control 39)".

    }
    actions
    {
        modify(Setup)
        {
            ApplicationArea = Basic;
        }
        modify(DataExchangeTypes)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "DataExchangeTypes(Action 22)".

        }
        modify(ActivityLog)
        {
            ApplicationArea = Basic;
        }
        // modify(OCRSetup)
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Insertion (RunObject) on "OCRSetup(Action 69)".

        // }
        modify(CreateDocument)
        {
            ApplicationArea = Basic;
        }
        modify(CreateGenJnlLine)
        {
            ApplicationArea = Basic;
        }
        modify(CreateManually)
        {

            //Unsupported feature: Property Modification (Level) on "CreateManually(Action 285)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Image) on "CreateManually(Action 285)".


            //Unsupported feature: Property Modification (PromotedCategory) on "CreateManually(Action 285)".

        }
        modify(AttachFile)
        {
            ApplicationArea = Basic;
        }
        modify(ReplaceMainAttachment)
        {
            ApplicationArea = Basic;
        }
        modify(AttachFromCamera)
        {
            ApplicationArea = Basic;
        }
        modify(TextToAccountMapping)
        {
            ApplicationArea = Basic;
        }
        modify(Release)
        {
            ApplicationArea = Basic;
        }
        modify(Reopen)
        {
            ApplicationArea = Basic;
        }
        modify(Reject)
        {
            ApplicationArea = Basic;
        }
        modify(Approve)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Approve(Action 75)".

        }
        modify(RejectApproval)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "RejectApproval(Action 76)".

        }
        modify(Delegate)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Delegate(Action 77)".

        }
        // modify(Comment)
        // {
        //     ApplicationArea = Basic;

        //Unsupported feature: Property Modification (PromotedCategory) on "Comment(Action 78)".


        //Unsupported feature: Property Insertion (RunObject) on "Comment(Action 78)".


        //Unsupported feature: Property Insertion (RunPageLink) on "Comment(Action 78)".

        //}
        modify(SendApprovalRequest)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "SendApprovalRequest(Action 80)".

        }
        modify(CancelApprovalRequest)
        {
            ApplicationArea = Basic;
            //Enabled = OpenApprovalEntriesExist;

            //Unsupported feature: Property Modification (Image) on "CancelApprovalRequest(Action 79)".


            //Unsupported feature: Property Modification (PromotedCategory) on "CancelApprovalRequest(Action 79)".

        }
        modify(OpenDocument)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "OpenDocument(Action 67)".

        }
        modify(RemoveReferencedRecord)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "RemoveReferencedRecord(Action 5)".

        }
        modify(Navigate)
        {
            ApplicationArea = Basic;
        }
        modify(Journal)
        {
            ApplicationArea = Basic;
        }
        modify(PurchaseInvoice)
        {
            ApplicationArea = Basic;
        }
        modify(PurchaseCreditMemo)
        {
            ApplicationArea = Basic;
        }
        modify(SalesInvoice)
        {
            ApplicationArea = Basic;
        }
        modify(SalesCreditMemo)
        {
            ApplicationArea = Basic;
        }
        modify(SendToJobQueue)
        {
            ApplicationArea = Basic;
        }
        modify(RemoveFromJobQueue)
        {
            ApplicationArea = Basic;
        }
        modify(SendToOcr)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "SendToOcr(Action 54)".

        }
        modify(ReceiveFromOCR)
        {
            ApplicationArea = Basic;
            //Enabled = "OCR Status" = "OCR Status"::Sent;

            //Unsupported feature: Property Modification (PromotedCategory) on "ReceiveFromOCR(Action 55)".

        }
        modify(CorrectOCRData)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "CorrectOCRData(Action 35)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Setup(Action 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DataExchangeTypes(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ActivityLog(Action 73)".

        modify(OCRSetup)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "OCRSetup(Action 69)".


        //Unsupported feature: Property Deletion (Promoted) on "OCRSetup(Action 69)".


        //Unsupported feature: Property Deletion (Visible) on "OCRSetup(Action 69)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "OCRSetup(Action 69)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "OCRSetup(Action 69)".

        modify(ApprovalEntries)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CreateDocument(Action 121)".


        //Unsupported feature: Property Deletion (Enabled) on "CreateDocument(Action 121)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "CreateDocument(Action 121)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CreateGenJnlLine(Action 31)".


        //Unsupported feature: Property Deletion (Enabled) on "CreateGenJnlLine(Action 31)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "CreateGenJnlLine(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CreateManually(Action 285)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "CreateManually(Action 285)".



        //Unsupported feature: Code Modification on "AttachFile(Action 21).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ImportAttachment(Rec);
        CurrPage.UPDATE(TRUE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CurrPage.UPDATE(TRUE);
        ImportAttachment;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "AttachFile(Action 21)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "AttachFile(Action 21)".



        //Unsupported feature: Code Modification on "ReplaceMainAttachment(Action 85).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ReplaceOrInsertMainAttachment;
        CLEAR("Data Exchange Type");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ReplaceOrInsertMainAttachment;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ReplaceMainAttachment(Action 85)".


        //Unsupported feature: Property Deletion (Promoted) on "ReplaceMainAttachment(Action 85)".


        //Unsupported feature: Property Deletion (Enabled) on "ReplaceMainAttachment(Action 85)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "ReplaceMainAttachment(Action 85)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "ReplaceMainAttachment(Action 85)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AttachFromCamera(Action 30)".


        //Unsupported feature: Property Deletion (Enabled) on "AttachFromCamera(Action 30)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "AttachFromCamera(Action 30)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "AttachFromCamera(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TextToAccountMapping(Action 64)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "TextToAccountMapping(Action 64)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Release(Action 12)".


        //Unsupported feature: Property Deletion (Enabled) on "Release(Action 12)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Release(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reopen(Action 82)".


        //Unsupported feature: Property Deletion (Enabled) on "Reopen(Action 82)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Reopen(Action 82)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reject(Action 9)".


        //Unsupported feature: Property Deletion (Enabled) on "Reject(Action 9)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Reject(Action 9)".

        modify(Status)
        {
            Visible = false;
        }
        modify(SetToProcessed)
        {
            Visible = false;
        }
        modify(SetToUnprocessed)
        {
            Visible = false;
        }


        //Unsupported feature: Code Modification on "Approve(Action 75).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestReadyForApproval;
        ApprovalsMgmt.ApproveRecordApprovalRequest(RECORDID);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ApprovalsMgmt.ApproveRecordApprovalRequest(RECORDID);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Approve(Action 75)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RejectApproval(Action 76)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Delegate(Action 77)".

        modify(Comment)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Comment(Action 78)".



        //Unsupported feature: Code Modification on "SendApprovalRequest(Action 80).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        TestReadyForApproval;
        IF ApprovalsMgmt.CheckIncomingDocApprovalsWorkflowEnabled(Rec) THEN
          ApprovalsMgmt.OnSendIncomingDocForApproval(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF ApprovalsMgmt.CheckIncomingDocApprovalsWorkflowEnabled(Rec) THEN
          ApprovalsMgmt.OnSendIncomingDocForApproval(Rec);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "SendApprovalRequest(Action 80)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "SendApprovalRequest(Action 80)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CancelApprovalRequest(Action 79)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "CancelApprovalRequest(Action 79)".



        //Unsupported feature: Code Modification on "OpenDocument(Action 67).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ShowRecord;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ShowNAVRecord;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "OpenDocument(Action 67)".


        //Unsupported feature: Property Deletion (Enabled) on "OpenDocument(Action 67)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "OpenDocument(Action 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RemoveReferencedRecord(Action 5)".


        //Unsupported feature: Property Deletion (Enabled) on "RemoveReferencedRecord(Action 5)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "RemoveReferencedRecord(Action 5)".



        //Unsupported feature: Code Modification on "Navigate(Action 68).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF NOT Posted THEN
          ERROR(NoPostedDocumentsErr);
        NavigatePage.SetDoc("Posting Date","Document No.");
        NavigatePage.RUN;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        TESTFIELD(Posted);
        NavigatePage.SetDoc("Posting Date","Document No.");
        NavigatePage.RUN;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Navigate(Action 68)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Journal(Action 65)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PurchaseInvoice(Action 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PurchaseCreditMemo(Action 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesInvoice(Action 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesCreditMemo(Action 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SendToJobQueue(Action 42)".


        //Unsupported feature: Property Deletion (Visible) on "SendToJobQueue(Action 42)".


        //Unsupported feature: Property Deletion (Enabled) on "SendToJobQueue(Action 42)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RemoveFromJobQueue(Action 56)".


        //Unsupported feature: Property Deletion (Visible) on "RemoveFromJobQueue(Action 56)".


        //Unsupported feature: Property Deletion (Enabled) on "RemoveFromJobQueue(Action 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SendToOcr(Action 54)".


        //Unsupported feature: Property Deletion (Visible) on "SendToOcr(Action 54)".


        //Unsupported feature: Property Deletion (Enabled) on "SendToOcr(Action 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ReceiveFromOCR(Action 55)".


        //Unsupported feature: Property Deletion (Visible) on "ReceiveFromOCR(Action 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CorrectOCRData(Action 35)".


        //Unsupported feature: Property Deletion (Visible) on "CorrectOCRData(Action 35)".

        moveafter(Setup; CreateManually)
    }


    //Unsupported feature: Property Modification (ExternalDataType) on "AttachFromCamera(Action 30).OnAction.CameraOptions(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //AttachFromCamera : 'Microsoft.Dynamics.Nav.ClientExtensions, Version=14.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Client.Capabilities.CameraOptions;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //AttachFromCamera : 'Microsoft.Dynamics.Nav.ClientExtensions, Version=9.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Client.Capabilities.CameraOptions;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (ExternalDataType) on "CameraProvider(Variable 1005)".

    //var
    //>>>> ORIGINAL VALUE:
    //CameraProvider : 'Microsoft.Dynamics.Nav.ClientExtensions, Version=14.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Client.Capabilities.CameraProvider;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CameraProvider : 'Microsoft.Dynamics.Nav.ClientExtensions, Version=9.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Client.Capabilities.CameraProvider;
    //Variable type has not been exported.


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsDataExchTypeEditable := NOT (Status IN [Status::Created,Status::Posted]);
    ShowErrors;
    SetCalculatedFields;
    RecordHasAttachment := HasAttachment;
    SetControlVisibility;
    AttachEnabled := "Entry No." <> 0;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    SetControlVisibility;
    */
    //end;


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    URL := GetURL;
    ShowErrors;
    EnableReceiveFromOCR := WaitingToReceiveFromOCR;
    CurrPage.EDITABLE(NOT Processed);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    URL := GetURL;
    ShowErrors;
    */
    //end;


    //Unsupported feature: Code Modification on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsDataExchTypeEditable := TRUE;
    EnableReceiveFromOCR := WaitingToReceiveFromOCR;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IsDataExchTypeEditable := TRUE;
    */
    //end;


    //Unsupported feature: Code Modification on "OnModifyRecord".

    //trigger OnModifyRecord(): Boolean
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OCRDataCorrectionEnabled := GetGeneratedFromOCRAttachment(IncomingDocumentAttachment);
    RecordHasAttachment := HasAttachment;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    OCRDataCorrectionEnabled := GetGeneratedFromOCRAttachment(IncomingDocumentAttachment);
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    HasCamera := CameraProvider.IsAvailable;
    IF HasCamera THEN
      CameraProvider := CameraProvider.Create;

    UpdateOCRSetupVisibility;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    */
    //end;


    //Unsupported feature: Code Modification on "SetControlVisibility(PROCEDURE 9)".

    //procedure SetControlVisibility();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
    OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
    ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
    CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
    UpdateOCRSetupVisibility;
    AutomaticCreationActionsAreEnabled := "Data Exchange Type" <> '';
    RecordLinkExists := GetRecord(RelatedRecord);
    CanBeSentToOCR := VerifyCanBeSentToOCR;
    ReplaceMainAttachmentEnabled := CanReplaceMainAttachment;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    */
    //end;

    //Unsupported feature: Deletion (VariableCollection) on "SetControlVisibility(PROCEDURE 9).RelatedRecord(Variable 1002)".

}
