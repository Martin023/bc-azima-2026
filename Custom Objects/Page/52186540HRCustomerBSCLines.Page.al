page 52186540 "HR Customer BSC Lines"
{
    PageType = ListPart;
    SourceTable = "HR Individual Target Line";
    SourceTableView = WHERE("Perspective Type" = CONST("Customer and Sales"));
    UsageCategory = Lists;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Perspective Code"; Rec."Perspective Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Perspective Description"; Rec."Perspective Description")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Objective; Rec.Objective)
                {
                    ApplicationArea = Basic;
                    Editable = TargetSettingStatus;
                    Enabled = TargetSettingStatus;
                }
                field(Strategy; Rec.Strategy)
                {
                    ApplicationArea = Basic;
                }
                field(Measures; Rec.Measures)
                {
                    ApplicationArea = Basic;
                }
                field(Baseline; Rec.Baseline)
                {
                    ApplicationArea = Basic;
                }
                field("Targeted Score"; Rec."Targeted Score")
                {
                    ApplicationArea = Basic;
                    Editable = TargetSettingStatus;
                    Enabled = TargetSettingStatus;
                }
                field(Change; Rec.Change)
                {
                    ApplicationArea = Basic;
                }
                field("Quarter 1"; Rec."Quarter 1")
                {
                    ApplicationArea = Basic;
                }
                field("Agreed Mid Year Rating"; Rec."Agreed Mid Year Rating")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Agreed End Year Rating"; Rec."Agreed End Year Rating")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Mid Year Self Rating"; Rec."Mid Year Self Rating")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Mid Year Supervisor Rating"; Rec."Mid Year Supervisor Rating")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Achieved Score"; Rec."Achieved Score")
                {
                    ApplicationArea = Basic;
                    Editable = AppraisalStatus;
                    Enabled = AppraisalStatus;
                }
                field("Unachieved Targets"; Rec."Unachieved Targets")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Quarter 3"; Rec."Quarter 3")
                {
                    ApplicationArea = Basic;
                }
                field("Self Rating"; Rec."Self Rating")
                {
                    ApplicationArea = Basic;
                    Editable = SelfRating;
                    Enabled = SelfRating;
                }
                field("Supervisor Rating"; Rec."Supervisor Rating")
                {
                    ApplicationArea = Basic;
                    Editable = SupervisorRating;
                    Enabled = SupervisorRating;
                }
                field("Agreed Rating"; Rec."Agreed Rating")
                {
                    ApplicationArea = Basic;
                    Editable = AgreedRating;
                    Enabled = AgreedRating;
                }
                field("Appraisee Comments"; Rec."Appraisee Comments")
                {
                    ApplicationArea = Basic;
                    Editable = SelfRating;
                    Enabled = SelfRating;
                }
                field("Appraiser Comments"; Rec."Appraiser Comments")
                {
                    ApplicationArea = Basic;
                    Editable = SupervisorRating;
                    Enabled = SupervisorRating;
                }
                field("Perspective Type"; Rec."Perspective Type")
                {
                    ApplicationArea = Basic;
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

        Rec."Perspective Type" := Rec."Perspective Type"::"Customer and Sales";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        FnEdittableUnedittable;

        Rec."Perspective Type" := Rec."Perspective Type"::"Customer and Sales";
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

