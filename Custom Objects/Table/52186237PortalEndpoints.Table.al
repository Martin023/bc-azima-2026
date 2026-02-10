table 52186237 "Portal Endpoints"
{

    fields
    {
        field(1; Name; Code[50])
        {
            Editable = true;

            trigger OnValidate()
            begin
                CreateLogs(Name, Enabled, "Password Verification", "OTP Verification", ActionG::Modify, 'Name');
            end;
        }
        field(2; Enabled; Option)
        {
            OptionMembers = YES,NO;

            trigger OnValidate()
            begin
                CreateLogs(Name, Enabled, "Password Verification", "OTP Verification", ActionG::Modify, 'Enabled');
            end;
        }
        field(3; "Password Verification"; Option)
        {
            Editable = false;
            OptionMembers = ACTIVE,INACTIVE;

            trigger OnValidate()
            begin
                CreateLogs(Name, Enabled, "Password Verification", "OTP Verification", ActionG::Modify, 'Password Verification');
            end;
        }
        field(4; "OTP Verification"; Option)
        {
            Editable = false;
            OptionMembers = ACTIVE,INACTIVE;

            trigger OnValidate()
            begin
                CreateLogs(Name, Enabled, "Password Verification", "OTP Verification", ActionG::Modify, 'OTP Verification');
            end;
        }
        field(5; "Change Status Stats"; Integer)
        {
            CalcFormula = Count("Log Endpoint  Entiries" WHERE(Name = FIELD(Name)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Name)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        UserEndPoint: Record "Portal Endpoints";
        UserNm: Record "Log Endpoint  Entiries";
    begin
        CreateLogs(Name, Enabled, "Password Verification", "OTP Verification", ActionG::Delete, Name);
    end;

    trigger OnInsert()
    var
        UserEndPoint: Record "Portal Endpoints";
        userNm: Record "Log Endpoint  Entiries";
    begin
        CreateLogs(Name, Enabled, "Password Verification", "OTP Verification", ActionG::Insert, Name);
        "Password Verification" := "Password Verification"::ACTIVE;
        "OTP Verification" := "OTP Verification"::ACTIVE;
    end;

    trigger OnModify()
    var
        UserEndPoint: Record "Portal Endpoints";
        UserNm: Record "Log Endpoint  Entiries";
    begin
    end;

    var
        LogEndpointEntiries: Record "Log Endpoint  Entiries";
        ActionG: Option Insert,Delete,Modify;

    local procedure CreateLogs(Namef: Text; Enabledf: Option YES,NO; "Password Verificationf": Option ACTIVE,INACTIVE; "OTP Verificationf": Option ACTIVE,INACTIVE; "Action": Option Insert,Delete,Modify; AffectedField: Text)
    begin
        LogEndpointEntiries.Init;
        LogEndpointEntiries.Name := Namef;
        LogEndpointEntiries.Enabled := Enabledf;
        LogEndpointEntiries."OTP Verification" := "OTP Verificationf";
        LogEndpointEntiries."Password Verification" := "Password Verificationf";
        LogEndpointEntiries.Action := Action;
        LogEndpointEntiries."User ID" := UserId;
        LogEndpointEntiries.Date := Today;
        LogEndpointEntiries.Time := Time;
        LogEndpointEntiries."Affected Field/Row" := AffectedField;
        LogEndpointEntiries.Insert;
    end;
}

