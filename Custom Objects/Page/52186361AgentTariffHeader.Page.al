page 52186361 "Agent Tariff Header"
{
    CardPageID = "Agent Tariff Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Agent Tarriff Header";
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
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Type"; Rec."Trans Type Agents")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Charge Excise Duty"; Rec."Charge Excise Duty")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Daily Limit"; Rec."Daily Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Weekly Limit"; Rec."Weekly Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Monthly Limit"; Rec."Monthly Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Yearly Limit"; Rec."Yearly Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Limit"; Rec."Transaction Limit")
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

