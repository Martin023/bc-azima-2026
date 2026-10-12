page 52186138 "Global Bulk SMS Token Part"
{
    PageType = ListPart;
    SourceTable = "Global Bulk SMS Token Map";
    Caption = 'Custom Tokens';
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Token Code"; Rec."Token Code")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = true;
                    ShowMandatory = true;
                }
                field("Token Description"; Rec."Token Description")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Select the table source: Member Field, Savings Field, or Loan Field';
                }
                field("Source Table ID"; Rec."Source Table ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field("Source Field Name"; Rec."Source Field Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Enter field name manually OR click "Browse Fields" button above to select from list';
                }
                field("Source Field Caption"; Rec."Source Field Caption")
                {
                    ApplicationArea = All;
                    ToolTip = 'Auto-filled after Source Field Name is validated';
                }
                field("Calculation Type"; Rec."Calculation Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'For calculated tokens: Sum, Count, Average, Max, Min';
                }
                field("Data Type"; Rec."Data Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Auto-detected from field type';
                }
                field("Format String"; Rec."Format String")
                {
                    ApplicationArea = All;
                    ToolTip = 'Optional format string for dates, decimals (e.g., <Standard Format,2> for decimals)';
                }
                field("Sample Value"; Rec."Sample Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Click Test Token to populate with real data';
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
                        Message('Please select a Source Type first.');
                        exit;
                    end;

                    FieldSelector.LoadFields(Rec."Source Table ID");
                    FieldSelector.LookupMode(true);

                    if FieldSelector.RunModal() = Action::LookupOK then begin
                        if FieldSelector.GetSelectedField(SelectedFieldName, SelectedFieldCaption) then begin
                            if SelectedFieldName <> '' then begin
                                Rec.Validate("Source Field Name", SelectedFieldName);
                                CurrPage.Update(true);
                                Message('Field selected: %1', SelectedFieldCaption);
                            end else begin
                                Message('No field was selected.');
                            end;
                        end;
                    end;
                end;
            }

            action(TestToken)
            {
                ApplicationArea = All;
                Caption = 'Test Token';
                Image = TestReport;

                trigger OnAction()
                var
                    TestMemberNo: Code[20];
                    TestValue: Text;
                    TestMember: Record Members;
                begin
                    Message('Please select a member to test token value.');
                    if Page.RunModal(Page::"Member List", TestMember) = Action::LookupOK then
                        TestMemberNo := TestMember."No."
                    else
                        exit;

                    if TestMemberNo = '' then
                        Error('Member No. cannot be blank.');

                    TestValue := Rec.TestTokenValue(TestMemberNo);

                    Message('Token %1 for Member %2:\%3', Rec."Token Code", TestMemberNo, TestValue);
                end;
            }
        }
    }
}
