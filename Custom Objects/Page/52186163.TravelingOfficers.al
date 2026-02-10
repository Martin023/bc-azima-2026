page 52187069 "Travelling Officers"
{
    ApplicationArea = All;
    Caption = 'Travelling Officers';
    PageType = List;
    SourceTable = "Travelling Officers";
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Movement No."; Rec."Record No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                }
                // Field("No."; Rec."No.")
                // {
                //     ToolTip = 'Specifies the value of the No. field.';
                // }
                field("Staff Number"; Rec."Staff Number")
                {
                    ToolTip = 'Specifies the value of the Staff Number field.';
                }
                field("Officer's Name"; Rec."Officer's Name")
                {
                    ToolTip = 'Specifies the value of the Officer''s Name field.';
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                    ToolTip = 'Specifies the value of the Department field.';
                }
            }
        }
    }
}
