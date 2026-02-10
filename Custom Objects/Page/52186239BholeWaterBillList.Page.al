page 52186239 "B/hole Water Bill List"
{
    Caption = 'Water Batch Invoice List';
    CardPageID = "B/Hole Water Bill";
    PageType = List;
    SourceTable = "B/Hole Water Bill";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Zone Code"; Rec."Zone Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Zone Description"; Rec."Zone Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Meter Reading Date"; Rec."Meter Reading Date")
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

