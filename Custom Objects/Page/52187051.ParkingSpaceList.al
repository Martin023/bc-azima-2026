page 52187051 "Parking Space List"
{
    ApplicationArea = All;
    Caption = 'Parking Space List';
    PageType = List;
    SourceTable = "Parking Space";
    UsageCategory = Lists;
    CardPageId = "Parking Space Card";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Client"; Rec."Client")
                {
                    ToolTip = 'Specifies the value of the Client field.';
                }
                field("Parking Area"; Rec."Parking Area")
                {
                    ToolTip = 'Specifies the value of the Parking Area field.';
                }
                field("Parking Slot"; Rec."Parking Slot")
                {
                    ToolTip = 'Specifies the value of the Parking Slot field.';
                }
                field("Parking Slot Number Allocated"; Rec."Parking Slot Number Allocated")
                {
                    ToolTip = 'Specifies the value of the Parking Slot Number Allocated field.';
                }
                field("Staff Full Name"; Rec."Staff Full Name")
                {
                    ToolTip = 'Specifies the value of the Staff Full Name field.';
                }
                field("Staff Department"; Rec."Staff Department")
                {
                    ToolTip = 'Specifies the value of the Staff Department field.';
                }
                field("External Client Details"; Rec."External Client Details")
                {
                    ToolTip = 'Specifies the value of the External Client Details field.';
                }
                field("Reallocated"; Rec."Realocated")
                {
                    Caption = 'Reallocated';
                    ToolTip = 'Specifies the value of the Reallocated field.';
                }
                field("Booking Status"; Rec."Booking Status")
                {
                    ToolTip = 'Specifies the value of the Booking Status field.';
                }
                field(Status;Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Created at"; Rec."Created at")
                {
                    ToolTip = 'Specifies the value of the Created at field.';
                }
            }
        }
    }
}
