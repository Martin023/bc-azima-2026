page 52185941 "Budgetary Control Setup"
{
    PageType = Card;
    SourceTable = "Budgetary Control Setup";
    ApplicationArea = All;
    UsageCategory=Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Mandatory; Rec.Mandatory)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Allow OverExpenditure"; Rec."Allow OverExpenditure")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Budget Check Criteria"; Rec."Budget Check Criteria")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Partial Budgetary Check"; Rec."Partial Budgetary Check")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Use Totaling Account"; Rec."Use Totaling Account")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Budget)
            {
                Caption = 'Budget';
                field("Current Budget Code"; Rec."Current Budget Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Current Budget Start Date"; Rec."Current Budget Start Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Current Budget End Date"; Rec."Current Budget End Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Current Item Budget"; Rec."Current Item Budget")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            group(Actuals)
            {
                Caption = 'Actuals';
                Visible = false;
                field("Analysis View Code"; Rec."Analysis View Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Dimension 1 Code"; Rec."Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Dimension 2 Code"; Rec."Dimension 2 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Dimension 3 Code"; Rec."Dimension 3 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Dimension 4 Code"; Rec."Dimension 4 Code")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        UserSetup.GetDefaultSalesAmountApprovalLimit();
    end;

    var
        Text000: Label 'You do not have permissions to view This page';
        StatusPermissions: Record "Status Change Permissions.";
        UserSetup: Record "User Setup";
}

