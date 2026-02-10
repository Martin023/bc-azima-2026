#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185525 "PR Other PR Customers (Listin)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/PR Other PR Customers (Listin).rdl';

    dataset
    {
        dataitem("PR Period Transactions"; "PR Period Transactions")
        {
            RequestFilterFields = "Transaction Code", "Payroll Period", "Employee Code", "Department Code";

            column(EmployeeCode_PRPeriodTransactions; "PR Period Transactions"."Employee Code")
            {
            }
            column(TransactionCode_PRPeriodTransactions; "PR Period Transactions"."Transaction Code")
            {
            }
            column(Balance_PRperiodTransactions; "PR Period Transactions".Balance)
            {
            }
            column(TransactionName_PRPeriodTransactions; "PR Period Transactions"."Transaction Name")
            {
            }
            column(Amount_PRPeriodTransactions; "PR Period Transactions".Amount)
            {
            }
            column(SchemeCode_PRPeriodTransactions; "PR Period Transactions"."Global Dimension 1 Code")
            {
            }
            column(strEmpName; strEmpName)
            {
            }
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(CompInfoAddress; CompInfo.Address)
            {
            }
            column(CompInfoCity; CompInfo.City)
            {
            }
            column(CompInfoPicture; CompInfo.Picture)
            {
            }
            column(CompInfoEMail; CompInfo."E-Mail")
            {
            }
            column(CompInfoHomePage; CompInfo."Home Page")
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //CALCFIELDS(Gender);

                HREmp.Reset;
                if HREmp.Get("PR Period Transactions"."Employee Code") then begin
                    strEmpName := HREmp."Full Name";
                end;
            end;

            trigger OnPreDataItem()
            begin
                // OnViewCurrRec();
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
        fnCompanyInfo;

        PeriodFilter := "PR Period Transactions".GetFilter("Payroll Period");
        if PeriodFilter = '' then Error('Please Specify "Payroll Period" on the Request Page');
        SelectedPeriod := "PR Period Transactions".GetRangeMin("Payroll Period");

        PRPayrollPeriods.Reset;
        if PRPayrollPeriods.Get(SelectedPeriod) then PeriodName := PRPayrollPeriods."Period Name";
    end;

    var
        strEmpName: Text;
        HREmp: Record "HR Employees";
        CompInfo: Record "Company Information";
        PeriodName: Text[30];
        PeriodFilter: Text[30];
        PRPayrollPeriods: Record "PR Payroll Periods";
        SelectedPeriod: Date;


    procedure fnCompanyInfo()
    begin
        CompInfo.Reset;
        if CompInfo.Get then
            CompInfo.CalcFields(CompInfo.Picture);
    end;


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
