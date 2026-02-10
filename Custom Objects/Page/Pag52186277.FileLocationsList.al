namespace MNS.MNS;

page 52186277 "File Locations List"
{
    Caption = 'File Locations List';
    PageType = List;
    SourceTable = "File Locations";
    Editable = true;
    CardPageId = "Files Locations Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("Location Entry"; Rec."Location Entry")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Entry field.';
                }

                field(Building; Rec.Building)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Building field.';
                }
                field(Town; Rec.Town)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Town field.';
                }
                field(Floor; Rec.Floor)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Floor field.';
                }
                // field(Location; Rec.Location)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Location field.';
                // }

            }
        }
    }
}
