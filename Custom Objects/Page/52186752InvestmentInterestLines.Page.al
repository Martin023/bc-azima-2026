page 52186752 "Investment Interest Lines"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Investment Interest Lines";
    ApplicationArea = Basic, Suite;
    usagecategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Account Type"; Rec."Account Type")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Investment No"; Rec."Investment No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Placed"; Rec."Date Placed")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Maturity Date"; Rec."Maturity Date")
                {

                }
                field("Invested Amount"; Rec."Invested Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Accrued Interest"; Rec."Accrued Interest Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Investment G/L Account"; Rec."Accrued Interest G/L Acc")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Income G/L Acc"; Rec."Interest Income G/L Acc")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                // field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field(Posted; Rec.Posted)
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

