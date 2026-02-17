page 52186512 "HR Professional bodies"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Professional Body';
    SourceTable = "HR Professional body Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Professional Body"; Rec."Professional Body")
                {
                    ApplicationArea = Basic;
                }
                field(Control7; Rec.Members)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group(Control6)
            {
                ShowCaption = false;
                part("Professional Body Requirements"; "HR Professional Body Lines")
                {
                    ApplicationArea = Basic;
                    Caption = 'Professional Body Requirements';
                    SubPageLink = "No." = FIELD("No.");
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Members)
            {
                ApplicationArea = Bsaic;
                Image = CustomerList;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "HR Proffesional Body Members";
                RunPageLink = "Professional Body" = FIELD("No.");
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Created By" := Rec."Created By";
    end;

}

