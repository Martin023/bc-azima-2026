page 52186027 "Contract Documents"
{
    PageType = List;
    SourceTable = "Contract Documents";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("File Location"; Rec."File Location")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Line Type")
            {
                RunObject = Page "Contract Lines Type";
                RunPageLink = "Contract Line Code" = FIELD("Document Type");
            }
        }
    }
}

