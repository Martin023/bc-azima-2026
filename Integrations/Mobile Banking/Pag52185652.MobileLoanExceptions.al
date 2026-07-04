page 52185652 "Mobile Loan Exceptions"
{
    Caption = 'Mobile Loan Exceptions';
    PageType = List;
    SourceTable = "Mobile Loan Exceptions";
    applicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member No. field.', Comment = '%';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Name field.', Comment = '%';
                }
                field(Employer; Rec.Employer)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employer field.', Comment = '%';
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Employer Name field.', Comment = '%';
                }
                field("Product ID"; Rec."Product ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Product field.', Comment = '%';
                }
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Loan Product Name field.', Comment = '%';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created On field.', Comment = '%';
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Modified By field.', Comment = '%';
                }
                field("Modified On"; Rec."Modified On")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Modified On field.', Comment = '%';
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
