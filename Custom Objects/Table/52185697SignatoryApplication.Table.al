table 52185697 "Signatory Application"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
        }
        field(2; "Account No"; Code[20])
        {
            NotBlank = true;
        }
        field(3; Names; Text[50])
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                if "Account Type" = "Account Type"::Member then
                    TestField("Member No.");
            end;
        }
        field(4; "Date Of Birth"; Date)
        {

            trigger OnValidate()
            var
                DateofBirthError: Label 'This date cannot be greater than today.';
                MinMemberAge: Text;
            begin

                if "Date Of Birth" > Today then
                    Error(DateofBirthError);
                GeneralSetup.Get;
                MinMemberAge := Format(GeneralSetup."Min. Member Age");

                if "Date Of Birth" > CalcDate(GeneralSetup."Min. Member Age", Today) then
                    Error('Minimum age required is %1', GeneralSetup."Min. Member Age");


                if (CalcDate(GeneralSetup."Max. Age Non-Common Bond", "Date Of Birth")) < Today
                then
                    Error('The member age of %1 is exceeded', GeneralSetup."Max. Age Non-Common Bond");
            end;
        }
        field(5; "Staff/Payroll"; Code[20])
        {
        }
        field(6; "ID Number"; Code[50])
        {
        }
        field(7; Signatory; Boolean)
        {

            trigger OnValidate()
            begin
                if Type <> Type::Member then
                    TestField("PIN Number");
            end;
        }
        field(8; "Must Sign"; Boolean)
        {

            trigger OnValidate()
            begin
                if Type <> Type::Member then
                    TestField("PIN Number");
            end;
        }
        field(9; "Must be Present"; Boolean)
        {
        }
        field(10; Picture; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(11; Signature; Blob)
        {
            Caption = 'Signature';
            SubType = Bitmap;
        }
        field(12; "Expiry Date"; Date)
        {
        }
        field(13; Type; Option)
        {
            OptionCaption = 'Member,Chair Person,Secretary,Treasurer,Vice Chair Persion';
            OptionMembers = Member,"Chair Person",Secretary,Treasurer,"Vice Chair Persion";

            trigger OnValidate()
            begin
                
                // SignatoryApplication.Reset;
                // SignatoryApplication.SetRange("Account No", "Account No");
                // SignatoryApplication.SetRange(Type, Type);
                // if SignatoryApplication.Find('-') then begin
                //     if Type <> Type::Member then
                //         Error('Error %1', Type);
                // end;
                // TestField("Account Type", "Account Type"::Member);
                // if Type <> Type::Member then
                //     TestField("PIN Number");
            end;
        }
        field(14; "Member No."; Code[10])
        {
            TableRelation = IF ("Account Type" = CONST(Member)) Members WHERE(Status = FILTER(Active | New | Dormant));
            trigger OnValidate()
            var
                Members: Record Members;
                ImageData: Record "Image Data";
                MemberApplication: Record "Member Application";
                CurrentMemberApplication: Record "Member Application";
                AccountSignatories: Record "Account Signatories";
            begin

                Names := '';
                "ID Number" := '';
                "Date Of Birth" := 0D;
                "Staff/Payroll" := '';
                "Phone No." := '';
                "PIN Number" := '';
                if "Account Type" = "Account Type"::Member then begin
                    if Members.Get("Member No.") then begin
                        Members.TestField("Primary Identification");
                        Members.TestField(Name);
                        Members.TestField("Date of Birth");
                        // Members.TestField("Payroll/Staff No.");
                        Members.TestField("Phone No.");
                        // Members.TestField("P.I.N Number");
                        "First Name" := Members."First Name";
                        "Second Name" := Members."Middle Name";
                        Names := Members.Name;
                        "ID Number" := Members."Primary Identification";
                        "Date Of Birth" := Members."Date of Birth";
                        "Staff/Payroll" := Members."Payroll/Staff No.";
                        "Phone No." := Members."Phone No.";
                        "PIN Number" := Members."P.I.N Number";

                        ImageData.Reset;
                        ImageData.SetRange(ImageData."Member No", Members."No.");
                        if ImageData.Find('-') then begin
                            ImageData.CalcFields(Picture, Signature);
                            Rec.Picture := ImageData.Picture;
                            Rec.Signature := ImageData.Signature;
                        end;
                    end;
                end;
                if "Account Type" = "Account Type"::Member then begin
                    //Look for all applications where this member is a member and of the same business group, if find then throw an error
                    if CurrentMemberApplication.Get(Rec."Account No") then begin
                        SignatoryApplication.Reset();
                        SignatoryApplication.SetFilter("Account No", '<>%1', Rec."Account No");
                        SignatoryApplication.SetRange("Member No.", Rec."Member No.");
                        if SignatoryApplication.Find('-') then begin
                            repeat
                                MemberApplication.Reset();
                                MemberApplication.SetRange("No.", SignatoryApplication."Account No");
                                MemberApplication.SetRange(Created, false);
                                MemberApplication.SetRange("Account Type", CurrentMemberApplication."Account Type");
                                MemberApplication.SetFilter(Status, '%1|%2|%3', MemberApplication.Status::Open, MemberApplication.Status::Approved, MemberApplication.Status::Deffered);
                                if MemberApplication.FindFirst() then
                                    Error('This member is in another application %1 with status %2', MemberApplication."No.", MemberApplication.Status);
                            until SignatoryApplication.Next() = 0;
                        end;
                        // if (CurrentMemberApplication."Account Type" = CurrentMemberApplication."Account Type"::"Group Account") or
                        //  (CurrentMemberApplication."Account Type" = CurrentMemberApplication."Account Type"::"Group Account") then
                        //     if not Members."Has Joined Business Loans" then Error('This member has not joned business loan');
                    end;


                    // AccountSignatories.Reset();
                    // AccountSignatories.SetFilter("Account No", '<>%1', Rec."Account No");
                    // AccountSignatories.SetRange("Member No.", Rec."Member No.");
                    // if AccountSignatories.Find('-') then begin
                    //     repeat
                    //         Members.Reset();
                    //         Members.SetRange("No.", AccountSignatories."Account No");
                    //         Members.SetRange("Account Type", CurrentMemberApplication."Account Type");
                    //         if Members.FindFirst() then
                    //             Error('This member is in another group %1', Members."No.");
                    //     until AccountSignatories.Next() = 0;
                    // end;

                    //Members can belong to multiple groups  

                    //if not Members."Has Joined Business Loans" then Message('This member has not joned business loan');
                end;

            end;
        }
        field(15; "Entry Type"; Option)
        {
            OptionCaption = 'Initial,Changes';
            OptionMembers = Initial,Changes;
        }
        field(16; "Phone No."; Code[20])
        {

            trigger OnValidate()
            begin
                "Phone No." := DelChr("Phone No.", '=', 'A|B|C|D|E|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|.|,|!|@|#|$|%|^|&|*|(|)|[|]|{|}|/|\|"|;|:|<|>|?|-|_');

                if "Phone No." <> '' then begin

                    ///CountryRegion.GET(Nationality);
                    if (CopyStr("Phone No.", 1, 3)) <> ('254') then
                        Error('The Mobile phone No. should take the format of ' + '254');
                    if StrLen("Phone No.") < 10 then
                        Error('Phone No. should be equal to 12 characters');
                end;
            end;
        }
        field(17; "Account Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Member,Non-Member';
            OptionMembers = Member,"Non-Member";

            trigger OnValidate()
            var
                MemberApplication: Record "Member Application";
            begin
                // "Member No." := '';
                // if MemberApplication.Get("Account No") then begin
                //     if MemberApplication."Account Type" = MemberApplication."Account Type"::"Group Account" then begin
                //         if "Account Type" = Rec."Account Type"::"Non-Member" then Error('');
                //     end;
                // end;
            end;
        }
        field(18; "PIN Number"; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
                MemberApplication: Record "Member Application";
                Cust: Record Members;
                Characters: Text;
                GlobalFunctions: Codeunit "Global Functions";

            begin

                if "PIN Number" <> '' then begin
                    MemberApplication.Reset;
                    MemberApplication.SetRange(MemberApplication."P.I.N Number", "PIN Number");
                    MemberApplication.SetFilter(MemberApplication.Status, '%1', MemberApplication.Status::Open);
                    // MemberApplication.SetFilter(MemberApplication."No.", '<>%1', "No.");
                    if MemberApplication.Find('-') then begin
                        repeat
                            if (MemberApplication.Status in [MemberApplication.Status::Open, MemberApplication.Status::Pending,
                                                             MemberApplication.Status::Approved]) then
                                //IF "Type of Application" <> "Type of Application"::Readmission then
                                    Error('KRA PIN number has already been used in member application %1', MemberApplication."No.");
                        until MemberApplication.Next = 0;
                    end;

                    Cust.Reset;
                    Cust.SetRange(Cust."P.I.N Number", "PIN Number");
                    if Cust.FindFirst then
                        //IF "Type of Application" <> "Type of Application"::Readmission then
                        // Error(MemberExistError, Cust."No.", Cust.Name);
                        Error('The given K.R.A pin %1 already exists!', "PIN Number");

                    // if "Account Type" = Rec."Account Type"::"Single Member Account" then begin
                    //     if StrPos("P.I.N Number", 'A') <> 1 then
                    //         Error('KRA Pin: First letter must be an A');
                    // end;

                    if StrLen("PIN Number") <> 11 then Error('KRA Pin Number length must be 11 characters');

                    Characters := '1234567890!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';
                    if not ValidateShouldNotHaves(CopyStr("PIN Number", 11, 1), Characters) then Error('KRA Pin: Last character must be a letter');

                    Characters := '1234567890';
                    if ValidateShouldNotHaves(CopyStr("PIN Number", 2, 8), Characters) then Error('KRA Pin number must be alphanumeric');

                    if not GlobalFunctions.ValidateKRAPIN("PIN Number") then begin
                        Error('Invalid KRA Pin format. Sample Expected format is: A123456789X');
                    end;
                end;

            end;
        }
        field(19; "First Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "First Name" := UpperCase("First Name");
                rec.Names := rec."First Name" + ' ' + rec."Second Name";
            end;
        }
        field(20; "Second Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Second Name" := UpperCase("Second Name");
                rec.Names := rec."First Name" + ' ' + rec."Second Name";
            end;
        }
        field(21; "Other Names"; Text[50])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Other Names" := UpperCase("Other Names");
                rec.Names := rec."First Name" + ' ' + rec."Second Name" + ' ' + rec."Other Names";
            end;
        }
        field(22; "Can Access Member Portal"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Account No", "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        GeneralSetup: Record "General Set-Up";
        SignatoryApplication: Record "Signatory Application";



    procedure ValidateShouldNotHaves(Number: Text; CharactersToCheck: Text): Boolean
    var
        i: Integer;

    begin
        FOR i := 1 TO STRLEN(Number) DO
            IF STRPOS(CharactersToCheck, Number[i]) > 0 THEN
                exit(false);

        exit(true);
    end;
}

