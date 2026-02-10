page 52186317 "BBF Entitlement List"
{
    PageType = List;
    SourceTable = "BBF Entitlement";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Relationship Type"; Rec."Relationship Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Claim Option"; Rec."Claim Option")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Claim Type"; Rec."Claim Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("SACCO Max. Allowed";Rec."SACCO Max. Allowed")
                {

                }
                field("Insurance Max. Allowed";Rec."Insurance Max. Allowed")
                {
                    
                }

            }
        }
    }

    actions
    {
    }
}

