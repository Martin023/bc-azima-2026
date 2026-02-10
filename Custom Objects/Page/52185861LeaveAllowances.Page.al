page 52185861 "Leave Allowances"
{
    PageType = List;
    SourceTable = "Leave Allowances";
    SourceTableView = WHERE(Paid = CONST(false));
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Paid; Rec.Paid)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Posted"; Rec."Date Posted")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control13; Outlook)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control14; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Job)
            {
                action("Post Leave")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Post Leave';
                    Image = PostBatch;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    begin
                        if Confirm('Do You want to Post the Leave Allowances?', false) = false then
                            Error('Process Aborted');
                        PRTrans.Reset;
                        PRTrans.SetRange(PRTrans."IsLeave Allowance", true);
                        if PRTrans.Find('-') then begin
                            PRPeriod.Reset;
                            PRPeriod.SetRange(PRPeriod.Closed, false);
                            if PRPeriod.Find('-') then begin
                                LeaveAllowances.Reset;
                                LeaveAllowances.SetRange(LeaveAllowances.Paid, false);
                                if LeaveAllowances.Find('-') then begin
                                    repeat
                                        PREmpTrans.Reset;
                                        // PREmpTrans.SETRANGE(PREmpTrans."Employee Code",LeaveAllowances."Employee No.");
                                        //  PREmpTrans.SETRANGE(PREmpTrans."Payroll Period",PRPeriod."Date Opened");
                                        // IF PREmpTrans.FIND('-') THEN
                                        begin
                                            PREmpTrans.Init;
                                            PREmpTrans."Employee Code" := LeaveAllowances."Employee No.";
                                            PREmpTrans."Transaction Code" := PRTrans."Transaction Code";
                                            PREmpTrans."Period Month" := PRPeriod."Period Month";
                                            PREmpTrans."Period Year" := PRPeriod."Period Year";
                                            PREmpTrans."Payroll Period" := PRPeriod."Date Opened";
                                            PREmpTrans."Transaction Name" := PRTrans."Transaction Name";
                                            PREmpTrans.Amount := LeaveAllowances.Amount;
                                            PREmpTrans.Insert;
                                            LeaveAllowances.Paid := true;
                                            LeaveAllowances.Modify;
                                        end
                                    until LeaveAllowances.Next = 0;
                                end;
                                Message('Successfully Posted Leave Allowances');
                            end else begin
                                Error('No Payroll Period is open');
                            end;

                        end else begin
                            Error('No Transaction code found')
                        end
                    end;
                }
            }
        }
    }

    var
        PREmpTrans: Record "PR Employee Transactions";
        PRPeriod: Record "PR Payroll Periods";
        PRTrans: Record "prTransaction Codes";
        LeaveAllowances: Record "Leave Allowances";
        prVitalSetup: Record "PR Vital Setup Info";
}

