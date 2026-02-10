page 52185762 "Member Collaterals"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    DeleteAllowed = false;
    PageType = List;
    SourceTable = Collateral;
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Collateralised"; Rec."Date Collateralised")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Collateral Type"; Rec."Collateral Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Collateral Value"; Rec."Collateral Value")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Registration/Certificate No."; Rec."Registration/Certificate No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Internal Account(Lien)"; Rec."Internal Account(Lien)")
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

