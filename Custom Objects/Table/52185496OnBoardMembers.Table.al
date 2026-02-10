table 52185496 "On Board Members"
{
    DrillDownPageId = "On Boarded Members";
    LookupPageId = "On Boarded Members";
    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Account No"; Code[30])
        {
            TableRelation = "Savings Accounts"."No." WHERE(Status = FILTER(Active | New | Dormant),
                                                            "Product Type" = CONST('505'));

            trigger OnValidate()
            begin
                "Member Name" := '';
                if SavingsAccounts.Get("Account No") then begin
                    "Member Name" := SavingsAccounts.Name;
                end;
            end;
        }
        field(3; "Phone Number"; Text[30])
        {

            trigger OnValidate()
            begin
                if "Username Login Type" = Rec."Username Login Type"::Phone then begin
                    if CopyStr("Phone Number", 1, 3) <> '254' then
                        Error('Phone number must begin with 254');
                    if StrLen("Phone Number") <> 12 then
                        Error('Phone number must be equal to 12 characters');

                end;
            end;
        }
        field(4; "Member Name"; Text[50])
        {
            Editable = false;
        }
        field(5; "E-Mail"; Text[30])
        {
        }
        field(6; "Username Login Type"; Option)
        {
            OptionMembers = Phone,"E-Mail";
        }
        field(7; Created; Boolean)
        {
            Editable = false;
        }
        field(8; "Created By"; Code[30])
        {
            Editable = false;
        }
        field(9; "Created At"; DateTime)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Created By" := UserId;
        "Created At" := CurrentDateTime;
    end;

    var
        SavingsAccounts: Record "Savings Accounts";
}

