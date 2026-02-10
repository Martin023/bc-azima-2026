page 52185657 prPostedAssignEmployeeLoan
{
    Editable = false;
    PageType = Card;
    SourceTable = prAssignEmployeeLoan;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        PRTransactions.Reset;
                        PRTransactions.SetRange(PRTransactions."IsCoop/LnRep", true);
                        if PAGE.RunModal(39004006, PRTransactions) = ACTION::LookupOK then begin
                            Rec."Transaction Code" := PRTransactions."Transaction Code";
                            Rec."Transaction Name" := PRTransactions."Transaction Name";
                        end
                    end;

                    trigger OnValidate()
                    begin
                        blnIsLoan := false;
                        if objTransCodes.Get(Rec."Transaction Code") then
                            Rec."Transaction Name" := objTransCodes."Transaction Name";
                        Rec."Payroll Period" := SelectedPeriod;
                        Rec."Period Month" := PeriodMonth;
                        Rec."Period Year" := PeriodYear;
                        if objTransCodes."Special Transactions" = 8 then blnIsLoan := true;

                        /*IF objTransCodes."Is Formula"=TRUE THEN
                        BEGIN
                         empCode:="Employee Code";
                         CLEAR(objOcx);
                         curTransAmount:=objOcx.fnDisplayFrmlValues(empCode,PeriodMonth,PeriodYear,objTransCodes.Formula);
                         Amount:=curTransAmount;
                        END;
                        */
                        //*************ENTER IF EMPLOYER DEDUCTION IS SET UP
                        curTransAmount := 0;
                        /*
                        IF objTransCodes."Include Employer Deduction"=TRUE THEN
                        BEGIN
                          curTransAmount:=objOcx.fnDisplayFrmlValues(empCode,PeriodMonth,PeriodYear,objTransCodes."Is Formula for employer");
                          "Employer Amount":=curTransAmount;
                        END;
                        */

                    end;
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        if objPeriod.Get(Rec."Payroll Period") then begin
                            if objPeriod.Closed = true then Error('The %1 period has already been closed', Rec."Payroll Period");
                            Rec."Payroll Period" := CalcDate('<-CM>', Rec."Start Date");
                            Rec.Validate("Payroll Period");
                        end
                    end;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = Basic, Suite;
                    Enabled = false;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Loan Balance';

                    trigger OnValidate()
                    begin
                        if (blnIsLoan = true) and (Rec.Balance > 0) and (Rec.Amount > 0) then begin
                            Rec."#of Repayments" := Round(Rec.Balance / Rec.Amount, 1, '>');
                            Rec."#of Repayments" := Round(Rec."#of Repayments", 1, '>');
                        end;
                    end;
                }
                field("#of Repayments"; Rec."#of Repayments")
                {
                    ApplicationArea = Basic, Suite;

                    trigger OnValidate()
                    begin
                        if blnIsLoan = true then begin
                            Rec."#of Repayments" := Round(Rec.Balance / Rec.Amount, 1, '>');
                            Rec."#of Repayments" := Round(Rec."#of Repayments", 1, '>');
                        end;
                    end;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Monthly Deduction';

                    trigger OnValidate()
                    begin
                        if (blnIsLoan = true) and (Rec.Balance > 0) and (Rec.Amount > 0) then begin
                            Rec."#of Repayments" := Round(Rec.Balance / Rec.Amount, 1, '>');
                            Rec."#of Repayments" := Round(Rec."#of Repayments", 1, '>');
                        end;
                    end;
                }
                field("Stop for Next Period"; Rec."Stop for Next Period")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Amortized Loan Total Repay Amt"; Rec."Amortized Loan Total Repay Amt")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Suspended; Rec.Suspended)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Process Loan")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Process Loan';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Posted then Error('The Loan has already been processed');

                    objPeriod.Reset;
                    objPeriod.SetRange(objPeriod.Closed, false);
                    if objPeriod.Find('-') then begin
                        if Rec."Payroll Period" = objPeriod."Date Opened" then begin
                            PrEmpTrans.Init;
                            PrEmpTrans.TransferFields(Rec);
                            if PrEmpTrans.Insert then
                                Rec.Status := Rec.Status::Posted;
                            Rec.Modify;
                            Message('Loan %1 successfully processed for employee %2', Rec."Transaction Code", Rec."Employee Code");
                        end
                        else begin
                            Rec.Status := Rec.Status::Posted;
                            Rec.Modify;//the transfer will be transferred to the right period when the specified period is opened using close period functionality
                            Message('Loan %1 successfully processed for employee %2', Rec."Transaction Code", Rec."Employee Code");
                        end
                    end
                    else begin
                        Rec.Status := Rec.Status::Posted;
                        Rec.Modify;//the transfer will be transferred to the right period when the specified period is opened using close period functionality
                        Message('Loan %1 successfully processed for employee %2', Rec."Transaction Code", Rec."Employee Code");
                    end
                end;
            }
            action(Transfer)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Transfer';
                Image = TransferFunds;
                Promoted = true;

                trigger OnAction()
                begin
                    /*
                    //Added for loan card to push loans for next period into employee transactions **changes**
                    prAssignEmployeeLoan.RESET;
                    prAssignEmployeeLoan.SETRANGE(prAssignEmployeeLoan."Payroll Period",dtNewPeriod);
                    prAssignEmployeeLoan.SETRANGE(prAssignEmployeeLoan.Status,prAssignEmployeeLoan.Status::Posted);
                    IF prAssignEmployeeLoan.FINDSET THEN
                    REPEAT
                    //  fnInsertTrans(prAssignEmployeeLoan);
                    
                      prEmployeeTrans.RESET;
                      prEmployeeTrans.SETRANGE(prEmployeeTrans."Employee Code",prAssignLoan."Employee Code");
                      prEmployeeTrans.SETRANGE(prEmployeeTrans."Transaction Code",prAssignLoan."Transaction Code");
                      prEmployeeTrans.SETRANGE(prEmployeeTrans."Payroll Period",prAssignLoan."Payroll Period");
                      IF NOT prEmployeeTrans.FINDFIRST THEN BEGIN
                        prEmployeeTrans.INIT;
                        prEmployeeTrans.TRANSFERFIELDS(prAssignLoan);
                        prEmployeeTrans.INSERT;
                      END
                    
                    UNTIL prAssignEmployeeLoan.NEXT=0;
                    */
                    objPeriod.SetRange(objPeriod.Closed, false);
                    objPeriod.FindLast;
                    if Date2DMY(Rec."Start Date", 2) = objPeriod."Period Month" then begin
                        Rec."Payroll Period" := objPeriod."Date Opened";
                        Rec."Period Month" := objPeriod."Period Month";
                        Rec."Period Year" := objPeriod."Period Year";
                        //MODIFY;
                        prEmployeeTrans.Reset;
                        prEmployeeTrans.SetRange(prEmployeeTrans."Employee Code", Rec."Employee Code");
                        prEmployeeTrans.SetRange(prEmployeeTrans."Transaction Code", Rec."Transaction Code");
                        prEmployeeTrans.SetRange(prEmployeeTrans."Payroll Period", Rec."Payroll Period");
                        if not prEmployeeTrans.FindFirst then begin
                            prEmployeeTrans.Init;
                            prEmployeeTrans.TransferFields(Rec);
                            prEmployeeTrans.Insert;
                            Message('Loan successfully transferred');
                        end
                    end

                end;
            }
        }
    }

    trigger OnInit()
    begin
        /*
        objPeriod.RESET;
        objPeriod.SETRANGE(objPeriod.Closed,FALSE);
        IF objPeriod.FIND('-') THEN
        BEGIN
            SelectedPeriod:=objPeriod."Date Opened";
            PeriodName:=objPeriod."Period Name";
            PeriodMonth:=objPeriod."Period Month";
            PeriodYear:=objPeriod."Period Year";
            //objEmpTrans.RESET;
            //objEmpTrans.SETRANGE("Payroll Period",SelectedPeriod);
        END;
        */
        //Filter per period  - Dennis
        //SETFILTER("Payroll Period",FORMAT(objPeriod."Date Opened"));

    end;

    var
        objTransCodes: Record "PR Transaction Codes";
        SelectedPeriod: Date;
        objPeriod: Record "PR Payroll Periods";
        PeriodName: Text[30];
        PeriodTrans: Record "PR Period Transactions";
        PeriodMonth: Integer;
        PeriodYear: Integer;
        blnIsLoan: Boolean;
        objEmpTrans: Record "PR Employee Transactions";
        transType: Text[30];
        objOcx: Codeunit prPayrollProcessing111;
        strExtractedFrml: Text[30];
        curTransAmount: Decimal;
        empCode: Text[30];
        Employee: Record "HR Employees";
        EmpTrans: Record "PR Employee Transactions";
        VitalSetUp: Record "PR Vital Setup Info";
        SalaryCard: Record "PR Salary Card";
        TotalEarnings: Decimal;
        ArreasAmount: Decimal;
        ArrearsDays: Integer;
        NoOfMonthDays: Integer;
        i: Integer;
        RemainingDays: Integer;
        TDate: Date;
        PRTransactions: Record "PR Transaction Codes";
        PrEmpTrans: Record "PR Employee Transactions";
        prEmployeeTrans: Record "PR Employee Transactions";

    //[Scope('OnPrem')]
    procedure ProcessLoan()
    begin
    end;
}

