page 52186765 "Bulk SMS Header"
{
    SourceTable = "Bulk SMS Header";
    // ApplicationArea = Basic, Suite;
    // UsageCategory = Lists;
    PromotedActionCategories = 'New,Process,Reports,Approvals,Defaulter Notification';
    layout
    {
        area(content)
        {

            field(No; Rec.No)
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("Date Entered"; Rec."Date Entered")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("Time Entered"; Rec."Time Entered")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("Entered By"; Rec."Entered By")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("SMS Type"; Rec."SMS Type")
            {
                ApplicationArea = Basic, Suite;
                Editable = Mssage;
            }
            field("SMS Status"; Rec."SMS Status")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("Status Date"; Rec."Status Date")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("Status Time"; Rec."Status Time")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field("Status By"; Rec."Status By")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
            }
            field(Message_; Rec.Message_)
            {
                ApplicationArea = Basic, Suite;
                Editable = Mssage;
                ShowMandatory = true;
                MultiLine = true;
            }
            field("Use Line Message"; Rec."Use Line Message")
            {
                Caption = 'Use Line Messages';
                ApplicationArea = Basic, Suite;
                trigger OnValidate()
                begin
                    if rec."Use Line Message" then begin
                        rec.Message_ := '';
                        Mssage := false;
                    end;
                end;
            }
            // field("Approval Status"; Rec."Approval Status")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Editable = false;
            // }
            field("Responsibility Center"; Rec."Responsibility Center")
            {
                ApplicationArea = Basic, Suite;
                Editable = Mssage;
            }
            field("SMS Source"; Rec."SMS Source")
            {
                ApplicationArea = Basic, Suite;
                Editable = Mssage;
            }
            field("Email Subject"; rec."Email Subject")
            {
                ApplicationArea = Basic, Suite;
                ShowMandatory = true;
            }
            part(Control1000000012; "Bulk SMS Lines part")
            {
                Editable = BulkSMSLines;
                SubPageLink = No = FIELD(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send SMS")
            {
                ApplicationArea = Basic, Suite;
                Image = PutawayLines;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = Rec."SMS Status" <> Rec."SMS Status"::Sent;
                trigger OnAction()
                var
                    PhoneNo: Text[13];
                    SMSText: text[1000];
                    BulkLines: Record "Bulk SMS Lines";
                    SMSID: Guid;
                    SkySMS: Codeunit SendSms;
                    SMSSource: Enum "SMS Source";
                    MsgText: text[10000];
                begin
                    if rec."SMS Status" = rec."SMS Status"::Sent then
                        Error('This record has already been sent.');

                    // IF Rec.Status <> Rec.Status::Approved THEN
                    //     ERROR('This document requires approval');

                    if UserSetup.Get(UserId) then begin
                        if UserSetup."Post Reversals" = false then
                            Error('You do not have permission');
                    end;
                    if Confirm('Are you sure you would like to send the SMS(ES)?', false) = true then begin

                        if not Rec."Use Line Message" = true then begin
                            Rec.TestField(Message_);
                        end;

                        BulkLines.Reset;
                        BulkLines.SetRange(No, Rec.No);
                        if BulkLines.Find('-') then begin
                            repeat
                                if Members.get(BulkLines."Member No") then begin
                                    if rec."Use Line Message" then
                                        MsgText := BulkLines."Text Message"
                                    else
                                        MsgText := Rec.Message_;

                                    SkySMS.SendSms(
                                SMSSource::BULK_SMS,
                                Members."Phone No.",
                                MsgText,
                                rec.No,
                                '',
                                false,
                                0,
                                false,
                                'CBS',
                                '',
                                'CBS');

                                    BulkLines.Sent := true;
                                    BulkLines.Modify();
                                end else begin
                                    if rec."Use Line Message" then
                                        MsgText := BulkLines."Text Message"
                                    else
                                        MsgText := Rec.Message_;

                                    SkySMS.SendSms(
                            SMSSource::BULK_SMS,
                            BulkLines."code",
                            MsgText,
                            rec.No,
                            '',
                            false,
                            0,
                            false,
                            'CBS',
                            '',
                            'CBS');
                                    BulkLines.Sent := true;
                                    BulkLines.Modify();
                                end;
                            until BulkLines.Next = 0
                        end else
                            Error('No members to send SMS to');

                        Rec."SMS Status" := Rec."SMS Status"::Sent;
                        Rec."Status Date" := Today;
                        Rec."Status Time" := Time;
                        Rec."Status By" := UserId;
                        Rec.Modify;
                    end
                    else begin
                        Message('Cancelled successfully');
                    end;

                end;
                // BulkLines.Reset;
                // BulkLines.SetRange(BulkHeader.No, Rec.No);
                // if BulkLines.Find('-') then begin
                //             repeat
                //                 //SMS MESSAGE
                //                 SMSMessage.Reset;
                //                 SMSMessage.SetRange("SMS Message", Rec.Message_);
                //                 SMSMessage.SetRange("Telephone No", Vend."Mobile Phone No");
                //                 if SMSMessage.Find('-') then begin
                //                 end
                //                 else begin

                //                     SMSMessage.Reset;
                //                     if SMSMessage.Find('+') then begin
                //                         iEntryNo := SMSMessage."Entry No";
                //                         iEntryNo := iEntryNo + 1;
                //                     end
                //                     else begin
                //                         iEntryNo := 1;
                //                     end;

                //                     SMSMessage.Init;
                //                     SMSMessage."Entry No" := iEntryNo;
                //                     SMSMessage."Document No" := '';
                //                     SMSMessage."Account No" := Vend."No.";
                //                     SMSMessage."Date Entered" := Today;
                //                     SMSMessage."Time Entered" := Time;
                //                     SMSMessage.Source := SMSMessage.Source::MSACCO;
                //                     SMSMessage."Entered By" := UserId;
                //                     SMSMessage."Sent To Server" := SMSMessage."Sent To Server"::No;
                //                     SMSMessage."SMS Message" := Rec.Message_;
                //                     SMSMessage."Telephone No" := Vend."Mobile Phone No";
                //                     if Vend."Mobile Phone No" <> '' then
                //                         SMSMessage.Insert;
                //                 end;
                //             until Vend.Next = 0
                //         end;
                //     end;


                //     //DIMENSION
                //     if BulkHeader."SMS Type" = BulkHeader."SMS Type"::Dimension then begin
                //         BulkLines.Reset;
                //         BulkLines.SetRange(BulkLines.No, Rec.No);
                //         if BulkLines.Find('-') then begin
                //             repeat

                //                 Vend.Reset;
                //                 Vend.SetRange(Vend."Product Type", '505');
                //                 Vend.SetFilter(Vend.Status, '%1|%2|%3', Vend.Status::Active, Vend.Status::Dormant, Vend.Status::Frozen);
                //                 if Vend.Find('-') then begin
                //                     repeat
                //                         //SMS MESSAGE
                //                         SMSMessage.Reset;
                //                         if SMSMessage.Find('+') then begin
                //                             iEntryNo := SMSMessage."Entry No";
                //                             iEntryNo := iEntryNo + 1;
                //                         end
                //                         else begin
                //                             iEntryNo := 1;
                //                         end;

                //                         SMSMessage.Init;
                //                         SMSMessage."Entry No" := iEntryNo;
                //                         SMSMessage."Document No" := '';
                //                         SMSMessage."Account No" := Vend."No.";
                //                         SMSMessage."Date Entered" := Today;
                //                         SMSMessage."Time Entered" := Time;
                //                         SMSMessage.Source := SMSMessage.Source::MSACCO;
                //                         SMSMessage."Entered By" := UserId;
                //                         SMSMessage."Sent To Server" := SMSMessage."Sent To Server"::No;
                //                         SMSMessage."SMS Message" := Rec.Message_;
                //                         SMSMessage."Telephone No" := Vend."Mobile Phone No";
                //                         if Vend."Mobile Phone No" <> '' then
                //                             SMSMessage.Insert;

                //                     until Vend.Next = 0
                //                 end;

                //             until BulkLines.Next = 0
                //         end;
                //     end;
                //     //Telephone
                //     if BulkHeader."SMS Type" = BulkHeader."SMS Type"::Telephone then begin

                // end;
                // end;
            }

            action("Import Telephone Nos")
            {
                Caption = 'Import Telephone/ Text Messages';
                ApplicationArea = Basic, Suite;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = Rec."SMS Status" <> Rec."SMS Status"::Sent;

                trigger OnAction()
                begin
                    if Rec."SMS Type" <> Rec."SMS Type"::"Selected Members" then begin
                        Error('SMS Type must be: Selected Members.');
                    end;
                    BulkHeader.Reset;
                    BulkHeader.SetRange(BulkHeader.No, Rec.No);
                    if BulkHeader.Find('-') then begin
                        XMLPORT.Run(Xmlport::"Import Telephone Nos");
                    end;
                end;
            }
            action("Suggest Members")
            {
                ApplicationArea = Basic, Suite;
                Image = Suggest;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = Rec."SMS Status" <> Rec."SMS Status"::Sent;

                trigger OnAction()
                begin
                    BulkHeader.Reset;
                    BulkHeader.SetRange(BulkHeader.No, Rec.No);
                    if BulkHeader.Find('-') then begin
                        Report.RunModal(Report::"Generate Bulk SMS Lines", true, true, BulkHeader);
                    end;
                end;
            }
            action("Send Email")
            {
                ApplicationArea = Basic, Suite;
                Image = PutawayLines;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = Rec."SMS Status" <> Rec."SMS Status"::Sent;
                trigger OnAction()
                var
                    PhoneNo: Text[13];
                    SMSText: text[1000];
                    BulkLines: Record "Bulk SMS Lines";
                    Email: Codeunit Email;
                    EmailMsg: Codeunit "Email Message";
                begin
                    if rec."SMS Status" = rec."SMS Status"::Sent then
                        Error('This record has already been sent.');
                    if rec."Email Subject" = '' then
                        Error('Email Subject is required.');

                    // IF Rec.Status <> Rec.Status::Approved THEN
                    //     ERROR('This document requires approval');

                    if UserSetup.Get(UserId) then begin
                        if UserSetup."Post Reversals" = false then
                            Error('You do not have permission');
                    end;

                    if Rec."SMS Status" <> Rec."SMS Status"::Pending then
                        Error('The mail status is not open');
                    if Confirm('Are you sure you would like to send the Email(s)?', false) = true then begin

                        if Rec."SMS Type" = Rec."SMS Type"::"Selected Members" then begin

                        end;
                        if not Rec."Use Line Message" = true then begin
                            Rec.TestField(Message_);
                        end;

                        BulkLines.Reset;
                        BulkLines.SetRange(No, Rec.No);
                        if BulkLines.Find('-') then begin
                            repeat
                                BulkLines.Validate("Text Message");
                                Members.Reset();
                                if Members.get(BulkLines."Member No") then begin
                                    if members."E-Mail" <> '' then begin
                                        if Rec."Use Line Message" then begin
                                            EmailMsg.Create(
                                                Members."E-Mail",
                                                rec."Email Subject",
                                                GetGreeting() + ' ' + Members."First Name" + ', ' + BulkLines."Text Message"
                                            );
                                            Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
                                        end
                                        else
                                            if Rec.Message_ <> '' then begin
                                                EmailMsg.Create(
                                                    Members."E-Mail",
                                                    rec."Email Subject",
                                                    GetGreeting() + ' ' + Members."First Name" + ', ' + Rec.Message_
                                                );
                                                Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
                                            end;
                                    end;
                                    BulkLines.Sent := true;
                                    BulkLines.Modify();
                                end;
                            until BulkLines.Next = 0
                        end
                        else
                            Error('No members to send Emails to');
                    end;
                    Rec."SMS Status" := Rec."SMS Status"::Sent;
                    Rec."Status Date" := Today;
                    Rec."Status Time" := Time;
                    Rec."Status By" := UserId;
                    Rec.Modify;
                end;
            }
            separator(Action4)
            {
            }
            // action(Approve)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = Approve;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     Caption = 'Approve';
            //     Enabled = Rec."SMS Status" <> Rec."SMS Status"::Sent;

            //     trigger OnAction()
            //     begin
            //         if rec."SMS Status" = rec."SMS Status"::Sent then
            //             Error('This record has already been sent.');
            //         if (Rec."Approval Status" = Rec."Approval Status"::Approved) and (Rec.Status = Rec.Status::Approved) then
            //             Error('This record is already approved.');
            //         Rec.Validate("Approval Status", Rec."Approval Status"::Approved);
            //         Rec.Validate("Status", Rec.Status::Approved);
            //         Rec.Modify();
            //         Message('Record approved successfully.');
            //     end;
            // }
            // action(Reopen)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = ReOpen;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     Caption = 'Reopen';
            //     Enabled = Rec."SMS Status" <> Rec."SMS Status"::Sent;
            //     trigger OnAction()
            //     begin
            //         if rec."SMS Status" = rec."SMS Status"::Sent then
            //             Error('This record has already been sent.');

            //         Rec.Status := rec.Status::Open;
            //         Rec."Approval Status" := rec."Approval Status"::Open;
            //         Rec."SMS Status" := Rec."SMS Status"::Pending;
            //         Rec.Modify();
            //         Message('Record re-opened successfully.');
            //     end;
            // }


            // action(Reject)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = Reject;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     Caption = 'Reject';
            //     Enabled = Rec."SMS Status" <> Rec."SMS Status"::Sent;

            //     trigger OnAction()
            //     begin
            //         if rec."SMS Status" = rec."SMS Status"::Sent then
            //             Error('This record has already been sent.');

            //         if Rec."Approval Status" = Rec."Approval Status"::Rejected then
            //             Error('This record is already rejected.');

            //         Rec.Validate("Approval Status", Rec."Approval Status"::Rejected);
            //         Rec."SMS Status" := Rec."SMS Status"::Cancelled;
            //         Rec.Modify();
            //         Message('Record rejected successfully.');
            //     end;
            // }

            // TODO : To be returned once needed.
            // group("Pre-Defined SMS")
            // {
            //     Caption = 'Pre-Defined SMS';

            //     action("Share Reminder SMS")
            //     {
            //         Caption = 'Share Reminder SMS';
            //         ApplicationArea = Basic, Suite;
            //         Image = Share;
            //         Promoted = true;
            //         PromotedCategory = Process;
            //         Enabled = Rec."SMS Status" <> Rec."SMS Status"::Sent;
            //         trigger OnAction()
            //         begin
            //             Rec.Message_ := 'Kindly note that your share capital is due for payment. Please use our mobile channel or bank to make your payments. Thank you.';
            //         end;
            //     }
            //     action("loan reminder SMS")
            //     {
            //         Caption = 'Loan Reminder SMS';
            //         ApplicationArea = Basic, Suite;
            //         Image = Payment;
            //         Promoted = true;
            //         PromotedCategory = Process;
            //         Enabled = Rec."SMS Status" <> Rec."SMS Status"::Sent;
            //         trigger OnAction()
            //         begin
            //             Rec.Message_ := 'Kindly note that your loan is due for payment. Please use our mobile channel or bank to make your payments. Thank you.';
            //         end;
            //     }
            // }

            // TODO : To be returned once needed.


        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
    end;

    var
        BulkHeader: Record "Bulk SMS Header";
        Mssage: Boolean;
        UseHeader: Boolean;
        BulkSMSLines: Boolean;
        UserSetup: Record "User Setup";
        SendSms: codeunit SendSms;
        Members: record Members;

    //[Scope('OnPrem')]
    procedure UpdateControl()
    begin
        if Rec.Status = Rec.Status::Open then begin
            Mssage := true;
            UseHeader := true;
            BulkSMSLines := true;
        end;

        if Rec.Status = Rec.Status::Pending then begin
            Mssage := false;
            UseHeader := false;
            BulkSMSLines := false;
        end;

        if Rec.Status = Rec.Status::Rejected then begin
            Mssage := false;
            UseHeader := false;
            BulkSMSLines := false;
        end;
        if Rec.Status = Rec.Status::Approved then begin
            Mssage := false;
            UseHeader := false;
            BulkSMSLines := false;
        end;
    end;

    local procedure GetGreeting(): Text
    var
        CurrentTime: Time;
    begin
        CurrentTime := Time();
        if CurrentTime < 120000T then
            exit('Good Morning,');
        if CurrentTime < 180000T then
            exit('Good Afternoon,');
        exit('Good Evening,');
    end;
}

