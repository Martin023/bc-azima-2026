page 52186147 "Proc. Plan Activities Card"
{
    Caption = 'Procurement Plan Activities Card';
    PageType = List;
    SourceTable = "Workplan Activities";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                IndentationColumn = ActivitiesIndent;
                IndentationControls = "Activity Description";
                ShowCaption = false;
                field("Activity Code"; Rec."Activity Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Activity Description"; Rec."Activity Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Default RFP Code"; Rec."Default RFP Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Totaling; Rec.Totaling)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Workplan Code"; Rec."Workplan Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Converted to Budget"; Rec."Converted to Budget")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Strategic Plan Code"; Rec."Strategic Plan Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Strategic Plan Desc"; Rec."Strategic Plan Desc")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Medium term Plan Code"; Rec."Medium term Plan Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Medium term  Plan Desc"; Rec."Medium term  Plan Desc")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("PC Code"; Rec."PC Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("PC Name"; Rec."PC Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Indentation; Rec.Indentation)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Convert)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Convert';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    xRec."Converted to Budget" := false;
                    Workplan.Reset;
                    if Workplan.Find('-') then
                        Rec."Converted to Budget" := true;
                    repeat
                        Rec."Converted to Budget" := true;
                    until Workplan.Next = 0;
                    Rec.Modify;
                    //END;
                end;
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Indent Workplan")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Indent Workplan';
                    RunObject = Codeunit "Workplan Indent";
                }
                action("Import Workplan")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Import Workplan';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ActivitiesIndent := 0;
        WorkPlanCodeOnFormat;
        ActivitiesOnFormat;
        TypeOnFormat;
        TotalingOnFormat;
    end;

    var
        Workplan: Record Workplan;

        "WorkPlan CodeEmphasize": Boolean;

        ActivitiesEmphasize: Boolean;

        ActivitiesIndent: Integer;

        TypeEmphasize: Boolean;

        TotalingEmphasize: Boolean;

    //[Scope('OnPrem')]
    procedure SetSelection(var GLAcc: Record Workplan)
    begin
    end;

    //[Scope('OnPrem')]
    procedure GetSelectionFilter(): Code[80]
    var
        GLAcc: Record Workplan;
        FirstAcc: Text[20];
        LastAcc: Text[20];
        SelectionFilter: Code[80];
        GLAccCount: Integer;
        More: Boolean;
    begin
    end;

    local procedure WorkPlanCodeOnFormat()
    begin
        "WorkPlan CodeEmphasize" := Rec."Account Type" <> Rec."Account Type"::Posting;
    end;

    local procedure ActivitiesOnFormat()
    begin
        ActivitiesIndent := Rec.Indentation;
        ActivitiesEmphasize := Rec."Account Type" <> Rec."Account Type"::Posting;
    end;

    local procedure TypeOnFormat()
    begin
        TypeEmphasize := Rec."Account Type" <> Rec."Account Type"::Posting;
    end;

    local procedure TotalingOnFormat()
    begin
        TotalingEmphasize := Rec."Account Type" <> Rec."Account Type"::Posting;
    end;
}

