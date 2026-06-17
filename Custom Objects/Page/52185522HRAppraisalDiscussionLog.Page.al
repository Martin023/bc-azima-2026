page 52185522 "HR Appraisal Discussion Log"
{
    PageType = ListPart;
    SourceTable = "HR Appraisal Discussion Log";
    Caption = 'Discussion Log';
    AutoSplitKey = true;
    DelayedInsert = true;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Discussion Date"; Rec."Discussion Date")
                {
                    ApplicationArea = Basic;
                }
                field("Discussion Time"; Rec."Discussion Time")
                {
                    ApplicationArea = Basic;
                }
                field("Point Category"; Rec."Point Category")
                {
                    ApplicationArea = Basic;
                }
                field("Discussion Point"; Rec."Discussion Point")
                {
                    ApplicationArea = Basic;
                }
                field("Raised By"; Rec."Raised By")
                {
                    ApplicationArea = Basic;
                }
                field("Raised By User ID"; Rec."Raised By User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Response"; Rec."Response")
                {
                    ApplicationArea = Basic;
                }
                field("Response By"; Rec."Response By")
                {
                    ApplicationArea = Basic;
                }
                field("Response By User ID"; Rec."Response By User ID")
                {
                    ApplicationArea = Basic;
                }
                field("Response Date"; Rec."Response Date")
                {
                    ApplicationArea = Basic;
                }
                field(Resolved; Rec.Resolved)
                {
                    ApplicationArea = Basic;
                }
                field("Resolution Notes"; Rec."Resolution Notes")
                {
                    ApplicationArea = Basic;
                }
                field("Target Line No"; Rec."Target Line No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        AppraisalHeader: Record "HR Individual Targets Header";
    begin
        Rec."Discussion Date" := Today;
        Rec."Discussion Time" := Time;
        Rec."Raised By User ID" := UserId;

        if AppraisalHeader.Get(Rec."Appraisal No") then begin
            if UserId = AppraisalHeader."User ID" then
                Rec."Raised By" := Rec."Raised By"::Appraisee
            else if UserId = AppraisalHeader."Supervisor ID" then
                Rec."Raised By" := Rec."Raised By"::Appraiser;
        end;
    end;
}
