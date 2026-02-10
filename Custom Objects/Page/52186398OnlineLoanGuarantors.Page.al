page 52186398 "Online Loan Guarantors"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Online Loan Guarantors";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan Application No"; Rec."Loan Application No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Guarantor No."; Rec."Guarantor No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Guarantor Names"; Rec."Guarantor Names")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Guarantor ID No"; Rec."Guarantor ID No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Guarantor Phone"; Rec."Guarantor Phone")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Guarantor Email"; Rec."Guarantor Email")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Guarantor Amount"; Rec."Guarantor Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Approved; Rec.Approved)
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

