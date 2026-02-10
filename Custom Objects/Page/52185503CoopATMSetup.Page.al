page 52185503 "Coop ATM Setup"
{
    PageType = Card;
    SourceTable = "Coop ATM  Setup";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Coop Commission Account"; Rec."Coop Commission Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Coop Fee Account"; Rec."Coop Fee Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Coop Bank Account"; Rec."Coop Bank Account")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Daily Withdrawal Limit"; Rec."Daily Withdrawal Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transactional Withdrawal Limit"; Rec."Transactional Withdrawal Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Institution Code"; Rec."Institution Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Institution Name"; Rec."Institution Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Transaction Valid Days"; Rec."Transaction Valid Days")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        SkyPermissions.Reset;
        SkyPermissions.SetRange("User ID", UserId);
        SkyPermissions.SetRange("ATM Setups", false);
        if SkyPermissions.FindFirst then Error('You do nto have permission ATM Setups in MBanking Permissions');
    end;

    var
        SkyPermissions: Record "Sky Permissions";
}

