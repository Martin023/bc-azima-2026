page 52187384 "Closed Vehicle Req - List"
{
    ApplicationArea = All;
    Caption = 'Closed Vehicle Req - List';
    PageType = List;
    SourceTable = "Motor Vehicle Request";
    UsageCategory = Lists;
    
    DeleteAllowed = False;
    Editable = False;
    InsertAllowed = false;
    ModifyAllowed = false;
    CardPageId = "Deffered Vehicle Req - Card";
        SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE(Status = CONST(Closed)); 

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
                field(Destination; Rec.Destination)
                {
                    ToolTip = 'Specifies the value of the Destination field.';
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ToolTip = 'Specifies the value of the Staff Name field.';
                }
                field("Type of Travel"; Rec."Type of Travel")
                {
                    ToolTip = 'Specifies the value of the Type of Travel field.';
                }
            }
        }
    }
}
