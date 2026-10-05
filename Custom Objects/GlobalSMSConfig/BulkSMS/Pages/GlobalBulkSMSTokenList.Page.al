page 52186128 "Global Bulk SMS Token List"
{
    PageType = List;
    SourceTable = "Global Bulk SMS Token Map";
    Caption = 'Campaign Custom Tokens';

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
                }
                field("Token Description"; Rec."Token Description")
                {
                    ApplicationArea = All;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                }
                field("Source Field Caption"; Rec."Source Field Caption")
                {
                    ApplicationArea = All;
                }
                field("Calculation Type"; Rec."Calculation Type")
                {
                    ApplicationArea = All;
                }
                field("Data Type"; Rec."Data Type")
                {
                    ApplicationArea = All;
                }
                field("Sample Value"; Rec."Sample Value")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
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
