page 52186155 "My Assigned Targets"
{
    Caption = 'My Assigned Targets';
    PageType = List;
    PromotedActionCategories = 'New,Actions,Report,Views,Filters';
    SourceTable = "HR Employee Target Assignment";
    CardPageID = "HR Employee Target Assgn Card";
    ApplicationArea = Basic;
    UsageCategory = Lists;
    Editable = true;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Assignment No"; Rec."Assignment No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("HOD Name"; Rec."HOD Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Perspective Description"; Rec."Perspective Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Caption = 'Perspective';
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Objective; Rec.Objective)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Width = 40;
                }
                field(Strategy; Rec.Strategy)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Width = 30;
                }
                field("Targeted Score"; Rec."Targeted Score")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Baseline; Rec.Baseline)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Favorable;
                    StyleExpr = Rec.Status = Rec.Status::Incorporated;
                }
                field("Employee Accepted"; Rec."Employee Accepted")
                {
                    ApplicationArea = Basic;
                    Editable = EmployeeCanEdit;
                }
                field("Employee Comments"; Rec."Employee Comments")
                {
                    ApplicationArea = Basic;
                    Editable = EmployeeCanEdit;
                }
                field("Appraisal Year"; Rec."Appraisal Year")
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
            action("Accept Assignment")
            {
                ApplicationArea = Basic;
                Caption = 'Accept Assignment';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = (Rec.Status = Rec.Status::Assigned) and EmployeeCanEdit;

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Assigned then
                        Rec.MarkAsAccepted();
                    CurrPage.Update(false);
                end;
            }
            action("Import to Appraisal")
            {
                ApplicationArea = Basic;
                Caption = 'Import to Appraisal';
                Image = MakeOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = EmployeeCanEdit;

                trigger OnAction()
                var
                    IndivTargetHeader: Record "HR Individual Targets Header";
                    Assignment: Record "HR Employee Target Assignment";
                    AppraisalPeriod: Record "HR Appraisal Period";
                    DeptTargetNo: Code[20];
                    DeptHeader: Record "HR Department Targets Header";
                    AppraisalYear: Integer;
                    ReviewSeqNo: Integer;
                    AppraisalCycleStage: Option "Target Setting","Evaluation Review","Year-End Review";
                    ExistingAppraisal: Record "HR Individual Targets Header";
                    FoundExisting: Boolean;
                begin
                    Assignment.Reset;
                    Assignment.CopyFilters(Rec);
                    Assignment.SetRange("Employee Accepted", true);
                    Assignment.SetFilter(Status, '%1|%2', Assignment.Status::Assigned, Assignment.Status::Accepted);
                    if Assignment.IsEmpty then begin
                        Error('No ACCEPTED targets available to import. Please use "Accept Assignment" button on targets you agree with, then try again.');
                    end;

                    if not Assignment.FindFirst then
                        Error('No target selected.');

                    DeptTargetNo := Assignment."Department Target No";
                    AppraisalYear := Assignment."Appraisal Year";
                    ReviewSeqNo := Assignment."Review Sequence No";
                    AppraisalCycleStage := Assignment."Appraisal Cycle Stage";
                    
                    // VALIDATE ASSIGNMENT HAS CORRECT PERIOD INFO
                    if ReviewSeqNo = 0 then
                        Error('Department Target %1 does not have appraisal period information. Please contact your HOD or HR Administrator.', DeptTargetNo);
                    
                    if AppraisalYear < 1000 then
                        Error('Department Target %1 has invalid appraisal year. Please contact your HOD or HR Administrator.', DeptTargetNo);
                    
                    // VALIDATE DEPARTMENT TARGET HAS CORRECT PERIOD INFO
                    if not DeptHeader.Get(DeptTargetNo) then
                        Error('Department Target %1 not found.', DeptTargetNo);
                    
                    if DeptHeader."Review Sequence No" = 0 then
                        Error('Department Target %1 does not have appraisal period information. Please contact your HOD or HR Administrator.', DeptTargetNo);

                    // CHECK IF TARGETS ALREADY IMPORTED
                    Assignment.Reset;
                    Assignment.CopyFilters(Rec);
                    Assignment.SetRange(Status, Assignment.Status::Incorporated);
                    if not Assignment.IsEmpty then begin
                        if Assignment.FindFirst then
                            Error('These targets have already been imported into Appraisal %1. Open that appraisal to view your targets.', 
                                  Assignment."Incorporated Into Appraisal No");
                    end;

                    // FIND OR CREATE MATCHING APPRAISAL (BY YEAR + REVIEW SEQUENCE)
                    ExistingAppraisal.Reset;
                    ExistingAppraisal.SetRange("Employee No", CurrentEmployeeNo);
                    ExistingAppraisal.SetRange("Appraisal Year", AppraisalYear);
                    ExistingAppraisal.SetRange("Review Sequence No", ReviewSeqNo);
                    ExistingAppraisal.SetFilter(Status, '<>%1', ExistingAppraisal.Status::Posted);
                    FoundExisting := ExistingAppraisal.FindFirst;

                    if FoundExisting then begin
                        if not Confirm('You already have an appraisal (%1) for Year %2 - Review %3 (%4). Import these targets into the EXISTING appraisal?', 
                            true, ExistingAppraisal."Appraisal No", AppraisalYear, ReviewSeqNo, Format(AppraisalCycleStage)) then
                            exit;

                        IndivTargetHeader := ExistingAppraisal;
                    end else begin
                        if not Confirm('This will create a NEW Individual Targets appraisal for Year %1 - Review %2 (%3) and import ACCEPTED targets from Department Target %4. Continue?', 
                            true, AppraisalYear, ReviewSeqNo, Format(AppraisalCycleStage), DeptTargetNo) then
                            exit;

                        IndivTargetHeader.Init;
                        IndivTargetHeader."Appraisal Year" := AppraisalYear;
                        IndivTargetHeader."Review Sequence No" := ReviewSeqNo;
                        IndivTargetHeader."Appraisal Cycle Stage" := AppraisalCycleStage;
                        IndivTargetHeader."Period Start Date" := DeptHeader."Period Start Date";
                        IndivTargetHeader."Period End Date" := DeptHeader."Period End Date";
                        
                        // FIND MATCHING APPRAISAL PERIOD DESCRIPTION
                        AppraisalPeriod.Reset;
                        AppraisalPeriod.SetRange("Appraisal Year", AppraisalYear);
                        AppraisalPeriod.SetRange("Review Sequence No", ReviewSeqNo);
                        if AppraisalPeriod.FindFirst then
                            IndivTargetHeader."Appraisal Period" := AppraisalPeriod."Appraisal Period Description"
                        else
                            Error('No matching Appraisal Period found for Year %1, Review Sequence %2. Please contact HR Administrator.', AppraisalYear, ReviewSeqNo);
                        
                        IndivTargetHeader.Insert(true);
                    end;

                    IndivTargetHeader.ImportFromAssignedTargets(DeptTargetNo);

                    if Confirm('Targets imported successfully into Appraisal %1 (Year %2 - Review %3). Do you want to open it?', 
                        true, IndivTargetHeader."Appraisal No", AppraisalYear, ReviewSeqNo) then
                        PAGE.Run(PAGE::"HR Individual Appraisal Card", IndivTargetHeader);

                    CurrPage.Update(false);
                end;
            }
            action("View Department Target")
            {
                ApplicationArea = Basic;
                Caption = 'View Department Target';
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    DeptHeader: Record "HR Department Targets Header";
                begin
                    if DeptHeader.Get(Rec."Department Target No") then
                        PAGE.Run(PAGE::"HR Department Targets Card", DeptHeader);
                end;
            }
        }
        area(navigation)
        {
            group(Filters)
            {
                Caption = 'Filters';
                action("Show Assigned Only")
                {
                    ApplicationArea = Basic;
                    Caption = 'Show Assigned Only';
                    Image = FilterLines;

                    trigger OnAction()
                    begin
                        Rec.SetRange(Status, Rec.Status::Assigned);
                        CurrPage.Update(false);
                    end;
                }
                action("Show Accepted")
                {
                    ApplicationArea = Basic;
                    Caption = 'Show Accepted';
                    Image = Approve;

                    trigger OnAction()
                    begin
                        Rec.SetRange(Status, Rec.Status::Accepted);
                        CurrPage.Update(false);
                    end;
                }
                action("Show All")
                {
                    ApplicationArea = Basic;
                    Caption = 'Show All';
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
        HREmp.Reset;
        HREmp.SetRange("User ID", UserId);
        if HREmp.FindFirst then begin
            EmployeeCanEdit := true;
            CurrentEmployeeNo := HREmp."No.";
            Rec.SetRange("Employee No", CurrentEmployeeNo);
        end else begin
            EmployeeCanEdit := false;
            Error('Your Employee record is not linked to your User ID. Please contact HR Administrator.');
        end;
    end;

    var
        EmployeeCanEdit: Boolean;
        CurrentEmployeeNo: Code[20];
}
