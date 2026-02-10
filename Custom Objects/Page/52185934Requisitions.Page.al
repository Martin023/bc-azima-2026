page 52185934 Requisitions
{
    // CardPageID = "Internal Requisitions";
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approvals,Budget,Category6_caption,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Quote),
                            DocApprovalType = FILTER(Requisition),
                            Status = FILTER(<> Released));
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Procurement Category Code"; Rec."Procurement Category Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755012; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control1102755013; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control1102755014; Links)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("<Action59>")
            {
                Caption = '&Quote';
                action("<Action61>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Statistics';
                    Image = Statistics;
                    ShortCutKey = 'F7';

                    trigger OnAction()
                    begin
                        Rec.CalcInvDiscForHeader;
                        Commit;
                        PAGE.RunModal(PAGE::"Purchase Statistics", Rec);
                    end;
                }
                action("<Action62>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Card';
                    Image = EditLines;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F7';
                }
                action("<Action63>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    // RunObject = Page "Purch. Comment Sheet";
                    // RunPageLink = Rec."Document Type" = FIELD("Document Type"),
                    //               Rec."No." = FIELD("No."),
                    //               "Document Line No." = CONST(0);
                }
                action("<Action111>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }
            }
            group("<Action104>")
            {
                Caption = '&Line';
                group("<Action105>")
                {
                    Caption = 'Item Availability by';
                    action("<Action109>")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Variant';
                    }
                    action("<Action106>")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Location';
                    }
                }
                action("<Action112>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                }
                action("<Action168>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                }
                action("<Action5800>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item Charge &Assignment';
                }
                action("<Action6500>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';
                }
            }
        }
        area(processing)
        {
            action("<Action69>")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Make &Order';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                //ApprovalMgt: Codeunit 1535;
                begin
                    /*
                    IF LinesCommitted THEN
                       ERROR('All Lines should be committed');
                    
                    IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
                      CODEUNIT.RUN(CODEUNIT::"Purch.-Quote to Order (Yes/No)",Rec);
                    */

                end;
            }
            group("<Action64>")
            {
                Caption = 'F&unctions';
                action("<Action65>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;

                    trigger OnAction()
                    begin
                        ApproveCalcInvDisc;
                    end;
                }
                separator(Action1102755037)
                {
                }
                action("<Action67>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                }
                action("<Action18>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Insert &Ext. Texts';
                }
                separator(Action1102755034)
                {
                }
                action("<Action143>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        StdVendPurchCode: Record "Standard Vendor Purchase Code";
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                separator(Action1102755032)
                {
                }
                action("<Action66>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;

                    trigger OnAction()
                    begin
                        // rec.CopyPurchDoc.SetPurchHeader(Rec);
                        // CopyPurchDoc.RunModal;
                        // Clear(CopyPurchDoc);
                    end;
                }
                action("<Action138>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Archi&ve Document';

                    trigger OnAction()
                    begin
                        // ArchiveManagement.ArchivePurchDocument(Rec);
                        // CurrPage.Update(false);
                    end;
                }
                separator(Action1102755026)
                {
                }
                action("<Action1102755002>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Check Budget Availability';
                    Image = Balance;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        BCSetup: Record "Budgetary Control Setup";
                    begin

                        // BCSetup.Get;
                        // if not BCSetup.Mandatory then
                        //     exit;

                        // if Rec.Status = Rec.Status::Released then
                        //     Error('This document has already been released. This functionality is available for open documents only');
                        // if not SomeLinesCommitted then begin
                        //     if not Confirm('Some or All the Lines Are already Committed do you want to continue', true, Rec."Document Type") then
                        //         Error('Budget Availability Check and Commitment Aborted');
                        //     DeleteCommitment.Reset;
                        //     DeleteCommitment.SetRange(DeleteCommitment."Document Type", DeleteCommitment."Document Type"::LPO);
                        //     DeleteCommitment.SetRange(DeleteCommitment."Document No.", Rec."No.");
                        //     DeleteCommitment.DeleteAll;
                        // end;
                        //Commitment.CheckPurchase(Rec);
                        Message('Budget Availability Checking Complete');
                    end;
                }
                action("<Action1102755003>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Budget Commitment';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if not Confirm('Are you sure you want to Cancel All Commitments Done for this document', true, Rec."Document Type") then
                            Error('Budget Availability Check and Commitment Aborted');

                        // DeleteCommitment.Reset;
                        // DeleteCommitment.SetRange(DeleteCommitment."Document Type", DeleteCommitment."Document Type"::LPO);
                        // DeleteCommitment.SetRange(DeleteCommitment."Document No.", Rec."No.");
                        // DeleteCommitment.DeleteAll;
                        // //Tag all the Purchase Line entries as Uncommitted
                        // PurchLine.Reset;
                        // PurchLine.SetRange(PurchLine."Document Type", Rec."Document Type");
                        // PurchLine.SetRange(PurchLine."Document No.", Rec."No.");
                        // if PurchLine.Find('-') then begin
                        //     repeat
                        //         PurchLine.Committed := false;
                        //         PurchLine.Modify;
                        //     until PurchLine.Next = 0;
                        // end;

                        Message('Commitments Cancelled Successfully for Doc. No %1', Rec."No.");
                    end;
                }
                separator(Action1102755023)
                {
                }
                action("<Action118>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        if LinesCommitted then
                            Error('All Lines should be committed');

                        //ReleasePurchDoc.PerformManualRelease(Rec);
                    end;
                }
                action("<Action119>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re&open';
                    Image = ReOpen;

                    trigger OnAction()
                    var
                    // ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        if LinesCommitted then
                            Error('All Lines should be committed');

                        // ReleasePurchDoc.PerformManualReopen(Rec);
                    end;
                }
                separator(Action1102755020)
                {
                }
                action("<Action135>")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Send BizTalk Rqst. for Purch. Quote';

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        //IF ApprovalMgt.PrePostApprovalCheck(SalesHeader,Rec) THEN
                        //  BizTalkManagement.SendReqforPurchQuote(Rec);
                    end;
                }
            }
            action("<Action70>")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if LinesCommitted then
                        Error('All Lines should be committed');
                    rec.Reset;
                    rec.SetRange("No.", Rec."No.");
                    //REPORT.Run(52185989, true, true, Rec);
                    rec.Reset;
                    //DocPrint.PrintPurchHeader(Rec);
                end;
            }
            action(PurchHistoryBtn)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase H&istory';
                // Visible = PurchHistoryBtnVisible;

                trigger OnAction()
                begin
                    //PurchInfoPaneMgmt.LookupVendPurchaseHistory(Rec,"Pay-to Vendor No.",TRUE);
                end;
            }
            action("<Action158>")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Contacts';
            }
            action("<Action159>")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Order &Addresses';
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    // Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        // if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
                        //     ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    // Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        // ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
            }
            group(Navigate)
            {
                Caption = 'Navigate';
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                    //     // //ApprovalEntries: Page "Approval Entries";
                    //     // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //     /*
                        //     DocumentType := DocumentType::"Payment Voucher";
                        //     ApprovalEntries.SetRecordFilters(DATABASE::"Payments Header","Document Type","No.");
                        //     ApprovalEntries.RUN;
                        //     */
                        //     ApprovalsMgmt.OpenApprovalEntriesPage(RecordId);

                    end;
                }
            }
        }
    }

    var
        PurchSetup: Record "Purchases & Payables Setup";
        // CopyPurchDoc: Report "Copy Purchase Document";
        // DocPrint: Codeunit "Document-Print";
        // //UserMgt: Codeunit "User Setup Management BR";
        // ArchiveManagement: Codeunit ArchiveManagement;
        // PurchInfoPaneMgmt: Codeunit "Purchases Info-Pane Management";
        // //Commitment: Codeunit "Budgetary Control";
        BCSetup: Record "Budgetary Control Setup";
        // DeleteCommitment: Record Committment;
        // PurchLine: Record "Purchase Line";
        // 
        // PurchHistoryBtnVisible: Boolean;
        // 
        PayToCommentPictVisible: Boolean;

        PayToCommentBtnVisible: Boolean;

        PurchHistoryBtn1Visible: Boolean;

        PurchLinesEditable: Boolean;
    // // //ApprovalEntries: Page "Approval Entries";
    // "NOT OpenApprovalEntriesExist": Boolean;
    // OpenApprovalEntriesExistForCurrUser: Boolean;
    // OpenApprovalEntriesExist: Boolean;

    local procedure ApproveCalcInvDisc()
    begin
    end;

    local procedure UpdateInfoPanel()
    var
        DifferBuyFromPayTo: Boolean;
    begin
        // DifferBuyFromPayTo := "Buy-from Vendor No." <> "Pay-to Vendor No.";
        // PurchHistoryBtnVisible := DifferBuyFromPayTo;
        // PayToCommentPictVisible := DifferBuyFromPayTo;
        // PayToCommentBtnVisible := DifferBuyFromPayTo;
        /*
        PurchHistoryBtn1Visible := PurchInfoPaneMgmt.DocExist(Rec,"Buy-from Vendor No.");
        IF DifferBuyFromPayTo THEN
          PurchHistoryBtnVisible := PurchInfoPaneMgmt.DocExist(Rec,"Pay-to Vendor No.")
        */

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
        if rec.Status <> rec.Status::Open then begin
            PurchLinesEditable := false;
        end else
            PurchLinesEditable := true;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
    end;

    local procedure CurrencyCodeOnAfterValidate()
    begin
    end;

    local procedure OnAfGetCurrRecord()
    begin
        xRec := Rec;

        UpdateControls;
    end;

    local procedure SetControlAppearance()
    var
    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
    end;
}

