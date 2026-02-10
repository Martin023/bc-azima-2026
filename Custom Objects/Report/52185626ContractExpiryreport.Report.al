#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185626 "Contract Expiry report"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("HR Employees"; "HR Employees")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin


                DaystoProbaton := "HR Employees"."End Of Probation Date" - Today;
                //MESSAGE(FORMAT(DaystoProbaton));

                HREmp.Reset;
                HREmp.SetRange(HREmp."No.", "No.");
                HREmp.SetRange(HREmp.Status, HREmp.Status::Active);
                if HREmp.Find('-') then
                  //MESSAGE(FORMAT(DaystoProbaton));

                  begin
                    if DaystoProbaton > 20 then
                        repeat
                        // smtp.CreateMessage('Dear' + ' ' + "HR Employees"."No." + ',' + 'Probation Approval Notification', "HR Employees"."Company E-Mail", "HR Employees"."Company E-Mail",
                        //    'Probation End date Notification', 'Your probation period will be coming to an end,' + '' + Format("HR Employees"."ID Number") + '  ' +
                        //     "HR Employees"."Full Name" + ' ', true);
                        // smtp.Send();
                        until HREmp.Next = 0;
                    //MESSAGE('mail sent');
                end
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

    var
        HREmp: Record "HR Employees";
        DaystoProbaton: Integer;
    //smtp: Codeunit 400;
}
