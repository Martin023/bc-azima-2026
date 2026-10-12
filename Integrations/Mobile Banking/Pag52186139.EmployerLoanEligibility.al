page 52186141 "Employer Loan Eligibility"
{
    PageType = List;
    SourceTable = "Employer Loan Eligibility";
    Caption = 'Employer Loan Eligibility';
    UsageCategory = None;
    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employer Code field.', Comment = '%';
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employer Name field.', Comment = '%';
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
        if Rec.GetFilter("Product ID") <> '' then
            Rec.Validate("Product ID", Rec.GetRangeMin("Product ID"));
    end;

    local procedure CheckPageEditable()
    var
        ProductFactory: Record "Product Factory";
    begin
        if Rec.GetFilter("Product ID") <> '' then begin
            if ProductFactory.Get(Rec.GetRangeMin("Product ID")) then
                CurrPage.Editable(ProductFactory.Status = ProductFactory.Status::Open)
            else
                CurrPage.Editable(true);
        end else
            CurrPage.Editable(true);
    end;
}
