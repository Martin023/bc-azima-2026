page 52185781 "HR CEO Goals Card"
{
    Caption = 'CEO Goals Card';
    PageType = Card;
    SourceTable = "HR CEO Goals Header";
    PromotedActionCategories = 'New,Process,Report,Approval,Assignment';
    ApplicationArea = Basic;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General Information';

                field("Goal No."; Rec."Goal No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = Basic;
                    Editable = Rec.Status = Rec.Status::Open;
                    ShowMandatory = true;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = Basic;
                    Editable = Rec.Status = Rec.Status::Open;
                    ShowMandatory = true;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        AppraisalPeriodRec: Record "HR Appraisal Period";
                        AppraisalPeriodPage: Page "HR Appraisal Period Setup";
                    begin
                        AppraisalPeriodRec.Reset();
                        AppraisalPeriodPage.SetTableView(AppraisalPeriodRec);
                        AppraisalPeriodPage.LookupMode(true);
                        if AppraisalPeriodPage.RunModal() = ACTION::LookupOK then begin
                            AppraisalPeriodPage.GetRecord(AppraisalPeriodRec);
                            Rec.Validate("Appraisal Period", AppraisalPeriodRec."Appraisal Period");
                            CurrPage.Update(true);
                        end;
                    end;
                }
                field("Appraisal Period Description"; Rec."Appraisal Period Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Period Description';
                    Style = Subordinate;
                    StyleExpr = true;
                }
                field("Review Sequence No."; Rec."Review Sequence No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Review Sequence';
                    ToolTip = 'Q1=1, Q2=2, Q3=3, Q4=4';
                }
                field("Appraisal Cycle Stage"; Rec."Appraisal Cycle Stage")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Appraisal Year"; Rec."Appraisal Year")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;
                }
                field("CEO Employee No."; Rec."CEO Employee No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("CEO Name"; Rec."CEO Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Total Goal Lines"; Rec."Total Goal Lines")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total HOD Assignments"; Rec."Total HOD Assignments")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Favorable;
                    StyleExpr = Rec."Total HOD Assignments" > 0;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }

            group("Strategic Goals")
            {
                Caption = 'Strategic Goal Lines';

                part("Goal Lines"; "HR CEO Goal Lines")
                {
                    ApplicationArea = Basic;
                    SubPageLink = "Goal No." = FIELD("Goal No.");
                    UpdatePropagation = Both;
                    Enabled = Rec.Status = Rec.Status::Open;
                }
            }

            group("HOD Assignments")
            {
                Caption = 'HOD Assignments';

                part(Assignments; "HR CEO Goal HOD Assignments")
                {
                    ApplicationArea = Basic;
                    SubPageLink = "Goal No." = FIELD("Goal No.");
                    UpdatePropagation = Both;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Approve)
            {
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = Rec.Status = Rec.Status::Open;
                ToolTip = 'Approve these CEO goals. Once approved, lines can be assigned to HODs.';

                trigger OnAction()
                var
                    GoalLine: Record "HR CEO Goal Line";
                begin
                    Rec.TestField("Goal No.");
                    Rec.TestField(Title);
                    Rec.TestField("Appraisal Period");

                    GoalLine.Reset();
                    GoalLine.SetRange("Goal No.", Rec."Goal No.");
                    if GoalLine.IsEmpty then
                        Error('CANNOT APPROVE: NO GOAL LINES HAVE BEEN ADDED. ADD AT LEAST ONE STRATEGIC OBJECTIVE BEFORE APPROVING.');

                    if not Confirm('Approve CEO Goals "%1"? Once approved the goal lines can be assigned to HODs.', true, Rec.Title) then
                        exit;

                    Rec.Status := Rec.Status::Approved;
                    Rec."Approved By" := UserId;
                    Rec."Approved Date" := Today;
                    Rec.Modify();
                    Message('CEO Goals approved. You can now assign goal lines to HODs.');
                    CurrPage.Update(false);
                end;
            }

            action(Reopen)
            {
                Caption = 'Reopen';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = Rec.Status = Rec.Status::Approved;
                ToolTip = 'Reopen for editing. Only possible if no assignments have been made.';

                trigger OnAction()
                var
                    Assignment: Record "HR CEO Goal HOD Assignment";
                begin
                    Assignment.Reset();
                    Assignment.SetRange("Goal No.", Rec."Goal No.");
                    if not Assignment.IsEmpty then
                        Error('CANNOT REOPEN: HOD ASSIGNMENTS ALREADY EXIST. REMOVE ALL ASSIGNMENTS BEFORE REOPENING.');

                    if not Confirm('Reopen CEO Goals "%1" for editing?', true, Rec.Title) then
                        exit;

                    Rec.Status := Rec.Status::Open;
                    Rec."Approved By" := '';
                    Rec."Approved Date" := 0D;
                    Rec.Modify();
                    CurrPage.Update(false);
                end;
            }

            group("Assignment Actions")
            {
                Caption = 'Assign to HODs';

                action("Assign Selected Line to HODs")
                {
                    Caption = 'Assign Selected Line to HODs';
                    Image = Allocate;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Enabled = Rec.Status = Rec.Status::Approved;
                    ToolTip = 'Assign the currently selected goal line to one or more HODs.';

                    trigger OnAction()
                    var
                        SelectedLine: Record "HR CEO Goal Line";
                        Assignment: Record "HR CEO Goal HOD Assignment";
                        HRHOD: Record "HR Heads of Departments";
                        TempHOD: Record "HR Heads of Departments" temporary;
                        HODSelectionPage: Page "HR Head of Departments List";
                        AssignCount: Integer;
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);

                        // GET THE LINE SELECTED IN THE SUBPART
                        CurrPage."Goal Lines".Page.GetSelectedLine(SelectedLine);

                        if SelectedLine."Goal No." = '' then
                            Error('PLEASE SELECT A GOAL LINE FROM THE LIST BEFORE USING THIS ACTION.');

                        // OPEN HOD SELECTION
                        HRHOD.Reset();
                        HODSelectionPage.SetTableView(HRHOD);
                        HODSelectionPage.LookupMode(true);
                        if HODSelectionPage.RunModal() <> ACTION::LookupOK then
                            exit;

                        HODSelectionPage.GetRecord(HRHOD);

                        // CREATE ASSIGNMENT IF NOT DUPLICATE
                        Assignment.Reset();
                        Assignment.SetRange("Goal No.", Rec."Goal No.");
                        Assignment.SetRange("Goal Line No.", SelectedLine."Line No.");
                        Assignment.SetRange("HOD Employee No.", HRHOD."Employee No.");
                        if not Assignment.IsEmpty then begin
                            Message('THIS GOAL LINE HAS ALREADY BEEN ASSIGNED TO HOD %1 (%2).', HRHOD."Employee Name", HRHOD."Employee No.");
                            exit;
                        end;

                        Clear(Assignment);
                        Assignment.Init();
                        Assignment."Goal No." := Rec."Goal No.";
                        Assignment.Validate("Goal No.");
                        Assignment."Goal Line No." := SelectedLine."Line No.";
                        Assignment.Validate("Goal Line No.");
                        Assignment."HOD Employee No." := HRHOD."Employee No.";
                        Assignment.Validate("HOD Employee No.");
                        Assignment.Insert(true);

                        Message('Goal line "%1" assigned to HOD %2 successfully.', SelectedLine.Objective, HRHOD."Employee Name");
                        CurrPage.Update(false);
                    end;
                }

                action("Assign All Lines to One HOD")
                {
                    Caption = 'Assign All Lines to One HOD';
                    Image = Allocate;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Enabled = Rec.Status = Rec.Status::Approved;
                    ToolTip = 'Assign ALL goal lines to one selected HOD.';

                    trigger OnAction()
                    var
                        GoalLine: Record "HR CEO Goal Line";
                        Assignment: Record "HR CEO Goal HOD Assignment";
                        HRHOD: Record "HR Heads of Departments";
                        HODSelectionPage: Page "HR Head of Departments List";
                        AssignCount: Integer;
                        SkipCount: Integer;
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);

                        GoalLine.Reset();
                        GoalLine.SetRange("Goal No.", Rec."Goal No.");
                        if GoalLine.IsEmpty then
                            Error('NO GOAL LINES FOUND. ADD GOAL LINES BEFORE ASSIGNING.');

                        HRHOD.Reset();
                        HODSelectionPage.SetTableView(HRHOD);
                        HODSelectionPage.LookupMode(true);
                        if HODSelectionPage.RunModal() <> ACTION::LookupOK then
                            exit;

                        HODSelectionPage.GetRecord(HRHOD);

                        AssignCount := 0;
                        SkipCount := 0;

                        if GoalLine.FindSet() then
                            repeat
                                Assignment.Reset();
                                Assignment.SetRange("Goal No.", Rec."Goal No.");
                                Assignment.SetRange("Goal Line No.", GoalLine."Line No.");
                                Assignment.SetRange("HOD Employee No.", HRHOD."Employee No.");
                                if Assignment.IsEmpty then begin
                                    Clear(Assignment);
                                    Assignment.Init();
                                    Assignment."Goal No." := Rec."Goal No.";
                                    Assignment.Validate("Goal No.");
                                    Assignment."Goal Line No." := GoalLine."Line No.";
                                    Assignment.Validate("Goal Line No.");
                                    Assignment."HOD Employee No." := HRHOD."Employee No.";
                                    Assignment.Validate("HOD Employee No.");
                                    Assignment.Insert(true);
                                    AssignCount += 1;
                                end else
                                    SkipCount += 1;
                            until GoalLine.Next() = 0;

                        if AssignCount > 0 then
                            Message('%1 goal line(s) assigned to %2. %3 already existed and were skipped.',
                                AssignCount, HRHOD."Employee Name", SkipCount)
                        else
                            Message('No new assignments created. %1 already has all goal lines assigned.', HRHOD."Employee Name");

                        CurrPage.Update(false);
                    end;
                }

                action("Assign All Lines to All HODs")
                {
                    Caption = 'Assign All Lines to All HODs';
                    Image = SendTo;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Enabled = Rec.Status = Rec.Status::Approved;
                    ToolTip = 'Assign lines marked "All HODs" to every registered HOD at once.';

                    trigger OnAction()
                    var
                        GoalLine: Record "HR CEO Goal Line";
                        HRHOD: Record "HR Heads of Departments";
                        Assignment: Record "HR CEO Goal HOD Assignment";
                        AssignCount: Integer;
                        SkipCount: Integer;
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);

                        GoalLine.Reset();
                        GoalLine.SetRange("Goal No.", Rec."Goal No.");
                        GoalLine.SetRange("Applies To", GoalLine."Applies To"::"All HODs");
                        if GoalLine.IsEmpty then
                            Error('NO LINES MARKED "ALL HODs" FOUND. SET "APPLIES TO" = "ALL HODs" ON RELEVANT LINES FIRST.');

                        HRHOD.Reset();
                        if HRHOD.IsEmpty then
                            Error('NO HEADS OF DEPARTMENTS ARE REGISTERED. PLEASE CONFIGURE HODs FIRST.');

                        if not Confirm('This will assign all "All HODs" lines to every registered HOD. Continue?', true) then
                            exit;

                        AssignCount := 0;
                        SkipCount := 0;

                        if GoalLine.FindSet() then
                            repeat
                                HRHOD.Reset();
                                if HRHOD.FindSet() then
                                    repeat
                                        Assignment.Reset();
                                        Assignment.SetRange("Goal No.", Rec."Goal No.");
                                        Assignment.SetRange("Goal Line No.", GoalLine."Line No.");
                                        Assignment.SetRange("HOD Employee No.", HRHOD."Employee No.");
                                        if Assignment.IsEmpty then begin
                                            Clear(Assignment);
                                            Assignment.Init();
                                            Assignment."Goal No." := Rec."Goal No.";
                                            Assignment.Validate("Goal No.");
                                            Assignment."Goal Line No." := GoalLine."Line No.";
                                            Assignment.Validate("Goal Line No.");
                                            Assignment."HOD Employee No." := HRHOD."Employee No.";
                                            Assignment.Validate("HOD Employee No.");
                                            Assignment.Insert(true);
                                            AssignCount += 1;
                                        end else
                                            SkipCount += 1;
                                    until HRHOD.Next() = 0;
                            until GoalLine.Next() = 0;

                        Message('%1 assignment(s) created across all HODs. %2 already existed and were skipped.',
                            AssignCount, SkipCount);
                        CurrPage.Update(false);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        CanEdit := CheckEditAccess();
    end;

    trigger OnAfterGetRecord()
    begin
        CanEdit := CheckEditAccess();
    end;

    local procedure CheckEditAccess(): Boolean
    var
        HREmp: Record "HR Employees";
    begin
        // CEO IS THE CREATOR — ONLY THEY CAN EDIT
        HREmp.Reset();
        HREmp.SetRange("User ID", UserId);
        if HREmp.FindFirst() then
            exit(HREmp."No." = Rec."CEO Employee No.");
        exit(false);
    end;

    var
        CanEdit: Boolean;
}
