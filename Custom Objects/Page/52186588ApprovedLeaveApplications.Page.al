page 52186588 "Approved Leave Applications"
{
    //CardPageID = "HR Leave Application Card";
    DeleteAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Leave Application";
    SourceTableView = WHERE(Status = FILTER(Approved));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                Editable = false;
                ShowCaption = false;
                field("Application Code"; Rec."Application Code")
                {
                    Caption = 'Application No';
                    ApplicationArea = Basic, Suite;
                }
                field("Applicant Staff No."; Rec."Applicant Staff No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                    ApplicationArea = Basic, Suite;
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Return Date"; Rec."Return Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    Style = Attention;
                    StyleExpr = TRUE;
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(factboxes)
        {
            // part(Control1102755006; "HR Leave Applicaitons Factbox")
            // {
            //     SubPageLink = "No." = FIELD("Applicant Staff No.");
            //     ApplicationArea = Basic, Suite;
            // }
            systempart(Control1102755004; Outlook)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        HREmp.Reset;
        if HREmp.Get(rec."Applicant Staff No.") then begin
            EmpName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
        end else begin
            EmpName := 'n/a';
        end;
    end;

    var
        EmpName: Text;
        HREmp: Record "HR Employees";

    //[Scope('OnPrem')]
    procedure TESTFIELDS()
    begin
        rec.TestField("Leave Type");
        rec.TestField("Days Applied");
        rec.TestField("Start Date");
        rec.TestField(Reliever);
        rec.TestField("Applicant Supervisor");
    end;

    //[Scope('OnPrem')]
    procedure TestLeaveFamily()
    var
        LeaveFamily: Record "HR Leave Family Groups";
        LeaveFamilyEmployees: Record "HR Leave Family Employees";
        Employees: Record "HR Employees";
    begin
        /*
        LeaveFamilyEmployees.SETRANGE(LeaveFamilyEmployees."Employee No","Employee No");
        IF LeaveFamilyEmployees.FINDSET THEN //find the leave family employee is associated with
        REPEAT
          LeaveFamily.SETRANGE(LeaveFamily.Code,LeaveFamilyEmployees.Family);
          LeaveFamily.SETFILTER(LeaveFamily."Max Employees On Leave",'>0');
          IF LeaveFamily.FINDSET THEN //find the status other employees on the same leave family
            BEGIN
              Employees.SETRANGE(Employees."No.",LeaveFamilyEmployees."Employee No");
              Employees.SETRANGE(Employees."Leave Status",Employees."Leave Status"::"0");
              IF Employees.COUNT>LeaveFamily."Max Employees On Leave" THEN
              ERROR('The Maximum number of employees on leave for this family has been exceeded, Contact th HR manager for more information');
            END
        UNTIL LeaveFamilyEmployees.NEXT = 0;
        */

    end;
}

