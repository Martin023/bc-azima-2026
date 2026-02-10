page 52185902 "Store Requisition Header"
{
    DeleteAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approvals,Cancellation,Category6_caption,Category7_caption,Category8_caption,Approvals,Category10_caption';
    SourceTable = "Store Requistion Header";
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Editable = False;
                }
                field("Request date"; Rec."Request date")
                {
                    ApplicationArea = Basic;
                    Editable = Inst;

                    trigger OnValidate()
                    begin
                        //Not allow back date
                        //IF TODAY > "Posting Date" THEN ERROR('Posting Date Cannot be %1',"Posting Date");
                    end;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Function Name"; Rec."Function Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
                    Editable = true;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                // field("Budget Center Name"; Rec."Budget Center Name")
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Description';
                //     Editable = false;
                // }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = false;
                }
                field(Dim3; Rec.Dim3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Visible = false;
                }
                field(Dim4; Rec.Dim4)
                {
                    ApplicationArea = Basic;
                    Caption = 'Description';
                    Editable = false;
                    Visible = false;
                }
                field("Request Reason"; Rec."Request Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Request Reason';
                    Editable = DepType;
                }
                field("Required Date"; Rec."Required Date")
                {
                    ApplicationArea = Basic;
                    Editable = IntMode;

                    trigger OnValidate()
                    begin
                        //Not allow back date
                        //IF TODAY > "Posting Date" THEN ERROR('Posting Date Cannot be %1',"Posting Date");
                    end;
                }
                field("Issuing Store"; Rec."Issuing Store")
                {
                    ApplicationArea = Basic;
                    Editable = CurrCode;
                }
                field("Store Description"; Rec."Store Description")
                {
                    Editable = false;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic;
                    Editable = False;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = Basic;

                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;

                }

            }
            part(Control1102755015; "Store Requisition Line")
            {
                SubPageLink = "Requistion No" = FIELD("No.");
                //editable = Dimension;
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';
                action("Post Store Requisition")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Store Requisition';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = true;

                    trigger OnAction()
                    var
                        ItemLedger: Record "Item Ledger Entry";
                    begin
                        if not LinesExists then
                            Error('There are no Lines created for this Document');

                        if Rec.Posted = true then
                            Error('The Document Has Already been Posted');

                        if Rec.Status <> Rec.Status::Released then
                            Error('The Document Has not yet been Approved');
                        if InventorySetup.Get then begin
                            InventorySetup.TestField(InventorySetup."Item Jnl Template");
                            InventorySetup.TestField(InventorySetup."Item Jnl Batch");
                            GenJnline.Reset;
                            GenJnline.SetRange(GenJnline."Journal Template Name", InventorySetup."Item Jnl Template");
                            GenJnline.SetRange(GenJnline."Journal Batch Name", InventorySetup."Item Jnl Batch");
                            if GenJnline.Find('-') then GenJnline.DeleteAll;


                            ReqLine.Reset;
                            ReqLine.SetRange(ReqLine."Requistion No", Rec."No.");
                            Rec.TestField("Issuing Store");
                            if ReqLine.Find('-') then begin
                                repeat
                                    //Issue
                                    LineNo := LineNo + 1000;
                                    GenJnline.Init;
                                    GenJnline."Journal Template Name" := InventorySetup."Item Jnl Template";
                                    GenJnline."Journal Batch Name" := InventorySetup."Item Jnl Batch";
                                    GenJnline."Line No." := LineNo;
                                    GenJnline."Entry Type" := GenJnline."Entry Type"::"Negative Adjmt.";
                                    GenJnline."Document No." := Rec."No.";
                                    GenJnline."Item No." := ReqLine."No.";
                                    GenJnline.Validate("Item No.");
                                    GenJnline."Location Code" := ReqLine."Issuing Store";
                                    GenJnline."Bin Code" := ReqLine."Bin Code";
                                    GenJnline.Validate("Location Code");
                                    GenJnline."Posting Date" := Today;
                                    GenJnline.Description := ReqLine.Description;
                                    ItemLedger.Reset;
                                    ItemLedger.SetRange(ItemLedger."Item No.", ReqLine."No.");
                                    ItemLedger.SetRange(ItemLedger."Location Code", ReqLine."Issuing Store");
                                    // ItemLedger.CalcSums(Quantity);
                                    // if ItemLedger.Quantity <= 0 then Error('Item %1 is out of stock in store %2', ReqLine.Description, ReqLine."Issuing Store");
                                    GenJnline.Quantity := ReqLine."Quantity";
                                    GenJnline."Shortcut Dimension 1 Code" := ReqLine."Shortcut Dimension 1 Code";
                                    GenJnline.Validate("Shortcut Dimension 1 Code");
                                    GenJnline."Shortcut Dimension 2 Code" := ReqLine."Shortcut Dimension 2 Code";
                                    GenJnline.Validate("Shortcut Dimension 2 Code");
                                    //GenJnline."Lot No.":=ReqLine."Lot No.";
                                    GenJnline."Dimension Set ID" := ReqLine."Dimension Set ID";
                                    GenJnline.Validate(Quantity);
                                    GenJnline.Validate("Unit Amount");
                                    GenJnline."Reason Code" := '221';
                                    //GenJnline.VALIDATE("Reason Code");
                                    GenJnline."Gen. Prod. Posting Group" := ReqLine."Gen. Prod. Posting Group";
                                    GenJnline."Gen. Bus. Posting Group" := ReqLine."Gen. Bus. Posting Group";
                                    GenJnline.Insert(true);

                                    //ReqLine."Request Status":=ReqLine."Request Status"::Closed;

                                    //Denno Added to take care of lot numbers-----------------
                                    //If Lot No field  Exist then insert reservation line
                                    ResEntry.Reset;
                                    ResEntry.SetRange(ResEntry."Entry No.");
                                    if ResEntry.Find('+') then LastResNo := ResEntry."Entry No.";

                                    LastResNo := LastResNo + 1;

                                    if ReqLine."Lot No." <> '' then begin
                                        ResEntry.Init;
                                        ResEntry."Entry No." := LastResNo;   //ResEntry."Entry No."
                                        ResEntry."Item No." := ReqLine."No.";
                                        ResEntry."Location Code" := ReqLine."Issuing Store";
                                        ResEntry."Quantity (Base)" := -ReqLine.Quantity;
                                        ResEntry.Validate("Quantity (Base)");
                                        ResEntry.Quantity := -ReqLine.Quantity;
                                        ResEntry."Qty. to Handle (Base)" := -ReqLine.Quantity;
                                        ResEntry.Validate("Qty. to Handle (Base)");
                                        ResEntry."Reservation Status" := ResEntry."Reservation Status"::Prospect;
                                        ResEntry."Creation Date" := Today;
                                        ResEntry."Source Type" := 83;
                                        ResEntry."Source Subtype" := 3;
                                        ResEntry."Source ID" := 'ITEM';
                                        ResEntry."Source Batch Name" := 'DEFAULT';
                                        ResEntry."Source Ref. No." := LineNo;
                                        ResEntry."Lot No." := ReqLine."Lot No.";
                                        ResEntry."Item Tracking" := ResEntry."Item Tracking"::"Lot No.";
                                        ResEntry.Insert;

                                    end;
                                    ReqLine."Last Date of Issue" := Today;
                                    ReqLine.Modify();
                                //End Denno Added to take care of lot numbers-----------------

                                until ReqLine.Next = 0;

                                Rec.Posted := true;
                                Rec.status := rec.status::Posted;
                                Rec."Date Posted" := Today;
                                Rec.Modify(true);

                                //Post Entries
                                if Rec.status = Rec.status::Posted then begin
                                    GenJnline.Reset;
                                    GenJnline.SetRange(GenJnline."Journal Template Name", InventorySetup."Item Jnl Template");
                                    GenJnline.SetRange(GenJnline."Journal Batch Name", InventorySetup."Item Jnl Batch");
                                    CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", GenJnline);
                                end;
                                //End Post entries

                            end
                            else
                                error('No lines to post');
                        end;
                        // if not SendEmails then begin
                        //     Message('Email not sent.');
                        // end;

                    end;

                    /*
                    Status:=Status::Posted;
                    MODIFY;
                    */


                }
                separator(Action1102755035)
                {
                }
                action("Print/Preview")
                {
                    ApplicationArea = Basic;
                    Caption = 'Print/Preview';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.Reset;
                        Rec.SetFilter(Rec."No.", Rec."No.");
                        //REPORT.Run(52185785, true, true, Rec);
                        Rec.Reset;
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
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                    // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    // CustomApprovalsCodeunit: Codeunit "Custom Approvals Codeunit";
                    begin
                        Rec.TestField("Issuing Store");
                        if not LinesExists then
                            Error('There are no Lines created for this Document');

                        // if not AllFieldsEntered then
                        //     Error('Some of the Key Fields on the Lines:[ACCOUNT NO.,AMOUNT] Have not been Entered please RECHECK your entries');

                        // //Ensure No Items That should be committed that are not
                        // if LinesCommitmentStatus then
                        //     Error('There are some lines that have not been committed');

                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    // CustomApprovalsCodeunit: Codeunit "Custom Approvals Codeunit";
                    begin
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
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
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        // //ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /*
                        DocumentType := DocumentType::"Payment Voucher";
                        ApprovalEntries.SetRecordFilters(DATABASE::"Payments Header","Document Type","No.");
                        ApprovalEntries.RUN;
                        */
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);

                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approve';
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    //Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        reqtoApp: page "Requests to Approve";
                        APPEntry: Record "Approval Entry";
                        members: Record 52185700;
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                        if rec.Status = rec.Status::Released then exit;
                        IF not ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId) THEN BEGIN
                            Rec.Status := REC.Status::Released;
                            REC.Modify();
                        end;


                        //members.SetRange("No.", APPEntry."Document No.");

                    END;
                }
                action("Reopen  Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reopen  Card';
                    Image = OpenJournal;
                    Promoted = true;
                    PromotedCategory = Category9;


                    trigger OnAction()
                    begin
                        Message('Sets the status of job to open');

                        Rec.Status := Rec.Status::Open;
                        Rec.Modify;
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
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
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
                    // RunPageLink = "Table ID" = CONST(52185868),
                    //               "Document No." = FIELD("No.");
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        CurrPageUpdate;
        SetControlAppearance;
        UpdateControls;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // "Responsibility Center" := UserMgt.GetPurchasesFilter();
        // //Add dimensions if set by default here
        // "Global Dimension 1 Code" := UserMgt.GetSetDimensions(UserId, 1);
        // Validate("Global Dimension 1 Code");
        // "Shortcut Dimension 2 Code" := UserMgt.GetSetDimensions(UserId, 2);
        // Validate("Shortcut Dimension 2 Code");
        // "Shortcut Dimension 3 Code" := UserMgt.GetSetDimensions(UserId, 3);
        // Validate("Shortcut Dimension 3 Code");
        // "Shortcut Dimension 4 Code" := UserMgt.GetSetDimensions(UserId, 4);
        // Validate("Shortcut Dimension 4 Code");

        UpdateControls;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        // if (Rec.Status = Rec.Status::"Pending Approval") or (Rec.Status = Rec.Status::Released) then
        //     CurrPage.Editable := true;

        // if Rec.Status = Rec.Status::Open then begin
        //     PageActionsVisible := false;
        // end else
        //     if Rec.Status <> Rec.Status::Open then begin
        //         PageActionsVisible := true;
        //     end;
        UpdateControls;




        /*
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center" ,UserMgt.GetPurchasesFilter());
          FILTERGROUP(0);
        END;
        */

    end;

    var
        // UserMgt: Codeunit "User Setup Management BR";
        ReqLine: Record "Store Requistion Lines";
        InventorySetup: Record "Inventory Setup";
        GenJnline: Record "Item Journal Line";
        LineNo: Integer;
        Post: Boolean;
        // JournlPosted: Codeunit "Journal Post Successful";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batches,Loan,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,"HRTransport Request",HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation","Overdraft ",BLA,"Member Editable","MSacco Applications","MSacco PinChange","MSacco PhoneChange","MSacco TransChange",BulkSMS,"Payment Voucher","Petty Cash",Imp,Requisition,ImpSurr,Interbank,Receipt,"Staff Claim","Staff Adv",AdvSurr,OT;
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        ApprovalEntries: Page "Approval Entries";

        StatusEditable: Boolean;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";

        PageActionsVisible: Boolean;
        Text046: Label 'The %1 does not match the quantity defined in item tracking.';
        ResEntry: Record "Reservation Entry";
        LastResNo: Integer;
        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        StoreRequistionHeader: Record "Store Requistion Header";
        Trans: Record "Store Requistion Header";

    //[Scope('OnPrem')]
    procedure LinesExists(): Boolean
    var
        PayLines: Record "Store Requistion Lines";
    begin
        HasLines := false;
        PayLines.Reset;
        PayLines.SetRange(PayLines."Requistion No", Rec."No.");
        if PayLines.Find('-') then begin
            HasLines := true;
            exit(HasLines);
        end;
    end;

    //[Scope('OnPrem')]


    //[Scope('OnPrem')]
    procedure CurrPageUpdate()
    begin
        //xRec:=Rec;
        UpdateControls;
        //CurrPage.UPDATE;
    end;

    local procedure CheckTrackingSpecification(var PurchLine: Record "Store Requistion Lines")
    var
        PurchLineToCheck: Record "Store Requistion Lines";
        ReservationEntry: Record "Reservation Entry";
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        ItemTrackingManagement: Codeunit "Item Tracking Management";
        ErrorFieldCaption: Text[250];
        SignFactor: Integer;
        PurchLineQtyHandled: Decimal;
        PurchLineQtyToHandle: Decimal;
        TrackingQtyHandled: Decimal;
        TrackingQtyToHandle: Decimal;
        Inbound: Boolean;
        SNRequired: Boolean;
        LotRequired: Boolean;
        SNInfoRequired: Boolean;
        LotInfoReguired: Boolean;
        CheckPurchLine: Boolean;
    begin
        // if a PurchaseLine is posted with ItemTracking then the whole quantity of
        // the regarding PurchaseLine has to be post with Item-Tracking

        TrackingQtyToHandle := 0;
        TrackingQtyHandled := 0;

        PurchLineToCheck.Copy(PurchLine);
        PurchLineToCheck.SetRange(Type, PurchLineToCheck.Type::Item);
        //IF PurchHeader.Receive THEN BEGIN ---- Denno
        //  PurchLineToCheck.SETFILTER("Quantity Received",'<>%1',0);
        //  ErrorFieldCaption := PurchLineToCheck.FIELDCAPTION("Qty. to Receive");
        //END ELSE BEGIN
        PurchLineToCheck.SetFilter(Quantity, '<>%1', 0);
        ErrorFieldCaption := PurchLineToCheck.FieldCaption(Quantity);
        //END;

        if PurchLineToCheck.FindSet then begin
            ReservationEntry."Source Type" := DATABASE::"Store Requistion Lines";
            ReservationEntry."Source Subtype" := 0;//PurchHeader."Document Type";
            SignFactor := CreateReservEntry.SignFactor(ReservationEntry);
            repeat
                // Only Item where no SerialNo or LotNo is required
                Item.Get(PurchLineToCheck."No.");
                if Item."Item Tracking Code" <> '' then begin
                    Inbound := (PurchLineToCheck.Quantity * SignFactor) > 0;
                    ItemTrackingCode.Code := Item."Item Tracking Code";
                    //here
                    // ItemTrackingManagement.GetItemTrackingSettings(ItemTrackingCode,
                    //   GenJnline."Entry Type"::"Negative Adjmt.",
                    //   Inbound,
                    //   SNRequired,
                    //   LotRequired,
                    //   SNInfoRequired,
                    //   LotInfoReguired);
                    CheckPurchLine := (SNRequired = false) and (LotRequired = false);
                    if CheckPurchLine then
                        CheckPurchLine := GetTrackingQuantities(PurchLineToCheck, 0, TrackingQtyToHandle, TrackingQtyHandled);
                end else
                    CheckPurchLine := false;

                TrackingQtyToHandle := 0;
                TrackingQtyHandled := 0;

                if CheckPurchLine then begin
                    GetTrackingQuantities(PurchLineToCheck, 1, TrackingQtyToHandle, TrackingQtyHandled);
                    TrackingQtyToHandle := TrackingQtyToHandle * SignFactor;
                    TrackingQtyHandled := TrackingQtyHandled * SignFactor;
                    /*      IF PurchHeader.Receive THEN BEGIN
                            PurchLineQtyToHandle := PurchLineToCheck."Qty. to Receive (Base)";
                            PurchLineQtyHandled := PurchLineToCheck."Qty. Received (Base)";
                          END ELSE */
                    begin
                        PurchLineQtyToHandle := PurchLineToCheck.Quantity;
                        PurchLineQtyHandled := PurchLineToCheck.Quantity;
                    end;
                    if ((TrackingQtyHandled + TrackingQtyToHandle) <> (PurchLineQtyHandled + PurchLineQtyToHandle)) or
                       (TrackingQtyToHandle <> PurchLineQtyToHandle)
                    then
                        Error(StrSubstNo(Text046, ErrorFieldCaption));
                end;
            until PurchLineToCheck.Next = 0;
        end;

    end;

    local procedure GetTrackingQuantities(PurchLine: Record "Store Requistion Lines"; FunctionType: Option CheckTrackingExists,GetQty; var TrackingQtyToHandle: Decimal; var TrackingQtyHandled: Decimal): Boolean
    var
        TrackingSpecification: Record "Tracking Specification";
        ReservEntry: Record "Reservation Entry";
    begin
        with TrackingSpecification do begin
            SetCurrentKey("Source ID", "Source Type", "Source Subtype", "Source Batch Name",
              "Source Prod. Order Line", "Source Ref. No.");
            SetRange("Source Type", DATABASE::"Store Requistion Lines");
            SetRange("Source Subtype", 0);
            SetRange("Source ID", PurchLine."Requistion No");
            SetRange("Source Batch Name", '');
            SetRange("Source Prod. Order Line", 0);
            SetRange("Source Ref. No.", PurchLine."Line No.");
        end;
        with ReservEntry do begin
            SetCurrentKey(
              "Source ID", "Source Ref. No.", "Source Type", "Source Subtype",
              "Source Batch Name", "Source Prod. Order Line");
            SetRange("Source ID", PurchLine."Requistion No");
            SetRange("Source Ref. No.", PurchLine."Line No.");
            SetRange("Source Type", DATABASE::"Store Requistion Lines");
            SetRange("Source Subtype", 0);
            SetRange("Source Batch Name", '');
            SetRange("Source Prod. Order Line", 0);
        end;

        case FunctionType of
            FunctionType::CheckTrackingExists:
                begin
                    TrackingSpecification.SetRange(Correction, false);
                    if not TrackingSpecification.IsEmpty then
                        exit(true);
                    ReservEntry.SetFilter("Serial No.", '<>%1', '');
                    if not ReservEntry.IsEmpty then
                        exit(true);
                    ReservEntry.SetRange("Serial No.");
                    ReservEntry.SetFilter("Lot No.", '<>%1', '');
                    if not ReservEntry.IsEmpty then
                        exit(true);
                end;
            FunctionType::GetQty:
                begin
                    TrackingSpecification.CalcSums("Quantity Handled (Base)");
                    TrackingQtyHandled := TrackingSpecification."Quantity Handled (Base)";
                    if ReservEntry.FindSet then
                        repeat
                            if (ReservEntry."Lot No." <> '') or (ReservEntry."Serial No." <> '') then
                                TrackingQtyToHandle := TrackingQtyToHandle + ReservEntry."Qty. to Handle (Base)";
                        until ReservEntry.Next = 0;
                end;
        end;
    end;

    local procedure SetControlAppearance()
    var
    // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        //    OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;


    //[Scope('OnPrem')]
    procedure AllFieldsEntered(): Boolean
    var
        PayLines: Record "Store Requistion Lines";
    begin
        AllKeyFieldsEntered := true;
        PayLines.Reset;
        PayLines.SetRange(PayLines."Requistion No", Rec."No.");
        if PayLines.Find('-') then begin
            repeat
                if (PayLines."No." = '') or (PayLines."Quantity Requested" <= 0) then
                    AllKeyFieldsEntered := false;
            until PayLines.Next = 0;
            exit(AllKeyFieldsEntered);
        end;
    end;

    //[Scope('OnPrem')]
    procedure LinesCommitmentStatus() Exists: Boolean
    var
        BCsetup: Record "Budgetary Control Setup";
        PayLine: Record "Store Requistion Lines";
    begin
        if BCsetup.Get() then begin
            if not BCsetup.Mandatory then begin
                Exists := false;
                exit;
            end;
        end else begin
            Exists := false;
            exit;
        end;
        Exists := false;
        PayLine.Reset;
        PayLine.SetRange(PayLine."No.", Rec."No.");
        PayLine.SetRange(PayLine.Committed, false);
        if PayLine.Find('-') then
            Exists := true;
    end;

    [TryFunction]
    procedure SendEmails()
    var
        myInt: Integer;
        email: codeunit Email;
        userset: Record "User Setup";

        Filename: Text;
        usermail: Text;
        username: text;
        instr: InStream;
        emailbody: Label 'Dear <b>%1</b>, <br> <P>Your Store Requisition Request Has been Approved</P> <h>';
    begin
        userset.Reset();
        userset.SetRange("User ID", rec."User ID");
        if userset.FindFirst() then begin
            usermail := userset."E-Mail";
            username := userset."Full Name";

        end;
        EmailMsg.Create(usermail, 'Store Requisition', '', true);
        EmailMsg.AppendToBody(StrSubstNo(emailbody, username));
        // if UploadIntoStream('Select the file', '', 'This files|*.jpg;*.pdf;*.docx;*.png', Filename, instr) then
        //     EmailMsg.AddAttachment(Filename, '', instr)
        // else
        //     Message('There was an error in uploading %1', GetLastErrorText());
        if email.Send(EmailMsg) then
            Message('Email sent successfully')
        else
            Message('There was an error in sendingmail,%1', GetLastErrorText());
    end;

    var
        GLAcc: Record "G/L Account";
        Item: Record Item;
        FA: Record "Fixed Asset";
        CItem: Record "Item Charge";
        EmailMsg: Codeunit "Email Message";

        EmailRecipientList: List of [Text];
        AttachmentInstream: InStream;
        Application: Record "HR Job Applications";
        Email: Codeunit Email;
        StoreReq: record "Store Requistion Header";
        JournalPostingSucc: Codeunit "Journal Post Successful";

    local procedure UpdateControls()
    begin
        // if rec.Status <> rec.Status::Open then
        //     CurrPage.EDITABLE := false;


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
            Dimension := true;
            MKS := true;
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
            Dimension := False;
            MKS := False;
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
            Dimension := False;
            MKS := False;
        end;


    end;

    var
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
        InvTcode: Boolean;
        Inst: Boolean;
        DepType: Boolean;
        Dimension: Boolean;
        MKS: Boolean;
}

