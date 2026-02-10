page 52187323 "Promise Topay Card"
{
    //DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Promise Topay Header";
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = GeneralTabEditable;
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Member No."; Rec."Member No.")
                {

                }
                field("Member Name"; Rec."Member Name")
                {
                    Editable = false;
                }

                field("Promise Status"; Rec."Promise Status")
                {
                    Editable = false;
                }

            }
            group("SMS Area")
            {
                Visible = SMSTabVisible;
                field("Write an SMS"; Rec."Write an SMS")
                {
                    MultiLine = true;
                }
                field("Loan Reference"; Rec."Loan Reference")
                {

                }
                field("Phone Number"; Rec."Phone Number")
                {

                }
            }

            group("Audit Trail")
            {
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field("Created At"; Rec."Created At")
                {
                    Editable = false;
                }

                field("Closed By"; Rec."Closed By")
                {
                    Editable = false;
                }
                field("Closed At"; Rec."Closed At")
                {
                    Editable = false;
                }
            }
            group("Work Distribution")
            {
                field("Responsible Officer"; Rec."Responsible Officer")
                {
                    Editable = false;
                }
                field("Supervisor ID"; Rec."Supervisor ID")
                {
                    Editable = false;
                }
            }
            part("Promise Topay SMS"; "Promise Topay SMS")
            {
                Visible = SMSLogTabVisible;
                Editable = false;
                SubPageLink = "Header No." = field("No.");
            }


        }
    }

    actions
    {
        area(creation)
        {
            action("Promise Lines")
            {
                ApplicationArea = Basic, Suite;
                Image = MoveToNextPeriod;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Promise Topay Lines";
                RunPageLink = "Header No." = field("No."), "Member No." = field("Member No.");

            }
            action("Activate Promise")
            {
                Visible = ActivatePromiseVisible;
                ApplicationArea = Basic, Suite;
                Image = CloseDocument;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    if not Confirm('Are you sure you want to activate this promise?') then exit;
                    PromiseLines.Reset();
                    PromiseLines.SetRange("Header No.", Rec."No.");
                    PromiseLines.SetFilter("Loan No.", '<>%1', '');
                    if PromiseLines.Find('-') then begin
                        repeat
                            if PromiseLines."Amount to Pay" = 0 then Error('Amount to pay can not be 0 in one of the promise lines');
                            if PromiseLines."Topay Date" = 0D then Error('To pay Date can not be empty in one of the promise lines');
                        until PromiseLines.Next() = 0;
                    end else
                        Error('Kindly add promise lines');
                    Rec."Promise Status" := Rec."Promise Status"::Active;
                    Rec.Modify();
                    PageControl();
                    Message('Promise activated successfully');
                end;

            }
            action("Close Promise")
            {
                Visible = ClosePromiseVisible;
                ApplicationArea = Basic, Suite;
                Image = CloseDocument;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    if Rec."Promise Status" <> Rec."Promise Status"::Active then Error('Only active promises can be closed');
                    if not Confirm('Are you sure you want to close this promise?\NB: Closed proises can not be reopened.') then exit;
                    PromiseLines.Reset();
                    PromiseLines.SetRange("Header No.", Rec."No.");
                    PromiseLines.SetRange("Close Promise", false);
                    if PromiseLines.Find('-') then begin
                        repeat
                            if PromiseLines."Amount Paid" < PromiseLines."Amount to Pay" then begin
                                if PromiseLines.Comment = '' then
                                    if PromiseLines."Amount Paid" > 0 then
                                        Error('This case can not be closed due to Loan Number %1 payment being KES %2 shy of %3. If you really need to close it, kindly add a comment.',
                                            PromiseLines."Loan No.", (PromiseLines."Amount to Pay" - PromiseLines."Amount Paid"), PromiseLines."Amount to Pay")
                                    else
                                        Error('This case can not be closed because there is no payment made to Loan Number %1 . If you really need to close it, kindly add a comment.',
                                                PromiseLines."Loan No.");
                            end;
                        until PromiseLines.Next() = 0;
                    end;
                    PageControl();
                    Message('Promise closed successfully');
                end;

            }
            action("Send an SMS")
            {
                Visible = SendSMSVisible;
                ApplicationArea = Basic, Suite;
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    SendSMS: Codeunit SendSms;
                    Source: Enum "SMS Source";

                begin
                    Rec.TestField("Phone Number");
                    if Rec."Loan Reference" = '' then Error('Loan Reference field must have a value');
                    if not Confirm('Are you sure you want to snd this SMS?') then exit;
                    LogSMS();
                    SendSMS.SendSms(Source::LOAN_DEFAULTED, Rec."Phone Number", Rec."Write an SMS", Rec."Member No.", '', true, 0, false, 'CBS', Rec."Member No.", 'CBS');
                    Message('SMS Sent successfully');
                end;
            }
            group(TaskAssignment)
            {
                Caption = 'Assign Task';
                action(AssinedUser)
                {
                    ApplicationArea = all;
                    Image = Task;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "User Tasks";
                    RunPageLink = "Record ID" = FIELD("No.");
                    Caption = 'User Assigned';
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        PageControl();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        PageControl();
    end;

    trigger OnAfterGetRecord()
    begin
        PageControl();
    end;

    trigger OnClosePage()
    begin
        PageControl();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        PageControl();
    end;

    procedure LogSMS()
    begin
        PromiseTopayLog.Init();
        PromiseTopayLog."Header No." := Rec."No.";
        PromiseTopayLog."Member No" := Rec."Member No.";
        PromiseTopayLog.Validate("Member No");
        PromiseTopayLog.SMS := Rec."Write an SMS";
        PromiseTopayLog."Loan Number" := Rec."Loan Reference";
        PromiseTopayLog."Date Created" := CurrentDateTime;
        PromiseTopayLog."Created By" := UserId;
        PromiseTopayLog.Insert(true);
    end;

    procedure PageControl()
    begin
        GeneralTabEditable := false;
        SMSTabVisible := false;
        SMSLogTabVisible := false;
        ActivatePromiseVisible := false;
        ClosePromiseVisible := false;
        SendSMSVisible := false;

        if Rec."Promise Status" = Rec."Promise Status"::New then begin
            GeneralTabEditable := true;
            SMSTabVisible := false;
            SMSLogTabVisible := false;
            ActivatePromiseVisible := true;
            ClosePromiseVisible := false;
            SendSMSVisible := false;
        end;
        if Rec."Promise Status" = Rec."Promise Status"::Active then begin
            GeneralTabEditable := false;
            SMSTabVisible := true;
            SMSLogTabVisible := true;
            ActivatePromiseVisible := false;
            ClosePromiseVisible := true;
            SendSMSVisible := true;
        end;
        if Rec."Promise Status" = Rec."Promise Status"::Closed then begin
            GeneralTabEditable := false;
            SMSTabVisible := false;
            SMSLogTabVisible := true;
            ActivatePromiseVisible := false;
            ClosePromiseVisible := false;
            SendSMSVisible := false;
        end;
    end;

    var
        PromiseTopayLog: Record "PromiseTopay SMS Log";
        PromiseLines: Record "Promise Topay Lines";

        GeneralTabEditable: Boolean;
        SMSTabVisible: Boolean;
        SMSLogTabVisible: Boolean;
        ActivatePromiseVisible: Boolean;
        ClosePromiseVisible: Boolean;
        SendSMSVisible: Boolean;


}

