page 52186406 "Product Factory Appl. List"
{
    CardPageID = "Product Factory Appl. Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Product Factory Application";
    Caption = 'Product Setup Application List';
    // ApplicationArea = Basic, Suite;
    // UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product ID"; Rec."Product ID")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Description"; Rec."Product Description")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Product Class Type"; Rec."Product Class Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control10; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control11; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control12; Links)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
    }
}

