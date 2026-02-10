page 52185974 "End Year Review"
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
                    Editable = SelfRating;
                    Enabled = SelfRating;
                }
                field("Appraiser Comments"; Rec."Appraiser Comments")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = SupervisorRating;
                    Enabled = SupervisorRating;
                }
                field("Perspective Type"; Rec."Perspective Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
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

        Rec."Perspective Type" := Rec."Perspective Type"::"Training and Development";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        FnEdittableUnedittable;

        Rec."Perspective Type" := Rec."Perspective Type"::"Training and Development";
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

    //[Scope('OnPrem')]
    procedure FnEdittableUnedittable()
    begin
        Rec.CalcFields("Appraisal Type", Status);

        if (Rec."Appraisal Type" = Rec."Appraisal Type"::"Target Setting") then begin
            TargetSettingStatus := true;
            AppraisalStatus := false;
            SupervisorRating := false;
            AgreedRating := false;
            SelfRating := false;
        end else
            if (Rec."Appraisal Type" = Rec."Appraisal Type"::"Quarter 1") then begin
                TargetSettingStatus := false;
                AppraisalStatus := false;
                SupervisorRating := true;
                AgreedRating := false;
                SelfRating := true;
            end else
                if (Rec."Appraisal Type" = Rec."Appraisal Type"::"Appraisal Review") then begin
                    TargetSettingStatus := false;
                    AppraisalStatus := true;
                    SupervisorRating := false;
                    AgreedRating := true;
                    SelfRating := false;
                end;


        /*
         IF ("Appraisal Type"="Appraisal Type"::"Appraisal Review") AND (Status=Status::Open) THEN BEGIN
         TargetSettingStatus:=TRUE;
         AppraisalStatus:=FALSE;
         SupervisorRating:=FALSE;
         AgreedRating:=FALSE;
         SelfRating:=FALSE;
         END ELSE
         IF ("Appraisal Type"="Appraisal Type"::"Appraisal Review") AND (Status<>Status::Open) THEN BEGIN
         TargetSettingStatus:=FALSE;
         AppraisalStatus:=FALSE;
         SupervisorRating:=FALSE;
         AgreedRating:=FALSE;
         SelfRating:=FALSE;
         END ELSE
         IF (("Appraisal Type"="Appraisal Type"::"Target Setting") OR ("Appraisal Type"="Appraisal Type"::"End Year Appraisal"))
          AND (Status=Status::Open) THEN BEGIN
         TargetSettingStatus:=FALSE;
         AppraisalStatus:=TRUE;
         SupervisorRating:=FALSE;
         AgreedRating:=FALSE;
         SelfRating:=TRUE;
         END ELSE
         IF (("Appraisal Type"="Appraisal Type"::"Target Setting") OR ("Appraisal Type"="Appraisal Type"::"End Year Appraisal"))
         AND (Status=Status::"Pending Approval") THEN BEGIN
         TargetSettingStatus:=FALSE;
         AppraisalStatus:=FALSE;
         SupervisorRating:=TRUE;
         AgreedRating:=TRUE;
         SelfRating:=FALSE;
         END ELSE
         IF (("Appraisal Type"="Appraisal Type"::"Target Setting") OR ("Appraisal Type"="Appraisal Type"::"End Year Appraisal"))
         AND (Status=Status::Approved) THEN BEGIN
         TargetSettingStatus:=FALSE;
         AppraisalStatus:=FALSE;
         SupervisorRating:=FALSE;
         AgreedRating:=FALSE;
         SelfRating:=FALSE;
         END;
         IF (Status=Status::Posted) THEN BEGIN
         TargetSettingStatus:=FALSE;
         AppraisalStatus:=FALSE;
         SupervisorRating:=FALSE;
         AgreedRating:=FALSE;
         SelfRating:=FALSE;
         END
        */

    end;
}

