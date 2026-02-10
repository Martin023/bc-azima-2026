codeunit 52186420 "52186420 NavigateExte"
{
    TableNo = "Document Entry";
    trigger OnRun()
    begin
        

 
    end;

    [EventSubscriber(ObjectType::Page, page::Navigate, 'OnBeforeNavigateShowRecords', '', false, false)]
    procedure ShowRecordsSacco()
    var
        IsHandled: Boolean;

    begin
        IsHandled := false;
        if IsHandled then
            exit;
        // Message('Here Trying');
        // pageextension52185642.FindCreditEntries();
        // pageextension52185642.FindSavingsEntries();

        case RecordReference."Table ID" of
            DATABASE::"Savings Ledger Entry":
                PAGE.RUN(0, SavingAccLedgEntry);
            DATABASE::"Credit Ledger Entry":
                PAGE.RUN(0, CreditAccLedgeEntry);

        end;
    end;

    var
        RecordReference: Record "Document Entry";
        SavingAccLedgEntry: Record "Savings Ledger Entry";
        CreditAccLedgeEntry: Record "Credit Ledger Entry";
        pageextension52185642: Page Navigate;

}
