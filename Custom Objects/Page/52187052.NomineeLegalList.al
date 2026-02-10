page 52187052 "Nominee Legal List"
{
    ApplicationArea = All;
    Caption = 'Nominee Legal List';
    PageType = List;
    SourceTable = "Nominee Legal";
    UsageCategory = Lists;
    CardPageID = "Nominee Legal Card";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Member No."; Rec."Member No.")
                {
                    ToolTip = 'Specifies the value of the Member No. field.';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.';
                }
            }
        }
    }
}
