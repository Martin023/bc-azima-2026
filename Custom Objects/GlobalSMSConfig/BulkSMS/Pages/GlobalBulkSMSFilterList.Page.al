page 52185548 "Global Bulk SMS Filter List"
{
    PageType = List;
    SourceTable = "Global Bulk SMS Filter";
    Caption = 'Campaign Filters';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Enabled; Rec.Enabled)
                {
                    ApplicationArea = All;
                }
                field("Filter Source"; Rec."Filter Source")
                {
                    ApplicationArea = All;
                }
                field("Field Caption"; Rec."Field Caption")
                {
                    ApplicationArea = All;
                }
                field("Filter Operator"; Rec."Filter Operator")
                {
                    ApplicationArea = All;
                }
                field("Filter Value 1"; Rec."Filter Value 1")
                {
                    ApplicationArea = All;
                }
                field("Filter Value 2"; Rec."Filter Value 2")
                {
                    ApplicationArea = All;
                }
                field("Logical Operator"; Rec."Logical Operator")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = true;
                }
            }
        }
    }
}
