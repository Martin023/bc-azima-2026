codeunit 52187332 MySubscribers
{
    EventSubscriberInstance = StaticAutomatic;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"System Editss", 'OnBeforeSystemEditsPosting', '', true, true)]
    local procedure "System Editss_OnBeforeSystemEditsPosting"
    //FilterValue is the primary key of the table
    //FieldID : id of the field being edited
    //newfieldref: incoming value of the field.
    (TableID: Integer; FilterValue: Text; FieldID: Integer; NewFieldRef: FieldRef)

    var
        Members: Record Members;
        HrEmployees: record "HR Employees";
        EmployeeTransfer: record "Employee Transfer";
    begin
        if TableID = 52185650 then begin
            If HrEmployees.get(FilterValue) then begin
                IF HrEmployees."Global Dimension 2 Code" <> Format(NewFieldRef) then begin
                    EmployeeTransfer.init;
                    EmployeeTransfer.Department := HrEmployees."Global Dimension 2 Code";
                    EmployeeTransfer.date1 := Today;
                    EmployeeTransfer.month := Date2DMY(Today, 2);
                    EmployeeTransfer."Employee Code" := HrEmployees."No.";
                    EmployeeTransfer.insert(true);

                end;
                if HrEmployees."Salary Grade" <> format(NewFieldRef) then HrEmployees.GradeGetLeaveDays();

                if (HrEmployees."Responsibility Center" <> format(NewFieldRef)) or (HrEmployees."Supervisor Code" <> format(NewFieldRef)) or
              (HrEmployees."Global Dimension 1 Code" <> format(NewFieldRef)) or (HrEmployees."Global Dimension 2 Code" <> format(NewFieldRef)) then
                    HrEmployees.SendSupervisorEmail();

            end;


        end;


    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforePostGenJnlLine', '', false, false)]
    local procedure OnBeforePostGenJnlLine(var Sender: Codeunit "Gen. Jnl.-Post Line"; var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
    begin
        NextEntryNo := Sender.GetNextEntryNo();
        NextTransactionNo := Sender.GetNextTransactionNo();
        case
            GenJournalLine."Account Type" of
            GenJournalLine."Account Type"::Savings:
                begin
                    CustomPostCU.PostSavings(Sender, GenJournalLine, true);

                end;
            GenJournalLine."Account Type"::Credit:
                begin
                    CustomPostCU.PostCredit(Sender, GenJournalLine, true);
                end;

        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Navigate", 'OnAfterNavigateFindRecords', '', true, true)]
    local procedure "Navigate_OnAfterNavigateFindRecords"(var DocumentEntry: Record "Document Entry"; DocNoFilter: Text; PostingDateFilter: Text; var NewSourceRecVar: Variant)
    begin
        if SavingsLedgerEntry.ReadPermission() then begin
            SavingsLedgerEntry.Reset();
            SavingsLedgerEntry.SetCurrentKey("Document No.");
            SavingsLedgerEntry.SetFilter("Document No.", DocNoFilter);
            SavingsLedgerEntry.SetFilter("Posting Date", PostingDateFilter);
            //SavingsLedgerEntry.SetFilter("External Document No.", ExtDocNo);
            NavigatePage.InsertIntoDocEntry(DocumentEntry, DATABASE::"Savings Ledger Entry", SavingsLedgerEntry.TableCaption, SavingsLedgerEntry.Count);
        end;
        if CreditLedgerEntry.ReadPermission() then begin
            CreditLedgerEntry.Reset();
            CreditLedgerEntry.SetCurrentKey("Document No.");
            CreditLedgerEntry.SetFilter("Document No.", DocNoFilter);
            CreditLedgerEntry.SetFilter("Posting Date", PostingDateFilter);
            //CreditLedgerEntry.SetFilter("External Document No.", ExtDocNo);
            NavigatePage.InsertIntoDocEntry(DocumentEntry, DATABASE::"Credit Ledger Entry", CreditLedgerEntry.TableCaption, CreditLedgerEntry.Count);
        end;

    end;


    [EventSubscriber(ObjectType::Page, Page::"Navigate", 'OnAfterNavigateShowRecords', '', true, true)]
    local procedure "Navigate_OnAfterNavigateShowRecords"
    (
        TableID: Integer;
        DocNoFilter: Text;
        PostingDateFilter: Text;
        ItemTrackingSearch: Boolean;
        var TempDocumentEntry: Record "Document Entry";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        ServiceInvoiceHeader: Record "Service Invoice Header";
        ServiceCrMemoHeader: Record "Service Cr.Memo Header";
        ContactType: Enum "Navigate Contact Type";
        ContactNo: Code[250];
        ExtDocNo: Code[250]
    )
    begin
        SavingsLedgerEntry.SetFilter("Document No.", DocNoFilter);
        CreditLedgerEntry.SetFilter("Document No.", DocNoFilter);
        case TableID of
            DATABASE::"Savings Ledger Entry":
                PAGE.Run(0, SavingsLedgerEntry);
            DATABASE::"Credit Ledger Entry":
                PAGE.Run(0, CreditLedgerEntry);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnBeforeMakeApprovalEntry, '', false, false)]
    local procedure OnBeforeMakeApprovalEntry(var ApprovalEntry: Record "Approval Entry"; ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepArgument: Record "Workflow Step Argument"; ApproverId: Code[50]; var IsHandled: Boolean);
    var
        UserSetUp: Record "User Setup";
    begin
        UserSetUp.Reset();
        UserSetUp.SetRange("User ID", UserId);
        UserSetUp.SetRange("Allow Self Approval", true);
        if not UserSetUp.FindFirst() then
            if UserId = ApproverId then
                Error('You cannot approve a record you initiated');

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnInsertICGenJnlLineOnAfterCopyDocumentFields, '', false, false)]
    local procedure "Purch.-Post_OnInsertICGenJnlLineOnAfterCopyDocumentFields"(PurchaseHeader: Record "Purchase Header"; PurchaseLine: Record "Purchase Line"; var TempICGenJournalLine: Record "Gen. Journal Line")
    begin
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice then begin
            if PurchaseLine.Description <> '' then
                TempICGenJournalLine.Description := PurchaseLine.Description;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"System Initialization", OnAfterLogin, '', false, false)]
    local procedure "System Initialization_OnAfterLogin"()
    begin
        clonotice.Reset();
        clonotice.setfilter("Maturity Date", '<=%1', Today);
        clonotice.setrange(Status, clonotice.status::Approved);
        clonotice.SetRange("Clossure Created", false);
        clonotice.SetRange("Notice Type", clonotice."Notice Type"::"Withdrawal - Normal");
        clonotice.setrange("Early Withdrawal", false);
        if clonotice.FindFirst() then
            Message('There are %1 members with withdrawal notice that are due/matured for closure. Please work on them or notify the relevant person responsible.', clonotice.Count())
            ;

    end;



    var
        clonotice: Record "Member withdrawal Notice";
        NextEntryNo: Integer;
        NextTransactionNo: Integer;
        LoanApp: Record Loans;
        SavingsAccounts: Record "Savings Accounts";
        LoanTypes: Record "Product Factory";

        GenJnlCheckLine: Record "Gen. Journal Line";
        CustomPostCU: Codeunit "CustomPostCU";

        NavigatePage: Page Navigate;
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        TempSavingsLedgerEntry: Record "Savings Ledger Entry" temporary;
        SavingsLedgerEntry2: Record "Savings Ledger Entry";
        CreditLedgerEntry: Record "Credit Ledger Entry";
        TempCreditLedgerEntry: Record "Credit Ledger Entry" temporary;
        CreditLedgerEntry2: Record "Credit Ledger Entry";
        GLReg: Record "G/L Register";
        GenPostReverse: Codeunit "Gen. Jnl.-Post Reverse";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        CannotReverseErr: Label 'You cannot reverse the transaction, because it has already been reversed.';
        PostedAndAppliedSameTransactionErr: Label 'You cannot reverse register number %1 because it contains customer or vendor or employee, savings, credit ledger entries that have been posted and applied in the same transaction.\\You must reverse each transaction in register number %1 separately.', Comment = '%1="G/L Register No."';
}