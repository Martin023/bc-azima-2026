page 52185659 "PR Salary List (ALL)"
{
    CardPageID = "PR Header Salary Card - ALL";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Earnings/Deductions,Budgetary Control,Cancellation,Navigate,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "HR Employees";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    SourceTableView = where(Status = Const(Active));

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
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Of Join"; Rec."Date Of Join")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Employment Status';
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }
                field("Posting Group"; Rec."Posting Group")
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
            group(Transactions)
            {
                Caption = 'Transactions';
                action("Assign Earning/Deductions")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Assign Earning/Deductions';
                    Image = List;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "PR Employee Transactions";
                    RunPageLink = "Employee Code" = FIELD("No.");
                }
                // action("Salary Arrears")
                // {
                //     ApplicationArea = Basic, Suite;
                //     Caption = 'Salary Arrears';
                //     Image = SelectEntries;
                //     Promoted = true;
                //     PromotedCategory = Category4;
                //     PromotedIsBig = true;
                //     RunObject = Page "pr Salary Arrears";
                //     RunPageLink = "No." = FIELD("No.");
                // }
            }
        }
        area(processing)
        {
            action(ViewPayslip)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'View Payslip';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PRPeriod.Reset;
                    PRPeriod.SetRange(PRPeriod.Closed, false);
                    if PRPeriod.Find('-') then begin
                        SelectedPeriod := PRPeriod."Date Opened";
                    end else begin
                        Error('No Payroll period found');
                    end;

                    //Display payslip report
                    PRSalaryCard.reset;
                    PRSalaryCard.SetRange("Employee Code", Rec."No.");
                    PRSalaryCard.SetRange(PRSalaryCard."Period Filter", SelectedPeriod);
                    if PRSalaryCard.FindFirst() then
                        REPORT.Run(REPORT::"PR Individual Payslip", true, false, PRSalaryCard);
                end;
            }
            action(ProcessPayroll)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Process Payroll';
                Image = PayrollStatistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Text000: Label '@1@@@@@@@@@@@@@@@@@@@@@';
                begin

                    PRPeriod.Reset;
                    PRPeriod.SetRange(PRPeriod.Closed, false);
                    if PRPeriod.Find('-') then begin
                        SelectedPeriod := PRPeriod."Date Opened";
                    end else begin
                        Error('No Payroll period found');
                    end;

                    if PRSalaryCard.Get(Rec."No.") then begin
                        HREmployeePR.Reset;
                        HREmployeePR.SetRange(HREmployeePR.Status, HREmployeePR.Status::Active);

                        if HREmployeePR.Find('-') then begin
                            ProgressWindow.Open('Processing Salary #1#################################################################');
                            repeat
                                ProgressWindow.Update(1, HREmployeePR."No." + ':' + HREmployeePR."Full Name");
                                if PRSalaryCard.Get(HREmployeePR."No.") then begin
                                    ProcessPayroll.fnProcesspayroll(HREmployeePR."No.", HREmployeePR."Date Of Join"
                                    , PRSalaryCard."Basic Pay", PRSalaryCard."Pays PAYE", PRSalaryCard."Pays NSSF", PRSalaryCard."Pays NHIF"
                                    , SelectedPeriod, SelectedPeriod, '', '', HREmployeePR."Date Of Leaving", true,
                                    HREmployeePR."Department Code", PRSalaryCard."Insurance Certificate?", PRSalaryCard."Pays New NSSF (%)");
                                end else begin
                                    //ERROR('Employee not found in PR Salary Card table, please capture Basic PY information');
                                end;
                            until HREmployeePR.Next = 0;
                            ProgressWindow.Close;
                        end;

                        Commit;

                        // //CODEUNIT
                        // PRSalaryCard.Reset;
                        // PRSalaryCard.SetRange("Employee Code", Rec."No.");
                        // PRSalaryCard.SetRange(PRSalaryCard."Period Filter", SelectedPeriod);

                        //AFTER SUCCESS PROCSSING PRINT INDIVIDUAL PAYSLIP
                        //REPORT.Run(REPORT::"PR Individual Payslip", true, false, PRSalaryCard);
                    end;
                end;
            }
            action("Update NSSF NHIF")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Update NSSF NHIF,HLevy';
                Visible = false;

                trigger OnAction()
                var
                    PRSalaryCard: Record "PR Salary Card";
                begin
                    //Error('disabled');
                    PRSalaryCard.Reset;
                    if PRSalaryCard.Find('-') then begin
                        repeat
                            PRSalaryCard."Pays NSSF" := true;
                            PRSalaryCard."Pays PAYE" := true;
                            PRSalaryCard."Pays NHIF" := true;
                            PRSalaryCard."Pays Housing Levy" := true;
                            PRSalaryCard.Modify;
                        until PRSalaryCard.Next = 0;
                        Message('DONE');
                    end;
                end;
            }
            action("Process Current")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Process Current';
                Image = PayrollStatistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Text000: Label '@1@@@@@@@@@@@@@@@@@@@@@';
                begin

                    PRPeriod.Reset;
                    PRPeriod.SetRange(PRPeriod.Closed, false);
                    if PRPeriod.Find('-') then begin
                        SelectedPeriod := PRPeriod."Date Opened";
                    end else begin
                        Error('No Payroll period found');
                    end;

                    if PRSalaryCard.Get(Rec."No.") then begin
                        HREmployeePR.Reset;
                        HREmployeePR.SetRange(HREmployeePR.Status, HREmployeePR.Status::Active);
                        //HREmployeePR.setrange(HREmployeePR."Member Status",HREmployeePR."Member Status"::Active);
                        HREmployeePR.SetRange(HREmployeePR."No.", Rec."No.");
                        if HREmployeePR.Find('-') then begin
                            ProgressWindow.Open('Processing Salary #1#################################################################');
                            repeat
                                ProgressWindow.Update(1, HREmployeePR."No." + ':' + HREmployeePR."Full Name");
                                if PRSalaryCard.Get(HREmployeePR."No.") then begin
                                    ProcessPayroll.fnProcesspayroll(HREmployeePR."No.", HREmployeePR."Date Of Join"
                                     , PRSalaryCard."Basic Pay", PRSalaryCard."Pays PAYE", PRSalaryCard."Pays NSSF", PRSalaryCard."Pays NHIF"
                                     , SelectedPeriod, SelectedPeriod, '', '', HREmployeePR."Date Of Leaving", true,
                                     HREmployeePR."Department Code", PRSalaryCard."Insurance Certificate?", PRSalaryCard."Pays New NSSF (%)");
                                end else begin
                                    //ERROR('Employee not found in PR Salary Card table, please capture Basic PY information');
                                end;
                            until HREmployeePR.Next = 0;
                            ProgressWindow.Close;
                        end;

                        Commit;

                        //CODEUNIT
                        PRSalaryCard.Reset;
                        PRSalaryCard.SetRange("Employee Code", Rec."No.");
                        PRSalaryCard.SetRange(PRSalaryCard."Period Filter", SelectedPeriod);
                        if PRSalaryCard.Find('-') then begin
                            //AFTER SUCCESS PROCSSING PRINT INDIVIDUAL PAYSLIP
                            REPORT.Run(REPORT::"PR Individual Payslip", true, false, PRSalaryCard);
                        end;
                    end;
                end;
            }
            action("Update Loan Deductions")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Update Loan Deductions';
                Image = UnlimitedCredit;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;


                trigger OnAction()
                var
                    PRTransactionCodes: Record "PR Transaction Codes";
                    PREmployeeTransactions: Record "PR Employee Transactions";
                    HREmployees: Record "HR Employees";
                    ProductFactory: Record "Product Factory";
                    Loans: Record Loans;
                    PRTransactionCodesN: Record "PR Transaction Codes";
                    PREmployeeTransactionsN: Record "PR Employee Transactions";
                    PayPeriod: Record "PR Payroll Periods";
                    dtOpenPeriod: Date;
                    strPeriodName: Text;
                begin

                    if not Confirm('Are you sure you want to update staff loan details?') then exit;
                    PayPeriod.SetRange(PayPeriod.Closed, false);
                    if PayPeriod.Find('-') then begin
                        strPeriodName := PayPeriod."Period Name";
                        dtOpenPeriod := PayPeriod."Date Opened";
                    end;
                    //if PRSalaryCard.Get('200435') then begin
                    if PRSalaryCard.Get(Rec."No.") then begin
                        HREmployees.Reset;
                        HREmployees.SetRange(HREmployees.Status, HREmployees.Status::Active);
                        if HREmployees.Find('-') then begin
                            repeat
                                Loans.Reset;
                                Loans.SetRange(Loans."Member No.", HREmployees."Member No.");
                                Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Total Balance");
                                Loans.SetFilter(Loans."Total Balance", '>%1', 0);
                                if Loans.Find('-') then begin
                                    repeat
                                        PREmployeeTransactions.Reset;
                                        PREmployeeTransactions.SetRange("Employee Code", HREmployees."No.");
                                        PREmployeeTransactions.SetRange("Loan Number", Loans."Loan No.");
                                        PREmployeeTransactions.SetRange(PREmployeeTransactions."Payroll Period", dtOpenPeriod);
                                        if PREmployeeTransactions.Find('-') then begin
                                            repeat
                                                Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Outstanding Bills");
                                                if Loans."Outstanding Balance" > 0 then begin
                                                    if PREmployeeTransactions.Variated = false then begin
                                                        PREmployeeTransactions.Amount := Loans.Repayment;
                                                    end;
                                                    PREmployeeTransactions.Balance := Loans."Outstanding Balance";
                                                    if Loans.Interest = 0 then begin
                                                        PREmployeeTransactions."Loan Interest Rate" := 1;
                                                    end else begin
                                                        PREmployeeTransactions."Loan Interest Rate" := Loans.Interest;
                                                    end;
                                                    PREmployeeTransactions."#of Repayments" := Loans.Installments;
                                                    PREmployeeTransactions."Original Amount" := Loans."Approved Amount";
                                                    PREmployeeTransactions."Interest Due" := Loans."Outstanding Interest";
                                                    PREmployeeTransactions.Modify;
                                                end else
                                                    PREmployeeTransactions.DeleteAll();


                                            until PREmployeeTransactions.Next = 0;
                                        end;
                                    until Loans.Next = 0;
                                end;
                            until HREmployees.Next = 0;
                        end;
                    end;
                end;
            }

            action("Update New Loan Deductions")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Update New Loan Deductions';
                Image = UnlimitedCredit;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;


                trigger OnAction()
                var
                    PRTransactionCodes: Record "PR Transaction Codes";
                    PREmployeeTransactions: Record "PR Employee Transactions";
                    HREmployees: Record "HR Employees";
                    ProductFactory: Record "Product Factory";
                    Loans: Record Loans;
                    PRTransactionCodesN: Record "PR Transaction Codes";
                    PREmployeeTransactionsN: Record "PR Employee Transactions";
                    PayPeriod: Record "PR Payroll Periods";
                    dtOpenPeriod: Date;
                    strPeriodName: Text;
                begin
                    report.run(report::"Update Employee Loans Report");
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        // CheckPayrollView();
        // OnAccesRestrictView
    end;


    var
        PRSalaryCard: Record "PR Salary Card";
        PRPeriod: Record "PR Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodMonth: Integer;
        PeriodYear: Integer;
        ProcessPayroll: Codeunit "PR Payroll Processing";
        HREmployeePR: Record "HR Employees";
        ProgressWindow: Dialog;
        PREmployeeTrans: Record "PR Employee Transactions";
        HREMP: Record "HR Employees";
        i: Integer;
        PRPeriodT: Record "PR Period Transactions";
        PRTransCodes: Record "PR Transaction Codes";
        PrevPayrollPeriod: Date;
        LoanStatus: Option " ","Fully Paid","Partly Paid";
        LoanTransCode: Code[15];
        InterestTransCode: Code[15];
        PREmployeeTrans_2: Record "PR Employee Transactions";
        PREmployeeTrans_3: Record "PR Employee Transactions";
        PREmployeeTrans_4: Record "PR Employee Transactions";
        PRTransCodes_2: Record "PR Transaction Codes";
        LoanTransCode_2: Code[20];
        InterestTransCode_2: Code[20];
        ApprovalEntry: Record "Approval Entry";
        ChangePermission: Record "Status Change Permissions.";

    //[Scope('OnPrem')]
    procedure CheckPayrollView()
    var
        Text000: Label 'You do not have permissions to VIEW Payroll.Sending An E-mail Alert To The Payroll Manager.';
        StatusPermissions: Record "Status Change Permissions.";
    begin
        /*StatusPermissions.RESET;
        StatusPermissions.SETRANGE(StatusPermissions."User ID");
        StatusPermissions.SETRANGE(StatusPermissions."Function",StatusPermissions."Function"::"View Payroll");
        IF NOT StatusPermissions.FIND('-') THEN
        ERROR(Text000);;
        */
        StatusPermissions.Reset;
        StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
        StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."Function"::"View Payroll");
        if not StatusPermissions.Find('-') then
            Error(Text000);

    end;

    procedure OnAccesRestrictView()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestrictViewTxt: Label 'You do Not have Permission on View,Read,Modify on this Page. Contact system administrator for assistance. %1-%2';
    begin
        ChangePermission.Reset;
        ChangePermission.SetRange("User ID", UserId);
        ChangePermission.SetRange("View Payroll", true);
        ChangePermission.SetRange("Function Extended", ChangePermission."Function Extended"::"View Payroll");
        if not ChangePermission.Find('-') then begin
            Error(ErrorOnRestrictViewTxt, UserId, Rec.TableCaption);
        end;
    end;
}

