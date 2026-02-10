page 52185685 "Bond Security List"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Bond Security";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bond No."; Rec."Bond No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Security Details"; Rec."Security Details")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Value; Rec.Value)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Guarantee Value"; Rec."Guarantee Value")
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

