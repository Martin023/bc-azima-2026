namespace mns.mns;
using System.Automation;

page 52185452 "Hr Leave Application List All"

{
    CardPageID = "HR Leave Application Card";
    DeleteAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "HR Leave Application";
    //SourceTableView = WHERE(Status = FILTER(<> Approved));
    UsageCategory = Lists;
    ApplicationArea = Basic;

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
                    ApplicationArea = Basic;
                    Caption = 'Application No';
                }
                field("Applicant Staff No."; Rec."Applicant Staff No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Names; Rec.Names)
                {
                    ApplicationArea = Basic;
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    ApplicationArea = Basic;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Return Date"; Rec."Return Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755006; "HR Leave Applications Factbox")
            {
                ApplicationArea = Basic;
                SubPageLink = "No." = FIELD("Applicant Staff No.");
            }
            systempart(Control1102755004; Outlook)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Update Doc No")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    Buffer: Record "Buffer table";
                    Buffer_3: Record "Buffer table";
                begin
                    ApprovalEntry.Reset;
                    ApprovalEntry.SetRange("Table ID", 39003925);
                    ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Created); //This will only select the first creaed entry
                    ApprovalEntry.FindFirst;
                    repeat
                        Buffer.Reset;
                        Buffer.Init;

                        Buffer."Entry No" := ApprovalEntry."Entry No.";
                        Buffer."Doc No" := Format(ApprovalEntry."Record ID to Approve", 0, 1) + '[]';
                        Buffer."Counter Variable" := LastLineNo;

                        //Duplicates
                        Buffer_3.Reset;
                        Buffer_3.SetRange("Doc No", Format(ApprovalEntry."Record ID to Approve", 0, 1));
                        if not Buffer_3.Find('-') then Buffer.Insert; //Since we are skipping duplicates wont be there
                                                                      //meaning the remaining  created entries wont be in our list. we will only get the 1st one


                    until ApprovalEntry.Next = 0;
                    Message('Done %1 Update', ApprovalEntry.Count);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        // HREmp.Reset;
        // if HREmp.Get(Rec."Applicant Staff No.") then begin
        //     EmpName := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
        // end else begin
        //     EmpName := 'n/a';
        // end;
    end;



    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // xRec.Reset;
        // xRec.SetRange(xRec."Applicant User ID", UserId);
        // xRec.SetRange(xRec.Status, xRec.Status::New);
        // if xRec.Find('-') then
        //     Error('You still have a new leave application no' + ' ' + xRec."Application Code" + 'that needs to be utilized first');

        // xRec.Reset;
        // xRec.SetRange(xRec."Applicant User ID", UserId);
        // xRec.SetRange(xRec.Status, xRec.Status::"Pending Approval");
        // if xRec.Find('-') then
        //     Error('You your leave application no' + ' ' + xRec."Application Code" + 'is still  pending Approval. Kindy Contact the HR department to have it approved first')
    end;

    trigger OnOpenPage()
    begin
        //Rec.SetFilter("Applicant User ID", UserId);
    end;

    var
        EmpName: Text;
        HREmp: Record "HR Employees";

    //[Scope('OnPrem')]
    procedure TESTFIELDS()
    begin
        Rec.TestField("Leave Type");
        Rec.TestField("Days Applied");
        Rec.TestField("Start Date");
        Rec.TestField(Reliever);
        Rec.TestField("Applicant Supervisor");
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

    local procedure LastLineNo(): Integer
    var
        Buffer_2: Record "Buffer table";
    begin
        Buffer_2.Reset;
        if Buffer_2.FindLast then begin
            exit(Buffer_2."Counter Variable" + 1);
        end else begin
            exit(1);
        end;
    end;
}

