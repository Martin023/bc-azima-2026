page 52185687 "Bond Beneficiary Companies"
{
    PageType = List;
    SourceTable = "Bond Company";
    ApplicationArea = Basic, Suite;
    usagecategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Company Code"; Rec."Company Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Cash Cover Required"; Rec."Cash Cover Required")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Max. Perf. Bond without Securi"; Rec."Max. Perf. Bond without Securi")
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

