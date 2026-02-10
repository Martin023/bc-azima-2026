page 52185471 "Created Sky Business Accounts"
{
    PageType = List;
    SourceTable = "Sky Business Accounts";
    SourceTableView = WHERE("Paid Initial Amount" = CONST(true));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Business Name"; Rec."Business Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Business Location"; Rec."Business Location")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Activated At"; Rec."Activated At")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Form Submitted"; Rec."Form Submitted")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Paid Initial Amount"; Rec."Paid Initial Amount")
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

