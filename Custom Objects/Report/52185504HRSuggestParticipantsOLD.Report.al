#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185504 "HR Suggest Participants OLD"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            DataItemTableView = where(Status = filter(Active));
            RequestFilterFields = "No.", Gender, "Department Code", Office;
            column(ReportForNavId_2; 2)
            {
            }

            // trigger OnAfterGetRecord()
            // begin
            //     HRShiftScheduleLines.Reset;
            //     HRShiftScheduleLines.SetRange(HRShiftScheduleLines.Code, ApplicationNoFilter);
            //     if HRShiftScheduleLines.Find('-') then begin
            //         fn_InsertEntries;
            //         Counter += 1;
            //     end else begin
            //         fn_InsertEntries;
            //         Counter += 1;
            //     end;
            // end;
        }
        dataitem("HR Shift Schedule Lines"; "HR Shift Schedule Lines")
        {
            DataItemTableView = sorting(Code, "Line No.");
            column(ReportForNavId_1; 1)
            {
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
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
        Message('%1 Participants Suggested', Counter);
    end;

    trigger OnPreReport()
    begin
        //
        ApplicationNoFilter := "HR Shift Schedule Lines".GetFilter(Code);
        if ApplicationNoFilter = '' then Error(Text2000);

        //
        Counter := 0;
    end;

    var
        ApplicationNoFilter: Code[10];
        Text2000: label 'Please enter shift no';
        HRShiftScheduleLines: Record "HR Shift Schedule Lines";
        Counter: Integer;

    local procedure fn_InsertEntries()
    begin
        HRShiftScheduleLines.Init;

        HRShiftScheduleLines."Line No." := fn_GetLastEntryNo;
        HRShiftScheduleLines.Code := ApplicationNoFilter;
        HRShiftScheduleLines."Employee No." := "HR Employees"."No.";
        HRShiftScheduleLines.Validate(HRShiftScheduleLines."Employee No.");

        HRShiftScheduleLines.Insert;
    end;

    local procedure fn_GetLastEntryNo() LastEntryNo: Integer
    var
        HRShiftScheduleLines_2: Record "HR Shift Schedule Lines";
    begin
        HRShiftScheduleLines_2.Reset;
        if HRShiftScheduleLines_2.FindLast then begin
            LastEntryNo := HRShiftScheduleLines_2."Line No." + 1;
        end else begin
            LastEntryNo := 1;
        end;
    end;
}
