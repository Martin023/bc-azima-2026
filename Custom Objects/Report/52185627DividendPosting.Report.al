#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185627 "Dividend Posting"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Members; members)
        {

            RequestFilterFields = "No.";


            trigger OnAfterGetRecord()
            var
                DividendpII: Codeunit DVII;
                DividendProcess: Codeunit "Dividend Process";
            begin
                Year := Date2dmy(Today, 3);
                DividendSetUp.Get();
                PreviousYear := Date2DMY(DividendSetUp."End Date", 3);

                //ERROR('Fine %1',PreviousYear);

                DividendProgression.Reset;
                DividendProgression.SetRange(DividendProgression."Member No", "No.");
                DividendProgression.SetRange(DividendProgression.Year, PreviousYear);
                if DividendProgression.Find('-') then begin
                    intProgressI += 1;

                    if (intProgressI >= NoOfRecsProgress) or (Time - TimeProgress > 1000) then begin
                        NoOfProgressed := NoOfProgressed + intProgressI;
                        diaProgress.Update(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                        intProgressI := 0;
                        TimeProgress := Time;
                    end;
                    DividendPostingBuffer.SetCurrentKey("Member No.", Posted);
                    DividendPostingBuffer.SetRange("Member No.", "No.");
                    DividendPostingBuffer.SetRange(Posted, false);
                    IF DividendPostingBuffer.Find('-') THEN BEGIN
                        DividendpII.PostDiv(Members."No.", SendSMS);
                    end;


                end;
            end;

            trigger OnPostDataItem()
            var

                Text001: label 'Successfully Processed.';
                DividendProcess: Codeunit "Dividend Process";
            begin
                diaProgress.Close;
                Message(MessageTxt);
            end;

            trigger OnPreDataItem()

            begin
                intProgressTotal := Members.Count;

                if UserSetup.Get(UserId) then
                    if UserSetup."Post Dividend" = false then
                        Error('You are not allowed to Post Dividend');


                Temp.Get(UserId);
                Temp.TestField("Cashier Journal Template");
                Temp.TestField("Cashier Journal Batch");
                JBatch := Temp."Cashier Journal Batch";
                Jtemplate := Temp."Cashier Journal Template";
                GenJLine.SetRange("Journal Batch Name", JBatch);
                GenJLine.SetRange("Journal Template Name", Jtemplate);
                if GenJLine.Find('-') then
                    GenJLine.DeleteAll;

                intProgressI := 0;
                TimeProgress := Time;
                NoOfRecsProgress := intProgressTotal DIV 100;
                NoOfProgressed := 0;

                diaProgress.Open(DividendsPosting + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field("Posting Date:"; PostingDate)
                {
                    ApplicationArea = Basic;
                }
                field("Document No.:"; DocumentNo)
                {
                    ApplicationArea = Basic;
                }
                field("Ext Document No.:"; ExtDocumentNo)
                {
                    ApplicationArea = Basic;
                }
                field(SendSMS; SendSMS)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send SMS';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Temp: Record "Banking User Template";
        Jtemplate: Code[10];
        JBatch: Code[10];
        GenJLine: Record "Gen. Journal Line";
        PostingDate: Date;
        DocumentNo: Code[10];
        ExtDocumentNo: Code[10];
        MessageTxt: label 'Journal Posted Successfully';
        intProgressTotal: Integer;
        diaProgress: Dialog;
        intProgressI: Integer;
        intProgress: Integer;
        TimeProgress: Time;
        NoOfProgressed: Integer;
        NoOfRecsProgress: Integer;
        DividendsPosting: label 'Dividends Posting';
        SendSMS: Boolean;
        UserSetup: Record "User Setup";
        DividendProgression: Record "Dividend Progression";
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        Year: Integer;
        PreviousYear: Integer;
        CreditLedgerEntry: Record "Credit Ledger Entry";
        DividendSetUp: Record "Dividend SetUp";
        DividendPostingBuffer: Record "Dividend Posting Buffer";
}
