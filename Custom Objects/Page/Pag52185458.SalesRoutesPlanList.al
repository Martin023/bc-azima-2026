namespace AzimaBC.AzimaBC;

page 52185458 "Sales Routes Plan List"
{
    ApplicationArea = All;
    Caption = 'Sales Routes Plan List';
    PageType = List;
    SourceTable = "Sales Route Plans";
    UsageCategory = Lists;
    CardPageId = "Sales Route Plan Card";

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
                field(Desription; Rec.Desription)
                {
                    ToolTip = 'Specifies the value of the Desription field.', Comment = '%';
                }
                field("Place to visit"; Rec."Place to visit")
                {
                    ToolTip = 'Specifies the value of the Place to visit field.', Comment = '%';
                }
                field(Achievements; Rec.Achievements)
                {
                    ToolTip = 'Specifies the value of the Achievements field.', Comment = '%';
                }
                field(Leads; Rec.Leads)
                {
                    ToolTip = 'Specifies the value of the Leads field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
        }
    }
}
