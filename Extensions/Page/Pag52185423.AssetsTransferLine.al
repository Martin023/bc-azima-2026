page 52185576 "Assets Transfer Line"
{
    ApplicationArea = All;
    Caption = 'Assets Transfer Line';
    PageType = ListPart;
    SourceTable = "Asset Transfer Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Asset to Transfer"; Rec."Asset to Transfer")
                {
                    ToolTip = 'Specifies the value of the Asset to Transfer field.';
                }
                field("Asset Description"; Rec."Asset Description")
                {
                    ToolTip = 'Specifies the value of the Asset Description field.';
                    Editable = false;
                }
                field("Current Dimension 1 Code"; Rec."Current Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Dim 1 field.';
                    Editable = false;
                }
                field("Current Dimension 2 Code"; Rec."Current Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the dim 2 field.';
                    Editable = false;
                }
                field("Current Location"; Rec."Current Location")
                {
                    ToolTip = 'Specifies the value of the From Location field.';
                    Editable = false;
                }
                field("Current Responsible Employee"; Rec."Current Responsible Employee")
                {
                    ToolTip = 'Specifies the value of the From Responsible Employee field.';
                    Editable = false;
                }
                field("Current Employee Name"; Rec."Current Employee Name")
                {
                    ToolTip = 'Specifies the value of the To Responsible Employee field.';
                    Editable = false;

                }
                field("To Responsible Employee"; Rec."To Responsible Employee")
                {
                    ToolTip = 'Specifies the value of the To Responsible Employee field.';
                }
                field("To Responsible Employee Name"; Rec."To Responsible Employee Name")
                {
                    ToolTip = 'Specifies the value of the To Location field.';
                    Editable = false;
                }
                field("To Location"; Rec."To Location")
                {
                    ToolTip = 'Specifies the value of the To Location field.';
                }
                field("To Dimension Value 1 code"; Rec."To Dimension Value 1 code")
                {
                    ToolTip = 'Specifies the value of the To Global dim 1 code field.';
                }
                field("To Dimension Value 2 Code"; Rec."To Dimension Value 2 Code")
                {
                    ToolTip = 'Specifies the value of the To Branch field.';
                }
                field(Transferred; Rec.Transferred)
                {
                    Editable = false;
                }
            }
        }
    }
}
