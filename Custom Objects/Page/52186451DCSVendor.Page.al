page 52186451 "DCS Vendor"
{
    PageType = List;
    SourceTable = "Savings Accounts";
    SourceTableView = WHERE("Salary Through FOSA" = FILTER(true),
                            Status = FILTER(Active),
                            "Transactional Mobile No" = FILTER(<> ''));
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("MPESA Mobile No"; Rec."Transactional Mobile No")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'MPESA Mobile No';
                }
                field("BOSA Account No"; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'BOSA Account No';
                }
                field("ID No."; Rec."ID No.")
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

