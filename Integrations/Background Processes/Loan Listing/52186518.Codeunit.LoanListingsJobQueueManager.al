codeunit 52186518 "Loan Listing Job Queue Manager"
{
    TableNo = Loans;
    trigger OnRun()
    var
        AsAtDate: Date;
        SourceUnit: Option " ",FOSA,BOSA,"BUSINESS LOANS","HR LOANS";
        TheLoanListings: record "Loan Listing Report List";
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

        JobQueueEntry.SetFilter("Object ID to Run", '=%1|%2', Codeunit::"Loan Listing Job", Codeunit::"Loan Listing Job Queue Manager");

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
            // Message('There are ongoing loan listing generation process jobs running at the moment. Count = %1', JobQueueEntry.Count);
            Message('Report generation has been initiated successfully. Click the "Check report generation status" button to confirm if the report is complete. Job Queue Count = %1', JobQueueEntry.Count);
            exit;
        end;

        // Get Start Date and End Date Parameters
        if DateRangeDialog.RunModal = Action::OK then begin
            // Retrieve the dates entered by the user
            AsAtDate := DateRangeDialog.GetAsAtDate();
            SourceUnit := DateRangeDialog.GetSourceUnit();

            if SourceUnit <> SourceUnit::" " then begin
                Rec.SetRange("Source Unit", SourceUnit);
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
                    DialogProgress.Open('Preparing loan listing batch from #1 to #2###', StartFrom, Counter);
                end else begin
                    DialogProgress.Update();
                end;

                if Counter >= RecordCount then begin
                    Counter := RecordCount;
                end;

                JobQueueEntry.Init;

                JobQueueEntry.ID := CreateGuid();
                JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
                JobQueueEntry."Object ID to Run" := Codeunit::"Loan Listing Job";
                JobQueueEntry.Description := 'Loan listing job starting from record ' + Format(StartFrom) + ' to record ' + Format(Counter);
                JobQueueEntry."Job Queue Category Code" := '';
                JobQueueEntry."Recurring Job" := false;
                JobQueueEntry.Status := JobQueueEntry.Status::Ready;
                JobQueueEntry."Earliest Start Date/Time" := CurrentDateTime;
                JobQueueEntry."Starting Time" := Time;

                TheParameterObj.Add('task_id', JobQueueEntry.ID);
                TheParameterObj.Add('start', StartFrom);
                TheParameterObj.Add('end', Counter);
                TheParameterObj.Add('records_pause', Settings."Records Pause Count");
                TheParameterObj.Add('as_at_date', AsAtDate);
                TheParameterObj.Add('source_unit', SourceUnit);


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
            TheLoanListings.DeleteAll();

            BulkErrors.Reset;
            BulkErrors.SetRange(Process, BulkErrors.Process::"Loan Listing");
            BulkErrors.DeleteAll();

            DialogProgress.Close();
        end else begin
            Error('Sky background manager settings have not been set!');
        end;
    end;

    var
        DateRangeDialog: page "Loan List. Date Picker";
}

codeunit 52186519 "Loan Listing Job"
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
        theSourceUnit: JsonToken;
        SourceUnit: Option " ",FOSA,BOSA,"BUSINESS LOANS","HR LOANS";
        RecordsPause: JsonToken;
        i: Integer;
        BatchNo: Code[100];

        AsAt: JsonToken;
        AsAtDate: Date;
    begin
        BatchNo := Format(CurrentDateTime);
        TheParameterObj.ReadFrom(Rec."Parameter String");
        TheParameterObj.SelectToken('$.start', theStart);
        TheParameterObj.SelectToken('$.end', theEnd);
        TheParameterObj.SelectToken('$.records_pause', RecordsPause);
        TheParameterObj.SelectToken('$.as_at_date', AsAt);
        TheParameterObj.SelectToken('$.source_unit', theSourceUnit);

        Evaluate(AsAtDate, AsAt.AsValue.AsText);

        TheLoans.Reset;

        if theSourceUnit.AsValue.AsInteger <> 0 then begin
            SourceUnit := theSourceUnit.AsValue.AsInteger;
            TheLoans.SetRange("Source Unit", SourceUnit);
        end;
        
        if TheLoans.FindSet then begin
            TheLoans.Next((theStart.AsValue.AsInteger) - 1);

            for i := theStart.AsValue.AsInteger to theEnd.AsValue.AsInteger do begin
                TheBulkProcessing.LoanListingProcessing(TheLoans, BatchNo, AsAtDate);

                // Important!!
                if (((i mod RecordsPause.AsValue.AsInteger) = 0) and (i <> 0)) then begin
                    Sleep(2000); // 2s
                end;

                TheLoans.Next();
            end;
        end;
    end;
}

page 52187025 "Loan List. Date Picker"
{
    PageType = StandardDialog;
    Caption = 'Loan Listing - Enter Date Range';

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

                field(SourceUnit; SourceUnit)
                {
                    ApplicationArea = All;
                    Caption = 'Source Unit';
                }

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
        SourceUnit: Option " ",FOSA,BOSA,"BUSINESS LOANS","HR LOANS";



    procedure GetAsAtDate(): Date
    begin
        exit(AsAtDate)
    end;

    procedure GetSourceUnit(): Option "",FOSA,BOSA,"BUSINESS LOANS","HR LOANS"
    begin
        exit(SourceUnit)
    end;
}
