page 52187097 "Actioned Cases"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "DMU Case Forwarding";
    CardPageId = "DMU CF Page";
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTableView = where("Case Closed" = const(true));
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                }
                field("Send/Forward to"; Rec."Send/Forward to")
                {

                }

                field("Open Issues"; Rec."Open Issues")
                {
                    Editable = false;
                }
                field("Originating Department"; Rec."Originating Department")
                {
                    Editable = false;
                }
                field("Current Departmrnt"; Rec."Current Departmrnt")
                {
                    Editable = false;
                }
                field("Originating Status"; Rec."Originating Status")
                {
                    Editable = false;
                }
                field("Recepient Status"; Rec."Recepient Status")
                {
                    Editable = false;
                }
                field("Viewed By Recepient";Rec."Viewed By Recepient")
                {
                    Editable = false;
                }
                
            }
        }
    }
}
