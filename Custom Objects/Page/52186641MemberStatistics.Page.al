page 52186641 "Member Statistics"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = Members;

    layout
    {
        area(content)
        {
            group("Savings Statistics")
            {
                part(Control4; "Savings Statistics")
                {
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Member No." = FIELD("No.");
                    Visible = Not HideAccount;

                }
                // group(Control7)
                // {
                //     //The GridLayout property is only supported on controls of type Grid
                //     //GridLayout = Columns;
                //     ShowCaption = false;
                // }
                // part(Control6; "Savings Statistics Unallocated")
                // {
                //     ApplicationArea = Basic, Suite;
                //     SubPageLink = "Member No." = FIELD("No.");
                //     UpdatePropagation = Both;
                // }
                // part(Control5; "Credit Statistics")
                // {
                //     ApplicationArea = Basic, Suite;
                //     SubPageLink = "Member No." = FIELD("No.");
                // }
            }
            group("Running Loans Statistics")
            {
                part(Control8; "Loans Statistics")
                {
                    Caption = 'Running Loans Statistics';
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Member No." = FIELD("No.");
                    SubPageView = where(Posted = filter(true), "Total Loan Balance" = filter(<> 0));
                    Visible = Not HideAccount;

                }
            }
            group("Unposted Loans Statistics")
            {
                part(Control; "Unposted Loans Statistics")
                {
                    Caption = 'Unposted Loans Statistics';
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Member No." = FIELD("No.");
                    SubPageView = where(Posted = filter(false));
                    Visible = Not HideAccount;


                }
            }
            group("Cleared Loans Statistics")
            {
                part(Control9; "Loans Statistics")
                {
                    Caption = 'Cleared Loans Statistics';
                    ApplicationArea = Basic, Suite;
                    SubPageLink = "Member No." = FIELD("No.");
                    SubPageView = where(Posted = filter(true), "Total Loan Balance" = filter(0));
                    Visible = Not HideAccount;

                }
            }
        }
    }

    actions
    {
    }

    var
        UserSetup: Record "User Setup";
        GlobalFunctions: Codeunit "Global Functions";
        HideAccount: Boolean;

    trigger OnOpenPage()
    begin
        HideAccount := GlobalFunctions.HideAccount(Rec."No.");
    end;
}

