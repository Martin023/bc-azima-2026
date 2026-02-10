namespace ALProject.ALProject;
using System.Security.User;

page 52186464 "Clearance Form List"
{
    CardPageId="Clearance Form";
    Caption = 'Clearance Form';
    PageType = List;
    SourceTable = "Clearance Form";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Clearance No"; Rec."Clearance No")
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
                field(status; Rec.status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
   

}
