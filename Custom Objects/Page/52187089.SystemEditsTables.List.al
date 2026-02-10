page 52187089 "System Edits Tables"
{
    ApplicationArea = All;
    Caption = 'System Edits Tables';
    PageType = List;
    SourceTable = "System Edits Tables";
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Table ID"; Rec."Table ID")
                {
                    ToolTip = 'Specifies the value of the Table ID field.';
                }
                field("Table Name"; Rec."Table Name")
                {
                    ToolTip = 'Specifies the value of the Table Name field.';
                }
                field("Table Caption"; Rec."Table Caption")
                {
                    ToolTip = 'Specifies the value of the Table Caption field.';
                }
                field(Activated; Rec.Activated)
                {
                    ToolTip = 'Specifies the value of the Activate field.';
                }
            }
        }
    }
}
