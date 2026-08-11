table 52185692 "Next of KIN Application"
{
    LookupPageID = "Next of KIN Application";

    fields
    {
        field(1; "Record ID"; Code[30])
        {
            Editable = false;

        }
        field(13; "Identification Type"; Enum "Identification Type")
        {
            Editable = true;

            trigger OnValidate()
            var
                NextOfKinAppCheck: Record "Next of KIN Application";
                MyUniqueID: Text;
                IsUnique: Boolean;
            begin
                if xRec."Identification Type" <> "Identification Type"::" " then begin
                    if "Identification Type" = "Identification Type"::"System UID" then begin
                        if "System UID" = '' then begin

                            IsUnique := false;
                            repeat
                                MyUniqueID := GenerateSystemUID(10);
                                NextOfKinAppCheck.Reset();
                                NextOfKinAppCheck.SetRange("System UID", CopyStr(MyUniqueID, 1, MaxStrLen("System UID")));
                                if NextOfKinAppCheck.IsEmpty() then
                                    IsUnique := true;
                            until IsUnique;

                            "System UID" := CopyStr(MyUniqueID, 1, MaxStrLen("System UID"));
                        end else
                            MyUniqueID := "System UID";

                        Identification := CopyStr(MyUniqueID, 1, MaxStrLen(Identification));
                    end else
                        Identification := '';

                    "Date of Birth" := 0D;
                    Relationship := '';
                    Age := 0;
                end;
            end;
        }

        field(11; Identification; Code[30])
        {
            trigger OnValidate()
            var
                NextOfKinApp: Record "Next of KIN Application";
            begin
                if "Identification Type" <> "Identification Type"::"System UID" then begin
                    if "Identification Type" = "Identification Type"::"ID Number" then begin
                        if StrLen(Identification) > 9 then Error('ID Number cannot have more than 9 characters');
                        if StrLen(Identification) < 5 then Error('ID Number cannot have less than 7 characters');
                        Characters := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';
                        if not MemberApplication.ValidateShouldNotHaves(Identification, Characters) then Error('ID Number has invalid characters');
                    end;
                    if "Identification Type" = "Identification Type"::"Passport No" then begin
                        if StrLen(Identification) > 12 then Error('Passport Number cannot have more thna 12 characters');
                        if StrLen(Identification) < 7 then Error('Passport Number cannot have less than 7 characters');
                        Characters := '!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';
                        if not MemberApplication.ValidateShouldNotHaves(Identification, Characters) then Error('Passport Number has invalid characters');
                    end;
                    if "Identification Type" = "Identification Type"::"Birth Certificate Number" then begin
                        if StrLen(Identification) < 7 then Error('Birth Certificate Number cannot have less than 7 characters');
                        Characters := '!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';
                        if not MemberApplication.ValidateShouldNotHaves(Identification, Characters) then Error('Birth Certificate Number has invalid characters');
                    end;
                    if "Identification Type" = "Identification Type"::"Service Number" then begin
                        if StrLen(Identification) < 7 then Error('Service Number cannot have less than 7 characters');
                        if StrLen(Identification) > 10 then Error('Service Number cannot have more thna 10 characters');
                        Characters := '!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';
                        if not MemberApplication.ValidateShouldNotHaves(Identification, Characters) then Error('Service Number has invalid characters');
                    end;

                    // NextOfKin.Reset();
                    // NextOfKin.SetRange(Identification, Rec.Identification);
                    // NextOfKin.SetRange("Identification Type", Rec."Identification Type");
                    // if NextOfKin.FindFirst() then Error('Identification exists in Member Number: %1 Beneficiary name: %2', NextOfKin."Record ID", NextOfKin.Name);

                    // NextOfKinApp.Reset();
                    // NextOfKinApp.SetRange(Identification, Rec.Identification);
                    // NextOfKinApp.SetRange("Identification Type", Rec."Identification Type");
                    // NextOfKinApp.SetFilter("Record ID",'<>%1', );
                    // if NextOfKin.FindFirst() then Error('Identification exists in Member Number: %1 Beneficiary name: %2', NextOfKin."Record ID", NextOfKin.Name);
                end;

                RelationshipTypes.Reset;
                RelationshipTypes.SetRange(Relation, Relationship);
                if RelationshipTypes.Find('-') then begin
                    if RelationshipTypes.Self then begin
                        Error('You can not edit this value');
                    end;
                end;
            end;
        }
        field(3; Name; Text[50])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                Name := UpperCase(Name);

                RelationshipTypes.Reset;
                RelationshipTypes.SetRange(Relation, Relationship);
                if RelationshipTypes.Find('-') then begin
                    if RelationshipTypes.Self then begin
                        Error('You can noot edit this value');
                    end;
                end;
            end;
        }
        field(4; Relationship; Text[30])
        {
            Description = 'LookUp to Relationships Table';
            TableRelation = "Relationship Types";


            trigger OnValidate()
            var
                NextOfKinApp: Record "Next of KIN Application";
                MemberApplicationTable: Record "Member Application";
            begin
                "Date of Birth" := 0D;
                Age := 0;

                RelationshipTypes.Reset();
                RelationshipTypes.SetRange(Relation, Rec.Relationship);
                if RelationshipTypes.FindFirst() then begin
                    NextOfKinApp.Reset();
                    NextOfKinApp.SetRange("Record ID", Rec."Record ID");
                    NextOfKinApp.SetRange(Relationship, Rec.Relationship);
                    if NextOfKinApp.Find('-') then
                        if NextOfKinApp.Count > RelationshipTypes."BBF Max. Allowed" - 1 then Error('Max %1s allowed is %2', Relationship, RelationshipTypes."BBF Max. Allowed");

                    if RelationshipTypes.Self then begin
                        if MemberApplicationTable.Get(Rec."Record ID") then begin
                            MemberApplicationTable.TestField("Primary Identification");
                            MemberApplicationTable.TestField(Name);
                            if MemberApplicationTable."Date of Birth" = 0D then Error('Please fill the date of birth of the member first');
                            Identification := MemberApplicationTable."Primary Identification";
                            Name := MemberApplicationTable.Name;
                            "Date of Birth" := MemberApplicationTable."Date of Birth";

                            AgeVar := Round(((Today - "Date of Birth") / 365), 1, '=');
                            Message('age %1', AgeVar);
                        end;
                    end;
                end;


            end;
        }
        field(5; "Is a Beneficiary"; Boolean)
        {
        }
        field(20; "Is Next of Kin"; Boolean)
        {
            Enabled = false;
        }
        field(21; "Is Nominee"; Boolean)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if not "Is Nominee" then Allocation := 0;
            end;
        }
        field(22; "Is Contact Person"; Boolean)
        {
        }
        field(6; "Date of Birth"; Date)
        {

            trigger OnValidate()
            var
                DateofBirthError: Label 'This date cannot be greater than today.';
            begin
                if "Date of Birth" = 0D then exit;
                TestField(Relationship);
                if "Date of Birth" > Today then
                    Error(DateofBirthError);
                RelationshipTypes.Reset;
                RelationshipTypes.SetRange(Relation, Relationship);
                if RelationshipTypes.Find('-') then begin
                    if RelationshipTypes.Self then begin
                        Error('You can not edit this value');
                    end;
                    AgeVar := Round(((Today - "Date of Birth") / 365), 1, '=');
                    Message('age %1', AgeVar);
                    if (AgeVar < RelationshipTypes."Min. Age") or (AgeVar > RelationshipTypes."Max. Age") then
                        Error('This relationship %1 is of range min. Age:%2 and Max. Age:%3', RelationshipTypes.Relation, RelationshipTypes."Min. Age", RelationshipTypes."Max. Age");
                end;

                Age := AgeVar;
                if ("Identification Type" = "Identification Type"::"ID Number") or ("Identification Type" = "Identification Type"::"Passport No") or
                   ("Identification Type" = "Identification Type"::"Service Number") then
                    if Age < 18 then Error('Age must be greater than 18 for identification type %1', "Identification Type");

                if RelationshipTypes.Self then begin
                    Error('You can not edit this value');
                end;
            end;
        }
        field(7; Address; Text[30])
        {

            trigger OnValidate()
            begin
                Address := UpperCase(Address);
            end;
        }
        field(8; Telephone; Code[20])
        {
            Caption = 'Mobile No.';
            CharAllowed = '0123456789';
        }

        field(10; Email; Text[30])
        {

            trigger OnValidate()
            begin
            end;
        }

        field(12; Allocation; Decimal)
        {
            trigger OnValidate()
            var
                Allocations: Decimal;
            begin
                if not "Is Nominee" then Error('Percentages can oly be filled for nominees');
                NOK.Reset();
                NOK.SetRange("Record ID", Rec."Record ID");
                NOK.SetRange(Removed, false);
                NOK.SetFilter("No.", '<>%1', Rec."No.");
                if NOK.Find('-') then begin
                    NOK.CalcSums(Allocation);
                    Allocations := NOK.Allocation;
                end;

                if Allocations + Allocation > 100 then Error('Total allocations cannot be greater than a 100%');
            end;
        }

        field(14; Deceased; Boolean)
        {
            Editable = false;
        }
        field(15; "No."; Integer)
        {
            Editable = false;
            AutoIncrement = true;
        }

        field(18; "Date Captured"; Date)
        {
            Editable = false;
        }
        field(19; "Portal Application"; Boolean)
        {
        }
        field(23; Removed; Boolean)
        {

        }
        field(24; "Is A WitNess"; Boolean)
        {
            Enabled = false;
        }
        field(25; "From Member Register"; Boolean)
        {

        }
        field(26; "System UID"; Code[10])
        {
            Editable = false;
        }
        field(27; "Special Instructions"; Text[250])
        {

        }
        field(28; Age; Integer)
        {
            Editable = false;
        }
        field(29; "Assigned Guardian"; Code[100])
        {
            TableRelation = "Next of KIN Application"."No." where("Is a Beneficiary" = const(true), "Record ID" = FIELD("Record ID"));
        }
        field(30; Gender; Enum Gender)
        {
        }
    }

    keys
    {
        key(Key1; "Record ID", "No.")
        {
        }
    }

    trigger OnInsert()
    begin
        "Date Captured" := Today;
    end;

    var
        NOK: Record "Next of KIN Application";
        TotalA: Decimal;
        NOK1: Record "Next of KIN Application";
        // dSMTPMail: Codeunit "SMTP Mail";
        BEntitlement: Record "BBF Entitlement";
        RelationshipTypes: Record "Relationship Types";
        AgeVar: Integer;
        TotRel: Integer;
        MemberApplication: Record "Member Application";
        Err0001: Label 'Age of a child cannot be greater than the principal member';
        BBFRequisationHeader: Record "BBF Requisation Header";
        CountBen: Integer;
        BBFEntitlement: Record "BBF Entitlement";
        Characters: Text;
        NextOfKin: Record "Next of KIN";

    procedure FieldLength(VarVariant: Text; FldLength: Integer): Text
    var
        FieldLengthError: Label 'Field cannot be more than %1 Characters.';
    begin
        if StrLen(VarVariant) > FldLength then
            Error(FieldLengthError, FldLength);
    end;

    trigger OnDelete()
    var
        myInt: Integer;
    begin
        if Rec."From Member Register" then begin
            Error('You cannot delete this value because it''s from member register');
        end;
    end;

    local procedure GenerateSystemUID(Length: Integer): Text
    var
        AllowedChars: Text;
        ResultUID: Text;
        i: Integer;
    begin
        AllowedChars := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        for i := 1 to Length do
            ResultUID += CopyStr(AllowedChars, Random(StrLen(AllowedChars)), 1);

        exit(ResultUID);
    end;
}

