table 52186840 "Notification EmSms setup"
{
    Caption = 'Notification setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "user id"; Code[50])
        {
            Caption = 'user id';
            TableRelation = "User Setup"."User ID";
            trigger OnValidate()
            var
                Usersetup: record "User Setup";
            begin
                Usersetup.reset();
                Usersetup.setrange("User ID", "user id");
                if usersetup.FindFirst() then begin
                    "Responsibility Centre" := Usersetup."Responsibility Centre";
                end;
            end;
        }
        field(2; "Notification"; Enum NotificationEmailSMS)
        {
            Caption = 'Notification';
        }
        field(3; "Send Email"; Boolean)
        {
            Caption = 'Send Email';
        }
        field(4; "send sms"; Boolean)
        {
            Caption = 'send sms';
        }
        field(5; "Responsibility Centre"; Code[40])
        {
            Caption = 'Responsibility Centre';
        }
    }
    keys
    {
        key(PK; "user id", Notification)
        {
            Clustered = true;
        }
    }
    trigger OnDelete()

    var
        myInt: Integer;
    begin
        UserSetup.Reset();
        UserSetup.SetRange("Responsibility Centre", NotificationSetup."Responsibility Centre");
        if not UserSetup.find('-') then begin
            Error('You cannot delete this record.')
        end
        else
            delete();
    end;
   

    Var
    UserSetup: Record "User Setup";
    NotificationSetup: Record "Notification EmSms setup";
}
