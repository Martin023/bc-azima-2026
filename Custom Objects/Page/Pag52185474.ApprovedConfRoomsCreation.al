page 52185474 "Approved Conf Rooms - Creation"
{
    ApplicationArea = All;
    Caption = 'Approved Conf Rooms - Creation';
    PageType = List;
    SourceTable = "Conf & Meeting Rooms List";
    UsageCategory = Lists;
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE(Status = CONST(Approved));
    CardPageId = "Appr Created Conf Rooms - Card";
    
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
