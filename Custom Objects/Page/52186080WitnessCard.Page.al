page 52186080 "Witness Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = Witnesses;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Case No"; Rec."Case No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Witness Type"; Rec."Witness Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Witness No"; Rec."Witness No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
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

