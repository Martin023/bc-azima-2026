page 52185895 "My CEO Goal Assignments"
{
    Caption = 'My CEO Goal Assignments';
    PageType = List;
    SourceTable = "HR CEO Goal HOD Assignment";
    ApplicationArea = Basic;
    UsageCategory = Lists;
    Editable = true;
    PromotedActionCategories = 'New,Process,Report';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Assignment No."; Rec."Assignment No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Goal No."; Rec."Goal No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Appraisal Period Description"; GoalTitle)
                {
                    ApplicationArea = Basic;
                    Caption = 'Goal Title';
                    Editable = false;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Appraisal Year"; Rec."Appraisal Year")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Review Sequence No."; Rec."Review Sequence No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sequence';
                    Editable = false;
                }
                field("Perspective Name"; Rec."Perspective Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Objective; Rec.Objective)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Strategy; Rec.Strategy)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Measures; Rec.Measures)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Baseline; Rec.Baseline)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Targeted Score"; Rec."Targeted Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("HOD Acknowledged"; Rec."HOD Acknowledged")
                {
                    ApplicationArea = Basic;
                    // EDITABLE ONLY WHEN STATUS IS ASSIGNED
                    Editable = Rec.Status = Rec.Status::Assigned;
                    Style = Favorable;
                    StyleExpr = Rec."HOD Acknowledged";
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Favorable;
                    StyleExpr = Rec.Status = Rec.Status::Incorporated;
                }
                field("Acknowledged Date"; Rec."Acknowledged Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Incorporated Into Target No."; Rec."Incorporated Into Target No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("HOD Comments"; Rec."HOD Comments")
                {
                    ApplicationArea = Basic;
                }
                field("CEO Name"; Rec."CEO Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Assigned Date"; Rec."Assigned Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Acknowledge)
            {
                ApplicationArea = Basic;
                Caption = 'Acknowledge Selected';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Acknowledge the selected assignment. Confirms you have received and understood this CEO goal.';

                trigger OnAction()
                begin
                    if Rec.Status <> Rec.Status::Assigned then
                        Error('THIS ASSIGNMENT IS ALREADY %1. ONLY "ASSIGNED" GOALS CAN BE ACKNOWLEDGED.', Rec.Status);

                    if not Confirm('Acknowledge this CEO goal assignment? This confirms you have received and understood the goal "%1".', true, Rec.Objective) then
                        exit;

                    Rec.Validate("HOD Acknowledged", true);
                    Rec.Modify(true);
                    Message('Goal acknowledged successfully.');
                    CurrPage.Update(false);
                end;
            }

            action("Acknowledge All")
            {
                ApplicationArea = Basic;
                Caption = 'Acknowledge All Assigned';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Acknowledge all assignments that are still in Assigned status.';

                trigger OnAction()
                var
                    Assignment: Record "HR CEO Goal HOD Assignment";
                    AckCount: Integer;
                begin
                    if not Confirm('Acknowledge ALL unacknowledged CEO goal assignments assigned to you?', true) then
                        exit;

                    Assignment.Reset();
                    Assignment.CopyFilters(Rec);
                    Assignment.SetRange(Status, Assignment.Status::Assigned);
                    if Assignment.IsEmpty then begin
                        Message('No unacknowledged assignments found.');
                        exit;
                    end;

                    AckCount := 0;
                    if Assignment.FindSet(true) then
                        repeat
                            Assignment.Validate("HOD Acknowledged", true);
                            Assignment.Modify(true);
                            AckCount += 1;
                        until Assignment.Next() = 0;

                    Message('%1 assignment(s) acknowledged.', AckCount);
                    CurrPage.Update(false);
                end;
            }

            action("Import Into Dept Target")
            {
                ApplicationArea = Basic;
                Caption = 'Import into Department Target';
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Import acknowledged CEO goal assignments into a Department Target. Creates the link between CEO goals and HOD department targets.';

                trigger OnAction()
                var
                    Assignment: Record "HR CEO Goal HOD Assignment";
                    DeptTarget: Record "HR Department Targets Header";
                    DeptTargetLine: Record "HR Department Target Line";
                    DeptTargetList: Page "HR Department Targets List";
                    GoalHeader: Record "HR CEO Goals Header";
                    LineNo: Integer;
                    ImportCount: Integer;
                    SelectedTargetNo: Code[20];
                begin
                    // VALIDATE CURRENT RECORD
                    if Rec.Status = Rec.Status::Incorporated then
                        Error('THIS ASSIGNMENT HAS ALREADY BEEN INCORPORATED INTO DEPARTMENT TARGET %1.', Rec."Incorporated Into Target No.");

                    if not Rec."HOD Acknowledged" then
                        Error('YOU MUST ACKNOWLEDGE THIS GOAL BEFORE IMPORTING. USE THE "ACKNOWLEDGE SELECTED" ACTION FIRST.');

                    // GET ALL ACKNOWLEDGED NON-INCORPORATED ASSIGNMENTS FOR THIS GOAL
                    Assignment.Reset();
                    Assignment.SetRange("HOD Employee No.", Rec."HOD Employee No.");
                    Assignment.SetRange("Goal No.", Rec."Goal No.");
                    Assignment.SetRange("HOD Acknowledged", true);
                    Assignment.SetRange(Status, Assignment.Status::Acknowledged);
                    if Assignment.IsEmpty then
                        Error('NO ACKNOWLEDGED ASSIGNMENTS FOUND FOR GOAL %1. ACKNOWLEDGE GOAL LINES BEFORE IMPORTING.', Rec."Goal No.");

                    // SELECT TARGET — FILTER TO HOD'S APPROVED DEPT TARGETS
                    DeptTarget.Reset();
                    DeptTarget.SetRange("Responsibility Center", Rec."Responsibility Center");
                    DeptTarget.SetRange(Status, DeptTarget.Status::Open);
                    if DeptTarget.IsEmpty then
                        Error('NO OPEN DEPARTMENT TARGETS FOUND FOR YOUR DEPARTMENT. CREATE AND OPEN A DEPARTMENT TARGET FIRST.');

                    DeptTargetList.SetTableView(DeptTarget);
                    DeptTargetList.LookupMode(true);
                    if DeptTargetList.RunModal() <> ACTION::LookupOK then
                        exit;

                    DeptTargetList.GetRecord(DeptTarget);
                    SelectedTargetNo := DeptTarget."Target No";

                    if not Confirm('Import CEO goal lines from "%1" into Department Target %2?', true,
                        Rec."Goal No.", SelectedTargetNo) then
                        exit;

                    // GET NEXT LINE NO IN TARGET
                    DeptTargetLine.Reset();
                    DeptTargetLine.SetRange("Department Target No", SelectedTargetNo);
                    if DeptTargetLine.FindLast() then
                        LineNo := DeptTargetLine."Line No"
                    else
                        LineNo := 0;

                    ImportCount := 0;

                    if Assignment.FindSet() then
                        repeat
                            LineNo += 1;
                            DeptTargetLine.Init();
                            DeptTargetLine."Department Target No" := SelectedTargetNo;
                            DeptTargetLine."Line No" := LineNo;
                            DeptTargetLine."Perspective Code" := Assignment."Perspective Code";
                            DeptTargetLine.Objective := Assignment.Objective;
                            DeptTargetLine.Strategy := Assignment.Strategy;
                            DeptTargetLine.Measures := Assignment.Measures;
                            DeptTargetLine.Baseline := Assignment.Baseline;
                            DeptTargetLine."Targeted Score" := Assignment."Targeted Score";
                            DeptTargetLine.Insert(true);

                            // MARK ASSIGNMENT AS INCORPORATED
                            Assignment.MarkAsIncorporated(SelectedTargetNo);
                            ImportCount += 1;
                        until Assignment.Next() = 0;

                    // TAG THE DEPT TARGET WITH SOURCE
                    DeptTarget.Get(SelectedTargetNo);
                    DeptTarget."Source Type" := DeptTarget."Source Type"::"Imported from CEO Goals";
                    DeptTarget."Source CEO Goal No." := Rec."Goal No.";
                    DeptTarget.Modify();

                    Message('%1 CEO goal line(s) imported into Department Target %2 successfully.', ImportCount, SelectedTargetNo);
                    CurrPage.Update(false);
                end;
            }

            group(Filters)
            {
                Caption = 'Filters';

                action("Show Assigned")
                {
                    ApplicationArea = Basic;
                    Caption = 'Assigned';
                    Image = FilterLines;

                    trigger OnAction()
                    begin
                        Rec.SetRange(Status, Rec.Status::Assigned);
                        CurrPage.Update(false);
                    end;
                }
                action("Show Acknowledged")
                {
                    ApplicationArea = Basic;
                    Caption = 'Acknowledged';
                    Image = FilterLines;

                    trigger OnAction()
                    begin
                        Rec.SetRange(Status, Rec.Status::Acknowledged);
                        CurrPage.Update(false);
                    end;
                }
                action("Show Incorporated")
                {
                    ApplicationArea = Basic;
                    Caption = 'Incorporated';
                    Image = FilterLines;

                    trigger OnAction()
                    begin
                        Rec.SetRange(Status, Rec.Status::Incorporated);
                        CurrPage.Update(false);
                    end;
                }
                action("Show All")
                {
                    ApplicationArea = Basic;
                    Caption = 'All';
                    Image = ClearFilter;

                    trigger OnAction()
                    begin
                        Rec.SetRange(Status);
                        CurrPage.Update(false);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        HREmp: Record "HR Employees";
    begin
        // FILTER TO CURRENT USER'S HOD EMPLOYEE NO.
        HREmp.Reset();
        HREmp.SetRange("User ID", UserId);
        if HREmp.FindFirst() then
            Rec.SetRange("HOD Employee No.", HREmp."No.")
        else
            Rec.SetRange("HOD Employee No.", 'DUMMY_NONEXISTENT');
    end;

    trigger OnAfterGetRecord()
    var
        GoalHeader: Record "HR CEO Goals Header";
    begin
        GoalTitle := '';
        if GoalHeader.Get(Rec."Goal No.") then
            GoalTitle := GoalHeader.Title;
    end;

    var
        GoalTitle: Text[100];
}
