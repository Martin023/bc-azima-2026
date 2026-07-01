page 52185660 "PR Header Salary Card - ALL"
{

    Caption = 'Salary Card';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Assign Earning/Deduction,Category10_caption';
    SourceTable = "HR Employees";

    layout
    {
        area(content)
        {
            group("Employee Details")
            {
                Caption = 'Employee Details';
                //Editable = false;
                Editable = true;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
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
                field("Date Of Join"; Rec."Date Of Join")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("NSSF No."; Rec."NSSF No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("NHIF No."; Rec."NHIF No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("PIN No."; Rec."PIN No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Salary Grade";Rec."Salary Grade")
                {
                    
                }
                field(Disabled; Rec.Disabled)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employee Type"; Rec."Employee Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Employment Status';
                }
            }
            part(PaymentInfo; "PR Salary Information")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Payment Information';
                ShowFilter = true;
                SubPageLink = "Employee Code" = FIELD("No.");
            }
            group(Posting)
            {
                Caption = 'Posting';
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Assign Earning/Deductions")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Assign Earning/Deductions';
                Image = List;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                RunObject = Page "PR Employee Transactions";
                RunPageLink = "Employee Code" = FIELD("No.");
            }
        }
    }

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
        ProcessPayroll: Codeunit "PR Payroll Processing";
        HrEmployee: Record "HR Employees";
        ProgressWindow: Dialog;
        HREmpPR: Record "HR Employees";
}

