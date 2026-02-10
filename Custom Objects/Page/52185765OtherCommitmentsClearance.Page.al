page 52185765 "Other Commitments Clearance"
{
    PageType = List;
    SourceTable = "Other Commitements Clearance";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field("Destination Loan No."; Rec."Destination Loan No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Monthly Deduction"; Rec."Monthly Deduction")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Affects 2/3 Rule"; Rec."Affects 2/3 Rule")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Posted; Rec.Posted) { }
            }
        }
    }

    actions
    {
    }
}

