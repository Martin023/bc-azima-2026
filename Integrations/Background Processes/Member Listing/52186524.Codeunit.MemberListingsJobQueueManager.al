codeunit 52186524 "Member List Job Queue Manager"
{
    TableNo = Members;
    trigger OnRun()
    var
        StartDate: Date;
        EndDate: Date;

        MemberListing: Record "Member Listing";
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

        JobQueueEntry.SetFilter("Object ID to Run", '=%1|%2', Codeunit::"Member Listing Job", Codeunit::"Member List Job Queue Manager");

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
            // Message('There are ongoing Member listing generation process jobs running at the moment. Count = %1', JobQueueEntry.Count);
            Message('Report generation has been initiated successfully. Click the "Check report generation status" button to confirm if the report is complete. Job Queue Count = %1', JobQueueEntry.Count);
            exit;
        end;

        // Get Start Date and End Date Parameters
        if DateRangeDialog.RunModal = Action::OK then begin
            // Retrieve the dates entered by the user
            // StartDate := DateRangeDialog.GetStartDate();
            EndDate := DateRangeDialog.GetAsAtDate();

            // Check if the dates are valid
            if EndDate <= StartDate then begin
                // Message('End Date must be greater than Start Date.');
                Error('End Date must be greater than Start Date.');
            end;

            if EndDate <> 0D then begin
                Rec.SetFilter("Registration Date", '..%1', EndDate);
            end;
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
                    DialogProgress.Open('Preparing Member listing batch from #1 to #2', StartFrom, Counter);
                end else begin
                    DialogProgress.Update();
                end;

                if Counter >= RecordCount then begin
                    Counter := RecordCount;
                end;

                JobQueueEntry.Init;

                JobQueueEntry.ID := CreateGuid();
                JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
                JobQueueEntry."Object ID to Run" := Codeunit::"Member Listing Job";
                JobQueueEntry.Description := 'Member listing job starting from record ' + Format(StartFrom) + ' to record ' + Format(Counter);
                JobQueueEntry."Job Queue Category Code" := '';
                JobQueueEntry."Recurring Job" := false;
                JobQueueEntry.Status := JobQueueEntry.Status::Ready;
                JobQueueEntry."Earliest Start Date/Time" := CurrentDateTime;
                JobQueueEntry."Starting Time" := Time;

                TheParameterObj.Add('task_id', JobQueueEntry.ID);
                TheParameterObj.Add('start', StartFrom);
                TheParameterObj.Add('end', Counter);
                TheParameterObj.Add('records_pause', Settings."Records Pause Count");
                // TheParameterObj.Add('start_date', StartDate);
                TheParameterObj.Add('end_date', EndDate);

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
            MemberListing.DeleteAll();

            BulkErrors.Reset;
            BulkErrors.SetRange(Process, BulkErrors.Process::"Member Listing");
            BulkErrors.DeleteAll();

            DialogProgress.Close();
        end else begin
            Error('Sky background manager settings have not been set!');
        end;
    end;

    var
        DateRangeDialog: Page "Member List. Date Picker";
}

codeunit 52186525 "Member Listing Job"
{
    TableNo = "Job Queue Entry";
    trigger OnRun()
    var
        TheMembers: Record Members;
        TheBulkProcessing: Codeunit "Bulk Processing";

        AsAt: date;

        Counter: Integer;
        Skip: Integer;
        TheParameterObj: JsonObject;

        theStart: JsonToken;
        theEnd: JsonToken;
        RecordsPause: JsonToken;
        // theStartDate: JsonToken;
        theEndDate: JsonToken;
        i: Integer;
        BatchNo: Code[100];
    begin
        BatchNo := Format(CurrentDateTime);
        TheParameterObj.ReadFrom(Rec."Parameter String");
        TheParameterObj.SelectToken('$.start', theStart);
        TheParameterObj.SelectToken('$.end', theEnd);
        TheParameterObj.SelectToken('$.records_pause', RecordsPause);
        // TheParameterObj.SelectToken('$.start_date', theStartDate);
        TheParameterObj.SelectToken('$.end_date', theEndDate);

        Evaluate(AsAt, theEndDate.AsValue.AsText);

        TheMembers.Reset;

        if AsAt <> 0D then begin
            TheMembers.SetFilter("Registration Date", '..%1', AsAt);
        end;

        if TheMembers.FindSet then begin
            TheMembers.Next((theStart.AsValue.AsInteger) - 1);

            for i := theStart.AsValue.AsInteger to theEnd.AsValue.AsInteger do begin
                // Evaluate(AsAt, theEndDate.AsValue.AsText);

                TheBulkProcessing.MemberListing(TheMembers, BatchNo);

                // Important!!
                if (((i mod RecordsPause.AsValue.AsInteger) = 0) and (i <> 0)) then begin
                    Sleep(2000); // 2s
                end;

                TheMembers.Next();
            end;
        end;
    end;
}


page 52187026 "Member List. Date Picker"
{
    PageType = StandardDialog;
    Caption = 'Member Listing - Enter Date Range';

    layout
    {
        area(content)
        {
            group(GroupName)
            {
                // field(StartDate; StartDate)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Start Date';
                // }
                field(AsAtDate; AsAtDate)
                {
                    ApplicationArea = All;
                    Caption = 'As At';
                }
            }
        }
    }

    var
        AsAtDate: Date;



    procedure GetAsAtDate(): Date
    begin
        exit(AsAtDate)
    end;
}
