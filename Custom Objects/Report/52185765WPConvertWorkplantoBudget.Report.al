#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185765 "W/P Convert Workplan to Budget"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Workplan Activities"; "Workplan Activities")
        {
            RequestFilterFields = "Workplan Code", "Activity Code";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Dann
                if Direction = Direction::"Upload Workplan Budget Entries" then begin
                    //   UnknownTable52185902.TestField("No.");
                    //   UnknownTable52185902.TestField("Workplan Code");
                    //   UnknownTable52185902.TestField("Amount to Transfer");
                    //   UnknownTable52185902.TestField("Account Type","account type"::Posting);
                    //   UnknownTable52185902.TestField("Date to Transfer");
                    //   UnknownTable52185902.TestField(Type);

                    WorkplanEntry.Reset;
                    WorkplanEntry.SetRange(WorkplanEntry."Activity Code", "Activity Code");
                    if WorkplanEntry.Find('-') then begin
                        //Update

                        InsertWorkplanEntries;

                        CounterVar += 1;

                        "Uploaded to Procurement Workpl" := true;

                        //UnknownTable52185902.Modify;

                        WorkplanEntry.Insert;
                    end else begin
                        //Insert
                        WorkplanEntry.Init;

                        InsertWorkplanEntries;

                        CounterVar += 1;

                        "Uploaded to Procurement Workpl" := true;

                        //UnknownTable52185902.Modify;

                        WorkplanEntry.Insert;
                    end;

                end else begin
                    //If Direction is Reversal
                    WorkplanEntry.SetRange(WorkplanEntry."Activity Code", "Activity Code");
                    WorkplanEntry.SetRange(WorkplanEntry."Workplan Code", "Workplan Code");
                    WorkplanEntry.SetRange(WorkplanEntry.Date, "Date to Transfer");
                    WorkplanEntry.SetRange(WorkplanEntry."Account Type", Type);
                    WorkplanEntry.SetRange(WorkplanEntry."Global Dimension 1 Code", "Global Dimension 1 Code");
                    WorkplanEntry.SetRange(WorkplanEntry."Global Dimension 2 Code", "Shortcut Dimension 2 Code");
                    WorkplanEntry.SetRange(WorkplanEntry."G/L Account No.", "No.");
                    WorkplanEntry.SetRange(WorkplanEntry."Expense Code", "Expense Code");
                    WorkplanEntry.SetRange(WorkplanEntry.Amount, "Amount to Transfer");
                    WorkplanEntry.SetRange(WorkplanEntry."Processed to Budget", false);
                    if WorkplanEntry.Find('-') then begin
                        CounterVar += 1;
                        WorkplanEntry.DeleteAll;
                        "Uploaded to Procurement Workpl" := false;
                        //UnknownTable52185902.Modify;
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                //SETRANGE("Workplan Code",WorkplanFilter);
                // UnknownTable52185902.SetRange("Account Type","account type"::Posting);
                // UnknownTable52185902.SetRange("Converted to Budget",false);

                // if Direction = Direction::"Upload Workplan Budget Entries" then
                // begin
                //     UnknownTable52185902.SetRange("Uploaded to Procurement Workpl",false);
                // end else
                // begin
                //     UnknownTable52185902.SetRange("Uploaded to Procurement Workpl",true);
                // end;
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
                field(Direction; Direction)
                {
                    ApplicationArea = Basic;
                    Caption = 'Direction';
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

    trigger OnPostReport()
    begin
        if Direction = Direction::"Upload Workplan Budget Entries" then begin
            Message(Text0001, CounterVar);
        end else begin
            Message(Text0002, CounterVar);
        end;
    end;

    trigger OnPreReport()
    begin
        /*
        //Required Filters
        WorkplanFilter:="Workplan Activities".GETFILTER("Workplan Code");
        IF WorkplanFilter = '' THEN ERROR('Workplan code must be filled in on request page');
        */
        //Default Direction to Uploading
        if Direction = Direction::" " then Direction := Direction::"Upload Workplan Budget Entries";

        CounterVar := 0;

    end;

    var
        WorkplanFilter: Text;
        WorkplanEntry: Record "Workplan Entry";
        CounterVar: Integer;
        Direction: Option " ","Upload Workplan Budget Entries","Reverse Workplan Budget Entries";
        Text0001: label 'Process Complete [%1] entries have been transfered to Procurement Workplan Budget Entries';
        Text0002: label 'Process Complete [%1] entries have been reversed from Procurement Workplan Budget Entries';

    local procedure GetNextEntryNo() EntryNumber: Integer
    var
        WorkplanEntry: Record "Workplan Entry";
        EntryNum: Integer;
    begin
        WorkplanEntry.SetCurrentkey("Entry No.");
        if WorkplanEntry.Find('+') then
            exit(WorkplanEntry."Entry No." + 1)
        else
            exit(1);
    end;


    procedure InsertWorkplanEntries()
    begin

        WorkplanEntry."Entry No." := GetNextEntryNo;
        WorkplanEntry."Workplan Code" := "Workplan Activities"."Workplan Code";
        WorkplanEntry."Activity Code" := "Workplan Activities"."Activity Code";
        WorkplanEntry.Date := "Workplan Activities"."Date to Transfer";
        WorkplanEntry."Global Dimension 1 Code" := "Workplan Activities"."Global Dimension 1 Code";
        WorkplanEntry."Global Dimension 2 Code" := "Workplan Activities"."Shortcut Dimension 2 Code";
        WorkplanEntry.Amount := "Workplan Activities"."Amount to Transfer";
        WorkplanEntry.Description := "Workplan Activities"."Activity Description";
        WorkplanEntry."User ID" := UserId;
        WorkplanEntry."Account Type" := "Workplan Activities".Type;
        WorkplanEntry."Expense Code" := "Workplan Activities"."Expense Code";
        WorkplanEntry."G/L Account No." := "Workplan Activities"."No.";
        WorkplanEntry."Created By:" := UserId;
        WorkplanEntry."Last Modified By:" := UserId;
        WorkplanEntry.Validate(WorkplanEntry."Expense Code");
        WorkplanEntry.Validate(WorkplanEntry."G/L Account No.");
        WorkplanEntry.Validate(WorkplanEntry."Global Dimension 1 Code");
        WorkplanEntry.Validate(WorkplanEntry."Global Dimension 2 Code");
        WorkplanEntry.Validate(WorkplanEntry."Activity Code");
        WorkplanEntry.Validate(WorkplanEntry."Workplan Code");
        WorkplanEntry.Validate(WorkplanEntry."Account Type");
    end;


    procedure ReversalWorkplanEntries()
    begin

        WorkplanEntry."Entry No." := GetNextEntryNo;
        WorkplanEntry."Workplan Code" := "Workplan Activities"."Workplan Code";
        WorkplanEntry."Activity Code" := "Workplan Activities"."Activity Code";
        WorkplanEntry.Date := "Workplan Activities"."Date to Transfer";
        WorkplanEntry."Global Dimension 1 Code" := "Workplan Activities"."Global Dimension 1 Code";
        WorkplanEntry.Amount := -("Workplan Activities"."Amount to Transfer"); //For Reversal Insert - ve
        WorkplanEntry.Description := "Workplan Activities"."Activity Description";
        WorkplanEntry."User ID" := UserId;
        WorkplanEntry."Account Type" := "Workplan Activities".Type;
        WorkplanEntry."G/L Account No." := "Workplan Activities"."No.";
        WorkplanEntry."Created By:" := UserId;
        WorkplanEntry."Last Modified By:" := UserId;
        WorkplanEntry."Expense Code" := "Workplan Activities"."Expense Code";
        WorkplanEntry."Entry Type" := WorkplanEntry."entry type"::Reversal;
        WorkplanEntry.Validate(WorkplanEntry."G/L Account No.");
        WorkplanEntry.Validate(WorkplanEntry."Expense Code");
        WorkplanEntry.Validate(WorkplanEntry."Global Dimension 1 Code");
        WorkplanEntry.Validate(WorkplanEntry."Activity Code");
        WorkplanEntry.Validate(WorkplanEntry."Workplan Code");
        WorkplanEntry.Validate(WorkplanEntry."Account Type");
    end;
}
