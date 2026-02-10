page 52187088 "Image Data Edits"
{
    ApplicationArea = All;
    Caption = 'Image Data Edits';
    PageType = Card;
    SourceTable = "System Edits Fields";
    
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Record ID"; Rec."Record ID")
                {
                    ToolTip = 'Specifies the value of the Record ID field.';
                    Editable = false;
                }
                field("Old Picture"; Rec."Old Picture")
                {
                    ToolTip = 'Specifies the value of the Old Picture field.';
                    Editable = false;
                }
                field("New Picture"; Rec."New Picture")
                {
                    ToolTip = 'Specifies the value of the New Picture field.';
                }
                
            }
        }
    }
}
