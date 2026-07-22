page 52185904 "Internal Requisitions"
{
    Caption = 'Purchase Requisitions';
    DeleteAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approvals,Budgetary Control,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = CONST(Quote),
                            DocApprovalType = CONST(Requisition),
                            Status = FILTER(Open | "Pending Approval" | Released));




    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                //Editable = statuseditable;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Editable = false;
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update;
                    end;

                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic;
                    Editable = InvTcode;
                    Visible = false;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    Caption = 'Requisition Date';
                    ApplicationArea = Basic;
                    Editable = InvTcode;

                    trigger OnValidate()
                    begin
                        //Not allow back date
                        //IF TODAY > Rec."Posting Date" THEN ERROR('Posting Date Cannot be %1',"Posting Date");
                    end;
                }
                field("Reason For request"; Rec."Posting Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reason For request';
                    Editable = InvTcode;
                }
                field("No. of Archived Versions"; Rec."No. of Archived Versions")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                // field("Order Date"; Rec."Order Date")
                // {
                //     Caption='Requisition Date';
                //     ApplicationArea = Basic;
                //     Importance = Promoted;
                // }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        //Not allow back  date
                        if Today > Rec."Posting Date" then Error('Posting Date Cannot be %1', Rec."Posting Date");
                    end;
                }
                field("Procurement Category Code"; Rec."Procurement Category Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Approval Time"; Rec."Approval Time")
                {
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;
                    Caption = 'Default';
                    visible = false;
                }
            }
            part(PurchLines; "Purchase Quote Subform")
            {
                Editable = InvTcode;
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = Basic;
            }
            group("Foreign Trade")
            {
                visible = false;
                Caption = 'Foreign Trade';
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                    Importance = Promoted;

                    trigger OnAssistEdit()
                    begin
                        Clear(ChangeExchangeRate);
                        //ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", WorkDate);
                        // if ChangeExchangeRate.RunModal = ACTION::OK then begin
                        //     Rec.Validate("Currency Factor", ChangeExchangeRate.GetParameter);
                        //     CurrPage.Update;
                        // end;
                        Clear(ChangeExchangeRate);
                    end;

                    trigger OnValidate()
                    begin
                        CurrencyCodeOnAfterValidate;
                    end;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic;
                    Editable = InvTcode;

                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = Basic;
                    Editable = InvTcode;

                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = Basic;
                    Editable = InvTcode;

                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ApplicationArea = Basic;
                    Editable = InvTcode;

                }
                field("Area"; Rec.Area)
                {
                    ApplicationArea = Basic;
                    Editable = InvTcode;

                }
            }
        }
        area(factboxes)
        {
            part(Control1901138007; "Vendor Details FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = false;
                ApplicationArea = Basic;
            }
            part(Control1904651607; "Vendor Statistics FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = true;
                ApplicationArea = Basic;
            }
            part(Control1903435607; "Vendor Hist. Buy-from FactBox")
            {
                SubPageLink = "No." = FIELD("Buy-from Vendor No.");
                Visible = true;
                ApplicationArea = Basic;
            }
            part(Control1906949207; "Vendor Hist. Pay-to FactBox")
            {
                SubPageLink = "No." = FIELD("Pay-to Vendor No.");
                Visible = false;
            }
            part(Control1906354007; "Approval FactBox")
            {
                SubPageLink = "Table ID" = CONST(38),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No.");
                Visible = false;
                ApplicationArea = Basic;
            }
            part(Control5; "Purchase Line FactBox")
            {
                Provider = PurchLines;
                SubPageLink = "Document Type" = FIELD("Document Type"),
                              "No." = FIELD("No."),
                              "Line No." = FIELD("Line No.");
                ApplicationArea = Basic;
            }
            systempart(Control1900383207; Links)
            {
                Visible = true;
                ApplicationArea = Basic;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Quote")
            {
                Caption = '&Quote';
                Image = Quote;
                action(Statistics)
                {
                    ApplicationArea = Basic;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        Rec.CalcInvDiscForHeader;
                        Commit;
                        PAGE.RunModal(PAGE::"Purchase Statistics", Rec);
                    end;
                }
                action(Vendor)
                {
                    ApplicationArea = Basic;
                    Caption = 'Vendor';
                    Image = Vendor;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                }
                // action("Co&mments")
                // {
                //     Caption = 'Co&mments';
                //     Image = ViewComments;
                //     RunObject = Page "Purch. Comment Sheet";
                //     RunPageLink = "Document Type" = FIELD("Document Type"),
                //                   "No." = FIELD("No."),
                //                   "Document Line No." = CONST(0);
                // }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SaveRecord;
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Print")
            {
                ApplicationArea = Basic;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin


                    if LinesCommitted then
                        Error('All Lines should be committed');
                    Rec.Reset;
                    Rec.SetRange("No.", Rec."No.");
                    REPORT.Run(39005984, true, true, Rec);
                    Rec.Reset;
                    DocPrint.PrintPurchHeader(Rec);
                end;
            }
            action(Print)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Requisition Form';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;

                trigger OnAction()
                begin
                    //IF Posted=FALSE THEN ERROR('Post the receipt before printing.');
                    rec.Reset;
                    rec.SetFilter("No.", Rec."No.");
                    REPORT.Run(Report::"Purchase Requisition Form", true, true, Rec);
                    //rec.Reset;
                end;
            }
            group(Action3)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                separator(Action148)
                {
                }
                action(Release)
                {
                    ApplicationArea = Basic;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    Visible = false;

                    trigger OnAction()
                    var
                    //  ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        //  ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                // action("Award Schedule")
                // {
                //     RunObject = Page Page39005947;
                // }
                action("Re&open")
                {
                    ApplicationArea = Basic;
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Visible = false;

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                action("Reset Document Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reset Document Date';
                    Image = ResetStatus;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                    //  ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        if Rec.Status <> Rec.Status::Open then Error('You cannot reset document date when the status is not open');
                        if Confirm('Are you sure you want to reset the document date?', false) = true then begin
                            Rec."Document Date" := Today;
                            Rec.Modify;
                            Rec.Validate("Document Date");
                            Message('Date has been reset successfully');
                        end;
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Calculate &Invoice Discount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                    end;
                }
                separator(Action144)
                {
                }
                action("Get St&d. Vend. Purchase Codes")
                {
                    ApplicationArea = Basic;
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;
                    Image = VendorCode;

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record "Standard Vendor Purchase Code";
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                separator(Action146)
                {
                }
                action(CopyDocument)
                {
                    ApplicationArea = Basic;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RunModal;
                        Clear(CopyPurchDoc);
                    end;
                }
                action("Archive Document")
                {
                    ApplicationArea = Basic;
                    Caption = 'Archi&ve Document';
                    Image = Archive;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.Update(false);
                    end;
                }
                separator(Action10)
                {
                }
                action("Check Budget Availability")
                {
                    ApplicationArea = Basic;
                    Image = Balance;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        BCSetup.Get;
                        if not BCSetup.Mandatory then
                            exit;

                        if Rec.Status = Rec.Status::Released then
                            Error('This document has already been released. This functionality is available for open documents only');
                        if SomeLinesCommitted then begin
                            if not Confirm('Some or All the Lines Are already Committed do you want to continue', true, Rec."Document Type") then
                                Error('Budget Availability Check and Commitment Aborted');
                            DeleteCommitment.Reset;
                            DeleteCommitment.SetRange(DeleteCommitment."Document Type", DeleteCommitment."Document Type"::Requisition);
                            DeleteCommitment.SetRange(DeleteCommitment."Document No.", Rec."No.");
                            DeleteCommitment.DeleteAll;
                        end;
                        Commitment.CheckPurchase(Rec);
                        Message('Budget Availability Checking Complete');
                    end;
                }
                action("Cancel Budget Commitment")
                {
                    ApplicationArea = Basic;
                    Image = CancelAllLines;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin

                        if not Confirm('Are you sure you want to Cancel All Commitments Done for this document', true, Rec."Document Type") then
                            Error('Budget Availability Check and Commitment Aborted');

                        DeleteCommitment.Reset;
                        DeleteCommitment.SetRange(DeleteCommitment."Document Type", DeleteCommitment."Document Type"::Requisition);
                        DeleteCommitment.SetRange(DeleteCommitment."Document No.", Rec."No.");
                        DeleteCommitment.DeleteAll;
                        //Tag all the Purchase Line entries as Uncommitted
                        PurchLine.Reset;
                        PurchLine.SetRange(PurchLine."Document Type", Rec."Document Type");
                        PurchLine.SetRange(PurchLine."Document No.", Rec."No.");
                        if PurchLine.Find('-') then begin
                            repeat
                                PurchLine.Committed := false;
                                PurchLine.Modify;
                            until PurchLine.Next = 0;
                        end;

                        Message('Commitments Cancelled Successfully for Doc. No %1', Rec."No.");
                    end;
                }
            }
            group(Action7)
            {
                Caption = 'Make Order';
                Image = MakeOrder;
                action("Make Order")
                {
                    ApplicationArea = Basic;
                    Caption = 'Make &Order';
                    Image = MakeOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        // IF ApprovalMgt.PrePostApprovalCheckPurch(SalesHeader,Rec) THEN
                        //  CODEUNIT.RUN(CODEUNIT::"Purch.-Quote to Order (Yes/No)",Rec);
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        // IF NOT LinesExists THEN
                        //    ERROR('There are no Lines created for this Document');

                        // IF NOT AllFieldsEntered THEN
                        //    ERROR('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

                        // //Ensure No Items That should be committed that are not
                        IF LinesCommitted THEN
                            if not Confirm('Do you wish to proceed without a budget Check ?', true, rec."No.") then exit;

                        if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                        if rec.status = rec.status::Released then begin
                            rec."Approval Time" := DT2Time(CurrentDateTime);
                            rec.modify(true);
                        end;

                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
            }
            group(Navigate)
            {
                Caption = 'Navigate';
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                    //ApprovalEntries: Page "Approval Entries";
                    /// DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Purchase Requisition";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId)
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    // RunObject = Page "Approval Comments";
                    // RunPageLink = "Table ID" = CONST(52185912),
                    //               "Document No." = FIELD("No.");
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
        }
    }


    trigger OnAfterGetCurrRecord()
    begin

        UpdateControls;

    end;

    trigger OnAfterGetRecord()
    begin
        UpdateControls;

    end;


    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SaveRecord;
        exit(Rec.ConfirmDeletion);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        PurchSetup: Record "Purchases & Payables Setup";
        No: code[20];
    begin
        PurchSetup.Get();
        PurchSetup.TestField("Requisition Default Vendor");
        if not Vendors.get(PurchSetup."Requisition Default Vendor") then
            Error('Default Vendor was not found in the vendor list please check the Purchase and Payables Setup') else begin
            rec."Buy-from Vendor No." := Vendors."No.";
            rec.Validate("Buy-from Vendor No.");
        end;
        rec.DocApprovalType := Rec.DocApprovalType::Requisition;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        PurchSetup: Record "Purchases & Payables Setup";
        No: code[20];
    begin
        // Rec."Responsibility Center" := UserMgt.GetPurchasesFilter;
        // Rec."Assigned User ID" := UserId;
        // usersetup.reset();
        // usersetup.SetRange("User ID",UserId);
        // IF usersetup.FindFirst() then begin
        //     rec."Shortcut Dimension 1 Code":=usersetup."Global Dimension 1 Code";
        //     rec."Shortcut Dimension 2 Code":=usersetup."Global Dimension 2 Code";
        //     rec."Responsibility Center":=usersetup."Responsibility Centre";



        // rec."Document Type" := rec."Document Type"::"Purchase Requisition";
        // if rec."Document Type" = rec."Document Type"::"Purchase Requisition" then begin
        //     PurchSetup.Get;
        //     PurchSetup.TestField("Purchase Requisition No.");
        //     NoSeriesMgt.InitSeries(PurchSetup."Purchase Requisition No.", PurchSetup."Purchase Requisition No.", 0D, No, PurchSetup."Purchase Requisition No.");
        //     rec."No." := '123';
        //     xRec."No." := Rec."No.";
        //     xrec.Modify();
        // end;
        rec.DocApprovalType := Rec.DocApprovalType::Requisition;


    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        //UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
        /*
        IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
          FILTERGROUP(0);
        END;
        */

    end;

    var
        ChangeExchangeRate: Page "Change Exchange Rate";
        CopyPurchDoc: Report "Copy Purchase Document";
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management";
        usersetup: record "User Setup";
        ArchiveManagement: Codeunit ArchiveManagement;
        Commitment: Codeunit "Budgetary Control";
        BCSetup: Record "Budgetary Control Setup";
        DeleteCommitment: Record Committment;
        PurchLine: Record "Purchase Line";
        StatusEditable: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        InvTcode: Boolean;
        Inst: Boolean;
        DepType: Boolean;
        member: record Members;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        IntMode: Boolean;
        CurrCode: Boolean;
        RespCenter: Boolean;
        Rmks: Boolean;
        WtaxCode: Boolean;
        INVdate: Boolean;
        pType: Boolean;
        Freq: Boolean;
        Intrate: Boolean;
        Mmarketpage: Boolean;

        Vendors: Record Vendor;
        CustomSubCU: Codeunit MySubscribers;




    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.PurchLines.PAGE.ApproveCalcInvDisc;
    end;

    local procedure BuyfromVendorNoOnAfterValidate()
    begin
        if Rec.GetFilter("Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
            if Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
                Rec.SetRange("Buy-from Vendor No.");
        CurrPage.Update;
    end;

    local procedure PurchaserCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(true);
    end;

    local procedure PaytoVendorNoOnAfterValidate()
    begin
        CurrPage.Update;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(true);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(true);
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.Update;
    end;

    local procedure CurrencyCodeOnAfterValidate()
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(true);
    end;

    //[Scope('OnPrem')]
    procedure LinesCommitted() Exists: Boolean
    var
        PurchLines: Record "Purchase Line";
    begin
        if BCSetup.Get() then begin
            if not BCSetup.Mandatory then begin
                Exists := false;
                exit;
            end;
        end else begin
            Exists := false;
            exit;
        end;
        if BCSetup.Get then begin
            Exists := false;
            PurchLines.Reset;
            PurchLines.SetRange(PurchLines."Document Type", Rec."Document Type");
            PurchLines.SetRange(PurchLines."Document No.", Rec."No.");
            PurchLines.SetRange(PurchLines.Committed, false);
            if PurchLines.Find('-') then
                Exists := true;
        end else
            Exists := false;
    end;

    //[Scope('OnPrem')]
    procedure SomeLinesCommitted() Exists: Boolean
    var
        PurchLines: Record "Purchase Line";
    begin
        if BCSetup.Get then begin
            Exists := false;
            PurchLines.Reset;
            PurchLines.SetRange(PurchLines."Document Type", Rec."Document Type");
            PurchLines.SetRange(PurchLines."Document No.", Rec."No.");
            PurchLines.SetRange(PurchLines.Committed, true);
            if PurchLines.Find('-') then
                Exists := true;
        end else
            Exists := false;
    end;

    //[Scope('OnPrem')]

    procedure UpdateControls()
    begin


        if Rec.Status = Rec.Status::Open then begin
            InvTcode := true;
            Inst := true;
            DepType := true;
            IntMode := true;
            CurrCode := true;
            RespCenter := true;
            Rmks := true;
            WtaxCode := true;
            INVdate := true;
            pType := true;
            Freq := true;
            Intrate := true;
            Mmarketpage := true;
        end;


        if Rec.Status = Rec.Status::"Pending Approval" then begin
            InvTcode := false;
            Inst := false;
            DepType := false;
            IntMode := false;
            CurrCode := false;
            RespCenter := false;
            Rmks := false;
            WtaxCode := false;
            INVdate := false;
            pType := false;
            Freq := false;
            Intrate := false;
            Mmarketpage := false;
        end;


        if Rec.Status = Rec.Status::Released then begin
            InvTcode := false;
            Inst := false;
            DepType := false;
            IntMode := false;
            CurrCode := false;
            RespCenter := false;
            Rmks := false;
            WtaxCode := false;
            INVdate := false;
            pType := false;
            Freq := false;
            Intrate := false;
            Mmarketpage := false;
        end;


    end;


    //[Scope('OnPrem')]
    procedure CurrPageUpdate()
    begin
        xRec := Rec;
        //UpdateControls;
        CurrPage.Update;
    end;

    local procedure SetControlAppearance()
    var
    // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        //    OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;
}

