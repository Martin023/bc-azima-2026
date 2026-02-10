namespace ALProject.ALProject;

page 52185695 "Clearance List"
{
    ApplicationArea = All;
    Caption = 'Clearance List';
    PageType = List;
    SourceTable = "Hr Employee Exit Interviews";
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Exit Interview No"; Rec."Exit Interview No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Exit Interview No field.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee No. field.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employee Name field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.';
                }
            }
        }
    }
}
