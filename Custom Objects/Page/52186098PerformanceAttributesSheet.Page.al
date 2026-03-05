page 52186098 "Performance Attributes Sheet"
{
    PageType = ListPart;
    SourceTable = "Performance Attributes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraisal No"; Rec."Appraisal No")
                {
                    ApplicationArea = Basic, Suite;
                }
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
                field("Additional Comments"; Rec."Additional Comments")
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

