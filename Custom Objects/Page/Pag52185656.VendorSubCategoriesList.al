namespace AZIMA.AZIMA;

page 52185656 "Vendor SubCategories List"
{
    ApplicationArea = All;
    Caption = 'Vendor SubCategories';
    PageType = List;
    SourceTable = "Vendor SubCategories";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Vendor Category"; Rec."Vendor Category")
                {
                    ApplicationArea = All;
                }
                field("Vendor SubCategory"; Rec."Vendor SubCategory")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
