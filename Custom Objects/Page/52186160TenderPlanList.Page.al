page 52186160 "Tender Plan List"
{
    CardPageID = "Work Plan Card";
    Editable = true;
    PageType = List;
    SourceTable = "Tender Plan Header";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Workplan Code"; Rec."Workplan Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Workplan Description"; Rec."Workplan Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Procurement Method"; Rec."Procurement Method")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Start Date"; Rec."Start Date")
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

