#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185469 "Gen. Jnl.-Post New"
{
    TableNo = "Gen. Journal Line";

    trigger OnRun()
    begin

        GenJnlLine.Copy(Rec);
        Code;
        // Copy(GenJnlLine);
    end;

    var
        Text000: label 'cannot be filtered when posting recurring journals';
        Text001: label 'Do you want to post the journal lines?';
        Text002: label 'There is nothing to post.';
        Text003: label 'The journal lines were successfully posted.';
        Text004: label 'The journal lines were successfully posted. You are now in the %1 journal.';
        Text005: label 'Using %1 for Declining Balance can result in misleading numbers for subsequent years. You should manually check the postings and correct them if necessary. Do you want to continue?';
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
        TempJnlBatchName: Code[10];
        Text006: label '%1 in %2 must not be equal to %3 in %4.', Comment = 'Source Code in Genenral Journal Template must not be equal to Job G/L WIP in Source Code Setup.';
        PreviewMode: Boolean;

    [TryFunction]
    local procedure "Code"()
    var
        FALedgEntry: Record "FA Ledger Entry";
        SourceCodeSetup: Record "Source Code Setup";
    begin
        begin
            GenJnlTemplate.Get(GenJnlLine."Journal Template Name");

            if GenJnlTemplate.Type = GenJnlTemplate.Type::Jobs then begin
                SourceCodeSetup.Get;
                if GenJnlTemplate."Source Code" = SourceCodeSetup."Job G/L WIP" then
                    Error(Text006, GenJnlTemplate.FieldCaption("Source Code"), GenJnlTemplate.TableCaption,
                      SourceCodeSetup.FieldCaption("Job G/L WIP"), SourceCodeSetup.TableCaption);
            end;
            GenJnlTemplate.TestField("Force Posting Report", false);
            if GenJnlTemplate.Recurring and (GenJnlLine.GetFilter(GenJnlLine."Posting Date") <> '') then
                GenJnlLine.FieldError(GenJnlLine."Posting Date", Text000);


            /*IF NOT PreviewMode THEN
              IF NOT CONFIRM(Text001,FALSE) THEN
                EXIT;*/


            if GenJnlLine."Account Type" = GenJnlLine."account type"::"Fixed Asset" then begin
                FALedgEntry.SetRange("FA No.", GenJnlLine."Account No.");
                FALedgEntry.SetRange("FA Posting Type", GenJnlLine."fa posting type"::"Acquisition Cost");
                if FALedgEntry.FindFirst and GenJnlLine."Depr. Acquisition Cost" then
                    if not Confirm(Text005, false, GenJnlLine.FieldCaption(GenJnlLine."Depr. Acquisition Cost")) then
                        exit;
            end;

            TempJnlBatchName := GenJnlLine."Journal Batch Name";

            GenJnlPostBatch.Run(GenJnlLine);

            if PreviewMode then
                exit;

            if GenJnlLine."Line No." <> 0 then
                // MESSAGE(Text002)
                //ELSE     //Temprary Comment
                /*IF TempJnlBatchName = "Journal Batch Name" THEN
                  MESSAGE(Text003)
                ELSE
                IF TempJnlBatchName <> "Journal Batch Name" THEN
                  MESSAGE(
                    Text004,
                    "Journal Batch Name");*/

                //Posting Successful
                if UserId <> 'HARAMBEESACCO\SKYWORLDLTD' then
                    PostIfSuccessful(1);

            if not GenJnlLine.Find('=><') or (TempJnlBatchName <> GenJnlLine."Journal Batch Name") then begin
                GenJnlLine.Reset;
                GenJnlLine.FilterGroup(2);
                GenJnlLine.SetRange(GenJnlLine."Journal Template Name", GenJnlLine."Journal Template Name");
                GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", GenJnlLine."Journal Batch Name");
                GenJnlLine.FilterGroup(0);
                GenJnlLine."Line No." := 1;
            end;
        end;

    end;


    procedure Preview(GenJournalLine: Record "Gen. Journal Line")
    var
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
    begin
        PreviewMode := true;
        GenJnlPostBatch.SetPreviewMode(true);
        GenJnlLine.Copy(GenJournalLine);
        // GenJnlPostPreview.Start;
        if not Code then begin
            // if GetLastErrorText <> GenJnlPostPreview.GetPreviewModeErrMessage then
            //     Error(GetLastErrorText);
            // GenJnlPostPreview.Finish;
            // GenJnlPostPreview.ShowAllEntries;
            Error('');
        end;
    end;


    procedure PostIfSuccessful(ValuePosting: Integer)
    var
        ValPost: Record "Value Posting";
    begin
        if UserId <> 'HARAMBEESACCO\MBANKING' then begin
            ValPost.SetRange(ValPost.UserID, UserId);
            if ValPost.Find('-') then begin
                ValPost."Value Posting" := ValuePosting;
                ValPost.Modify;
            end
            else begin
                ValPost.Init;
                ValPost.UserID := UserId;
                ValPost."Value Posting" := ValuePosting;
                ValPost.Insert;
            end;
        end;
    end;
}
