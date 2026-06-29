page 52187317 "Member Card Edits"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "System Edits";
    PromotedActionCategories = 'New,Process,Reports,Activities,Approvals,Category7_caption,Category8_caption,Category9_caption,Approvals';


    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = GeneralGroupEditable;
                field(RecordID; RecordID)
                {
                    Visible = false;
                }
                field("Member No"; "Member No")
                {
                    Editable = false;
                }
                field(Salutation; Salutation)
                {
                    ApplicationArea = Basic, Suite;
                    TableRelation = "Salutation Tittles".Code WHERE(Type = CONST(Tittle));
                    Editable = UserCanEditThisValue;

                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 2);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format(Salutation);
                            SystemFilterFields.Validate("New Value");
                            Name := FillNameValue(Salutation, 2);
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }

                field("First Name"; "First Name")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    Editable = UserCanEditThisValue;

                    trigger OnValidate()
                    begin
                        "First Name" := UpperCase("First Name");
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 4);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("First Name");
                            SystemFilterFields.Validate("New Value");
                            Name := FillNameValue("First Name", 4);
                            SystemFilterFields.Modify();
                        end;
                    end;

                }
                field("Middle Name"; "Middle Name")
                {
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    Editable = UserCanEditThisValue;
                    trigger OnValidate()
                    begin
                        "Middle Name" := UpperCase("Middle Name");
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 5);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Middle Name");
                            SystemFilterFields.Validate("New Value");
                            Name := FillNameValue("Middle Name", 5);
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("Other Names"; "Other Names")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = UserCanEditThisValue;

                    trigger OnValidate()
                    begin
                        "Other Names" := UpperCase("Other Names");
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 6);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Other Names");
                            SystemFilterFields.Validate("New Value");
                            Name := FillNameValue("Other Names", 6);
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("Primary Identification Type"; "Primary Identification Type")
                {
                    Editable = UserCanEditThisValue;

                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 58);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Primary Identification Type");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("Primary Identification"; "Primary Identification")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = UserCanEditThisValue;
                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 70);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Primary Identification");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }

                field("Secondary Identification Type"; "Secondary Identification Type")
                {
                    Editable = UserCanEditThisValue;

                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 59);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Secondary Identification Type");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("Secondary Identification"; "Secondary Identification")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 71);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Secondary Identification");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }

                field("P.I.N Number"; "P.I.N Number")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = UserCanEditThisValue;
                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 55);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("P.I.N Number");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("Date of Birth"; "Date of Birth")
                {

                    ApplicationArea = Basic, Suite;
                    Caption = 'Date Of birth';
                    Editable = true;
                    Visible = true;
                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 39);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Date of Birth");
                            SystemFilterFields.Validate("New Value");
                            Age := FillAge("Date of Birth", 39);
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field(Age; Age)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Age';
                    Editable = false;
                    Visible = true;
                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 91);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Age");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }

                field(Gender; Gender)
                {
                    ApplicationArea = Basic, Suite;
                    ValuesAllowed = Male, Female;
                    Editable = UserCanEditThisValue;
                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 42);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format(Gender);
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("Account Profile"; "Account Profile")
                {
                    Editable = UserCanEditThisValue;

                    trigger OnValidate()
                    var
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 49);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Account Profile");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("Marital Status"; "Marital Status")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    Caption = 'Marital Status';
                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 41);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Marital Status");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }

                field("From Another Sacco"; "From Another Sacco")
                {
                    Editable = UserCanEditThisValue;

                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 72);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("From Another Sacco");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("Member Class"; "Member Class")
                {
                    Editable = UserCanEditThisValue;

                    TableRelation = "Member Classes"."No.";
                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 47);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Member Class");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;

                }
                field("Sub Class"; "Sub Class")
                {
                    TableRelation = "Sub Classes"."Sub Class";
                    Editable = UserCanEditThisValue;

                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 1031);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Sub Class");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;

                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    TableRelation = "Responsibility CenterBR";
                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 26);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Responsibility Center");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;

                }
                field(Status; Status)
                {

                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 28);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format(Status);
                            SystemFilterFields."Generally Edited" := true;
                            // SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field(Subflag; Subflag)
                {
                    Caption = 'Sub Status';
                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 29);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format(Subflag);
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;

                }
                field(Blocked; Blocked)
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 16);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format(Blocked);
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }

                field("Account Type"; "Account Type")
                {
                    Editable = UserCanEditThisValue;

                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 48);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Account Type");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }


                field("Account Category"; "Account Category")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 43);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Account Category");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }

                field("Has Joined Business Loans"; "Has Joined Business Loans")
                {
                    Visible = false;

                    Editable = false;
                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 83);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Has Joined Business Loans");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }

            }
            group("Communication ")
            {
                Editable = ComunicationGroupEditable;
                field(Nationality; Nationality)
                {
                    ApplicationArea = Basic, Suite;
                    TableRelation = "Country/Region";
                    trigger OnValidate()
                    var
                        CountryRegion: Record "Country/Region";
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 14);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format(Nationality);
                            // SystemFilterFields.Validate("New Value");
                            if SystemFilterFields."Old Value" <> SystemFilterFields."New Value" then
                                SystemFilterFields."Generally Edited" := true;
                            if CountryRegion.Get(Nationality) then begin
                                if CopyStr("Phone No.", 1, 3) <> CopyStr(CountryRegion."County Phone Code", 1, 4) then begin
                                    if StrLen("Phone No.") < 12 then
                                        "Phone No." := CopyStr((CountryRegion."County Phone Code" + "Phone No."), 1, 12);
                                end;

                                "Phone No." := CountryRegion."County Phone Code";
                                "Transactional Mobile Number" := CountryRegion."County Phone Code";
                            end;
                            SystemFilterFields.Modify();
                        end;
                    end;

                }
                field(County; County)
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST(County));
                    trigger OnValidate()
                    var
                        Counties: Record "Segment/County/Dividend/Signat";
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 32);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format(County);
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;

                        Counties.Reset();
                        Counties.SetRange(Code, County);
                        if Counties.FindFirst() then
                            City := Counties.Description;
                    end;

                }
                field("Post Code"; "Post Code")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    Caption = 'Post Code/City';
                    TableRelation = "Post Code";
                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 22);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Post Code");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field(City; City)
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 38);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format(City);
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("Permanent Post Code"; "Permanent Post Code")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    TableRelation = "Post Code";
                    trigger OnValidate()
                    var
                        PostCode: Record "Post Code";
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 644);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Permanent Post Code");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;

                        PostCode.Reset();
                        PostCode.SetRange(Code, "Permanent Post Code");
                        if PostCode.FindFirst() then
                            "Permanent City" := PostCode.City;
                    end;
                }
                field("Permanent City"; "Permanent City")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 645);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Permanent City");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }

                field("Current Address"; "Current Address")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 7);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Current Address");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("Home Address"; "Home Address")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 8);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Home Address");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("Phone No."; "Phone No.")
                {

                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    trigger OnValidate()
                    var
                        CountryRegion: Record "Country/Region";
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 9);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Phone No.");
                            if SystemFilterFields."Old Value" <> SystemFilterFields."New Value" then
                                SystemFilterFields."Generally Edited" := true;
                            if CountryRegion.Get(Nationality) then begin
                                if CountryRegion."County Phone Code" <> CopyStr("Phone No.", 1, StrLen(CountryRegion."County Phone Code")) then
                                    Error('Phone No must start with %1.', CountryRegion."County Phone Code");
                            end;
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("Transactional Mobile Number"; "Transactional Mobile Number")
                {

                    Editable = UserCanEditThisValue;
                    trigger OnValidate()
                    var
                        CountryRegion: Record "Country/Region";
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 89);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Transactional Mobile Number");

                            if CountryRegion.Get(Nationality) then begin
                                if CountryRegion."County Phone Code" <> CopyStr("Transactional Mobile Number", 1, StrLen(CountryRegion."County Phone Code")) then
                                    Error('Phone No must start with %1.', CountryRegion."County Phone Code");
                            end;
                            if SystemFilterFields."Old Value" <> SystemFilterFields."New Value" then
                                SystemFilterFields."Generally Edited" := true;
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("Office Telephone No."; "Office Telephone No.")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = all;
                    Caption = 'Office Telephone No.';
                    trigger OnValidate()
                    var
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 10);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Office Telephone No.");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }

                field("E-Mail"; "E-Mail")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 23);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("E-Mail");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
            }

            group("Other Information")
            {

                Editable = OtherInfoGroupEditable;
                field("Self Employed"; "Self Employed")
                {
                    Editable = UserCanEditThisValue;

                    trigger OnValidate()
                    var
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 30);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Self Employed");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("Employer Code"; "Employer Code")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    TableRelation = Customer WHERE("Account Type" = CONST("Employer code"));
                    trigger OnValidate()
                    var
                        Customer: Record Customer;
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 31);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Employer Code");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();

                            if Customer.Get("Employer Code") then begin
                                "Employer Name" := Customer.Name;
                            end;
                        end;
                    end;

                }
                field("Employer Name"; "Employer Name")
                {

                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Payroll/Staff No"; "Payroll/Staff No.")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 40);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Payroll/Staff No.");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("Allow Retiree M-Loans"; "Allow Retiree M-Loans")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 1046);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Allow Retiree M-Loans");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("Staff/PF No."; "Staff/PF No.")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 93);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Staff/PF No.");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }

                field("Contribution Mode"; "Contribution Mode")
                {
                    Editable = UserCanEditThisValue;

                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 607);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Contribution Mode");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    Editable = UserCanEditThisValue;

                    Caption = 'Branch Code';
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                    trigger OnValidate()
                    var
                        DimVal: Record "Dimension Value";
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 11);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Global Dimension 1 Code");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;

                        DimVal.reset;
                        DimVal.SetRange(Code, "Global Dimension 1 Code");
                        if DimVal.find('-') then
                            "Branch Name" := DimVal.Name;
                    end;

                }
                field("Branch Name"; "Branch Name")
                {

                    Editable = false;
                }

                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    Editable = UserCanEditThisValue;

                    Caption = 'Activity Code';
                    ApplicationArea = Basic, Suite;
                    ShowMandatory = true;
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
                    trigger OnValidate()
                    var
                        DimVal: Record "Dimension Value";
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 12);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Global Dimension 2 Code");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;

                        DimVal.reset;
                        DimVal.SetRange(Code, "Global Dimension 2 Code");
                        if DimVal.find('-') then
                            "Activity Name" := DimVal.Name;
                    end;
                }
                field("Activity Name"; "Activity Name")
                {
                    Editable = false;
                }

                // field("Recruited by Type"; "Recruited by Type")
                // {
                //     Editable = UserCanEditThisValue;

                //     ApplicationArea = Basic, Suite;
                //     trigger OnValidate()
                //     begin
                //         SystemFilterFields.Reset();
                //         SystemFilterFields.SetRange("Record ID", RecordID);
                //         SystemFilterFields.SetRange("Field ID", 82);
                //         if SystemFilterFields.FindFirst() then begin
                //             SystemFilterFields."New Value" := Format("Recruited by Type");
                //             SystemFilterFields.Validate("New Value");
                //             SystemFilterFields.Modify();
                //         end;
                //     end;
                // }
                // field("Recruited By"; "Recruited By")
                // {
                //     Editable = UserCanEditThisValue;

                //     ApplicationArea = Basic, Suite;
                //     TableRelation = Members."No.";
                //     trigger OnValidate()
                //     begin
                //         SystemFilterFields.Reset();
                //         SystemFilterFields.SetRange("Record ID", RecordID);
                //         SystemFilterFields.SetRange("Field ID", 80);
                //         if SystemFilterFields.FindFirst() then begin
                //             SystemFilterFields."New Value" := Format("Recruited By");
                //             SystemFilterFields.Validate("New Value");
                //             SystemFilterFields.Modify();
                //         end;
                //     end;
                // }
                field("Introducer's Name"; "Recruited By Name")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                }
                field("Delegates Zone"; "Delegates Zone")
                {
                    Editable = UserCanEditThisValue;

                    TableRelation = "Electrol Zones/Area Svr Center".Code WHERE(Type = CONST("Electral Zone"));
                    ShowMandatory = true;
                    trigger OnValidate()
                    var
                        ElectrolZonesAreaSvrCenter: Record "Electrol Zones/Area Svr Center";

                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 39004243);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Delegates Zone");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;

                        ElectrolZonesAreaSvrCenter.Reset;
                        ElectrolZonesAreaSvrCenter.SetRange(ElectrolZonesAreaSvrCenter.Code, "Delegates Zone");
                        if ElectrolZonesAreaSvrCenter.Find('-') then begin
                            "Electrol Zone Descr." := ElectrolZonesAreaSvrCenter.Description;
                        end;
                    end;
                }
                field("Electrol Zone Descr."; "Electrol Zone Descr.")
                {
                    Editable = false;
                }

            }
            group("Bank Details")
            {
                Editable = BankDetailsEditable;
                field("Bank Code";
                "Bank Code")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    TableRelation = "Bank Code Structure";
                    trigger OnValidate()
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 58);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Primary Identification Type");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;

                }
                field("Branch Code"; "Branch Code")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    TableRelation = "Bank Code Structure".Code where(Type = const(Branch));
                    trigger OnValidate()
                    var
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 53);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Branch Code");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;

                }
                field("Bank Account No."; "Bank Account No.")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    trigger OnValidate()
                    var
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 54);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("Bank Account No.");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
            }
            group("Business Loan Details")
            {
                Editable = BusinessLoanEditable;
                Visible = false;
                field("BL Global Dimension 1 Code"; "BL Global Dimension 1 Code")
                {
                    ApplicationArea = Basic, Suite;
                    CaptionClass = '1,1,1';
                    Caption = 'Global Dimension 1 Code';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                    trigger OnValidate()
                    var
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 1019);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("BL Global Dimension 1 Code");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("BL Global Dimension 2 Code"; "BL Global Dimension 2 Code")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    CaptionClass = '1,1,2';
                    Caption = 'Global Dimension 2 Code';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
                    trigger OnValidate()
                    var
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 1020);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("BL Global Dimension 2 Code");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("BL Responsibility Center"; "BL Responsibility Center")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    Caption = 'Responsibility Center';
                    TableRelation = "Responsibility CenterBR";
                    trigger OnValidate()
                    var
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 1021);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("BL Responsibility Center");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("BL Created By"; "BL Created By")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    Caption = 'Created By';
                    trigger OnValidate()
                    var
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 1022);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("BL Created By");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("BL Registration Date"; "BL Registration Date")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Registration Date';
                    Visible = false;
                    Editable = UserCanEditThisValue;

                    trigger OnValidate()
                    var
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 1023);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("BL Registration Date");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("BL Type of Business"; "BL Type of Business")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    Caption = 'Type of Business';
                    trigger OnValidate()
                    var
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 1024);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("BL Type of Business");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("BL Business Location"; "BL Business Location")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    Caption = 'Business Location';
                    trigger OnValidate()
                    var
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 1025);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("BL Business Location");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("BL Relationship Manager"; "BL Relationship Manager")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    Caption = 'Relationship Manager';
                    // TableRelation = "HR Employees" WHERE(Status = FILTER(Active), "Global Dimension 2 Code" = field("Global Dimension 2 Code"));
                    TableRelation = "HR Employees" WHERE(Status = FILTER(Active));

                    trigger OnValidate()
                    var
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 1026);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("BL Relationship Manager");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("BL Wholesale/Retail"; "BL Wholesale/Retail")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    Caption = 'Wholesale/Retail';
                    trigger OnValidate()
                    var
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 1027);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("BL Wholesale/Retail");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("BL Current Capital"; "BL Current Capital")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    Caption = 'Current Capital';

                    trigger OnValidate()
                    var
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 1028);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("BL Current Capital");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("BL No. of Employees"; "BL No. of Employees")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    Caption = 'No. of Employees';
                    trigger OnValidate()
                    var
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 1029);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("BL No. of Employees");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
                field("BL Annual Turnover"; "BL Annual Turnover")
                {
                    Editable = UserCanEditThisValue;

                    ApplicationArea = Basic, Suite;
                    Caption = 'Annual Turnover';
                    trigger OnValidate()
                    var
                    begin
                        SystemFilterFields.Reset();
                        SystemFilterFields.SetRange("Record ID", RecordID);
                        SystemFilterFields.SetRange("Field ID", 1030);
                        if SystemFilterFields.FindFirst() then begin
                            SystemFilterFields."New Value" := Format("BL Annual Turnover");
                            SystemFilterFields.Validate("New Value");
                            SystemFilterFields.Modify();
                        end;
                    end;
                }
            }


            group("Edits Details")
            {
                Editable = EditsDetailsEditale;
                field("Edits Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = false;
                }
                field("Edits Reason"; Rec."Edits Reason")
                {
                    TableRelation = "System Edit Reasons" where("Responsibility Center" = field("Responsibility Center"));
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    Editable = false;
                }
                field(Comments; Rec.Comments)
                {

                }
                field("Edits Status"; Rec.Status)
                {
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    Editable = false;
                }
            }
            group("SMS Area")
            {
                field(SMSArea; SMSArea)
                {
                    Caption = 'Write an SMS';
                    MultiLine = true;
                }
                field(PhoneNumber; PhoneNumber)
                {
                    Caption = 'Send to Phone Number';
                }
            }

        }
    }


    actions
    {
        area(Creation)
        {

            action("Open This Edit")
            {
                ApplicationArea = Basic, Suite;
                Image = OpenWorksheet;
                Promoted = true;

                trigger OnAction()
                var
                begin
                    if SystemEdits.Get(Rec."No.") then
                        Page.Run(52187081, SystemEdits);
                end;
            }

            action("Open Edit Card")
            {
                ApplicationArea = Basic, Suite;
                Image = Process;
                Promoted = true;


                trigger OnAction()
                var
                begin

                    if SystemEdits.Get(Rec."No.") then
                        Page.Run(52187317, SystemEdits);
                end;

            }
            action("Send SMS")
            {
                ApplicationArea = Basic, Suite;
                Image = Process;
                Promoted = true;


                trigger OnAction()
                var
                    SendSMS: Codeunit SendSms;
                    Source: enum "SMS Source";
                begin
                    if PhoneNumber = '' then Error('Please add a phone number');
                    if SMSArea = '' then Error('Please write an SMS');
                    SendSMS.SendSms(Source::MEMBER_CHANGES, PhoneNumber, SMSArea, RecordID, RecordID, false, 211, false, 'CBS', '', 'CBS');
                    Message('SMS Sent successfully');
                end;

            }

            action("Record Fields")
            {
                ApplicationArea = all;
                Image = EditList;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "System Edits Fields";
                RunPageLink = "Record ID" = FIELD("No.");
                RunPageMode = View;
            }
            action("Post Changes")
            {
                ApplicationArea = all;
                Image = PostDocument;
                Promoted = true;
                PromotedCategory = Process;
                Enabled = PostChangesEnabled;

                trigger OnAction()
                var
                    SystemEditsCodeunit: Codeunit "System Editss";
                    Action: Option SetFilter,PostChanges;
                    CRMMemberEdit: Record "CRM Member Edit";
                    MSmartMemberEdit: Record "M-Smart Member Edit";
                begin
                    GetSystemEdits();
                    if SystemEdits.Status <> SystemEdits.Status::Approved then error('The status has to be approved');
                    if SystemEdits.Posted then Error('This record has already been posted');

                    if SystemEdits."Table ID" = 52185700 then
                        SystemEditsCard.SMSMemberOnChange(SystemEdits);

                    Message(SystemEditsCodeunit.SetFilterFields(SystemEdits."Table ID", SystemEdits."No.", Action::PostChanges, RecRef, RecRef));


                    SystemEdits.Posted := true;
                    SystemEdits."Posted By" := UserId;
                    SystemEdits."Posting Date" := CurrentDateTime;
                    if CRMMemberEdit.Get(SystemEdits."CRM No") then begin
                        CRMMemberEdit."Change Complete" := true;
                        CRMMemberEdit.Status := CRMMemberEdit.Status::Approved;
                        CRMMemberEdit.Modify(true);
                    end;

                    if MSmartMemberEdit.Get(SystemEdits."M-Smart No") then begin
                        MSmartMemberEdit."Change Complete" := true;
                        MSmartMemberEdit.Status := MSmartMemberEdit.Status::Approved;
                        MSmartMemberEdit.Modify(true);
                    end;
                    SystemEdits.Modify();
                end;

            }

        }

        area(processing)
        {
            group(Workflows)
            {
                Caption = 'Approval';

                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    Visible = SendApprovalVisible;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        JuniorError: Label 'You must specify either %1 %2 for %3';
                        IDJunior: Code[20];
                        ProductApplicationDocuments: Record "Product Documents";
                        ApplicationDocuments: Record "Application Documents";
                    begin
                        GetSystemEdits();
                        SystemEdits.TestField("Table ID");
                        SystemEdits.TestField("Edits Reason");
                        VarVariant := SystemEdits;
                        if CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) then begin
                            CustomApprovals.OnSendDocForApproval(VarVariant);
                        end;
                    end;
                }
                action(Approve)
                {
                    ApplicationArea = Basic, Suite;
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
                        SystemEdits.TestField(SystemEdits.Status, SystemEdits.Status::Pending);
                        ApprovalsMgmt.ApproveRecordApprovalRequest(SystemEdits.RecordId);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        GetSystemEdits();
                        SystemEdits.TestField(SystemEdits.Status, SystemEdits.Status::Pending);
                        VarVariant := SystemEdits;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                    end;
                }


                action(Reject)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Enabled = OpenApprovalEntriesExist;
                    // Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

                    begin
                        if not Confirm('Are you sure you want to reject this request?') then exit;
                        SystemEdits.TestField(SystemEdits.Status, SystemEdits.Status::Pending);
                        ApprovalsMgmt.RejectRecordApprovalRequest(SystemEdits.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic, Suite;
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
                        SystemEdits.TestField(SystemEdits.Status, SystemEdits.Status::Pending);
                        ApprovalsMgmt.DelegateRecordApprovalRequest(SystemEdits.RecordId);
                    end;
                }

                action(Approvals)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approvals';
                    Image = Approvals;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(SystemEdits.RecordId);
                    end;
                }
                action(Return)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Return Card';
                    Image = ReOpen;
                    Visible = ReopenVisible;

                    trigger OnAction()
                    var

                    begin

                        GetSystemEdits();
                        GlobalFunctions.CommentsManagement(RecordID);
                        //GlobalFunctions.CancelApprovalManually(SystemEdits.RecordId);
                        if Rec.Status = Rec.Status::Pending then begin
                            VarVariant := Rec;
                            CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                        end;

                        CurrPage.Update();
                    end;
                }
                // action(Commentss)
                // {
                //     ApplicationArea = Basic, Suite;
                //     Image = ViewComments;
                //     Promoted = true;
                //     Caption = 'Comment';

                //     RunObject = page "Comments List";
                //     RunPageLink = "Header No." = field();
                //     RunPageView = where(Types = CONST(comment));
                // }
                action(Deffer)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Deffer Application';
                    Image = ReOpen;
                    Visible = DeferVisible;

                    trigger OnAction()
                    var

                    begin
                        GetSystemEdits();
                        GlobalFunctions.CommentsManagement(SystemEdits."No.");
                        if not SystemEdits.Posted then begin
                            if not Confirm('Are you sure you want to deffer this record?') then exit;

                            if Rec.Status = Rec.Status::Pending then begin
                                VarVariant := Rec;
                                CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                            end;

                            SystemEdits.Status := SystemEdits.Status::Deffered;
                            SystemEdits.Validate(Status);
                            SystemEdits.Modify();

                            Message('Record deffered succsessfully');
                        end else
                            Error('You cannot deffer a posted record');
                    end;
                }
                action(Archive)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Archive Application';
                    Image = Archive;
                    Visible = DeferVisible;

                    trigger OnAction()
                    var

                    begin
                        GetSystemEdits();
                        GlobalFunctions.CommentsManagement(SystemEdits."No.");
                        if not SystemEdits.Posted then begin
                            if not Confirm('Are you sure you want to archive this record?') then exit;

                            if Rec.Status = Rec.Status::Pending then begin
                                VarVariant := Rec;
                                CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                            end;

                            SystemEdits.Status := SystemEdits.Status::Archived;
                            SystemEdits.Validate(Status);
                            SystemEdits.Modify();
                            Message('Record archive succsessfully');
                        end else
                            Error('You cannot archive a posted record');
                    end;
                }

                // group(TaskAssignment)
                // {
                //     Caption = 'Assign Task';
                //     action(AssinedUser)
                //     {
                //         ApplicationArea = all;
                //         Image = Task;
                //         Promoted = true;
                //         PromotedCategory = Process;
                //         RunObject = Page "User Tasks";
                //         RunPageLink = "Record ID" = FIELD();
                //         Caption = 'User Assigned';
                //     }
                // }
            }
        }
    }


    trigger OnOpenPage()
    var
        Customer: Record Customer;
        UserSetup: Record "User Setup";
    begin
        UserCanEditThisValue := true;
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst() then
            if UserSetup."Responsibility Centre" = 'DMU' then
                UserCanEditThisValue := false;

        GetSystemEdits();
        getControl();
        RecordID := Rec."No.";

        SystemFilterFields.Reset();
        SystemFilterFields.SetRange("Record ID", RecordID);
        if SystemFilterFields.Find('-') then begin
            repeat
                FieldRef := SystemEditsCodeunit.AssignFieldRefValue(52185700, '', SystemFilterFields."Field ID");
                if SystemFilterFields."Generally Edited" then
                    ConfigValidateMgt.EvaluateTextToFieldRef(SystemFilterFields."New Value", FieldRef, false)
                else
                    ConfigValidateMgt.EvaluateTextToFieldRef(SystemFilterFields."Old Value", FieldRef, false);

                if SystemFilterFields."Field ID" = 1 then begin
                    "Member No" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 2 then begin
                    Salutation := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 3 then begin
                    Name := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 4 then begin
                    "First Name" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 5 then begin
                    "Middle Name" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 6 then begin
                    "Other Names" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 6 then begin
                    "Other Names" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 49 then begin
                    "Account Profile" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 58 then begin
                    "Primary Identification Type" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 59 then begin
                    "Secondary Identification Type" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 70 then begin
                    "Primary Identification" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 71 then begin
                    "Secondary Identification" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 55 then begin
                    "P.I.N Number" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 39 then begin
                    "Date of Birth" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 91 then begin
                    Age := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 42 then begin
                    Gender := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 41 then begin
                    "Marital Status" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 72 then begin
                    "From Another Sacco" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 47 then begin
                    "Member Class" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 26 then begin
                    "Responsibility Center" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 40 then begin
                    "Payroll/Staff No." := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 28 then begin
                    Status := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 29 then begin
                    Subflag := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 16 then begin
                    Blocked := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 48 then begin
                    "Account Type" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 43 then begin
                    "Account Category" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 83 then begin
                    "Has Joined Business Loans" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 14 then begin
                    Nationality := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 32 then begin
                    County := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 22 then begin
                    "Post Code" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 38 then begin
                    City := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 644 then begin
                    "Permanent Post Code" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 645 then begin
                    "Permanent City" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 7 then begin
                    "Current Address" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 8 then begin
                    "Home Address" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 9 then begin
                    "Phone No." := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 89 then begin
                    "Transactional Mobile Number" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 23 then begin
                    "E-Mail" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 31 then begin
                    "Employer Code" := FieldRef.Value;
                    if Customer.Get("Employer Code") then begin
                        "Employer Name" := Customer.Name;
                    end;
                end;
                if SystemFilterFields."Field ID" = 40 then begin
                    "Payroll/Staff No." := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 1046 then begin
                    "Allow Retiree M-Loans" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 93 then begin
                    "Staff/PF No." := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 607 then begin
                    "Contribution Mode" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 11 then begin
                    "Global Dimension 1 Code" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 12 then begin
                    "Global Dimension 2 Code" := FieldRef.Value;
                end;

                if SystemFilterFields."Field ID" = 80 then begin
                    "Recruited By" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 82 then begin
                    "Recruited by Type" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 52 then begin
                    "Bank Code" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 53 then begin
                    "Branch Code" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 54 then begin
                    "Bank Account No." := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 39004243 then begin
                    "Delegates Zone" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 10 then begin
                    "Office Telephone No." := FieldRef.Value;
                end;

                //BUSINESS LOANS
                if SystemFilterFields."Field ID" = 1019 then begin
                    "BL Global Dimension 1 Code" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 1020 then begin
                    "BL Global Dimension 2 Code" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 1021 then begin
                    "BL Responsibility Center" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 1022 then begin
                    "BL Created By" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 1023 then begin
                    "BL Registration Date" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 1024 then begin
                    "BL Type of Business" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 1025 then begin
                    "BL Business Location" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 1026 then begin
                    "BL Relationship Manager" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 1027 then begin
                    "BL Wholesale/Retail" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 1028 then begin
                    "BL Current Capital" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 1029 then begin
                    "BL No. of Employees" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 1030 then begin
                    "BL Annual Turnover" := FieldRef.Value;
                end;
                if SystemFilterFields."Field ID" = 1031 then begin
                    "Sub Class" := FieldRef.Value;
                end;


            until SystemFilterFields.Next() = 0;
        end;

    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        getControl();
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        getControl();
    end;

    procedure GetSystemEdits()
    begin
        SystemEdits.Get(Rec."No.");
    end;

    procedure getControl()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        if Rec.Status = Rec.Status::Open then begin
            PostChangesEnabled := false;
            SendApprovalVisible := true;
            OpenApprovalEntriesExist := false;
            OpenApprovalEntriesExistForCurrUser := false;
            ReopenVisible := false;
            GeneralGroupEditable := true;
            ComunicationGroupEditable := true;
            OtherInfoGroupEditable := true;
            BankDetailsEditable := true;
            EditsDetailsEditale := true;
            BusinessLoanEditable := true;

            EditsHelper.Reset();
            EditsHelper.SetRange("Edits Header No.", RecordID);
            if EditsHelper.FindFirst() then begin
                if EditsHelper."Edit Type" = EditsHelper."Edit Type"::"Business Loan" then begin
                    GeneralGroupEditable := false;
                    ComunicationGroupEditable := false;
                    OtherInfoGroupEditable := false;
                    BankDetailsEditable := false;
                    BusinessLoanEditable := true;
                end;
                if EditsHelper."Edit Type" = EditsHelper."Edit Type"::Records then begin
                    BusinessLoanEditable := false;
                end;
            end;
        end;
        if Rec.Status = Rec.Status::Pending then begin
            PostChangesEnabled := false;
            SendApprovalVisible := false;
            ReopenVisible := true;
            GeneralGroupEditable := false;
            ComunicationGroupEditable := false;
            OtherInfoGroupEditable := false;
            BankDetailsEditable := false;
            EditsDetailsEditale := false;
            BusinessLoanEditable := false;

        end;
        if Rec.Status = Rec.Status::Approved then begin
            PostChangesEnabled := true;
            SendApprovalVisible := false;
            ReopenVisible := true;
            GeneralGroupEditable := false;
            ComunicationGroupEditable := false;
            OtherInfoGroupEditable := false;
            BankDetailsEditable := false;
            EditsDetailsEditale := false;
            BusinessLoanEditable := false;

        end;
        if Rec.Status = Rec.Status::Rejected then begin
            PostChangesEnabled := false;
            SendApprovalVisible := false;
            ReopenVisible := false;
            GeneralGroupEditable := false;
            ComunicationGroupEditable := false;
            OtherInfoGroupEditable := false;
            BankDetailsEditable := false;
            EditsDetailsEditale := false;
            BusinessLoanEditable := false;

        end;
        if Rec.Posted then begin
            PostChangesEnabled := false;
            SendApprovalVisible := false;
            ReopenVisible := false;
            GeneralGroupEditable := false;
            ComunicationGroupEditable := false;
            OtherInfoGroupEditable := false;
            BankDetailsEditable := false;
            EditsDetailsEditale := false;
            BusinessLoanEditable := false;

        end;
    end;

    local procedure FillNameValue(NameParam: Text; Position: Integer): Text
    var
        Salute: Text;
        First: Text;
        Middle: text;
        Other: Text;
    begin
        SystemFilterFieldsII.Reset();
        SystemFilterFieldsII.SetRange("Record ID", RecordID);
        SystemFilterFieldsII.SetRange("Field ID", 2);
        if SystemFilterFieldsII.FindFirst() then begin
            Salute := SystemFilterFieldsII."New Value";
        end;

        if Position = 2 then Salute := NameParam;

        SystemFilterFieldsII.Reset();
        SystemFilterFieldsII.SetRange("Record ID", RecordID);
        SystemFilterFieldsII.SetRange("Field ID", 4);
        if SystemFilterFieldsII.FindFirst() then begin
            First := SystemFilterFieldsII."New Value";
        end;

        if Position = 4 then First := NameParam;

        SystemFilterFieldsII.Reset();
        SystemFilterFieldsII.SetRange("Record ID", RecordID);
        SystemFilterFieldsII.SetRange("Field ID", 5);
        if SystemFilterFieldsII.FindFirst() then begin
            Middle := SystemFilterFieldsII."New Value";
        end;

        if Position = 5 then Middle := NameParam;

        SystemFilterFieldsII.Reset();
        SystemFilterFieldsII.SetRange("Record ID", RecordID);
        SystemFilterFieldsII.SetRange("Field ID", 6);
        if SystemFilterFieldsII.FindFirst() then begin
            Other := SystemFilterFieldsII."New Value";
        end;

        if Position = 6 then Other := NameParam;

        SystemFilterFieldsII.Reset();
        SystemFilterFieldsII.SetRange("Record ID", RecordID);
        SystemFilterFieldsII.SetRange("Field ID", 3);
        if SystemFilterFieldsII.FindFirst() then begin
            SystemFilterFieldsII."New Value" := Format(Salute + ' ' + First + ' ' + Middle + ' ' + Other);
            SystemFilterFieldsII.Validate("New Value");
            SystemFilterFieldsII.Modify();
        end;

        exit(Salute + ' ' + First + ' ' + Middle + ' ' + Other);
    end;

    local procedure FillAge(DateofBirth: Date; Position: Integer): Integer
    var
        MemberAge: Integer;
        NewBirthDate: Date;
    begin
        // Get existing Date of Birth
        SystemFilterFieldsII.Reset();
        SystemFilterFieldsII.SetRange("Record ID", RecordID);
        SystemFilterFieldsII.SetRange("Field ID", 39); // Date of Birth
        if SystemFilterFieldsII.FindFirst() then begin
            Evaluate(SystemFilterFieldsII."New Value", Format(DateofBirth));
        end;

        if Position = 39 then NewBirthDate := DateofBirth;

        // Calculate Age
        if NewBirthDate <> 0D then begin
            MemberAge := Date2DMY(Today, 3) - Date2DMY(NewBirthDate, 3);
        end
        else
            MemberAge := 0;
        // Update Age Field (Field ID = 91)
        SystemFilterFieldsII.Reset();
        SystemFilterFieldsII.SetRange("Record ID", RecordID);
        SystemFilterFieldsII.SetRange("Field ID", 91);
        if SystemFilterFieldsII.FindFirst() then begin
            SystemFilterFieldsII.Validate("New Value", Format(MemberAge));
            SystemFilterFieldsII.Modify();
        end;
        exit(MemberAge);
    end;

    var
        SystemEdits: Record "System Edits";
        VarVariant: Variant;
        CustomApprovals: Codeunit "Custom Approvals Codeunit";
        SystemEditsCodeunit: Codeunit "System Editss";
        GlobalFunctions: Codeunit "Global Functions";
        SystemEditsCard: Page "System Edits Card";
        ConfigValidateMgt: Codeunit "Config. Validate Management";
        FieldRef: FieldRef;
        RecRef: RecordRef;


        PostChangesEnabled: Boolean;
        SendApprovalVisible: Boolean;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        ReopenVisible: Boolean;
        DeferVisible: Boolean;
        GeneralGroupEditable: Boolean;
        ComunicationGroupEditable: Boolean;
        OtherInfoGroupEditable: Boolean;
        BankDetailsEditable: Boolean;
        EditsDetailsEditale: Boolean;
        BusinessLoanEditable: Boolean;

        SMSArea: Text;
        PhoneNumber: Text;

        "Member No": Code[50];
        Salutation: code[30];
        Name: text;
        "First Name": Text;
        "Middle Name": text;
        "Other Names": Text;
        "Primary Identification": Code[30];
        "Primary Identification Type": Enum "Identification Type";
        "Secondary Identification Type": Enum "Identification Type";
        "Secondary Identification": Code[30];
        "P.I.N Number": Code[50];
        "Date of Birth": Date;
        Age: Integer;
        Gender: enum Gender;
        "Marital Status": Enum "Marital Status";
        "From Another Sacco": Boolean;
        "Member Class": Code[50];
        "Responsibility Center": Code[50];
        "Payroll/Staff No.": Code[50];
        Status: Enum "Member Status";
        Subflag: Enum "Member Status Sub Flags";
        Blocked: Option " ",Credit,Debit,All;
        "Account Type": Option "Single Member Account","Group Account";
        "Account Category": enum "Account Category";
        "Has Joined Business Loans": Boolean;
        Nationality: Code[10];
        County: Text[30];
        "Post Code": Code[20];
        City: Text[30];
        "Permanent City": Text[30];
        "Permanent Post Code": Code[20];
        "Current Address": Text[50];
        "Home Address": Text[50];
        "Transactional Mobile Number": Text[30];
        "E-Mail": Text;
        "Employer Code": Code[100];
        "Allow Retiree M-Loans": Boolean;
        "Employer Name": Text;
        "Staff/PF No.": Code[20];
        "Contribution Mode": Option Salary,"Check off","Direct Debit",Cash,Pension,Dividend,Others;
        "Global Dimension 1 Code": Code[20];
        "Branch Name": Text;
        "Global Dimension 2 Code": Code[20];
        "Activity Name": Text;
        "Recruited by Type": Enum "Recruited By";
        "Recruited By": Code[10];
        "Recruited By Name": Text;
        "Bank Code": code[20];
        "Branch Code": Code[20];
        "Bank Account No.": Code[20];
        RecordID: Code[30];
        "Edits Reason": Code[50];
        "Reason Description": Text;
        "Electrol Zone Descr.": Text;


        "Delegates Zone": Code[20];
        "Phone No.": Text[80];
        "Office Telephone No.": Code[50];
        "Self Employed": Boolean;
        "Sub Class": Code[50];


        //BUSINESS LOAN MEMBERS
        "BL Global Dimension 1 Code": Code[20];
        "BL Global Dimension 2 Code": Code[20];
        "BL Responsibility Center": Code[10];
        "BL Created By": Code[50];
        "BL Registration Date": Date;
        "BL Type of Business": Enum "Business Type";
        "BL Business Location": Code[50];
        "BL Relationship Manager": Code[10];
        "BL Wholesale/Retail": Option " ",Wholesale,Retail;
        "BL Current Capital": Decimal;
        "BL No. of Employees": Integer;
        "BL Annual Turnover": Decimal;


        Comments: Text;
        "Edits Status": Enum "Workflow Status Main Flags";
        "Edits Responsibility Center": Code[50];
        SystemFilterFields: Record "System Edits Fields";
        SystemFilterFieldsII: Record "System Edits Fields";

        DataTransfer: Codeunit DataTransfer;
        "Account Profile": Option "Normal Member","High Profile","Politically Exposed";
        PostCode: Record "Post Code";
        EditsHelper: Record "Edits Helper";
        UserCanEditThisValue: Boolean;
}


