#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185622 "M-SACCO Report."
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/M-SACCO Report..rdl';

    dataset
    {
        dataitem("M-SACCO Applications."; "M-SACCO Applications")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(No; "M-SACCO Applications.".No)
            {
            }
            column(Date_Entered; "M-SACCO Applications."."Date Entered")
            {
            }
            column(CustomerNo; "M-SACCO Applications."."Customer ID No")
            {
            }
            column(CustomerName; "M-SACCO Applications."."Customer Name")
            {
            }
            column(MobileNo; "M-SACCO Applications."."MPESA Mobile No")
            {
            }
            column(Status; "M-SACCO Applications.".Status)
            {
            }
            column(Entr; "M-SACCO Applications."."Entered By")
            {
            }

            trigger OnAfterGetRecord()
            var
                STOpI: Codeunit "Gen. Jnl.-Post New";
            begin
                //STOpI.STOProcess(StandingOrderHeader,NextRunDate);
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
                field("Next Run Date:"; NextRunDate)
                {
                    ApplicationArea = Basic;
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

    var
        NextRunDate: Date;
}
