page 52186362 "Agent Tariff Card"
{
    PageType = Card;
    SourceTable = "Agent Tarriff Header";

    layout
    {
        area(content)
        {
            group(General)
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
                field("Charge Excise Duty"; Rec."Charge Excise Duty")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Sacco Comm Acc"; Rec."Sacco Comm Acc")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Vendor Comm Acc"; Rec."Vendor Comm Acc")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("SMS Acc"; Rec."SMS Acc")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Charge Acc"; Rec."Charge Acc")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Tiered; Rec.Tiered)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part(Control7; "Agent Tariff Details")
            {
                SubPageLink = Code = FIELD(Code);
            }
        }
    }

    actions
    {
    }
}

