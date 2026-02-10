page 52186240 "Nairobi Water Bill List"
{
    CardPageID = "Nairobi water Bill";
    Editable = false;
    PageType = List;
    SourceTable = "Nairobi Water Bill";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("Property No."; Rec."Property No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("L/R No."; Rec."L/R No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Meter Reading Date"; Rec."Meter Reading Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Previous Reading"; Rec."Previous Reading")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Current[Present] reading"; Rec."Current[Present] reading")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Billing date"; Rec."Billing date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("No."; Rec."No.")
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

