page 52187221 "Upcoming Matters"
{
    ApplicationArea = All;
    Caption = 'Upcoming Matters';
    PageType = ListPart;
    SourceTable = "Legal Upcoming Matters";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Record ID"; Rec."Record ID")
                {
                    Caption = 'Case Number';
                    ToolTip = 'Specifies the value of the Record ID field.';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                // field(No;Rec.No)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Editable = false;
                // }
                // field("Case Number"; Rec."Case Number")
                // {
                //     Editable = false;
                // }
                // field("Matter No"; Rec."Line No")
                // {
                // }
                field(Matter; Rec.Matter)
                {
                    ToolTip = 'Specifies the value of the Matter field.';
                    ApplicationArea = Basic, Suite;

                }
                field("Shceduled Date"; Rec."Shceduled Date")
                {
                    Caption = 'Scehduled Date';
                    ToolTip = 'Specifies the value of the Shceduled Date field.';
                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    var
                        MyNotification: Notification;
                    begin
                        if Rec."Shceduled Date" <= Today then begin
                            MyNotification.Message := 'The Upcoming Matter of Case No.' + ' ' + Rec."Record ID" + ' ' + Rec.Matter + ' is set for' + ' ' + Format(Rec."Shceduled Date") + '.';
                            MyNotification.Scope := NotificationScope::LocalScope;
                            MyNotification.Send();
                        end;

                        // UserSetup.Get(UserId);
                        // UserSetup.SetRange("Responsibility Centre", Rec."Responsibility Center");
                        // if UserSetup.Find('-') then begin
                        //     Members.Reset();
                        //     Members.SetRange("No.", UserSetup."Member No.");
                        //     if Members.Find('-') then begin
                        //         repeat
                        //             msg := 'Dear legal department, we would like to bring to your attention an important update regarding ongoing litigation related to' + Rec."Record ID" + 'The action required is' + Rec.Matter + 'Scheduled For' + Format(Rec."Shceduled Date") + '.';
                        //             SendSms.SendSms(Source::Legal, Members."Phone No.", msg, ' ', ' ', false, 0, false, 'CBS', ' ', 'CBS');
                        //         Until Members.Next = 0;
                        //     end
                        // end;    

                        UserSetup.Get(UserId);
                        UserSetup.SetRange("Responsibility Centre", Rec."Responsibility Center");
                        if UserSetup.Find('-') then begin
                            repeat
                                Members.Reset();
                                Members.SetRange("No.", UserSetup."Member No.");
                                if Members.FindFirst() then begin
                                    if Members."Phone No." <> '' then
                                    begin
                                        msg := 'Dear legal department, we would like to bring to your attention an important update regarding ongoing litigation related to' + Rec."Record ID" + 'The action required is' + Rec.Matter + 'Scheduled For' + Format(Rec."Shceduled Date") + '.';
                                        SendSms.SendSms(Source::Legal, Members."Phone No.", msg, ' ', ' ', false, 0, false, 'CBS', ' ', 'CBS');
                                    end; 
                                end
                                else
                                    msg := 'Dear legal department, we would like to bring to your attention an important update regarding ongoing litigation related to' + Rec."Record ID" + 'The action required is' + Rec.Matter + 'Scheduled For' + Format(Rec."Shceduled Date") + '.';
                                    SendSms.SendSms(Source::Legal, Members."Transactional Mobile Number", msg, ' ', ' ', false, 0, false, 'CBS', ' ', 'CBS');
                            Until UserSetup.Next = 0;
                        end;
                    end;
                }
                field("Captured By"; Rec."Captured By")
                {
                    ToolTip = 'Specifies the value of the Captured By field.';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Captured On"; Rec."Captured On")
                {
                    ToolTip = 'Specifies the value of the Captured On field.';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Branch Code"; Rec."Global Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Branch field.';
                    Editable = false;
                }
                field("Activity Code"; Rec."Global Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Department field.';
                    Editable = false;
                }
            }
        }
    }
    var
        SendSMS: Codeunit SendSms;
        msg: Text;
        UserSetup: Record "User Setup";
        Members: Record "Members";
        Source: enum "SMS Source";
}
