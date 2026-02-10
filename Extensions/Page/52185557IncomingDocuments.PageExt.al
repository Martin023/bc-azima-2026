#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185557 pageextension52185557 extends "Incoming Documents"
{

    //Unsupported feature: Property Modification (PromotedActionCategoriesML) on ""Incoming Documents"(Page 190)".

    layout
    {
        modify("Entry No.")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Entry No."(Control 3)".

        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Vendor Name")
        {
            ApplicationArea = Basic;
        }
        modify("Document Date")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor Invoice No.")
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Amount Incl. VAT")
        {
            ApplicationArea = Basic;
        }
        modify(URL)
        {
            ApplicationArea = Basic;
        }
        modify("Data Exchange Type")
        {
            ApplicationArea = Basic;
        }
        // modify(Control17)
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (Name) on "Control17(Control 17)".

        // }
        modify("OCR Status")
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

            //Unsupported feature: Property Modification (Visible) on ""Created By User Name"(Control 6)".

        }
        modify("Released Date-Time")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Released Date-Time"(Control 8)".

        }
        modify("Released By User Name")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Released By User Name"(Control 9)".

        }
        modify("Last Date-Time Modified")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Last Date-Time Modified"(Control 10)".

        }
        modify("Last Modified By User Name")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Last Modified By User Name"(Control 11)".

        }
        modify("Posted Date-Time")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Posted Date-Time"(Control 13)".

        }
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Visible) on ""Posting Date"(Control 16)".

        }

        //Unsupported feature: Property Modification (Visible) on "Control19(Control 19)".


        //Unsupported feature: Property Modification (Visible) on "Control20(Control 20)".


        //Unsupported feature: Property Modification (Visible) on "Control21(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor Name"(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor Invoice No."(Control 37)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Amount Incl. VAT"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on "URL(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Data Exchange Type"(Control 140)".


        //Unsupported feature: Code Modification on "Control17(Control 17).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ErrorMessage.SetContext(RECORDID);
        ErrorMessage.ShowErrorMessages(FALSE);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ErrorMessage.ShowErrorMessagesInContext(RECORDID,FALSE);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Control17(Control 17)".



        //Unsupported feature: Code Modification on ""OCR Status"(Control 62).OnDrillDown".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""OCR Status"(Control 62)".

        modify("OCR Track ID")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Created Date-Time"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Created By User Name"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Released Date-Time"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Released By User Name"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Date-Time Modified"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Modified By User Name"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Date-Time"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 16)".

        modify(Processed)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "IncomingDocAttachFactBox(Control 7)".


        //Unsupported feature: Property Deletion (SubPageLink) on "IncomingDocAttachFactBox(Control 7)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control19(Control 19)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control20(Control 20)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control21(Control 21)".

    }
    actions
    {
        modify(CreateFromCamera)
        {
            ApplicationArea = Basic;
        }
        modify(CreateFromAttachment)
        {
            ApplicationArea = Basic;
        }
        modify(Setup)
        {
            ApplicationArea = Basic;
        }
        modify(DataExchangeTypes)
        {
            ApplicationArea = Basic;
        }
        // modify(OCRSetup)
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Insertion (RunObject) on "OCRSetup(Action 46)".

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
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Image) on "CreateManually(Action 63)".


            //Unsupported feature: Property Modification (PromotedCategory) on "CreateManually(Action 63)".

        }
        modify(AttachFile)
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
        modify(SendApprovalRequest)
        {
            ApplicationArea = Basic;
        }
        modify(CancelApprovalRequest)
        {
            ApplicationArea = Basic;
            //Enabled = OpenApprovalEntriesExist;

            //Unsupported feature: Property Modification (Image) on "CancelApprovalRequest(Action 59)".

        }
        modify(OpenDocument)
        {
            ApplicationArea = Basic;
        }
        modify(RemoveReferencedRecord)
        {
            ApplicationArea = Basic;
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
        modify(SetReadyForOCR)
        {
            ApplicationArea = Basic;
        }
        modify(UndoSetReadyForOCR)
        {
            ApplicationArea = Basic;
        }
        modify(SendToOcr)
        {
            ApplicationArea = Basic;
        }
        modify(ReceiveFromOCR)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CreateFromCamera(Action 56)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "CreateFromCamera(Action 56)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CreateFromAttachment(Action 50)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "CreateFromAttachment(Action 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Setup(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DataExchangeTypes(Action 42)".

        modify(OCRSetup)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "OCRSetup(Action 46)".


        //Unsupported feature: Property Deletion (Visible) on "OCRSetup(Action 46)".

        modify(ApprovalEntries)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CreateDocument(Action 45)".


        //Unsupported feature: Property Deletion (Enabled) on "CreateDocument(Action 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CreateGenJnlLine(Action 51)".


        //Unsupported feature: Property Deletion (Enabled) on "CreateGenJnlLine(Action 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CreateManually(Action 63)".



        //Unsupported feature: Code Modification on "AttachFile(Action 39).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ImportAttachment(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ImportAttachment;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "AttachFile(Action 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TextToAccountMapping(Action 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Release(Action 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reopen(Action 67)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reject(Action 31)".

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


        //Unsupported feature: Code Modification on "SendApprovalRequest(Action 60).OnAction".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "SendApprovalRequest(Action 60)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CancelApprovalRequest(Action 59)".



        //Unsupported feature: Code Modification on "OpenDocument(Action 58).OnAction".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "OpenDocument(Action 58)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RemoveReferencedRecord(Action 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Navigate(Action 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Journal(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PurchaseInvoice(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PurchaseCreditMemo(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesInvoice(Action 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SalesCreditMemo(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SetReadyForOCR(Action 41)".


        //Unsupported feature: Property Deletion (Visible) on "SetReadyForOCR(Action 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on "UndoSetReadyForOCR(Action 43)".


        //Unsupported feature: Property Deletion (Visible) on "UndoSetReadyForOCR(Action 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on "SendToOcr(Action 12)".


        //Unsupported feature: Property Deletion (Visible) on "SendToOcr(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ReceiveFromOCR(Action 47)".


        //Unsupported feature: Property Deletion (Visible) on "ReceiveFromOCR(Action 47)".


        //Unsupported feature: Property Deletion (Enabled) on "ReceiveFromOCR(Action 47)".

        modify("Set View")
        {
            Visible = false;
        }
        modify(ShowAll)
        {
            Visible = false;
        }
        modify(ShowUnprocessed)
        {
            Visible = false;
        }
        moveafter(Setup; CreateManually)
    }


    //Unsupported feature: Property Modification (ExternalDataType) on "CreateFromCamera(Action 56).OnAction.CameraOptions(Variable 1000)".

    //var
    //>>>> ORIGINAL VALUE:
    //CreateFromCamera : 'Microsoft.Dynamics.Nav.ClientExtensions, Version=14.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Client.Capabilities.CameraOptions;
    //Variable type has not been exported.
    //>>>> MODIFIED VALUE:
    //CreateFromCamera : 'Microsoft.Dynamics.Nav.ClientExtensions, Version=9.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Client.Capabilities.CameraOptions;
    //Variable type has not been exported.


    //Unsupported feature: Property Modification (ExternalDataType) on "CameraProvider(Variable 1008)".

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
    StatusStyleText := GetStatusStyleText;
    SetControlVisibility;
    CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromIncomingDocument(Rec);
    SetToProcessedIsEnable := NOT Processed;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IsDataExchTypeEditable := TRUE;
    IF GUIALLOWED THEN BEGIN
      HasCamera := CameraProvider.IsAvailable;
      IF HasCamera THEN
        CameraProvider := CameraProvider.Create;
    END;
    EnableReceiveFromOCR := WaitingToReceiveFromOCR;
    UpdateOCRSetupVisibility;

    FILTERGROUP(0);
    SetProcessedDocumentsVisibility(GETFILTER(Processed) = FORMAT(TRUE));
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    IsDataExchTypeEditable := TRUE;
    HasCamera := CameraProvider.IsAvailable;
    IF HasCamera THEN
      CameraProvider := CameraProvider.Create;
    */
    //end;


    //Unsupported feature: Code Modification on "SetControlVisibility(PROCEDURE 9)".

    //procedure SetControlVisibility();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
    EnableReceiveFromOCR := WaitingToReceiveFromOCR;
    UpdateOCRSetupVisibility;
    CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
    AutomaticCreationActionsAreEnabled := "Data Exchange Type" <> '';
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
    */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).


    //Unsupported feature: Property Deletion (RefreshOnActivate).

}
