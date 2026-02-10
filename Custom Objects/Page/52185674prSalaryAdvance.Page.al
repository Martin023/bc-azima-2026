page 52185674 "prSalary Advance"
{
    PageType = Card;
    SourceTable = "prSalary Advance";

    layout
    {
        area(content)
        {
            group(General)
            {
                Visible = true;
                field("Requisition No."; Rec."Requisition No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    Visible = false;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit then
                            CurrPage.Update;
                    end;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Description"; Rec."Loan Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Types"; Rec."Loan Types")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employee Names"; Rec."Employee Names")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Months Salary"; Rec."Months Salary")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Advance Amount Requested"; Rec."Advance Amount Requested")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount Approved"; Rec."Amount Approved")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reasons for Advance Amount"; Rec."Reasons for Advance Amount")
                {
                    ApplicationArea = Basic, Suite;
                    MultiLine = false;
                }
                field("Loan Disbursement Date"; Rec."Loan Disbursement Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("No of Instalments"; Rec."No of Instalments")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Instalments Amount"; Rec."Instalments Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Principal Repayment"; Rec."Loan Principal Repayment")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Interest Repayment"; Rec."Loan Interest Repayment")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Loan Repayment Amount"; Rec."Total Loan Repayment Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Repayment Period"; Rec."Repayment Period")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount Paid"; Rec."Amount Paid")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Basic Salary"; Rec."Basic Salary")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("1/3/ of Basic Salary"; Rec."1/3/ of Basic Salary")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Eligible; Rec.Eligible)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                }
                field("Expected Repayment Amount"; Rec."Expected Repayment Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Grace Period - Principle (M)"; Rec."Grace Period - Principle (M)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Grace Period - Interest (M)"; Rec."Grace Period - Interest (M)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Supervisor; Rec.Supervisor)
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
            group(Functions)
            {
                Caption = 'Functions';
                action("Send Approval Request")
                {
                    ApplicationArea = Basic, Suite;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        //Code
                        VarVariant := Rec;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(rec.RecordId);
                    end;
                }
                action("Post Salary Advance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post Salary Advance';
                    Image = SalesTax;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        if not prVitalSetupInfo.Get() then
                            ERROR('pr rates and ceilings not setup');
                        if rec.Status = rec.Status::Approved then
                            //get period
                            period.Reset;
                        period.SetRange(period.Closed, false);
                        if period.Find('-') then
                            transcode.Reset;
                        transcode.SetRange(transcode."Is HR Loan", true);
                        if transcode.Find('-') then
                            Emptrans.Reset;
                        Emptrans.SetRange(Emptrans."Transaction Code", transcode."Transaction Code");
                        Emptrans.SetRange(Emptrans."Employee Code", rec."Employee No");
                        if Emptrans.Find('-') then
                            // BEGIN
                            //  AMOUNT:=Emptrans.Amount+("Training Cost Cstimated"*(prVitalSetupInfo."Training Deduction Percentage"/100));;
                            //  Emptrans.MODIFY;
                            // END ELSE
                        Emptrans.Init;
                        Emptrans."Employee Code" := rec."Employee No";
                        Emptrans."Transaction Code" := transcode."Transaction Code";
                        Emptrans."Transaction Name" := transcode."Transaction Name";
                        Emptrans."Period Month" := period."Period Month";
                        Emptrans."Period Year" := period."Period Year";
                        Emptrans."Payroll Period" := period."Date Opened";
                        Emptrans.Amount := rec.Repayment;
                        Emptrans.Balance := rec."Total Loan Repayment Amount";
                        Emptrans.Insert;
                        Message('Salary Advance Amount Successfully posted')
                    end;
                }
                action("View Schedule")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'View Schedule';
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedCategory = "Report";
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin

                        //IF Posted=TRUE THEN
                        //ERROR('Loan has been posted, Can only preview schedule');

                        if rec."Repayment Frequency" = rec."Repayment Frequency"::Weekly then
                            Evaluate(InPeriod, '1W')
                        else
                            if rec."Repayment Frequency" = rec."Repayment Frequency"::Monthly then
                                Evaluate(InPeriod, '1M')
                            else
                                if rec."Repayment Frequency" = rec."Repayment Frequency"::Quaterly then
                                    Evaluate(InPeriod, '1Q')
                                else
                                    if rec."Repayment Frequency" = rec."Repayment Frequency"::Yearly then
                                        Evaluate(InPeriod, '1Y');


                        Qcounter := 0;
                        Qcounter := 3;
                        //EVALUATE(InPeriod,'1M');
                        GrPrinciple := rec."Grace Period - Principle (M)";
                        grinterest := rec."Grace Period - Interest (M)";
                        InitialGraceInt := rec."Grace Period - Interest (M)";

                        LoansR.Reset;
                        LoansR.SetRange(LoansR."Loan No.", rec."Loan No.");
                        if LoansR.Find('-') then begin

                            rec.TestField("Loan Disbursement Date");
                            //TESTFIELD("Repayment Start Date");
                            Rundate := 0D;
                            Rschedule.Reset;
                            Rschedule.SetRange(Rschedule."Loan No.", rec."Loan No.");
                            if Rschedule.Find('-') then
                                Rschedule.DeleteAll;

                            LoanAmount := LoansR."Amount Approved";//LoansR."Amount Disbursed";
                            InterestRate := LoansR."Interest Rate";
                            RepayPeriod := LoansR."No of Instalments";
                            InitialInstal := LoansR."No of Instalments" + rec."Grace Period - Principle (M)";
                            Lbalance := LoansR."Amount Approved";
                            RunningDate := LoansR."Loan Disbursement Date";
                            Rundate := LoansR."Loan Disbursement Date";//CALCDATE('-1W',RunningDate);
                            InstalNo := 0;
                            //EVALUATE(RepayInterval,'1W');
                            //EVALUATE(RepayInterval,InPeriod);
                            //MESSAGE('%1,%2',RunningDate,Rundate);
                            //Repayment Frequency
                            if rec."Repayment Frequency" = rec."Repayment Frequency"::Weekly then
                                Rundate := CalcDate('-1W', Rundate)
                            else
                                if rec."Repayment Frequency" = rec."Repayment Frequency"::Monthly then
                                    Rundate := CalcDate('-1M', Rundate)
                                else
                                    if rec."Repayment Frequency" = rec."Repayment Frequency"::Quaterly then
                                        Rundate := CalcDate('-1Q', Rundate)
                                    else
                                        if rec."Repayment Frequency" = rec."Repayment Frequency"::Yearly then
                                            Rundate := CalcDate('-1Y', Rundate);
                            //Repayment Frequency


                            repeat
                                InstalNo := InstalNo + 1;
                                //Rundate:=CALCDATE("Instalment Period",Rundate);
                                //Rundate:=CALCDATE('1W',Rundate);


                                //Repayment Frequency
                                if rec."Repayment Frequency" = rec."Repayment Frequency"::Weekly then
                                    RunningDate := CalcDate('1W', RunningDate)
                                else
                                    if rec."Repayment Frequency" = rec."Repayment Frequency"::Monthly then
                                        RunningDate := CalcDate('1M', RunningDate)
                                    else
                                        if rec."Repayment Frequency" = rec."Repayment Frequency"::Quaterly then
                                            RunningDate := CalcDate('1Q', RunningDate)
                                        else
                                            if rec."Repayment Frequency" = rec."Repayment Frequency"::Yearly then
                                                RunningDate := CalcDate('1Y', RunningDate);

                                /*IF rec."Repayment Frequency"="Repayment Frequency"::Daily THEN
                                Rundate:=CALCDATE('-1D',Rundate)
                                ELSE IF rec."Repayment Frequency"="Repayment Frequency"::Weekly THEN
                                Rundate:=CALCDATE('-1W',Rundate)
                                ELSE IF rec."Repayment Frequency"="Repayment Frequency"::monthly THEN
                                Rundate:=CALCDATE('-1M',Rundate)
                                ELSE IF rec."Repayment Frequency"="Repayment Frequency"::Quartely THEN
                                Rundate:=CALCDATE('-1Q',Rundate);*/

                                //Repayment Frequency
                                //RunningDate:=CALCDATE('1M',Rundate);
                                Rundate := CalcDate('30D', Rundate);
                                //kma
                                if rec."Repayment Method" = rec."Repayment Method"::Amortised then begin
                                    rec.TestField("Interest Rate");
                                    rec.TestField("No of Instalments");
                                    TotalMRepay := Round((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                                    LInterest := Round(Lbalance / 100 / 12 * InterestRate, 0.0001, '>');
                                    Lprincipal := TotalMRepay - LInterest;
                                end;

                                if rec."Repayment Method" = rec."Repayment Method"::"Straight line" then begin
                                    rec.TestField("Interest Rate");
                                    rec.TestField("No of Instalments");
                                    Lprincipal := LoanAmount / RepayPeriod;
                                    LInterest := (InterestRate / 12 / 100) * LoanAmount;
                                    //Grace Period Interest
                                    LInterest := (LInterest * InitialInstal) / (InitialInstal - InitialGraceInt);
                                end;

                                if rec."Repayment Method" = rec."Repayment Method"::"Reducing Balance" then begin
                                    rec.TestField("Interest Rate");
                                    rec.TestField("No of Instalments");
                                    Lprincipal := LoanAmount / RepayPeriod;
                                    LInterest := (InterestRate / 12 / 100) * Lbalance;
                                end;

                                if rec."Repayment Method" = rec."Repayment Method"::Constants then begin
                                    rec.TestField(Repayment);
                                    if Lbalance < rec.Repayment then
                                        Lprincipal := Lbalance
                                    else
                                        Lprincipal := rec.Repayment;
                                    LInterest := rec."Interest Rate";
                                end;
                                //kma



                                //Grace Period
                                if GrPrinciple > 0 then begin
                                    Lprincipal := 0
                                end else begin
                                    //IF "Instalment Period" <> InPeriod THEN
                                    Lbalance := Lbalance - Lprincipal;
                                end;

                                if grinterest > 0 then
                                    LInterest := 0;

                                GrPrinciple := GrPrinciple - 1;
                                grinterest := grinterest - 1;
                                //Grace Period

                                /*//Q Principle
                                IF "Instalment Period" = InPeriod THEN BEGIN
                                //ADDED
                                IF GrPrinciple <> 0 THEN
                                GrPrinciple:=GrPrinciple-1;
                                IF Qcounter = 1 THEN BEGIN
                                Qcounter:=3;
                                Lprincipal:=Qprinciple+Lprincipal;
                                IF Lprincipal > Lbalance THEN
                                Lprincipal:=Lbalance;
                                Lbalance:=Lbalance-Lprincipal;
                                Qprinciple:=0;
                                END ELSE BEGIN
                                Qcounter:=Qcounter - 1;
                                Qprinciple:=Qprinciple+Lprincipal;
                                IF Qprinciple > Lbalance THEN
                                Qprinciple:=Lbalance;
                                Lprincipal:=0;
                                END

                                END;*/
                                //Q Principle


                                Evaluate(RepayCode, Format(InstalNo));
                                /*
                               WhichDay:=DATE2DWY(RunDate,1);
                               IF WhichDay=6 THEN
                                RunDate:=RunDate+2
                               ELSE IF WhichDay=7 THEN
                                RunDate:=RunDate+1;
                                      */
                                //MESSAGE('which day is %1',WhichDay);

                                //Lbalance:=Lbalance-Lprincipal;
                                //MESSAGE('Rundate %1',Rundate);
                                Rschedule.Init;
                                Rschedule."Repayment Code" := RepayCode;
                                Rschedule."Loan No." := rec."Loan No.";
                                Rschedule."Loan Amount" := LoanAmount;
                                Rschedule."Instalment No" := InstalNo;
                                Rschedule."Repayment Date" := Rundate;
                                Rschedule."Staff No." := rec."Employee No";
                                Rschedule."Loan Category" := rec."Loan Type";
                                Rschedule."Monthly Repayment" := LInterest + Lprincipal;
                                Rschedule."Monthly Interest" := LInterest;
                                Rschedule."Principal Repayment" := Lprincipal;
                                Rschedule.Insert;
                                //WhichDay:=(DATE2DMY,RSchedule."Repayment Date",1);
                                WhichDay := Date2DWY(Rschedule."Repayment Date", 1);
                            //MESSAGE('which day is %1',WhichDay);
                            //BEEP(2,10000);
                            until Lbalance < 1

                        end;

                        Commit;

                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan No.", rec."Loan No.");
                        //if LoanApp.Find('-') then
                        //REPORT.Run(52186039, true, false, LoanApp);
                        Report.RUN(Report::PRSalaryAdvanceSchedule, true, false, LoanApp)

                    end;
                }
            }
        }
    }

    var
        prVitalSetupInfo: Record "PR Vital Setup Info";
        period: Record "PR Payroll Periods";
        transcode: Record "PR Transaction Codes";
        Emptrans: Record "PR Employee Transactions";
        InPeriod: DateFormula;
        Qcounter: Integer;
        GrPrinciple: Integer;
        grinterest: Integer;
        LoansR: Record "prSalary Advance";
        Rschedule: Record "HR Loan Repayment Schedule";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        InitialInstal: Decimal;
        Lbalance: Decimal;
        Rundate: Date;
        InstalNo: Integer;
        TotalMRepay: Decimal;
        RunningDate: Date;
        AmountRequestededitable: Boolean;
        AmountApprovedEditable: Boolean;
        LoanDisbDateEditable: Boolean;
        NoofInstEdiatble: Boolean;
        CarloanEditable: Boolean;
        Logbookeditable: Boolean;
        DriverlicenceNoEditable: Boolean;
        InitialGraceInt: Decimal;
        RepayInterval: DateFormula;
        Qprinciple: Decimal;
        WhichDay: Integer;
        RepayCode: Code[10];
        Lprincipal: Decimal;
        LInterest: Decimal;
        LoanApp: Record "prSalary Advance";
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
}

