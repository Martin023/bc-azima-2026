#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185953 "Insert Closure PF No"
{
    ProcessingOnly = true;

    dataset
    {
        // dataitem(Membershipclosure; UnknownTable52185824)
        // {
        //     column(ReportForNavId_1; 1)
        //     {
        //     }

        //     trigger OnAfterGetRecord()
        //     begin
        //         if Members.Get(Membershipclosure."Member No.") then begin
        //             Membershipclosure."Staff No." := Members."Payroll/Staff No.";
        //             Membershipclosure.Modify;
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
