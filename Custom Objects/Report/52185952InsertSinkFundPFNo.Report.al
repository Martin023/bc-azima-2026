#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185952 "Insert SinkFund PF No"
{
    ProcessingOnly = true;

    dataset
    {
        // dataitem(SinkFundInformation; UnknownTable52185940)
        // {
        //     column(ReportForNavId_1; 1)
        //     {
        //     }

        //     trigger OnAfterGetRecord()
        //     begin
        //         if Members.Get(SinkFundInformation."Member No") then begin
        //             SinkFundInformation."Staff No." := Members."Payroll/Staff No.";
        //             SinkFundInformation.Modify;
        //         end
        //     end;

        //     trigger OnPostDataItem()
        //     begin
        //         Message('Done!!!')
        //     end;
        // }
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
        Members: Record "Members";
}
