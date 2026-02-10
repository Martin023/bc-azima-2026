page 52186833 "Employee Groups"
{
    ApplicationArea = All;
    InsertAllowed=true;
    ModifyAllowed=true;
    Caption = 'Employee Groups';
    PageType = List;
    SourceTable = "employee Group";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employee Group"; Rec."Employee Group")
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field("Employee Group Description"; Rec."Employee Group Description")
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Leave days"; Rec."Leave days")
                {
                    ToolTip = 'Specifies the value of the Leave days field.';
                }
                field("Overtime Claim";Rec."Overtime Claim")
                {
                    
                }
            }
        }
    }
}
