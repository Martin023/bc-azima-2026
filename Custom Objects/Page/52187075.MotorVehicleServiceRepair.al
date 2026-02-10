page 52187076 "Motor Vehicle Repair"
{
    ApplicationArea = All;
    Caption = 'Motor Vehicle Repair';
    PageType = List;
    SourceTable = "Maintain Machne/Vehicles";
    Editable = False;
    InsertAllowed = true;
    LinksAllowed = false;
    //ModifyAllowed = true;
    CardPageId = "Vehicles Repair";
    DeleteAllowed = False;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Repair No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the Service No. field.';
                    Caption = 'Repair No.';
                    Editable = false;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ToolTip = 'Specifies the value of the Vehicle No. field.';
                    Editable = false;
                }
                field("Asset No."; Rec."Asset No.")
                {
                    ToolTip = 'Specifies the value of the Asset No. field.';
                }
                field("Car Registration Number"; Rec."Registration No.")
                {
                    ToolTip = 'Specifies the value of the Car Registration Number field.';
                }
                field("Repair Date"; Rec."Repair Date")
                {
                    ToolTip = 'Specifies the value of the Repair Date field.';
                }
                field("Driver No,"; Rec."Driver No.")
                {
                    Caption ='Driver Staff No.';
                }
                field("Driver Pf No."; Rec."Driver Pf No.")
                {
                    ToolTip = 'Specifies the value of the Driver Pf No. field.';
                    Editable = false;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    Editable = false;
                }
                field("Garage/Workshop"; Rec."Repair Garage/Workshop")
                {
                    ToolTip = 'Specifies the value of the Repair Garage/Workshop field.';
                }
                field("Description of Repair"; Rec."Description of Repair")
                {
                    ToolTip = 'Specifies the value of the Description of Repair field.';
                    //MultiLine = true;
                }
                field("Cost of Repairs"; Rec."Repair Cost")
                {
                    ToolTip = 'Specifies the value of the Repair Cost field.';
                }
                field(Status;Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Captured By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                    Editable = false;
                }
            }
        }
    }
}
