namespace BCAZIMA.BCAZIMA;

page 50102 "Product Supported Classes List"
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
            }
        }
    }
    // trigger OnNewRecord(BelowxRec: Boolean)
    // begin
    //     if Rec.GetFilter("Product ID") <> '' then
    //         Rec.Validate("Product ID", Rec.GetRangeMin("Product ID"));
    // end;
}
