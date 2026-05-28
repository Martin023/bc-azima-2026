namespace AzimaBC.AzimaBC;

page 52185584 "Commission Generation List"
{
    ApplicationArea = All;
    Caption = 'Commission Generation List';
    PageType = List;
    SourceTable = Commission;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.', Comment = '%';
                }
               

            }
        }
    }
}
