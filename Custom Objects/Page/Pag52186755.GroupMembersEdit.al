namespace KenpipeBC.KenpipeBC;

page 52186755 "Group Members Edit"
{
    Caption = 'Group Members Edit';
    PageType = ListPart;
    SourceTable = "Group Members Edit";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Header No."; Rec."Header No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Header No. field.', Comment = '%';
                    Editable = false;
                }
                // field("Entry No."; Rec."Entry No.")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                // }
                field("Group No."; Rec."Group No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Group No. field.', Comment = '%';
                    Editable = false;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No field.', Comment = '%';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Name field.', Comment = '%';
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ID No. field.', Comment = '%';
                }
                field("KRA PIN"; Rec."KRA PIN")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the KRA PIN field.', Comment = '%';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. field.', Comment = '%';
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Designation field.', Comment = '%';
                }
                field("Must Be Present"; Rec."Must Be Present")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Must Be Present field.', Comment = '%';
                }
                field(Signatory; Rec.Signatory)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Signatory field.', Comment = '%';
                }
                field("Exited"; Rec."Exited")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Exited field.', Comment = '%';
                }
                field(Transferred; Rec.Transferred)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
