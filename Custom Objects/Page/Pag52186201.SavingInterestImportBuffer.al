namespace KenpipeCBS.KenpipeCBS;

page 52186201 "Saving Interest Import Buffer"
{
    ApplicationArea = All;
    Caption = 'Saving Interest Import Buffer';
    PageType = List;
    SourceTable = "Saving Interest Import Buffer";
    UsageCategory = Lists;
    // Editable = false;
    DeleteAllowed = false;
    // InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Header No."; Rec."Header No.")
                {
                    ApplicationArea = All;
                }
                field(No; rec.No) { ApplicationArea = All; }
                field("Member No"; Rec."Member No") { ApplicationArea = All; }
                field("Interest Date"; rec."Interest Date") { ApplicationArea = All; }
                field("Interest Amount"; Rec."Interest Amount") { ApplicationArea = All; }
                field("Lowest Bal"; Rec."Lowest Bal") { ApplicationArea = All; }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Import Interest")
            {
                ApplicationArea = All;
                Caption = 'Import Interest';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Import the interest amounts from the import buffer.';

                trigger OnAction()
                begin

                end;
            }
        }
    }
}
