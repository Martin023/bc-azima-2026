page 52186414 "Loan Securities Set-Up"
{
    CardPageID = "Loan Securites Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Loan Securities Set-up";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Code"; Rec."Setup Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                // field("No."; Rec."No.")
                // {
                //     ApplicationArea = Basic, Suite;
                // }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Security Description"; Rec."Security Description")
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

