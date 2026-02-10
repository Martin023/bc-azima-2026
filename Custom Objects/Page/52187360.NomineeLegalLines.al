page 52187360 "Nominee Legal Lines"
{
    ApplicationArea = All;
    Caption = 'Nominee Legal Lines ';
    PageType = ListPart;
    SourceTable = "Nominee Lines Table";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                }
                field("Nominee Name"; Rec."Nominee Name")
                {
                    ToolTip = 'Specifies the value of the Nominee Name field.';
                    Editable = false;
                }
                field(Allocation; Rec.Allocation)
                {
                    ToolTip = 'Specifies the value of the Allocation field.';
                    Editable = false;
                }
                field(Removed;  Rec.Removed)
                {
                    ToolTip = 'Specifies the value of the Updated field.';
                    Editable = false;
                }
                field(Deceased;Rec.Deceased)
                {
                    ToolTip = 'Specifies the value of the Deceased field.';
                    Editable = false;
                }
            }
        }
    }
}
