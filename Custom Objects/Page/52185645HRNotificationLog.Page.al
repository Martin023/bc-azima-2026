page 52185645 "HR Notification Log"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "HR Notification Log";
    Caption = 'HR Notification Log';
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = true;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Notification Type"; Rec."Notification Type")
                {
                    ApplicationArea = All;
                }
                field("Warning Date"; Rec."Warning Date")
                {
                    ApplicationArea = All;
                }
                field("Days/Months Remaining"; Rec."Days/Months Remaining")
                {
                    ApplicationArea = All;
                }
                field("Employee Department"; Rec."Employee Department")
                {
                    ApplicationArea = All;
                }
                field("Employee Position"; Rec."Employee Position")
                {
                    ApplicationArea = All;
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Retirement Date"; Rec."Retirement Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Notification Sent Date"; Rec."Notification Sent Date")
                {
                    ApplicationArea = All;
                }
                field("Recipient Email"; Rec."Recipient Email")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    StyleExpr = StatusStyle;
                }
                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date Time"; Rec."Created Date Time")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Control1; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control2; Links)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(DeleteOldEntries)
            {
                ApplicationArea = All;
                Caption = 'Delete Old Entries';
                Image = Delete;
                ToolTip = 'Delete notification log entries older than 1 year';

                trigger OnAction()
                var
                    HRNotifLog: Record "HR Notification Log";
                    DeletedCount: Integer;
                begin
                    if not Confirm('Delete all notification log entries older than 1 year?', false) then
                        exit;

                    HRNotifLog.Reset();
                    HRNotifLog.SetFilter("Created Date Time", '<%1', CreateDateTime(CalcDate('<-1Y>', Today), 0T));
                    DeletedCount := HRNotifLog.Count;
                    HRNotifLog.DeleteAll(true);
                    Message('%1 old notification log entries deleted.', DeletedCount);
                end;
            }
            action(ResendFailed)
            {
                ApplicationArea = All;
                Caption = 'Resend Failed Notifications';
                Image = ReopenCancelled;
                ToolTip = 'Attempt to resend failed notifications';

                trigger OnAction()
                var
                    HRNotifMgmt: Codeunit "HR Expiry & Retirement Notif";
                begin
                    if not Confirm('Resend all failed notifications?', false) then
                        exit;

                    HRNotifMgmt.ResendFailedNotifications();
                    CurrPage.Update(false);
                end;
            }
        }
        area(Promoted)
        {
            actionref(DeleteOldEntries_Promoted; DeleteOldEntries) { }
            actionref(ResendFailed_Promoted; ResendFailed) { }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetStatusStyle();
    end;

    local procedure SetStatusStyle()
    begin
        StatusStyle := '';
        case Rec.Status of
            Rec.Status::Sent:
                StatusStyle := 'Favorable';
            Rec.Status::Failed:
                StatusStyle := 'Unfavorable';
            Rec.Status::Pending:
                StatusStyle := 'Ambiguous';
        end;
    end;

    var
        StatusStyle: Text;
}
