#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185505 "HR Shift Closure"
{
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("HR Shift Management"; "HR Shift Management")
        {
            DataItemTableView = where(Status = const(Open));
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "HR Shift Management".Status := "HR Shift Management".Status::Closed;
                "HR Shift Management".Modify;
            end;
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

    trigger OnPreReport()
    begin
        if Confirm('Do you want to Close all open shifts', false) = false then Error('Aborted');
    end;

    var
        ApplicationNoFilter: Code[10];
        Text2000: label 'Please enter shift no';
        HRShiftScheduleLines: Record "Master Record Creation Header";
        Counter: Integer;
}
