report 52186370 "Leave Costing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Leave Costing.rdl';
    dataset

    {
        dataitem("PR Period Transactions"; "PR Period Transactions")
        {
            RequestFilterFields = "Employee Code", "Transaction Code";
            DataItemTableView = where ("Transaction Code" = CONST('E006'));
            column(ReportForNavId_7769; 7769)
            {
            }
            column(HideBalance; HideBalance)
            {
            }
            column(CI_Name; CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address; CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2; CI."Address 2")
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo; CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Picture; CI.Picture)
            {
                IncludeCaption = true;
            }
            column(CI_City; CI.City)
            {
                IncludeCaption = true;
            }
            column(USERID; UserId)
            {
            }
            column(TODAY; Today)
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            //column(CurrReport_PAGENO; CurrReport.PageNo)
            //{
            //}
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(prPeriod_Transactions__Group_Text_; "Group Text")
            {
            }
            column(prPeriod_Transactions_Amount; Amount)
            {
            }
            column(prPeriod_Transactions__Transaction_Name_; "Transaction Name")
            {
            }
            column(TotalsAllowances; TotalsAllowances)
            {
            }
            column(TOTAL_ALLOWANCES_; 'TOTAL ALLOWANCES')
            {
            }
            column(Allowances_ReportCaption; Allowances_ReportCaptionLbl)
            {
            }
            column(User_Name_Caption; User_Name_CaptionLbl)
            {
            }
            column(Print_Date_Caption; Print_Date_CaptionLbl)
            {
            }
            column(Period_Caption; Period_CaptionLbl)
            {
            }
            column(Page_No_Caption; Page_No_CaptionLbl)
            {
            }
            column(Transaction_Name_Caption; Transaction_Name_CaptionLbl)
            {
            }
            column(Period_Amount_Caption; Period_Amount_CaptionLbl)
            {
            }
            column(Prepared_by_______________________________________Date_________________Caption; Prepared_by_______________________________________Date_________________CaptionLbl)
            {
            }
            column(Checked_by________________________________________Date_________________Caption; Checked_by________________________________________Date_________________CaptionLbl)
            {
            }
            column(Authorized_by____________________________________Date_________________Caption; Authorized_by____________________________________Date_________________CaptionLbl)
            {
            }
            column(Approved_by______________________________________Date_________________Caption; Approved_by______________________________________Date_________________CaptionLbl)
            {
            }
            column(prPeriod_Transactions_Employee_Code; "Employee Code")
            {
            }
            column(prPeriod_Transactions_Transaction_Code; "Transaction Code")
            {
            }
            column(prPeriod_Transactions_Period_Month; "Period Month")
            {
            }
            column(prPeriod_Transactions_Period_Year; "Period Year")
            {
            }
            //column(prPeriod_Transactions_Membership; Membership)
            //{
            //}
            column(prPeriod_Transactions_Reference_No; "Reference No")
            {
            }
            column(prPeriod_Transactions_Group_Order; "Group Order")
            {
            }
            column(prPeriod_Transactions_Department_Code; "Department Code")
            {
            }
            column(EmployeeName; EmployeeName)
            {
            }
            column(Period; "PR Period Transactions"."Payroll Period")
            {
            }
            column(Balance_PRPeriodTransactions; "PR Period Transactions".Balance)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "PR Period Transactions".SetRange("Payroll Period", SelectedPeriod);
                //"prPeriod Transactions".SETFILTER("Group Order",'=1|3');
                //"prPeriod Transactions".SETFILTER("prPeriod Transactions"."Sub Group Order",'=2');
                if Amount <= 0 then
                    CurrReport.Skip;

                if "PR Period Transactions"."Payroll Period" <> SelectedPeriod then
                    CurrReport.Skip;

                Employees.Reset;
                if Employees.Get("Employee Code") then
                    EmployeeName := Employees."First Name" + ' ' + Employees."Middle Name" + ' ' + Employees."Last Name"
                else
                    EmployeeName := ' ';
            end;

            trigger OnPreDataItem()
            begin
                //OnViewCurrRec();
                LastFieldNo := "PR Period Transactions".FieldNo("Period Year");
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
                field(SelectedPeriod; SelectedPeriod)
                {
                    ApplicationArea = Basic;
                    Caption = 'Selected Period';
                    TableRelation = "PR Payroll Periods";
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

    trigger OnPreReport()
    begin
        if SelectedPeriod = 0D then Error('You must specify the period filter');

        objPeriod.Reset;
        objPeriod.SetRange(objPeriod."Date Opened", SelectedPeriod);
        if objPeriod.Find('-') then begin
            PeriodName := objPeriod."Period Name";
        end;


        if CI.Get() then
            CI.CalcFields(CI.Picture);
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: label 'Total for ';
        PeriodTrans: Record "PR Period Transactions";
        GroupOrder: label '3';
        objPeriod: Record "PR Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        CompanyInfo: Record "Company Information";
                TotalsAllowances: Decimal;
        Dept: Boolean;
        Allowances_ReportCaptionLbl: label 'Allowances Report';
        User_Name_CaptionLbl: label 'User Name:';
        Print_Date_CaptionLbl: label 'Print Date:';
        Period_CaptionLbl: label 'Period:';
        Page_No_CaptionLbl: label 'Page No:';
        Transaction_Name_CaptionLbl: label 'Transaction Name:';
        Period_Amount_CaptionLbl: label 'Period Amount:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared by……………………………………………………..                 Date……………………………………………';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked by…………………………………………………..                   Date……………………………………………';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized by……………………………………………………..              Date……………………………………………';
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved by……………………………………………………..                Date……………………………………………';
        Employees: Record "HR Employees";
        EmployeeName: Text[100];
        CI: Record "Company Information";
        ID: Integer;
        HideBalance: Boolean;
}

    /*
    {
        dataitem(Hremployees; "Hr employees")
        {
            RequestFilterFields = "No.", "Department Code", "Responsibility Center";
            column(No; "No.")
            {
            }
            column(FullName; "Full Name")
            {
            }
            Column(Monthly_Leave_Days; "Monthly Leave Days")
            {

            }
            column(Reimbursed_Leave_Days; "Reimbursed Leave Days")
            {

            }
            column("LeaveCost"; Cost)
            {

            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(PFNo; "PF No.")
            {
            }
            column(DepartmentCode; "Department Code")
            {
            }
            column(ResponsibilityCenter; "Responsibility Center")
            {
            }
            column(DepartmentName; DepartmentName)
            {
            }
            dataitem("PR Salary Card"; "PR Salary Card")
            {
                DataItemLink = "Employee Code" = field("No.");
                column(Basic_Pay; "Basic Pay")
                {

                }

            }
            trigger OnAfterGetRecord()
            var
                PRSalaryCard: Record "PR Salary Card";
                HrEmp: Record "HR Employees";
                strExtractedFrml: Text[250];
                curTransAmount: Decimal;
                EmpCode: code[20];
                intMonth: Integer;
                intYear: Integer;
                Bpay: Text[200];
                Extract: text;

            begin
                cost := 0;
                curTransAmount := 0;
                DepartmentName := '';
                
                HREmp.Reset;
                if HrEmp.Get("No.") then begin
                    HrEmp.CalcFields("Reimbursed Leave Days");
                    
                    if ResponsibilityCenterRec.Get(HrEmp."Responsibility Center") then
                        DepartmentName := ResponsibilityCenterRec.Name;
                    
                    PRSalaryCard.reset();
                    PRSalaryCard.setrange("Employee Code", HrEmp."No.");
                    if PRSalaryCard.FindSet() then begin
                        EmpCode := HrEmp."No.";
                        intMonth := Date2DMY(today, 2);
                        Intyear := Date2DMY(today, 3);
                        curTransAmount := 0;
                        strExtractedFrml := '';
                        if HrSetup.get() then
                            IF COPYSTR(HrSEtup.Formula, 3, 4) = 'BPAY' then
                                Bpay := CopyStr(HrSEtup.Formula, 1, 1) + Format(PRSalaryCard."Basic Pay") + CopyStr(HrSEtup.Formula, 8, 12);
                        curTransAmount := ROUND(Payroll.fnFormulaResult(Bpay), 1, '<');
                        Cost := Round((curTransAmount * (HrEmp."Monthly Leave Days" + HrEmp."Reimbursed Leave Days")), 0.01, '<');
                    end;
                end;
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
                group(Period)
                {

                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;









    var
        Formula: decimal;
        Month: Integer;
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        HrSEtup: record "HR Setup";
        Payroll: codeunit "PR Payroll Processing";
        Cost: decimal;
        DepartmentName: Text[100];
        ResponsibilityCenterRec: Record "Responsibility CenterBR";
}

*/
