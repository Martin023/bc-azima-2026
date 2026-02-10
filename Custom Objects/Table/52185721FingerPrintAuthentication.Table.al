table 52185721 "FingerPrint Authentication"
{

    fields
    {
        field(1; "Member No."; Code[20])
        {
        }
        field(2; Guid; Guid)
        {
        }
        field(3; "Authentication Status"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Member No.", Guid)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        Member: Record Members;
        Transactions: Record "Cashier Transactions";
        GenJournalBatch: Record "Gen. Journal Batch";
    begin
        /*
        {
        IF Member.GET("Member No.") THEN
        BEGIN
        IF "Authentication Status" = 1 THEN
         BEGIN
          Member."FingerPrint Verified" := TRUE;
          Member.MODIFY;
         END
        END
        }
        
        //lets use GUID to find and modify transaction
        IF "Authentication Status" = 1 THEN
        BEGIN
          Member.RESET;
          Member.SETRANGE(Member.SystemGeneratedGuid,Guid);
          IF Member.FINDFIRST THEN
          BEGIN
            Member."FingerPrint Verified" := TRUE;
            Member.MODIFY;
          END;
        
          Transactions.RESET;
          Transactions.SETRANGE(Transactions.SystemGeneratedGuid,Guid);
          IF Transactions.FINDFIRST THEN
          BEGIN
            Transactions."FingerPrint Verified" := TRUE;
            Transactions.MODIFY;
          END;
        
          GenJournalBatch.RESET;
          GenJournalBatch.SETRANGE(GenJournalBatch.SystemGeneratedGuid,Guid);
          IF GenJournalBatch.FINDFIRST THEN
          BEGIN
            GenJournalBatch."FingerPrint Verified" := TRUE;
            GenJournalBatch.MODIFY;
          END;
        
        END;
        */

    end;
}

