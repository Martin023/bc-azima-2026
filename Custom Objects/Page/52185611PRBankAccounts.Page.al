page 52185611 "PR Bank Accounts"
{
    PageType = List;
    SourceTable = "PR Bank Accounts";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Branches)
            {
                ApplicationArea = Basic, Suite;
                Image = BankAccount;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "PR Bank Branches";
                RunPageLink = "Bank Code" = FIELD("Bank Code");
            }
            action(Import)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Import';
                Promoted = true;
                PromotedCategory = Category4;
                ////RunObject = XMLport XMLport50076;
            }
        }
    }
}

