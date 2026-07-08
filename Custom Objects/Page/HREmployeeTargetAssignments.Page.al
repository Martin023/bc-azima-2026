page 52185644 "HR Employee Target Assignments"
{
    Caption = 'HR Employee Target Assignments';
    PageType = ListPart;
    SourceTable = "HR Employee Target Assignment";
    ApplicationArea = Basic;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Assignment No"; Rec."Assignment No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Perspective Name"; Rec."Perspective Name")
                {
                    ApplicationArea = Basic;
                }
                field(Objective; Rec.Objective)
                {
                    ApplicationArea = Basic;
                    Width = 30;
                }
                field("Targeted Score"; Rec."Targeted Score")
                {
                    ApplicationArea = Basic;
                }
                field(Baseline; Rec.Baseline)
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = Rec.Status = Rec.Status::Incorporated;
                }
                field("Employee Accepted"; Rec."Employee Accepted")
                {
                    ApplicationArea = Basic;
                }
                field("Incorporated Into Appraisal No"; Rec."Incorporated Into Appraisal No")
                {
                    ApplicationArea = Basic;
                }
                field("Assigned Date"; Rec."Assigned Date")
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
            action("View Details")
            {
                ApplicationArea = Basic;
                Caption = 'View Details';
                Image = View;
                
                trigger OnAction()
                begin
                    PAGE.RunModal(PAGE::"HR Employee Target Assgn Card", Rec);
                end;
            }
        }
    }
}
