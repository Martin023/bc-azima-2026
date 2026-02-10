page 52186678 "Complains and Remarks Page"
{
    PageType = Card;
    SourceTable = "Complain and Remarks";


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Complaint Catagory"; Rec."Complaint Catagory")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Complain; Rec.Complain)
                {
                    MultiLine = true;
                    ApplicationArea = Basic, Suite;
                }
                field(Suggestion; Rec.Suggestion)
                {
                    MultiLine = true;
                    ApplicationArea = Basic, Suite;
                }
                field("Proposed Resolutions"; Rec."Proposed Resolutions")
                {
                    MultiLine = true;
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }
}

