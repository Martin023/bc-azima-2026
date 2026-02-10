PageExtension 52186833 pageextension52186833 extends "Sales Credit Memo"
{

    //Unsupported feature: Property Modification (PromotedActionCategoriesML) on ""Sales Credit Memos"(Page 9302)".

    layout
    {
        addafter(Status)
        {
            field("Refund Type"; Rec."Refund Type")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Refund Reason';
                Visible = true;
                ShowMandatory = true;
            }
            field("Waiver Start Date"; Rec."Waiver Start Date")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Waiver Start Date';
                Visible = true;
                ShowMandatory = true;
            }
            field("Waiver End Date"; Rec."Waiver End Date")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Waiver End Date';
                Visible = true;
                ShowMandatory = true;
            }
            field(Waived; Rec.Waived)
            {

            }
        }
    }

    actions
    {
        modify(Post)
        {
            Visible = true;
        }
        addbefore(PostAndSend)
        {
            action(PostNew)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'P&ost';
                Image = PostOrder;
                ShortCutKey = 'F9';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';
                Visible = false;

                trigger OnAction()
                begin
                    PostDocument(CODEUNIT::"Sales-Post (Yes/No)");
                end;
            }
        }

    }

    var
        DocumentIsPosted: Boolean;
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        OpenPostedSalesCrMemoQst: Label 'The credit memo is posted as number %1 and moved to the Posted Sales Credit Memos window.\\Do you want to open the posted credit memo?', Comment = '%1 = posted document number';


    local procedure PostDocument(PostingCodeunitID: Integer)
    var
        SalesHeader: Record "Sales Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        OfficeMgt: Codeunit "Office Management";
        InstructionMgt: Codeunit "Instruction Mgt.";
        PreAssignedNo: Code[20];
        xLastPostingNo: Code[20];
        IsScheduledPosting: Boolean;
        IsHandled: Boolean;
    begin
        CheckSalesCheckAllLinesHaveQuantityAssigned();
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
        OnPostDocumentBeforeNavigateAfterPosting(Rec, PostingCodeunitID, DocumentIsPosted, IsHandled);
        if IsHandled then
            exit;

        if PostingCodeunitID <> CODEUNIT::"Sales-Post (Yes/No)" then
            exit;

        Rec.SetTrackInfoForCancellation();

        if OfficeMgt.IsAvailable() then begin
            if (Rec."Last Posting No." <> '') and (Rec."Last Posting No." <> xLastPostingNo) then
                SalesCrMemoHeader.SetRange("No.", Rec."Last Posting No.")
            else
                SalesCrMemoHeader.SetRange("Pre-Assigned No.", PreAssignedNo);
            IsHandled := false;
            OnPostDocumentOnBeforeOpenPage(SalesCrMemoHeader, IsHandled);
            if not IsHandled then
                if SalesCrMemoHeader.FindFirst() then
                    PAGE.Run(PAGE::"Posted Sales Credit Memo", SalesCrMemoHeader);
        end else
            if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode()) then
                ShowPostedConfirmationMessage(PreAssignedNo, xLastPostingNo);
    end;

    local procedure CheckSalesCheckAllLinesHaveQuantityAssigned()
    begin
        LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);
    end;

    local procedure OnPostOnAfterSetDocumentIsPosted(SalesHeader: Record "Sales Header"; var IsScheduledPosting: Boolean; var DocumentIsPosted: Boolean)
    begin
    end;

    local procedure OnPostDocumentBeforeNavigateAfterPosting(var SalesHeader: Record "Sales Header"; var PostingCodeunitID: Integer; DocumentIsPosted: Boolean; var IsHandled: Boolean)
    begin
    end;

    local procedure OnPostDocumentOnBeforeOpenPage(SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var IsHandled: boolean)
    begin
    end;

    local procedure ShowPostedConfirmationMessage(PreAssignedNo: Code[20]; xLastPostingNo: Code[20])
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
        IsHandled: Boolean;
    begin
        if (Rec."Last Posting No." <> '') and (Rec."Last Posting No." <> xLastPostingNo) then
            SalesCrMemoHeader.SetRange("No.", Rec."Last Posting No.")
        else
            SalesCrMemoHeader.SetRange("Pre-Assigned No.", PreAssignedNo);
        if SalesCrMemoHeader.FindFirst() then
            if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedSalesCrMemoQst, SalesCrMemoHeader."No."),
                 InstructionMgt.ShowPostedConfirmationMessageCode())
            then begin
                IsHandled := false;
                OnShowPostedConfirmationMessageOnBeforeShowPostedDocument(SalesCrMemoHeader, IsHandled);
                if not IsHandled then
                    InstructionMgt.ShowPostedDocument(SalesCrMemoHeader, Page::"Sales Credit Memo");
            end;
    end;

    local procedure OnShowPostedConfirmationMessageOnBeforeShowPostedDocument(SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var IsHandled: boolean)
    begin
    end;
}