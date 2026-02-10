#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185971 "Overtime Hours Worked1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Overtime Hours Worked1.rdl';

    dataset
    {
        dataitem("HR Employees"; "HR Employees")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(GlobalDimension1Name_HREmployees; "HR Employees"."Global Dimension 1 Name")
            {
            }
            column(FullName_HREmployees; "HR Employees"."Full Name")
            {
            }
            column(No_HREmployees; "HR Employees"."No.")
            {
            }
            column(CompanyInformationName; CompanyInformation.Name)
            {
            }
            column(CompanyInformationPicture; CompanyInformation.Picture)
            {
            }
            column(DepartmentName_HREmployees; "HR Employees"."Department Name")
            {
            }
            // dataitem(PREmployeeTransactions; PREmployeeTransactions)
            // {
            //     DataItemLink = "Employee Code" = field("No.");
            //     DataItemTableView = where("Transaction Code" = filter(E12 | E13));
            //     RequestFilterFields = "Employee Code", "Transaction Code", "Payroll Period";
            //     column(ReportForNavId_12; 12)
            //     {
            //     }
            //     column(Amount_PREmployeeTransactions; PREmployeeTransactions.Amount)
            //     {
            //     }
            //     column(NoofUnits_PREmployeeTransactions; PREmployeeTransactions."No of Units")
            //     {
            //     }
            //     column(PayrollPeriod_PREmployeeTransactions; PREmployeeTransactions."Payroll Period")
            //     {
            //     }
            //     column(TransactionName_PREmployeeTransactions; PREmployeeTransactions."Transaction Name")
            //     {
            //     }
            // }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
            }
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
        CompanyInformation.Get;
        CompanyInformation.CalcFields(Picture);
    end;

    var
        WeekendHours: Integer;
        Weekdayhours: Integer;
        weekendamount: Decimal;
        weekdayamount: Decimal;
        totalovertime: Decimal;
        CompanyInformation: Record "Company Information";
}
