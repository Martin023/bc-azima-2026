namespace MNS.MNS;

page 52186570 "Product & references"
{
    ApplicationArea = All;
    Caption = 'Product & references';
    PageType = List;
    SourceTable = "Product Factory";
    //SourceTableView = sorting("Product Class Type") where("Source Unit" = filter(BOSA | "BUSINESS LOANS"));
    UsageCategory = Lists;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    CardPageID = "Product Factory";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Product ID"; Rec."Product ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product ID field.', Comment = '%';
                }
                field("Product Description"; Rec."Product Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product Description field.', Comment = '%';
                }
                field("Search Code"; Rec."Search Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Search code field.', Comment = '%';
                }
                // field(Category; Rec.Category)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Product Category (Loan/Saving)';
                // }
                field("Source Unit"; Rec."Source Unit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Unit field.', Comment = '%';
                }

            }
        }
    }
}
