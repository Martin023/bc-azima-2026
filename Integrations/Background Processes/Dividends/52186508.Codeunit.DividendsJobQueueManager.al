codeunit 52186508 "Dividends Job Queue Manager"
{
    TableNo = "Savings Accounts";
    trigger OnRun()
    var
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

        ProgressStarted: Boolean;
    begin
        JobQueueEntry.Reset;

        JobQueueEntry.SetFilter("Object ID to Run", '=%1|%2', Codeunit::"Dividend Job", Codeunit::"Dividends Job Queue Manager");

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
            // Message('There are ongoing dividend generation process jobs running at the moment. Count = %1', JobQueueEntry.Count);
            Message('Report generation has been initiated successfully. Click the "Check report generation status" button to confirm if the report is complete. Job Queue Count = %1', JobQueueEntry.Count);
            exit;
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
                    DialogProgress.Open('Preparing dividend batch from #1 to #2###', StartFrom, Counter);
                    ProgressStarted := true;
                end else begin
                    DialogProgress.Update();
                end;

                if Counter >= RecordCount then begin
                    Counter := RecordCount;
                end;

                JobQueueEntry.Init;

                JobQueueEntry.ID := CreateGuid();
                JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
                JobQueueEntry."Object ID to Run" := Codeunit::"Dividend Job";
                JobQueueEntry.Description := 'Dividend job starting from record ' + Format(StartFrom) + ' to record ' + Format(Counter);
                JobQueueEntry."Job Queue Category Code" := '';
                JobQueueEntry."Recurring Job" := false;
                JobQueueEntry.Status := JobQueueEntry.Status::Ready;
                JobQueueEntry."Earliest Start Date/Time" := CurrentDateTime;
                JobQueueEntry."Starting Time" := Time;

                TheParameterObj.Add('task_id', JobQueueEntry.ID);
                TheParameterObj.Add('start', StartFrom);
                TheParameterObj.Add('end', Counter);
                TheParameterObj.Add('records_pause', Settings."Records Pause Count");

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

            if ProgressStarted then
                DialogProgress.Close();
        end else begin
            Error('Sky background manager settings have not been set!');
        end;
    end;
}

codeunit 52186509 "Dividend Job"
{
    TableNo = "Job Queue Entry";
    trigger OnRun()
    var
        DividendSetUp: Record "Dividend SetUp";
        DividendProgression: Record "Dividend Progression";
        ProductFactory: Record "Product Factory";
        DividendProcess: Codeunit "Dividend Process";

        TheSavingsAccounts: Record "Savings Accounts";

        Counter: Integer;
        Skip: Integer;
        TheParameterObj: JsonObject;

        theStart: JsonToken;
        theEnd: JsonToken;
        RecordsPause: JsonToken;
        i: Integer;
    begin
        TheParameterObj.ReadFrom(Rec."Parameter String");
        TheParameterObj.SelectToken('$.start', theStart);
        TheParameterObj.SelectToken('$.end', theEnd);
        TheParameterObj.SelectToken('$.records_pause', RecordsPause);

        TheSavingsAccounts.Reset;
        TheSavingsAccounts.SetFilter("Product Type", '1|2|3');

        TheSavingsAccounts.SetLoadFields(
            "No.",
            "Product Type"
            );

        if TheSavingsAccounts.FindSet then begin
            TheSavingsAccounts.Next((theStart.AsValue.AsInteger) - 1);

            DividendSetUp.Get;

            for i := theStart.AsValue.AsInteger to theEnd.AsValue.AsInteger do begin
                DividendProgression.Reset;
                DividendProgression.SetRange(DividendProgression.Year, Date2DMY(DividendSetUp."End Date", 3));
                DividendProgression.SetRange("Account No", TheSavingsAccounts."No.");
                DividendProgression.DeleteAll;

                if ProductFactory.Get(TheSavingsAccounts."Product Type") then begin
                    if ProductFactory."Dividend Calc. Method" <> ProductFactory."dividend calc. method"::" " then begin
                        // DividendProcess.generateDividends(TheSavingsAccounts, DividendSetUp);
                    end;
                end;

                if (((i mod RecordsPause.AsValue.AsInteger) = 0) and (i <> 0)) then begin
                    Sleep(2000); // 2s
                end;

                TheSavingsAccounts.Next();
            end;
        end;
    end;
}