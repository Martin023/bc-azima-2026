page 52185796 "Transaction Charges"
{
    ModifyAllowed = true;
    PageType = ListPart;
    SourceTable = "Transaction Charges";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                }
                field("Charge Code"; Rec."Charge Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Charge Type"; Rec."Charge Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Charge Amount"; Rec."Charge Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Percentage of Amount"; Rec."Percentage of Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                }
                field("Minimum Amount"; Rec."Minimum Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Maximum Amount"; Rec."Maximum Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Staggered Charge Code"; Rec."Staggered Charge Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Charge Category"; Rec."Transaction Charge Category")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Recover Excise Duty"; Rec."Recover Excise Duty")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Withholding Tax"; Rec."Withholding Tax")
                {

                }
            }
        }
    }

    actions
    {
    }
}

