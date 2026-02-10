page 52185634 "Salary Grades List"
{
    CardPageId = "Salary Grades";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Salary Grades";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    PromotedActionCategories = ',,,,Send To Payroll';

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;
                field("Salary Grade"; Rec."Salary Grade")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(SalaryPeriod; Rec.SalaryPeriod)
                {
                    ApplicationArea = all;
                }


                field("Salary Amount"; Rec."Salary Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Minimum Amount"; Rec."Minimum Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Maxmum Amount"; Rec."Maxmum Amount")
                {
                    ApplicationArea = Basic, Suite;
                }

            }
        }
    }


    actions
    {
        area(Navigation)
        {
            group(SendVariedToPayrolll)
            {
                action(SendAllowancesToPayroll)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send Varied To Payroll';
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Category5;
                    trigger OnAction()
                    var
                        PrEmployeeTransactions: Record "PR Employee Transactions";
                        salyGheader: Record "Salary Grades";
                        dtOpenPeriod: Date;
                        intMonth: Integer;
                        intYear: Integer;
                        Transactions: record "PR Transaction Codes";
                    begin
                        ProgressWindow.Open('Processing ... #1#################################################################');

                        dtOpenPeriod := ProcessPayroll.fnGetOpenPeriod();
                        intMonth := Date2dmy(dtOpenPeriod, 2);
                        intYear := Date2dmy(dtOpenPeriod, 3);
                        salyGheader.Reset();
                        if salyGheader.find('-') then begin
                            repeat
                                HREmployeePR.Reset;
                                HREmployeePR.SetRange(HREmployeePR.Status, HREmployeePR.Status::Active);
                                HREmployeePR.SetRange("Salary Grade", salyGheader."Salary Grade");
                                if HREmployeePR.Findfirst() then begin
                                    repeat
                                        PrEmployeeTransactions.Reset();
                                        PrEmployeeTransactions.SetRange("Employee Code", HREmployeePR."No.");
                                        PrEmployeeTransactions.SetRange("Payroll Period", dtOpenPeriod);
                                        PrEmployeeTransactions.SetRange("Period Month", intMonth);
                                        PrEmployeeTransactions.SetRange("Period Year", intYear);
                                        PrEmployeeTransactions.SetRange(Frequency, PrEmployeeTransactions.Frequency::Varied);
                                        if PrEmployeeTransactions.Find('-') then
                                            PrEmployeeTransactions.DeleteAll();
                                        ProgressWindow.Update(1, HREmployeePR."No." + ':' + HREmployeePR."Full Name");
                                        PRSalaryCard.Reset();
                                        PRSalaryCard.SetRange("Salary Grade", salyGheader."Salary Grade");
                                        PRSalaryCard.SetRange(Frequency, PRSalaryCard.Frequency::Varied);
                                        IF PRSalaryCard.Find('-') THEN begin
                                            repeat
                                                ProcessPayroll.Allowances(PRSalaryCard, HREmployeePR."No.", salyGheader.SalaryPeriod);
                                            until PRSalaryCard.Next() = 0;
                                        end;
                                    until HREmployeePR.Next = 0;
                                end;
                            until salyGheader.Next() = 0;
                        end;
                        ProgressWindow.Close;
                    end;

                }
            }

        }

    }

    var
        HREmployeePR: Record "HR Employees";
        SalaryGrades: record "Salary Grades";
        PRSalaryCard: Record "salary grade lines";
        PRPeriod: Record "PR Payroll Periods";
        ProgressWindow: Dialog;
        SelectedPeriod: Date;
        GradeLines: record "Salary Grade Lines";
        ProcessPayroll: codeunit "PR Payroll Processing";

    procedure OnViewCurrRec()
    var
        ChangePermission: Record "Status Change Permissions.";
        ErrorOnRestricViewTxt: Label 'You do not have Permissions to VIEW,MODIFY or DELETE on this record. Contact system administrator for assistance. %';
    begin
        ChangePermission.Reset;
        ChangePermission.SetRange("User ID", UserId);
        ChangePermission.SetRange("View Payroll", true);
        //ChangePermission.SETRANGE("Function Extended",ChangePermission."Function Extended"::"Edit HR Setups");
        if not ChangePermission.Find('-') then
            Error(ErrorOnRestricViewTxt, UserId);
    end;


}

