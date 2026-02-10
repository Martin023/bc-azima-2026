page 52187399 "Closed Vehicle Movments - List"
{
    ApplicationArea = All;
    Caption = 'Approved Vehicle Movements';
    PageType = List;
    SourceTable = "Vehicle Movement";
    UsageCategory = Lists;

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    // SourceTableView = SORTING("No.")
    //                   ORDER(Ascending)
    //                   WHERE(Status = CONST(Closed));
    CardPageId = "Closed Vehicle Movements";
    
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

