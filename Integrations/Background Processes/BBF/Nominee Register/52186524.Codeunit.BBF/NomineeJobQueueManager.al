codeunit 52186528 "BBF/Nominee Job Queue Manager"
{
    TableNo = "Next of KIN";
    trigger OnRun()
    var
        SelectedFilter: Text;

        BBFNominee: Record "BBF/Nominee Register";
        BulkErrors: Record "Bulk Processing Errors";

        RecordsPerBatch: Integer;
        Counter: Integer;
        StartFrom: Integer;

        JobQueueEntry: Record "Job Queue Entry";
        TheDuration: Duration;

        TheParameterObj: JsonObject;
        TheParameterString: Text;

        DialogProgress: Dialog;
        RecordCount: Integer;
        NoOfThreads: Integer;

        Settings: Record "Sky Background Process Manager";
    begin
        JobQueueEntry.Reset;

        JobQueueEntry.SetFilter("Object ID to Run", '=%1|%2', Codeunit::"BBF/Nominee Job", Codeunit::"BBF/Nominee Job Queue Manager");

        if JobQueueEntry.FindSet then begin
            repeat
                if (JobQueueEntry.Status = JobQueueEntry.Status::Error) or (JobQueueEntry.Status = JobQueueEntry.Status::Ready) then begin
                    JobQueueEntry.Status := JobQueueEntry.Status::Ready;
                    JobQueueEntry."Earliest Start Date/Time" := CurrentDateTime;
                    JobQueueEntry."Starting Time" := Time;
                    JobQueueEntry."User ID" := UserId;
                    JobQueueEntry.Modify();

                    JobQueueEntry.Restart();
                end;
            until JobQueueEntry.Next() = 0;
            // Message('There are ongoing BBF/Nominee generation process jobs running at the moment. Count = %1', JobQueueEntry.Count);
            Message('Report generation has been initiated successfully. Click the "Check report generation status" button to confirm if the report is complete. Job Queue Count = %1', JobQueueEntry.Count);
            exit;
        end;

        if BBFNomineeFilter.RunModal = Action::OK then begin
            SelectedFilter := BBFNomineeFilter.GetSelectedFilter();

            if SelectedFilter = 'Nominee' then
                Rec.SetRange("Is Nominee", true);
            if SelectedFilter = 'BBF' then
                Rec.SetRange("Is a Beneficiary", true);
        end;

        JobQueueEntry.Reset;

        if Settings.FindFirst then begin
            Settings.TestField("Records Pause Count");
            Settings.TestField("Threads Count");

            StartFrom := 1;
            Counter := 0;
            RecordCount := Rec.Count;
            NoOfThreads := Settings."Threads Count";
            RecordsPerBatch := Round(RecordCount / NoOfThreads, 1, '>');

            while ((Counter < RecordCount) and (RecordCount <> 0)) do begin
                Clear(TheParameterObj);
                TheParameterString := '';
                Counter += RecordsPerBatch;

                if Counter = RecordsPerBatch then begin
                    DialogProgress.Open('Preparing BBF/Nominee batch from #1 to #2###', StartFrom, Counter);
                end else begin
                    DialogProgress.Update();
                end;

                if Counter >= RecordCount then begin
                    Counter := RecordCount;
                end;

                JobQueueEntry.Init;

                JobQueueEntry.ID := CreateGuid();
                JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
                JobQueueEntry."Object ID to Run" := Codeunit::"BBF/Nominee Job";
                JobQueueEntry.Description := 'Loan BBF/Nominee job starting from record ' + Format(StartFrom) + ' to record ' + Format(Counter);
                JobQueueEntry."Job Queue Category Code" := '';
                JobQueueEntry."Recurring Job" := false;
                JobQueueEntry.Status := JobQueueEntry.Status::Ready;
                JobQueueEntry."Earliest Start Date/Time" := CurrentDateTime;
                JobQueueEntry."Starting Time" := Time;

                TheParameterObj.Add('task_id', JobQueueEntry.ID);
                TheParameterObj.Add('start', StartFrom);
                TheParameterObj.Add('end', Counter);
                TheParameterObj.Add('records_pause', Settings."Records Pause Count");
                TheParameterObj.Add('selected_filter', SelectedFilter);

                TheParameterObj.WriteTo(TheParameterString);

                JobQueueEntry."Parameter String" := TheParameterString;
                JobQueueEntry."Record ID to Process" := Rec.RecordId;

                if JobQueueEntry.Insert(true) then begin
                    JobQueueEntry.ScheduleTask();
                    JobQueueEntry.Reset();
                end;

                if ((Counter mod 5) = 0) and (Counter <> 0) then begin
                    Sleep(5000); // 5s
                end;

                StartFrom += RecordsPerBatch;
            end;

            // Clear all entries + error logs
            BBFNominee.DeleteAll();

            BulkErrors.Reset;
            BulkErrors.SetRange(Process, BulkErrors.Process::"BBF/Nominee Register");
            BulkErrors.DeleteAll();

            DialogProgress.Close();
        end else begin
            Error('Sky background manager settings have not been set!');
        end;
    end;

    var
        BBFNomineeFilter: Page "BBF/Nominee Filter";
}

codeunit 52186529 "BBF/Nominee Job"
{
    TableNo = "Job Queue Entry";
    trigger OnRun()
    var
        TheNextOfKin: Record "Next of KIN";
        TheBulkProcessing: Codeunit "Bulk Processing";

        Counter: Integer;
        Skip: Integer;
        TheParameterObj: JsonObject;

        theStart: JsonToken;
        theEnd: JsonToken;
        RecordsPause: JsonToken;
        i: Integer;
        BatchNo: Code[100];


        SelectedFilter: JsonToken;
    begin
        BatchNo := Format(CurrentDateTime);
        TheParameterObj.ReadFrom(Rec."Parameter String");
        TheParameterObj.SelectToken('$.start', theStart);
        TheParameterObj.SelectToken('$.end', theEnd);
        TheParameterObj.SelectToken('$.records_pause', RecordsPause);
        TheParameterObj.SelectToken('$.selected_filter', SelectedFilter);

        TheNextOfKin.Reset;
        TheNextOfKin.SetRange(Removed, false);
        if SelectedFilter.AsValue.AsText = 'Nominee' then
            TheNextOfKin.SetRange("Is Nominee", true);
        if SelectedFilter.AsValue.AsText = 'BBF' then
            TheNextOfKin.SetRange("Is a Beneficiary", true);
        if TheNextOfKin.FindSet then begin
            TheNextOfKin.Next((theStart.AsValue.AsInteger) - 1);

            for i := theStart.AsValue.AsInteger to theEnd.AsValue.AsInteger do begin
                TheBulkProcessing.BBFNomineeListing(TheNextOfKin, BatchNo);
                // Important!!
                if (((i mod RecordsPause.AsValue.AsInteger) = 0) and (i <> 0)) then begin
                    Sleep(2000); // 2s
                end;

                TheNextOfKin.Next();
            end;
        end;
    end;
}

page 52186746 "BBF/Nominee Filter"
{
    PageType = StandardDialog;
    Caption = 'BBF/Nominee Filter';

    layout
    {
        area(content)
        {
            group(GroupName)
            {
                field(SelectListing; SelectListing)
                {
                    Caption = 'Select Listing';
                }

            }
        }
    }

    var
        SelectListing: Option Nominee,BBF;

    procedure GetSelectedFilter(): Code[50]
    begin
        exit(Format(SelectListing));
    end;


}