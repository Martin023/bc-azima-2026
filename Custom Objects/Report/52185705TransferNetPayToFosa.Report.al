#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185705 "Transfer Net Pay To Fosa"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("prSalary Card"; "PR Salary Card")
        {
            RequestFilterFields = "Period Filter", "Employee Code";


            trigger OnAfterGetRecord()
            begin
                LineNumber := LineNumber + 1;


                PeriodTrans.Reset;
                PeriodTrans.SetRange(PeriodTrans."Employee Code", "prSalary Card"."Employee Code");
                PeriodTrans.SetRange(PeriodTrans."Payroll Period", SelectedPeriod);
                PeriodTrans.SetRange(PeriodTrans."Group Text", 'NET PAY');
                if PeriodTrans.Find('-') then begin
                    REPEAT
                        //MESSAGE('Sal Amt %1 Acc %2',PeriodTrans.Amount,PeriodTrans."Employee Code");
                        SalaryPrLines.Init;
                        SalaryPrLines."No." := LineNumber;
                        //SalaryPrLines."Account No.":="prSalary Card"."Bank Account Number";
                        SalaryPrLines.VALIDATE(SalaryPrLines."Account No.");
                        SalaryPrLines."Employer Code" := EmployerCode;
                        SalaryPrLines."Staff No." := PeriodTrans."Employee Code";
                        SalaryPrLines.Validate(SalaryPrLines."Staff No.");
                        SalaryPrLines.Date := Today;
                        SalaryPrLines."Salary Header No." := SalHeader;
                        SalaryPrLines.Amount := PeriodTrans.Amount;
                        SalaryPrLines.Insert;
                    UNTIL PeriodTrans.NEXT = 0;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Salary Transfered Successfully');
            end;

            trigger OnPreDataItem()
            begin

                //  OnViewCurrRec();
                "Slip/Receipt No" := UpperCase(objPeriod."Period Name");

                SalheaderDet.Reset;
                SalheaderDet.SetRange(SalheaderDet.No, SalHeader);
                if SalheaderDet.Find('-') then begin
                    if SalheaderDet.Posted = true then
                        Error('Header already posted');
                end else
                    Error('Salary Header No %1 not found', SalHeader);

                SalaryPrLines.Reset;
                SalaryPrLines.SetRange(SalaryPrLines."Salary Header No.", SalHeader);
                if SalaryPrLines.Find('-') then
                    SalaryPrLines.DeleteAll;
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
                field(SalHeader; SalHeader)
                {
                    ApplicationArea = Basic;
                    Caption = 'Salary Header No';
                    TableRelation = "Salary Header".No where(Posted = filter(false));
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
        PeriodFilter := "prSalary Card".GetFilter("Period Filter");
        if PeriodFilter = '' then Error('You must specify the period filter');

        SelectedPeriod := "prSalary Card".GetRangeMin("Period Filter");
        objPeriod.Reset;
        if objPeriod.Get(SelectedPeriod) then begin
            PeriodName := objPeriod."Period Name";
            if objPeriod.Closed = true then Error('The Period %1 is Closed', objPeriod."Date Opened");
        end;
        PostingDate := CalcDate('1M-1D', SelectedPeriod);

        Employer.reset;
        Employer.SetRange("Internal Staff Employer", true);
        Employer.SetRange("Account Type", Employer."Account Type"::"Employer Code");
        if Employer.FindFirst() then
            EmployerCode := Employer."No.";
    end;

    var
        PeriodTrans: Record "PR Period Transactions";
        objEmp: Record "HR Employees";
        PeriodName: Text[30];
        PeriodFilter: Text[30];
        SelectedPeriod: Date;
        objPeriod: Record "PR Payroll Periods";
        "Slip/Receipt No": Code[50];
        LineNumber: Integer;
        TransCode: Record "PR Transaction Codes";
        PostingDate: Date;
        SalheaderDet: Record "Salary Header";
        SalaryPrLines: Record "Salary Lines";
        SalHeader: Code[20];
        Employer: record Customer;
        EmployerCode: Code[20];

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
