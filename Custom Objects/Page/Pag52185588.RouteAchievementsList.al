namespace AzimaBC.AzimaBC;

page 52185588 "Route Achievements List"
{
    ApplicationArea = All;
    Caption = 'Route Achievements List';
    PageType = ListPart;
    SourceTable = "Route Achievements";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ToolTip = 'Specifies the value of the No field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }
}
