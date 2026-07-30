page 52185898 "HR Email Notification Log"
{
    Caption = 'Email Notification Log';
    PageType = List;
    SourceTable = "HR Email Notification Log";
    ApplicationArea = Basic;
    UsageCategory = Administration;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Basic;
                }
                field("Event Code"; Rec."Event Code")
                {
                    ApplicationArea = Basic;
                }
                field("Recipient Role"; Rec."Recipient Role")
                {
                    ApplicationArea = Basic;
                }
                field("Sent To"; Rec."Sent To")
                {
                    ApplicationArea = Basic;
                }
                field("Source Document No."; Rec."Source Document No.")
                {
                    ApplicationArea = Basic;
                }
                field("Subject Sent"; Rec."Subject Sent")
                {
                    ApplicationArea = Basic;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = Rec.Status = Rec.Status::Failed;
                }
                field("Error Text"; Rec."Error Text")
                {
                    ApplicationArea = Basic;
                    Style = Attention;
                    StyleExpr = Rec."Error Text" <> '';
                }
                field("Sent Date"; Rec."Sent Date")
                {
                    ApplicationArea = Basic;
                }
                field("Sent Time"; Rec."Sent Time")
                {
                    ApplicationArea = Basic;
                }
                field("Sent By"; Rec."Sent By")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Show Failed")
            {
                ApplicationArea = Basic;
                Caption = 'Failed Only';
                Image = FilterLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.SetRange(Status, Rec.Status::Failed);
                    CurrPage.Update(false);
                end;
            }
            action("Show All")
            {
                ApplicationArea = Basic;
                Caption = 'All';
                Image = ClearFilter;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.SetRange(Status);
                    CurrPage.Update(false);
                end;
            }
        }
    }
}
