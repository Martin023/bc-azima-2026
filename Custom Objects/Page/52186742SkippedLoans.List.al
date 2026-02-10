page 52186742 "Skipped Loans"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Skipped Loans";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Header No."; Rec."Header No.")
                {
                    Editable = false;
                }
                field("Loan No."; Rec."Loan No.")
                {
                    Editable = false;
                }
                field("Present Header No."; Rec."Present Header No.")
                {
                    Editable = false;
                }

            }
        }
    }
}
