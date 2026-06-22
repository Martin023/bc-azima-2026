page 52185714 "Member Application Single"
{
    DeleteAllowed = false;
    // InsertAllowed = false;
    PageType = Card;
    // UsageCategory = Administration;
    PromotedActionCategories = 'New,Process,Reports,Creation,Workflows,Views,CRM Actions,EDMS,IPRS';
    SourceTable = "Member Application";

    layout
    {
        area(content)
        {
            // group(CRM)
            // {
            //     Caption = 'CRM Information';
            //     field("CRM Application No."; Rec."CRM Application No.")
            //     {
            //         Editable = false;
            //     }
            //     field("CRM Created By"; Rec."CRM Created By")
            //     {
            //         Editable = false;
            //     }
            //     field("CRM Originating Branch"; Rec."CRM Originating Branch")
            //     {
            //         Editable = false;
            //     }
            //     field("CRM Notes"; Rec."CRM Notes")
            //     {
            //         Editable = false;
            //         MultiLine = true;
            //     }
            //     field("Contribution Start Date"; Rec."Contribution Start Date")
            //     {
            //         Editable = false;
            //     }
            //     field("Contribution Amount"; Rec."Contribution Amount")
            //     {
            //         Editable = false;
            //     }
            // }
            // group(IPRS)
            // {
            //     visible = false;
            //     Caption = 'IPRS Information';
            //     field("IPRS ID Type"; Rec."IPRS ID Type")
            //     {
            //         Editable = false;
            //         Caption = 'IPRS ID Type';
            //     }
            //     field("IPRS ID"; Rec."IPRS ID")
            //     {
            //         Editable = false;
            //         Caption = 'IPRS ID';
            //     }
            //     field("IPRS Full Names"; Rec."IPRS Full Names")
            //     {
            //         Editable = false;
            //         Caption = 'IPRS Full Names';
            //     }
            //     field("IPRS ID Serial No"; Rec."IPRS ID Serial No")
            //     {
            //         Editable = false;
            //         Caption = 'IPRS ID Serial No';
            //     }
            //     field("IPRS Verified"; Rec."IPRS Verified")
            //     {
            //         Editable = false;
            //         Caption = 'IPRS Verified?';
            //     }
            //     field("IPRS Verified At"; Rec."IPRS Verified At")
            //     {
            //         Editable = false;
            //         Caption = 'IPRS Verified At';
            //     }
            // }

            group(General)
            {
                //Editable = TabsEditable;
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Old Member No."; Rec."Old Member No.")
                {
                    ApplicationArea = all;
                    Editable = EmployerEdit;
                }
                field("Account Type"; Rec."Account Type")
                {
                    Editable = false;
                }
                // field("Is SACCO Account"; Rec."Is SACCO Account")
                // {
                //     ApplicationArea = all;
                //     Editable = true;
                // }

                field("Responsible Officer"; Rec."Responsible Officer")
                {
                    ApplicationArea = all;
                    Caption = 'Responsible Officer';
                    Editable = false;
                }
                field("Captured By"; Rec."Created By")
                {
                    ApplicationArea = all;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = all;
                    Caption = 'Application Date';
                    Editable = false;
                }
                field("Application Time"; Rec."Application Time")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Type of Application"; Rec."Type of Application")
                {
                    ApplicationArea = All;
                    Editable = true;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        if (Rec."Type of Application" = Rec."Type of Application"::Readmission) or (Rec."Type of Application" = Rec."Type of Application"::Nominee) then begin
                            EditPrinciple := true;
                        end else
                            EditPrinciple := false;

                        PrefillDetailsForARejoiningMember();
                    end;
                }
                field("Principle Member"; Rec."Principle Member")
                {
                    Editable = EditPrinciple;
                    ShowMandatory = EditPrinciple;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        PrefillDetailsForARejoiningMember();
                    end;
                }
                field(Salutation; Rec.Salutation)
                {
                    ApplicationArea = all;
                    Editable = EmployerEdit;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        if (Rec."Type of Application" = Rec."Type of Application"::Readmission) then
                            Rec.TestField("Principle Member");

                        Rec."Application Date" := Today;
                        Rec."Created By" := UserId;
                    end;
                }

                field(Disabled; Rec.Disabled)
                {
                    Editable = DOBEdit;

                    trigger OnValidate()
                    var
                        Contracts: Record "Certificate Management";
                    begin
                        if Rec.Disabled then begin
                            Contracts.Reset();
                            Contracts.SetRange("Record ID", Rec."No.");
                            Contracts.SetRange("Document Type", Contracts."Document Type"::"Tax Exemption");
                            if Contracts.FindFirst() then Contracts.DeleteAll();

                            Contracts.Init();
                            Contracts."Record ID" := Rec."No.";
                            Contracts."Document Type" := Contracts."Document Type"::"Tax Exemption";
                            Contracts.Insert();

                            Contracts.Reset();
                            Contracts.SetRange("Record ID", Rec."No.");
                            Contracts.SetRange("Document Type", Contracts."Document Type"::"Tax Exemption");
                            if Contracts.FindFirst() then
                                Page.Run(52186716, Contracts);
                        end else begin
                            if not Confirm('Toggling this action off, will automatically remove the dates filled under tax exemption if any\Do you wish to continue?') then begin
                                Rec.Disabled := true;
                            end else begin
                                Contracts.Reset();
                                Contracts.SetRange("Record ID", Rec."No.");
                                Contracts.SetRange("Document Type", Contracts."Document Type"::"Tax Exemption");
                                if Contracts.FindFirst() then Contracts.DeleteAll();
                            end;
                        end;

                    end;
                }

                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = all;
                    Editable = FirstNameEdit;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        //Rec."First Name" := DelChr(Rec."First Name", '=', '0|1|2|3|4|5|6|7|8|9');
                        Rec."Application Date" := Today;
                        rec."Created By" := UserId;
                        Rec.TestField(Salutation);
                    end;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = all;
                    Editable = SecondNameEdit;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        //  Rec."Middle Name" := DelChr(Rec."Middle Name", '=', '0|1|2|3|4|5|6|7|8|9');
                        Rec.TestField("First Name");
                    end;
                }
                field("Other Names"; Rec."Other Names")
                {
                    ApplicationArea = all;
                    Editable = LastNameEdit;

                    trigger OnValidate()
                    begin
                        //Rec."Other Names" := DelChr(Rec."Other Names", '=', '0|1|2|3|4|5|6|7|8|9');
                    end;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = all;
                    Editable = GenderEdit;
                    ShowMandatory = true;
                }


                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = all;
                    Editable = MaritalstatusEdit;
                    ShowMandatory = true;
                }
                field("Member Class"; Rec."Member Class")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                // field("Sub Class"; Rec."Sub Class")
                // {
                //     ApplicationArea = all;

                // }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = all;
                    Editable = DOBEdit;
                    ShowMandatory = true;
                }
                field(Age; Rec.Age)
                {
                    Editable = false;
                }

                field("Primary Identification Type"; Rec."Primary Identification Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        Contracts: Record "Certificate Management";
                    begin
                        Rec.TestField("Middle Name");
                        Contracts.Reset();
                        Contracts.SetRange("Record ID", Rec."No.");
                        Contracts.SetRange("Document Type", Contracts."Document Type"::Passport);
                        Contracts.SetRange("Document No.", Rec."Primary Identification");
                        if Contracts.FindFirst() then Contracts.DeleteAll();
                    end;
                }
                field("Primary Identification"; Rec."Primary Identification")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        Contracts: Record "Certificate Management";
                    begin
                        if Rec."Primary Identification Type" = Rec."Primary Identification Type"::" " then
                            Error('Primary identification type must have a value');

                        if Rec."Primary Identification Type" = Rec."Primary Identification Type"::"Passport No" then begin
                            Contracts.Reset();
                            Contracts.SetRange("Record ID", Rec."No.");
                            Contracts.SetRange("Document Type", Contracts."Document Type"::Passport);
                            if Contracts.FindFirst() then Contracts.DeleteAll();

                            Contracts.Init();
                            Contracts."Record ID" := Rec."No.";
                            Contracts."Document Type" := Contracts."Document Type"::Passport;
                            Contracts."Document No." := Rec."Primary Identification";
                            Contracts.Insert();

                            Contracts.Reset();
                            Contracts.SetRange("Record ID", Rec."No.");
                            Contracts.SetRange("Document Type", Contracts."Document Type"::Passport);
                            if Contracts.FindFirst() then
                                Page.Run(52186716, Contracts);
                        end;
                    end;
                }
                field("Secondary Identification Type"; Rec."Secondary Identification Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    trigger OnValidate()
                    var
                        Contracts: Record "Certificate Management";

                    begin
                        if Rec."Primary Identification" = '' then
                            Error('Primary identification must have a value');

                        if Rec."Primary Identification Type" = Rec."Secondary Identification Type" then
                            Error('Primary and secondary identification types cannot be the same');

                        Contracts.Reset();
                        Contracts.SetRange("Record ID", Rec."No.");
                        Contracts.SetRange("Document Type", Contracts."Document Type"::Passport);
                        Contracts.SetRange("Document No.", Rec."Secondary Identification");
                        if Contracts.FindFirst() then Contracts.DeleteAll();
                    end;
                }
                field("Secondary Identification"; Rec."Secondary Identification")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    trigger OnValidate()
                    var
                        Contracts: Record "Certificate Management";

                    begin
                        if Rec."Primary Identification" = '' then
                            Error('Primary identification must have a value');

                        if Rec."Primary Identification Type" = Rec."Secondary Identification Type" then
                            Error('Primary and secondary identification types cannot be the same');

                        if Rec."Secondary Identification Type" = Rec."Secondary Identification Type"::"Passport No" then begin
                            Contracts.Reset();
                            Contracts.SetRange("Record ID", Rec."No.");
                            Contracts.SetRange("Document Type", Contracts."Document Type"::Passport);
                            if Contracts.FindFirst() then Contracts.DeleteAll();

                            Contracts.Init();
                            Contracts."Record ID" := Rec."No.";
                            Contracts."Document Type" := Contracts."Document Type"::Passport;
                            Contracts."Document No." := Rec."Secondary Identification";
                            Contracts.Insert();

                            Contracts.Reset();
                            Contracts.SetRange("Record ID", Rec."No.");
                            Contracts.SetRange("Document Type", Contracts."Document Type"::Passport);
                            if Contracts.FindFirst() then
                                Page.Run(52186716, Contracts);
                        end;
                    end;
                }
                field("KRA P.I.N Number"; Rec."P.I.N Number")
                {
                    ApplicationArea = all;
                    Editable = PINNumberEdit;
                    ShowMandatory = true;
                }
                field(Religion; Rec.Religion)
                {
                    ApplicationArea = all;
                    // ShowMandatory = true;
                }

                field("Account Profile"; Rec."Account Profile")
                {
                    ApplicationArea = all;
                    Editable = true;
                }

                field("From Another Sacco"; Rec."From Another Sacco")
                {
                    ApplicationArea = all;
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;

                    trigger OnValidate()
                    var
                        RegistrationMngt: Codeunit "Registration Process";
                    begin
                        StatusControl;
                        // if (xRec.Status = Status::DefferFed) and (Rec.Status = Status::Approved) then Error('You cannot approve a deffered case, please reaopen first');
                        if Rec.Status = Rec.Status::Approved then begin
                            RegistrationMngt.MemberRegistration(Rec, true);
                            // Rec.Created := true;
                            // Rec.Modify();
                        end;
                    end;
                }
                field("Date Approved"; Rec."Date Approved")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Group Account No."; Rec."Group Account No.")
                {
                    ApplicationArea = all;
                    Editable = GroupAccountNoEdit;
                    Visible = false;
                }

                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = all;
                    Editable = RespCenterEdit;
                    ShowMandatory = true;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = GlobalDim1Edit;
                    ShowMandatory = true;
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Editable = GlobalDim2Edit;
                    ShowMandatory = true;
                }
                field("Activity Name"; Rec."Activity Name")
                {
                    ApplicationArea = all;
                }
                field(Created; Rec.Created)
                {
                    Editable = false;
                }
                // field("Source Aplication"; Rec."Source Aplication")
                // {
                //     Editable = false;
                // }
            }
            group("Communication Details")
            {
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = all;
                    Editable = NationalityEdit;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        Rec."Current Address" := 'P.O. BOX - ';
                        Rec."Home Address" := 'P.O. BOX - ';
                        Rec.TestField("Global Dimension 1 Code");
                        Rec.TestField("Global Dimension 2 Code");
                        Rec.TestField("Responsibility Center");
                    end;
                }
                field("Current Address"; Rec."Current Address")
                {
                    ApplicationArea = all;
                    Caption = 'Current Address';
                    Editable = AddressEdit;
                    // ShowMandatory = true;

                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = all;
                    Editable = PostCodeEdit;
                    Importance = Promoted;
                    // ShowMandatory = true;
                }

                field(City; Rec.City)
                {
                    ApplicationArea = all;
                    Caption = 'City';
                    Editable = CityEdit;
                    ShowMandatory = true;
                }
                field("Home Address"; Rec."Home Address")
                {
                    ApplicationArea = all;
                    Caption = 'Permanent Address';
                    Editable = AddressEdit;
                    //ShowMandatory = true; Mercy Mugambi Said
                }
                field("Permanent Post Code"; Rec."Permanent Post Code")
                {

                }
                field("Permanent City"; Rec."Permanent City")
                {
                    Editable = false;
                }

                field("Phone No."; Rec."Phone No.")
                {
                    Caption = 'Communication Phone Number';
                    ApplicationArea = all;
                    Editable = MobileNoEdit;
                    ShowMandatory = true;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        CountryRegion: Record "Country/Region";
                    begin


                        // if CountryRegion.Get(Rec.Nationality) then begin
                        //     if CountryRegion."County Phone Code" <> CopyStr(Rec."Phone No.", 1, StrLen(CountryRegion."County Phone Code")) then
                        //         Error('Phone No must start with %1.', CountryRegion."County Phone Code");
                        // end;
                    end;
                }
                field("Transactional Mobile Number"; Rec."Transactional Mobile Number")
                {
                    // ShowMandatory = true;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        CountryRegion: Record "Country/Region";
                    begin


                        if CountryRegion.Get(Rec.Nationality) then begin
                            if CountryRegion."County Phone Code" <> CopyStr(Rec."Phone No.", 1, StrLen(CountryRegion."County Phone Code")) then
                                Error('Phone No must start with %1.', CountryRegion."County Phone Code");
                        end;
                    end;
                }
                field("Office Telephone No."; Rec."Office Telephone No.")
                {
                    ApplicationArea = all;
                    Caption = 'Office Telephone No.';
                    Editable = PhoneEdit;

                }

                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = all;
                    Editable = EmailEdit;
                    ShowMandatory = true;
                }
                field("Office E-Mail"; Rec."Office E-Mail")
                {

                }
            }
            group("Employment Details")
            {
                // Visible = Not SelfEmployed;
                //Editable = TabsEditable;

                field("Self Employed"; Rec."Self Employed")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if Rec."Self Employed" then
                            SelfEmployed := false
                        else
                            SelfEmployed := true;
                    end;
                }
                field("Type of Business"; Rec."Type of Business")
                {
                    ApplicationArea = all;


                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = all;

                    // Editable = SelfEmployed;
                    ShowMandatory = SelfEmployed;
                }
                field("Employer Name"; Rec."Employer Name")
                {
                    ApplicationArea = all;

                    Editable = SelfEmployed;
                    ShowMandatory = SelfEmployed;
                }

                field("Payroll/Staff No."; Rec."Payroll/Staff No.")
                {
                    ApplicationArea = all;
                    Editable = SelfEmployed;
                    ShowMandatory = SelfEmployed;


                    trigger OnValidate()
                    begin
                        Rec.TestField("Employer Code");
                    end;
                }
                // field("TSC Number"; Rec."TSC Number")
                // {

                // }
                field("Terms of Employment"; Rec."Terms of Employment")
                {
                    ApplicationArea = all;
                    Editable = SelfEmployed;
                    ShowMandatory = SelfEmployed;
                    trigger OnValidate()
                    var
                        Contracts: Record "Certificate Management";
                    begin
                        Rec.TestField("Payroll/Staff No.");
                        if Rec."Terms of Employment" = Rec."Terms of Employment"::Contract then begin
                            Contracts.Reset();
                            Contracts.SetRange("Record ID", Rec."No.");
                            Contracts.SetRange("Document Type", Contracts."Document Type"::Contract);

                            if Contracts.FindFirst() then Contracts.DeleteAll();

                            Contracts.Init();
                            Contracts."Record ID" := Rec."No.";
                            Contracts."Document Type" := Contracts."Document Type"::Contract;
                            Contracts.Insert();

                            Contracts.Reset();
                            Contracts.SetRange("Record ID", Rec."No.");
                            Contracts.SetRange("Document Type", Contracts."Document Type"::Contract);
                            if Contracts.FindFirst() then
                                Page.Run(52186716, Contracts);
                        end else begin
                            if xRec."Terms of Employment" = Rec."Terms of Employment"::Contract then
                                if not Confirm('Changing from contract, will automatically remove the dates filled under contracts if any\Do you wish to continue?') then begin
                                    Rec."Terms of Employment" := Rec."Terms of Employment"::Contract;
                                    exit;
                                end else begin
                                    Contracts.Reset();
                                    Contracts.SetRange("Record ID", Rec."No.");
                                    Contracts.SetRange("Document Type", Contracts."Document Type"::Contract);
                                    if Contracts.FindFirst() then Contracts.DeleteAll();
                                end;
                        end;

                    end;
                }
                field("Contribution Effective Date"; Rec."Contribution Effective Date")
                {

                    Caption = 'Contribution Start Date';
                    ApplicationArea = all;
                    ShowMandatory = True;
                }
                field("Contribution Mode"; Rec."Contribution Mode")
                { }
                field("Country Of Operation"; Rec."Country Of Operation")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = all;
                    Editable = CountyEdit;
                    //ShowMandatory = true;
                }
                field("Sub-County"; Rec."Sub-County")
                {

                }

                field("Work Station"; Rec."Work Station")
                {
                    Editable = SelfEmployed;
                    //ShowMandatory = SelfEmployed;
                }
                // field("Employment Designation"; Rec."Employment Designation")
                // {
                //     Editable = SelfEmployed;
                //     // ShowMandatory = SelfEmployed;
                // }


            }
            group("Other Information")
            {
                //Editable = TabsEditable;
                field("Recruited by Type"; Rec."Recruited by Type")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Rec."Recruited By" := '';
                        Rec."Recruited By Name" := '';
                        if (Rec."Recruited by Type" = Rec."Recruited by Type"::Self) or (Rec."Recruited By Type" = Rec."Recruited By Type"::None) then
                            SalesEdit := false
                        else
                            SalesEdit := true;
                    end;
                }
                field("Recruited By"; Rec."Recruited By")
                {
                    ApplicationArea = all;
                    Caption = 'Recruited By';
                    Editable = SalesEdit;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        // Handle 'Others'
                        if Rec."Recruited by Type" = Rec."Recruited by Type"::Others then begin
                            Members.Reset;
                            Members.SetRange("No.", Rec."Recruited By");
                            if Members.FindFirst then
                                Rec."Recruited By Name" := Members.Name;
                        end;

                        // Handle 'Delegates'
                        if Rec."Recruited by Type" = Rec."Recruited by Type"::Delegates then begin
                            DelegateMemberss.Reset;
                            DelegateMemberss.SetRange("Delegate MNO.", Rec."Recruited By");
                            if DelegateMemberss.FindFirst then
                                Rec."Recruited By Name" := DelegateMemberss."Delegate Name";
                        end;

                        // Handle 'Staff'
                        if Rec."Recruited by Type" = Rec."Recruited by Type"::Staff then begin
                            HREmployees.Reset;
                            HREmployees.SetRange("No.", Rec."Recruited By");
                            if HREmployees.FindFirst then
                                Rec."Recruited By Name" := HREmployees."Full Name";
                        end;
                    end;
                }
                field("Recruited By Name"; Rec."Recruited By Name")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("recruitment Location"; Rec."Recruitment Location")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("Delegates Zone"; Rec."Delegates Zone")
                {

                    ApplicationArea = all;
                }
                field("Electrol Zone Descr."; Rec."Electrol Zone Descr.")
                {
                    ApplicationArea = all;
                }
                // field("Request for ATM"; Rec."Request for ATM")
                // {
                //     ApplicationArea = all;
                // }
                // field("Request Mobile Banking"; Rec."Request Mobile Banking")
                // {
                //     ApplicationArea = all;
                // }

                field("Witness ID No."; Rec."Witness ID No.")
                {
                    ApplicationArea = all;
                }
                field("Witness Name"; Rec."Witness Name")
                {
                    ApplicationArea = all;
                }

                field("2nd Witness ID No."; Rec."2nd Witness ID No.")
                {
                    ApplicationArea = all;
                }
                field("2nd Witness Name"; Rec."2nd Witness Name")
                {
                    ApplicationArea = all;
                }

            }
            group("Bank Details")
            {
                //Editable = TabsEditable;
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = all;
                    Editable = BankEdit;

                    trigger OnValidate()
                    var
                        BankStructure: Record "Bank Code Structure";
                    begin
                        if BankStructure.Get(Rec."Bank Code") then begin
                            Rec."Bank Name" := BankStructure.Name;
                            Rec."Branch Code" := '';
                            Rec."Bank Branch Name" := '';
                        end;
                    end;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    Editable = false;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = all;
                    Editable = BranchEdit;
                    trigger OnValidate()
                    var
                        BankStructure: Record "Bank Code Structure";
                    begin
                        if BankStructure.Get(Rec."Branch Code") then begin
                            Rec."Bank Branch Name" := BankStructure.Name;
                        end;
                    end;
                }
                field("Bank Branch Name"; Rec."Bank Branch Name")
                {
                    Editable = false;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = all;
                    Editable = BankAccountNoEdit;
                }
            }
        }
        area(factboxes)
        {

            part("Attached Documents"; "Doc. Attachment List Factbox")
            {
                ApplicationArea = basic;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(52185691),
                "No." = field("No.");

            }

        }

    }

    actions
    {
        area(creation)
        {

            action("Relations and Inheritance")
            {
                ApplicationArea = all;
                Image = Relationship;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Next of KIN Application";
                Caption = 'Dependancies Application Card';
                RunPageLink = "Record ID" = FIELD("No.");
            }
            action("Default Savings Product")
            {
                ApplicationArea = all;
                Image = Accounts;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Savings Account Registration";
                RunPageLink = "No." = FIELD("No.");
            }

            action("Picture & Signature")
            {
                ApplicationArea = all;
                Image = Picture;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Page "Member App Picture & Signature";
                RunPageLink = "No." = FIELD("No.");
            }

            group("Certificate Management")
            {
                // action(Passport)
                // {
                //     ApplicationArea = all;
                //     Image = Certificate;
                //     Promoted = true;
                //     PromotedCategory = Category4;
                //     RunObject = Page "Certificate Management";
                //     Caption = 'Passport';
                //     RunPageLink = "Record ID" = FIELD("No."), "Document Type" = filter(Passport);
                // }
                action("Tax Exemption")
                {
                    ApplicationArea = all;
                    Image = Certificate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Certificate Management";
                    Caption = 'Tax Excemption';
                    RunPageLink = "Record ID" = FIELD("No."), "Document Type" = filter("Tax Exemption");
                }
                // action("Contract")
                // {
                //     ApplicationArea = all;
                //     Image = Certificate;
                //     Promoted = true;
                //     PromotedCategory = Category4;
                //     RunObject = Page "Certificate Management";
                //     Caption = 'Contract';
                //     RunPageLink = "Record ID" = FIELD("No."), "Document Type" = filter("Contract");
                // }
            }
            action("Reset Application Details")
            {
                ApplicationArea = all;
                Image = RefreshVoucher;
                Promoted = true;
                PromotedCategory = category4;
                Visible = false;

                trigger OnAction()
                var
                    RegistrationMngt: Codeunit "Registration Process";
                    Text002: Label 'Are you sure you want to convert this application to membership?';
                    Text003: Label 'Are you sure you want to reset this application details?';
                    UserSetup: Record "User Setup";
                    Application: Record "Member Application";
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    if not Confirm(Text003) = true then exit;
                    UserSetup.Reset;
                    UserSetup.SetRange("User ID", UserId);
                    if UserSetup.FindFirst then begin
                        UserSetup.TestField("Global Dimension 1 Code");
                        UserSetup.TestField("Global Dimension 2 Code");
                        UserSetup.TestField("Responsibility Centre");
                        Application.Reset;
                        Application.SetRange("No.", Rec."No.");
                        if Application.Find('-') then begin
                            Rec."Application Date" := Today;
                            Rec."Created By" := UserId;
                            Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
                            Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                            Rec."Responsibility Center" := UserSetup."Responsibility Centre";
                            Rec."First Name" := '';
                            Rec."Middle Name" := '';
                            Rec.Name := '';
                            Rec."Other Names" := '';
                            Rec."Date of Birth" := 0D;
                            Rec."Payroll/Staff No." := '';
                            Rec."Employer Code" := '';
                            Rec."P.I.N Number" := '';
                            // Rec."Mobile Phone No" := '';
                            Rec.Modify;

                        end;
                    end;
                end;
            }
        }


        area(processing)
        {
            group("Workflows")
            {
                action(SendApprovalRequest)
                {
                    ApplicationArea = all;
                    Caption = 'Send A&pproval Request';
                    Visible = SendApprovalVisible;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        NextofKinError: Label 'You must specify next of Kin for this application.';
                        RegistrationMngt: Codeunit "Registration Process";
                        UserSetup: Record "User Setup";
                        Application: Record "Member Application";
                        IdentificationType: Enum "Identification Type";
                        CertificateManagement: Record "Certificate Management";
                        TypeOfApplication: Enum "Type of Application";
                        NokApp: Record "Next of KIN Application";
                    begin
                        if Rec."Source Aplication" = Rec."Source Aplication"::CRM then begin
                            Rec.TestField("Sent Back to CRM", false);
                        end;
                        if rec."Transactional Mobile Number" = '' then
                            if Confirm('Transactional Mobile Number is empty. This member will not be able to access mobile banking. Do you wish to continue') = false then
                                exit
                            else
                                Error('Transactional mobile no must be inserted');
                        if rec."Primary Identification" = '' then
                            Error('Primary Identification is required for membership application');


                        if not Confirm('Are you sure you want to send this application for approval?') then exit;

                        if Rec."Type of Application" = Rec."Type of Application"::"New Registration" then begin
                            Members.Reset();
                            Members.SetRange("Primary Identification", Rec."Primary Identification");
                            if Members.FindFirst() then begin
                                if Confirm('This member already exists under membership ' + Members."No." + ' do you wish to convert it to readmission?') then begin
                                    Rec."Type of Application" := Rec."Type of Application"::Readmission;
                                    Rec.Modify();
                                    Message('This membership has been converted to readmission, kindly reload the page then send it for approval');
                                    exit;
                                end else
                                    exit;
                            end;
                        end;

                        NokApp.Reset();
                        NokApp.SetRange("Record ID", Rec."No.");
                        if NokApp.FindSet() then begin
                            repeat
                                if NokApp.Name = '' then Error('One of the dependancies is missing a name');
                                if NokApp."Identification Type" = NokApp."Identification Type"::" " then Error('Indetification type must have a value for %1', NokApp.Name);
                                // NokApp.TestField(Identification);
                                NokApp.TestField(Relationship);
                                if (not NokApp."Is a Beneficiary") and (not NokApp."Is Contact Person") and (not NokApp."Is Nominee") then
                                    Error('Is a Beneficiary : %1\Is a Contact Person: %2\Is a Nominee: %3\One of the above must be true for %4', NokApp."Is a Beneficiary", NokApp."Is Contact Person", NokApp."Is Nominee", NokApp.Name);
                            until NokApp.Next() = 0;
                        end;

                        NokApp.Reset();
                        NokApp.SetRange(Removed, false);
                        NokApp.SetRange(Deceased, false);
                        NokApp.SetRange("Record ID", Rec."No.");
                        NokApp.SetRange("Is Nominee", true);
                        if NokApp.FindSet() then begin
                            NokApp.CalcSums(NokApp.Allocation);
                            if NokApp.Allocation <> 100 then Error('Alocation must sum up to 100%');
                        end;

                        if Rec."Type of Application" <> Rec."Type of Application"::"New Registration" then
                            Rec.TestField("Principle Member");
                        // Rec.TestField(Salutation);
                        Rec.TestField("First Name");
                        Rec.TestField("Middle Name");
                        Rec.TestField(Gender);
                        // Rec.TestField("Marital Status");
                        Rec.TestField("Member Class");
                        Rec.TestField("Date of Birth");
                        Rec.TestField("Primary Identification Type");
                        Rec.TestField("Primary Identification");
                        // Rec.TestField("E-Mail");
                        //Rec.TestField("P.I.N Number");
                        Rec.Validate("Primary Identification");
                        // Rec.TestField("Transactional Mobile Number");
                        // if Rec.Age > 18 then
                        //     Rec.TestField("P.I.N Number");
                        // Rec.TestField(Religion);
                        Rec.TestField("Global Dimension 1 Code");
                        Rec.TestField(Nationality);
                        if (StrLen(Rec."First Name") < 2) and (StrLen(Rec."Middle Name") < 2) and (StrLen(Rec."Other Names") < 2) then error('Invalid name, all names must not be Initials.');

                        Rec.TestField("Phone No.");
                        Rec.Validate("Phone No.");
                        //Rec.TestField("Employer Code"); //Karaya Said it should be compulsory
                        //Rec.TestField("Transactional Mobile Number");

                        if not Rec."Self Employed" then begin
                            Rec.TestField("Employer Code");
                            // if rec."Employer Code" <> 'DIASPORA' then begin
                            Rec.TestField("Payroll/Staff No.");
                            Rec.TestField("Terms of Employment");
                            // end;

                            // Rec.TestField("Work Station");
                            // Rec.TestField("Employment Designation");
                        end;
                        if Rec."Self Employed" then
                            Rec.TestField("Type of Business");

                        Rec.TestField("Country Of Operation");
                        // Rec.TestField(County);
                        if Rec."Recruited by Type" = Rec."Recruited by Type"::"None" then
                            Error('Recruited By Type must have a value');
                        // Rec.TestField("Recruited By");
                        //Rec.TestField("Recruited by Type");
                        //Rec.TestField("Delegates Zone");
                        if Rec."Contribution Effective Date" = 0D then
                            Error('Contribution Start Date must have a value');

                        Rec.CalcFields(Picture, Signature, "ID Card Front", "ID Card Back");
                        if not rec.Signature.HasValue then Error('Signature must have a value');
                        if not rec.Picture.HasValue then Error('Picture must have a value');
                        if not rec."ID Card Front".HasValue then error('ID Card Front must have a value');
                        if not rec."ID Card Back".HasValue then error('ID Card Back must have a value');


                        if Rec."Account Type" = Rec."Account Type"::"Single Member Account" then begin
                            AutoOpenedSavingAccs.Reset();
                            AutoOpenedSavingAccs.Reset();
                            AutoOpenedSavingAccs.SetRange("No.", Rec."No.");
                            if NOT AutoOpenedSavingAccs.Find('-') then begin

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
                                        AutoOpenSavingAccs."No." := Rec."No.";
                                        AutoOpenSavingAccs."Product Type" := ProductFactory."Product ID";
                                        //AutoOpenSavingAccs.Validate(AutoOpenSavingAccs."Product Type", ProductFactory."Product ID");
                                        AutoOpenSavingAccs."Monthly Contribution" := ProductFactory."Minimum Contribution";
                                        AutoOpenSavingAccs."Product Name" := ProductFactory."Product Description";
                                        AutoOpenSavingAccs.Insert;
                                    until ProductFactory.Next = 0;
                                end;
                            end;
                        end;

                        AutoOpenedSavingAccs.Reset();
                        AutoOpenedSavingAccs.SetRange("No.", Rec."No.");
                        if AutoOpenedSavingAccs.Find('-') then begin
                            repeat
                                if AutoOpenedSavingAccs."Monthly Contribution" = 0 then begin
                                    if ProductFactory.Get(AutoOpenedSavingAccs."Product Type") then begin
                                        if ProductFactory."Minimum Contribution" > 0 then begin
                                            if AutoOpenedSavingAccs."Monthly Contribution" <= 0 then
                                                Error('Kindly specify the minimum monthly contribution for %1 before proceeding.', ProductFactory."Product Description");
                                        end;
                                    end;
                                end;
                            until AutoOpenedSavingAccs.Next = 0;
                        end;

                        ApprovalsMgmt.Run();
                        UserSetup.Reset;
                        UserSetup.SetRange("User ID", UserId);
                        if UserSetup.FindFirst then begin
                            UserSetup.TestField("Global Dimension 1 Code");
                            UserSetup.TestField("Global Dimension 2 Code");
                            UserSetup.TestField("Responsibility Centre");
                            Application.Reset;
                            Application.SetRange("No.", Rec."No.");
                            if Application.Find('-') then begin
                                Rec."Application Date" := Today;
                                Rec."Created By" := UserId;
                                // Rec."Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code"; b
                                Rec."Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
                                Rec."Responsibility Center" := UserSetup."Responsibility Centre";
                                Rec.Modify;
                            end;
                        end;

                        if Rec."Recruited by Type" <> Rec."Recruited by Type"::Self then
                            Rec.TestField("Recruited By");
                        Rec.TestField(Status, Rec.Status::Open);

                        if Rec."Type of Application" = Rec."Type of Application"::Readmission then
                            Members.Get(Rec."Principle Member");

                        // if (Rec."IPRS Verified" = false) and
                        // (Rec."Primary Identification Type" = Rec."Primary Identification Type"::"ID Number") then begin
                        //     // Error('Primary Identification number must be IPRS verified before sending this membership application for approval');
                        //     Message('Take note that this application ID Number has NOT been verified through IPRS');
                        // end;


                        VarVariant := Rec;
                        ApprovalsMgmt.DeleteApprovalEntries(Rec.RecordId);
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then begin
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                            MemberApplication."No." := Rec."No.";
                        end;
                        // if rec.Status = rec.Status::Approved then
                        //     Message('Record approved successfully');
                        CurrPage.close;
                    end;
                }


                action(Approve)
                {
                    ApplicationArea = all;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Enabled = OpenApprovalEntriesExist;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if not Confirm('Are you sure you want to approve this record?') then exit;
                        Rec.TestField(Status, Rec.Status::Pending);
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = all;
                    Caption = 'Cancel Approval Re&quest';
                    //Visible = ReopenVisible;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = False;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        GlobalFunctions.CommentsManagement(Rec."No.");
                        if not Rec.Created then begin
                            if not Confirm('Are you sure you want to open this record?') then exit;
                            VarVariant := Rec;
                            CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                        end else
                            Error('You cannot open a created record');
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = all;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Enabled = OpenApprovalEntriesExist;
                    //Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        GlobalFunctions.CommentsManagement(Rec."No.");
                        if not Confirm('Are you sure you want to reject this application?') then exit;
                        Rec.TestField(Status, Rec.Status::Pending);
                        Rec.Status := Rec.Status::Rejected;
                        Rec.Modify(true);
                        Message('Application rejected sucessfully.');
                        // ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = all;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Enabled = OpenApprovalEntriesExist;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        GlobalFunctions.CommentsManagement(Rec."No.");
                        Rec.TestField(Status, Rec.Status::Pending);
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reopen Card';
                    Image = ReOpen;
                    Visible = ReopenVisible;
                    PromotedCategory = Category5;
                    Promoted = true;
                    trigger OnAction()
                    var

                    begin
                        GlobalFunctions.CommentsManagement(Rec."No.");


                        if not Rec.Created then begin
                            if not Confirm('Are you sure you want to open this record?') then exit;

                            // VarVariant := Rec;
                            // CustomApprovals.OnCancelDocApprovalRequest(VarVariant);

                            if rec.Status <> rec.Status::open then begin
                                rec.Status := rec.Status::Open;
                                rec.Modify();
                                //CurrPage.Update();
                                Message('The record have been opened successfully.');
                            end;

                        end else
                            Error('You cannot open a created record');
                    end;
                }
                action(Deffer)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Deffer Application';
                    Image = ReOpen;
                    Visible = DeferVisible;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var

                    begin
                        if Rec."Source Aplication" = Rec."Source Aplication"::CRM then begin
                            Rec.TestField("Sent Back to CRM", false);
                        end;


                        GlobalFunctions.CommentsManagement(Rec."No.");
                        if Rec.Status <> Rec.Status::Open then
                            Error('Status must be equal to open');
                        if not Rec.Created then begin
                            if not Confirm('Are you sure you want to deffer this record?') then exit;

                            // if Rec.Status = Rec.Status::Pending then begin
                            //     VarVariant := Rec;
                            //     CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                            // end;

                            Rec.Status := Rec.Status::Deffered;
                            Rec.Validate(Status);
                            Rec.Modify(true);
                            Message('Record deffered successfully');
                        end else
                            Error('You cannot deffer a created record');
                    end;
                }


                action(Archive)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Archive Application';
                    Image = Archive;
                    //Visible = RejectVisible;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var

                    begin
                        if Rec.Status = Rec.Status::Archived then
                            Error(('This record is already in archived state.'));
                        GlobalFunctions.CommentsManagement(Rec."No.");
                        if not Rec.Created then begin
                            if not Confirm('Are you sure you want to archive this record?') then exit;
                            GlobalFunctions.CancelApprovalManually(Rec.RecordId);
                            Rec.Status := Rec.Status::Archived;
                            Rec.Validate(Status);
                            Rec.Modify(true);
                            Message('Record archived succsessfully');
                        end else
                            Error('You cannot archive a created record');
                    end;
                }

                // action(Comment)
                // {
                //     ApplicationArea = all;
                //     Caption = 'Comments';
                //     Image = ViewComments;
                //     Promoted = true;
                //     PromotedCategory = Category5;
                //     RunObject = Page "Approval Comments";
                // }

                action(Comments)
                {
                    ApplicationArea = Basic, Suite;
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category5;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No.");
                    RunPageView = where(Types = CONST(comment));
                }

            }
            group(Views)
            {
                // action("MEMBER [FILE]")
                // {
                //     ApplicationArea = all;
                //     Image = Document;
                //     Promoted = true;
                //     PromotedCategory = Category6;

                //     trigger OnAction()
                //     var
                //         DMS: Record EDMS;
                //     begin

                //         DMS.Reset;
                //         DMS.SetRange(DMS.Key, DMS.Key::"member App");
                //         if DMS.Find('-') then begin
                //             HyperLink(DMS."url path" + Rec."No.");
                //         end;
                //     end;
                // }
                action(Approvals)
                {
                    ApplicationArea = all;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category6;

                    trigger OnAction()
                    var
                        //ApprovalEntries: Page "Approval Entries";
                        approvalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        approvalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
            }

            group(TaskAssignment)
            {
                Caption = 'Assign Task';
                action(AssinedUser)
                {
                    ApplicationArea = all;
                    Image = Task;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "User Tasks";
                    RunPageLink = "Record ID" = FIELD("No.");
                    Caption = 'User Assigned';
                }
            }

            group("Member Creation")
            {
                action("Create Member")
                {
                    ApplicationArea = all;
                    Image = Process;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        RegistrationMngt: Codeunit "Registration Process";
                        Text002: Label 'Are you sure you want to convert this application to membership?';
                    begin
                        if rec.Created then
                            Error('This member is already created');
                        Rec.TestField(Status, Rec.Status::Approved);
                        if not Confirm(Text002) = true then exit;
                        RegistrationMngt.MemberRegistration(Rec, true);
                        Rec.Created := true;
                        // Rec.Modify();
                    end;
                }

            }
            group("CRM Integration")
            {
                // Visible = Rec."Source Aplication" = Rec."Source Aplication"::CRM;
                Visible = IsNotSentBackToCRM;
                Enabled = IsNotSentBackToCRM;
                action("CRM Comment")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Comment;
                    Promoted = true;
                    PromotedCategory = Category7;

                    RunObject = page "Comments List";
                    RunPageLink = "Header No." = field("No.");
                    RunPageView = where(Types = CONST(comment));
                    // RunPageMode = Create;

                    Visible = IsNotSentBackToCRM;
                }
                action("Send Back to CRM")
                {
                    ApplicationArea = all;
                    Image = Return;
                    Promoted = true;
                    PromotedCategory = Category7;

                    Visible = IsNotSentBackToCRM;

                    trigger OnAction()
                    var
                        Comments: Record Comments;
                    begin
                        Rec.TestField(Status, Rec.Status::Open);

                        Comments.Reset;
                        Comments.SetRange("Header No.", Rec."No.");
                        Comments.SetAscending("Entry No.", true);

                        if Comments.FindLast then begin
                            if (Comments."Commented By" <> UserId) then begin
                                Error('Comment is required before sending the application back to CRM');
                            end else begin
                                if Confirm('This application will be sent back to CRM for editing. Are you sure you want to proceed?') then begin
                                    Rec."Sent Back to CRM" := true;
                                    Rec."Sent Back At" := CurrentDateTime;
                                    Rec."Sent Back By" := UserId;
                                    Rec.Modify;

                                    Message('Comment has been sent back to CRM');

                                    CurrPage.Close();
                                end;
                            end;
                        end else begin
                            Error('Comment is required before sending the application back to CRM');
                        end;
                        ;
                    end;
                }
            }

            // DO NOT Comment out this!
            group("EDMS Integration")
            {
                visible = false;
                //     // action("Import")
                //     // {
                //     //     ApplicationArea = All;
                //     //     Caption = 'Import File';
                //     //     Promoted = true;
                //     //     PromotedCategory = Category8;
                //     //     Image = Import;

                //     //     trigger OnAction()
                //     //     var
                //     //         Base64Convert: Codeunit "Base64 Convert";
                //     //         TempBlob: Codeunit "Temp Blob";
                //     //         InStr: InStream;

                //     //         EDMSFunctions: Codeunit "EDMS Functions";
                //     //         FileName: Text;
                //     //         FileContentsB64: Text;

                //     //         IDNumber: Text;
                //     //         ApplicationType: Label 'MA'; // Member Application
                //     //         PFNumber: Text;
                //     //     begin
                //     //         if Rec."No." <> '' then begin
                //     //             FileName := EDMSFunctions.PickEDMSFile(TempBlob);

                //     //             TempBlob.CreateInStream(InStr);
                //     //             FileContentsB64 := Base64Convert.ToBase64(InStr);

                //     //             if FileContentsB64 <> '' then begin
                //     //                 UploadToEDMS(Rec, FileName, FileContentsB64);
                //     //             end;
                //     //         end else begin
                //     //             Error('Application No. is required for EDMS document upload');
                //     //         end;
                //     //     end;
                //     // }

                // DO NOT comment out this!
                action("EDMS File List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Category8;
                    Caption = 'Channel Application Documents';

                    RunObject = page "Channel Application Documents";
                    RunPageLink = "Application No." = field("No.");
                }
            }

            // group("IPRS Integration")
            // {
            //     visible = false;
            //     action("IPRS File List")
            //     {
            //         Caption = 'IPRS Verification';
            //         ApplicationArea = Basic, Suite;
            //         Image = UserSetup;
            //         Promoted = true;
            //         PromotedCategory = Category9;

            //         trigger OnAction()
            //         var
            //             IPRS: Codeunit "IPRS Integration";
            //         begin
            //             if Rec."IPRS Verified" then begin
            //                 // Ask user to confirm re-verification
            //                 // Confirm user is aware of charges
            //                 if Confirm('This application is already verified with IPRS. Do you wish to proceed with the IPRS verification of this membership application again? Standard charges apply') then begin
            //                     IPRS.ValidateMemberApplication(Rec);
            //                 end;
            //             end else begin
            //                 // Confirm user is aware of charges
            //                 if Confirm('Do you wish to proceed with the IPRS verification of this membership application? Standard charges apply') then begin
            //                     IPRS.ValidateMemberApplication(Rec);
            //                 end;
            //             end;
            //         end;
            //     }
            // }

            // group("M-Smart Integration")
            // {
            //     Visible = IsNotSentBackToMSmart;
            //     Enabled = IsNotSentBackToMSmart;
            //     action("M-Smart Comment")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         Image = Comment;
            //         Promoted = true;
            //         PromotedCategory = Category9;

            //         RunObject = page "Comments List";
            //         RunPageLink = "Header No." = field("No.");
            //         RunPageView = where(Types = CONST(comment));
            //         // RunPageMode = Create;

            //         Visible = IsNotSentBackToMSmart;
            //     }
            //     action("Send Back to M-Smart")
            //     {
            //         ApplicationArea = all;
            //         Image = Return;
            //         Promoted = true;
            //         PromotedCategory = Category9;

            //         Visible = IsNotSentBackToMSmart;

            //         trigger OnAction()
            //         var
            //             Comments: Record Comments;
            //         begin
            //             Comments.Reset;
            //             Comments.SetRange("Header No.", Rec."No.");
            //             Comments.SetAscending("Entry No.", true);


            //             ;
            //         end;
            //     }
            // }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
    begin
        SetControlAppearance();
        StatusControl;

        CRMControl();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
        StatusControl();

        CRMControl();
        // if not Rec.Created then
        //     GlobalFunctions.PopUpCommentsIfCaseHas(Rec."No.");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        MemberAppliction: Record "Member Application";
    begin
        // Rec.Source := Rec.Source::CRM;
        // Rec."Single Party/Multiple/Business" := Rec."Single Party/Multiple/Business"::Single;

        // MemberAppliction.Reset;
        // MemberAppliction.SetRange("Created By", UserId);
        // MemberAppliction.SetRange(Status, MemberAppliction.Status::Open);
        // MemberAppliction.SetRange(Name, '');
        // if MemberAppliction.FindFirst then
        //     Error('You Already Have an Unused Open Card %1', MemberAppliction."No." + ' ' + 'On the Open Single Membership or On the Group Membership Application');

        Rec."Application Date" := Today;

        CRMControl();
    end;

    trigger OnOpenPage()
    begin

        SetControlAppearance();
        StatusControl;

        // if MemberApplication.Get(Rec."No.") then begin
        //     ProductFactory.SetFilter(ProductFactory.Status, '%1', ProductFactory.Status::Active);
        //     ProductFactory.SetFilter(ProductFactory."Auto Open Account", '%1', true);
        //     ProductFactory.SetFilter(ProductFactory."Product Category", '<>%1', ProductFactory."Product Category"::"Fixed Deposit");
        //     if ProductFactory.Find('-') then begin
        //         repeat
        //             AutoOpenSavingAccs.Reset;
        //             AutoOpenSavingAccs.SetRange("No.", MemberApplication."No.");
        //             AutoOpenSavingAccs.SetRange("Product Type", ProductFactory."Product ID");
        //             if AutoOpenSavingAccs.Find('-') then begin
        //                 if AutoOpenSavingAccs."Monthly Contribution" = 0 then
        //                     AutoOpenSavingAccs."Monthly Contribution" := ProductFactory."Minimum Contribution";
        //                 AutoOpenSavingAccs.Modify;
        //             end;
        //         until ProductFactory.Next = 0;
        //     end;
        //end;
        if Rec."Self Employed" then
            SelfEmployed := false
        else
            SelfEmployed := true;

        if (Rec."Type of Application" = Rec."Type of Application"::Readmission) or (Rec."Type of Application" = Rec."Type of Application"::Nominee) then begin
            EditPrinciple := true;
        end else
            EditPrinciple := false;

        CRMControl();
    end;

    procedure UploadToEDMS(Rec: Record "Member Application"; FileName: Text; FileContentsB64: Text)
    var
        EDMSFunctions: Codeunit "EDMS Functions";

        IDNumber: Text;
        ApplicationType: Label 'MA'; // Member Application
        PFNumber: Text;
    begin
        if Rec."Primary Identification Type" = Rec."Primary Identification Type"::"ID Number" then begin
            IDNumber := Rec."Primary Identification";
        end else
            if Rec."Secondary Identification Type" = Rec."Secondary Identification Type"::"ID Number" then begin
                IDNumber := Rec."Secondary Identification";
            end else begin
                IDNumber := Rec."Primary Identification";
            end;

        if Rec."Payroll/Staff No." <> '' then begin
            PFNumber := Rec."Payroll/Staff No.";
        end else begin
            PFNumber := Rec."No.";
        end;

        EDMSFunctions.EDMSMemberFileUpload(
            IDNumber,
            Rec.Name,
            ApplicationType,
            PfNumber,
            Rec."No.",
            Rec."No.",
            FileName,
            FileContentsB64
        );
    end;

    var
        GlobalFunctions: Codeunit "Global Functions";
        Outstr: OutStream;
        Templ: Codeunit "Temp Blob";
        instr: InStream;
        MemberApp: Record "Member Application";
        Email: Codeunit Email;
        Emailmsg: Codeunit "Email Message";
        recref: RecordRef;
        EnumScen: Enum "Email Scenario";
        EmailBody: Label 'Dear Member,<Br><P> You have a request to approve.</p><hr>';
        RecoApprover: Text;
        GenSetup: Record "General Set-Up";
        ApplicationDateEdit: Boolean;
        FirstNameEdit: Boolean;
        SecondNameEdit: Boolean;
        LastNameEdit: Boolean;
        AddressEdit: Boolean;
        EmployerEdit: Boolean;
        GlobalDim1Edit: Boolean;
        GlobalDim2Edit: Boolean;
        SalesEdit: Boolean;
        DOBEdit: Boolean;
        IDNoEdit: Boolean;
        PassportNoEdit: Boolean;
        StaffNoEdit: Boolean;
        PINNumberEdit: Boolean;
        BirthCertEdit: Boolean;
        GenderEdit: Boolean;
        MaritalstatusEdit: Boolean;
        //SegmentEdit: Boolean;
        GroupAccountNoEdit: Boolean;
        EmailEdit: Boolean;
        UserAppemail: Text;
        RespCenterEdit: Boolean;
        PhoneEdit: Boolean;
        RelationshipManager: Boolean;
        MobileNoEdit: Boolean;
        PostCodeEdit: Boolean;
        ElectrolZoneEdit: Boolean;
        AreaServiceCenterEdit: Boolean;
        CityEdit: Boolean;
        MemberClassEdit: Boolean;
        NationalityEdit: Boolean;
        CountyEdit: Boolean;
        Text001: Label 'Date of Birth cannot be greater than today.';
        Text002: Label 'This applicant is below the mininmum membership age of %1.';
        BankEdit: Boolean;
        BranchEdit: Boolean;
        ApplicationDocumentEdit: Boolean;
        Approvenry: Record "Approval Entry";
        BankAccountNoEdit: Boolean;
        NextofKINApplication: Record "Next of KIN Application";
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        Text003: Label 'You must provide either ID Number, Passport No., P.I.N Number or Birth Cerificate No.';
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ProductFactory: Record "Product Factory";
        AutoOpenSavingAccs: Record "Savings Account Registration";
        AutoOpenedSavingAccs: Record "Savings Account Registration";
        MemberApplication: Record "Member Application";

        AgentSource: Boolean;
        EditPrinciple: Boolean;
        SelfEmployed: Boolean;
        MemberEmploymentTerm: Boolean;
        Customer: Record Customer;
        EditCountry: Boolean;
        VirtualRegistrations: Record "Virtual Registrations";
        Members: Record Members;
        HREmployees: Record "HR Employees";
        DelegateMemberss: Record "Delegate Members";
        UserSetup: Record "User Setup";
        ValidateDetails: Boolean;
        SendApprovalVisible: Boolean;
        ReopenVisible: Boolean;
        TabsEditable: Boolean;
        DeferVisible: Boolean;
        RejectVisible: Boolean;
        IsNotSentBackToCRM: Boolean;
        IsNotSentBackToMSmart: Boolean;

    //[Scope('Internal')]
    procedure StatusControl()
    begin
        case Rec.Status of
            Rec.Status::Open:
                begin
                    ApplicationDateEdit := true;
                    FirstNameEdit := true;
                    SecondNameEdit := true;
                    LastNameEdit := true;
                    DOBEdit := true;
                    OpenApprovalEntriesExist := true;
                    IDNoEdit := true;
                    PassportNoEdit := true;
                    PINNumberEdit := true;
                    BirthCertEdit := true;
                    StaffNoEdit := true;
                    GenderEdit := true;
                    MaritalstatusEdit := true;
                    //SegmentEdit := true;
                    RespCenterEdit := false;
                    GroupAccountNoEdit := true;
                    MemberClassEdit := true;
                    ElectrolZoneEdit := true;
                    AreaServiceCenterEdit := true;
                    PhoneEdit := true;
                    MobileNoEdit := true;
                    EmailEdit := true;
                    AddressEdit := true;
                    PostCodeEdit := true;
                    CityEdit := false;
                    NationalityEdit := true;
                    CountyEdit := true;
                    RelationshipManager := true;
                    EmployerEdit := true;
                    GlobalDim1Edit := false;
                    GlobalDim2Edit := false;
                    SalesEdit := true;
                    BankEdit := true;
                    BranchEdit := true;
                    BankAccountNoEdit := true;
                    SendApprovalVisible := true;
                    ReopenVisible := false;
                    TabsEditable := true;
                    DeferVisible := true;
                    RejectVisible := true;
                end;

            Rec.Status::Pending, Rec.Status::Approved, Rec.Status::Rejected:
                begin
                    ApplicationDateEdit := false;
                    FirstNameEdit := false;
                    SecondNameEdit := false;
                    LastNameEdit := false;
                    DOBEdit := false;
                    IDNoEdit := false;
                    PassportNoEdit := false;
                    PINNumberEdit := false;
                    BirthCertEdit := false;
                    StaffNoEdit := false;
                    GenderEdit := false;
                    MaritalstatusEdit := false;
                    // SegmentEdit := false;
                    RespCenterEdit := false;
                    GroupAccountNoEdit := false;
                    MemberClassEdit := false;
                    ElectrolZoneEdit := false;
                    AreaServiceCenterEdit := false;

                    PhoneEdit := false;
                    MobileNoEdit := false;
                    EmailEdit := false;
                    AddressEdit := false;
                    PostCodeEdit := false;
                    CityEdit := false;
                    NationalityEdit := false;
                    CountyEdit := false;
                    RelationshipManager := false;

                    EmployerEdit := false;
                    GlobalDim1Edit := false;
                    GlobalDim2Edit := false;
                    SalesEdit := false;

                    BankEdit := false;
                    BranchEdit := false;
                    BankAccountNoEdit := false;
                    SendApprovalVisible := false;
                    ReopenVisible := true;
                    TabsEditable := false;
                end;
        end;

        Rec.CalcFields("Responsible Officer", "Supervisor ID");
        if Rec."No." <> '' then begin
            if (UserId <> Rec."Responsible Officer") and (UserId <> Rec."Supervisor ID") then begin
                TabsEditable := false;
            end;
        end;

        if Rec.Status = Rec.Status::Pending then begin
            DeferVisible := true;
        end;

        if Rec.Status = Rec.Status::Deffered then begin
            DeferVisible := false;
            SendApprovalVisible := false;
            ReopenVisible := true;

        end;
        if Rec.Status = Rec.Status::Archived then begin
            RejectVisible := false;
            SendApprovalVisible := false;
            ReopenVisible := true;

        end;
        if Rec.Status = Rec.Status::Rejected then begin
            ReopenVisible := true;
            SendApprovalVisible := false;
        end;



        AgentSource := false;


        if Rec.Status <> Rec.Status::Open then
            CurrPage.Editable := false;

        if Rec."Recruited by Type" = Rec."Recruited by Type"::Self then
            SalesEdit := false
        else
            SalesEdit := true;

    end;

    procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;


    procedure PrefillDetailsForARejoiningMember()
    var
        Certificate: Record "Certificate Management";
        ImageData: Record "Image Data";
    begin
        if Rec."Principle Member" <> '' then
            if (Rec."Type of Application" = Rec."Type of Application"::Readmission) and (Members.Get(Rec."Principle Member")) then begin
                Rec.Salutation := Members.Salutation;
                Rec."First Name" := Members."First Name";
                Rec."Middle Name" := Members."Middle Name";
                Rec."Other Names" := Members."Other Names";
                Rec.Gender := Members.Gender;
                Rec."Marital Status" := Members."Marital Status";
                Rec."Member Class" := Members."Member Class";
                Rec."Date of Birth" := Members."Date of Birth";
                Rec."Primary Identification Type" := Members."Primary Identification Type";
                Rec."Primary Identification" := Members."Primary Identification";
                Rec."Secondary Identification Type" := Members."Secondary Identification Type";
                Rec."Secondary Identification" := Members."Secondary Identification";
                Rec."P.I.N Number" := Members."P.I.N Number";
                Rec.Religion := Members.Religion;
                Rec."Account Profile" := Members."Account Profile";
                Rec."From Another Sacco" := Members."From Another Sacco";
                Rec.Nationality := Members.Nationality;
                Rec."Post Code" := Members."Post Code";
                Rec."Home Address" := Members."Home Address";
                Rec."Current Address" := Members."Current Address";
                Rec."Phone No." := Members."Phone No.";
                Rec."Office Telephone No." := Members."Office Telephone No.";
                Rec."E-Mail" := Members."E-Mail";
                Rec."Self Employed" := Members."Self Employed";
                Rec."Employer Code" := Members."Employer Code";
                Rec."Employer Name" := Members."Employer Name";
                Rec."Payroll/Staff No." := Members."Payroll/Staff No.";
                Rec."Terms of Employment" := Members."Terms of Employment";
                Rec."Country Of Operation" := Members."Country Of Operation";
                Rec.County := Members.County;
                Rec.City := Members.City;
                Rec."Work Station" := Members."Work Station";
                Rec."Employment Designation" := Members."Employment Designation";
                Rec."Recruited by Type" := Members."Recruited by Type";
                Rec."Recruited By" := Members."Recruited By";
                Rec."Recruited By Name" := Members."Recruited By Name";
                Rec."Delegates Zone" := Members."Delegates Zone";
                Rec."Electrol Zone Descr." := Members."Electrol Zone Descr.";
                Rec."Bank Code" := Members."Bank Code";
                Rec."Branch Code" := Members."Branch Code";
                Rec."Bank Account No." := Members."Bank Account No.";

                ImageData.Reset();
                ImageData.SetRange("Member No", Rec."Principle Member");
                if ImageData.FindFirst() then begin
                    ImageData.CalcFields(Signature, Picture);
                    rec.Signature := ImageData.Signature;
                    rec.Picture := ImageData.Picture;
                end;
            end;
        if (xRec."Type of Application" = Rec."Type of Application"::Readmission) and (Rec."Type of Application" <> Rec."Type of Application"::Readmission) then begin
            Rec."Principle Member" := '';
            Rec.Salutation := '';
            Rec."First Name" := '';
            Rec."Middle Name" := '';
            Rec."Other Names" := '';
            Rec.Gender := Rec.Gender::" ";
            Rec."Marital Status" := Rec."Marital Status"::" ";
            Rec."Member Class" := '';
            Rec."Date of Birth" := 0D;
            Rec."Primary Identification Type" := Rec."Primary Identification Type"::" ";
            Rec."Primary Identification" := '';
            Rec."Secondary Identification Type" := Rec."Secondary Identification Type"::" ";
            Rec."Secondary Identification" := '';
            Rec."P.I.N Number" := '';
            Rec.Religion := '';
            Rec."Account Profile" := Rec."Account Profile"::"Normal Member";
            Rec."From Another Sacco" := false;
            Rec.Nationality := '';
            Rec."Post Code" := '';
            Rec."Home Address" := '';
            Rec."Current Address" := '';
            Rec."Phone No." := '';
            Rec."Office Telephone No." := '';
            Rec."E-Mail" := Members."E-Mail";
            Rec."Self Employed" := false;
            Rec."Employer Code" := '';
            Rec."Employer Name" := '';
            Rec."Payroll/Staff No." := '';
            Rec."Terms of Employment" := Rec."Terms of Employment"::" ";
            Rec."Country Of Operation" := '';
            Rec.County := '';
            Rec.City := '';
            Rec."Work Station" := '';
            Rec."Employment Designation" := '';
            Rec."Recruited by Type" := Rec."Recruited by Type"::"None";
            Rec."Recruited By" := '';
            Rec."Recruited By Name" := '';
            Rec."Delegates Zone" := '';
            Rec."Electrol Zone Descr." := '';
            Rec."Bank Code" := '';
            Rec."Branch Code" := '';
            Rec."Bank Account No." := '';
            Rec."Bank Branch Name" := '';
            Rec."Bank Name" := '';
        end;

        if Rec."Account Type" = Rec."Account Type"::"Single Member Account" then begin
            AutoOpenSavingAccs.Reset();
            AutoOpenSavingAccs.SetRange("No.", Rec."No.");
            if AutoOpenSavingAccs.FindFirst() then AutoOpenSavingAccs.DeleteAll();

            if Rec."Type of Application" <> Rec."Type of Application"::Readmission then begin
                ProductFactory.SetRange(ProductFactory.Status, ProductFactory.Status::Active);
                ProductFactory.SetRange("Product Class Type", ProductFactory."Product Class Type"::Savings);
                ProductFactory.SetRange(ProductFactory."Auto Open Account", true);

                if ProductFactory.FindSet() then begin
                    repeat
                        AutoOpenSavingAccs.Init;
                        AutoOpenSavingAccs."No." := Rec."No.";
                        AutoOpenSavingAccs.Validate(AutoOpenSavingAccs."Product Type", ProductFactory."Product ID");
                        AutoOpenSavingAccs."Monthly Contribution" := ProductFactory."Minimum Contribution";
                        AutoOpenSavingAccs.Insert;
                    until ProductFactory.Next = 0;
                end;
            end;
        end;

        NextofKINApplication.Reset();
        NextofKINApplication.SetRange("Record ID", Rec."No.");
        if NextofKINApplication.FindSet() then NextofKINApplication.DeleteAll();

        Certificate.Reset();
        Certificate.SetRange("Record ID", Rec."No.");
        if Certificate.FindSet() then Certificate.DeleteAll();


    end;


    local procedure CRMControl()
    begin
        if Rec."Source Aplication" = Rec."Source Aplication"::CRM then begin
            if Rec."Sent Back to CRM" then begin
                IsNotSentBackToCRM := false;
            end else begin
                IsNotSentBackToCRM := true;
            end;
        end else begin
            IsNotSentBackToCRM := false;
        end;
    end;

}