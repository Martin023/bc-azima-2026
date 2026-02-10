page 52186155 "Workplan Budget Creation"
{
    PageType = List;
    SourceTable = "Procur. Plan Budget Allocation";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Analysis Area"; Rec."Analysis Area")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Workplan Code';
                }
                field("Current G/L Budget"; Rec."Current G/L Budget")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Current Item Budget"; Rec."Current Item Budget")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Business Unit"; Rec."Business Unit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Budget Dimension 1 Code"; Rec."Budget Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Budget Dimension 1 Code';
                    Enabled = FieldsEditable;
                    Visible = FieldsEditable;
                }
                field("Budget Dimension 2 Code"; Rec."Budget Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Budget Dimension 2 Code';
                    Enabled = FieldsEditable;
                    Visible = FieldsEditable;
                }
                field("Budget Dimension 3 Code"; Rec."Budget Dimension 3 Code")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Budget Dimension 3 Code';
                    Enabled = FieldsEditable;
                    Visible = FieldsEditable;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Period Type"; Rec."Period Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Overwrite; Rec.Overwrite)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Process)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Process';
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField("Start Date");
                    Rec.TestField("End Date");
                    if Confirm('Process Allocation?', false) = false then begin
                        Error('Processing Aborted');
                        exit;
                    end else begin
                        fnProcessAllocation;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        Budget.Reset;
        Budget.SetRange(Budget."Workplan Code", Rec.Name);
        if Budget.Find('-') then begin
            //Check if the budget dimension 1 is to be enabled
            if Budget."Budget Dimension 1 Code" = '' then begin
                FieldsEditable := false;
            end
            else begin
                FieldsEditable := true;
            end;
            if Budget."Budget Dimension 2 Code" = '' then begin
                FieldsEditable := false;
            end
            else begin
                FieldsEditable := true;
            end;
            if Budget."Budget Dimension 3 Code" = '' then begin
                FieldsEditable := false;
            end
            else begin
                FieldsEditable := true;
            end;
        end;
    end;

    var
        Budget: Record Workplan;
        FieldsEditable: Boolean;
    // BudgetAllocation: Codeunit "WP Budget Allocation";

    //[Scope('OnPrem')]
    procedure fnProcessAllocation()
    begin
        Rec.SetRange("Line No.", Rec."Line No.");
        //BudgetAllocation.CreateBudgetFromWorkplan(Rec);here
    end;
}

