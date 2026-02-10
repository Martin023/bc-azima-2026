
page 52186110 "Defined SLA List"
{
    ApplicationArea = All;
    Caption = 'Defined SLA List';
    PageType = List;
    SourceTable = 52186018;
    UsageCategory = Administration;
    CardPageId = "Defined SLA Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(SLA; Rec.SLA)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SLA field.';
                }
                field("Origination Type"; Rec."Origination Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Application field.';
                }
                field(Commission;Rec.Commission)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Commission field.';
                }
            }
        }
    }
}
