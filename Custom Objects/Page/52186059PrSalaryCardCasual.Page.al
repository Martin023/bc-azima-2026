page 52186059 "PrSalary Card Casual"
{
    // strempcode,dtDOE,curbasicpay,blnpaye,blnnssf,blnnhif,selectedperio,dtopenperio,
    // membership,referenceno,dttermination,blngetspayereleif

    Editable = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Navigate,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "HR Employees";
    ApplicationArea = Basic, Suite;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group("Employee Details")
            {
                Caption = 'Employee Details';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    Enabled = true;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
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
                    Editable = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Full / Part Time"; Rec."Full / Part Time")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = true;
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employee Classification"; Rec."Employee Classification")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Main Bank"; Rec."Main Bank")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Branch Bank"; Rec."Branch Bank")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bank Account Number"; Rec."Bank Account Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'ID Number';
                }
                field("PIN No."; Rec."PIN No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'PIN No.';
                }
                field("NHIF No."; Rec."NHIF No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Hr Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posting Group';
                    Editable = true;
                }
            }
            part("Basic Pay"; "prSalary Info Casual")
            {
                Caption = 'Basic Pay';
                SubPageLink = "Employee Code" = FIELD("No.");
                ApplicationArea = Basic, Suite;
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
                separator(Action1102756016)
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
                separator(Action1102756059)
                {
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
                action("Salary Ledger")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Salary Ledger';
                    Image = Trace;
                    Promoted = true;
                    PromotedCategory = Category7;
                    RunObject = Page "prSalary Arrears";
                    RunPageLink = "Employee Code" = FIELD("No.");
                }
                separator(Action1102756009)
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
                separator(Action1102756011)
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
                separator(Action1102756013)
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
                separator(Action1102756000)
                {
                }
                action("Basic Salary Arrears")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Basic Salary Arrears';
                    Image = CalculateRegenerativePlan;
                    RunObject = Page "prStaff Dimensions";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    Visible = false;
                }
                action("Salary Information")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Salary Information';

                    trigger OnAction()
                    var
                        PrSalaryInfo: Record "PR Salary Card";
                    begin
                        //PrSalaryInfo.reset;
                        if PrSalaryInfo.Get(Rec."No.") then
                            PAGE.Run(PAGE::"PR Salary Information", PrSalaryInfo)
                        else begin
                            PrSalaryInfo.Init;
                            PrSalaryInfo."Employee Code" := Rec."No.";
                            PrSalaryInfo.Insert(true);
                            PAGE.Run(PAGE::"PR Salary Information", PrSalaryInfo)
                        end
                    end;
                }
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
                    /*
                    SalCard.SETRANGE("Employee Code","No.");
                    SalCard.SETRANGE(SalCard."Period Filter",SelectedPeriod);
                    //REPORT.Run(52185902,TRUE,FALSE,SalCard);
                    */
                    HrEmployee.Reset;
                    HrEmployee.SetRange(HrEmployee."No.", Rec."No.");
                    HrEmployee.SetRange(HrEmployee."Current Month Filter", SelectedPeriod);
                    //REPORT.Run(52185642, true, false, HrEmployee);

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

                    //For Multiple Payroll
                    if ContrInfo."Multiple Payroll" then begin
                        PayrollDefined := '';
                        PayrollType.Reset;
                        PayrollType.SetCurrentKey(EntryNo);
                        if PayrollType.FindFirst then begin
                            NoofRecords := PayrollType.Count;
                            i := 0;
                            repeat
                                i += 1;
                                PayrollDefined := PayrollDefined + '&' + PayrollType."Payroll Code";
                                if i < NoofRecords then
                                    PayrollDefined := PayrollDefined + ','
                            until PayrollType.Next = 0;
                        end;


                        Selection := StrMenu(PayrollDefined, NoofRecords);
                        PayrollType.Reset;
                        PayrollType.SetRange(PayrollType.EntryNo, Selection);
                        if PayrollType.Find('-') then begin
                            PayrollCode := PayrollType."Payroll Code";
                        end;
                    end;
                    //End Multiple Payroll

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
                                //  ProcessPayroll.fnProcesspayroll(HrEmployee."No.",HrEmployee."Date Of Join",TotalPay,SalCard."Pays PAYE"
                                //      ,SalCard."Pays NSSF",SalCard."Pays NHIF",SelectedPeriod,SelectedPeriod,'','',
                                //    //hosea  //HrEmployee."Date Of Leaving",TRUE,HrEmployee."Department Code",PayrollCode);
                                //      HrEmployee."Date Of Leaving",TRUE,HrEmployee."Department Code",SalCard."Insurance Ceritifacte?");
                            end;
                        until HrEmployee.Next = 0;
                        ////Progress Window
                        ProgressWindow.Close;
                    end;
                    //CODEUNIT

                    Commit;

                    /*
                    SalCard.RESET;
                    SalCard.SETRANGE("Employee Code","No.");
                    SalCard.SETRANGE(SalCard."Period Filter",SelectedPeriod);
                    //REPORT.Run(52185902,TRUE,FALSE,SalCard);
                    */
                    HrEmployee.Reset;
                    HrEmployee.SetRange(HrEmployee."No.", Rec."No.");
                    HrEmployee.SetRange(HrEmployee."Current Month Filter", SelectedPeriod);
                    //REPORT.Run(52185642, true, false, HrEmployee);

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

                    //SalCard.GET("No.");

                    //For Multiple Payroll
                    if ContrInfo."Multiple Payroll" then begin
                        PayrollDefined := '';
                        PayrollType.Reset;
                        PayrollType.SetCurrentKey(EntryNo);
                        if PayrollType.FindFirst then begin
                            NoofRecords := PayrollType.Count;
                            i := 0;
                            repeat
                                i += 1;
                                PayrollDefined := PayrollDefined + '&' + PayrollType."Payroll Code";
                                if i < NoofRecords then
                                    PayrollDefined := PayrollDefined + ','
                            until PayrollType.Next = 0;
                        end;

                        Selection := StrMenu(PayrollDefined, NoofRecords);
                        PayrollType.Reset;
                        PayrollType.SetRange(PayrollType.EntryNo, Selection);
                        if PayrollType.Find('-') then begin
                            PayrollCode := PayrollType."Payroll Code";
                        end;
                    end;
                    //End Multiple Payroll

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
                    if ContrInfo."Multiple Payroll" then
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
                                    //ProgressWindow.UPDATE(1,HrEmployee."No."+':'+HrEmployee."First Name"+' '+HrEmployee."Middle Name"+' '+HrEmployee."Last Name");

                                    if SalCard.Get(HrEmployee."No.") then begin

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


                                        HrEmployee.TestField(HrEmployee."Date Of Join");
                                        //      ProcessPayroll.fnProcesspayroll(HrEmployee."No.",HrEmployee."Date Of Join",TotalPay,SalCard."Pays PAYE"
                                        //          ,SalCard."Pays NSSF",SalCard."Pays NHIF",SelectedPeriod,SelectedPeriod,'','',
                                        //          //hosea //HrEmployee."Date Of Leaving",TRUE,HrEmployee."Department Code",PayrollCode);
                                        //          HrEmployee."Date Of Leaving",TRUE,HrEmployee."Department Code",SalCard."Insurance Ceritifacte?");
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

                    /*
                    SalCard.RESET;
                    SalCard.SETRANGE("Employee Code","No.");
                    SalCard.SETRANGE(SalCard."Period Filter",SelectedPeriod);
                    //REPORT.Run(52185902,TRUE,FALSE,SalCard);
                    */

                end;
            }
            action("Update Basic Info")
            {
                ApplicationArea = Basic, Suite;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    PrsalCard: Record "prSalary Card Casual";
                begin

                    if Confirm('Update Basic Infor?', true) = false then exit;

                    PrsalCard.Reset;
                    PrsalCard.SetRange(PrsalCard."Employee Code", Rec."No.");
                    if PrsalCard.Find('-') = false then begin
                        PrsalCard.Init;
                        PrsalCard."Employee Code" := Rec."No.";
                        PrsalCard.Insert;
                    end
                    else
                        Error('Basic information for this employee has already been updated');
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        DepName := '';
        DValues.Reset;
        DValues.SetRange(DValues.Code, Rec."Department Code");
        if DValues.Find('-') then
            DepName := DValues.Name;
    end;

    trigger OnInit()
    begin
        PayrollCode := '';

        USetup.Reset;
        USetup.SetRange(USetup."User ID", UserId);
        if USetup.Find('-') then
            //PayrollCode:=USetup."Payroll Code";

            Rec.SetFilter("Payroll Code", PayrollCode);

        objPeriod.Reset;
        objPeriod.SetRange(objPeriod.Closed, false);
        if objPeriod.Find('-') then begin
            SelectedPeriod := objPeriod."Date Opened";
            PeriodName := objPeriod."Period Name";
            PeriodMonth := objPeriod."Period Month";
            PeriodYear := objPeriod."Period Year";
        end;
    end;

    trigger OnOpenPage()
    begin
        CurrPage.Editable := true;
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
        USetup: Record "User Setup";
        NormalHrs: Decimal;
        OvertimeHrs: Decimal;
        PHSWkndHrs: Decimal;
        TotalPay: Decimal;
        CasualSetup: Record "PrCasual Payroll Setup";
}

