#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185813 "Salary increment"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //NewBasicPay:=0;
                PrvitalSetup.Reset;
                PrvitalSetup.Get(PrvitalSetup."Setup Code");
                PrvitalSetup.TestField("Salary increment %");

                PRSalaryCard.Reset;
                PRSalaryCard.SetRange(PRSalaryCard."Employee Code", "No.");
                //UnknownTable "HR EMPLOYEES".SetRange(Status, Status::Active);
                if PRSalaryCard.Find('-') then begin
                    repeat
                        // MESSAGE(FORMAT(PrvitalSetup."Salary increment %"));
                        Increase := PrvitalSetup."Salary increment %" / 100 * PRSalaryCard."Basic Pay";
                        NewBasicPay := Increase + PRSalaryCard."Basic Pay";
                        // MESSAGE(FORMAT(NewBasicPay));
                        PRSalaryCard."Basic Pay" := NewBasicPay;
                        PRSalaryCard.Modify;
                    until PRSalaryCard.Next = 0;
                    Message('Salary increament Done');
                end;
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
        PrvitalSetup: Record "PR Vital Setup Info";
        PRSalaryCard: Record "PR Salary Card";
        Increase: Decimal;
        NewBasicPay: Decimal;
}
