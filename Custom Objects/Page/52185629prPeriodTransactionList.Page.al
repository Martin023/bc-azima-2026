page 52185629 "prPeriodTransaction List"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "PR Period Transactions";
    UsageCategory = Lists;
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                ShowCaption = false;
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Code"; Rec."Transaction Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Name"; Rec."Transaction Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Reference No"; Rec."Reference No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("coop parameters"; Rec."coop parameters")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Group Order"; Rec."Group Order")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sub Group Order"; Rec."Sub Group Order")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Group Text"; Rec."Group Text")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Journal Account Type"; Rec."Journal Account Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Journal Account Code"; Rec."Journal Account Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Salary Type"; Rec."Salary Type")
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

