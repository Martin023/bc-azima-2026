page 52186659 "Mobile Guarantor Setup"
{
    Editable = true;
    PageType = List;
    SourceTable = "Mobile Guarantors Setup";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Product Code"; Rec."Product Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("No. of Guarantors"; Rec."No. of Guarantors")
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
        // Permission.RESET;
        // Permission.SETRANGE("User ID",USERID);
        // Permission.SETRANGE("Sky Mobile Setups",TRUE);
        // IF NOT Permission.FINDFIRST THEN
        //  ERROR('You do not have the following permission: "Sky Mobile Setups"');
    end;

    var
        Permission: Record "Sky Permissions";
}

