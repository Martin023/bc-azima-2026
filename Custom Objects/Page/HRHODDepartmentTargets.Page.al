page 52185505 "HRHOD Department Targets"
{
    Caption = 'HOD Department Targets';
    PageType = List;
    SourceTable = "HR Department Targets Header";
    CardPageID = "HR Department Targets Card";
    ApplicationArea = Basic;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Target No"; Rec."Target No")
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Year"; Rec."Appraisal Year")
                {
                    ApplicationArea = Basic;
                }
                field("Review Sequence No"; Rec."Review Sequence No")
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = Rec."Review Sequence No" = 0;
                }
                field("Appraisal Cycle Stage"; Rec."Appraisal Cycle Stage")
                {
                    ApplicationArea = Basic;
                }
                field("HOD Employee No"; Rec."HOD Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("HOD Name"; Rec."HOD Name")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Refresh Period Info")
            {
                ApplicationArea = Basic;
                Caption = 'Refresh Period Info';
                Image = RefreshLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    DeptTarget: Record "HR Department Targets Header";
                    AppraisalPeriodRec: Record "HR Appraisal Period";
                    UpdateCount: Integer;
                begin
                    if not Confirm('This will refresh Review Sequence No and Period dates for all Department Targets with missing information. Continue?', false) then
                        exit;

                    UpdateCount := 0;
                    DeptTarget.Reset;
                    DeptTarget.CopyFilters(Rec);
                    if DeptTarget.FindSet then begin
                        repeat
                            if (DeptTarget."Appraisal Period" <> 0D) then begin
                                if AppraisalPeriodRec.Get(DeptTarget."Appraisal Period") then begin
                                    // ALWAYS UPDATE IF YEAR IS WRONG (26 INSTEAD OF 2026) OR REVIEW SEQ IS 0
                                    if (DeptTarget."Review Sequence No" = 0) or 
                                       (DeptTarget."Appraisal Year" < 1000) or
                                       (DeptTarget."Appraisal Year" <> AppraisalPeriodRec."Appraisal Year") then begin
                                        DeptTarget."Appraisal Year" := AppraisalPeriodRec."Appraisal Year";
                                        DeptTarget."Review Sequence No" := AppraisalPeriodRec."Review Sequence No";
                                        DeptTarget."Appraisal Cycle Stage" := AppraisalPeriodRec."Appraisal Cycle Stage";
                                        DeptTarget."Period Start Date" := AppraisalPeriodRec."Period Start Date";
                                        DeptTarget."Period End Date" := AppraisalPeriodRec."Period End Date";
                                        DeptTarget."Appraisal Period Description" := AppraisalPeriodRec."Appraisal Period Description";
                                        DeptTarget.Modify(true);
                                        UpdateCount += 1;
                                    end;
                                end;
                            end;
                        until DeptTarget.Next = 0;
                    end;

                    Message('%1 Department Target(s) updated with period information.', UpdateCount);
                    CurrPage.Update(false);
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        DeptFilter: Text;
    begin
        HREmp.Reset;
        HREmp.SetRange(HREmp."User ID", UserId);
        if HREmp.Find('-') then begin
            HRHOD.Reset;
            HRHOD.SetRange(HRHOD."Employee No.", HREmp."No.");
            if HRHOD.Find('-') then begin
                DeptFilter := '';
                repeat
                    if DeptFilter = '' then
                        DeptFilter := HRHOD."Responsibility center"
                    else
                        DeptFilter := DeptFilter + '|' + HRHOD."Responsibility center";
                until HRHOD.Next = 0;
                
                Rec.SetFilter("Responsibility Center", DeptFilter);
            end else begin
                Error('You are not assigned as a Head of Department. Please contact HR Administrator.');
            end;
        end else begin
            Error('Your Employee record is not linked to your User ID. Please contact HR Administrator.');
        end;
    end;

    var
        HREmp: Record "HR Employees";
        HRHOD: Record "HR Heads of Departments";
}