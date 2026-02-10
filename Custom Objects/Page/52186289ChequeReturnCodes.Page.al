page 52186289 "Cheque Return Codes"
{
    PageType = List;
    SourceTable = "Cheque Return Codes";
    ApplicationArea = Basic, Suite;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Return Code"; Rec."Return Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Code Interpretation"; Rec."Code Interpretation")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Charges; Rec.Charges)
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

