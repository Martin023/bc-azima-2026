page 52187369 "Share Certificate Buffer List"
{
    ApplicationArea = All;
    Caption = 'Share Certificate Buffer List';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Share Certificate Buffer";
    Editable = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    
    layout
    {
        area(content)
        {
            repeater(group)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.';
                }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                field("No. of Shares "; Rec."No. of Shares")
                {
                    ToolTip = 'Specifies the value of the No. of Shares  field.';
                }
                field("Shares Recepient Name"; Rec."Shares Recepient Name")
                {
                    ToolTip = 'Specifies the value of the Shares Recepient Name field.';
                }
                field("Shares Recepient No"; Rec."Shares Recepient No")
                {
                    ToolTip = 'Specifies the value of the Shares Recepient No field.';
                }
                field("Transffered Shares"; Rec."Transffered Shares")
                {
                    ToolTip = 'Specifies the value of the Transffered Shares field.';
                }
            }
        }
    }
}
