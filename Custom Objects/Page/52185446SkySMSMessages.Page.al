page 52185446 "Sky SMS Messages"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sky SMS Messages";
    SourceTableView = SORTING(date_created)
                      ORDER(Descending)
                      WHERE(msg_general_flag = FILTER(<> 'NOT_MASKED'));
    UsageCategory = Lists;
    ApplicationArea = Basic;
    CardPageId = "Sky SMS Card"; // UAT testing only

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(msg_id; Rec.msg_id)
                {
                    ApplicationArea = Basic;
                }
                field(msg_status_code; Rec.msg_status_code)
                {
                    ApplicationArea = Basic;
                }
                field(msg_status_description; Rec.msg_status_description)
                {
                    ApplicationArea = Basic;
                }
                field(sender; Rec.sender)
                {
                    ApplicationArea = Basic;
                }
                field(receiver; Rec.receiver)
                {
                    ApplicationArea = Basic;
                }
                field(msg; Rec.msg)
                {
                    ApplicationArea = Basic;
                }
                field(msg_type; Rec.msg_type)
                {
                    ApplicationArea = Basic;
                }
                field(msg_priority; Rec.msg_priority)
                {
                    ApplicationArea = Basic;
                }
                field("SMS Date"; Rec."SMS Date")
                {
                    ApplicationArea = Basic;
                }
                field("Account To Charge"; Rec."Account To Charge")
                {
                    ApplicationArea = Basic;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = Basic;
                }
                field(date_created; Rec.date_created)
                {
                    ApplicationArea = Basic;
                }
                field(Finalized; Rec.Finalized)
                {
                    ApplicationArea = Basic;
                }
                field("Split Charge"; Rec."Split Charge")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

