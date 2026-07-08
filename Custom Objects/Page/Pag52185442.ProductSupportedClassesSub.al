page 52185442 "Product Supported Classes List"
{
    PageType = List;
    SourceTable = "Product Supported Classes";
    Caption = 'Product Supported Classes';
    UsageCategory = None;
    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Class Category"; Rec."Class Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the member class category supported by this product.';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the user who added this class category.';
                    Visible = true;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date and time when this record was created.';
                    Visible = true;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the user who last changed this record.';
                    Visible = true;
                }
                field("Modified On"; Rec."Modified On")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date and time of the last modification.';
                    Visible = true;
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