#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185506 "HR Suggest Participants"
{
    //DefaultLayout = RDLC;
    //RDLCLayout = './bc-azima-2026/Layout/HR Suggest Participants.rdl';
    ProcessingOnly = true;

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            DataItemTableView = where(Status = const(Active));
            RequestFilterFields = Gender, "Global Dimension 1 Code", "Global Dimension 2 Code";
            column(ReportForNavId_1; 1)
            {
            }
        }
        dataitem("HR Training App Lines"; "HR Training App Lines")
        {
            DataItemTableView = sorting("Line No.", "Application No.") order(ascending);
            column(ReportForNavId_2; 2)
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

    var
        ApplicationNoFilter: Code[10];
        HRShiftScheduleLines: Record "HR Training App Lines";
        Counter: Integer;

    local procedure fn_InsertEntries()
    begin
        /*
        HRShiftScheduleLines.INIT;
        
        HRShiftScheduleLines."Line No.":=fn_GetLastEntryNo;
        HRShiftScheduleLines.Code:=ApplicationNoFilter;
        HRShiftScheduleLines."Employee No.":="HR Employees"."No.";
        HRShiftScheduleLines.VALIDATE(HRShiftScheduleLines."Employee No.");
        
        HRShiftScheduleLines.INSERT;
        */

        HRShiftScheduleLines.Init;

        HRShiftScheduleLines."Line No." := fn_GetLastEntryNo;
        HRShiftScheduleLines."Application No." := ApplicationNoFilter;
        HRShiftScheduleLines."Employee No." := "HR Employees"."No.";
        HRShiftScheduleLines.Validate(HRShiftScheduleLines."Employee No.");

        HRShiftScheduleLines.Insert;

    end;

    local procedure fn_GetLastEntryNo() LastEntryNo: Integer
    var
        HRShiftScheduleLines_2: Record "HR Training App Lines";
    begin
        HRShiftScheduleLines_2.Reset;
        if HRShiftScheduleLines_2.FindLast then begin
            LastEntryNo := HRShiftScheduleLines_2."Line No." + 1;
        end else begin
            LastEntryNo := 1;
        end;
    end;
}
