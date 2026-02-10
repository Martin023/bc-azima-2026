page 52185531 "Deffered Conf Rooms Creation L"
{
    ApplicationArea = All;
    Caption = 'Deffered Conf Rooms - Creation';
    PageType = List;
    SourceTable = "Conf & Meeting Rooms List";
    UsageCategory = Lists;
    CardPageID = "Deffered Conf Rooms Creation C";
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE("Room Status" = CONST(Closed));
    InsertAllowed = FALSE;
    DeleteAllowed = FALSE;
    ModifyAllowed = FALSE;
    Editable = FALSE;
    
    
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

