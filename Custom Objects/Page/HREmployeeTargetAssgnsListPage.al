page 52185636 "HR Employee Target Assgns List"
{
    Caption = 'Employee Target Assignments';
    PageType = List;
    SourceTable = "HR Employee Target Assignment";
    CardPageID = "HR Employee Target Assgn Card";
    ApplicationArea = Basic;
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Assignment No"; Rec."Assignment No")
                {
                    ApplicationArea = Basic;
                }
                field("Department Target No"; Rec."Department Target No")
                {
                    ApplicationArea = Basic;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = Basic;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = Basic;
                }
                field("Perspective Description"; Rec."Perspective Description")
                {
                    ApplicationArea = Basic;
                }
                field(Objective; Rec.Objective)
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
                field("Employee Accepted"; Rec."Employee Accepted")
                {
                    ApplicationArea = Basic;
                }
                field("Appraisal Year"; Rec."Appraisal Year")
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
            action("Accept Assignment")
            {
                ApplicationArea = Basic;
                Caption = 'Accept Assignment';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = Rec.Status = Rec.Status::Assigned;

                trigger OnAction()
                begin
                    Rec.MarkAsAccepted();
                    CurrPage.Update(false);
                end;
            }
        }
    }
}
