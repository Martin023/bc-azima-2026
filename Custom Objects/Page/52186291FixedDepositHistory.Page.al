page 52186291 "Fixed Deposit History"
{
    Editable = false;
    PageType = List;
    SourceTable = "Fixed Deposit History";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Fixed Deposit Type"; Rec."Fixed Deposit Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("FD Maturity Date"; Rec."FD Maturity Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Neg. Interest Rate"; Rec."Neg. Interest Rate")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("FD Duration"; Rec."FD Duration")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("FD Maturity Instructions"; Rec."FD Maturity Instructions")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Interest Earned"; Rec."Interest Earned")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Fixed Amount"; Rec."Fixed Amount")
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

