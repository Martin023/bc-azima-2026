table 52185984 "Global Bulk SMS Line"
{
    Caption = 'Global Bulk SMS Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Campaign No."; Code[20])
        {
            Caption = 'Campaign No.';
            DataClassification = CustomerContent;
            TableRelation = "Global Bulk SMS Header"."Campaign No.";
        }

        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }

        field(3; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            DataClassification = CustomerContent;
            TableRelation = Members."No.";

            trigger OnValidate()
            var
                Member: Record Members;
            begin
                if "Member No." = '' then
                    Error('Member No. cannot be blank.');

                if not Member.Get("Member No.") then
                    Error('Member %1 does not exist.', "Member No.");

                if Member.Status = Member.Status::Deceased then
                    Error('Cannot add deceased member %1 to SMS campaign.', "Member No.");

                "Member Name" := Member.Name;

                if "Phone No." = '' then begin
                    "Phone No." := Member."Phone No.";
                    ValidatePhoneNumber();
                end;
            end;
        }

        field(4; "Member Name"; Text[200])
        {
            Caption = 'Member Name';
            DataClassification = CustomerContent;
        }

        field(5; "Phone No."; Code[20])
        {
            Caption = 'Phone No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                ValidatePhoneNumber();
            end;
        }

        field(6; "Personalized Message"; Text[2000])
        {
            Caption = 'Personalized Message';
            DataClassification = CustomerContent;
        }

        field(7; "Token Values"; Text[2000])
        {
            Caption = 'Token Values';
            DataClassification = CustomerContent;
        }

        field(8; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionMembers = Pending,Sent,Failed,Skipped;
            OptionCaption = 'Pending,Sent,Failed,Skipped';
            InitValue = Pending;
        }

        field(9; "Sent DateTime"; DateTime)
        {
            Caption = 'Sent DateTime';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(10; "Error Message"; Text[250])
        {
            Caption = 'Error Message';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(11; "Retry Count"; Integer)
        {
            Caption = 'Retry Count';
            DataClassification = CustomerContent;
            InitValue = 0;
            Editable = false;
        }

        field(12; "Sent By"; Code[50])
        {
            Caption = 'Sent By';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Campaign No.", "Line No.")
        {
            Clustered = true;
        }
        key(Member; "Member No.")
        {
        }
        key(Status; "Campaign No.", Status)
        {
        }
        key(Phone; "Phone No.")
        {
        }
    }

    trigger OnInsert()
    var
        Header: Record "Global Bulk SMS Header";
    begin
        if not Header.Get("Campaign No.") then
            Error('Campaign %1 does not exist.', "Campaign No.");

        if Header.Status in [Header.Status::Sending, Header.Status::Completed] then
            Error('Cannot add recipients to campaign with status %1.', Header.Status);

        TestField("Member No.");
        TestField("Phone No.");

        if "Personalized Message" = '' then
            "Personalized Message" := Header."Message Template";

        Status := Status::Pending;
        "Retry Count" := 0;
    end;

    trigger OnModify()
    var
        Header: Record "Global Bulk SMS Header";
    begin
        if Status = Status::Sent then
            if (xRec.Status = Status::Sent) and (Status = Status::Sent) then
                if (xRec."Sent DateTime" <> 0DT) then
                    Error('Cannot modify a line that has already been sent.');

        if Header.Get("Campaign No.") then
            if Header.Status = Header.Status::Completed then
                if not (Status in [Status::Pending, Status::Failed]) then
                    Error('Cannot modify line in completed campaign except to reset for retry.');
    end;

    trigger OnDelete()
    var
        Header: Record "Global Bulk SMS Header";
    begin
        if Header.Get("Campaign No.") then
            if Header.Status in [Header.Status::Sending, Header.Status::Completed] then
                Error('Cannot delete recipients from campaign with status %1.', Header.Status);
    end;

    local procedure ValidatePhoneNumber()
    var
        CleanPhone: Text;
        i: Integer;
        CharVar: Char;
    begin
        if "Phone No." = '' then
            exit;

        CleanPhone := '';
        for i := 1 to StrLen("Phone No.") do begin
            CharVar := "Phone No."[i];
            if CharVar in ['0' .. '9', '+'] then
                CleanPhone := CleanPhone + Format(CharVar);
        end;

        if CleanPhone = '' then
            Error('Phone number must contain at least one digit.');

        if StrLen(CleanPhone) < 10 then
            Error('Phone number must be at least 10 digits. Received: %1', CleanPhone);

        if StrLen(CleanPhone) > 15 then
            Error('Phone number cannot exceed 15 digits. Received: %1', CleanPhone);

        if (CleanPhone[1] = '+') and (StrLen(CleanPhone) < 11) then
            Error('International phone number format requires at least 11 characters including +. Received: %1', CleanPhone);

        "Phone No." := CopyStr(CleanPhone, 1, MaxStrLen("Phone No."));
    end;

    procedure MarkAsSent()
    begin
        Status := Status::Sent;
        "Sent DateTime" := CurrentDateTime();
        "Sent By" := CopyStr(UserId(), 1, MaxStrLen("Sent By"));
        "Error Message" := '';
        Modify(true);
    end;

    procedure MarkAsFailed(ErrorText: Text)
    begin
        Status := Status::Failed;
        "Error Message" := CopyStr(ErrorText, 1, MaxStrLen("Error Message"));
        "Retry Count" += 1;
        Modify(true);
    end;

    procedure ResetForRetry()
    begin
        if not (Status in [Status::Failed, Status::Skipped]) then
            Error('Can only reset Failed or Skipped lines.');

        Status := Status::Pending;
        "Error Message" := '';
        Modify(true);
    end;

    procedure SkipLine(Reason: Text)
    begin
        Status := Status::Skipped;
        "Error Message" := CopyStr(Reason, 1, MaxStrLen("Error Message"));
        Modify(true);
    end;

    procedure CheckDuplicatePhone(): Boolean
    var
        ExistingLine: Record "Global Bulk SMS Line";
    begin
        ExistingLine.SetRange("Campaign No.", "Campaign No.");
        ExistingLine.SetRange("Phone No.", "Phone No.");
        ExistingLine.SetFilter("Line No.", '<>%1', "Line No.");
        exit(not ExistingLine.IsEmpty());
    end;

    procedure CheckDuplicateMember(): Boolean
    var
        ExistingLine: Record "Global Bulk SMS Line";
    begin
        ExistingLine.SetRange("Campaign No.", "Campaign No.");
        ExistingLine.SetRange("Member No.", "Member No.");
        ExistingLine.SetFilter("Line No.", '<>%1', "Line No.");
        exit(not ExistingLine.IsEmpty());
    end;
}
