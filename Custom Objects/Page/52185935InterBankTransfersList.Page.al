page 52185935 "InterBank Transfers List"
{
    CardPageID = "Bank & Cash Transfer Request";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "InterBank Transfers";
    SourceTableView = WHERE(Posted = CONST(false));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Source Transfer Type"; Rec."Source Transfer Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Paying  Bank Account Name"; Rec."Paying  Bank Account Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Receiving Transfer Type"; Rec."Receiving Transfer Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Receiving Bank Account Name"; Rec."Receiving Bank Account Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Currency Code Destination"; Rec."Currency Code Destination")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cancelled By"; Rec."Cancelled By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Time Cancelled"; Rec."Time Cancelled")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Cancelled"; Rec."Date Cancelled")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
    trigger OnInit()
    begin
        CurrPage.LookupMode := true;
    end;

    trigger OnOpenPage()
    begin
        if UserMgt.GetPurchasesFilter() <> '' then begin
            Rec.FilterGroup(2);
            Rec.SetRange("Reciept Responsibility Center", UserMgt.GetPurchasesFilter());
            //  setrange("global Dimension 2 Code",UserMgt.GetSetDimensions(userid,2));
            Rec.FilterGroup(0);
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

        "NOT OpenApprovalEntriesExist": Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
    // CustomApprovals: Codeunit "Custom Approvals Codeunit";

    local procedure SetControlAppearance()
    var
    //  // ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        //  OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        //  OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;
}

