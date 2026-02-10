page 52186429 "Business Appraisals"
{
    PageType = List;
    SourceTable = "Business Loan Appraisal";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Financial Classification Code"; Rec."Financial Classification Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan With Sacco"; Rec."Loan With Sacco")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

