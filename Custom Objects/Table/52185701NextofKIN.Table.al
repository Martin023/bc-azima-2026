table 52185701 "Next of KIN"
{
    DrillDownPageID = "Next of KIN";
    LookupPageID = "Next of KIN";

    fields
    {
        field(2; "Record ID"; Code[20])
        {
            Description = 'LookUp to Member Application Table';
            TableRelation = Members."No.";
        }

        field(40; "Member Name"; Text[80])
        {
            Description = 'LookUp to Relationships Table';
            TableRelation = Members.Name;
        }
        field(3; Name; Text[80])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                Name := UpperCase(Name);
            end;
        }
        field(4; Relationship; Text[30])
        {
            Description = 'LookUp to Relationships Table';
            TableRelation = "Relationship Types";
        }

        field(6; "Date of Birth"; Date)
        {
            trigger OnValidate()
            var
                DateofBirthError: Label 'This date cannot be greater than today.';
            begin
                if "Date of Birth" > Today then
                    Error(DateofBirthError);
            end;
        }
        field(7; Address; Text[30])
        {
        }
        field(8; Telephone; Code[20])
        {
            Caption = 'Mobile No.';
            CharAllowed = '0123456789';
        }

        field(10; Email; Text[30])
        {
        }
        field(20; "Identification Type"; Enum "Identification Type")
        {
        }
        field(11; Identification; Code[20])
        {

            trigger OnValidate()
            begin
                Identification := DelChr(Identification, '=', 'A|B|C|D|E|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|.|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?|+|-|_');
            end;
        }
        field(12; Allocation; Decimal)
        {
            MinValue = 0;

            trigger OnValidate()
            begin
                TotalA := 0;

                NOK.Reset;
                NOK.SetRange(NOK."Record ID", "Record ID");
                if NOK.Find('-') then begin
                    repeat
                        TotalA := TotalA + NOK.Allocation
                    until NOK.Next = 0;
                end;
                TotalA := TotalA + Allocation;

            end;
        }

        field(14; Deceased; Boolean)
        {
            Editable = false;
        }

        field(5; "Is a Beneficiary"; Boolean)
        {

        }
        field(13; "Is Next of Kin"; Boolean)
        {
            Enabled = false;
        }
        field(17; "Is Nominee"; Boolean)
        {

        }
        field(21; "Is Contact Person"; Boolean)
        {
        }
        field(18; "Date Modified"; Date)
        {
        }
        field(19; "Date Captured"; Date)
        {
            Editable = false;
        }
        field(22; Removed; Boolean)
        {
            Editable = false;
        }
        field(23; "Is A WitNess"; Boolean)
        {

        }
        field(24; "System UID"; Code[10])
        {
            Editable = false;
        }
        field(25; "Special Instructions"; Text[250])
        {

        }
        field(67; "Date Approved"; Date)
        {
            TableRelation = Members."No.";
            trigger OnValidate()
            begin
                Members.Reset;
                Members.SetRange(Members."No.", "Record ID");
                if Members.Find('-') then begin
                    "Date Approved" := Members."Date Approved";
                end;
            end;

        }

        field(68; Gender; Enum Gender)
        {

        }
        field(69; "Insurance Claim Paid"; Boolean)
        {
            Editable = false;
        }
        field(70; "Employer Code"; Code[100])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Employer Code" where("No." = field("Record ID")));
            TableRelation = Customer;
        }

    }

    keys
    {
        key(Key1; "Record ID", Identification)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        PasswordHandler: Codeunit "Password Handler";
    begin
        "Date Modified" := Today;

        if Identification = '' then begin
            if "System UID" = '' then begin
                Identification := PasswordHandler.GeneratePassword(10);
                "System UID" := Identification;
            end else begin
                Identification := "System UID";
            end;
        end;
    end;

    trigger OnModify()
    begin
        "Date Modified" := Today;
    end;

    var
        NOK: Record "Next of KIN";
        TotalA: Decimal;
        NOK1: Record "Next of KIN";
        BEntitlement: Record "BBF Entitlement";
        Members: Record Members;

    [Scope('OnPrem')]
    procedure FieldLength(VarVariant: Text; FldLength: Integer): Text
    var
        FieldLengthError: Label 'Field cannot be more than %1 Characters.';
    begin
        if StrLen(VarVariant) > FldLength then
            Error(FieldLengthError, FldLength);
    end;
}

