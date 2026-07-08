page 52185652 "Mobile Loan Exceptions"
{
    Caption = 'Mobile Loan Exceptions';
    PageType = List;
    SourceTable = "Mobile Loan Exceptions";
    ApplicationArea = All;
    deleteallowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Member identification number';
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Name of the member';
                }
                field(Employer; Rec.Employer)
                {
                    ApplicationArea = All;
                    ToolTip = 'Employer code';
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employer name';
                }
                field("Product ID"; Rec."Product ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Loan product identifier';
                }
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Loan product name';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Active or Inactive status of the exception';
                }
                // field(Remarks; Rec.Remarks)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Notes about this exception';
                // }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'User who created this record';
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date and time record was created';
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                    ToolTip = 'User who last modified this record';
                }
                field("Modified On"; Rec."Modified On")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date and time record was last modified';
                }
                field("Disabled By"; Rec."Disabled By")
                {
                    ApplicationArea = All;
                    ToolTip = 'User who disabled this exception';
                }
                field("Disabled On"; Rec."Disabled On")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date and time exception was disabled';
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