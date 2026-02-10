page 52186157 "Procurement Methods Sub Page"
{
    PageType = ListPart;
    SourceTable = "Procurement Method Stages";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Minimum Duration"; Rec."Minimum Duration")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Maximum Duration"; Rec."Maximum Duration")
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

