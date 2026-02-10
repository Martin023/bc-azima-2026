codeunit 52186520 "Loan FallOff Job Queue Manager"
{
    TableNo = Loans;
    trigger OnRun()
    var
        EmployerCode: code[50];
        AsAt: date;

        LoanFallOff: Record "Loan FallOff";
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

        JobQueueEntry.SetFilter("Object ID to Run", '=%1|%2', Codeunit::"Loan FallOff Job", Codeunit::"Loan FallOff Job Queue Manager");

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
            // Message('There are ongoing loan fall-off generation process jobs running at the moment. Count = %1', JobQueueEntry.Count);
            Message('Report generation has been initiated successfully. Click the "Check report generation status" button to confirm if the report is complete. Job Queue Count = %1', JobQueueEntry.Count);
            exit;
        end;

        if FallOffFilter.RunModal = Action::OK then begin
            EmployerCode := FallOffFilter.GetEmployerCode();
            AsAt := FallOffFilter.GetAsAtDate();

            if EmployerCode <> '' then begin
                Rec.SetRange("Employer Code", EmployerCode);
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
                    DialogProgress.Open('Preparing loan fall-off batch from #1 to #2###', StartFrom, Counter);
                end else begin
                    DialogProgress.Update();
                end;

                if Counter >= RecordCount then begin
                    Counter := RecordCount;
                end;

                JobQueueEntry.Init;

                JobQueueEntry.ID := CreateGuid();
                JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
                JobQueueEntry."Object ID to Run" := Codeunit::"Loan FallOff Job";
                JobQueueEntry.Description := 'Loan fall-off job starting from record ' + Format(StartFrom) + ' to record ' + Format(Counter);
                JobQueueEntry."Job Queue Category Code" := '';
                JobQueueEntry."Recurring Job" := false;
                JobQueueEntry.Status := JobQueueEntry.Status::Ready;
                JobQueueEntry."Earliest Start Date/Time" := CurrentDateTime;
                JobQueueEntry."Starting Time" := Time;

                TheParameterObj.Add('task_id', JobQueueEntry.ID);
                TheParameterObj.Add('start', StartFrom);
                TheParameterObj.Add('end', Counter);
                TheParameterObj.Add('records_pause', Settings."Records Pause Count");
                TheParameterObj.Add('as_at', AsAt);
                TheParameterObj.Add('employer_code', EmployerCode);

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
            LoanFallOff.DeleteAll();

            BulkErrors.Reset;
            BulkErrors.SetRange(Process, BulkErrors.Process::"Loan Fall Off");
            BulkErrors.DeleteAll();

            DialogProgress.Close();
        end else begin
            Error('Sky background manager settings have not been set!');
        end;
    end;

    var
        FallOffFilter: Page "Fall Off Filter";
}

codeunit 52186521 "Loan FallOff Job"
{
    TableNo = "Job Queue Entry";
    trigger OnRun()
    var
        TheLoans: Record Loans;
        TheBulkProcessing: Codeunit "Bulk Processing";

        Counter: Integer;
        Skip: Integer;
        TheParameterObj: JsonObject;

        theStart: JsonToken;
        theEnd: JsonToken;
        RecordsPause: JsonToken;
        i: Integer;
        BatchNo: Code[100];

        AsAtText: JsonToken;
        AsAt: Date;
        EmployerCode: JsonToken;
    begin
        BatchNo := Format(CurrentDateTime);
        TheParameterObj.ReadFrom(Rec."Parameter String");
        TheParameterObj.SelectToken('$.start', theStart);
        TheParameterObj.SelectToken('$.end', theEnd);
        TheParameterObj.SelectToken('$.records_pause', RecordsPause);
        TheParameterObj.SelectToken('$.as_at', AsAtText);
        TheParameterObj.SelectToken('$.employer_code', EmployerCode);

        Evaluate(AsAt, AsAtText.AsValue.AsText);
        if AsAt = 0D then AsAt := Today;

        TheLoans.Reset;
        if EmployerCode.AsValue.AsText <> '' then
            TheLoans.SetRange("Employer Code", EmployerCode.AsValue.AsText);
        if TheLoans.FindSet then begin
            TheLoans.Next((theStart.AsValue.AsInteger) - 1);

            for i := theStart.AsValue.AsInteger to theEnd.AsValue.AsInteger do begin
                TheBulkProcessing.GenerateLoanFallOffOutPut(TheLoans, BatchNo, AsAt);
                // Important!!
                if (((i mod RecordsPause.AsValue.AsInteger) = 0) and (i <> 0)) then begin
                    Sleep(2000); // 2s
                end;

                TheLoans.Next();
            end;
        end;
    end;
}

page 52187023 "Fall Off Filter"
{
    PageType = StandardDialog;
    Caption = 'Deposit Listing - Enter Date Range';

    layout
    {
        area(content)
        {
            group(GroupName)
            {

                field(AsAt; AsAt)
                {
                    // TableRelation = "Interest Due Period"."Interest Due Date";
                    Caption = 'As At';
                }
                field(EmployerCode; EmployerCode)
                {
                    TableRelation = Customer."No.";
                    Caption = 'Employer Code';
                }

            }
        }
    }

    var
        EmployerCode: code[50];
        AsAt: date;

    procedure GetAsAtDate(): Date
    begin
        exit(AsAt)
    end;

    procedure GetEmployerCode(): Code[50]
    begin
        exit(EmployerCode)
    end;


}