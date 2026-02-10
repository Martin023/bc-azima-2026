page 52186060 "PrSalary List Casual"
{
    CardPageID = "PrSalary Card Casual";
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Navigate,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "HR Employees";
    SourceTableView = WHERE(Status = FILTER(Active),
                            "Contract Type" = FILTER('CASUAL'));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Office; Rec.Office)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payment Mode"; Rec."Payment Mode")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Of Join"; Rec."Date Of Join")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Full / Part Time"; Rec."Full / Part Time")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Other Info")
            {
                Caption = 'Other Info';
                Visible = false;
                action("Cost Centers")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cost Centers';
                    Image = Dimensions;
                    RunObject = Page "prStaff Dimensions";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    Visible = false;
                }
                separator(Action1000000017)
                {
                }
                action("Banking Details")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Banking Details';
                    Image = BankAccount;
                    RunObject = Page "prEmployee Banks";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    Visible = false;
                }
                separator(Action1000000015)
                {
                }
                action("Pension Details")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pension Details';
                    Image = PlanningWorksheet;
                }
            }
            group(Transactions)
            {
                Caption = 'Transactions';
                action("Payroll Transactions")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payroll Transactions';
                    Image = Trace;
                    Promoted = true;
                    PromotedCategory = Category7;
                    RunObject = Page "PR Employee Transactions";
                    RunPageLink = "Employee Code" = FIELD("No.");
                }
                separator(Action1000000011)
                {
                }
                action("View Trans Codes")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'View Trans Codes';
                    Image = Track;
                    RunObject = Page "PR Bank Branches";
                    Visible = false;
                }
                separator(Action1000000009)
                {
                }
                action("Insurance Policies")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Insurance Policies';
                    Image = Insurance;
                    RunObject = Page "prEmployee Posting Group";
                    Visible = false;
                }
                separator(Action1000000007)
                {
                }
                action("Staff Loans")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Staff Loans';
                    Image = Loaner;
                    RunObject = Page "prEmployee Posting Group";
                    Visible = false;
                }
                separator(Action1000000005)
                {
                }
                action("Basic Salary Arrears")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Basic Salary Arrears';
                    Image = CalculateRegenerativePlan;
                    RunObject = Page "prSalary Arrears";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    RunPageView = SORTING("Employee Code", "Period Month", "Period Year");
                    Visible = false;
                }
            }
        }
        area(processing)
        {
            action("View Payslip")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'View Payslip';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Opened";

                    //CLEAR(objOcx);
                    //objOcx.fnMandatoryProcesses;
                    //Display payslip report
                    PRSalaryCard.SetRange("Employee Code", Rec."No.");
                    PRSalaryCard.SetRange(PRSalaryCard."Period Filter", SelectedPeriod);

                    //REPORT.Run(REPORT::"PR Individual Payslip", true, false, PRSalaryCard);
                end;
            }
            action("Process Current")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Process Current';
                Image = CalculatePlan;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ContrInfo.Get;
                    VitalInfo.Get('');

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Opened";

                    SalCard.Get(Rec."No.");

                    //Delete all Records from the prPeriod Transactions for Reprocessing
                    prPeriodTransactions.Reset;
                    prPeriodTransactions.SetRange(prPeriodTransactions."Employee Code", Rec."No."); //PKK
                    if ContrInfo."Multiple Payroll" then
                        prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Code", PayrollCode);
                    prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Period", SelectedPeriod);
                    if prPeriodTransactions.Find('-') then
                        prPeriodTransactions.DeleteAll;

                    //Delete all Records from prEmployer Deductions
                    prEmployerDeductions.Reset;
                    prEmployerDeductions.SetRange(prEmployerDeductions."Employee Code", Rec."No."); //PKK
                    if ContrInfo."Multiple Payroll" then
                        prEmployerDeductions.SetRange(prEmployerDeductions."Payroll Code", PayrollCode);

                    prEmployerDeductions.SetRange(prEmployerDeductions."Payroll Period", SelectedPeriod);
                    if prEmployerDeductions.Find('-') then
                        prEmployerDeductions.DeleteAll;

                    //Use CODEUNIT
                    HrEmployee.Reset;
                    HrEmployee.SetRange(HrEmployee.Status, HrEmployee.Status::Active);
                    //PKK - PROCESS CURRENT ONLY
                    HrEmployee.SetRange(HrEmployee."No.", Rec."No.");
                    //PKK - PROCESS CURRENT ONLY
                    if ContrInfo."Multiple Payroll" then
                        HrEmployee.SetRange(HrEmployee."Payroll Code", PayrollCode);
                    //HrEmployee.SETRANGE(HrEmployee."No.",'CSS0005');
                    if HrEmployee.Find('-') then begin
                        //Progress Window
                        ProgressWindow.Open('Processing Salary for Employee No. #1#######');
                        repeat
                            //Progress Window
                            Sleep(100);
                            //Progress Window
                            //Suspended
                            if not SalCard."Suspend Pay" then begin
                                ProgressWindow.Update(1, HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' + HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name");
                                if SalCard.Get(HrEmployee."No.") then

                                    //Compute Casual Basic Pay
                                    CasualSetup.Reset;
                                if CasualSetup.Get() then begin
                                    NormalHrs := SalCard."Hours Worked" * CasualSetup."Normal Hours Rate per Hour";
                                    OvertimeHrs := SalCard."Overtime Hours" * CasualSetup."Overtime Hours Rate per Hour";
                                    PHSWkndHrs := SalCard."Public Holidays&Weekend Hours" * CasualSetup."PHs and Weekends Rate per Hour";
                                    TotalPay := NormalHrs + OvertimeHrs + PHSWkndHrs;
                                end;
                                //Compute Casual Basic Pay


                                HrEmployee.TestField(HrEmployee."Date Of Join");
                                HrEmployee.TestField(HrEmployee."Date Of Join");
                                //  ProcessPayroll.fnProcesspayroll(HrEmployee."No.",HrEmployee."Date Of Join",TotalPay,SalCard."Pays PAYE"
                                //      ,SalCard."Pays NSSF",SalCard."Pays NHIF",SelectedPeriod,SelectedPeriod,'','',
                                //       HrEmployee."Date Of Leaving",TRUE,HrEmployee."Department Code",SalCard."Insurance Ceritifacte?");
                                //hosea   //HrEmployee."Date Of Leaving",TRUE,HrEmployee."Department Code",PayrollCode,SalCard."Insurance Ceritifacte?");
                            end;
                        until HrEmployee.Next = 0;
                        ////Progress Window
                        ProgressWindow.Close;
                    end;
                    //CODEUNIT

                    Commit;

                    PRSalaryCard.SetRange("Employee Code", Rec."No.");
                    PRSalaryCard.SetRange(PRSalaryCard."Period Filter", SelectedPeriod);

                    //REPORT.Run(REPORT::"PR Individual Payslip", true, false, PRSalaryCard);
                end;
            }
            action("Process Payroll")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Process Payroll';
                Image = CalculateCalendar;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ContrInfo.Get;

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then;
                    SelectedPeriod := objPeriod."Date Opened";


                    //Delete all Records from the prPeriod Transactions for Reprocessing
                    prPeriodTransactions.Reset;
                    if ContrInfo."Multiple Payroll" then
                        prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Code", PayrollCode);
                    prPeriodTransactions.SetRange(prPeriodTransactions."Payroll Period", SelectedPeriod);
                    if prPeriodTransactions.Find('-') then
                        prPeriodTransactions.DeleteAll;

                    //Delete all Records from prEmployer Deductions
                    prEmployerDeductions.Reset;
                    if ContrInfo."Multiple Payroll" then
                        prEmployerDeductions.SetRange(prEmployerDeductions."Payroll Code", PayrollCode);
                    prEmployerDeductions.SetRange(prEmployerDeductions."Payroll Period", SelectedPeriod);
                    if prEmployerDeductions.Find('-') then
                        prEmployerDeductions.DeleteAll;

                    //Use CODEUNIT
                    HrEmployee.Reset;
                    HrEmployee.SetRange(HrEmployee.Status, HrEmployee.Status::Active);
                    //IF ContrInfo."Multiple Payroll" THEN
                    HrEmployee.SetRange(HrEmployee."Payroll Code", PayrollCode);
                    if HrEmployee.Find('-') then begin
                        //Progress Window
                        ProgressWindow.Open('Processing Salary for Employee No. #1#######');
                        repeat
                            //Progress Window
                            Sleep(100);
                            //Progress Window
                            //Suspended
                            if SalCard.Get(HrEmployee."No.") then begin
                                if not SalCard."Suspend Pay" then begin
                                    HrEmployee.TestField(HrEmployee."Date Of Join");
                                    //PKProgressWindow.UPDATE(1,HrEmployee."No."+':'+HrEmployee."First Name"+' '+HrEmployee."Middle Name"+' '+HrEmployee."Last Name");

                                    //Compute Casual Basic Pay
                                    CasualSetup.Reset;
                                    if CasualSetup.Get() then begin
                                        NormalHrs := 0;
                                        OvertimeHrs := 0;
                                        PHSWkndHrs := 0;
                                        TotalPay := 0;
                                        NormalHrs := SalCard."Hours Worked" * CasualSetup."Normal Hours Rate per Hour";
                                        OvertimeHrs := SalCard."Overtime Hours" * CasualSetup."Overtime Hours Rate per Hour";
                                        PHSWkndHrs := SalCard."Public Holidays&Weekend Hours" * CasualSetup."PHs and Weekends Rate per Hour";
                                        TotalPay := NormalHrs + OvertimeHrs + PHSWkndHrs;
                                    end;
                                    //Compute Casual Basic Pay

                                    if SalCard.Get(HrEmployee."No.") then begin
                                        HrEmployee.TestField(HrEmployee."Date Of Join");
                                        //  ProcessPayroll.fnProcesspayroll(HrEmployee."No.",HrEmployee."Date Of Join",TotalPay,SalCard."Pays PAYE"
                                        //      ,SalCard."Pays NSSF",SalCard."Pays NHIF",SelectedPeriod,SelectedPeriod,'','',
                                        //   //hosea//    HrEmployee."Date Of Leaving",TRUE,HrEmployee."Department Code",PayrollCode,SalCard."Insurance Ceritifacte?");
                                        //      HrEmployee."Date Of Leaving",TRUE,HrEmployee."Department Code",SalCard."Insurance Ceritifacte?");
                                    end;
                                end;
                            end;

                            ProgressWindow.Update(1, HrEmployee."No." + ':' + HrEmployee."First Name" + ' ' + HrEmployee."Middle Name" + ' ' + HrEmployee."Last Name");

                        until HrEmployee.Next = 0;
                        ////Progress Window
                        ProgressWindow.Close;
                    end;
                    //CODEUNIT

                    Message('Payroll processing completed successfully.');
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        /*
        IF UserMgt.GetPurchasesFilter <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center",UserMgt.GetPurchasesFilter);
          FILTERGROUP(0);
        END;
        */

        UserSetup.Get(UserId);
        //hosea
        //SETRANGE("Payroll Code",UserSetup."Payroll Code");

    end;

    var
        objEmp: Record "HR Employees";
        SalCard: Record "prSalary Card Casual";
        objPeriod: Record "PR Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodMonth: Integer;
        PeriodYear: Integer;
        HrEmployee: Record "HR Employees";
        Employee: Record "HR Employees";
        ProgressWindow: Dialog;
        prPeriodTransactions: Record "PR Period Transactions";
        prEmployerDeductions: Record "prEmployer Deductions";
        PayrollType: Record "prPayroll Type";
        Selection: Integer;
        PayrollDefined: Text[30];
        PayrollCode: Code[10];
        NoofRecords: Integer;
        i: Integer;
        ContrInfo: Record "Control-Information";
        DepName: Text[200];
        DValues: Record "Dimension Value";
        VitalInfo: Record "PR Vital Setup Info";
        UserSetup: Record "User Setup";
        User: Code[100];
        NormalHrs: Decimal;
        OvertimeHrs: Decimal;
        PHSWkndHrs: Decimal;
        TotalPay: Decimal;
        CasualSetup: Record "PrCasual Payroll Setup";
        PRSalaryCard: Record "PR Salary Card";
}

