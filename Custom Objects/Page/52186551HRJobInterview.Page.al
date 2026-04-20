page 52186551 "HR Job Interview"
{
    PageType = List;
    SourceTable = "HR Job Interview";
    UsageCategory = Lists;
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Applicant No";Rec."Applicant No")
                {
                  ApplicationArea = Basic;  
                }
                field("Requisition No."; Rec."Requisition No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ToolTip = 'Shows the employee requisition this interview is linked to';
                }
                field("Interview Code"; Rec."Interview Code")
                {
                    ApplicationArea = Basic;
                }
                field("Interview Description"; Rec."Interview Description")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic;
                }
                field(Interviewer; Rec.Interviewer)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Interviewer Name"; Rec."Interviewer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Applicants)
            {
                Caption = 'Applicants';
                action("Hiring Criteria")
                {
                    ApplicationArea = Basic;
                    Caption = 'Hiring Criteria';
                    Image = Agreement;
                    Promoted = true;
                    RunObject = Page "HR Hiring Criteria";
                    RunPageLink = "Application Code" = FIELD("Applicant No");
                }
            }
        }
    }
}

