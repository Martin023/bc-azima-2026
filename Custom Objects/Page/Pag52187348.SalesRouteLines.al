namespace AZIMA.AZIMA;

page 52187348 "Sales Route Lines"
{
    ApplicationArea = All;
    Caption = 'Sales Route Lines';
    PageType = ListPart;
    SourceTable = "Sales Route Lines";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Route Date"; Rec."Route Date")
                {
                    ToolTip = 'Specifies the value of the Route Date field.', Comment = '%';
                }
                field(Day; Rec.Day)
                {
                    ToolTip = 'Specifies the value of the Day field.', Comment = '%';
                }
                field("Place to Visit"; Rec."Place to Visit")
                {
                    ToolTip = 'Specifies the value of the Place to Visit field.', Comment = '%';
                }
                field(Target; Rec.Target)
                {
                    ToolTip = 'Specifies the value of the Target field.', Comment = '%';
                }
            }
        }
    }
}
