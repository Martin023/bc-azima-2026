table 52185840 "Securities Register"

{
    // LookupPageId = "Collateral Register - List";
    // DrillDownPageId = "Collateral Register - List";
    LookupPageId = "Securities Register - List";
    DrillDownPageId = "Securities Register - List";

    fields
    {
        field(1; "No."; Code[10])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get;
                    NoSeriesMgt.TestManual(SalesSetup."Loan Security Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(5; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(8; "Account No."; Code[20])
        {
            TableRelation = Members."No.";
            trigger OnValidate()
            begin
                if CusMembr.Get("Account No.") then
                    "Account Name" := CusMembr.Name;
                "PF No." := CusMembr."Payroll/Staff No.";
            end;
        }
        field(9; "Account Name"; Text[100])
        {
            Editable = false;
        }
        field(10; "Collateral Type"; Option)
        {
            OptionCaption = ' ,Land,Real Estate/Plot,Plant and Equipment,Natural Reserves,Marketable Securities,Inventory,Motor Vehicle, Chattels';
            OptionMembers = " ",Land,"Real Estate/Plot","Plant and Equipment","Natural Reserves","Marketable Securities",Inventory,"Motor Vehicle",Chattels;
        }

        field(11; Collateral; Code[10])
        {
            TableRelation = "Loan Securities Set-up"."Setup Code";
            //TableRelation = "Loan Securities Set-up"."No." WHERE(Type = FIELD("Collateral Type"));
            trigger OnValidate()
            begin
                if SecurityRegSetUp.Get(Collateral) then begin
                    if SecurityRegSetUp.Blocked then
                        Error(Text001, SecurityRegSetUp."Security Description");

                    "Collateral Name" := SecurityRegSetUp."Security Description";
                    "Collateral Multiplier" := SecurityRegSetUp."Collateral Multiplier";

                end;
            end;
        }
        field(12; "Collateral Name"; Text[150])
        {
            Editable = false;
        }
        field(13; "Collateral Reg No."; Text[100])
        {
            Editable = false;
        }
        field(15; "Collateral Multiplier"; Integer)
        {
            Editable = true;

            trigger OnValidate()
            begin
                Validate("Forced Sale Value");
                if ("Collateral Multiplier" > 100) or
                  ("Collateral Multiplier" < 0)
                  then
                    "Collateral Multiplier" := 0
            end;
        }
        field(16; "Insured Value"; Decimal)
        {
            trigger OnValidate()
            begin
                rec."Total Market Value" := "Market Value" + "Insured Value";
            end;
        }
        field(17; "Collateral Limit"; Decimal)
        {
            Description = 'Max. amount Collateral can cover against loan';
            Editable = false;

            trigger OnValidate()
            begin
                //"Forced Sale Value" := "Collateral Limit";
                //Validate("Forced Sale Value");
            end;
        }
        field(29; Status; Option)
        {
            OptionMembers = Open,Pending,Approved,Rejected,Archived;
            OptionCaption = 'Open,Pending,Approved,Rejected,Archived';
        }
        field(30; "Inward/Outward"; Option)
        {
            OptionCaption = ' ,In-Store,Returned';
            OptionMembers = " ","In-Store",Returned;
        }
        field(31; "Last Valuation Date"; Date)
        {

            trigger OnValidate()
            begin
                GenSetup.Get;
                if "Last Valuation Date" <> 0D then begin
                    if "Last Valuation Date" > Today then
                        Error(Text004);
                    GenSetup.TestField("Maximum Valuation Period");
                    if CalcDate(GenSetup."Maximum Valuation Period", "Last Valuation Date") < Today then
                        Error(Text003, GenSetup."Maximum Valuation Period");
                    SecurityRegSetUp.Reset;
                    SecurityRegSetUp.SetRange(SecurityRegSetUp.Type, "Collateral Type");
                    if SecurityRegSetUp.Find('-') then begin
                        if Format(SecurityRegSetUp."Revaluation Frequency") <> '' then
                            "Next Valuation Date" := CalcDate(SecurityRegSetUp."Revaluation Frequency", "Last Valuation Date");
                    end;
                end;
            end;
        }
        field(32; "Forced Sale Value"; Decimal)
        {

            trigger OnValidate()
            var
                Text001: Label 'Forced sale value cannot be more than collateral limit';
            begin
                if ("Collateral Multiplier" > 100) or
                ("Collateral Multiplier" < 0)
                then
                    "Collateral Multiplier" := 0 else
                    "Collateral Multiplier" := "Collateral Multiplier";
                "Collateral Limit" := "Forced Sale Value" * ("Collateral Multiplier" / 100);
                Validate("Collateral Limit");
            end;
        }
        field(33; "Collateral Perfected"; Boolean)
        {
            Editable = false;
        }
        field(34; "Next Valuation Date"; Date)
        {
            Editable = false;
        }
        field(35; Remarks; Text[150])
        {
        }
        field(36; "Collateral Ref No."; Text[300])
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                SecuritiesRegister.Reset;
                SecuritiesRegister.SetRange(SecuritiesRegister."Collateral Ref No.", "Collateral Ref No.");
                SecuritiesRegister.SetFilter(SecuritiesRegister.Status, '%1|%2|%3', SecuritiesRegister.Status::Open, SecuritiesRegister.Status::Approved, SecuritiesRegister.Status::Pending);
                if SecuritiesRegister.Find('-') then
                    Message('Collateral Ref No. :%1', SecuritiesRegister."No.", ' already exists');
            end;
        }
        field(37; "Captured By"; Text[100])
        {

            trigger OnValidate()
            begin
                "Captured By" := UserId;
            end;
        }
        field(38; "Date Captured"; Date)
        {
            trigger OnValidate()
            begin
                "Date Captured" := Today;
            end;
        }
        field(39; "Spousal Consent"; Boolean)
        {
            Caption = 'Spousal Consent';
        }
        field(40; "Land Control Board Consent"; Boolean)
        {
            Caption = 'Land Control Board';
        }
        field(41; "Law Firm Hanlding the Matter"; Text[100])
        {
            Caption = 'Law Firm Hanlding the Matter';
        }
        field(42; "Fees Payable to the firm"; Decimal)
        {
            Caption = 'Fees Payable to the firm';
        }
        field(111; "Charge Type"; Code[100])
        {
            Caption = 'Charge Type';
            //OptionMembers = " CHARGE","Further Charge","Second Further Charge","Discharge";
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST("Charge Type"));
            trigger OnValidate()
            begin
                Chargetype.Reset;
                Chargetype.SetRange(Chargetype.Code, "Charge Type");
                if Chargetype.Find('-') then
                    "Charge Type" := Chargetype.Description;
            end;
        }
        field(112; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin

            end;
        }
        field(113; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin

            end;
        }
        field(114; "User ID"; Code[50])
        {

        }
        FIELD(115; "Responsibility Center"; Code[50])
        {
            TableRelation = "Responsibility CenterBR";

        }
        field(116; "Status of the fees"; Option)
        {
            Caption = 'Status of the fees';
            OptionMembers = " ","Unpaid","Partially Paid","Paid";
        }
        field(117; "Loan Product"; Code[20])
        {
            TableRelation = "Product Factory"."Product ID";
            trigger OnValidate()
            begin
                if "Loan Product" <> '' then begin
                    if ProductFactory.Get("Loan Product") then begin
                        "Loan Name" := ProductFactory."Product Description";
                        // "Security Stage" := ProductFactory."Security Stage";
                        // "Amount to be Charged" := ProductFactory."Amount to be Charged";
                        // "Market Value" := ProductFactory."Market Value";
                    end;
                end;

            end;
        }
        field(118; "Loan Amount"; Decimal)
        {
            //Caption = 'Intended Amount';
        }
        field(119; "Security Stage"; Enum "Perfection Stages")
        {
            Caption = 'Security Stage';
        }
        field(120; "Amount to be Charged"; Decimal)
        {
            Caption = 'Charged Amount';
        }
        field(121; "Market Value"; Decimal)
        {
            Caption = 'Market Value';

            trigger OnValidate()
            begin
                rec."Total Market Value" := "Market Value" + "Insured Value";
            end;
        }
        field(122; "Loan Name"; Text[100])
        {
            Caption = 'Loan Name';
        }
        field(123; "Loan No."; Code[20])
        {
            Caption = 'Loan No.';
            TableRelation = Loans WHERE("Member No." = field("Account No."));
            trigger OnValidate()
            begin
                Loans.Reset;
                if Loans.Get("Loan No.") then begin
                    "Loan Name" := Loans."Loan Product Type Name";
                    "Loan Amount" := Loans."Approved Amount";
                    "Lending Unit" := Loans."Source Unit";
                    "Outstanding Balance" := Loans."Outstanding Balance";
                end;
            end;
        }
        field(124; "Security Category"; Text[10])
        {
            Caption = 'Security Category';
            TableRelation = "Property Category";
        }

        field(125; "Chargor/Owner Name"; Text[30])
        {
            Caption = 'Chargor/Owner Name';
        }

        field(126; "Chargor/Owner KRA PIN"; Code[20])
        {
            Caption = 'Chargor/Owner KRA PIN';
        }
        field(127; "Chargor/Owner ID No"; Code[20])
        {
            Caption = 'Chargor/Owner ID No.';
        }
        field(128; "Date of registration"; Date)
        {
            Caption = 'Date of registration';
        }
        field(138; "Date of Manufucture"; Date)
        {
            Caption = 'Date of Manufucture';
        }
        field(129; "Collateral Description"; Text[50])
        {
            Caption = 'Collateral Description';
        }
        field(130; "Lease/Ownership Exp. Date"; Date)
        {
            Caption = 'Lease/Ownership Expiry. Date';
            trigger OnValidate()
            Var
                TodayYear: Integer;
                ExpiryYear: Integer;

            begin

                if rec."Collateral Hold Types" = rec."Collateral Hold Types"::"Lease Hold" then begin
                    if rec."Lease/Ownership Exp. Date" < Today then
                        Error('Lease/Ownership Expiry Date cannot be less than today')
                    else begin
                        TodayYear := Date2DMY(Today, 3);
                        ExpiryYear := Date2DMY(rec."Lease/Ownership Exp. Date", 3);
                        Rec."Years to Expiry" := ExpiryYear - TodayYear;

                        if Rec."Lending Unit" = Rec."Lending Unit"::"HR LOANS" then begin
                            ProductFactory.get("Loan Product");
                            IF ProductFactory."Is a Construction Loan" = TRUE THEN
                                if Rec."Years to Expiry" < 30 then
                                    Error('Lease/Ownership Expiry Date Cannot be less than 30 years.');
                        end;
                    end;
                end
                else if rec."Collateral Hold Types" = rec."Collateral Hold Types"::"Free Hold" then
                    Rec."Years to Expiry" := 0;
            end;

        }
        field(131; "Reference No"; Code[20])
        {
            Caption = 'Reference No';

        }
        field(132; "Property Location"; text[30])
        {
            Caption = 'Property Location';

        }
        field(133; "Storage No"; Code[20])
        {
            Caption = 'Storage No.';

        }
        field(134; "Valuer Name"; Text[200])
        {
            Caption = 'Valuer Name.';
            //TableRelation = "HR Lookup Values".Description where (Type = CONST("Security Valuers"));
        }
        field(135; "Law Firm Address"; Code[50])
        {
            Caption = 'Law Firm Address.';
        }
        field(136; "Law Firm Physical Address"; Code[50])
        {
            Caption = 'Law Firm Physical Address.';
        }
        field(137; "Lending Unit"; Enum "Source Unit")
        {
            Caption = 'Lending Unit';

            // OptionCaption = ' ,FOSA,BOSA,BUSINESS LOANS,HR LOANS';
            // OptionMembers = "",FOSA,BOSA,"BUSINESS LOANS","HR LOANS";
        }
        field(139; "Loan Offer Letter Date"; Date)
        {
            Caption = 'Loan Offer Letter Date';
        }
        field(140; "Send/Forward to"; Code[50])
        {
            TableRelation = "Responsibility CenterBR";
        }

        field(141; "Originating Department"; Code[50])
        {
            Editable = false;
        }
        field(142; "Current Departmrnt"; Code[50])
        {
            Editable = false;
        }
        field(143; "Chargor Phone No."; Code[20])
        {
            Caption = 'Chargor Phone No.';
        }
        field(144; "Collateral Discharged"; Boolean)
        {
            Caption = 'Collateral Discharged';
        }
        field(145; "Collateral Owner"; Option)
        {
            Caption = 'Collateral Owner';
            OptionCaption = ' ,Chargor,Loanee';
            OptionMembers = " ",Loanee,Chargor;
        }
        field(146; "SMS Sent"; Boolean)
        {
            Caption = 'SMS Sent';
        }
        field(147; "Collateral Substituted"; Boolean)
        {
            Caption = 'Collateral Substituted';
        }
        field(148; "Outstanding Balance"; Decimal)
        {
            Caption = 'Outstanding Balance';
        }
        field(149; "Collateral Category"; Option)
        {
            Caption = 'Collateral Category';
            OptionCaption = ' ,Immovable,Moveable, Chattels';
            OptionMembers = " ",Immovable,Moveable,Chattels;
            trigger OnValidate()
            begin
                Rec."Affidavit Provided" := false;
                Rec."Land Control Board Consent" := false;
                Rec."Spousal Consent" := false;
                Rec."Amount to be Charged" := 0;
                Rec."Personal Guarantee Provided" := false;
                Rec."Corporate Guarantee Provided" := false;
                Rec."Insurance Type" := Rec."Insurance Type"::" ";
                Rec."Insurance Company" := '';
                Rec."Tracking Company" := '';
                Rec."Property Location" := '';
                Rec."Status of the fees" := Rec."Status of the fees"::" ";
                Rec."Fees Payable to the firm" := 0;
                Rec."Law Firm Physical Address" := '';
                Rec."Law Firm Address" := '';
                REc."Law Firm Hanlding the Matter" := '';
                Rec."Years to Expiry" := 0;
                Rec."Lease/Ownership Exp. Date" := 0D;
                Rec."Date of Manufucture" := 0D;
                Rec."Valuer Name" := '';
                Rec."Deposit Account" := '';
                Rec."Deposit Account Name" := Rec."Deposit Account Name"::" ";
                Rec."Deposit Account No." := '';
                Rec."Deposit Account Balance" := 0;
                Rec."Cash Collateral Amount" := 0;
                Rec."Cash Collateral Posted" := false;
                Rec."Collateral Description" := '';
                Rec."Affidavit Provided" := false;
                Rec."Chattel Make" := '';
                Rec."Model No." := '';
                Rec."Serial No." := '';
                Rec."Year of Purchase" := 0;
                Rec."Total Market Value" := 0;
                Rec."PF No." := '';
                Rec."Collateral Hold Types" := Rec."Collateral Hold Types"::" ";
                Rec."Personal Guarantee Provided" := false;
                Rec."Chargor/Owner Name" := '';
                Rec."Chargor/Owner KRA PIN" := '';
                Rec."Chargor/Owner ID No" := '';
                Rec."Chargor Phone No." := '';
                Rec."Date of registration" := 0D;
                Rec."Date of Manufucture" := 0D;




            end;
        }
        field(150; "Affidavit Date"; Date)
        {
            Caption = 'Affidavit Date';
        }

        field(151; "Affidavit Provided"; Boolean)
        {
            Caption = 'Affidavit Provided';
        }
        field(152; "Chattel Make"; Text[350])
        {
            Caption = 'Chattel Make';
        }
        field(153; "Total Market Value"; Decimal)
        {
            Caption = 'Total Market Value';
        }
        field(154; "Year of Purchase"; Integer)
        {
            Caption = 'Year of Purchase';
        }
        field(155; "Serial No."; Code[350])
        {
            Caption = 'Serial No.';
        }
        field(156; "Model No."; Code[350])
        {
            Caption = 'Model No.';
        }
        field(157; "Deposit Account"; Code[100])
        {
            Caption = 'Deposit Account';
            TableRelation = "Product Factory"."Product ID" where("Product Class Type" = CONST("Savings"));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ProductFactory.Reset;
                if ProductFactory.Get("Deposit Account") then begin
                    // "Deposit Account No." := ProductFactory."Product ID";
                    // "Deposit Account Balance" := ProductFactory."Available Balance";
                    "Deposit Account Name" := (ProductFactory."Product Category");
                end;
            end;
        }
        Field(158; "Deposit Account No."; Code[100])
        {
            Caption = 'Deposit Account No.';
            TableRelation = "Savings Accounts"."No." where("Product Category" = field("Deposit Account Name"), "Member No." = field("Account No."));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                SavingsAccounts.Reset();
                SavingsAccounts.SetRange(SavingsAccounts."No.", "Deposit Account No.");
                if SavingsAccounts.Find('-') then begin
                    SavingsAccounts.CalcFields("Balance (LCY)");
                    "Deposit Account Balance" := SavingsAccounts."Balance (LCY)";
                end;
            end;
        }
        field(159; "Deposit Account Balance"; Decimal)
        {
            Caption = 'Deposit Account Balance';
        }
        field(160; "Cash Collateral Amount"; Decimal)
        {
            Caption = 'Cash Collateral Amount';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if rec."Cash Collateral Amount" > rec."Deposit Account Balance" then
                    Error('Cash Collateral Amount cannot be more than Deposit Account Balance');
            end;
        }
        FIELD(161; "Deposit Account Name"; Enum "Product Categories")
        {
            Caption = 'Deposit Account Name';
        }
        field(162; "Collateral Hold Types"; Option)
        {
            Caption = 'Collateral Hold Types';
            OptionCaption = ' ,Lease Hold, Free Hold';
            OptionMembers = " ","Lease Hold","Free Hold";
        }
        field(163; "Years to Expiry"; Integer)
        {
            Caption = 'Years to Expiry';
        }
        field(164; "Personal Guarantee Provided"; Boolean)
        {
            Caption = 'Personal Guarantee Provided';
        }
        field(165; "Corporate Guarantee Provided"; Boolean)
        {
            Caption = 'Corporate Guarantee Provided';
        }
        field(167; "Tracking Company"; Text[200])
        {
            Caption = 'Tracking Company';
        }
        field(168; "Insurance Company"; Text[200])
        {
            Caption = 'Insurance Company';
        }
        field(169; "Insurance Type"; Option)
        {
            Caption = 'Insurance Type';
            OptionCaption = ' ,Comprehensive,Third Party';
            OptionMembers = " ","Comprehensive","Thrid Party";
        }
        field(170; "PF No."; Code[50])
        {
            Caption = 'PF No.';
        }
        field(171; "Cash Collateral Posted"; Boolean)
        {

        }
        field(172; "Tracking Renewal Date"; Date)
        {
            Caption = 'Tracking Renewal Date';
        }
        field(173; "Land Rate Renewal"; Date)
        {
            trigger OnValidate()
            begin
                If "Land Rate Renewal" <= Today then error('Land Rate Renewal Must be greater than Today');
            end;

        }
        field(174; "Due Date"; DateFormula)
        {

        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Collateral Name")
        {
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get;
            SalesSetup.TestField(SalesSetup."Loan Security Nos.");
            "No." := NoSeriesMgt.GetNextNo(SalesSetup."Loan Security Nos.");
            // NoSeriesMgt.InitSeries(SalesSetup."Loan Security Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        Validate("Captured By");
        Validate("Date Captured");

        "User ID" := UserId;
        "Captured By" := UserId;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
            UserSetup.TestField("Responsibility Centre");
            "Originating Department" := UserSetup."Responsibility Centre";
            "Current Departmrnt" := UserSetup."Responsibility Centre";
            CFPage.InsertTracker("No.", "Originating Department", true, UserId, CurrentDateTime);
        end;
    end;


    trigger OnModify()
    begin
        //IF (Status=Status::Approved) OR (Status=Status::Pending) THEN
        //ERROR(Text002,Status);
    end;

    var
        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;
        SalesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        CusMembr: Record Members;
        SecurityRegSetUp: Record "Loan Securities Set-up";
        Text001: Label 'This collateral is blocked thus not avaialable for use.';
        Text002: Label 'This application is %1 thus cannot modify.';
        GenSetup: Record "General Set-Up";
        Text003: Label 'The last valuation day is more than %1 hence is invalid';
        Text004: Label 'Last valuation date cannot be greater than today';
        Text005: Label 'The forced sale value cannot be greater than collateral maximum limit of %1';
        UserSetup: Record "User Setup";
        ProductFactory: Record "Product Factory";
        Chargetype: Record "Segment/County/Dividend/Signat";
        Loans: Record Loans;
        SavingsAccounts: Record "Savings Accounts";
        HRCodeunit: Codeunit "HR Codeunit";
        ProductSetup: record "Product Factory";
        SecuritiesRegister: Record "Securities Register";
}

