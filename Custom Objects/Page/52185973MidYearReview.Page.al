page 52185973 "Mid Year Review"
{
    PageType = ListPart;
    SourceTable = "HR Individual Target Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Perspective Code"; Rec."Perspective Code")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Perspective Description"; Rec."Perspective Description")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field(Objective; Rec.Objective)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = TargetSettingStatus;
                    Enabled = TargetSettingStatus;
                }
                field(Strategy; Rec.Strategy)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Measures; Rec.Measures)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Baseline; Rec.Baseline)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = BaselineScore;
                    Enabled = BaselineScore;
                }
                field("Targeted Score"; Rec."Targeted Score")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = TargetSettingStatus;
                    Enabled = TargetSettingStatus;
                }
                field(Change; Rec.Change)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = ChangeScore;
                    Enabled = ChangeScore;
                }
                field("Agreed Mid Year Rating"; Rec."Agreed Mid Year Rating")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Agreed End Year Rating"; Rec."Agreed End Year Rating")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Mid Year Self Rating"; Rec."Mid Year Self Rating")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Mid Year Supervisor Rating"; Rec."Mid Year Supervisor Rating")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Achieved Score"; Rec."Achieved Score")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = AppraisalStatus;
                    Enabled = AppraisalStatus;
                }
                field("Unachieved Targets"; Rec."Unachieved Targets")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Self Rating"; Rec."Self Rating")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = SelfRating;
                    Enabled = SelfRating;
                }
                field("Supervisor Rating"; Rec."Supervisor Rating")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = SupervisorRating;
                    Enabled = SupervisorRating;
                }
                field("Agreed Rating"; Rec."Agreed Rating")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = AgreedRating;
                    Enabled = AgreedRating;
                }
                field("Appraisee Comments"; Rec."Appraisee Comments")
                {
                    ApplicationArea = Basic, Suite;
                    caption = 'Appraisee Comments(Achievements/Challenges/Recommendations)';
                    Editable = SelfRating;
                    Enabled = SelfRating;
                }
                field("Appraiser Comments"; Rec."Appraiser Comments")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = SupervisorRating;
                    Enabled = SupervisorRating;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        FnEdittableUnedittable;
    end;

    trigger OnInit()
    begin
        FnEdittableUnedittable;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        FnEdittableUnedittable;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        FnEdittableUnedittable;
    end;

    trigger OnOpenPage()
    begin
        FnEdittableUnedittable;
    end;

    var
        TargetSettingStatus: Boolean;
        AppraisalStatus: Boolean;
        SupervisorRating: Boolean;
        AgreedRating: Boolean;
        SelfRating: Boolean;
        ChangeScore: Boolean;
        BaselineScore: Boolean;
        HeaderRec: Record "HR Individual Targets Header";

    local procedure FnEdittableUnedittable()
    var
        IsAppraisee: Boolean;
        IsSupervisor: Boolean;
    begin
        if HeaderRec.Get(Rec."Appraisal No") then;

        IsAppraisee := (UserId = HeaderRec."User ID");
        IsSupervisor := (UserId = HeaderRec."Supervisor ID");

        // TARGET SETTING STAGE - Only editable when Status = Open
        if (HeaderRec."Appraisal Cycle Stage" = HeaderRec."Appraisal Cycle Stage"::"Target Setting") and (HeaderRec.Status = HeaderRec.Status::Open) then begin
            TargetSettingStatus := true;
            AppraisalStatus := false;
            SupervisorRating := false;
            AgreedRating := false;
            SelfRating := false;
            BaselineScore := false;
            ChangeScore := false;

        end else
            // EVALUATION REVIEW STAGE
            if (HeaderRec."Appraisal Cycle Stage" = HeaderRec."Appraisal Cycle Stage"::"Evaluation Review") then begin
                TargetSettingStatus := false;
                BaselineScore := false;
                ChangeScore := false;
                AppraisalStatus := false;

                // Status = Open: Employee can edit Self Rating
                if HeaderRec.Status = HeaderRec.Status::Open then begin
                    SelfRating := IsAppraisee;
                    SupervisorRating := false;
                    AgreedRating := false;
                end else
                    // Status = Pending Approval or Discussed: Supervisor can edit Supervisor Rating and Achieved Score
                    if HeaderRec.Status in [HeaderRec.Status::"Pending Approval", HeaderRec.Status::Discussed] then begin
                        SelfRating := false;
                        SupervisorRating := IsSupervisor;
                        AgreedRating := false;
                        AppraisalStatus := IsSupervisor; // Achieved Score
                    end else begin
                        // Status = Approved or Posted: All locked
                        SelfRating := false;
                        SupervisorRating := false;
                        AgreedRating := false;
                    end;

            end else
                // YEAR-END REVIEW STAGE
                if (HeaderRec."Appraisal Cycle Stage" = HeaderRec."Appraisal Cycle Stage"::"Year-End Review") then begin
                    TargetSettingStatus := false;
                    BaselineScore := false;
                    ChangeScore := false;

                    // Status = Open: Employee can edit Self Rating
                    if HeaderRec.Status = HeaderRec.Status::Open then begin
                        SelfRating := IsAppraisee;
                        SupervisorRating := false;
                        AgreedRating := false;
                        AppraisalStatus := false;
                    end else
                        // Status = Pending Approval or Discussed: Supervisor can edit all rating fields
                        if HeaderRec.Status in [HeaderRec.Status::"Pending Approval", HeaderRec.Status::Discussed] then begin
                            SelfRating := false;
                            SupervisorRating := IsSupervisor;
                            AgreedRating := IsSupervisor;
                            AppraisalStatus := IsSupervisor; // Achieved Score
                        end else begin
                            // Status = Approved or Posted: All locked
                            SelfRating := false;
                            SupervisorRating := false;
                            AgreedRating := false;
                            AppraisalStatus := false;
                        end;
                end;
    end;
}

