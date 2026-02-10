page 52185778 "Dividends Provision List"
{
    CardPageID = "Dividends Provision";
    // DeleteAllowed = false;
    Editable = true;
    // InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Dividends Provision Header";

    layout
    {
        area(content)
        {
            repeater(Group)

            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("End Date"; Rec."End Date")
                {
                }
                field("Total Amount"; Rec."Distributed Amount")
                { }
            }
        }
    }

    actions
    {
    }
}

