table 52185691 "Member Application"

{
    DrillDownPageId = "Open Member Application List";
    LookupPageId = "Open Member Application List";
    Caption = 'Member Application';
    DataCaptionFields = "No.", Name;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeriesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."Member Application Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin
                if "Account Type" = Rec."Account Type"::"Group Account" then begin

                    AutoOpenSavingAccs.Reset();
                    AutoOpenSavingAccs.SetRange("No.", Rec."No.");
                    if AutoOpenSavingAccs.FindSet() then AutoOpenSavingAccs.DeleteAll();

                    ProductFactory.Reset();
                    ProductFactory.SetRange(ProductFactory.Status, ProductFactory.Status::Active);
                    ProductFactory.SetRange("Product Class Type", ProductFactory."Product Class Type"::Savings);
                    ProductFactory.SetRange("Auto Open Group Account", true);
                    if ProductFactory.Find('-') then begin
                        repeat
                            AutoOpenSavingAccs.Init;
                            AutoOpenSavingAccs."No." := "No.";
                            AutoOpenSavingAccs."Product Type" := ProductFactory."Product ID";
                            //AutoOpenSavingAccs.Validate(AutoOpenSavingAccs."Product Type", ProductFactory."Product ID");
                            AutoOpenSavingAccs."Monthly Contribution" := ProductFactory."Minimum Contribution";
                            AutoOpenSavingAccs."Product Name" := ProductFactory."Product Description";
                            AutoOpenSavingAccs.Insert;

                        // AutoOpenSavingAccs.Reset;
                        // AutoOpenSavingAccs.SetRange("No.", MemberApplication."No.");
                        // AutoOpenSavingAccs.SetRange("Product Type", ProductFactory."Product ID");
                        // if AutoOpenSavingAccs.Find('-') then begin
                        //     //if AutoOpenSavingAccs."Monthly Contribution" = 0 then
                        //     AutoOpenSavingAccs."Product Name" := ProductFactory."Product Description";
                        //     AutoOpenSavingAccs."Monthly Contribution" := ProductFactory."Minimum Contribution";
                        //     AutoOpenSavingAccs.Modify;
                        //end;
                        until ProductFactory.Next = 0;
                    end;
                end;
            end;
        }
        field(3; "First Name"; Text[50])
        {

            trigger OnValidate()
            var
                Characters: Text;
            begin
                Characters := '1234567890!@#$%^&*()_~{}[];:"|\ ,./<>?-= ';

                if not ValidateShouldNotHaves("First Name", Characters) then Error('First Name has invalid characters');

                "First Name" := UPPERCASE("First Name");


                "First Name" := UpperCase("First Name");
                if StrLen("First Name") < 2 then error('Invalid name');
                Name := "First Name" + ' ' + "Middle Name" + ' ' + "Other Names";
                Name := Name.Trim();


                if "Account Type" = Rec."Account Type"::"Single Member Account" then begin

                    AutoOpenSavingAccs.Reset();
                    AutoOpenSavingAccs.SetRange("No.", Rec."No.");
                    if AutoOpenSavingAccs.FindSet() then
                        AutoOpenSavingAccs.DeleteAll();

                    ProductFactory.Reset();
                    ProductFactory.SetRange(ProductFactory.Status, ProductFactory.Status::Active);
                    ProductFactory.SetRange("Product Class Type", ProductFactory."Product Class Type"::Savings);
                    ProductFactory.SetRange("Auto Open Account", true);
                    if ProductFactory.Find('-') then begin
                        repeat
                            AutoOpenSavingAccs.Init;
                            AutoOpenSavingAccs."No." := "No.";
                            AutoOpenSavingAccs."Product Type" := ProductFactory."Product ID";
                            //AutoOpenSavingAccs.Validate(AutoOpenSavingAccs."Product Type", ProductFactory."Product ID");
                            AutoOpenSavingAccs."Monthly Contribution" := ProductFactory."Minimum Contribution";
                            AutoOpenSavingAccs."Product Name" := ProductFactory."Product Description";
                            AutoOpenSavingAccs.Insert;
                        until ProductFactory.Next = 0;
                    end;
                end;


            end;
        }
        field(4; "Middle Name"; Text[30])
        {
            Caption = 'Last Name';

            trigger OnValidate()
            var
                Characters: Text;
            begin
                Characters := '1234567890!@#$%^&*()_~{}[];:"|\ ,./<>?-= ';

                if not ValidateShouldNotHaves("Middle Name", Characters) then Error('Last Name has invalid characters');
                "Middle Name" := UPPERCASE("Middle Name");

                "Middle Name" := UpperCase("Middle Name");
                if "Middle Name" <> '' then begin
                    if StrLen("Middle Name") < 2 then error('Invalid name');
                end;
                Name := "First Name" + ' ' + "Middle Name" + ' ' + "Other Names";
                Name := Name.Trim();
            end;
        }
        field(5; "Other Names"; Text[30])
        {

            trigger OnValidate()
            var
                Characters: Text;
            begin
                Characters := '1234567890!@#$%^&*()_~{}[];:"|\,./<>?-=';

                if not ValidateShouldNotHaves("Other Names", Characters) then Error('Other Names has invalid characters');
                "Other Names" := UPPERCASE("Other Names");

                "Other Names" := UpperCase("Other Names");
                // if StrLen("Other Names") < 2 then error('Invalid name');
                Name := "First Name" + ' ' + "Middle Name" + ' ' + "Other Names";
                Name := Name.Trim();
            end;
        }

        field(6; "Current Address"; Text[50])
        {
            Caption = 'Address';
        }
        field(7; "Home Address"; Text[50])
        {
            Caption = 'Permanent Address';
        }
        field(8; "Phone No."; Text[20])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            var
                Characters: Text;
            begin
                //Characters := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''+';

                //if not ValidateShouldNotHaves("Phone No.", Characters) then Error('Phone number has invalid characters');
                TestField(Nationality);
                CountryRegion.Get(Nationality);
                NewMob := '';
                NewMob := CopyStr("Phone No.", 1, 3);
                // if (CopyStr("Phone No.", 1, 3)) <> (CountryRegion."County Phone Code") then
                //    Error('The Mobile phone No. should take the format of ' + CountryRegion."County Phone Code");
                //if StrLen("Phone No.") <> 13 then
                // if StrLen("Phone No.") < 12 then
                //     Error('Phone No. should be equal to 12 characters');
                if "Phone No." <> '' then begin
                    Cust.Reset;
                    Cust.SetRange(Cust."Phone No.", "Phone No.");
                    //Cust.SetFilter(Cust.Status, '<>%1', Cust.Status::Closed);
                    if Cust.FindFirst then
                        IF "Type of Application" <> "Type of Application"::Readmission then
                            // Error(MemberExistError, Cust."No.", Cust.Name);
                            Error('Phone number %1 is already linked to an existing member!', "Phone No.");
                end;
                // "Transactional Mobile Number" := "Phone No.";
            end;
        }
        field(9; "Office Telephone No."; Code[50])
        {
        }
        field(10; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            trigger OnValidate()
            var
                DimVal: Record "Dimension Value";
            begin
                DimVal.reset;
                DimVal.SetRange(Code, "Global Dimension 1 Code");
                if DimVal.find('-') then
                    "Branch Name" := DimVal.Name;
            end;
        }
        field(11; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            trigger OnValidate()
            var
                DimVal: Record "Dimension Value";
            begin
                DimVal.reset;
                DimVal.SetRange(Code, "Global Dimension 2 Code");
                if DimVal.find('-') then
                    "Activity Name" := DimVal.Name;
            end;
        }
        field(12; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }


        field(13; "Application Date"; Date)
        {

            trigger OnValidate()
            begin
                if "Application Date" > Today then
                    Error(DateofBirthError);
            end;
        }
        field(1006; "Application Time"; Time)
        {
            Editable = False;

            trigger OnValidate()
            begin
                "Application Time" := Time;
            end;

        }
        field(10900; "Testing Date"; DateTime)
        {
            trigger OnValidate()
            begin
                "Testing Date" := CurrentDateTime;
            end;
        }
        field(10071; "Approval Time"; Time)
        {

        }
        field(14; Status; Enum "Workflow Status Main Flags")
        {
            Editable = True;

            trigger OnValidate()
            var
                myInt: Integer;
                RegistrationMngt: Codeunit "Registration Process";
            begin
                if (xRec.Status = Status::Deffered) and (Rec.Status = Status::Approved) then Error('This record cannot be approved. Please reopen it first');

                if (Rec.Status = Status::Rejected) or (Rec.Status = Status::Deffered) then
                    GlobalFunctions.CommentsManagement(Rec."No.");

                if (xRec.Status = Status::Pending) and (Rec.Status = Status::Approved) then
                    Rec."Date Approved" := Today;
                Rec."Approval Time" := Time;
            end;
        }
        field(16; "E-Mail"; Text[50])
        {

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";

            begin
                if "E-Mail" <> '' then begin
                    "E-Mail" := LowerCase("E-Mail");
                    MailManagement.CheckValidEmailAddresses("E-Mail");
                    // GlobalFunctions.ValidateEmailAddress("E-Mail");
                    GlobalFunctions.CheckEmailHasADot("E-Mail");
                    MemberApplication.Reset;
                    MemberApplication.SetRange(MemberApplication."E-Mail", "E-Mail");
                    MemberApplication.SetFilter(MemberApplication."No.", '<>%1', "No.");
                    if MemberApplication.Find('-') then begin
                        repeat
                            if (MemberApplication.Status in [MemberApplication.Status::Open, MemberApplication.Status::Pending,
                                                             MemberApplication.Status::Approved]) then
                                IF "Type of Application" <> "Type of Application"::Readmission then
                                    // Error(MemberExistError, MemberApplication."No.", MemberApplication.Name);
                                    Error('The given email address %1 already exists!', "E-Mail");
                        until MemberApplication.Next = 0;
                    end;


                    Cust.Reset;
                    Cust.SetRange(Cust."E-Mail", "E-Mail");
                    if Cust.FindFirst then
                        IF "Type of Application" <> "Type of Application"::Readmission then
                            // Error(MemberExistError, Cust."No.", Cust.Name);
                            Error('The given email address %1 already exists!', "E-Mail");
                end;
            end;
        }

        field(17; Nationality; Code[20])
        {
            TableRelation = "Country/Region";
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                CountryRegion: Record "Country/Region";
            begin
                if CountryRegion.Get(Nationality) then begin
                    if CopyStr("Phone No.", 1, 3) <> CopyStr(CountryRegion."County Phone Code", 1, 4) then begin
                        if StrLen("Phone No.") < 12 then
                            "Phone No." := CopyStr((CountryRegion."County Phone Code" + "Phone No."), 1, 12);
                    end;

                    "Phone No." := CountryRegion."County Phone Code";
                    "Transactional Mobile Number" := CountryRegion."County Phone Code";

                end;
            end;
        }
        field(18; Religion; Code[50])
        {
            TableRelation = "HR Lookup Values".Code where(Type = filter(Religion));
        }

        field(19; "Primary Identification Type"; Enum "Identification Type")
        {
            ValuesAllowed = "ID Number", "Passport No", "Service Number", "Birth Certificate Number", "Huduma/Maisha Number";
            trigger OnValidate()
            var
                myInt: Integer;
                MemberClasses: Record "Member Classes";
            begin
                if "Primary Identification Type" = "Primary Identification Type"::"Birth Certificate Number" then
                    if (Today - "Date of Birth") / 365 > 18 then Error('Primary identification cannot be Birth Certicate Age %1', round((Today - "Date of Birth") / 365));

                if ("Primary Identification Type" = "Primary Identification Type"::"Service Number") then
                    if (Today - "Date of Birth") / 365 < 18 then Error('Primary identification cannot be Service Number Age %1', round((Today - "Date of Birth") / 365));

                if ("Primary Identification Type" = "Primary Identification Type"::"ID Number") then
                    if (Today - "Date of Birth") / 365 < 18 then Error('Primary identification cannot be ID Number Age %1', round((Today - "Date of Birth") / 365));

                if MemberClasses.Get("Member Class") then begin
                    if Format(Rec."Member Class") = Format(MemberClasses."Member Class"::B) then
                        if "Primary Identification Type" <> "Primary Identification Type"::"Birth Certificate Number" then
                            Error('Primary identification type must be Birth Certificate Number');
                end;
                "Primary Identification" := '';
                if "Secondary Identification Type" <> Rec."Secondary Identification Type"::" " then
                    if "Primary Identification Type" = "Secondary Identification Type" then begin
                        if Confirm('Primary and secondary identification types cannot be the same\Should we clear the secondary identifications') then begin
                            "Secondary Identification Type" := Rec."Secondary Identification Type"::" ";
                            "Secondary Identification" := '';
                        end else begin
                            "Primary Identification Type" := xRec."Primary Identification Type";
                            "Primary Identification" := xRec."Primary Identification";
                        end;
                    end;
            end;
        }
        field(20; "Secondary Identification Type"; Enum "Identification Type")
        {
        }
        field(21; "Primary Identification"; Code[20])
        {

            trigger OnValidate()
            begin
                "Primary Identification" := ValidateIdentificationTypes("Primary Identification Type", "Primary Identification", PrimaryOrSecondaryID::Primary);

            end;
        }

        field(22; "Secondary Identification"; Code[10])
        {

            trigger OnValidate()
            begin
                "Secondary Identification" := ValidateIdentificationTypes("Secondary Identification Type", "Secondary Identification", PrimaryOrSecondaryID::Secondary);
            end;
        }

        field(23; "Marital Status"; Enum "Marital Status")
        {
        }

        field(24; Gender; Enum Gender)
        {
        }
        field(25; "No. Series"; Code[10])
        {
        }


        field(26; "Post Code"; Code[20])
        {
            Caption = 'Current Post Code';
            TableRelation = "Post Code";
            ValidateTableRelation = false;
            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, Nationality, (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }

        field(27; "Responsibility Center"; Code[20])
        {
            Description = 'LookUp to Responsibility Center BR';
            TableRelation = "Responsibility CenterBR";
        }

        field(28; "Bank Code"; Code[20])
        {
            Description = 'LookUp to Banks Table';
            TableRelation = "Bank Code Structure".Code where(Type = const("Main Bank"));

            trigger OnValidate()
            var
                BankStructure: Record "Bank Code Structure";
            begin
                if BankStructure.Get("Bank Code") then begin
                    "Bank Name" := BankStructure.Name;
                end;
            end;
        }
        field(68; "Bank Name"; Text[100])
        {
            Editable = false;
        }

        field(29; "Branch Code"; Code[20])
        {
            Description = 'LookUp to Banks Table';
            TableRelation = "Bank Code Structure".Code where(Type = const(Branch), "Parent Code" = field("Bank Code"));

            trigger OnValidate()
            var
                BankStructure: Record "Bank Code Structure";
            begin
                if BankStructure.Get("Branch Code") then begin
                    "Bank Branch Name" := BankStructure.Name;
                end;
            end;
        }
        field(69; "Bank Branch Name"; Text[100])
        {
            Editable = false;
        }
        field(30; "Recruited by Type"; Enum "Recruited By")
        {
        }
        field(31; "Recruited By"; Code[50])
        {
            Caption = 'Salesperson Code';

            TableRelation = IF ("Recruited by Type" = FILTER(Staff)) "HR Employees"
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
            IF ("Recruited by Type" = CONST("Sales Representative")) "HR Employees" where("Staff Category" = const("Sales Representatives"));
            trigger OnValidate()
            var
                Members: Record Members;
            begin
                if "Recruited by Type" <> "Recruited by Type"::Staff then begin
                    if Members.Get("Recruited By") then
                        "Recruited By Name" := Members.Name;
                end else begin
                    HREmployees.Reset;
                    HREmployees.SetRange("Member No.", "Recruited By");
                    if HREmployees.Find('-') then begin
                        "Recruited By Name" := HREmployees."First Name" + ' ' + HREmployees."Last Name"
                    end;
                end;
            end;
        }
        field(32; "Recruited By Name"; Text[100])
        {
            Editable = false;
        }

        field(33; "Member Segment"; Code[20])
        {
            Description = 'LookUp to Member Segment Table where Type = Segment';
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST(Segment));
        }



        field(34; "P.I.N Number"; Code[20])
        {
            Caption = 'KRA Pin No.';
            trigger OnValidate()
            var
                Characters: Text;
            begin
                // FieldLength("ID No.", 15);

                if "P.I.N Number" <> '' then begin
                    MemberApplication.Reset;
                    MemberApplication.SetRange(MemberApplication."P.I.N Number", "P.I.N Number");
                    MemberApplication.SetFilter(MemberApplication.Status, '%1', MemberApplication.Status::Open);
                    MemberApplication.SetFilter(MemberApplication."No.", '<>%1', "No.");
                    if MemberApplication.Find('-') then begin
                        repeat
                            if (MemberApplication.Status in [MemberApplication.Status::Open, MemberApplication.Status::Pending,
                                                             MemberApplication.Status::Approved]) then
                                IF "Type of Application" <> "Type of Application"::Readmission then
                                    Error('KRA PIN number has already been used in member application %1', MemberApplication."No.");
                        until MemberApplication.Next = 0;
                    end;

                    Cust.Reset;
                    Cust.SetRange(Cust."P.I.N Number", "P.I.N Number");
                    if Cust.FindFirst then
                        IF "Type of Application" <> "Type of Application"::Readmission then
                            // Error(MemberExistError, Cust."No.", Cust.Name);
                            Error('The given K.R.A pin %1 already exists!', "P.I.N Number");

                    if "Account Type" = Rec."Account Type"::"Single Member Account" then begin
                        if StrPos("P.I.N Number", 'A') <> 1 then
                            Error('KRA Pin: First letter must be an A');
                    end;

                    if StrLen("P.I.N Number") <> 11 then Error('KRA Pin Number length must be 11 characters');

                    Characters := '1234567890!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';
                    if not ValidateShouldNotHaves(CopyStr("P.I.N Number", 11, 1), Characters) then Error('KRA Pin: Last character must be a letter');

                    Characters := '1234567890';
                    if ValidateShouldNotHaves(CopyStr("P.I.N Number", 2, 8), Characters) then Error('KRA Pin number must be alphanumeric');

                    if not GlobalFunctions.ValidateKRAPIN("P.I.N Number") then begin
                        Error('Invalid KRA Pin format. Sample Expected format is: A123456789X');
                    end;
                end;
            end;
        }

        field(35; "At CCC"; Boolean)
        {

        }

        field(36; "Group Account No."; Code[20])
        {
            Description = 'LookUp to Member where Group Account = Yes';
            TableRelation = Members WHERE("Account Type" = FILTER(<> "Single Member Account"));
        }
        field(37; "Created By"; Code[100])
        {
        }

        field(38; "Self Employed"; Boolean)
        {
            trigger OnValidate()
            begin
                if "Self Employed" THEN
                    // TestField("Type of Business");

                if "Self Employed" THEN Message('Please Capture Type of Business.');

            end;

        }

        field(39; "Employer Code"; Code[20])
        {
            // TableRelation = Customer WHERE("Account Type" = CONST("Employer Code"));
            TableRelation = Customer WHERE("Account Type" = CONST(Employer));
            trigger OnValidate()
            begin
                CalcFields("Employer Name")
            end;
        }

        field(40; "Employer Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Employer Code")));
        }

        field(41; "Payroll/Staff No."; Code[20])
        {

            trigger OnValidate()
            var
                Characters: Text;
            begin
                if "Payroll/Staff No." <> '' then begin

                    MemberApplication.Reset;
                    MemberApplication.SetFilter("Employer Code", "Employer Code");
                    MemberApplication.SetFilter("Payroll/Staff No.", "Payroll/Staff No.");
                    MemberApplication.SetFilter(MemberApplication."No.", '<>%1', "No.");
                    if MemberApplication.FindFirst then
                        if (MemberApplication.Status in [MemberApplication.Status::Open, MemberApplication.Status::Pending, MemberApplication.Status::Approved]) then
                            // Error(MemberExistError, MemberApplication."No.", MemberApplication.Name);
                            Error('The given payroll/staff number %1 already exists!', "Payroll/Staff No.");


                    Cust.Reset;
                    Cust.SetRange(Cust."Employer Code", "Employer Code");
                    Cust.SetRange(Cust."Payroll/Staff No.", "Payroll/Staff No.");
                    if Cust.FindFirst then
                        IF "Type of Application" <> "Type of Application"::Readmission then
                            // Error(MemberExistError, Cust."No.", Cust.Name);
                            Error('The given payroll/staff number %1 already exists!', "Payroll/Staff No.");

                    Characters := '1234567890';
                    if ValidateShouldNotHaves("Payroll/Staff No.", Characters) then Error('Payroll/Staff No. number must have numbers');

                    Characters := '!@#$%^&*{}[];:" ,<>?= ''';
                    if not ValidateShouldNotHaves("Payroll/Staff No.", Characters) then Error('Payroll/Staff No. number has invalid characters');
                end;
            end;
        }
        field(42; "Terms of Employment"; Enum "Terms Of Employment")
        {

        }

        field(43; "Country Of Operation"; Code[10])
        {
            TableRelation = "Country/Region";
        }

        field(430; "Country Of Operation Name"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Country/Region".Name where(Code = field("Country Of Operation")));
        }

        field(44; County; Text[30])
        {
            Caption = 'County';
            Description = 'LookUp to Member Segment Table where Type = County';
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST(County));
        }

        field(440; "County Name"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Segment/County/Dividend/Signat".Description where(Code = field(County)));
        }

        field(45; City; Text[30])
        {
            Caption = 'City';
            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, Nationality, (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(645; "Permanent City"; Text[30])
        {
            Caption = 'Permanent City';
            trigger OnValidate()
            begin
                PostCode.ValidateCity("Permanent City", "Permanent Post Code", County, Nationality, (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }

        field(46; "Work Station"; Code[20])
        {
            TableRelation = "Electrol Zones/Area Svr Center".Code WHERE(Type = CONST("Work Station"),"Employer Code" = field("Employer Code"));
        }

        field(47; "Employment Designation"; Text[50])
        {
            TableRelation = "Electrol Zones/Area Svr Center".Code WHERE(Type = CONST(Designation));

        }


        field(48; "Member Class"; Code[10])
        {

            TableRelation = "Member Classes"."No.";

            trigger OnValidate()
            begin
                "Sub Class" := '';
                MemberClasess.Reset;
                MemberClasess.SetRange("No.", "Member Class");
                if MemberClasess.Find('-') then begin
                    MemberClasess.TestField("Default BOSA Deposit");
                    MemberClasess.TestField("Default Share Capital");
                    MemberClasess.TestField("Entrance Fee");
                    AutoOpenSavingAccs.Reset;
                    AutoOpenSavingAccs.SetRange("No.", "No.");
                    if AutoOpenSavingAccs.Find('-') then begin
                        repeat
                            if AutoOpenSavingAccs."Product Category" = AutoOpenSavingAccs."Product Category"::"BOSA Deposits" then
                                AutoOpenSavingAccs."Monthly Contribution" := MemberClasess."Default BOSA Deposit"
                            else
                                if AutoOpenSavingAccs."Product Category" = AutoOpenSavingAccs."Product Category"::"Share Capital" then
                                    AutoOpenSavingAccs."Monthly Contribution" := MemberClasess."Default Share Capital"
                                else
                                    if AutoOpenSavingAccs."Product Category" = AutoOpenSavingAccs."product category"::"Entrance Fee" then
                                        AutoOpenSavingAccs."Monthly Contribution" := MemberClasess."Entrance Fee";
                            AutoOpenSavingAccs.Modify;
                        until AutoOpenSavingAccs.Next = 0;
                    end;
                end;
            end;
        }

        field(49; "Date of Birth"; Date)
        {

            trigger OnValidate()
            var
                DateofBirthError: Label 'This date cannot be greater than today.';
                MemberClass: Record "Member Classes";
                MemberAge: Integer;
                MinAge: Integer;
            begin
                MemberAge := Round(((Today - "Date of Birth") / 365), 1, '<');

                TestField("Member Class");
                if MemberClass.Get("Member Class") then begin
                    MinAge := MemberClass."Minimum Age";
                    if MemberAge < MinAge then Error('Applicant''s age is %1. Minimum age required is %2 years', MemberAge, MinAge);
                end;
                Age := MemberAge;
            end;
        }
        field(51; "Type of Application"; Enum "Type of Application")
        {
            Description = 'New, Readmission or Nominee';
            trigger OnValidate()
            var
                RegistrationProcess: Codeunit "Registration Process";
            begin


            end;
        }

        field(50; "Principle Member"; Code[20])
        {
            TableRelation = if ("Type of Application" = const(Readmission)) Members."No." WHERE(Status = FILTER(Closed | Dormant | Withdrawn), Subflag = filter(Withdrawal | Closed)) else
            if ("Type of Application" = const(Nominee)) Members."No.";
            trigger OnValidate()
            var
                RegistrationProcess: Codeunit "Registration Process";
            begin

            end;
        }


        field(52; "Old Member No."; Code[20])
        {
        }

        field(53; "Account Type"; Option)
        {
            OptionMembers = "Single Member Account","Group Account";
            trigger OnValidate()
            begin

            end;
        }
        field(54; "From Another Sacco"; Boolean)
        {

        }

        field(55; "Bank Account No."; Code[20])
        {

            trigger OnValidate()
            begin
                if StrLen("Bank Account No.") > 14 then
                    Error(BankAccountErr);
            end;
        }


        field(56; "Delegates Zone"; Code[100])
        {
            TableRelation = "Electrol Zones/Area Svr Center".Code WHERE(Type = CONST("Electral Zone"));

            trigger OnValidate()
            begin
                ElectrolZonesAreaSvrCenter.Reset;
                ElectrolZonesAreaSvrCenter.SetRange(ElectrolZonesAreaSvrCenter.Code, "Delegates Zone");
                if ElectrolZonesAreaSvrCenter.Find('-') then begin
                    "Electrol Zone Descr." := ElectrolZonesAreaSvrCenter.Description;
                end;
            end;
        }

        field(57; "Electrol Zone Descr."; Text[100])
        {
            Editable = false;
        }

        field(58; "CRM Application No."; Code[50])
        {

        }
        field(158; "CRM No. Series"; Code[10])
        {

        }

        field(59; Salutation; Code[50])
        {
            TableRelation = "Salutation Tittles".Code WHERE(Type = CONST(Tittle));
        }


        field(60; "ID Card Front"; BLOB)
        {
            Description = 'Identification document front.';
            SubType = Bitmap;
        }
        field(61; "ID Card Back"; BLOB)
        {
            Description = 'Identification document back.';
            SubType = Bitmap;
        }

        field(62; Picture; Blob)
        {
            Caption = 'Picture';
            Description = 'Used to capture applicant Photos and should be deleted on account creation.';
            SubType = Bitmap;
        }
        field(63; Signature; Blob)
        {
            Caption = 'Signature';
            Description = 'Used to capture applicant Signature and should be deleted on account creation.';
            SubType = Bitmap;
        }


        field(64; "Responsible Officer"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."User ID" where("Record ID" = field("No.")));
        }
        field(65; "Supervisor ID"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."Supervisor ID" where("Record ID" = field("No.")));
        }
        field(66; "Account Profile"; Option)
        {
            OptionMembers = "Normal Member","High Profile","Politically Exposed";
        }
        field(67; Created; Boolean)
        {

        }
        field(70; "Contribution Start Date"; Date)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Contribution Start Date" < Today then Error('Contribution start date cannot be earlier than today');
            end;
        }
        field(701; "Contribution Amount"; Decimal)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Contribution Amount" < 0 then begin
                    Error('Contribution amount MUST be a positive value')
                end;
            end;
        }
        field(71; "Transactional Mobile Number"; Text[20])
        {
            trigger OnValidate()
            var
                // Characters: Text;
                MemberApplication: Record "Member Application";
            begin
                // Characters := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';

                // if not ValidateShouldNotHaves("Transactional Mobile Number", Characters) then Error('Phone number has invalid characters');
                // TestField(Nationality);
                // CountryRegion.Get(Nationality);
                // NewMob := '';
                // NewMob := CopyStr("Transactional Mobile Number", 1, 4);
                // if (CopyStr("Transactional Mobile Number", 1, 4)) <> (CountryRegion."County Phone Code") then
                //     Error('The Mobile phone No. should take the format of ' + CountryRegion."County Phone Code");
                // if StrLen("Transactional Mobile Number") <> 13 then
                //     Error('Phone No. should be equal to 13 characters');
                if "Transactional Mobile Number" <> '' then begin
                    Cust.Reset;
                    Cust.SetRange(Cust."Transactional Mobile Number", "Transactional Mobile Number");
                    //Cust.SetFilter(Cust.Status, '<>%1', Cust.Status::Closed);
                    if Cust.FindFirst then
                        IF "Type of Application" <> "Type of Application"::Readmission then
                            // Error(MemberExistError, Cust."No.", Cust.Name);
                            Error('The given transactional mobile number %1 already exists!', "Transactional Mobile Number");

                    Cust.Reset;
                    Cust.SetRange(Cust."Transactional Mobile Number", "Phone No.");
                    //Cust.SetFilter(Cust.Status, '<>%1', Cust.Status::Closed);
                    if Cust.FindFirst then
                        IF "Type of Application" <> "Type of Application"::Readmission then
                            // Error(MemberExistError, Cust."No.", Cust.Name);
                            Error('The given transactional mobile number %1 already exists!', "Transactional Mobile Number");

                    MemberApplication.Reset;
                    MemberApplication.SetRange(MemberApplication."Transactional Mobile Number", "Transactional Mobile Number");
                    MemberApplication.SetFilter(MemberApplication."No.", '<>%1', "No.");
                    if MemberApplication.FindFirst then begin
                        Error('The transactional mobile number provided is already in use on member application = %1', MemberApplication."No.");
                    end;

                    // MemberApplication.Reset;
                    // MemberApplication.SetRange(MemberApplication."Transactional Mobile Number", "Phone No.");
                    // MemberApplication.SetFilter(MemberApplication."No.", '<>%1', "No.");
                    // if MemberApplication.FindFirst then begin
                    //     Error('The transactional mobile number provided is already in use on member application = %1', MemberApplication."No.");
                    // end;
                end;
            end;
        }

        field(72; "Sub-County"; Text[30])
        {
            Caption = 'Sub-County';
            Description = 'LookUp to Member Segment Table where Type = County';
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST("Sub-County"));
        }
        field(73; Age; Integer)
        {
            Editable = false;
        }
        field(74; "Office E-Mail"; Text[50])
        {

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";

            begin
                if "Office E-Mail" <> '' then begin
                    "Office E-Mail" := LowerCase("Office E-Mail");
                    // LowerCase("Office E-Mail");
                    MailManagement.CheckValidEmailAddresses("Office E-Mail");
                    GlobalFunctions.CheckEmailHasADot("Office E-Mail");
                    MemberApplication.Reset;
                    MemberApplication.SetRange(MemberApplication."E-Mail", "Office E-Mail");
                    MemberApplication.SetFilter(MemberApplication."No.", '<>%1', "No.");
                    if MemberApplication.Find('-') then begin
                        repeat
                            if (MemberApplication.Status in [MemberApplication.Status::Open, MemberApplication.Status::Pending,
                                                             MemberApplication.Status::Approved]) then
                                IF "Type of Application" <> "Type of Application"::Readmission then
                                    // Error(MemberExistError, MemberApplication."No.", MemberApplication.Name);
                                    Error('The given office email address %1 already exists!', "Office E-Mail");
                        until MemberApplication.Next = 0;
                    end;


                    Cust.Reset;
                    Cust.SetRange(Cust."Office E-Mail", "Office E-Mail");
                    if Cust.FindFirst then
                        IF "Type of Application" <> "Type of Application"::Readmission then
                            // Error(MemberExistError, Cust."No.", Cust.Name);
                            Error('The given office email address %1 already exists!', "Office E-Mail");
                end;
            end;
        }

        field(75; "TSC Number"; Code[20])
        {

            trigger OnValidate()
            var
                Characters: Text;
            begin
                if "TSC Number" <> '' then begin

                    MemberApplication.Reset;
                    MemberApplication.SetFilter("Employer Code", "Employer Code");
                    MemberApplication.SetFilter("TSC Number", "TSC Number");
                    MemberApplication.SetFilter(MemberApplication."No.", '<>%1', "No.");
                    if MemberApplication.FindFirst then
                        if (MemberApplication.Status in [MemberApplication.Status::Open, MemberApplication.Status::Pending, MemberApplication.Status::Approved]) then
                            // Error(MemberExistError, MemberApplication."No.", MemberApplication.Name);
                            Error('The given tsc number %1 already exists!', "TSC Number");


                    Cust.Reset;
                    Cust.SetRange(Cust."Employer Code", "Employer Code");
                    Cust.SetRange(Cust."TSC Number", "TSC Number");
                    if Cust.FindFirst then
                        IF "Type of Application" <> "Type of Application"::Readmission then
                            // Error(MemberExistError, Cust."No.", Cust.Name);
                            Error('The given tsc number %1 already exists!', "TSC Number");

                    Characters := '1234567890';
                    if ValidateShouldNotHaves("TSC Number", Characters) then Error('TSC number must have numbers');

                    Characters := '!@#$%^&*{}[];:" ,<>?= ''';
                    if not ValidateShouldNotHaves("TSC Number", Characters) then Error('TSC number has invalid characters');
                end;
            end;
        }
        field(76; "Permanent Post Code"; Code[20])
        {
            Caption = 'Permanent Post Code';
            TableRelation = "Post Code";
            ValidateTableRelation = false;
            trigger OnValidate()
            begin
                PostCode.ValidatePostCode("Permanent City", "Post Code", County, Nationality, (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(77; "Source Aplication"; Option)
        {
            OptionMembers = "N/A",CRM,"Kenpipe SM","CRM - Sales","Members Portal";
        }

        //GROUP ACCOUNT DETAILS START HERE
        field(500; "Company Registration No."; Code[30])
        {

        }
        field(501; "Allocated Officer"; Code[50])
        {
            TableRelation = "HR Employees"."No." where(Status = const(Active));
        }
        field(502; "Allocated Officer Name"; Text[100])
        {

        }

        field(503; "Year of Incorporation"; Code[4])
        {

        }
        field(504; "Disabled"; Boolean)
        {

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
                if not ValidateShouldNotHaves("Witness ID No.", Characters) then Error('ID Number has invalid characters');
                "Witness Name" := '';
                membersCheck.Reset();
                ;
                membersCheck.SetRange("Primary Identification", "Witness ID No.");
                if membersCheck.Find('-') then
                    "Witness Name" := membersCheck.Name;
            end;
        }
        field(509; "Witness Name"; Text[50])
        {

            trigger OnValidate()
            var
                Characters: Text;
            begin
                Characters := '1234567890!@#$%^&*()_~{}[];:"|\,./<>?-=';
                if not ValidateShouldNotHaves("Witness Name", Characters) then Error('Witness Name has invalid characters');
                "Witness Name" := UPPERCASE("Witness Name");
                "Witness Name" := UpperCase("Witness Name");
            end;
        }
        field(510; "2nd Witness ID No."; code[10])
        {
            trigger OnValidate()
            var
                Characters: Text;
            begin
                if StrLen("2nd Witness ID No.") > 9 then Error('ID Number cannot have more than 9 characters');
                if StrLen("2nd Witness ID No.") < 5 then Error('ID Number cannot have less than 7 characters');
                Characters := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';
                if not ValidateShouldNotHaves("2nd Witness ID No.", Characters) then Error('ID Number has invalid characters');
                "2nd Witness Name" := '';
                membersCheck.Reset();
                membersCheck.SetRange("Primary Identification", "2nd Witness ID No.");
                if membersCheck.Find('-') then
                    "2nd Witness Name" := membersCheck.Name;

                if Rec."Witness ID No." = Rec."2nd Witness ID No." then Error('Witness ID numbers cannot be the same');
            end;
        }
        field(511; "2nd Witness Name"; Text[50])
        {

            trigger OnValidate()
            var
                Characters: Text;
            begin
                Characters := '1234567890!@#$%^&*()_~{}[];:"|\,./<>?-=';
                if not ValidateShouldNotHaves("2nd Witness Name", Characters) then Error('Witness Name has invalid characters');
                "2nd Witness Name" := UPPERCASE("2nd Witness Name");
                "2nd Witness Name" := UpperCase("2nd Witness Name");
            end;
        }

        // CRM Details
        field(600; "CRM Created By"; Code[100])
        {

        }

        field(601; "CRM Originating Branch"; Code[50])
        {

        }

        field(602; "CRM Notes"; text[1000])
        {

        }

        field(610; "CRM Updated By"; Code[100])
        {

        }

        field(611; "CRM Updating Branch"; Code[50])
        {

        }

        field(603; "Mwalimu Smart Callback URL"; text[1000])
        {

        }
        field(604; "Contribution Effective Date"; Date)
        {
            // trigger OnValidate()
            // begin

            //     if "Contribution Effective Date" < Today then;
            //     ERROR('Past dates are not allowed.');
            //     end; 
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
            OptionCaption = 'Salary,Check off,Direct Debit,Cash,Pension,Dividend,Others';
        }
        field(608; "Date Approved"; Date)
        {

        }
        field(1000; "Sent Back to CRM"; Boolean)
        {
            Editable = False;
        }
        field(1001; "Passport Expiry Date"; Date)
        {
        }
        field(1002; "Member No."; Code[50])
        {
            CalcFormula = lookup(Members."No." where("Application No." = field("No.")));
            FieldClass = FlowField;
        }
        field(1003; "Approved By"; Code[100])
        {
        }
        field(1004; "Membership Status"; enum "Member Status")
        {
            CalcFormula = lookup(Members.Status where("Application No." = field("No.")));
            FieldClass = FlowField;
        }

        field(1005; "Sent Back to M-Smart"; Boolean)
        {
            Editable = False;
        }
        field(1007; "Sent Back By"; code[100])
        {
            Editable = False;
        }
        field(1008; "Sent Back At"; DateTime)
        {
            Editable = False;
        }
        field(1009; "CRM Lead Ref. No"; Text[50])
        {
            Editable = False;
        }
        field(1010; "IPRS Verified"; Boolean)
        {
            Editable = False;
        }

        field(1012; "Sub Class"; Code[50])
        {
            TableRelation = "Sub Classes"."Sub Class" where("Main Class" = field("Member Class"));
        }
        field(1013; "Is SACCO Account"; Boolean)
        {
        }
        field(1014; "Application Date Time"; DateTime)
        {
        }
        field(1015; "defined Sla"; Duration)
        {
        }
        field(1016; "Expected completion date"; Duration)
        {
        }
        field(1017; "Type of Business"; Text[50])
        {

        }
        // IPRS
        field(1018; "IPRS ID Type"; Code[50])
        {
            Editable = False;
        }
        field(1019; "IPRS ID"; Text[50])
        {
            Editable = False;
        }
        field(1020; "IPRS Full Names"; Text[150])
        {
            Editable = False;
        }
        field(1021; "IPRS ID Serial No"; Text[100])
        {
            Editable = False;
        }
        field(1022; "IPRS Verified At"; DateTime)
        {
            Editable = False;
        }
        field(1023; "Recruitment Location"; Code[100])
        {
            Editable = true;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "CRM Application No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        UserSetup: Record "User Setup";
        SubDepartments: Enum "Sub Module";
        theSMS: Text;
        theEmail: Text;
        DepartMent: Enum "Responsibility Center Enum";
        SLA: Record "Defined SLA";
        Customer: Record Customer;

    begin
        if "No." = '' then begin

            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Member Application Nos.");
            "No." := NoSeriesMgt.GetNextNo(SeriesSetup."Member Application Nos.");
            // NoSeriesMgt.InitSeries(SeriesSetup."Member Application Nos.", xRec."No. Series", 0D, "No.", "No. Series");

            // if MemberApplication.Get(Rec."No.") then begin
            //     Productfactory.Reset;
            //     ProductFactory.SetFilter(ProductFactory.Status, '%1', ProductFactory.Status::Active);
            //     ProductFactory.SetFilter(ProductFactory."Auto Open Account", '%1', true);
            //     if ProductFactory.Find('-') then begin
            //         repeat
            //             AutoOpenSavingAccs.Reset;
            //             AutoOpenSavingAccs.SetRange("No.", MemberApplication."No.");
            //             //AutoOpenSavingAccs.SetRange("Product Type", ProductFactory."Product ID");
            //             if AutoOpenSavingAccs.Find('-') then begin
            //                 if AutoOpenSavingAccs."Monthly Contribution" = 0 then
            //                     AutoOpenSavingAccs."Monthly Contribution" := ProductFactory."Minimum Contribution";
            //                 AutoOpenSavingAccs.Modify;
            //             end;
            //         until ProductFactory.Next = 0;
            //     end;
            // end;
        end;

        if UserSet.Get(UserId) then begin
            "Responsibility Center" := UserSet."Shortcut Dimension 3 Code";
        end;

        SLA.reset();
        SLA.SetRange("Origination Type", SLA."Origination Type"::"New Registration");
        if SLA.findfirst() then
            "defined Sla" := SLA.SLA
        else if SLA."Origination Type" = SLA."Origination Type"::"Member Readmission" then
            "defined Sla" := SLA.SLA;

        "Testing Date" := CurrentDateTime;
        "Application Date Time" := CurrentDateTime;
        "Application Date" := Today;
        "Application Time" := Time;
        if "Current Address" = '' then begin
            "Current Address" := Addr;
        end;

        if "Home Address" = '' then begin
            "Home Address" := Addr;
        end;
        "Created By" := UserId;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end;

        // if not GlobalFunctions.AssignUserTasks(DepartMent::RECORDS, SubDepartments::"Members Applications", "No.") then
        //     Message('Auto asign of tasks to users has failed. Please make sure that you have present users or contact your system administrator');


        // CRM API
        // CRMApplicationNo: Text;
        // MemberNo: Text;
        // MemberStatus: Option; //' ,New,Active,Dormant,Frozen,Withdrawal Applicant,Withdrawn,Deceased,Defaulter,Closed,Withdrawn Shareholder'
        // MemberApplicationStatus: Option; //'Open,Pending,Approved,Rejected,Created';
        // Description: Text
        // if "CRM Application No." <> '' then begin
        //     CRMIntegration.CRMMemberApplicationUpdate(
        //     "CRM Application No.",
        //     '',
        //     '',
        //     Format(Status),
        //     'New application with status ' + Format(Status),
        //     ''
        // );
        // end;

        // SMS to applicant
        theSMS := 'Dear applicant, your membership application request has been received successfully and is being processed. REF ' + "No.";
        theEmail := '<p>Dear applicant, <br/>Your membership application request has been received successfully and is being processed. Reference: <b>' + "No." + '</b></p>';

        if "Type of Application" = "Type of Application"::Readmission then begin
            theSMS := 'Dear applicant, your membership readmission request has been received successfully and is being processed. REF ' + "No.";
            theEmail := '<p>Dear applicant, <br/>Your membership readmission request has been received successfully and is being processed. Reference: <b>' + "No." + '</b></p>';
        end;

        SkySMS.SendSms(
            SMSSource::CRM,
            "Phone No.",
            theSMS,
            CreateGuid(),
            '',
            false,
            0,
            false,
            'CBS',
            "No.",
            'CBS'
        );

        // EMAIL
        SkySendEmail.QueueOutgoingEmail(
            Rec."E-Mail",
            'Membership Application',
            theEmail,
            'TEXT',
            'MEMBER APPLICATION',
            'CRM'
        );
    end;

    trigger OnModify()
    var
        myInt: Integer;
        thisApp: Record "Member Application";
        MemberAccounts: Record "Savings Accounts";
        ProductSetup: Record "Product Factory";
        Comments: Record Comments;

        EDMSLog: Record "EDMS Scanned Apps. Log";

        theSMS: Text;
        theEmail: Text;
    begin
        thisApp.Reset();

        thisApp.SetRange("No.", Rec."No.");

        if thisApp.FindFirst() then begin
            // Track Status and Created changes
            IF not (thisApp.Status = Status) OR not (thisApp.Created = Created) then begin
                // CRM API
                // CRMApplicationNo: Text;
                // MemberNo: Text;
                // MemberStatus: Option; //' ,New,Active,Dormant,Frozen,Withdrawal Applicant,Withdrawn,Deceased,Defaulter,Closed,Withdrawn Shareholder'
                // MemberApplicationStatus: Option; //'Open,Pending,Approved,Rejected,Created';
                // Description: Text
                IF not Created then begin
                    // if "CRM Application No." <> '' then begin
                    //     CRMIntegration.CRMMemberApplicationUpdate(
                    //     "CRM Application No.",
                    //     '',
                    //     '',
                    //     Format(Status),
                    //     'Application status changed to ' + Format(Status),
                    //     ''
                    // );
                    // end;
                end else begin
                    NewMember.Reset();

                    NewMember.SetFilter("CRM Application No.", "CRM Application No.");

                    IF NewMember.FindFirst() then begin
                        if "CRM Application No." <> '' then begin
                            //     CRMIntegration.CRMMemberApplicationUpdate(
                            //     "CRM Application No.",
                            //     NewMember."No.",
                            //     Format(NewMember.Status),
                            //     Format(Status),
                            //     'Application status changed to ' + Format(Status),
                            //     ''
                            // );
                        end;

                        MemberAccounts.Reset;
                        MemberAccounts.SetFilter("Member No.", NewMember."No.");

                        if MemberAccounts.FindSet then begin
                            repeat begin
                                MemberAccounts.CalcFields(Balance);
                                MemberAccounts.CalcFields("Last Transaction Date");

                                ProductSetup.Reset;

                                ProductSetup.SetFilter("Product ID", MemberAccounts."Product Type");

                                if Format(MemberAccounts."Last Transaction Date") <> '' then begin
                                    // if "CRM Application No." <> '' then begin
                                    //     CRMIntegration.CRMMemberAccountUpdate(
                                    //     '',
                                    //     NewMember."No.",
                                    //     MemberAccounts."No.",
                                    //     MemberAccounts.Balance,
                                    //     GlobalFunctions.FormatISODate(MemberAccounts."Last Transaction Date"),
                                    //     Format(ProductSetup.Category),
                                    //     MemberAccounts."Product Category".AsInteger(),
                                    //     Format(MemberAccounts.Status),
                                    //     ''
                                    // );
                                    // end;
                                end else begin
                                    // if "CRM Application No." <> '' then begin
                                    //     CRMIntegration.CRMMemberAccountUpdate(
                                    //     '',
                                    //     NewMember."No.",
                                    //     MemberAccounts."No.",
                                    //     MemberAccounts.Balance,
                                    //     GlobalFunctions.FormatISODate(Today),
                                    //     Format(ProductSetup.Category),
                                    //     MemberAccounts."Product Category".AsInteger(),
                                    //     Format(MemberAccounts.Status),
                                    //     ''
                                    // );
                                    // end;
                                end;
                            end until MemberAccounts.Next = 0;
                        end;

                        // EDMS
                        EDMSLog.Reset;
                        EDMSLog.SetRange("Application No.", Rec."No.");

                        if EDMSLog.FindFirst then begin
                            EDMSLog."Member No." := NewMember."No.";

                            EDMSLog.Modify;
                        end;
                    end;
                end;


            end;

            if thisApp.Status <> Status then begin
                // SMS to applicant
                case Status of
                    Status::Approved:
                        begin
                            theSMS := 'Dear applicant, your membership application request has been approved. REF ' + "No.";
                            theEmail := '<p>Dear applicant,<br/><br/>Your membership application request has been approved. Reference: <b>' + "No." + '</b></p>';
                            if "Type of Application" = "Type of Application"::Readmission then begin
                                theSMS := 'Dear applicant, your membership readmission request has been approved. REF ' + "No.";
                                theEmail := '<p>Dear applicant,<br/><br/>Your membership readmission request has been approved. Reference: <b>' + "No." + '</b></p>';
                            end;
                        end;
                    Status::Rejected:
                        begin
                            theSMS := 'Dear applicant, your membership application request has been rejected. REF ' + "No.";
                            theEmail := '<p>Dear applicant, your membership application request has been rejected. Reference: <b>' + "No." + '</b></p>';
                            if "Type of Application" = "Type of Application"::Readmission then begin
                                theSMS := 'Dear applicant, your membership readmission request has been rejected. REF ' + "No.";
                                theEmail := '<p>Dear applicant, your membership application request has been rejected. Reference: <b>' + "No." + '</b></p>';
                            end;
                        end;
                end;

                if theSMS <> '' then begin
                    SkySMS.SendSms(
                        SMSSource::CRM,
                        "Phone No.",
                        theSMS,
                        CreateGuid(),
                        '',
                        false,
                        0,
                        false,
                        'CBS',
                        "No.",
                        'CBS'
                    );

                    // EMAIL
                    SkySendEmail.QueueOutgoingEmail(
                        Rec."E-Mail",
                        'Membership Application',
                        theEmail,
                        'TEXT',
                        'MEMBER APPLICATION',
                        'CRM'
                    );
                end;
            end;
        end;
    end;

    var
        SkySMS: CodeUnit SendSms;
        SkySendEmail: CodeUnit "Sky Send Email";
        SMSSource: enum "SMS Source";
        GlobalFunctions: Codeunit "Global Functions";
        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        UserSet: Record "User Setup";
        Cust: Record Members;
        StrTel: Text[30];
        PostCode: Record "Post Code";
        ProductFactory: Record "Product Factory";
        AutoOpenSavingAccs: Record "Savings Account Registration";
        Text018: Label 'This applicant is below the mininmum membership age of %1. Is the applicant applying for a junior account';
        GeneralSetUp: Record "General Set-Up";
        DateofBirthError: Label 'Date cannot be greater than today.';
        MinimumAgeError: Label 'Date of birth must be less than %1';
        // MemberExistError: Label 'Already exists with member %1 Name: %2';
        CountryRegion: Record "Country/Region";
        // SMTPMail: Codeunit "SMTP Mail";
        Customer: Record Customer;
        MemberApplication: Record "Member Application";
        Addr: Label ' P.O. BOX- ';
        BankAccountErr: Label 'Bank Account No cannot be more then 14 characters.';
        MemberClasess: Record "Member Classes";
        ApplicationDocuments: Record "Application Documents";
        CRMApplication: Record "CRM Application";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        ElectrolZonesAreaSvrCenter: Record "Electrol Zones/Area Svr Center";
        SavingsAccounts: Record "Savings Accounts";
        HREmployees: Record "HR Employees";
        MemberApplication2: Record "Member Application";
        PrimaryOrSecondaryID: Option Primary,Secondary;
        NewMob: Code[20];
        MemberRejError: Label 'Status is Rejected For member %1 Name: %2';

        CRMIntegration: Codeunit "CRM Integration";
        NewMember: Record Members;
        membersCheck: Record Members;

    procedure FieldLength(VarVariant: Text; FldLength: Integer): Text
    var
        FieldLengthError: Label 'Field cannot be more than %1 Characters.';
    begin
        if StrLen(VarVariant) > FldLength then
            Error(FieldLengthError, FldLength);
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
            if not ValidateShouldNotHaves(Identification, Characters) then Error('ID Number has invalid characters');
        end;
        if IdentificationType = IdentificationType::"Passport No" then begin
            if StrLen(Identification) > 12 then Error('Passport Number cannot have more thna 12 characters');
            if StrLen(Identification) < 7 then Error('Passport Number cannot have less than 7 characters');
            Characters := '!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';
            if not ValidateShouldNotHaves(Identification, Characters) then Error('Passport Number has invalid characters');
        end;
        if IdentificationType = IdentificationType::"Birth Certificate Number" then begin
            if StrLen(Identification) < 7 then Error('Birth Certificate Number cannot have less than 7 characters');
            Characters := '!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';
            if not ValidateShouldNotHaves(Identification, Characters) then Error('Birth Certificate Number has invalid characters');
        end;
        if IdentificationType = IdentificationType::"Service Number" then begin
            if StrLen(Identification) < 7 then Error('Service Number cannot have less than 7 characters');
            if StrLen(Identification) > 10 then Error('Service Number cannot have more thna 10 characters');
            Characters := '!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';
            if not ValidateShouldNotHaves(Identification, Characters) then Error('Service Number has invalid characters');
        end;

        if "Type of Application" <> Rec."Type of Application"::Readmission then begin
            MemberApplication.Reset();
            MemberApplication.SetFilter("No.", '<>%1', Rec."No.");
            MemberApplication.SetRange(Created, false);
            MemberApplication.SetFilter(Status, '%1|%2|%3', MemberApplication.Status::Open, MemberApplication.Status::Pending, MemberApplication.Status::Approved);
            if MemberApplication.FindSet() then begin
                repeat
                    if IdentificationType = MemberApplication."Primary Identification Type" then
                        if (Identification = MemberApplication."Primary Identification") and (Identification <> '') then
                            Error('Same primary identification value %3 = %2 exists in another application: %1', MemberApplication."No.", Identification, MemberApplication."Primary Identification Type");
                    if IdentificationType = MemberApplication."Secondary Identification Type" then
                        if (Identification = MemberApplication."Secondary Identification") and (Identification <> '') then
                            Error('Same secondary identification value %3 = %2 exists in another application: %1', MemberApplication."No.", Identification, MemberApplication."Secondary Identification Type");
                until MemberApplication.Next() = 0;
            end;

            Members.Reset();
            if Members.FindSet() then begin
                repeat
                    if IdentificationType = Members."Primary Identification Type" then
                        if (Identification = Members."Primary Identification") and (Identification <> '') then
                            Error('Same primary identification value %2 = %3 exists in another membership: %1', Members."No.", Members."Primary Identification Type", Members."Primary Identification");
                    if IdentificationType = Members."Secondary Identification Type" then
                        if (Identification = Members."Secondary Identification") and (Identification <> '') then
                            Error('Same secondary identification value %2 = %3 exists in another membership: %1', Members."No.", Members."Secondary Identification Type", Members."Secondary Identification");
                until Members.Next() = 0;
            end;
        end;

        if "Type of Application" = Rec."Type of Application"::Readmission then begin
            MemberApplication.Reset();
            MemberApplication.SetFilter("No.", '<>%1', Rec."No.");
            MemberApplication.SetRange(Created, false);
            MemberApplication.SetFilter(Status, '%1|%2|%3', MemberApplication.Status::Open, MemberApplication.Status::Pending, MemberApplication.Status::Approved);
            if MemberApplication.FindSet() then begin
                repeat
                    if IdentificationType = MemberApplication."Primary Identification Type" then
                        if (Identification = MemberApplication."Primary Identification") and (MemberApplication."Primary Identification" <> '') then
                            Error('Same Identification in another application: %1', MemberApplication."No.");
                    if IdentificationType = MemberApplication."Secondary Identification Type" then
                        if (Identification = MemberApplication."Secondary Identification") and (MemberApplication."Secondary Identification" <> '') then
                            Error('Same Identification in another application: %1', MemberApplication."No.");
                until MemberApplication.Next() = 0;
            end;

            if Members.Get("Principle Member") then begin
                if IdentificationType = Members."Primary Identification Type" then
                    if (Identification <> Members."Primary Identification") then
                        Error('Mismatch in identification between the existing membership and this application');

                if IdentificationType = Members."Secondary Identification Type" then
                    if (Identification <> Members."Secondary Identification") and (Members."Secondary Identification" <> '') then
                        Error('Mismatch in identification between the existing membership and this application');
            end;
        end;
        exit(Identification);
    end;

    procedure ValidateShouldNotHaves(Number: Text; CharactersToCheck: Text): Boolean
    var
        i: Integer;

    begin
        FOR i := 1 TO STRLEN(Number) DO
            IF STRPOS(CharactersToCheck, Number[i]) > 0 THEN
                exit(false);

        exit(true);
    end;

    // procedure CheckIfCode(Number: Text): Text
    // var
    //     Alphabet: Text;
    //     i: Integer;
    // begin
    //     Alphabet := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    //     FOR i := 1 TO STRLEN(Number) DO
    //         IF STRPOS(Alphabet, Number[i]) > 0 THEN
    //             EXIT('Phone Number cant have alphabets');
    // end;
}

