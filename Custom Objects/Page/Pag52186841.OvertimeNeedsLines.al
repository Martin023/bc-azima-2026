page 52186842 OvertimeNeedsLines
{
    ApplicationArea = All;
    Caption = 'OvertimeNeedsLines';
    PageType = ListPart;
    SourceTable = "Overtime Need Request Lines";

    layout
    {
        area(content)
        {
            repeater(group)
            {


                field("Staff No"; Rec."Staff No")
                {
                    ToolTip = 'Specifies the value of the Staff No field.';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Staff Name field.';
                }

                field("responsibility centre"; Rec."responsibility centre")
                {
                    ToolTip = 'Specifies the value of the responsibility centre field.';
                    editable = false;
                }
            }
        }
    }
}
