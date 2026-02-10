page 52186258 "Payment Schedule"
{
    PageType = List;
    SourceTable = "Payment Schedule";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Lease No"; Rec."Lease No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Paid; Rec.Paid)
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

