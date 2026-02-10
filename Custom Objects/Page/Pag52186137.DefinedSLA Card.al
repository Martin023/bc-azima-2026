
page 52186137 "Defined SLA Card"
{
    Caption = 'Defined SLA Card';
    PageType = Card;
    SourceTable = 52186018;
    
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                
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
            }
        }
    }
}
