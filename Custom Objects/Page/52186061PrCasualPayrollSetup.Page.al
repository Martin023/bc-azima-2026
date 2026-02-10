page 52186061 "PrCasual Payroll Setup"
{
    PageType = Card;
    SourceTable = "PrCasual Payroll Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Normal Hours Rate per Hour"; Rec."Normal Hours Rate per Hour")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Overtime Hours Rate per Hour"; Rec."Overtime Hours Rate per Hour")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("PHs and Weekends Rate per Hour"; Rec."PHs and Weekends Rate per Hour")
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

