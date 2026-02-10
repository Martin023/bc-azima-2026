#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185777 "Helb Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Helb Report.rdl';

    dataset
    {
        dataitem("PR Period Transactions"; "PR Period Transactions")
        {
            //DataItemTableView = where("Transaction Code" = filter(D06));
            RequestFilterFields = "Payroll Period", "Transaction Code";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(Amount_PRPeriodTransactions; "PR Period Transactions".Amount)
            {
            }
            column(EmployeeCode_PRPeriodTransactions; "PR Period Transactions"."Employee Code")
            {
            }
            column(TransactionCode_PRPeriodTransactions; "PR Period Transactions"."Transaction Code")
            {
            }
            column(GroupText_PRPeriodTransactions; "PR Period Transactions"."Group Text")
            {
            }
            column(TransactionName_PRPeriodTransactions; "PR Period Transactions"."Transaction Name")
            {
            }
            column(Pic; CompInfo.Picture)
            {
            }
            column(RCount; RCount)
            {
            }
            column(TransName; "PR Period Transactions"."Transaction Name")
            {
            }
            column(Balance_PRPeriodTransactions; "PR Period Transactions".Balance)
            {
            }
            dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
            {
                DataItemLink = "No." = field("Employee Code");
                column(ReportForNavId_1000000006; 1000000006)
                {
                }
                column(IDNumber_HREmployees; "HR Employees"."ID Number")
                {
                }
                column(FullName_HREmployees; "HR Employees"."Full Name")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                RCount := RCount + 1;
            end;

            trigger OnPreDataItem()
            begin
                OnViewCurrRec;
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
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
        ObjEmp: Record "HR Employees";
        RCount: Integer;
        TransName: Text;


    procedure OnViewCurrRec()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestricViewTxt: label 'You do not have Permissions to VIEW,MODIFY or DELETE on this record. Contact system administrator for assistance. %';
    begin
        ChangePermission.Reset;
        ChangePermission.SetRange("User ID", UserId);
        ChangePermission.SetRange("View Payroll", true);
        ChangePermission.SetRange("Function Extended", ChangePermission."function extended"::"View Payroll");
        if not ChangePermission.Find('-') then
            Error(ErrorOnRestricViewTxt, UserId);
    end;
}
