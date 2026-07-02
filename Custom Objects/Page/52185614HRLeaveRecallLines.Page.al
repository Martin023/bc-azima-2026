page 52185614 "HR Leave Recall Lines"
{
    PageType = ListPart;
    SourceTable = "HR Leave Recall Lines";
    Caption = 'HR Leave Recall Lines';
    Editable = true;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Recall Date"; Rec."Recall Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = not Rec.Posted;
                }
                field("Days Recalled"; Rec."Days Recalled")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = not Rec.Posted;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = not Rec.Posted;
                }
                field("Recalled By"; Rec."Recalled By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Recall Timestamp"; Rec."Recall Timestamp")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = not Rec.Posted;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ledger Entry No."; Rec."Ledger Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Post Recall")
            {
                ApplicationArea = All;
                Caption = 'Post Recall';
                Image = Post;
                // Promoted = true;
                // PromotedCategory = Process;
                // PromotedIsBig = true;
                // Enabled = not Rec.Posted;

                trigger OnAction()
                begin
                    if Confirm('Do you want to post this recall and reimburse %1 day(s) to the employee?', true, Rec."Days Recalled") then begin
                        Rec.PostRecall();
                        CurrPage.Update(false);
                    end;
                end;
            }
        }
    }
}
