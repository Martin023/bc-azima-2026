page 52186382 "File Mvt Remarks Card"
{
    PageType = Card;
    Caption = 'File Movement Card';
    SourceTable = "File Movement Remarks";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Responsibility Centre"; Rec."Responsibility Centre")
                {
                    ApplicationArea = Basic, Suite;
                }

            }
        }
    }

    actions
    {
    }
}

