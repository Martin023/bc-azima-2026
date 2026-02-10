page 52187366 "Vehicle Servicing List Page"
{
    ApplicationArea = All;
    Caption = 'Vehicle Servicing';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Vehicle Servicing Table";
    CardPageID = "Vehicle Servicing Card Page";
    //AutoSplitKey = true;
    //DelayedInsert = true;
    Editable = false;
    DeleteAllowed = false;
    // InsertAllowed = true;
    // LinksAllowed = false;
    // ModifyAllowed = true;

    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                // field("Record ID"; Rec."Record ID")
                // {
                //     Editable = false;
                // }
                field(No; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No field.';
                    Editable = false;
                }
                field("Vehicle No"; Rec."Registration No.")
                {
                    ToolTip = 'Specifies the value of the Vehicle No field.';
                    Editable = false;
                }
                field("Service Date";Rec."Service Date")
                {
                    ToolTip = 'Specifies the value of the Service Date field.';
                }
                field("Driver No,"; Rec."Supervisor Staff No.")
                {
                    Caption = 'Driver No.';
                }
                field("Driver Name"; Rec."Supervisor Name")
                {
                    Caption = 'Driver Name';
                    Editable = false;
                }
                //field("Service Vendor No.";Rec."Service Vendor No."){}
                field("Service Garage/Workshop"; Rec."Service Garage/Workshop")
                {
                    ToolTip = 'Specifies the value of the Service Garage/Workshop field.';
                }
                field("Service description"; Rec."Service description")
                {
                    ToolTip = 'Specifies the value of the Service description field.';
                }
                field("Last service date"; Rec."Last service date")
                {
                    ToolTip = 'Specifies the value of the Last service date field.';
                    ShowMandatory = true;
                }
                // field("Next Service Date"; Rec."Next Service Date")
                // {
                //     ToolTip = 'Specifies the value of the Next Service Date field.';
                // }
                field("Next Service Mileage"; Rec."Next Service Mileage")
                {
                    ToolTip = 'Specifies the value of the Next Service Mileage field.';
                }
                field(Status;Rec.Status)
                {
                    Editable = false;
                }
                // field("Created at"; Rec."Created at")
                // {
                //     Editable = false;
                // }
                field("Created By"; Rec."Created by")
                {
                    Editable = false;
                }

            }
        }
    }
}
