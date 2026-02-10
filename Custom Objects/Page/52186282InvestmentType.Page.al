page 52186282 "Investment Type"
{
    PageType = List;
    SourceTable = "Investment Type";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;
    DeleteAllowed = false;
    Editable = true;

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
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Deposit Type"; Rec."Deposit Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Accrued Interest"; Rec."Accrued Interest G/L Acc")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Income"; Rec."Interest Income G/L Acc")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
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

