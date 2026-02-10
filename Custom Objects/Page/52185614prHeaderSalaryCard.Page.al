page 52185614 "prHeader Salary Card"
{
    // strempcode,dtDOE,curbasicpay,blnpaye,blnnssf,blnnhif,selectedperio,dtopenperio,
    // membership,referenceno,dttermination,blngetspayereleif

    DeleteAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Navigate,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "HR Employees";
    SourceTableView = WHERE(Status = FILTER(New));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

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
                    Editable = false;
                    Enabled = true;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field(DepName; Rec.DepName)
                // {
                //     Editable = false;
                //     Visible = false;
                // }
                field(Office; Rec.Office)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Unit';
                    Editable = false;
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
                field("Salary Grade"; Rec."Salary Grade")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Salary Notch/Step"; Rec."Salary Notch/Step")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        if not Confirm('Changing the Grade will affect the Basic Salary and the salary notch\step transactions. ' +
                                        'Do you wish to continue?', false) then begin
                            Rec."Salary Notch/Step" := '';
                            Error('You have opted to abort the process.');

                        end;
                    end;
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(Control1102756041; "PR Salary Information")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Employee Code" = FIELD("No.");
            }
            group("Posting && Bank Details")
            {
                Caption = 'Posting && Bank Details';
                field("Hr Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posting Group';
                    Editable = true;
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
            }
            group("Other Details")
            {
                Caption = 'Other Details';
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'ID No.';
                }
                field("PIN No."; Rec."PIN No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pension No.';
                }
                field("NSSF No."; Rec."NSSF No.")
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
                    Promoted = true;
                    PromotedCategory = Category7;
                    RunObject = Page "prEmployee Banks";
                    RunPageLink = "Employee Code" = FIELD("No.");
                }
                separator(Action1102756059)
                {
                }
                action("Pension Details")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pension Details';
                    Image = PlanningWorksheet;
                    RunObject = Page "Pension Contribution Details";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    Visible = false;
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
                    RunObject = Page "prInsurance Policies";
                    RunPageLink = "Employee Code" = FIELD("No.");
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
                    RunObject = Page "prInsurance Policies";
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
                    RunObject = Page "prSalary Arrears";
                    RunPageLink = "Employee Code" = FIELD("No.");
                    RunPageView = SORTING("Employee Code", "Period Month", "Period Year");
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
        area(processing)
        {
            action("View Payslip")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'View Payslip';
                Image = Payment;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

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
                    SalCard.GET("No.");
                    SalCard.SETRANGE("Employee Code","No.");
                    SalCard.SETRANGE(SalCard."Period Filter",SelectedPeriod);
                    //REPORT.Run(52185622,TRUE,FALSE,SalCard);
                    */
                    prPostingGroup.Get(Rec."Posting Group");
                    HrEmployee.Reset;
                    HrEmployee.SetRange(HrEmployee."No.", Rec."No.");
                    HrEmployee.SetRange(HrEmployee."Current Month Filter", SelectedPeriod);
                    //if prPostingGroup."Payslip Report" <> 0 then
                    //REPORT.Run(prPostingGroup."Payslip Report", true, false, HrEmployee)
                    // else
                    // Error('Please Specify the Posting group %1 payslip report', "Posting Group");
                    /*
                    IF SalCard.Currency = '' THEN
                      BEGIN
                        HrEmployee.RESET;
                        HrEmployee.SETRANGE(HrEmployee."No.","No.");
                        HrEmployee.SETRANGE(HrEmployee."Current Month Filter",SelectedPeriod);
                        IF prPostingGroup."Payslip Report" <> 0 THEN
                         //REPORT.Run(prPostingGroup."Payslip Report",TRUE,FALSE,HrEmployee)
                        ELSE
                         //REPORT.Run(52185622,TRUE,FALSE,HrEmployee);
                      END
                    ELSE IF SalCard."Does Not Pay PAYE On Basic" = TRUE THEN
                      BEGIN
                        HrEmployee.RESET;
                        HrEmployee.SETRANGE(HrEmployee."No.","No.");
                        HrEmployee.SETRANGE(HrEmployee."Current Month Filter",SelectedPeriod);
                        //REPORT.Run(52185651,TRUE,FALSE,HrEmployee);
                      END
                    ELSE
                      BEGIN
                        HrEmployee.RESET;
                        HrEmployee.SETRANGE(HrEmployee."No.","No.");
                        HrEmployee.SETRANGE(HrEmployee."Current Month Filter",SelectedPeriod);
                        //REPORT.Run(52185650,TRUE,FALSE,HrEmployee);
                      END
                    */

                end;
            }
            action("Process Current")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Process Current';
                Image = CalculatePlan;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

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
                                    HrEmployee.TestField(HrEmployee."Date Of Join");
                                //PKK Check NHF Age
                                if (HrEmployee."Date Of Birth" <> 0D) then begin
                                    if CalcDate(VitalInfo."NHF - Maximum Age", HrEmployee."Date Of Birth") <> HrEmployee."Date Of Birth" then begin
                                        if CalcDate(VitalInfo."NHF - Maximum Age", HrEmployee."Date Of Birth") < Today then
                                            SalCard."Pays NHIF" := false;
                                    end;
                                end;
                                //PKK Check NHF Age
                                HrEmployee.TestField(HrEmployee."Date Of Join");
                                ProcessPayroll.fnProcesspayroll(HrEmployee."No.", HrEmployee."Date Of Join", SalCard."Basic Pay", SalCard."Pays PAYE"
                                    , SalCard."Pays NSSF", SalCard."Pays NHIF", SelectedPeriod, SelectedPeriod, '', '',
                                    HrEmployee."Date Of Leaving", true, HrEmployee."Department Code", PayrollCode);
                            end;
                        until HrEmployee.Next = 0;
                        ////Progress Window
                        ProgressWindow.Close;
                    end;
                    //CODEUNIT

                    Commit;

                    prPostingGroup.Get(Rec."Posting Group");
                    HrEmployee.Reset;
                    HrEmployee.SetRange(HrEmployee."No.", Rec."No.");
                    HrEmployee.SetRange(HrEmployee."Current Month Filter", SelectedPeriod);
                    //if prPostingGroup."Payslip Report" <> 0 then
                    //REPORT.Run(prPostingGroup."Payslip Report", true, false, HrEmployee)
                    // else
                    // Error('Please Specify the Posting group %1 payslip report', "Posting Group");
                end;
            }
            action("Process Payroll")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Process Payroll';
                Image = CalculateCalendar;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

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
                                    //PKK Check NHF Age
                                    if (HrEmployee."Date Of Birth" <> 0D) then begin
                                        if CalcDate(VitalInfo."NHF - Maximum Age", HrEmployee."Date Of Birth") <> HrEmployee."Date Of Birth" then begin
                                            if CalcDate(VitalInfo."NHF - Maximum Age", HrEmployee."Date Of Birth") < Today then
                                                SalCard."Pays NHIF" := false;
                                        end;
                                    end;
                                    //PKK Check NHF Age
                                    //PKProgressWindow.UPDATE(1,HrEmployee."No."+':'+HrEmployee."First Name"+' '+HrEmployee."Middle Name"+' '+HrEmployee."Last Name");

                                    if SalCard.Get(HrEmployee."No.") then begin
                                        HrEmployee.TestField(HrEmployee."Date Of Join");
                                        ProcessPayroll.fnProcesspayroll(HrEmployee."No.", HrEmployee."Date Of Join", SalCard."Basic Pay", SalCard."Pays PAYE"
                                            , SalCard."Pays NSSF", SalCard."Pays NHIF", SelectedPeriod, SelectedPeriod, '', '',
                                            HrEmployee."Date Of Leaving", true, HrEmployee."Department Code", PayrollCode);
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
                    //REPORT.Run(52185622,TRUE,FALSE,SalCard);
                    */

                end;
            }
            group(Functions)
            {
                Caption = 'Functions';
                Visible = false;
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Requisition","Transport Requisition",JV,"Grant Task","Concept Note",Proposal,"Job Approval","Disciplinary Approvals",GRN,Clearence,Donation,Transfer,PayChange,Budget,GL,"Cash Purchase","Leave Reimburse",Appraisal,Inspection,Closeout,"Lab Request",ProposalProjectsAreas,"Leave Carry over","IB Transfer",EmpTransfer,LeavePlanner,HrAssetTransfer,"Salary Details";
                    ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := DocumentType::"Salary Details";
                        DocumentType := DocumentType::"Job Approval";
                        ApprovalEntries.SetRecordFilters(DATABASE::"HR Employees", DocumentType, Rec.Position);
                        ApprovalEntries.Run;
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if Confirm('Send this Salary Details for Approval?', true) = false then exit;
                        //AppMgmt.SendJobApprovalRequest(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Request';
                    Image = CancelAllLines;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if Confirm('Cancel Approval Request?', true) = false then exit;
                        //AppMgmt.CanceljobAppRequest(Rec,TRUE,TRUE);
                    end;
                }
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

        objPeriod.Reset;
        objPeriod.SetRange(objPeriod.Closed, false);
        if objPeriod.Find('-') then begin
            SelectedPeriod := objPeriod."Date Opened";
            PeriodName := objPeriod."Period Name";
            PeriodMonth := objPeriod."Period Month";
            PeriodYear := objPeriod."Period Year";
        end;
    end;

    var
        objEmp: Record "HR Employees";
        SalCard: Record "PR Salary Card";
        objPeriod: Record "PR Payroll Periods";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodMonth: Integer;
        PeriodYear: Integer;
        ProcessPayroll: Codeunit prPayrollProcessing111;
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
        prPostingGroup: Record "prEmployee Posting Group";
}

