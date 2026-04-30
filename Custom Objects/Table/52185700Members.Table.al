table 52185700 Members
{
    DrillDownPageID = "Member List";
    LookupPageID = "Member List";

    fields
    {
        field(1; "No."; Code[50])
        {
            Caption = 'No.';
            SQLDataType = Varchar;

            trigger OnValidate()
            begin

                FieldNotEditable();
                if "No." <> xRec."No." then begin
                    SeriesSetup.Get;
                    if Rec."Account Type" = Rec."Account Type"::"Single Member Account" then
                        NoSeriesMgt.TestManual(SeriesSetup."Member Nos.") else
                        NoSeriesMgt.TestManual(SeriesSetup."Group Account Nos");
                    "No. Series" := '';
                end;

            end;
        }
        field(2; Salutation; Code[50])
        {
            TableRelation = "Salutation Tittles".Code WHERE(Type = CONST(Tittle));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Rec.Salutation = '' then Error(FieldEmptyError);

            end;

        }
        field(3; Name; Text[80])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin
                //FieldNotEditable();

                SavingAccounts.Reset;
                SavingAccounts.SetFilter(SavingAccounts."Member No.", '<>%1', '');
                SavingAccounts.SetRange(SavingAccounts."Member No.", "No.");
                if SavingAccounts.Find('-') then begin
                    repeat
                        SavingAccounts.Validate(SavingAccounts.Name, Name);
                        SavingAccounts.Modify;
                    until SavingAccounts.Next = 0;
                end;

                CreditAccounts.Reset;
                CreditAccounts.SetFilter(CreditAccounts."Member No.", '<>%1', '');
                CreditAccounts.SetRange(CreditAccounts."Member No.", "No.");
                if CreditAccounts.Find('-') then begin
                    repeat
                        CreditAccounts.Validate(CreditAccounts.Name, Name);
                        CreditAccounts.Modify;
                    until CreditAccounts.Next = 0;
                end;
                Loans.Reset;
                Loans.SetRange("Member No.", "No.");
                if Loans.Find('-') then begin
                    repeat
                        Loans."Member Name" := Name;
                        Loans.Modify;
                    until Loans.Next = 0;
                end;
            end;


        }

        field(4; "First Name"; Text[50])
        {

            trigger OnValidate()
            begin
                Characters := '1234567890!@#$%^&*()_~{}[];:"|\ ,./<>?-= ';

                if not ValidateShouldNotHaves("First Name", Characters) then Error('First Name has invalid characters');

                "First Name" := UpperCase("First Name");
                Name := "First Name" + ' ' + "Other Names" + ' ' + "Middle Name";

                SavingAccounts.Reset;
                SavingAccounts.SetFilter(SavingAccounts."Member No.", '<>%1', '');
                SavingAccounts.SetRange(SavingAccounts."Member No.", "No.");
                if SavingAccounts.Find('-') then begin
                    repeat
                        SavingAccounts.Validate(SavingAccounts.Name, Name);
                        SavingAccounts.Modify;
                    until SavingAccounts.Next = 0;
                end;

                CreditAccounts.Reset;
                CreditAccounts.SetFilter(CreditAccounts."Member No.", '<>%1', '');
                CreditAccounts.SetRange(CreditAccounts."Member No.", "No.");
                if CreditAccounts.Find('-') then begin
                    repeat
                        CreditAccounts.Validate(CreditAccounts.Name, Name);
                        CreditAccounts.Modify;
                    until CreditAccounts.Next = 0;
                end;

                if Rec."First Name" = '' then Error(FieldEmptyError);

                Name := "First Name" + ' ' + "Other Names" + ' ' + "Middle Name";
                ;

            end;
        }

        field(5; "Middle Name"; Text[50])
        {
            Caption = 'Last Name';
            Description = 'Maintain names separately';

            trigger OnValidate()
            begin
                Characters := '1234567890!@#$%^&*()_~{}[];:"|\ ,./<>?-= ';

                if not ValidateShouldNotHaves("Middle Name", Characters) then Error('Middle Name has invalid characters');
                "Middle Name" := UpperCase("Middle Name");
                Name := "First Name" + ' ' + "Other Names" + ' ' + "Middle Name";

                SavingAccounts.Reset;
                SavingAccounts.SetFilter(SavingAccounts."Member No.", '<>%1', '');
                SavingAccounts.SetRange(SavingAccounts."Member No.", "No.");
                if SavingAccounts.Find('-') then begin
                    repeat
                        SavingAccounts.Validate(SavingAccounts.Name, Name);
                        SavingAccounts.Modify;
                    until SavingAccounts.Next = 0;
                end;

                CreditAccounts.Reset;
                CreditAccounts.SetFilter(CreditAccounts."Member No.", '<>%1', '');
                CreditAccounts.SetRange(CreditAccounts."Member No.", "No.");
                if CreditAccounts.Find('-') then begin
                    repeat
                        CreditAccounts.Validate(CreditAccounts.Name, Name);
                        CreditAccounts.Modify;
                    until CreditAccounts.Next = 0;
                end;

                if Rec."Middle Name" = '' then Error(FieldEmptyError);

                Name := "First Name" + ' ' + "Other Names" + ' ' + "Middle Name";

            end;
        }
        field(6; "Other Names"; Text[50])
        {
            Description = 'Names separately';

            trigger OnValidate()
            begin
                Characters := '1234567890!@#$%^&*()_~{}[];:"|\,./<>?-=';

                if not ValidateShouldNotHaves("Other Names", Characters) then Error('Other Names has invalid characters');

                "Other Names" := UpperCase("Other Names");
                Name := "First Name" + ' ' + "Other Names" + ' ' + "Middle Name";

                SavingAccounts.Reset;
                SavingAccounts.SetFilter(SavingAccounts."Member No.", '<>%1', '');
                SavingAccounts.SetRange(SavingAccounts."Member No.", "No.");
                if SavingAccounts.Find('-') then begin
                    repeat
                        SavingAccounts.Validate(SavingAccounts.Name, Name);
                        SavingAccounts.Modify;
                    until SavingAccounts.Next = 0;
                end;

                CreditAccounts.Reset;
                CreditAccounts.SetFilter(CreditAccounts."Member No.", '<>%1', '');
                CreditAccounts.SetRange(CreditAccounts."Member No.", "No.");
                if CreditAccounts.Find('-') then begin
                    repeat
                        CreditAccounts.Validate(CreditAccounts.Name, Name);
                        CreditAccounts.Modify;
                    until CreditAccounts.Next = 0;
                end;

                // FieldNotEditable();
            end;
        }


        field(7; "Current Address"; Text[50])
        {
            Caption = 'Current Address';

            trigger OnValidate()
            begin
                SavingAccounts.Reset;
                SavingAccounts.SetFilter(SavingAccounts."Member No.", '<>%1', '');
                SavingAccounts.SetRange(SavingAccounts."Member No.", "No.");
                if SavingAccounts.Find('-') then begin
                    repeat
                        SavingAccounts.Validate(SavingAccounts."Current Address", "Current Address");
                        SavingAccounts.Modify;
                    until SavingAccounts.Next = 0;
                end;

                CreditAccounts.Reset;
                CreditAccounts.SetFilter(CreditAccounts."Member No.", '<>%1', '');
                CreditAccounts.SetRange(CreditAccounts."Member No.", "No.");
                if CreditAccounts.Find('-') then begin
                    repeat
                        CreditAccounts.Validate(CreditAccounts."Current Address", "Current Address");
                        CreditAccounts.Modify;
                    until CreditAccounts.Next = 0;
                end;
            end;
        }
        field(8; "Home Address"; Text[50])
        {
            Caption = 'Home Address';

            trigger OnValidate()
            begin
                SavingAccounts.Reset;
                SavingAccounts.SetFilter(SavingAccounts."Member No.", '<>%1', '');
                SavingAccounts.SetRange(SavingAccounts."Member No.", "No.");
                if SavingAccounts.Find('-') then begin
                    repeat
                        SavingAccounts.Validate(SavingAccounts."Home Address", "Home Address");
                        SavingAccounts.Modify;
                    until SavingAccounts.Next = 0;
                end;

                CreditAccounts.Reset;
                CreditAccounts.SetFilter(CreditAccounts."Member No.", '<>%1', '');
                CreditAccounts.SetRange(CreditAccounts."Member No.", "No.");
                if CreditAccounts.Find('-') then begin
                    repeat
                        CreditAccounts.Validate(CreditAccounts."Home Address", "Home Address");
                        CreditAccounts.Modify;
                    until CreditAccounts.Next = 0;
                end;
            end;
        }


        field(9; "Phone No."; Text[80])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            var
                Characters: Text;
                NewMob: Text;
            begin
                // CanEditSensitiveData();
                if "Phone No." = '' then Error(FieldEmptyError);
                SavingAccounts.Reset;
                SavingAccounts.SetFilter(SavingAccounts."Member No.", '<>%1', '');
                SavingAccounts.SetRange(SavingAccounts."Member No.", "No.");
                if SavingAccounts.Find('-') then begin
                    repeat
                        SavingAccounts.Validate(SavingAccounts."Phone No.", "Phone No.");
                        SavingAccounts.Modify;
                    until SavingAccounts.Next = 0;
                end;

                CreditAccounts.Reset;
                CreditAccounts.SetFilter(CreditAccounts."Member No.", '<>%1', '');
                CreditAccounts.SetRange(CreditAccounts."Member No.", "No.");
                if CreditAccounts.Find('-') then begin
                    repeat
                        CreditAccounts.Validate(CreditAccounts."Phone No.", "Phone No.");
                        CreditAccounts.Modify;
                    until CreditAccounts.Next = 0;
                end;

                Characters := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';

                if not MemberApplication.ValidateShouldNotHaves("Phone No.", Characters) then Error('Phone number has invalid characters');
                if Nationality <> '' then begin
                    CountryRegion.Get(Nationality);
                    NewMob := '';
                    NewMob := CopyStr("Phone No.", 1, 3);
                    if (CopyStr("Phone No.", 1, 4)) <> (CountryRegion."County Phone Code") then
                        Error('The Mobile phone No. should take the format of ' + CountryRegion."County Phone Code");
                    if StrLen("Phone No.") <> 12 then
                        Error('Phone No. should be equal to 12 characters');
                    if "Phone No." <> '' then begin
                        Cust.Reset;
                        Cust.SetFilter("No.", '<>%1', Rec."No.");
                        Cust.SetRange(Cust."Phone No.", "Phone No.");
                        if Cust.FindFirst then
                            Error(MemberExistError, Cust."No.", Cust.Name);
                    end;
                end;
            end;
        }
        field(10; "Office Telephone No."; Code[50])
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                // CanEditSensitiveData();
            end;
        }


        field(11; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                // CanEditSensitiveData();
                SavingAccounts.Reset;
                SavingAccounts.SetFilter(SavingAccounts."Member No.", '<>%1', '');
                SavingAccounts.SetRange(SavingAccounts."Member No.", "No.");
                if SavingAccounts.Find('-') then begin
                    repeat
                        SavingAccounts.Validate(SavingAccounts."Global Dimension 1 Code", "Global Dimension 1 Code");
                        SavingAccounts.Modify;
                    until SavingAccounts.Next = 0;
                end;

                CreditAccounts.Reset;
                CreditAccounts.SetFilter(CreditAccounts."Member No.", '<>%1', '');
                CreditAccounts.SetRange(CreditAccounts."Member No.", "No.");
                if CreditAccounts.Find('-') then begin
                    repeat
                        CreditAccounts.Validate(CreditAccounts."Global Dimension 1 Code", "Global Dimension 1 Code");
                        CreditAccounts.Modify;
                    until CreditAccounts.Next = 0;
                end;

                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(12; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                // CanEditSensitiveData();
                SavingAccounts.Reset;
                SavingAccounts.SetFilter(SavingAccounts."Member No.", '<>%1', '');
                SavingAccounts.SetRange(SavingAccounts."Member No.", "No.");
                if SavingAccounts.Find('-') then begin
                    repeat
                        SavingAccounts.Validate(SavingAccounts."Global Dimension 2 Code", "Global Dimension 2 Code");
                        SavingAccounts.Modify;
                    until SavingAccounts.Next = 0;
                end;

                CreditAccounts.Reset;
                CreditAccounts.SetFilter(CreditAccounts."Member No.", '<>%1', '');
                CreditAccounts.SetRange(CreditAccounts."Member No.", "No.");
                if CreditAccounts.Find('-') then begin
                    repeat
                        CreditAccounts.Validate(CreditAccounts."Global Dimension 2 Code", "Global Dimension 2 Code");
                        CreditAccounts.Modify;
                    until CreditAccounts.Next = 0;
                end;

                //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(13; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FieldNotEditable();
            end;
        }


        field(14; Nationality; Code[10])
        {
            Caption = 'Nationality';
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                // CanEditSensitiveData();
                if Nationality = '' then Error(FieldEmptyError);
            end;
        }
        field(15; Comment; Boolean)
        {
            CalcFormula = Exist("Comment Line" WHERE("No." = FIELD("No.")));
            Caption = 'Comment';
            Description = 'LookUp to Comment Line';
            Editable = false;
            FieldClass = FlowField;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FieldNotEditable();
            end;
        }
        field(16; Blocked; Option)
        {
            Caption = 'Blocked';
            OptionCaption = ' ,Credit,Debit,All';
            OptionMembers = " ",Credit,Debit,All;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                CanEditSensitiveData();
            end;

        }
        field(17; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FieldNotEditable();
            end;
        }
        field(18; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FieldNotEditable();
            end;
        }
        field(19; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FieldNotEditable();
            end;
        }
        field(20; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FieldNotEditable();
            end;
        }


        field(21; Picture; Text[1])
        {
            Caption = 'Picture';
            // SubType = Bitmap;
        }
        field(22; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = IF (Nationality = CONST('')) "Post Code"
            ELSE
            IF (Nationality = FILTER(<> '')) "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                SavingAccounts.Reset;
                SavingAccounts.SetFilter(SavingAccounts."Member No.", '<>%1', '');
                SavingAccounts.SetRange(SavingAccounts."Member No.", "No.");
                if SavingAccounts.Find('-') then begin
                    repeat
                        SavingAccounts.Validate(SavingAccounts."Post Code", "Post Code");
                        SavingAccounts.Modify;
                    until SavingAccounts.Next = 0;
                end;

                CreditAccounts.Reset;
                CreditAccounts.SetFilter(CreditAccounts."Member No.", '<>%1', '');
                CreditAccounts.SetRange(CreditAccounts."Member No.", "No.");
                if CreditAccounts.Find('-') then begin
                    repeat
                        CreditAccounts.Validate(CreditAccounts."Post Code", "Post Code");
                        CreditAccounts.Modify;
                    until CreditAccounts.Next = 0;
                end;

                PostCode.ValidatePostCode(City, "Post Code", County, Nationality, (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }

        field(23; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                SavingAccounts.Reset;
                SavingAccounts.SetFilter(SavingAccounts."Member No.", '<>%1', '');
                SavingAccounts.SetRange(SavingAccounts."Member No.", "No.");
                if SavingAccounts.Find('-') then begin
                    repeat
                        SavingAccounts.Validate(SavingAccounts."E-Mail", "E-Mail");
                        SavingAccounts.Modify;
                    until SavingAccounts.Next = 0;
                end;

                CreditAccounts.Reset;
                CreditAccounts.SetFilter(CreditAccounts."Member No.", '<>%1', '');
                CreditAccounts.SetRange(CreditAccounts."Member No.", "No.");
                if CreditAccounts.Find('-') then begin
                    repeat
                        CreditAccounts.Validate(CreditAccounts."E-Mail", "E-Mail");
                        CreditAccounts.Modify;
                    until CreditAccounts.Next = 0;
                end;

                MailManagement.CheckValidEmailAddresses("E-Mail");
                GlobalFunctions.CheckEmailHasADot("E-Mail");

                Cust.Reset;
                Cust.SetRange(Cust."E-Mail", "E-Mail");
                Cust.SetFilter("No.", '<>%1', Rec."No.");
                if Cust.FindFirst then
                    Error(MemberExistError, Cust."No.", Cust.Name);

                if "E-Mail" = '' then Error(FieldEmptyError);
            end;
        }

        field(24; "No. Series"; Code[50])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FieldNotEditable();
            end;
        }
        field(25; "Currency Filter"; Code[10])
        {
            Caption = 'Currency Filter';
            FieldClass = FlowFilter;
            TableRelation = Currency;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FieldNotEditable();
            end;
        }

        field(26; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Description = 'LookUp to Responsibility Center BR Table';
            TableRelation = "Responsibility CenterBR";

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                // CanEditSensitiveData();
                if "Responsibility Center" = '' then Error(FieldEmptyError);
            end;
        }


        field(27; "Registration Date"; Date)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //FieldNotEditable();
            end;
        }
        field(1004; "Registration Time"; Time)
        {
            trigger OnValidate()
            begin
                //FieldNotEditable();
            end;
        }
        field(28; Status; Enum "Member Status")
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                CanEditSensitiveData();
                // if xRec.Status = Status::Deceased then
                //     FieldNotEditable();
                if Status = Status::" " then Error(FieldEmptyError);

                if (Rec.Status = Rec.Status::Deceased) then begin
                    Rec."Closure Date" := Today;
                    Rec.Modify;
                end;
            end;
        }

        field(29; "Subflag"; Enum "Member Status Sub Flags")
        {
            Caption = 'Sub Status';

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                CanEditSensitiveData();
                if xRec.Subflag = Subflag::Deceased then
                    FieldNotEditable();

                if (Rec.Subflag = Rec.Subflag::Closed) then begin
                    Rec."Closure Date" := Today;
                    Rec.Modify;
                end;
            end;
        }

        field(30; "Self Employed"; Boolean)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                // CanEditSensitiveData();
                if Rec."Self Employed" then
                    Message('WARNING!\You will be requred to fill in all other employment details')
                else
                    Message('WARNING!\Changing the value of this field will render all other employment details invaluable');

            end;
        }
        field(31; "Employer Code"; Code[100])
        {
            Description = 'LookUp to Customer Table';
            TableRelation = Customer WHERE("Account Type" = CONST(Employer));

            trigger OnValidate()
            begin
                // CanEditSensitiveData();
                SavingAccounts.Reset;
                SavingAccounts.SetFilter(SavingAccounts."Member No.", '<>%1', '');
                SavingAccounts.SetRange(SavingAccounts."Member No.", "No.");
                if SavingAccounts.Find('-') then begin
                    repeat
                        SavingAccounts."Payroll/Staff No." := rec."Payroll/Staff No.";
                        SavingAccounts.Validate(SavingAccounts."Employer Code", "Employer Code");
                        SavingAccounts.Modify;
                    until SavingAccounts.Next = 0;
                end;

                CreditAccounts.Reset;
                CreditAccounts.SetFilter(CreditAccounts."Member No.", '<>%1', '');
                CreditAccounts.SetRange(CreditAccounts."Member No.", "No.");
                if CreditAccounts.Find('-') then begin
                    repeat
                        CreditAccounts."Payroll/Staff No." := Rec."Payroll/Staff No.";
                        CreditAccounts.Validate(CreditAccounts."Employer Code", "Employer Code");
                        CreditAccounts.Modify;
                    until CreditAccounts.Next = 0;
                end;

                CheckoffAdviceLine.Reset;
                CheckoffAdviceLine.SetRange("Member No.", "No.");
                if CheckoffAdviceLine.Find('-') then begin
                    repeat
                        CheckoffAdviceLine."Payroll No" := "Employer Code";
                        CheckoffAdviceLine.Validate("Employer Code", "Employer Code");
                        CheckoffAdviceLine.Modify;
                    until CheckoffAdviceLine.Next = 0;
                end;

                LoanApps.Reset;
                LoanApps.SetRange("Member No.", "No.");
                if LoanApps.Find('-') then begin
                    repeat
                        LoanApps."Staff No" := Rec."Employer Code";
                        LoanApps.Validate("Employer Code", "Employer Code");
                        LoanApps.Modify;
                    until LoanApps.Next = 0;
                end;

                if Customer.Get("Employer Code") then
                    "Employer Name" := Customer.Name
                else
                    "Employer Name" := '';
            end;
        }

        field(32; County; Text[30])
        {
            Caption = 'County';
            Description = 'LookUp to Member Segment Table where Type = County';
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST(County));

            trigger OnValidate()
            begin
                SavingAccounts.Reset;
                SavingAccounts.SetFilter(SavingAccounts."Member No.", '<>%1', '');
                SavingAccounts.SetRange(SavingAccounts."Member No.", "No.");
                if SavingAccounts.Find('-') then begin
                    SavingAccounts.Validate(SavingAccounts.County, County);
                    SavingAccounts.Modify;
                end;

                CreditAccounts.Reset;
                CreditAccounts.SetFilter(CreditAccounts."Member No.", '<>%1', '');
                CreditAccounts.SetRange(CreditAccounts."Member No.", "No.");
                if CreditAccounts.Find('-') then begin
                    repeat
                        CreditAccounts.Validate(CreditAccounts.County, County);
                        CreditAccounts.Modify;
                    until CreditAccounts.Next = 0;
                end;
            end;
        }

        field(33; "Terms of Employment"; Enum "Terms Of Employment")
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                // CanEditSensitiveData();
            end;
        }

        field(34; "Work Station"; Code[20])
        {
            TableRelation = "Electrol Zones/Area Svr Center".Code WHERE(Type = CONST("Area Service Centers"));
        }

        field(35; "Country Of Operation"; Code[10])
        {
            TableRelation = "Country/Region";
        }
        field(36; "Employer Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = FIELD("Employer Code")));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FieldNotEditable();
            end;
        }
        field(37; "Employment Designation"; Text[50])
        {
            TableRelation = "Electrol Zones/Area Svr Center".Code WHERE(Type = CONST("Work Station"));

        }
        field(38; City; Text[30])
        {
            Caption = 'City';

            trigger OnValidate()
            begin
                SavingAccounts.Reset;
                SavingAccounts.SetFilter(SavingAccounts."Member No.", '<>%1', '');
                SavingAccounts.SetRange(SavingAccounts."Member No.", "No.");
                if SavingAccounts.Find('-') then begin
                    repeat
                        SavingAccounts.Validate(SavingAccounts.City, City);
                        SavingAccounts.Modify;
                    until SavingAccounts.Next = 0;
                end;

                CreditAccounts.Reset;
                CreditAccounts.SetFilter(CreditAccounts."Member No.", '<>%1', '');
                CreditAccounts.SetRange(CreditAccounts."Member No.", "No.");
                if CreditAccounts.Find('-') then begin
                    repeat
                        CreditAccounts.Validate(CreditAccounts.City, City);
                        CreditAccounts.Modify;
                    until CreditAccounts.Next = 0;
                end;

                PostCode.ValidateCity(City, "Post Code", County, Nationality, (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(39; "Date of Birth"; Date)
        {

            trigger OnValidate()
            var
                DateofBirthError: Label 'This date cannot be greater than today.';
            begin
                // CanEditSensitiveData();
                if "Date of Birth" = 0D then Error(FieldEmptyError);
                if "Date of Birth" > Today then
                    Error(DateofBirthError);

                SavingAccounts.Reset;
                SavingAccounts.SetFilter(SavingAccounts."Member No.", '<>%1', '');
                SavingAccounts.SetRange(SavingAccounts."Member No.", "No.");
                if SavingAccounts.Find('-') then begin
                    repeat
                        SavingAccounts.Validate(SavingAccounts."Date of Birth", "Date of Birth");
                        SavingAccounts.Modify;
                    until SavingAccounts.Next = 0;
                end;

                CreditAccounts.Reset;
                CreditAccounts.SetFilter(CreditAccounts."Member No.", '<>%1', '');
                CreditAccounts.SetRange(CreditAccounts."Member No.", "No.");
                if CreditAccounts.Find('-') then begin
                    repeat
                        CreditAccounts.Validate(CreditAccounts."Date of Birth", "Date of Birth");
                        CreditAccounts.Modify;
                    until CreditAccounts.Next = 0;
                end;
            end;
        }

        field(40; "Payroll/Staff No."; Code[20])
        {

            trigger OnValidate()
            begin
                // CanEditSensitiveData();
                if "Payroll/Staff No." <> '' then begin
                    Cust.Reset;
                    Cust.SetRange(Cust."Employer Code", "Employer Code");
                    Cust.SetRange(Cust."Payroll/Staff No.", "Payroll/Staff No.");
                    Cust.SetFilter("No.", '<>%1', Rec."No.");
                    if Cust.FindFirst then
                        Error(MemberExistError, Cust."No.", Cust.Name);

                    rec.validate("Employer Code");
                end;

                Characters := '1234567890';
                if MemberApplication.ValidateShouldNotHaves("Payroll/Staff No.", Characters) then Error('Payroll/Staff No. number must have numbers');

                Characters := '!@#$%^&*{}[];:" ,<>?= ''';
                if not MemberApplication.ValidateShouldNotHaves("Payroll/Staff No.", Characters) then Error('Payroll/Staff No. number has invalid characters');
            end;
        }


        field(41; "Marital Status"; Enum "Marital Status")
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Marital Status" = "Marital Status"::" " then Error(FieldEmptyError);
            end;
        }

        field(42; Gender; Enum Gender)
        {

            trigger OnValidate()
            begin
                if Gender = Gender::" " then Error(FieldEmptyError);

            end;
        }


        field(43; "Account Category"; enum "Account Category")
        {
            Description = 'Member,"Staff Members","Board Members",Delegates';
        }

        field(44; "Group Account No."; Code[20])
        {
            Description = 'LookUp to Member.No. WHERE Group Account=Yes';

            trigger OnValidate()
            begin
                CanEditSensitiveData();
            end;
        }



        field(45; "Type of Application"; Enum "Type of Application")
        {

        }

        field(46; "Member Segment"; Code[20])
        {
            Description = 'LookUp to Member Segment Table where Type = Segment';
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST(Segment));
        }
        field(47; "Member Class"; Code[10])
        {
            TableRelation = "Member Classes"."No.";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                // CanEditSensitiveData();
                if "Member Class" = '' then Error(FieldEmptyError);
            end;
        }
        field(48; "Account Type"; Option)
        {
            OptionMembers = "Single Member Account","Group Account";
            OptionCaption = 'Single Member Account,MFI Account';

        }


        field(49; "Account Profile"; Option)
        {
            OptionMembers = "Normal Member","High Profile","Politically Exposed";

        }
        field(50; Religion; Code[50])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter(Religion));

        }

        field(51; "Created By"; Code[100])
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Created By" = '' then Error(FieldEmptyError);
            end;
        }
        field(5100; "Approved By"; Code[100])
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Approved By" = '' then Error(FieldEmptyError);
            end;
        }



        field(52; "Bank Code"; Code[20])
        {
            Description = 'LookUp to Banks Code Structure Table';
            TableRelation = "Bank Code Structure";
        }
        field(53; "Branch Code"; Code[20])
        {
            Caption = 'Bank Branch Code';
            Description = 'LookUp to Banks Code Structure Table';
            TableRelation = "Bank Code Structure".Code where(Type = const(Branch), "Parent Code" = field("Bank Code"));

        }
        field(54; "Bank Account No."; Code[20])
        {
        }
        field(55; "P.I.N Number"; Code[20])
        {
            trigger OnValidate()
            begin
                // CanEditSensitiveData();
                if "P.I.N Number" = '' then Error(FieldEmptyError);

                if "P.I.N Number" <> '' then begin
                    Cust.Reset;
                    Cust.SetRange(Cust."P.I.N Number", "P.I.N Number");
                    Cust.SetFilter("No.", '<>%1', Rec."No.");
                    if Cust.FindFirst then
                        Error(MemberExistError, Cust."No.", Cust.Name);
                end;

                if "Account Type" = Rec."Account Type"::"Single Member Account" then begin
                    if StrPos("P.I.N Number", 'A') <> 1 then
                        Error('First letter must be an A');
                end;

                if StrLen("P.I.N Number") <> 11 then Error('P.I.N Number length must be 11 characters');

                Characters := '1234567890!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';
                if not MemberApplication.ValidateShouldNotHaves(CopyStr("P.I.N Number", 11, 1), Characters) then Error('Last character must be a letter');

                Characters := '1234567890';
                if MemberApplication.ValidateShouldNotHaves(CopyStr("P.I.N Number", 2, 8), Characters) then Error('Pin number must be alphanumeric');
            end;
        }

        field(56; "Application No."; Code[20])
        {
            TableRelation = "Member Application"."No.";
            Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FieldNotEditable();
            end;
        }


        field(57; "Rejoinig Date"; Date)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //FieldNotEditable();
            end;
        }
        field(1005; "Rejoining Time"; Time)
        {
            trigger OnValidate()
            begin
                //FieldNotEditable();
            end;
        }

        field(58; "Primary Identification Type"; Enum "Identification Type")
        {
            trigger OnValidate()
            var
                PrimaryOrSecondaryID: Option Primary,Secondary;
            begin
                // CanEditSensitiveData();
                if "Primary Identification Type" = "Primary Identification Type"::" " then
                    Error(FieldEmptyError);

                if "Secondary Identification Type" = "Primary Identification Type" then Error('Primary and secondary identificatin types cannot be the same');

                if "Primary Identification" <> '' then
                    ValidateIdentificationTypes("Primary Identification Type", "Primary Identification", PrimaryOrSecondaryID::Primary);


            end;
        }
        field(59; "Secondary Identification Type"; Enum "Identification Type")
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Secondary Identification Type" = "Primary Identification Type" then Error('Primary and secondary identificatin types cannot be the same');
            end;
        }
        field(70; "Primary Identification"; Code[20])
        {
            NotBlank = true;
            trigger OnValidate()
            var
                PrimaryOrSecondaryID: Option Primary,Secondary;
            begin
                // CanEditSensitiveData();
                if "Primary Identification" = '' then Error(FieldEmptyError);


                if "Primary Identification" <> '' then
                    ValidateIdentificationTypes("Primary Identification Type", "Primary Identification", PrimaryOrSecondaryID::Primary);

            end;
        }

        field(71; "Secondary Identification"; Code[20])
        {
            trigger OnValidate()
            var
                PrimaryOrSecondaryID: Option Primary,Secondary;
            begin
                // CanEditSensitiveData();


                if "Secondary Identification" <> '' then
                    ValidateIdentificationTypes("Secondary Identification Type", "Secondary Identification", PrimaryOrSecondaryID::Secondary);

            end;
        }
        field(72; "From Another Sacco"; Boolean)
        {

        }

        field(74; "Status Change Statistics"; Integer)
        {
            // CalcFormula = Count("Reactivate/Deactivate Header" WHERE("Account Type" = CONST(Member),
            //                                                           "Account No." = FIELD("No."),
            //                                                           Status = CONST(Processed)));
            // Editable = false;
            // FieldClass = FlowField;
        }

        field(75; "Last Transaction Date"; Date)
        {
            CalcFormula = Max("Savings Ledger Entry"."Posting Date" WHERE("Member No." = FIELD("No.")));
            FieldClass = FlowField;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FieldNotEditable();
            end;
        }
        field(76; "Old Member No."; Code[20])
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                CanEditSensitiveData();
            end;
        }
        field(77; "Principle Member"; Code[20])
        {
            TableRelation = Members WHERE(Status = FILTER(Active | Dormant));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                CanEditSensitiveData();
            end;
        }
        field(78; Hide; Boolean)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FieldNotEditable();
            end;
        }

        field(79; "Document No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FieldNotEditable();
            end;
        }

        field(80; "Recruited By"; Code[10])
        {
            Caption = 'Salesperson Code/Recruited By';

            TableRelation = IF ("Recruited by Type" = FILTER(Staff)) "HR Employees"."No."
            ELSE
            IF ("Recruited by Type" = CONST(Others)) Members."No." WHERE(Status = FILTER(<> Deceased & <> Closed), "Account Type" = filter("Single Member Account"))
            ELSE
            IF ("Recruited by Type" = CONST(spouse)) Members."No." WHERE(Status = FILTER(<> Deceased & <> Closed), "Account Type" = filter("Single Member Account"))
            else
            IF ("Recruited by Type" = CONST(parent)) Members."No." WHERE(Status = FILTER(<> Deceased & <> Closed), "Account Type" = filter("Single Member Account"))
            else
            IF ("Recruited by Type" = CONST(Delegates)) "Delegate Officials"."Member Number"
            else
            IF ("Recruited by Type" = CONST("Board Member")) "Delegate Officials"."Member Number"
            else
            IF ("Recruited by Type" = CONST("Sales Representative")) "HR Employees"."No." where("Staff Category" = const("Sales Representatives"));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                CanEditSensitiveData();
                if "Recruited By" = '' then Error(FieldEmptyError);
            end;
        }
        field(81; "Recruited By Name"; Text[100])
        {
            Editable = false;
        }

        field(82; "Recruited by Type"; Enum "Recruited By")
        {

            trigger OnValidate()
            begin
                CanEditSensitiveData();
                if "Recruited by Type" = "Recruited by Type"::"None" then Error(FieldEmptyError);
                SavingAccounts.Reset;
                SavingAccounts.SetFilter(SavingAccounts."Member No.", '<>%1', '');
                SavingAccounts.SetRange(SavingAccounts."Member No.", "No.");
                if SavingAccounts.Find('-') then begin
                    repeat
                        SavingAccounts.Validate(SavingAccounts."Recruited by Type", "Recruited by Type");
                        SavingAccounts.Modify;
                    until SavingAccounts.Next = 0;
                end;

                CreditAccounts.Reset;
                CreditAccounts.SetFilter(CreditAccounts."Member No.", '<>%1', '');
                CreditAccounts.SetRange(CreditAccounts."Member No.", "No.");
                if CreditAccounts.Find('-') then begin
                    repeat
                        CreditAccounts.Validate(CreditAccounts."Recruited by Type", "Recruited by Type");
                        CreditAccounts.Modify;
                    until CreditAccounts.Next = 0;
                end;
            end;
        }


        field(83; "Has Joined Business Loans"; Boolean)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FieldNotEditable();
            end;
        }

        field(88; "Contribution Start Date"; Date)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                CanEditSensitiveData();
                if "Contribution Start Date" < Today then Error('Contribution start date cannot be earlier than today');

            end;
        }
        field(89; "Transactional Mobile Number"; Text[20])

        {
            trigger OnValidate()
            var
                Characters: Text;
                MemApp: Record "Member Application";
                NewMob: Text;
            begin
                CanEditSensitiveData();
                FieldNotEditable();

                Characters := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';
                if not MemApp.ValidateShouldNotHaves("Transactional Mobile Number", Characters) then Error('Phone number has invalid characters');
                if Rec.Nationality <> '' then
                    CountryRegion.Get(Rec.Nationality);
                NewMob := '';
                NewMob := CopyStr("Transactional Mobile Number", 1, 4);
                if (CopyStr("Transactional Mobile Number", 1, 4)) <> (CountryRegion."County Phone Code") then
                    Error('The Mobile phone No. should take the format of ' + CountryRegion."County Phone Code");
                if StrLen("Transactional Mobile Number") <> 13 then
                    Error('Phone No. should be equal to 13 characters');
                if "Transactional Mobile Number" <> '' then begin
                    Cust.Reset;
                    Cust.SetRange(Cust."Transactional Mobile Number", "Transactional Mobile Number");
                    //Cust.SetFilter(Cust.Status, '<>%1', Cust.Status::Closed);
                    if Cust.FindFirst then
                        Error(MemberExistError, Cust."No.", Cust.Name);
                end;
            end;
        }
        field(90; "Sub-County"; Text[30])
        {
            Caption = 'Sub County';
            Description = 'LookUp to Member Segment Table where Type = County';
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST("Sub-County"));
        }
        field(91; Age; Integer)
        {
            Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FieldNotEditable();
            end;
        }
        field(92; "Office E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                if Rec."Office E-Mail" <> '' then begin

                    MailManagement.CheckValidEmailAddresses("Office E-Mail");
                end;

            end;
        }
        field(93; "TSC Number"; Code[20])
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                // CanEditSensitiveData();
                if "Payroll/Staff No." <> '' then begin
                    Cust.Reset;
                    Cust.SetRange(Cust."Employer Code", Rec."Employer Code");
                    Cust.SetRange(Cust."Payroll/Staff No.", Rec."Payroll/Staff No.");
                    Cust.SetFilter("No.", '<>%1', Rec."No.");
                    if Cust.FindFirst then
                        Error(MemberExistError, Cust."No.", Cust.Name);
                end;

                Characters := '1234567890';
                if MemberApplication.ValidateShouldNotHaves("Payroll/Staff No.", Characters) then Error('Payroll/Staff No. number must have numbers');

                Characters := '!@#$%^&*{}[];:" ,<>?= ''';
                if not MemberApplication.ValidateShouldNotHaves("Payroll/Staff No.", Characters) then Error('Payroll/Staff No. number has invalid characters');
            end;
        }
        field(39004243; "Delegates Zone"; Code[20])
        {
            TableRelation = "Electoral Zones";

            trigger OnValidate()
            var
                ElectoralZones: Record "Electoral Zones";
            begin
                if ElectoralZones.Get("Delegates Zone") then
                    "Electrol Zone Descr." := ElectoralZones."Electoral Zone Name";
            end;
        }

        field(84; "Electrol Zone Descr."; Text[100])
        {
            Editable = false;
        }
        field(85; "ID Card"; Text[10])
        {
        }
        field(86; "ID Card Back"; Text[10])
        {
        }

        field(87; "CRM Application No."; code[20])
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FieldNotEditable();
            end;
        }
        field(94; "Source Aplication"; Option)
        {
            OptionMembers = "N/A",CRM,"Kenpipe Smart","CRM - Sales";
        }
        field(95; "Marked For Edits"; Boolean)
        {
            Editable = false;
        }


        //GROUP ACCOUNTS
        field(500; "Company Registration No."; Code[30])
        {

        }
        field(501; "Allocated Officer"; Code[50])
        {
            TableRelation = "HR Employees"."No." where(Status = const(Active));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FieldNotEditable();
            end;
        }
        field(502; "Allocated Officer Name"; Text[100])
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FieldNotEditable();
            end;
        }
        field(505; "Request for ATM"; Boolean)
        {

        }
        field(506; "Request Mobile Banking"; Boolean)
        {

        }
        field(507; "Request Mwalimu Smart"; Boolean)
        {

        }
        field(508; "Witness ID No."; code[10])
        {
            trigger OnValidate()
            var
                Characters: Text;
            begin
                if StrLen("Witness ID No.") > 9 then Error('ID Number cannot have more than 9 characters');
                if StrLen("Witness ID No.") < 5 then Error('ID Number cannot have less than 7 characters');
                Characters := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';
                // if not ValidateShouldNotHaves("Witness ID No.", Characters) then Error('ID Number has invalid characters');
            end;
        }
        field(509; "Witness Name"; Text[50])
        {

            trigger OnValidate()
            var
                Characters: Text;
            begin
                Characters := '1234567890!@#$%^&*()_~{}[];:"|\,./<>?-=';
                // if not ValidateShouldNotHaves("Witness Name", Characters) then Error('Witness Name has invalid characters');
                "Witness Name" := UPPERCASE("Witness Name");
                "Witness Name" := UpperCase("Witness Name");
            end;
        }

        field(511; "2nd Witness ID No."; code[10])
        {
            trigger OnValidate()
            var
                Characters: Text;
            begin
                if StrLen("2nd Witness ID No.") > 9 then Error('ID Number cannot have more than 9 characters');
                if StrLen("2nd Witness ID No.") < 5 then Error('ID Number cannot have less than 7 characters');
                Characters := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';
                // if not ValidateShouldNotHaves("Witness ID No.", Characters) then Error('ID Number has invalid characters');
            end;
        }
        field(510; "2nd Witness Name"; Text[50])
        {

            trigger OnValidate()
            var
                Characters: Text;
            begin
                Characters := '1234567890!@#$%^&*()_~{}[];:"|\,./<>?-=';
                // if not ValidateShouldNotHaves("Witness Name", Characters) then Error('Witness Name has invalid characters');
                "2nd Witness Name" := UPPERCASE("2nd Witness Name");
                "2nd Witness Name" := UpperCase("2nd Witness Name");
            end;
        }
        field(604; "Contribution Effective Date"; Date)
        {
            // trigger OnValidate()
            // begin

            //     if "Contribution Effective Date" < Today then;
            //     ERROR('Past dates are not allowed.');
            //     end; 
        }
        field(644; "Permanent Post Code"; Code[20])
        {
            Caption = 'Permanent Post Code';
            TableRelation = "Post Code";
            ValidateTableRelation = false;
            trigger OnValidate()
            begin
                PostCode.ValidatePostCode("Permanent City", "Post Code", County, Nationality, (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(645; "Permanent City"; Text[30])
        {
            Caption = 'Permanent City';
            Editable = false;
            trigger OnValidate()
            begin
                PostCode.ValidateCity("Permanent City", "Permanent Post Code", County, Nationality, (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }

        field(646; "Any Physical Disability"; Boolean)
        {
            CalcFormula = Exist("Certificate Management" WHERE("Record ID" = FIELD("No."), "Document Type" = CONST("Tax Exemption")));
            Caption = 'Any Physical Disability';
            Description = 'LookUp';
            Editable = false;
            FieldClass = FlowField;
        }
        field(605; "Branch Name"; Code[100])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where("Code" = field("Global Dimension 1 Code")));
        }
        field(606; "Activity Name"; Code[100])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where("Code" = field("Global Dimension 2 Code")));
        }

        field(607; "Contribution Mode"; Option)
        {
            OptionMembers = Salary,"Check off","Direct Debit",Cash,Pension,Dividend,Others;
            OptionCaption = 'Salary,"Check off","Direct Debit",Cash,Pension,Dividend,Others';
        }
        field(608; "Date Approved"; Date)
        {

        }
        field(1000; "Passport Expiry Date"; Date)
        {
        }

        field(1001; "M-S Verified By"; Code[100])
        {
            Editable = false;
        }
        field(1002; "M-S Verified At"; DateTime)
        {
            Editable = false;
        }
        field(1003; "Rejection Reason"; Text[1000])
        {

        }
        field(1006; TAT; Duration)
        {

        }
        field(1007; "Society Position"; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Delegate Officials".Position where("Member Number" = field("No."), Retired = const(false)));
            Editable = false;
        }
        field(1008; "Member Class Graduation"; Option)
        {
            OptionMembers = " ","Nominee Graduant","Child Hope Graduant";
            Editable = false;
            Description = 'This field will help us know from which class did the member graduate to';
        }
        field(1009; "Graduation Date"; DateTime)
        {
            Editable = false;
        }
        field(1010; "Member Class Account Type"; Option)
        {
            OptionMembers = " ","Child Hope",Nominee;
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Member Class Account Type" where("No." = field("Employer Code")));
            Description = 'This field will help us run the process that will be upgrading the nominees and child hope by filtering';
        }
        field(1011; "Manually Uploaded"; Boolean)
        {
            Editable = false;
        }
        field(1012; "Manual Upload Batch No."; Code[100])
        {
            Editable = false;
        }
        field(1013; "Card Printing Times."; Integer)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Member Card Printing Log" where("Record ID" = field("No.")));
        }

        field(1014; "Total Savings"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = - Sum("Savings Ledger Entry".Amount WHERE("Member No." = FIELD("No."), "Posting Date" = FIELD("Date Filter")));

        }


        field(1015; "Loan Balances"; Decimal)
        {

            FieldClass = FlowField;
            CalcFormula = Sum("Credit Ledger Entry".Amount WHERE("Member No." = FIELD("No."),
            "Posting Date" = FIELD("Date Filter")));
        }

        field(1016; "CRM Lead Ref. No"; Text[50])
        {
            Editable = False;
        }
        field(1017; "IPRS Verified"; Boolean)
        {
            Editable = False;
        }
        field(1018; "Subflag Backup"; Enum "Member Status Sub Flags")
        {
            //I created this field to store subflags for members who have defaulted. This back up will help me restore the previous members status before attachment on reversal

            trigger OnValidate()
            begin
                FieldNotEditable();
            end;
        }

        //BUSINESS LOAN MEMBERS
        field(1019; "BL Global Dimension 1 Code"; Code[20])
        {
            // CaptionClass = '1,1,1';
            Caption = 'Business Loan Branch Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,Blocked);
            end;
        }
        field(1020; "BL Global Dimension 2 Code"; Code[20])
        {
            // CaptionClass = '1,1,2';
            Caption = 'Business Loan Activity Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Last Date Modified");
            end;
        }
        field(1021; "BL Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility CenterBR";
            Editable = false;
        }
        field(1022; "BL Created By"; Code[50])
        {
            Editable = false;
        }

        field(1023; "BL Registration Date"; Date)
        {
            Editable = false;
        }
        field(1024; "BL Type of Business"; Enum "Business Type")
        {

        }
        field(1025; "BL Business Location"; Code[50])
        {

        }

        field(1026; "BL Relationship Manager"; Code[10])
        {
            //TableRelation = "HR Employees" WHERE(Status = FILTER(Active),"Global Dimension 2 Code" = field("Global Dimension 2 Code"));
            TableRelation = "HR Employees" WHERE(Status = FILTER(Active));
        }

        field(1027; "BL Wholesale/Retail"; Option)
        {
            OptionMembers = " ",Wholesale,Retail;
        }
        field(1028; "BL Current Capital"; Decimal)
        {

        }
        field(1029; "BL No. of Employees"; Integer)
        {

        }
        field(1030; "BL Annual Turnover"; Decimal)
        {

        }
        field(1031; "Sub Class"; Code[50])
        {
            TableRelation = "Sub Classes"."Sub Class" where("Main Class" = field("Member Class"));
        }
        field(1032; "Is SACCO Account"; Boolean)
        {
        }
        field(1033; "Application Date"; Date)
        {
        }
        field(1034; "Closure Date"; Date)
        {
        }
        field(1035; "FOSA Account"; Code[50])
        {
            TableRelation = "Savings Accounts"."No." where("Member No." = field("No."), "Product Category" = filter("FOSA Account"));
        }
        field(1036; "FOSA Account Status"; Option)
        {
            OptionCaption = ' ,New,Active,Dormant,Frozen,Withdrawal Application,Withdrawn,Deceased,Defaulter,Closed';
            OptionMembers = " ",New,Active,Dormant,Frozen,"Withdrawal Application",Withdrawn,Deceased,Defaulter,Closed;
            TableRelation = "Savings Accounts".Status where("No." = field("FOSA Account"));
        }

        // IPRS
        field(1037; "IPRS ID Type"; Code[50])
        {
            Editable = False;
        }
        field(1038; "IPRS ID"; Text[50])
        {
            Editable = False;
        }
        field(1039; "IPRS Full Names"; Text[150])
        {
            Editable = False;
        }
        field(1040; "IPRS ID Serial No"; Text[100])
        {
            Editable = False;
        }
        field(1041; "IPRS Verified At"; DateTime)
        {
            Editable = False;
        }
        field(1042; Retired; Boolean)
        {
            Editable = false;
        }

        field(1043; "FOSA Savings"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = - sum("Savings Ledger Entry".Amount where("Member No." = field("No."), "Product Category" = filter("FOSA Account"), "Posting Date" = FIELD("Date Filter")));
        }

        field(1044; "BOSA Deposit"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = - sum("Savings Ledger Entry".Amount where("Member No." = field("No."), "Product Category" = const("BOSA Deposits"), "Posting Date" = FIELD("Date Filter")));
        }

        field(1045; "Share Capital"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = - sum("Savings Ledger Entry".Amount where("Member No." = field("No."), "Product Category" = const("Share Capital"), "Posting Date" = FIELD("Date Filter")));
        }

        field(1046; "Allow Retiree M-Loans"; Boolean)
        {
            Editable = false;
        }
        field(1047; "Group Savings Balance"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = - sum("Savings Ledger Entry".Amount where("Member No." = field("No."), "Product Category" = const("Chama Investment Account"), "Posting Date" = FIELD("Date Filter")));
        }
        field(1048; "Block Div Advance"; Boolean)
        {
            Caption = 'Block From Dividend Advance Loan';
        }
        field(1049; "Blocked By"; Code[30]) { }

        field(1050; "Div Advance %"; Decimal)
        {
            MinValue = 0.0;
            MaxValue = 100.0;
            trigger Onvalidate()
            var
                ChangePermission: Record "Status Change Permissions.";
                ErrorOnRestricViewTxt: Label 'You do not have Permissions to Edit Dividend Advance limit. Kindly contact system administrator for assistance.';
            begin
                ChangePermission.Reset;
                ChangePermission.SetRange("User ID", UserId);
                ChangePermission.SetRange("Edit Div Advance", true);
                if not ChangePermission.Find('-') then
                    Error(ErrorOnRestricViewTxt, UserId);

                // if "Div Advance %" <> 0 then begin
                "Div Advance % Modified By" := UserID;
                "Div Advance % Modified At" := CURRENTDATETIME;
                rec.Modify;
                // end
            end;
        }
        field(1051; "Div Advance % Modified By"; Code[100])
        {
            Caption = 'Dividend Advance % Modified By';
            Editable = false;
        }
        field(1052; "Div Advance % Modified At"; DateTime)
        {
            Caption = 'Dividend Advance % Modified At';
            Editable = false;
        }
        field(1053; "Has NOK"; Boolean)
        {
            Caption = 'Has Next Of Kin';
            FieldClass = flowfield;
            CalcFormula = exist("Next of KIN" where("Record ID" = field("No."), Deceased = const(false)));
        }
        field(1054; "Old Account Name"; text[100])
        {
            Caption = 'Old Account Name';
            Editable = false;
        }
        field(1055; "Captured By"; Code[100])
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Captured By" = '' then Error(FieldEmptyError);
            end;
        }
        field(1056; "Recruitment Location"; Code[100])
        {
            Caption = 'Recruitment Location';
            Editable = true;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        // Secondary keys for non-primary fields
        key(IdxTransactionalMobileNumber; "Transactional Mobile Number")
        {
            Clustered = false;
        }

        key(IdxPhoneNo; "Phone No.")
        {
            Clustered = false;
        }

        key(IdxPrimaryIdentificationType; "Primary Identification Type")
        {
            Clustered = false;
        }

        key(IdxPrimaryIdentification; "Primary Identification")
        {
            Clustered = false;
        }

        key(IdxPrimaryID; "Primary Identification Type", "Primary Identification")
        {
            Clustered = false;
        }
        key(IdxSecIdentificationType; "Secondary Identification Type")
        {
            Clustered = false;
        }

        key(IdxSecondaryIdentification; "Secondary Identification")
        {
            Clustered = false;
        }

        key(IdxSecondaryID; "Secondary Identification Type", "Secondary Identification")
        {
            Clustered = false;
        }

        key(IdxPayrollStaffNo; "Payroll/Staff No.")
        {
            Clustered = false;
        }

        key(IdxSubflag; "Subflag")
        {
            Clustered = false;
        }
        key(IdxEmail; "E-Mail")
        {
            Clustered = false;
        }
        key(IdxPIN; "P.I.N Number")
        {
            Clustered = false;
        }
        key(IdxEmployerCode; "Employer Code")
        {
            Clustered = false;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "No." = '' then begin
            SeriesSetup.Get;
            if Rec."Account Type" = Rec."Account Type"::"Single Member Account" then begin
                SeriesSetup.TestField(SeriesSetup."Member Nos.");
                "No." := NoSeriesMgt.GetNextNo(SeriesSetup."Member Nos.", 0D, false);
                // NoSeriesMgt.InitSeries(SeriesSetup."Member Nos.", xRec."No. Series", 0D, "No.", "No. Series");
            end else begin
                SeriesSetup.TestField(SeriesSetup."Group Account Nos");
                "No." := NoSeriesMgt.GetNextNo(SeriesSetup."Member Nos.", 0D, false);
                // NoSeriesMgt.InitSeries(SeriesSetup."Group Account Nos", xRec."No. Series", 0D, "No.", "No. Series");
            end;
        end;

        "Created By" := UserId;
        "Last Date Modified" := Today;

        // if "CRM Application No." <> '' then begin
        //     CRMIntegration.CRMMemberEditUpdate(Rec);
        // end;

    end;

    trigger OnModify()
    var
        thisMember: Record Members;
    begin

        "Last Date Modified" := Today;

        // thisMember.Reset;

        // thisMember.SetFilter("No.", "No.");

        // if thisMember.FindFirst then begin
        //     if ("CRM Application No." <> '') OR (thisMember.Status <> Status) OR (thisMember.Subflag <> Subflag) then begin
        //         // CRMIntegration.CRMMemberEditUpdate(Rec);
        //     end;
        // end;
        if xrec."Employer Code" <> Rec."Employer Code" then
            rec.Validate("Employer Code");


    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
    end;

    var
        SeriesSetup: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit "No. Series";
        SavingAccounts: Record "Savings Accounts";
        CreditAccounts: Record "Credit Accounts";
        CountryRegion: Record "Country/Region";
        LoanApps: Record Loans;
        Cust: Record Members;
        MemberExistError: Label 'Already exists with member %1 Name: %2';
        PostCode: Record "Post Code";
        CheckoffAdviceLine: Record "Checkoff Advice Line";
        Customer: Record Customer;
        Loans: Record Loans;
        CRMIntegration: CodeUnit "CRM Integration";
        MemberApplication: Record "Member Application";
        Characters: Text;
        GlobalFunctions: Codeunit "Global Functions";

        FieldEmptyError: Label 'This field can''t be empty';

    // [Scope('OnPrem')]
    procedure TestNoEntriesExist(CurrentFieldName: Text[100]; GLNO: Code[20])
    var
        MemberLedgEntry: Record "Cust. Ledger Entry";
    // Text000: ;
    begin
        //To prevent change of field
        MemberLedgEntry.SetCurrentKey(MemberLedgEntry."Customer No.");
        MemberLedgEntry.SetRange(MemberLedgEntry."Customer No.", "No.");
        // if MemberLedgEntry.Find('-') then
        //     Error(Text000,
        //           CurrentFieldName);
    end;

    // [Scope('OnPrem')]
    procedure FieldLength(VarVariant: Text; FldLength: Integer): Text
    var
        FieldLengthError: Label 'Field cannot be more than %1 Characters.';
    begin
        if StrLen(VarVariant) > FldLength then
            Error(FieldLengthError, FldLength);
    end;

    // [Scope('OnPrem')]
    procedure SendRecords()
    var
        DocumentSendingProfile: Record "Document Sending Profile";
        TempDocumentSendingProfile: Record "Document Sending Profile" temporary;
        ReportDistributionManagement: Codeunit "Report Distribution Management";
    begin
        DocumentSendingProfile.GetDefaultForCustomer("No.", DocumentSendingProfile);
        Commit;

        TempDocumentSendingProfile.Init;
        TempDocumentSendingProfile.Code := DocumentSendingProfile.Code;
        TempDocumentSendingProfile.Validate("One Related Party Selected", IsSingleCustomerSelected);
        TempDocumentSendingProfile.SetDocumentUsage(Rec);
        TempDocumentSendingProfile.Insert;

        if PAGE.RunModal(PAGE::"Select Sending Options", TempDocumentSendingProfile) = ACTION::LookupOK then begin
            CheckDocumentSendingProfileIsSupported(TempDocumentSendingProfile);
            // ReportDistributionManagement.SendDocumentReport(TempDocumentSendingProfile, Rec);
        end;
    end;

    // [Scope('OnPrem')]
    procedure PrintRecords(ShowRequestForm: Boolean)
    var
        TempDocumentSendingProfile: Record "Document Sending Profile" temporary;
        ReportDistributionManagement: Codeunit "Report Distribution Management";
    begin
        TempDocumentSendingProfile.Init;

        if ShowRequestForm then
            TempDocumentSendingProfile.Printer := TempDocumentSendingProfile.Printer::"Yes (Prompt for Settings)"
        else
            TempDocumentSendingProfile.Printer := TempDocumentSendingProfile.Printer::"Yes (Use Default Settings)";

        TempDocumentSendingProfile.Insert;

        // ReportDistributionManagement.dSendDocumentReport(TempDocumentSendingProfile, Rec);
    end;

    // [Scope('OnPrem')]
    procedure EmailRecords(ShowRequestForm: Boolean)
    var
        TempDocumentSendingProfile: Record "Document Sending Profile" temporary;
        ReportDistributionManagement: Codeunit "Report Distribution Management";
    begin
        TempDocumentSendingProfile.Init;

        if ShowRequestForm then
            TempDocumentSendingProfile."E-Mail" := TempDocumentSendingProfile."E-Mail"::"Yes (Prompt for Settings)"
        else
            TempDocumentSendingProfile."E-Mail" := TempDocumentSendingProfile."E-Mail"::"Yes (Use Default Settings)";

        TempDocumentSendingProfile."E-Mail Attachment" := TempDocumentSendingProfile."E-Mail Attachment"::PDF;

        TempDocumentSendingProfile.Insert;

        // ReportDistributionManagement.SendDocumentReport(TempDocumentSendingProfile, Rec);
    end;

    local procedure IsSingleCustomerSelected(): Boolean
    var
        SelectedCount: Integer;
        CustomerCount: Integer;
        BillToCustomerNoFilter: Text;
    begin
        SelectedCount := Count;

        if SelectedCount < 1 then
            exit(false);

        if SelectedCount = 1 then
            exit(true);

        BillToCustomerNoFilter := GetFilter("No.");
        SetRange("No.", "No.");
        CustomerCount := Count;
        SetFilter("No.", BillToCustomerNoFilter);

        exit(SelectedCount = CustomerCount);
    end;

    local procedure CheckDocumentSendingProfileIsSupported(var TempDocumentSendingProfile: Record "Document Sending Profile" temporary)
    var
        CannotSendMultipleStatementsElectronicallyErr: Label 'You can only send one electronic statements at a time.';
    begin
        if (Count > 1) and
           (TempDocumentSendingProfile."Electronic Document" <> TempDocumentSendingProfile."Electronic Document"::No)
        then
            Error(CannotSendMultipleStatementsElectronicallyErr);
    end;


    procedure CanEditSensitiveData()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        UserSetup.SetRange("Member Change Permission", true);
        if not UserSetup.FindFirst() then
            Error('This is member sensitive data and your''e not allowed to change it. Please contact your system administrator');
    end;

    procedure FieldNotEditable()
    begin
        Error('The value in this field cannot be edited');
    end;


    procedure ValidateIdentificationTypes(IdentificationType: enum "Identification Type"; Identification: Code[30]; PrimaryOrSecondaryID: Option Primary,Secondary): Code[30]
    var
        Members: Record Members;
        Characters: Text;
    begin

        if IdentificationType = IdentificationType::"ID Number" then begin
            if StrLen(Identification) > 9 then Error('ID Number cannot have more than 9 characters');
            if StrLen(Identification) < 5 then Error('ID Number cannot have less than 7 characters');
            Characters := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';
            if not MemberApplication.ValidateShouldNotHaves(Identification, Characters) then Error('ID Number has invalid characters');
        end;
        if IdentificationType = IdentificationType::"Passport No" then begin
            if StrLen(Identification) > 12 then Error('Passport Number cannot have more thna 12 characters');
            if StrLen(Identification) < 7 then Error('Passport Number cannot have less than 7 characters');
            Characters := '!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';
            if not MemberApplication.ValidateShouldNotHaves(Identification, Characters) then Error('Passport Number has invalid characters');
        end;
        if IdentificationType = IdentificationType::"Birth Certificate Number" then begin
            if StrLen(Identification) < 7 then Error('Birth Certificate Number cannot have less than 7 characters');
            Characters := '!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';
            if not MemberApplication.ValidateShouldNotHaves(Identification, Characters) then Error('Birth Certificate Number has invalid characters');
        end;
        if IdentificationType = IdentificationType::"Service Number" then begin
            if StrLen(Identification) < 7 then Error('Service Number cannot have less than 7 characters');
            if StrLen(Identification) > 10 then Error('Service Number cannot have more thna 10 characters');
            Characters := '!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';
            if not MemberApplication.ValidateShouldNotHaves(Identification, Characters) then Error('Service Number has invalid characters');
        end;


        Members.Reset();
        Members.SetFilter("No.", '<>%1', "No.");
        if Members.FindSet() then begin
            repeat
                if IdentificationType = Members."Primary Identification Type" then
                    if (Identification = Members."Primary Identification") then
                        Error('Same Identification in another membership: %1', Members."No.");
                if IdentificationType = Members."Secondary Identification Type" then
                    if (Identification = Members."Secondary Identification") then
                        Error('Same Identification in another membership: %1', Members."No.");
            until Members.Next() = 0;
        end;


    end;

    procedure ValidateShouldNotHaves(Number: Text; CharactersToCheck: Text): Boolean
    var
        i: Integer;
        users: Page "User Settings List";
    begin
        FOR i := 1 TO STRLEN(Number) DO
            IF STRPOS(CharactersToCheck, Number[i]) > 0 THEN
                exit(false);

        exit(true);
    end;

}
