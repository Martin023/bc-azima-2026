page 52187393 "Key Details"
{
    ApplicationArea = All;
    Caption = 'Key Details';
    PageType = List;
    SourceTable = "Office Keys List";
    UsageCategory = Lists;
    // CardPageId = "Key Creation Card";
    DeleteAllowed = false;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No.";Rec."No.")
                {
                    ToolTip = 'Specifies the value of the Key Number field.';
                    Editable = false;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.';
                }
                field("Key Category"; Rec."Key Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Key Category field.';
                }
                field("Office/Store/Room Name"; Rec."Office/Store/Room Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Office/Store/Room Name field.';
                }
                field("Floor"; Rec.Floor)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Floor field.';
                }
                field("Number of Keys"; Rec."Key Number")
                {
                    Caption = 'Number of Keys';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Key Number field.';
                }
                field("Key Status"; Rec."Key Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Key Status field.';
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                    Editable = false;
                }
                field("Global Dimension 1 Code";Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                    editable = false;
                }
                field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                    editable = false;
                }
                // FIELD("Created By";Rec."Created By")
                // {
                //     ToolTip = 'Specifies the value of the Created By field.';
                //     editable = false;
                // }
                // field("Created At";Rec."Created at")
                // {
                //     ToolTip = 'Specifies the value of the Created Date field.';
                //     editable = false;
                // }

            }
        }
    }
}
