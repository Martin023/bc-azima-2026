page 52187376 "MNS Parking Space List"
{
    ApplicationArea = All;
    Caption = 'Parking Spaces List';
    PageType = List;
    SourceTable = "Parking List Table";
    UsageCategory = Lists;
    CardPageID = "Parking Space Creation";
    DeleteAllowed = false;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No"; Rec.No)
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                }
                field("Parking Area"; Rec."Parking Area")
                {
                    ApplicationArea = All;
                    Caption = 'Parking Area';
                }
                field("Parking Slot Number"; Rec."Parking Slot Number")
                {
                    ApplicationArea = All;
                    Caption = 'Parking Slot No';
                }
                field("Parking Status"; Rec."Parking Slot Status")
                {
                    ApplicationArea = All;
                    Caption = 'Parking Status';
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    Caption = 'Responsibility Center';
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Global Dimension 1 Code';
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Global Dimension 2 Code';
                    Editable = false;
                }
                // field("Created By"; Rec."Created By")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Created By';
                //     Editable = false;
                // }
                // field("Created At";Rec."Created At")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                
                // field("Status"; Rec.Status)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Status';
                // }
                field("Created"; Rec.Created)
                {
                    ApplicationArea = All;
                    Caption = 'Created';
                }
            }
        }
    }
}
