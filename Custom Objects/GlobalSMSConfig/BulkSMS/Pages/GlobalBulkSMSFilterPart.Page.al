page 52186073 "Global Bulk SMS Filter Part"
{
    PageType = ListPart;
    SourceTable = "Global Bulk SMS Filter";
    Caption = 'Filters';
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Enabled; Rec.Enabled)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enable or disable this filter line';
                }
                field("Filter Source"; Rec."Filter Source")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Select the table source: Member, Savings Account, or Loan';
                }
                field("Source Table ID"; Rec."Source Table ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field("Field Name"; Rec."Field Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Enter field name manually OR click "Browse Fields" button above to select from list';
                }
                field("Field Caption"; Rec."Field Caption")
                {
                    ApplicationArea = All;
                    ToolTip = 'Auto-filled after Field Name is validated';
                }
                field("Filter Operator"; Rec."Filter Operator")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Select the comparison operator: Equal, Range, Contains, etc.';
                }
                field("Filter Value 1"; Rec."Filter Value 1")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Enter the filter value or starting value for range';
                }
                field("Filter Value 2"; Rec."Filter Value 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'End value for Range operator (only used with Range)';
                }
                field("Logical Operator"; Rec."Logical Operator")
                {
                    ApplicationArea = All;
                    ToolTip = 'How to combine with the next filter: AND (both must match) or OR (either can match)';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = true;
                    ToolTip = 'Auto-generated human-readable description of this filter';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(BrowseFields)
            {
                ApplicationArea = All;
                Caption = 'Browse Fields';
                Image = ListPage;
                ToolTip = 'Open field browser to select a field from the chosen source table';

                trigger OnAction()
                var
                    FieldSelector: Page "Global SMS Field Selector";
                    SelectedFieldName: Text[100];
                    SelectedFieldCaption: Text[100];
                begin
                    if Rec."Source Table ID" = 0 then begin
                        Message('Please select a Filter Source first.');
                        exit;
                    end;

                    FieldSelector.LoadFields(Rec."Source Table ID");
                    FieldSelector.LookupMode(true);

                    if FieldSelector.RunModal() = Action::LookupOK then begin
                        if FieldSelector.GetSelectedField(SelectedFieldName, SelectedFieldCaption) then begin
                            if SelectedFieldName <> '' then begin
                                Rec.Validate("Field Name", SelectedFieldName);
                                CurrPage.Update(true);
                                Message('Field selected: %1', SelectedFieldCaption);
                            end else begin
                                Message('No field was selected.');
                            end;
                        end;
                    end;
                end;
            }

            action(TestFilter)
            {
                ApplicationArea = All;
                Caption = 'Test Filter';
                Image = TestReport;

                trigger OnAction()
                var
                    FilterEngine: Codeunit "Global Filter Engine";
                    MatchCount: Integer;
                begin
                    MatchCount := FilterEngine.TestFilters(Rec."Campaign No.");
                    Message('%1 member(s) match.', MatchCount);
                end;
            }
        }
    }
}
