page 52187373 "Rejected Parking Space - List"
{
    ApplicationArea = All;
    Caption = 'Rejected Parking Space - List';
    PageType = List;
    SourceTable = "Parking Space";
    UsageCategory = Lists;
    CardPageId = "Rejected Parking Space - Card";
    DeleteAllowed = False;
    Editable = False;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE(Status = CONST(Rejected)); 

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
            }
        }
    }
}

