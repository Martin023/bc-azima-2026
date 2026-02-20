#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187230 pageextension52187230 extends "Sales Invoice"
{
    layout
    {

        addafter("External Document No.")
        {
            field("KRA PIN"; Rec."KRA PIN")
            {
            }

        }
        addafter(Status)
        {
            field(Leases; Rec.Leases)
            {
            }

            field("Invoice Start Date"; Rec."Invoice Start Date")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Invoice Start Date';
                Visible = true;
            }
            field("Frequency Period"; Rec."Frequency Period")
            {

            }

            field("Period Type"; Rec."Period Type")
            {

            }

            field(Tenor; Rec.Tenor)
            {

            }
            field("Invoice End Date"; Rec."Invoice End Date")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Invoice End Date';
                Visible = true;
                //Editable
            }

            field(Invoiced; Rec.Invoiced)
            {
                // Editable=false;
                Visible = false;

            }

        }
        modify("Sell-to Customer No.")
        {
            ApplicationArea = Basic;
            trigger OnAfterValidate()
            begin
                Customer.Reset();
                Customer.SetRange(Customer."No.", Rec."Sell-to Customer No.");
                if Customer.FindFirst() then begin
                    LoaneeInfomationBase.Reset();
                    LoaneeInfomationBase.SetRange("Member No.", Customer."No.");
                    LoaneeInfomationBase.SetFilter(Info, '<>%1', '');
                    if LoaneeInfomationBase.Find('-') then begin
                        repeat
                            if (LoaneeInfomationBase."Expiry Date" = 0D) or (LoaneeInfomationBase."Expiry Date" > Today) then
                                Message(LoaneeInfomationBase.Info);
                        until LoaneeInfomationBase.Next = 0;
                    end;

                end;
            end;
        }
        modify("Posting Description")
        {
            ApplicationArea = Basic;
            Visible = true;
        }

    }
    actions
    {
        modify(Post)
        {
            ApplicationArea = Basic;
            Visible = false;

        }

        addafter(Preview)
        {
            action(PostInvoice)
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
                Caption = 'P&ost Invoice';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Process;
                ShortCutKey = 'F9';
                AboutTitle = 'When all is set, you post';
                AboutText = 'After entering the sales lines and other information, you post the invoice to make it count.? After posting, the sales invoice is moved to the Posted Sales Invoices list.';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                trigger OnAction()
                var
                    msg: Text;
                    Customer: Record Customer;
                    Lease: Record Lease;
                    SalesInvoice: Record "Sales Header";
                    SalesLines: Record "Sales Line";
                    SendSMS: Codeunit SendSms;
                    Source: enum "SMS Source";
                begin
                    Customer.get(rec."Sell-to Customer No.");
                    SalesInvoice.Reset();
                    SalesInvoice.SetRange("Document Type", rec."Document Type");
                    SalesInvoice.SetRange("No.", rec."No.");
                    if SalesInvoice.Find('-') then begin
                        //Message('Coded');
                        // SalesInvoice.Invoiced := true;
                        SalesInvoice.TestField(Status, SalesInvoice.Status::Released);
                        // Message(Customer."Phone No.");
                        // Message(Customer."No.");
                        msg := 'Dear ' + Customer.Name + ', Your Invoice for the month of this month' + ' is ' + Format(Rec."Amount Including VAT") + Lease."No." + Lease."Property Name" + ' is in debt';
                        //PostDocument(CODEUNIT::"Sales-Post (Yes/No)", Enum::"Navigate After Posting"::"Posted Document");

                        SendSMS.SendSms(Source::Tenants, Customer."Phone No.", msg, Format(Customer."No."), '', true, 0, false, 'CBS', Format(Customer."No."), 'CBS');

                        PostDocument(CODEUNIT::"Sales-Post (Yes/No)", Enum::"Navigate After Posting"::"Posted Document");

                    end;
                end;
            }
        }

    }

    var
        LoaneeInfomationBase: Record "Loanee Infomation Base";
        Customer: Record Customer;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."Assigned User ID" := UserID;
    end;

    trigger OnOpenPage()
    var
        DisposalLines: record "Disposal Lines";
        DisposalHeader: record "Stock Keeping";
        SalesLines: record "Sales Line";
        LineNo: integer;
    begin
        DisposalHeader.reset;
        DisposalHeader.SetRange(No, rec."Your Reference");
        DisposalHeader.SetRange(Types, DisposalHeader.types::Disposal);
        IF DisposalHeader.findfirst() then begin
            DisposalLines.reset;
            DisposalLines.setrange("Header No", DisposalHeader.No);
            if DisposalLines.find('-') then begin

                LineNo := LineNo + 1;
                repeat
                    SalesLines.init;
                    SalesLines."Line No." := LineNo;
                    SalesLines."Document Type" := SalesLines."Document Type"::Invoice;
                    SalesLines."Document No." := rec."No.";
                    SalesLines.Type := SalesLines.Type::Item;
                    SalesLines."No." := DisposalLines."Item No";
                    SalesLines.Description := DisposalLines."Item Name";
                    SalesLines.Quantity := DisposalLines."Physical Count";
                    SalesLines."Disposal Reason" := DisposalLines."Disposal Reason";
                    SalesLines."Disposal Expiry" := DisposalLines.Expiry;
                    SalesLines.insert(true);
                until DisposalLines.next = 0;
            end;
        end;

    end;

    local procedure PostDocument(PostingCodeunitID: Integer; Navigate: Enum "Navigate After Posting")
    var
        SalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        OfficeMgt: Codeunit "Office Management";
        InstructionMgt: Codeunit "Instruction Mgt.";
        PreAssignedNo: Code[20];
        xLastPostingNo: Code[20];
        IsScheduledPosting: Boolean;
        IsHandled: Boolean;
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        DocumentIsPosted: Boolean;
        OpenPostedSalesInvQst: Label 'The invoice is posted as number %1 and moved to the Posted Sales Invoices window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';
    begin
        LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);
        PreAssignedNo := Rec."No.";
        xLastPostingNo := Rec."Last Posting No.";

        Rec.SendToPosting(PostingCodeunitID);

        IsScheduledPosting := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        DocumentIsPosted := (not SalesHeader.Get(Rec."Document Type", Rec."No.")) or IsScheduledPosting;
        OnPostOnAfterSetDocumentIsPosted(SalesHeader, IsScheduledPosting, DocumentIsPosted);

        if IsScheduledPosting then
            CurrPage.Close();
        CurrPage.Update(false);

        IsHandled := false;
        OnPostDocumentBeforeNavigateAfterPosting(Rec, PostingCodeunitID, Navigate, DocumentIsPosted, IsHandled);
        if IsHandled then
            exit;

        if PostingCodeunitID <> CODEUNIT::"Sales-Post (Yes/No)" then
            exit;

        if OfficeMgt.IsAvailable() then begin
            if (Rec."Last Posting No." <> '') and (Rec."Last Posting No." <> xLastPostingNo) then
                SalesInvoiceHeader.SetRange("No.", Rec."Last Posting No.")
            else begin
                SalesInvoiceHeader.SetCurrentKey("Pre-Assigned No.");
                SalesInvoiceHeader.SetRange("Pre-Assigned No.", PreAssignedNo);
            end;
            if SalesInvoiceHeader.FindFirst() then
                PAGE.Run(PAGE::"Posted Sales Invoice", SalesInvoiceHeader);
        end else
            case Navigate of
                Enum::"Navigate After Posting"::"Posted Document":
                    if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode()) then
                        ShowPostedConfirmationMessage(PreAssignedNo, xLastPostingNo);
                Enum::"Navigate After Posting"::"New Document":
                    if DocumentIsPosted then begin
                        SalesHeader.Init();
                        SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Invoice);
                        OnPostOnBeforeSalesHeaderInsert(SalesHeader);
                        SalesHeader.Insert(true);
                        PAGE.Run(PAGE::"Sales Invoice", SalesHeader);
                    end;
            end;
    end;

    // [IntegrationEvent(false, false)]   ← removed attribute only (to fix AL0819)
    local procedure OnPostOnAfterSetDocumentIsPosted(SalesHeader: Record "Sales Header"; var IsScheduledPosting: Boolean; var DocumentIsPosted: Boolean)
    begin
    end;

    // [IntegrationEvent(true, false)]   ← removed attribute only (to fix AL0819)
    local procedure OnPostDocumentBeforeNavigateAfterPosting(var SalesHeader: Record "Sales Header"; var PostingCodeunitID: Integer; var Navigate: Enum "Navigate After Posting"; DocumentIsPosted: Boolean; var IsHandled: Boolean)
    begin
    end;

    procedure ShowPostedConfirmationMessageCode(): Code[50]
    begin
        exit('SHOWPOSTEDCONFIRMATIONMESSAGE');
    end;

    local procedure ShowPostedConfirmationMessage(PreAssignedNo: Code[20]; xLastPostingNo: Code[20])
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
        ICFeedback: Codeunit "IC Feedback";
        OpenPostedSalesInvQst: Label 'The invoice is posted as number %1 and moved to the Posted Sales Invoices window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';
    begin
        if (Rec."Last Posting No." <> '') and (Rec."Last Posting No." <> xLastPostingNo) then
            SalesInvoiceHeader.SetRange("No.", Rec."Last Posting No.")
        else begin
            SalesInvoiceHeader.SetCurrentKey("Pre-Assigned No.");
            SalesInvoiceHeader.SetRange("Pre-Assigned No.", PreAssignedNo);
        end;
        if SalesInvoiceHeader.FindFirst() then begin
            ShowIntercompanyMessage(Rec, Enum::"IC Transaction Document Type"::Invoice, SalesInvoiceHeader."No.");
            if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedSalesInvQst, SalesInvoiceHeader."No."),
                 InstructionMgt.ShowPostedConfirmationMessageCode())
            then
                InstructionMgt.ShowPostedDocument(SalesInvoiceHeader, Page::"Sales Invoice");
        end;
    end;

    // [IntegrationEvent(false, false)]   ← removed attribute only (to fix AL0819)
    local procedure OnPostOnBeforeSalesHeaderInsert(var SalesHeader: Record "Sales Header")
    begin
    end;

    internal procedure ShowIntercompanyMessage(SalesHeader: Record "Sales Header"; ICTransactionDocumentType: Enum "IC Transaction Document Type"; DocumentNo: Code[20])
    var
        ICSetup: Record "IC Setup";
        ICOutboxTransaction: Record "IC Outbox Transaction";
        ICPartnerCode: Code[20];
        CreatedTransactionWaitingInOutboxMsg: Label 'An entry for document %1 has been created as an intercompany transaction. The entry awaits a manual check in the Intercompany Outbox before being sent.', Comment = '%1 = Document No.';
        CreatedAndSentTransactionMsg: Label 'An entry for document %1 has been created as an intercompany transaction. The entry was automatically sent to IC partner %2.', Comment = '%1 = Document No., %2 = IC Partner No.';
    begin
        if GuiAllowed() then begin
            if SalesHeader."Sell-to IC Partner Code" <> '' then
                ICPartnerCode := SalesHeader."Sell-to IC Partner Code"
            else
                ICPartnerCode := SalesHeader."Bill-to IC Partner Code";
            if ICPartnerCode = '' then
                exit;
            if (not ICSetup.FindFirst()) or (not ICSetup."Transaction Notifications") then
                exit;

            if ICSetup."Auto. Send Transactions" then begin
                if ExistsInICHandledOutbox(ICPartnerCode, ICOutboxTransaction."Source Type"::"Sales Document", ICTransactionDocumentType, DocumentNo, SalesHeader."Posting Date", SalesHeader."Document Date") then
                    Message(CreatedAndSentTransactionMsg, DocumentNo, ICPartnerCode);
            end
            else
                if ExistsInICOutbox(ICPartnerCode, ICOutboxTransaction."Source Type"::"Sales Document", ICTransactionDocumentType, DocumentNo, SalesHeader."Posting Date", SalesHeader."Document Date") then
                    Message(CreatedTransactionWaitingInOutboxMsg, DocumentNo);
        end;
    end;

    local procedure ExistsInICHandledOutbox(ICPartnerCode: Code[20]; SourceType: Option; ICTransactionDocumentType: Enum "IC Transaction Document Type"; DocumentNo: Code[20]; PostingDate: Date; DocumentDate: Date): Boolean
    var
        HandledICOutboxTransaction: Record "Handled IC Outbox Trans.";
    begin
        HandledICOutboxTransaction.SetRange("IC Partner Code", ICPartnerCode);
        HandledICOutboxTransaction.SetRange("Source Type", SourceType);
        HandledICOutboxTransaction.SetRange("Document Type", ICTransactionDocumentType);
        HandledICOutboxTransaction.SetRange("Document No.", DocumentNo);
        HandledICOutboxTransaction.SetRange("Posting Date", PostingDate);
        HandledICOutboxTransaction.SetRange("Document Date", DocumentDate);
        exit(not HandledICOutboxTransaction.IsEmpty());
    end;

    local procedure ExistsInICOutbox(ICPartnerCode: Code[20]; SourceType: Option; ICTransactionDocumentType: Enum "IC Transaction Document Type"; DocumentNo: Code[20]; PostingDate: Date; DocumentDate: Date): Boolean
    var
        ICOutboxTransaction: Record "IC Outbox Transaction";
    begin
        ICOutboxTransaction.SetRange("IC Partner Code", ICPartnerCode);
        ICOutboxTransaction.SetRange("Source Type", SourceType);
        ICOutboxTransaction.SetRange("Document Type", ICTransactionDocumentType);
        ICOutboxTransaction.SetRange("Document No.", DocumentNo);
        ICOutboxTransaction.SetRange("Posting Date", PostingDate);
        ICOutboxTransaction.SetRange("Document Date", DocumentDate);
        exit(not ICOutboxTransaction.IsEmpty());
    end;
    //     // modify("Reservation Entries")
    //     // {
    //     //     ApplicationArea = Basic;
    //     // }
    //     // modify("Item &Tracking Lines")
    //     // {
    //     //     ApplicationArea = Basic;
    //     // }

    //     //Unsupported feature: Property Deletion (ToolTipML) on ""Show Document"(Action 23)".


    //     //Unsupported feature: Property Deletion (ToolTipML) on ""Reservation Entries"(Action 32)".


    //     //Unsupported feature: Property Deletion (ToolTipML) on ""Item &Tracking Lines"(Action 6500)".

    // }
    // local procedure PostDocument(PostingCodeunitID: Integer; Navigate: Enum "Navigate After Posting")
    // var
    //     SalesHeader: Record "Sales Header";
    //     SalesInvoiceHeader: Record "Sales Invoice Header";
    //     OfficeMgt: Codeunit "Office Management";
    //     InstructionMgt: Codeunit "Instruction Mgt.";
    //     PreAssignedNo: Code[20];
    //     xLastPostingNo: Code[20];
    //     IsScheduledPosting: Boolean;
    //     IsHandled: Boolean;
    // begin
    //     LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);
    //     PreAssignedNo := Rec."No.";
    //     xLastPostingNo := Rec."Last Posting No.";

    //     Rec.SendToPosting(PostingCodeunitID);

    //     IsScheduledPosting := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
    //     DocumentIsPosted := (not SalesHeader.Get(Rec."Document Type", Rec."No.")) or IsScheduledPosting;
    //     OnPostOnAfterSetDocumentIsPosted(SalesHeader, IsScheduledPosting, DocumentIsPosted);

    //     if IsScheduledPosting then
    //         CurrPage.Close();
    //     CurrPage.Update(false);

    //     IsHandled := false;
    //     OnPostDocumentBeforeNavigateAfterPosting(Rec, PostingCodeunitID, Navigate, DocumentIsPosted, IsHandled);
    //     if IsHandled then
    //         exit;

    //     if PostingCodeunitID <> CODEUNIT::"Sales-Post (Yes/No)" then
    //         exit;

    //     if OfficeMgt.IsAvailable() then begin
    //         if (Rec."Last Posting No." <> '') and (Rec."Last Posting No." <> xLastPostingNo) then
    //             SalesInvoiceHeader.SetRange("No.", Rec."Last Posting No.")
    //         else begin
    //             SalesInvoiceHeader.SetCurrentKey("Pre-Assigned No.");
    //             SalesInvoiceHeader.SetRange("Pre-Assigned No.", PreAssignedNo);
    //         end;
    //         if SalesInvoiceHeader.FindFirst() then
    //             PAGE.Run(PAGE::"Posted Sales Invoice", SalesInvoiceHeader);
    //     end else
    //         case Navigate of
    //             Enum::"Navigate After Posting"::"Posted Document":
    //                 if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode()) then
    //                     ShowPostedConfirmationMessage(PreAssignedNo, xLastPostingNo);
    //             Enum::"Navigate After Posting"::"New Document":
    //                 if DocumentIsPosted then begin
    //                     SalesHeader.Init();
    //                     SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Invoice);
    //                     OnPostOnBeforeSalesHeaderInsert(SalesHeader);
    //                     SalesHeader.Insert(true);
    //                     PAGE.Run(PAGE::"Sales Invoice", SalesHeader);
    //                 end;
    //         end;
    // end;
    //   local procedure ShowPostedConfirmationMessage(PreAssignedNo: Code[20]; xLastPostingNo: Code[20])
    // var
    //     SalesInvoiceHeader: Record "Sales Invoice Header";
    //     InstructionMgt: Codeunit "Instruction Mgt.";
    //     ICFeedback: Codeunit "IC Feedback";
    // begin
    //     if (Rec."Last Posting No." <> '') and (Rec."Last Posting No." <> xLastPostingNo) then
    //         SalesInvoiceHeader.SetRange("No.", Rec."Last Posting No.")
    //     else begin
    //         SalesInvoiceHeader.SetCurrentKey("Pre-Assigned No.");
    //         SalesInvoiceHeader.SetRange("Pre-Assigned No.", PreAssignedNo);
    //     end;
    //     if SalesInvoiceHeader.FindFirst() then begin
    //         ICFeedback.ShowIntercompanyMessage(Rec, Enum::"IC Transaction Document Type"::Invoice, SalesInvoiceHeader."No.");
    //         if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedSalesInvQst, SalesInvoiceHeader."No."),
    //              InstructionMgt.ShowPostedConfirmationMessageCode())
    //         then
    //             InstructionMgt.ShowPostedDocument(SalesInvoiceHeader, Page::"Sales Invoice");
    //     end;
    // end;

    // internal procedure ShowIntercompanyMessage(PurchaseHeader: Record "Purchase Header"; ICTransactionDocumentType: Enum "IC Transaction Document Type")
    // begin
    //     ShowIntercompanyMessage(PurchaseHeader, ICTransactionDocumentType, PurchaseHeader."No.");
    // end;


    // var
    // LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
}
