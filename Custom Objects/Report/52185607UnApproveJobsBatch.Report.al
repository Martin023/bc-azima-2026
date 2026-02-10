#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185607 "UnApprove Jobs Batch"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("HR Jobs"; "HR Jobs")
        {
            DataItemTableView = where(Status = filter(Canceled));
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "HR Jobs".Status := "HR Jobs".Status::Open;
                "HR Jobs".Modify;
            end;

            trigger OnPostDataItem()
            begin
                Message('Process Complete');
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
}
