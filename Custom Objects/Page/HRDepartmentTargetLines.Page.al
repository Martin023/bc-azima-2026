Page 52185503 "Department Target Lines"
{
    Caption = 'Department Target Lines';
    PageType = ListPart;
    SourceTable = "HR Department Target Line";
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Department Target No"; Rec."Department Target No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Perspective Code"; Rec."Perspective Code")
                {
                    ApplicationArea = Basic;
                }
                field("Perspective Description"; Rec."Perspective Description")
                {
                    ApplicationArea = Basic;
                }
                field("Perspective Type"; Rec."Perspective Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Objective; Rec.Objective)
                {
                    ApplicationArea = Basic;
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
                }
                field(Change; Rec.Change)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Achieved Score"; Rec."Achieved Score")
                {
                    ApplicationArea = Basic;
                }
                field("Unachieved Targets"; Rec."Unachieved Targets")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                }
                field(Comments; Rec.Comments)
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
            action("Assign to Employees")
            {
                ApplicationArea = Basic;
                Caption = 'Assign to Employees';
                Image = Allocate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    DeptHeader: Record "HR Department Targets Header";
                begin
                    if not DeptHeader.Get(Rec."Department Target No") then
                        Error('Department Target Header not found.');
                    
                    DeptHeader.AssignLineToEmployees(Rec."Line No");
                    CurrPage.Update(false);
                end;
            }
        }
    }
}