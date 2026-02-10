page 52187073 "Motor Vehicle Fueling List"
{
    ApplicationArea = All;
    Caption = 'Motor Vehicle Fueling List';
    PageType = List;
    SourceTable = "HR Fuel Management Header";
    UsageCategory = Lists;
    CardPageId = "HR Fuel Management Card";
    DeleteAllowed = false;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field("Fuel Type"; Rec."Fuel Type")
                {
                    ToolTip = 'Specifies the value of the Fuel Type field.';
                }
                field("Type of Payment"; Rec."Type Of Payment")
                {
                }
                field("Driver Staff No."; Rec."Driver Staff No.")
                {
                    ToolTip = 'Specifies the value of the Driver Staff No. field.';
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ToolTip = 'Specifies the value of the Driver Name field.';
                }
                field("Vehicle Registration No."; Rec."Vehicle Registration No.")
                {
                    ToolTip = 'Specifies the value of the Vehicle Registration No. field.';
                }
                field("Date of Fuleing"; Rec."Date of Fueling")
                {
                    ToolTip = 'Specifies the value of the Date of Fuleing field.';
                }
                field("Created On"; Rec."Created at")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }
}
