page 52185835 "Investment Card"
{
    DeleteAllowed = true;
    PageType = Card;
    SourceTable = "Investment Header";
    SourceTableView = WHERE("Asset Type" = CONST("Money Market"));
    PromotedActionCategories = 'New,Process,Reports,Approvals';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Investment No"; Rec."Investment No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Transaction Date"; rec."Transaction Date")
                {
                    Caption = 'Posting Date';
                    ApplicationArea = Basic, Suite;
                }
                field("Investment Type Code"; Rec."Investment Type Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = InvTcode;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        SharesVisible := true;
                        if rec."Deposit Type" = rec."Deposit Type"::Shares then
                            SharesVisible := false;
                        // GetInvestType();
                    end;
                }
                field("Investment Type Description"; Rec."Investment Type Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Institution; Rec.Institution)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = Inst;
                    ShowMandatory = true;
                }
                field("Institution Name"; Rec."Institution Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Vendor Credit Limit(LCY)"; Rec."Vendor Credit Limit(LCY)")
                {
                    Caption = 'Investment Limit';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Available Amount"; Rec."Available Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Deposit Type"; Rec."Deposit Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = DepType;
                }

                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = RespCenter;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = Rmks;
                }
                group(Control25)
                {
                    ShowCaption = false;
                }
                field("Withholding Tax Code"; Rec."Withholding Tax Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = WtaxCode;
                    ShowMandatory = true;
                }
                field("Investment Date"; Rec."Investment Date")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Proposed Value Date';
                    Editable = INVdate;
                    ShowMandatory = true;
                }

                group(SharesNot)
                {
                    Caption = 'Period';
                    Visible = SharesVisible;
                    field("Period Type"; Rec."Period Type")
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = pType;
                        // Visible = InvestTypeVisib;
                    }
                    field("Frequency Period"; Rec."Frequency Period")
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = Freq;
                        // Visible = InvestTypeVisib;
                    }
                    field("Interest Rate"; Rec."Interest Rate")
                    {
                        ApplicationArea = Basic, Suite;
                        // Editable = true;
                        Editable = InvTcode;
                    }
                }
                field(Tenor; Rec.Tenor)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("No Of Days"; Rec."No Of Days")
                {
                    Editable = false;

                }
                field("Expected Payment Date"; Rec."Expected Payment Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Time Posted"; Rec."Time Posted")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Accrued Interest G/L Acc"; Rec."Accrued Interest G/L Acc")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Interest Income G/L Acc"; Rec."Interest Income G/L Acc")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
            part(Control4; "Money Market Subform")
            {
                Editable = Mmarketpage;
                SubPageLink = "Investment No" = FIELD("Investment No");
                ApplicationArea = Basic, Suite;

            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Print Requisition")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Requisition';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                Visible = false;

                trigger OnAction()
                begin
                    /*PV.RESET;
                    PV.SETRANGE(PV."Requisition No.","Request No.");
                    IF PV.FIND('-') THEN
                    //REPORT.Run(39005736,TRUE,TRUE,PV);
                    */

                end;
            }
        }
        area(processing)
        {
            action("Check Compliance")
            {
                ApplicationArea = Basic, Suite;
                Image = CalculateHierarchy;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    // ComplianceChecking();
                end;
            }
            action("Place Deal")
            {
                ApplicationArea = Basic, Suite;
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if (Rec.Status = Rec.Status::Approved) or (Rec.Status = Rec.Status::Fulfilled) then begin

                        PaymentsHeader.Reset;
                        PaymentsHeader.SetRange(PaymentsHeader."Creation Doc Type", PaymentsHeader."Creation Doc Type"::Investment);
                        PaymentsHeader.SetRange(PaymentsHeader."Creation Doc No.", Rec."Investment No");
                        if PaymentsHeader.Find('-') then begin

                            if PaymentsHeader.Posted = false then
                                PAGE.Run(Page::"Payment Header", PaymentsHeader)
                            else
                                PAGE.Run(Page::"Posted Payment Header", PaymentsHeader);
                        end else begin
                            Rec.CreatePaymentDoc;
                        end;
                    end else
                        Error(DocMustbeApprovedorFulfilled);
                end;
            }
            action("Partially Lifted")
            {
                ApplicationArea = Basic, Suite;
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    ReceiptHeader: Record "Receipts Header";

                begin
                    if (Rec.Status = Rec.Status::Fulfilled) then begin
                        if ReceiptHeader.Posted = false then
                            // PAGE.Run(Page::"Receipt Header", ReceiptHeader);
                        rec.Status := Rec.Status::"Partially Lifted";
                        rec.Modify();

                    end; //else
                         // Error('Payment for the Investment needed')


                end;
                // end;
            }

            action(Matured)
            {
                ApplicationArea = Basic, Suite;
                Image = Process;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    ReceiptHeader: Record "Receipts Header";

                begin
                    if (Rec.Status = Rec.Status::Fulfilled) OR (Rec.Status = Rec.Status::"Partially Lifted") then begin
                        if ReceiptHeader.Posted = false then
                            // PAGE.Run(Page::"Receipt Header", ReceiptHeader);
                        rec.Status := Rec.Status::Matured;
                        rec.Modify();

                    end; //else
                         // Error('Payment for the Investment needed')


                end;
                // end;
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        // ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        // // ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                    // // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //  ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    // RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin


                        Rec.TestField("Investment Type Code");
                        Rec.TestField(Institution);
                        Rec.TestField("Responsibility Center");
                        Rec.TestField("Withholding Tax Code");
                        Rec.TestField("Investment Date");

                        if Rec."Deposit Type" <> Rec."Deposit Type"::Shares then begin
                            Rec.TestField("Frequency Period");
                            Rec.TestField("Interest Rate");
                        end;

                        if Rec.Status <> Rec.Status::Open then
                            Error(DocMustbeOpen);

                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then begin
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                            if xrec.Status <> rec.Status then CurrPage.Close();
                        end;
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        if Rec.Status <> Rec.Status::"Pending Approval" then
                            Error(DocMustbePending);

                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                        if xrec.Status <> rec.Status then CurrPage.Close();
                    end;
                }
                action(ReOpen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re Open';
                    Promoted = true;
                    PromotedCategory = Category4;
                    Image = OpenWorksheet;

                    trigger OnAction()
                    var

                    begin
                        VarVariant := Rec;
                        if not confirm('Are you sure you want to reopen this document?') then exit;
                        Rec.Status := Rec.Status::Open;
                        rec.modify;
                        Message('The document have been opened successfully.');
                        if xrec.Status <> rec.Status then CurrPage.Close();
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var

                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action(Commentss)
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    Caption = 'Comment';
                    PromotedCategory = Category4;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("Investment No");
                    RunPageView = where(Types = CONST(comment));
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SharesVisible := true;
        if rec."Deposit Type" = rec."Deposit Type"::Shares then
            SharesVisible := false;
        // GetInvestType();
        UpdateControls;
    end;

    trigger OnInit()
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        if UserSetup.Get(UserId) then
            Rec."Responsibility Center" := UserSetup."Responsibility Centre";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Asset Type" := Rec."Asset Type"::"Money Market";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Asset Type" := Rec."Asset Type"::"Money Market";
        InvestmentsList.reset;
        InvestmentsList.setrange("Asset Type", InvestmentsList."Asset Type"::"Money Market");
        InvestmentsList.setrange("Status", InvestmentsList.Status::Open);
        if InvestmentsList.FindFirst() then begin
            If InvestmentsList.Count > 2 then Error('You can only have 2 Open Investments at a time Please the current open %1 to prevent wastage', InvestmentsList."Investment No");
        end;

    end;

    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        ResponsibilityCenter: Record "Responsibility Center";
        UserSetup: Record "User Setup";
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        DocMustbeOpen: Label 'This application request must be open';
        DocMustbePending: Label 'This application request must be Pending';
        InvTcode: Boolean;
        Inst: Boolean;
        DepType: Boolean;
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
        SharesVisible: Boolean;
        DocMustbeApprovedorFulfilled: Label 'This application request must be approved';
        PaymentsHeader: Record "Payments Header";

        InvestmentsList: record "Investment Header";
    // InvestTypeVisib: Boolean;

    // procedure GetInvestType()
    // var
    //     InvestType: Record "Investment Type";
    // begin
    //     InvestType.RESET;
    //     if InvestType.Get(Rec."Investment Type Code") then begin
    //         if InvestType."Deposit Type" = InvestType."Deposit Type"::Shares
    //         then
    //             InvestTypeVisib := false
    //         else
    //             InvestTypeVisib := true;
    //     end;
    // end;

    local procedure UpdateControls()
    begin

        if Rec.Status = Rec.Status::Open then begin
            InvTcode := true;
            Inst := true;
            DepType := false;
            IntMode := false;
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


        if Rec.Status = Rec.Status::Rejected then begin
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

        if Rec.Status = Rec.Status::Approved then begin
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

        if Rec.Status = Rec.Status::Fulfilled then begin
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
}

