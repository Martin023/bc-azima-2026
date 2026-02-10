page 52187367 "Drivers List"
{
    ApplicationArea = All;
    Caption = 'Drivers List';
    PageType = List;
    SourceTable = "HR Drivers";
    UsageCategory = Lists;
    CardPageID = "HR Drivers Card";
    //DeleteAllowed = true;
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No.";Rec."No.")
                {
                    Caption = 'Driver No.';
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }

                field("Driver Name"; Rec."Driver Name")
                {
                    ToolTip = 'Specifies the value of the Driver Name field.';
                }
                field("Driver Availability"; Rec."Driver Availability")
                {
                    ToolTip = 'Specifies the value of the Driver Availability field.';
                }
                
                field("Driver License Number"; Rec."Driver License Number")
                {
                    ToolTip = 'Specifies the value of the Driver License Number field.';
                }
                // field("No of Trips"; Rec."No of Trips")
                // {
                //     ToolTip = 'Specifies the value of the No of Trip field.';
                // }
                field(Active; Rec.Active)
                {
                    ToolTip = 'Specifies the value of the Active field.';
                }
                field(Status;Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }
}
