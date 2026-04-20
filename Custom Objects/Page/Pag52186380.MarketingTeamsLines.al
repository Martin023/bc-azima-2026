namespace AzimaCBS.AzimaCBS;

page 52186380 "Marketing Teams Lines"
{
    ApplicationArea = All;
    Caption = 'Marketing Teams Lines';
    PageType = ListPart;
    SourceTable = "Marketing Teams Lines";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Member No"; Rec."Member No")
                {
                    ToolTip = 'Specifies the value of the Member No field.', Comment = '%';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ToolTip = 'Specifies the value of the Member Name field.', Comment = '%';
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designatiom field.', Comment = '%';
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Location field.', Comment = '%';
                }
                field(Branch; Rec.Branch)
                {
                    ToolTip = 'Specifies the value of the Phone field.', Comment = '%';
                }
            }
        }
    }
}
