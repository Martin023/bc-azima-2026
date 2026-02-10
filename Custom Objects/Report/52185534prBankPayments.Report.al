#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185534 "prBank Payments"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/prBank Payments.rdl';

    dataset
    {
        dataitem("PR Bank Branches"; "PR Bank Branches")
        {
            RequestFilterFields = "Branch Code", "Branch Name";
            column(ReportForNavId_4233; 4233)
            {
            }
            column(GETFILTERS; "PR Bank Branches".GetFilters)
            {
            }
            column(USERID; UserId)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            //column(CurrReport_PAGENO; CurrReport.PageNo)
            //{
            //}
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(prBank_Structure__Bank_Code_; "Branch Code")
            {
            }
            column(prBank_Structure__Branch_Code_; "Branch Name")
            {
            }
            column(prBank_Structure__Bank_Name_; "Bank Code")
            {
            }
            column(prBank_Structure__Branch_Name_; "Bank Name")
            {
            }
            column(TotTaxablePay; TotTaxablePay)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Bank_Payment_ScheduleCaption; Bank_Payment_ScheduleCaptionLbl)
            {
            }
            column(BankCaption; BankCaptionLbl)
            {
            }
            column(BranchCaption; BranchCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(Employee_NameCaption; Employee_NameCaptionLbl)
            {
            }
            column(Account_No_Caption; Account_No_CaptionLbl)
            {
            }
            column(Net_AmountCaption; Net_AmountCaptionLbl)
            {
            }
            column(Employee_BankCaption; Employee_BankCaptionLbl)
            {
            }
            column(Bank_BranchCaption; Bank_BranchCaptionLbl)
            {
            }
            column(Total_Caption; Total_CaptionLbl)
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
            dataitem("HR EMPLOYEES"; "HR EMPLOYEES")
            {
                DataItemLink = "Main Bank" = field("Branch Code"), "Branch Bank" = field("Branch Name");
                DataItemTableView = sorting("No.") order(ascending);
                column(ReportForNavId_8631; 8631)
                {
                }
                column(HR_Employee_No_; "No.")
                {
                }
                column(HR_Employee_Main_Bank; "Main Bank")
                {
                }
                column(HR_Employee_Branch_Bank; "Branch Bank")
                {
                }
                dataitem("PR Salary Card"; "PR Salary Card")
                {
                    DataItemLink = "Employee Code" = field("No.");
                    RequestFilterFields = "Period Filter", "Identification Number", "Mobile Number", Nationality, "Date of Birth", "Scheme Code 2";
                    column(ReportForNavId_6207; 6207)
                    {
                    }
                    column(prSalary_Card__prSalary_Card___Employee_Code_; "PR Salary Card"."Employee Code")
                    {
                    }
                    column(EmployeeName; EmployeeName)
                    {
                    }
                    column(TaxablePay; TaxablePay)
                    {
                    }
                    column(bankAcc; bankAcc)
                    {
                    }
                    column(mainBankNM; mainBankNM)
                    {
                    }
                    column(BranchBankNM; BranchBankNM)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //  bankAcc:='';
                        //  mainBankNM:='';
                        //  BranchBankNM:='';

                        objEmp.Reset;
                        objEmp.SetRange(objEmp."No.", "Employee Code");
                        if objEmp.Find('-') then
                            EmployeeName := objEmp."First Name" + ' ' + objEmp."Middle Name" + ' ' + objEmp."Last Name";

                        //Bank Details
                        bankAcc := objEmp."Bank Account Number";

                        bankStruct.Reset;
                        bankStruct.SetRange(bankStruct."Branch Code", objEmp."Main Bank");
                        bankStruct.SetRange(bankStruct."Branch Name", objEmp."Branch Bank");
                        if bankStruct.Find('-') then begin
                            mainBankNM := bankStruct."Bank Code";
                            BranchBankNM := bankStruct."Bank Name";
                        end;

                        PeriodTrans.Reset;
                        PeriodTrans.SetRange(PeriodTrans."Employee Code", "Employee Code");
                        PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);

                        TaxablePay := 0;
                        if PeriodTrans.Find('-') then
                            repeat
                                //TXBP Taxable Pay -  BY DENNIS
                                if (PeriodTrans."Transaction Code" = 'NPAY') then begin
                                    TaxablePay := PeriodTrans.Amount;
                                end;
                            until PeriodTrans.Next = 0;

                        TotTaxablePay := TotTaxablePay + TaxablePay;
                        TotPayeAmount := TotPayeAmount + PayeAmount;
                    end;
                }
            }

            trigger OnAfterGetRecord()
            begin
                TotTaxablePay := 0;
            end;

            trigger OnPreDataItem()
            begin
                //     OnViewCurrRec();
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
        PeriodFilter := "PR Salary Card".GetFilter("Period Filter");
        if PeriodFilter = '' then Error('You must specify the period filter');

        SelectedPeriod := "PR Salary Card".GetRangeMin("Period Filter");
        objPeriod.Reset;
        if objPeriod.Get(SelectedPeriod) then PeriodName := objPeriod."Period Name";


        if companyinfo.Get() then
            companyinfo.CalcFields(companyinfo.Picture);
    end;

    var
        PeriodTrans: Record "PR Period Transactions";
        PayeAmount: Decimal;
        TotPayeAmount: Decimal;
        TaxablePay: Decimal;
        TotTaxablePay: Decimal;
        EmployeeName: Text[200];
        PinNumber: Text[30];
        objPeriod: Record "PR Payroll Periods";
        objEmp: Record "HR Employees";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodFilter: Text[30];
        companyinfo: Record "Company Information";
        bankStruct: Record "PR Bank Branches";
        bankAcc: Text[50];
        BranchBankNM: Text[100];
        mainBankNM: Text[100];
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Bank_Payment_ScheduleCaptionLbl: label 'Bank Payment Schedule';
        BankCaptionLbl: label 'Bank';
        BranchCaptionLbl: label 'Branch';
        No_CaptionLbl: label 'No:';
        Employee_NameCaptionLbl: label 'Employee Name';
        Account_No_CaptionLbl: label 'Account No.';
        Net_AmountCaptionLbl: label 'Net Amount';
        Employee_BankCaptionLbl: label 'Employee Bank';
        Bank_BranchCaptionLbl: label 'Bank Branch';
        Total_CaptionLbl: label 'Total:';
        Prepared_by_______________________________________Date_________________CaptionLbl: label 'Prepared by……………………………………………………..                 Date……………………………………………';
        Checked_by________________________________________Date_________________CaptionLbl: label 'Checked by…………………………………………………..                   Date……………………………………………';
        Authorized_by____________________________________Date_________________CaptionLbl: label 'Authorized by……………………………………………………..              Date……………………………………………';
        Approved_by______________________________________Date_________________CaptionLbl: label 'Approved by……………………………………………………..                Date……………………………………………';


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
