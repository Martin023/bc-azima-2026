page 52187022 "Deposit List. Date Picker"
{
    PageType = StandardDialog;
    Caption = 'Deposit Listing - Enter Date Range';

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
                field(ProductCategory; ProductCategory)
                {
                    ApplicationArea = All;
                    Caption = 'Product Category';
                }

                field(EndDate; EndDate)
                {
                    ApplicationArea = All;
                    Caption = 'As At';
                }
            }
        }
    }

    var
        StartDate: Date;
        EndDate: Date;
        ProductCategory: enum "Product Categories";

    procedure GetStartDate(): Date
    begin
        exit(StartDate)
    end;

    procedure GetEndDate(): Date
    begin
        exit(EndDate)
    end;

    procedure GetProductCategory(): enum "Product Categories"
    begin
        exit(ProductCategory)
    end;
}


codeunit 52186522 "Deposit List Job Queue Manager"
{
    TableNo = "Savings Accounts";
    trigger OnRun()
    var
        StartDate: Date;
        EndDate: Date;
        ProductCategory: enum "Product Categories";

        DepositListing: Record "Deposit Listing";
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

        JobQueueEntry.SetFilter("Object ID to Run", '=%1|%2', Codeunit::"Deposit Listing Job", Codeunit::"Deposit List Job Queue Manager");

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
            // Message('There are ongoing deposit listing generation process jobs running at the moment. Count = %1', JobQueueEntry.Count);
            Message('Report generation has been initiated successfully. Click the "Check report generation status" button to confirm if the report is complete. Job Queue Count = %1', JobQueueEntry.Count);
            exit;
        end;

        // Get Start Date and End Date Parameters
        if DateRangeDialog.RunModal = Action::OK then begin
            // Retrieve the dates entered by the user
            StartDate := DateRangeDialog.GetStartDate();
            EndDate := DateRangeDialog.GetEndDate();
            ProductCategory := DateRangeDialog.GetProductCategory();

            // Check if the dates are valid
            if EndDate <= StartDate then begin
                // Message('End Date must be greater than Start Date.');
                Error('End Date must be greater than Start Date.');
            end;

            if ProductCategory <> ProductCategory::" " then begin
                Rec.SetRange("Product Category", ProductCategory);
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
                    DialogProgress.Open('Preparing deposit listing batch from #1 to #2', StartFrom, Counter);
                end else begin
                    DialogProgress.Update();
                end;

                if Counter >= RecordCount then begin
                    Counter := RecordCount;
                end;

                JobQueueEntry.Init;

                JobQueueEntry.ID := CreateGuid();
                JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
                JobQueueEntry."Object ID to Run" := Codeunit::"Deposit Listing Job";
                JobQueueEntry.Description := 'Deposit listing job starting from record ' + Format(StartFrom) + ' to record ' + Format(Counter);
                JobQueueEntry."Job Queue Category Code" := '';
                JobQueueEntry."Recurring Job" := false;
                JobQueueEntry.Status := JobQueueEntry.Status::Ready;
                JobQueueEntry."Earliest Start Date/Time" := CurrentDateTime;
                JobQueueEntry."Starting Time" := Time;

                TheParameterObj.Add('task_id', JobQueueEntry.ID);
                TheParameterObj.Add('start', StartFrom);
                TheParameterObj.Add('end', Counter);
                TheParameterObj.Add('records_pause', Settings."Records Pause Count");
                TheParameterObj.Add('start_date', StartDate);
                TheParameterObj.Add('end_date', EndDate);
                TheParameterObj.Add('product_category', ProductCategory.AsInteger);

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
            DepositListing.DeleteAll();

            BulkErrors.Reset;
            BulkErrors.SetRange(Process, BulkErrors.Process::"Deposit Listing");
            BulkErrors.DeleteAll();

            DialogProgress.Close();
        end else begin
            Error('Sky background manager settings have not been set!');
        end;
    end;

    var
        DateRangeDialog: Page "Deposit List. Date Picker";
}

codeunit 52186523 "Deposit Listing Job"
{
    TableNo = "Job Queue Entry";
    trigger OnRun()
    var
        TheSavingsAccounts: Record "Savings Accounts";
        TheBulkProcessing: Codeunit "Bulk Processing";

        AsAt: date;

        Counter: Integer;
        Skip: Integer;
        TheParameterObj: JsonObject;

        theStart: JsonToken;
        theEnd: JsonToken;
        theProductCategory: JsonToken;
        ProductCategory: enum "Product Categories";
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
        TheParameterObj.SelectToken('$.product_category', theProductCategory);

        TheSavingsAccounts.Reset;

        if theProductCategory.AsValue.AsInteger <> 0 then begin
            ProductCategory := "Product Categories".FromInteger(theProductCategory.AsValue.AsInteger);
            TheSavingsAccounts.SetRange("Product Category", ProductCategory);
        end;

        if TheSavingsAccounts.FindSet then begin
            TheSavingsAccounts.Next((theStart.AsValue.AsInteger) - 1);

            for i := theStart.AsValue.AsInteger to theEnd.AsValue.AsInteger do begin
                Evaluate(AsAt, theEndDate.AsValue.AsText);

                TheBulkProcessing.GenerateDepositListing(TheSavingsAccounts, AsAt, BatchNo);

                // Important!!
                if (((i mod RecordsPause.AsValue.AsInteger) = 0) and (i <> 0)) then begin
                    Sleep(2000); // 2s
                end;

                TheSavingsAccounts.Next();
            end;
        end;
    end;
}