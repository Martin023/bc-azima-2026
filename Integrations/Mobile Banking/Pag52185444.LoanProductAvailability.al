namespace BCAZIMA.BCAZIMA;

page 52185444 "Loan Product Availability"
{
    PageType = List;
    SourceTable = "Loan Product Availability";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Loan Product Code"; Rec."Loan Product Code")
                {
                    ApplicationArea = All;
                }

                field(Month; Rec.Month)
                {
                    ApplicationArea = All;
                }

                field(Accessible; Rec.Accessible)
                {
                    ApplicationArea = All;
                }
                field("Upfront Interest Rate"; Rec."Upfront Interest Rate")
                {
                    ApplicationArea = All;
                }

                field("Last Modified By"; Rec."Last Modified By")
                {
                    ApplicationArea = All;
                }

                field("Last Modified At"; Rec."Last Modified At")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Loan Product Code" := Rec.GetRangeMin("Loan Product Code");
    end;
}
