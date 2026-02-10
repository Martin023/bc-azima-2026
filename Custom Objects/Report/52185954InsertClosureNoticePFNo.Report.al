#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185954 "Insert Closure Notice PF No"
{
    ProcessingOnly = true;

    dataset
    {
        // dataitem(MemberWithdrawalNotice; UnknownTable52185826)
        // {
        //     column(ReportForNavId_1; 1)
        //     {
        //     }

        //     trigger OnAfterGetRecord()
        //     begin
        //         if Members.Get(MemberWithdrawalNotice."Member No.") then begin
        //             MemberWithdrawalNotice."Staff No." := Members."Payroll/Staff No.";
        //             MemberWithdrawalNotice.Modify;
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
