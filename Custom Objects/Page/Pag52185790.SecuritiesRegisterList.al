namespace MNS.MNS;

page 52185790 "Securities Register - List"
{
    ApplicationArea = All;
    Caption = 'Securities Register - List';
    PageType = List;
    SourceTable = "Securities Register";
    UsageCategory = Lists;
    cardpageid = "Collateral Register Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Collateral No.';
                }
                field("Collateral Category"; Rec."Collateral Category")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Collateral Owner"; Rec."Collateral Owner")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Collateral Ref No."; Rec."Collateral Ref No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Collateral; Rec.Collateral)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Market Value"; Rec."Market Value")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Date Captured"; Rec."Date Captured")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Perfected"; Rec."Collateral Perfected")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Discharged"; Rec."Collateral Discharged")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Substituted; Rec."Collateral Substituted")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
}
