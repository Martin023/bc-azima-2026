table 52185812 "HR CEO Setup"
{
    Caption = 'HR CEO Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "CEO Employee No."; Code[20])
        {
            Caption = 'CEO Employee No.';
            TableRelation = "HR Employees"."No." WHERE(Status = CONST(Active));

            trigger OnValidate()
            var
                HREmp: Record "HR Employees";
            begin
                "CEO Name" := '';
                "CEO User ID" := '';

                if "CEO Employee No." <> '' then begin
                    HREmp.Get("CEO Employee No.");
                    "CEO Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                    if HREmp."User ID" = '' then
                        Error('EMPLOYEE %1 DOES NOT HAVE A USER ID LINKED. PLEASE UPDATE THE EMPLOYEE CARD FIRST.', "CEO Employee No.");
                    "CEO User ID" := HREmp."User ID";
                end;
            end;
        }
        field(3; "CEO Name"; Text[200])
        {
            Caption = 'CEO Name';
            Editable = false;
        }
        field(4; "CEO User ID"; Code[50])
        {
            Caption = 'CEO User ID';
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(5; "Set By"; Code[100])
        {
            Caption = 'Set By';
            Editable = false;
        }
        field(6; "Set Date"; Date)
        {
            Caption = 'Set Date';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Primary Key" := 'CEO';
        "Set By" := UserId;
        "Set Date" := Today;
    end;

    trigger OnModify()
    begin
        "Set By" := UserId;
        "Set Date" := Today;
    end;

    // CALLED FROM GOALS HEADER — VALIDATES CURRENT USER IS THE CONFIGURED CEO
    procedure ValidateIsCEO()
    var
        CEOSetup: Record "HR CEO Setup";
        HREmp: Record "HR Employees";
    begin
        if not CEOSetup.Get('CEO') then
            Error('CEO SETUP IS NOT CONFIGURED. PLEASE ASK HR TO SET UP THE CEO IN HR CEO SETUP.');

        CEOSetup.TestField("CEO User ID");

        if UserId <> CEOSetup."CEO User ID" then
            Error('ACCESS DENIED: ONLY THE CONFIGURED CEO (%1) CAN CREATE CEO GOALS. YOUR USER ID IS %2.',
                CEOSetup."CEO Name", UserId);
    end;

    // RETURNS CEO EMPLOYEE NO FOR THE CURRENT USER — EMPTY IF NOT CEO
    procedure GetCEOEmployeeNo(): Code[20]
    var
        CEOSetup: Record "HR CEO Setup";
    begin
        if CEOSetup.Get('CEO') then
            if CEOSetup."CEO User ID" = UserId then
                exit(CEOSetup."CEO Employee No.");
        exit('');
    end;

    // RETURNS TRUE IF CURRENT USER IS THE CONFIGURED CEO
    procedure IsCEO(): Boolean
    var
        CEOSetup: Record "HR CEO Setup";
    begin
        if CEOSetup.Get('CEO') then
            exit(CEOSetup."CEO User ID" = UserId);
        exit(false);
    end;
}
