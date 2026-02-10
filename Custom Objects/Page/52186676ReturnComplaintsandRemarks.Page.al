page 52186676 "Return Complaints and Remarks"
{
    CardPageID = "Complains and Remarks Page";
    Editable = false;
    PageType = List;
    SourceTable = "Complain and Remarks";
    SourceTableView = WHERE(Type = CONST("Complains and Remarks"));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Complaint Catagory"; Rec."Complaint Catagory")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Complain; Rec.Complain)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Suggestion; Rec.Suggestion)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }
}

