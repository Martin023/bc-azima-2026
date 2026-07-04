page 52185445 "Loan Product Availability"
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
    trigger OnOpenPage()
    begin
        CheckPageEditable();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CheckPageEditable();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if Rec.GetFilter("Loan Product Code") <> '' then
            Rec.Validate("Loan Product Code", Rec.GetRangeMin("Loan Product Code"));
    end;

    local procedure CheckPageEditable()
    var
        ProductFactory: Record "Product Factory";
    begin
        if Rec.GetFilter("Loan Product Code") <> '' then begin
            if ProductFactory.Get(Rec.GetRangeMin("Loan Product Code")) then
                CurrPage.Editable(ProductFactory.Status = ProductFactory.Status::Open)
            else
                CurrPage.Editable(true);
        end else
            CurrPage.Editable(true);
    end;
}