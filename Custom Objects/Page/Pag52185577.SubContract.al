namespace MNS.MNS;

page 52185577 "Sub Contract"
{
    ApplicationArea = All;
    Caption = 'Sub Contract';
    PageType = List;
    SourceTable = "Sub Contracts";
    UsageCategory = Lists;
    DeleteAllowed = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Header Contract No."; Rec."Header Contract No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract No. field.';
                    Editable = false;
                }
                field("Sub Contract No."; Rec."Sub Contract No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sub Contract No. field.';
                }
                field("Contract Description"; Rec."Sub Contract Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Description field.';
                    Editable = false;
                }
                field("Contract Type"; Rec."Sub Contract Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Type field.';
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date field.';
                    Editable = false;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.';
                    Editable = false;
                }
            }
        }
    }
}
