page 52186699 "Safaricom Charges"
{
    PageType = List;
    SourceTable = "Sky Safcom Corporate Charges";
    UsageCategory = Lists;
    ApplicationArea = Basic, Suite;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Minimum; Rec.Minimum)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Maximum; Rec.Maximum)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Charge; Rec.Charge)
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
        Permission.Reset;
        Permission.SetRange("User ID", UserId);
        Permission.SetRange("Sky Mobile Setups", true);
        if not Permission.FindFirst then
            Error('You do not have the following permission: "Safaricom Charges Setup');
    end;

    var
        Permission: Record "Sky Permissions";
}

