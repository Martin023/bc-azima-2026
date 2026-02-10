page 52187396 "Rejected Vehicle Movt - List"
{
    ApplicationArea = All;
    Caption = 'Rejected Vehicle Movements';
    PageType = List;
    SourceTable = "Vehicle Movement";
    UsageCategory = Lists;
    CardPageID = "Rejected Vehicle Movments Card";

    DeleteAllowed = false;
    Editable = false;
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
                    ToolTip = 'Specifies the value of the Movement No. field.';
                    Editable = false;
                }
                field("Date of Travel"; Rec."Date of Travel")
                {
                    ToolTip = 'Specifies the value of the Date of Travel field.';
                }
                field("Name of Driver"; Rec."Name of Driver")
                {
                    ToolTip = 'Specifies the value of the Name of Driver field.';
                }
                field("Total Distance"; Rec."Total Distance")
                {
                    ToolTip = 'Specifies the value of the Total Distance field.';
                }
                field("Status"; Rec."Status")
                {
                }
            }
        }
    }
}
