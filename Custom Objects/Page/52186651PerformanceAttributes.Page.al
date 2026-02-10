page 52186651 "Performance Attributes"
{
    PageType = List;
    SourceTable = "Performance Attributes1";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Attribute; Rec.Attribute)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Target; Rec.Target)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Weight; Rec.Weight)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Additonal Comments"; Rec."Additonal Comments")
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

