page 52186022 "SMS Template Token Usage SF"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "SMS Template Token Usage";
    Caption = 'Tokens Used';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Tokens)
            {
                field(Token; Rec.Token)
                {
                    ApplicationArea = All;
                    ToolTip = 'Token used in this template';
                }
                field("Token Description"; Rec."Token Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Description of what this token represents';
                }
                field("Auto Detected"; Rec."Auto Detected")
                {
                    ApplicationArea = All;
                    ToolTip = 'Whether this token was auto-detected in message';
                }
            }
        }
    }
}
