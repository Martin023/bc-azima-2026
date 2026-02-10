page 52186161 "Work Plan Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Tender Plan Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Workplan Code"; Rec."Workplan Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Workplan Description"; Rec."Workplan Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Procurement Method"; Rec."Procurement Method")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Procurement Method Name"; Rec."Procurement Method Name")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(Control9; "Tender Subpage")
            {
                SubPageLink = "Tender No." = FIELD("No.");
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
    }
}

