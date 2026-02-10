page 52187361 "Other Party Lines"
{
    ApplicationArea = All;
    Caption = 'Other Party';
    PageType = ListPart;
    SourceTable = "Accident Lines Table";
    UsageCategory = Lists;
    DeleteAllowed = false;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Accident No."; Rec."Accident No.")
                {
                    ToolTip = 'Specifies the value of the Accident No. field.';
                }
                // field("Code"; Rec."Code")
                // {
                //     ToolTip = 'Specifies the value of the Code field.';
                // }
                
                field("Driver Name"; Rec."Driver Name")
                {
                    ToolTip = 'Specifies the value of the Driver Name field.';
                    ShowMandatory = True;
                }
                field("Driver ID No."; Rec."Driver ID No.")
                {
                    ToolTip = 'Specifies the value of the Driver ID No. field.';
                    
                }
                field("Driver License No."; Rec."Driver License No.")
                {
                    ToolTip = 'Specifies the value of the Driver License No. field.';
                }
                field("Vehicle Make"; Rec."Vehicle Make")
                {
                    ToolTip = 'Specifies the value of the MNS Vehicle Make field.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field.';
                    ShowMandatory = True;
                }
                field("Vehicle Insurance"; Rec."Vehicle Insurance")
                {
                    ToolTip = 'Specifies the value of the Vehicle Insurance field.';
                    ShowMandatory = True;
                }
                field("Insurance Policy No."; Rec."Insurance Policy No.")
                {
                    ToolTip = 'Specifies the value of the Insurance Policy No. field.';
                }
                field("Vehicle Reg No."; Rec."Vehicle No.")
                {
                    ToolTip = 'Specifies the value of the Vehicle No. field.';
                }
                field("Captured On"; Rec. "Captured On")
                {
                    Editable = false;
                }
                field("Captured By"; Rec. "Captured By")
                {
                    Editable = false;
                }
            }
        }
    }
}
