page 52187261 "Mobile Loan Restrictions"
{
    Caption = 'Mobile Loan Restrictions';
    PageType = List;
    SourceTable = "Mobile Loan Restrictions";
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
                    Editable = MemberNoEditable;
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
                    ToolTip = 'Active or Inactive status of the restriction';
                }
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
            }
        }
    }

    trigger OnOpenPage()
    begin
        MemberNoEditable := Rec.GetFilter("Member No.") = '';
    end;

    trigger OnAfterGetCurrRecord()
    begin
        // CheckPageEditable();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if Rec.GetFilter("Member No.") <> '' then
            Rec.Validate("Member No.", Rec.GetRangeMin("Member No."));
        if Rec.GetFilter("Product ID") <> '' then
            Rec.Validate("Product ID", Rec.GetRangeMin("Product ID"));
    end;

    // local procedure CheckPageEditable()
    // var
    //     ProductFactory: Record "Product Factory";
    // begin
    //     if Rec.GetFilter("Product ID") <> '' then begin
    //         if ProductFactory.Get(Rec.GetRangeMin("Product ID")) then
    //             CurrPage.Editable(ProductFactory.Status = ProductFactory.Status::Open)
    //         else
    //             CurrPage.Editable(true);
    //     end else
    //         CurrPage.Editable(true);
    // end;

    var
        MemberNoEditable: Boolean;
}
