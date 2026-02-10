page 52186467 "General SMS Lines"
{
    ApplicationArea = All;
    Caption = 'Genral SMS Lines';
    PageType = ListPart;
    SourceTable = "General SMS Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Header No"; Rec."Header No")
                {
                    Editable = true;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    Editable = true;
                }
                field(SMS; Rec.SMS)
                {
                    Editable = true;
                }
                field("SMS Sent"; Rec."SMS Sent")
                {
                    ToolTip = 'Specifies the value of the Sent field.';
                    Editable = false;
                }
            }
        }
    }
}
