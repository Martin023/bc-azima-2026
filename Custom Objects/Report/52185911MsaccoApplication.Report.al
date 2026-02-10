#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185911 "Msacco Application"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Msacco Application.rdl';

    dataset
    {
        dataitem("M-SACCO Applications"; "M-SACCO Applications")
        {
            DataItemTableView = where(Status = filter(Approved));
            RequestFilterFields = No, "Application Type";
            column(ReportForNavId_1; 1)
            {
            }
            column(App_No; "M-SACCO Applications".No)
            {
            }
            column(Date; "M-SACCO Applications"."Document Date")
            {
            }
            column(App_Type; "M-SACCO Applications"."Application Type")
            {
            }
            column(Phone_NO; "M-SACCO Applications"."MPESA Mobile No")
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            dataitem(SavingsAccounts; "Savings Accounts")
            {
                DataItemLink = "No." = field("Account No");
                column(ReportForNavId_6; 6)
                {
                }
                column(Member_Name; SavingsAccounts.Name)
                {
                }
                column(Member_No; SavingsAccounts."Member No.")
                {
                }
            }

            trigger OnPreDataItem()
            begin
                Company.Get;
                Company.CalcFields(Picture);
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
        Company: Record "Company Information";
}
