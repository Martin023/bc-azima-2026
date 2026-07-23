page 52185792 "HR CEO Goal HOD Assignments"
{
    Caption = 'HOD Assignments';
    PageType = ListPart;
    SourceTable = "HR CEO Goal HOD Assignment";
    ApplicationArea = Basic;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Assignments)
            {
                field("Assignment No."; Rec."Assignment No.")
                {
                    ApplicationArea = Basic;
                }
                field("Goal Line No."; Rec."Goal Line No.")
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
                }
                field("HOD Employee No."; Rec."HOD Employee No.")
                {
                    ApplicationArea = Basic;
                }
                field("HOD Name"; Rec."HOD Name")
                {
                    ApplicationArea = Basic;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = Basic;
                }
                field("Targeted Score"; Rec."Targeted Score")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = Rec.Status = Rec.Status::Incorporated;
                }
                field("HOD Acknowledged"; Rec."HOD Acknowledged")
                {
                    ApplicationArea = Basic;
                }
                field("Acknowledged Date"; Rec."Acknowledged Date")
                {
                    ApplicationArea = Basic;
                }
                field("Incorporated Into Target No."; Rec."Incorporated Into Target No.")
                {
                    ApplicationArea = Basic;
                }
                field("Incorporated Date"; Rec."Incorporated Date")
                {
                    ApplicationArea = Basic;
                }
                field("HOD Comments"; Rec."HOD Comments")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
}
