page 52185485 "Closed Conf Rooms - Creation L"
{
    ApplicationArea = All;
    Caption = 'Closed Conf Rooms - Creation L';
    PageType = List;
    SourceTable = "Conf & Meeting Rooms List";
    UsageCategory = Lists;
    
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE("Room Status" = CONST(Closed));
    InsertAllowed = FALSE;
    DeleteAllowed = FALSE;
    ModifyAllowed = FALSE;
    Editable = FALSE;
    CardPageId = "Closed Conf Rooms - Creation C";
    
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
                field("Room Name"; Rec."Room Name")
                {
                    ToolTip = 'Specifies the value of the Room Name field.';
                }
                field("Room Floor"; Rec."Floor Location")
                {
                }
                field("Rooms Status"; Rec."Room Status")
                {
                    ToolTip = 'Specifies the value of the Rooms Status field.';
                    Editable = False;
                }
                field("Global Dimension 1"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2"; Rec."Global Dimension 2 Code")
                {
                }
            }
        }
    }
}
