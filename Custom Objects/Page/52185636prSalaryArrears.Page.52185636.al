page 52185636 "pr Salary Arrears"
{
    PageType = Document;
    SourceTable = "HR Employees";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                // field("No."; Rec."No.")
                // {
                // }
                // field("""First Name""+' '+""Middle Name""+' '+""Last Name"""; Rec."First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
                // {
                //     Caption = 'Name';
                // }
                // field(StartDate; Rec.StartDate)
                // {
                //     Caption = 'Start Date';
                //     TableRelation = "PR Payroll Periods"."Date Opened";
                // }
                // field(EndDate; Rec.EndDate)
                // {
                //     Caption = 'End Date';
                //     TableRelation = "PR Payroll Periods"."Date Opened";
                // }
                // field(ProcessAll; Rec.ProcessAll)
                // {
                //     Caption = 'All Employees';
                // }
            }
            part(Control1102756010; prSalaryArrears)
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Employee Code" = FIELD("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action("Process Arrears")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Process Arrears';
                    Image = CalculatePlanChange;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        //Get the Salary Arrears code
                        TransCode.SetRange(TransCode."Special Transactions", 6);
                        if TransCode.Find('-') then
                            strTransCode := TransCode."Transaction Code";

                        //Get the open/current period
                        PayPeriod.SetRange(PayPeriod.Closed, false);
                        if PayPeriod.Find('-') then begin
                            PeriodMonth := PayPeriod."Period Month";
                            PeriodYear := PayPeriod."Period Year";
                        end;

                        if ProcessAll then begin
                            HrEmployee.Reset;
                            HrEmployee.SetRange(HrEmployee.Status, HrEmployee.Status::New);
                            if HrEmployee.Find('-') then begin
                                repeat
                                    //Get the staff current salary
                                    if SalCard.Get(HrEmployee."No.") then begin
                                        CurrBasic := SalCard."Basic Pay";
                                    end;
                                    objOcx.fnSalaryArrears(HrEmployee."No.", strTransCode, CurrBasic, StartDate, EndDate, PayPeriod."Date Opened",
                                    HrEmployee."Date Of Join", HrEmployee."Date Of Leaving");
                                until HrEmployee.Next = 0;
                            end;
                        end else begin
                            //Get the staff current salary
                            if SalCard.Get(Rec."No.") then begin
                                CurrBasic := SalCard."Basic Pay";
                            end;

                            objOcx.fnSalaryArrears(Rec."No.", strTransCode, CurrBasic, StartDate, EndDate, PayPeriod."Date Opened",
                            Rec."Date Of Join", Rec."Date Of Leaving");

                        end;
                    end;
                }
            }
        }
    }

    var
        StartDate: Date;
        EndDate: Date;
        ProcessAll: Boolean;
        HrEmployee: Record "HR Employees";
        objOcx: Codeunit prPayrollProcessing111;
        SalCard: Record "PR Salary Card";
        PayPeriod: Record "PR Payroll Periods";
        PeriodMonth: Integer;
        PeriodYear: Integer;
        TransCode: Record "PR Transaction Codes";
        strTransCode: Text[30];
        strEmpCode: Text[30];
        SalArr: Record "prSalary Arrears";
        strEmpName: Text[50];
        objEmp: Record "HR Employees";
        CurrBasic: Decimal;
}

