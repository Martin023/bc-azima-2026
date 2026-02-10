page 52185917 "Bank & Cash Transfer Request"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approvals,Cancel,Category6_caption,Category7_caption,Category8_caption,Approvals,Category10_caption,EDMS';
    SourceTable = "InterBank Transfers";



    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; Rec.No)
                {
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = Basic, Suite;
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Source Depot Code"; Rec."Source Depot Code")
                {

                    ApplicationArea = Basic, Suite;
                    Editable = DateEditable;
                }
                field("Source Department Code"; Rec."Source Department Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = DateEditable;
                    ShowMandatory = true;
                }
                field("Transfer Type"; Rec."Transfer Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = DateEditable;
                    trigger OnValidate()
                    begin
                        if rec."Transfer Type" = rec."Transfer Type"::"Treasury Requisition" then
                            TreasuryReq := true;
                    end;
                }
                field("Paying Account"; Rec."Paying Account")
                {
                    Caption = 'Source Account';
                    Editable = DateEditable;
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    trigger OnValidate()
                    var
                        Bnk: Record "Bank Account";
                    begin
                        PayingAccountOnAfterValidate;
                        if Bnk.Get(rec."Paying Account") then begin
                            Rec."Paying  Bank Account Name" := Bnk.Name;
                        end;
                    end;
                }
                field("Paying  Bank Account Name"; Rec."Paying  Bank Account Name")
                {
                    Caption = 'Source Bank Account Name';
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Source Amount';
                    Editable = DateEditable;
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field(Remarks; Rec.Remarks)
                {
                    Editable = RemarksEditable;
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Receiving Account"; Rec."Receiving Account")
                {
                    Caption = 'Destination Account';
                    Editable = DateEditable;
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    trigger OnValidate()
                    var
                        Bnk: Record "Bank Account";
                    begin

                        if Bnk.Get(rec."Receiving Account") then begin
                            Rec."Receiving Bank Account Name" := Bnk.Name;
                        end;

                        Bnk.Reset();
                        Bnk.SetRange(Bnk."No.", rec."Receiving Account");
                        if Bnk.FindFirst() then
                            if rec."Receiving Account" = rec."Paying Account" then
                                Error('The Receiving account cannot be the same as Paying account.');

                    end;
                }
                field("Receiving Bank Account Name"; Rec."Receiving Bank Account Name")
                {
                    Caption = 'Destination Bank Account Name';
                    Editable = false;
                    ApplicationArea = Basic, Suite;

                }
                field("Amount 2"; Rec."Amount 2")
                {
                    Caption = 'Destination Amount';
                    Editable = "Amount 2Editable";
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        Bnk: Record "Bank Account";
                        DestAmt: Decimal;
                    begin
                        DestAmt := 0;

                        if Bnk.Get(rec."Receiving Account") then begin
                            if (Bnk."Bank Type" = Bnk."Bank Type"::Cash) or (Bnk."Bank Type" = Bnk."Bank Type"::Treasury) then begin
                                Bnk.CalcFields("Balance (LCY)");
                                DestAmt := (rec."Amount 2") + (Bnk."Balance (LCY)");
                                if DestAmt > Bnk."Max. Witholding Balance" then
                                    Error('This amount will exceed the Maximum Witholding Balance of this Bank Account.');
                            end;
                        end;


                        if Bnk.Get(rec."Receiving Account") then begin
                            if not (Bnk."Bank Type" = Bnk."Bank Type"::Cash) or not (Bnk."Bank Type" = Bnk."Bank Type"::Treasury) then begin
                                Bnk.CalcFields("Balance (LCY)");
                                DestAmt := (rec."Amount 2") + (Bnk."Balance (LCY)");
                                if DestAmt > Bnk."Max. Witholding Balance" then
                                    Message('This amount will exceed the Maximum Witholding Balance of this Bank Account.');

                                if rec."Amount 2" <> rec.Amount then
                                    Message('Destination Amount must be the same as Source Amount.');
                            end;

                            if rec."Amount 2" <> rec.Amount then
                                Error('Destination Amount must be the same as Source Amount.');
                        end;

                    end;

                }
                field("Transfer Release Date"; Rec."Transfer Release Date")
                {
                    Editable = ChqVisible;
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    Editable = ChqVisible;
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Posted By"; Rec."Posted By")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }

                group(Treasury)
                {
                    Caption = 'Treasury Control';
                    Visible = TreasuryReq;
                    field(Payee; Rec.Payee)
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;

                    }
                    field("Treasury Cheque No"; Rec."Treasury Cheque No")
                    {
                        ApplicationArea = Basic;

                    }
                    field("Cheque Amount"; Rec."Cheque Amount")
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;

                    }
                }


            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action(Print)
                {
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ApplicationArea = Basic, Suite;
                    trigger OnAction()
                    begin

                        Rec.Reset;
                        Rec.SetRange(No, Rec.No);
                        Rec.Validate("Created By");
                        REPORT.Run(Report::"Interbank Details", true, true, Rec);
                        Rec.Reset;
                    end;
                }
                action("Cheque Print")
                {
                    Caption = 'Cheque Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    ApplicationArea = Basic, Suite;
                    trigger OnAction()
                    begin

                        Rec.Reset;
                        Rec.SetRange(No, Rec.No);
                        Rec.Validate("Created By");
                        REPORT.Run(Report::"Inter Bank Cheque", true, true, Rec);
                        Rec.Reset;
                    end;
                }
                action("Cancel Document")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Document';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        Text000: Label 'Are you sure you want to Cancel this Document?';
                        Text001: Label 'You have selected not to Cancel this Document';
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);
                        if Confirm(Text000, true) then begin
                            Rec.Status := Rec.Status::Cancelled;
                            Rec."Cancelled By" := UserId;
                            Rec."Date Cancelled" := Today;
                            Rec."Time Cancelled" := Time;
                            Rec.Modify;
                        end else
                            Error(Text001);
                    end;
                }

                action(Refresh)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Refresh;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()

                    begin
                        CurrPage.Update;
                    end;
                }
            }
            action("&Post")
            {
                Caption = '&Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;

                trigger OnAction()
                var
                    InterBa: Record "InterBank Transfers";
                    TrChqReg: Record "Treasury Cheques Register";
                begin
                    // ChqVisible := false;
                    // if Rec.Posted = false then
                    //     ChqVisible := false
                    // else
                    //     ChqVisible := true;

                    //rec.TestField("Cheque No");

                    if rec.Posted = true then
                        Error('The transfer has already been posted.');

                    TempBatch.Reset;
                    TempBatch.SetRange(TempBatch.UserID, UserId);
                    if TempBatch.Find('-') then begin
                        Rec."Inter Bank Template Name" := TempBatch."Inter Bank Template Name";
                        Rec."Inter Bank Journal Batch" := TempBatch."Inter Bank Batch Name";
                    end;
                    if (rec."Inter Bank Template Name" = '') or (rec."Inter Bank Journal Batch" = '') then
                        Error('Please set the Inter Bank Template Name and Inter Bank Journal Batch in the Cash Office User Template');

                    Rec.TestField(Status, Rec.Status::Approved);
                    Rec.TestField("Transfer Release Date");

                    BankAcc.Reset;
                    BankAcc.SetRange(BankAcc."No.", Rec."Paying Account");
                    BankAcc.SetRange(BankAcc."Bank Type", BankAcc."Bank Type"::Cash);
                    if BankAcc.FindFirst then begin
                        BankAcc.CalcFields(BankAcc.Balance);
                        Rec."Current Source A/C Bal." := BankAcc.Balance;
                        if (Rec."Current Source A/C Bal." - Rec.Amount) < 0 then begin
                            Error('The transaction will result in a negative balance in a CASH ACCOUNT.');
                        end;
                    end;
                    if Rec.Amount = 0 then begin
                        Error('Please ensure Amount to Transfer is entered');
                    end;
                    /*Check if the user's batch has any records within it*/
                    GenJnlLine.Reset;
                    GenJnlLine.SetRange(GenJnlLine."Journal Template Name", Rec."Inter Bank Template Name");
                    GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", Rec."Inter Bank Journal Batch");
                    GenJnlLine.DeleteAll;

                    LineNo := 1000;
                    /*Insert the new lines to be updated*/
                    GenJnlLine.Init;
                    /*Insert the lines*/
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                    GenJnlLine."Journal Template Name" := Rec."Inter Bank Template Name";
                    GenJnlLine."Journal Batch Name" := Rec."Inter Bank Journal Batch";
                    GenJnlLine."Posting Date" := Rec."Transfer Release Date";
                    GenJnlLine."Document No." := Rec.No;
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
                    GenJnlLine."Account No." := Rec."Receiving Account";
                    GenJnlLine.Description := rec.Remarks;
                    GenJnlLine."External Document No." := Rec."Cheque No";
                    GenJnlLine.Amount := Rec."Amount 2";
                    GenJnlLine.Validate(GenJnlLine.Amount);
                    GenJnlLine.Insert;


                    GenJnlLine.Init;
                    /*Insert the lines*/
                    GenJnlLine."Line No." := LineNo + 1;
                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                    GenJnlLine."Journal Template Name" := Rec."Inter Bank Template Name";
                    GenJnlLine."Journal Batch Name" := Rec."Inter Bank Journal Batch";
                    GenJnlLine."Posting Date" := Rec."Transfer Release Date";
                    GenJnlLine."Document No." := Rec.No;
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
                    GenJnlLine."Account No." := Rec."Paying Account";
                    GenJnlLine."External Document No." := Rec."Cheque No";
                    GenJnlLine.Description := Rec.Remarks;
                    GenJnlLine.Amount := -Rec.Amount;
                    GenJnlLine.Validate(GenJnlLine.Amount);
                    GenJnlLine.Insert;

                    // Post := false;
                    Commit;

                    GenJnlLine.Reset;
                    GenJnlLine.SetRange("Journal Template Name", TempBatch."Inter Bank Template Name");
                    GenJnlLine.SetRange("Journal Batch Name", TempBatch."Inter Bank Batch Name");
                    if GenJnlLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJnlLine);
                    end;
                    // Post := JournalPostedSuccessfully.PostedSuccessfully();
                    if Rec.Amount > 0 then begin
                        InterBa.Reset();
                        InterBa.SetRange(No, Rec.No);
                        if InterBa.FindFirst() then begin
                            InterBa.Posted := true;
                            InterBa."Date Posted" := Today;
                            InterBa."Time Posted" := Time;
                            InterBa."Posted By" := UserId;
                            InterBa.Modify;

                        end;

                        TRegister.Reset;
                        TRegister.SetRange(TRegister."Cheque No.", Rec."Treasury Cheque No");
                        TRegister.SetRange(Status, TRegister.Status::Pending);
                        if TRegister.Find('-') then begin
                            TRegister.Status := TRegister.Status::Approved;
                            TRegister.Payee := Rec.Payee;
                            TRegister.Amount := Rec."Cheque Amount";
                            TRegister."Treasury Control" := Rec."Receiving Account";
                            TRegister.Modify;
                        end;
                    end;
                    Message('The Journal Has Been Posted Successfully');
                    // end;

                end;
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
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                        CustomApprovalsCodeunit: Codeunit "Custom Approvals Codeunit";
                    begin

                        Rec.TestField("Receiving Account");
                        // Rec.TestField("Cheque No");
                        Rec.TestField(Remarks);

                        VarVariant := Rec;
                        if CustomApprovalsCodeunit.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovalsCodeunit.OnSendDocForApproval(VarVariant);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;
                    ApplicationArea = Basic, Suite;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                        CustomApprovalsCodeunit: Codeunit "Custom Approvals Codeunit";
                    begin
                        VarVariant := Rec;
                        CustomApprovalsCodeunit.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(ReOpen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Re Open';
                    Promoted = true;
                    PromotedCategory = category9;
                    Image = OpenWorksheet;

                    trigger OnAction()
                    var

                    begin
                        VarVariant := Rec;
                        //Rec.TestField(Status, Rec.Status::Approved);
                        //if rec.stst
                        if not confirm('Are you sure you want to reopen this document?') then exit;
                        Rec.Status := Rec.Status::Pending;
                        rec.modify;
                        Message('The document have been opened successfully.');
                    end;
                }
                action(Commentss)
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    Caption = 'Comment';
                    PromotedCategory = Category9;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field(No);
                    RunPageView = where(Types = CONST(comment));
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
                        //ApprovalEntries: Page "Approval Entries";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
            }

            // group("EDMS Integration")
            // {
            //     action("Import")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Import File';
            //         Promoted = true;
            //         PromotedCategory = Category11;
            //         Image = Import;

            //         trigger OnAction()
            //         var
            //             Base64Convert: Codeunit "Base64 Convert";
            //             TempBlob: Codeunit "Temp Blob";
            //             InStr: InStream;

            //             EDMSFunctions: Codeunit "EDMS Functions";
            //             FileName: Text;
            //             FileContentsB64: Text;

            //             IDNumber: Text;
            //             ApplicationType: Label 'MA'; // Member Application
            //             PFNumber: Text;
            //         begin
            //             if Rec."No" <> '' then begin
            //                 FileName := EDMSFunctions.PickEDMSFile(TempBlob);

            //                 TempBlob.CreateInStream(InStr);
            //                 FileContentsB64 := Base64Convert.ToBase64(InStr);

            //                 if FileContentsB64 <> '' then begin
            //                     // UploadToEDMS(Rec, FileName, FileContentsB64);
            //                 end;
            //             end else begin
            //                 Error('Application No. is required for EDMS document upload');
            //             end;
            //         end;
            //     }
            //     action("EDMS File List")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Image = Documents;
            //         Promoted = true;
            //         PromotedCategory = Category11;

            //         RunObject = page "EDMS Files List";
            //         RunPageLink = "Application No." = field("No");
            //         // RunPageMode = Create;
            //     }
            // }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin

        if Rec."Currency Code Source" <> '' then begin

            "Exch. Rate SourceVisible" := true;
        end
        else begin
            "Exch. Rate SourceVisible" := false;
        end;

        if Rec."Currency Code Destination" <> '' then begin
            "Exch. Rate DestinationVisible" := true;
        end
        else begin
            "Exch. Rate DestinationVisible" := false;
        end;

        UpdateControl;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;

    trigger OnInit()
    begin
        "Transfer Release DateEditable" := true;
        "External Doc No.Editable" := true;
        "Exch. Rate SourceEditable" := true;
        AmountEditable := true;
        "Paying AccountEditable" := true;
        SendingResponsibilityCenterEdi := true;
        "Source Transfer TypeEditable" := true;
        "Exch. Rate DestinationEditable" := true;
        RemarksEditable := true;
        "Amount 2Editable" := true;
        "Receiving AccountEditable" := true;
        RecieptResponsibilityCenterEdi := true;
        ReceivingTransferTypeEditable := true;
        DateEditable := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Date := Today;
        Rec."Inter Bank Template Name" := JTemplate;
        Rec."Inter Bank Journal Batch" := JBatch;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Reciept Responsibility Center" := UserMgt.GetPurchasesFilter();
        //VALIDATE( "Reciept Responsibility Center");
        Rec.Status := Rec.Status::Pending;
        Rec."Created By" := UserId;

        UpdateControl;
    end;

    trigger OnOpenPage()
    begin
        if UserMgt.GetPurchasesFilter() <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Reciept Responsibility Center", UserMgt.GetPurchasesFilter());
            Rec.FilterGroup(0);
        end;


        TempBatch.Reset;

        TempBatch.SetRange(TempBatch.UserID, UserId);
        if TempBatch.Find('-') then begin
            JTemplate := TempBatch."Inter Bank Template Name";
            JBatch := TempBatch."Inter Bank Batch Name";
        end;
    end;

    var
        GenJnlLine: Record "Gen. Journal Line";
        LineNo: Integer;
        TempBatch: Record "Cash Office User Template";
        JTemplate: Code[20];
        JBatch: Code[20];
        PCheck: Codeunit "Posting Check FP";
        Post: Boolean;
        BankAcc: Record "Bank Account";
        RegNo: Integer;
        FromNo: Integer;
        ToNo: Integer;
        RegMgt: Codeunit "Register Management";
        JournalPostedSuccessfully: Codeunit "Journal Post Successful";
        RespCenter: Record "Responsibility CenterBR";
        UserMgt: Codeunit "User Setup Management BR";

        "Exch. Rate DestinationVisible": Boolean;

        "Exch. Rate SourceVisible": Boolean;

        DateEditable: Boolean;

        ReceivingTransferTypeEditable: Boolean;

        RecieptResponsibilityCenterEdi: Boolean;

        "Receiving AccountEditable": Boolean;

        "Amount 2Editable": Boolean;

        RemarksEditable: Boolean;

        "Exch. Rate DestinationEditable": Boolean;

        "Source Transfer TypeEditable": Boolean;

        SendingResponsibilityCenterEdi: Boolean;

        "Paying AccountEditable": Boolean;

        AmountEditable: Boolean;

        "Exch. Rate SourceEditable": Boolean;

        "External Doc No.Editable": Boolean;

        "Transfer Release DateEditable": Boolean;
        Text19025618: Label 'Requesting Details';
        Text19044997: Label 'Source Details';
        //// //ApprovalEntries: Page "Approval Entries";
        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        TreasuryReq: Boolean;
        TRegister: Record "Treasury Cheques Register";
        ChqVisible: Boolean;

    //[Scope('OnPrem')]
    procedure GetDimensionName(var "Code": Code[20]; DimNo: Integer) Name: Text[60]
    var
        GLSetup: Record "General Ledger Setup";
        DimVal: Record "Dimension Value";
        Text000: Label 'Are you sure you want to Cancel this Document?';
        Text001: Label 'You have selected not to Cancel this Document';
    begin
        /*Get the global dimension 1 and 2 from the database*/
        Name := '';

        GLSetup.Reset;
        GLSetup.Get();

        DimVal.Reset;
        DimVal.SetRange(DimVal.Code, Code);

        if DimNo = 1 then begin
            DimVal.SetRange(DimVal."Dimension Code", GLSetup."Global Dimension 1 Code");
        end
        else
            if DimNo = 2 then begin
                DimVal.SetRange(DimVal."Dimension Code", GLSetup."Global Dimension 2 Code");
            end;
        if DimVal.Find('-') then begin
            Name := DimVal.Name;
        end;

    end;

    //[Scope('OnPrem')]
    procedure UpdateControl()
    begin


        if Rec.Status = Rec.Status::Approved then
            ChqVisible := true
        else
            ChqVisible := false;

        if Rec.Status <> Rec.Status::Pending then begin
            DateEditable := false;
            ReceivingTransferTypeEditable := false;
            RecieptResponsibilityCenterEdi := false;
            "Receiving AccountEditable" := false;
            "Amount 2Editable" := false;
            RemarksEditable := false;
            "Exch. Rate DestinationEditable" := false;


        end else begin
            DateEditable := true;
            ReceivingTransferTypeEditable := true;
            RecieptResponsibilityCenterEdi := true;
            "Receiving AccountEditable" := true;
            "Amount 2Editable" := true;
            RemarksEditable := true;
            "Exch. Rate DestinationEditable" := true;


        end;

        if Rec.Status = Rec.Status::Approved then begin
            "Source Transfer TypeEditable" := true;
            SendingResponsibilityCenterEdi := true;
            "Paying AccountEditable" := true;
            AmountEditable := true;
            "Paying AccountEditable" := true;
            "Exch. Rate SourceEditable" := true;
            "External Doc No.Editable" := true;
            "Transfer Release DateEditable" := true;
        end else begin
            "Source Transfer TypeEditable" := false;
            SendingResponsibilityCenterEdi := false;
            AmountEditable := false;
            "Paying AccountEditable" := false;
            "Exch. Rate SourceEditable" := false;
            "External Doc No.Editable" := false;
            "Transfer Release DateEditable" := false;
        end;
    end;

    local procedure ReceivingAccountOnAfterValidat()
    begin
        //check if the currency code field has been filled in
        "Exch. Rate DestinationVisible" := false;
        if Rec."Currency Code Destination" <> '' then begin
            "Exch. Rate DestinationVisible" := true;
        end;
    end;

    local procedure PayingAccountOnAfterValidate()
    begin
        //check if the currency code field has been filled in
        "Exch. Rate SourceVisible" := false;
        if Rec."Currency Code Source" <> '' then begin
            "Exch. Rate SourceVisible" := true;
        end;
    end;

    local procedure SetControlAppearance()
    var
    // ApprovalsMgmt: Codeunit 1535;
    begin
        // OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        // OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;
}

