page 52185898 "HR Email Notification Log"
{
    Caption = 'Email Notification Log';
    PageType = List;
    SourceTable = "HR Email Notification Log";
    ApplicationArea = Basic;
    UsageCategory = Administration;
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Event Code"; Rec."Event Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Recipient Role"; Rec."Recipient Role")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sent To"; Rec."Sent To")
                {
                    ApplicationArea = Basic;
                    Editable = IsFailed;
                    Style = Attention;
                    StyleExpr = IsFailed;
                }
                field("Source Document No."; Rec."Source Document No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Subject Sent"; Rec."Subject Sent")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Favorable;
                    StyleExpr = IsSuccess;
                }
                field("Error Text"; Rec."Error Text")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = Rec."Error Text" <> '';
                }
                field("Retry Count"; Rec."Retry Count")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Is Retry"; Rec."Is Retry")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Is Resend"; Rec."Is Resend")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Parent Entry No."; Rec."Parent Entry No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Sent Date"; Rec."Sent Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sent Time"; Rec."Sent Time")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sent By"; Rec."Sent By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Retry)
            {
                ApplicationArea = Basic;
                Caption = 'Retry';
                Image = Redo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = IsFailed;
                ToolTip = 'Retry sending this failed notification using the stored token values and current template body.';

                trigger OnAction()
                var
                    EmailDispatcher: Codeunit "HR Email Dispatcher";
                begin
                    EmailDispatcher.Retry(Rec."Entry No.");
                    CurrPage.Update(false);
                end;
            }
            action(Resend)
            {
                ApplicationArea = Basic;
                Caption = 'Resend';
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Resend this notification regardless of its current status. A new log entry is created.';

                trigger OnAction()
                var
                    EmailDispatcher: Codeunit "HR Email Dispatcher";
                begin
                    EmailDispatcher.Resend(Rec."Entry No.");
                    CurrPage.Update(false);
                end;
            }
            action("View History")
            {
                ApplicationArea = Basic;
                Caption = 'View History';
                Image = History;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Show all retry and resend entries linked to this notification.';

                trigger OnAction()
                var
                    OriginalNo: Integer;
                begin
                    if Rec."Parent Entry No." <> 0 then
                        OriginalNo := Rec."Parent Entry No."
                    else
                        OriginalNo := Rec."Entry No.";

                    Rec.SetFilter("Entry No.", '%1|%2', OriginalNo, OriginalNo);
                    Rec.SetFilter("Parent Entry No.", '%1', OriginalNo);
                    CurrPage.Update(false);
                end;
            }
            action("Show Failed")
            {
                ApplicationArea = Basic;
                Caption = 'Failed Only';
                Image = FilterLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.SetFilter(Status, '%1|%2', Rec.Status::Failed, Rec.Status::"Retry Failed");
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
                    Rec.SetRange("Parent Entry No.");
                    CurrPage.Update(false);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IsFailed := (Rec.Status = Rec.Status::Failed) or (Rec.Status = Rec.Status::"Retry Failed");
        IsSuccess := (Rec.Status = Rec.Status::Sent) or (Rec.Status = Rec.Status::"Retry Succeeded") or (Rec.Status = Rec.Status::Resent);
    end;

    var
        IsFailed: Boolean;
        IsSuccess: Boolean;
}
