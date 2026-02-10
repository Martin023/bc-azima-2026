page 52186245 "Common Area Charges"
{
    PageType = List;
    SourceTable = "Common Area Charges";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;


    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                ShowCaption = false;
                field(No; Rec.No)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Meter Rent"; Rec."Meter Rent")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("C/Area Fixed Charge"; Rec."C/Area Fixed Charge")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("B/Hole Average Sewer Charge"; Rec."B/Hole Average Sewer Charge")
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

