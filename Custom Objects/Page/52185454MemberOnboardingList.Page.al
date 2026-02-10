page 52185454 "Member Onboarding List"
{
    CardPageID = "Member Onboarding";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "On Board Members";
    SourceTableView = WHERE(Created = CONST(false));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

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
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Username Login Type"; Rec."Username Login Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Created At"; Rec."Created At")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Created; Rec.Created)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("On Board All Members")
            {
                ApplicationArea = Basic, Suite;
                Image = CreditCard;
                Promoted = true;

                trigger OnAction()
                begin
                    // SkyHarambeePortal.OnBoardMembers;
                    // Message('Done');
                end;
            }
        }
    }

    var
    // SkyHarambeePortal: Codeunit "Sky Harambee Portal";
}

