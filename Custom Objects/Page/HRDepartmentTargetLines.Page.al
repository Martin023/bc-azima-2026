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
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Editable = false;
                }
                field("Department Target No"; Rec."Department Target No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                    Editable = false;
                }
                field("Perspective Code"; Rec."Perspective Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Perspective';
                    ShowMandatory = true;
                    
                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Perspective Name"; Rec."Perspective Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Perspective Name';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Objective; Rec.Objective)
                {
                    ApplicationArea = Basic;
                    Caption = 'Objective';
                    ShowMandatory = true;
                    Width = 30;
                }
                field(Strategy; Rec.Strategy)
                {
                    ApplicationArea = Basic;
                    Caption = 'Strategy';
                    Width = 30;
                }
                field(Measures; Rec.Measures)
                {
                    ApplicationArea = Basic;
                    Caption = 'Key Measures';
                    Width = 20;
                }
                field(Baseline; Rec.Baseline)
                {
                    ApplicationArea = Basic;
                    Caption = 'Baseline';
                }
                field("Targeted Score"; Rec."Targeted Score")
                {
                    ApplicationArea = Basic;
                    Caption = 'Target';
                    ShowMandatory = true;
                }
                field("Achieved Score"; Rec."Achieved Score")
                {
                    ApplicationArea = Basic;
                    CaptionClass = GetResultCaption();
                    
                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = Basic;
                    Caption = 'Performance Score %';
                    Editable = false;
                    Style = Favorable;
                    StyleExpr = Rec.Score >= 80;
                }
                field("Unachieved Targets"; Rec."Unachieved Targets")
                {
                    ApplicationArea = Basic;
                    Caption = 'Gap';
                    Editable = false;
                    Visible = false;
                }
                field(Change; Rec.Change)
                {
                    ApplicationArea = Basic;
                    Caption = 'Change';
                    Editable = false;
                    Visible = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Start Date';
                    Visible = false;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'End Date';
                    Visible = false;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = Basic;
                    Caption = 'Comments';
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
                ToolTip = 'Assign this goal to selected employees';

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
    
    local procedure GetResultCaption(): Text
    var
        ResultLabel: Text[50];
    begin
        Rec.CalcFields("Result Label");
        ResultLabel := Rec."Result Label";
        
        if ResultLabel <> '' then
            exit(ResultLabel)
        else
            exit('Achieved');
    end;
}