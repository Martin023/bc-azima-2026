table 52187013 "B/S Loan Account Application"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            SQLDataType = Varchar;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeriesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."Business Loan Acc App");
                    "No. Series" := '';
                end;
            end;
        }

        field(2; "CRM Application No."; Code[50])
        {

        }

        field(3; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }

        field(4; "Member No."; Code[20])
        {
            TableRelation = Members where(Status = filter(Active));

            trigger OnValidate()
            var
                BSLNAccApp: Record "B/S Loan Account Application";
            begin
                CalcFields(Name, "Phone No.");
                BSLNAccApp.Reset();
                BSLNAccApp.SetRange("Member No.", "Member No.");
                BSLNAccApp.SetFilter("No.", '<>%1', "No.");
                BSLNAccApp.SetFilter(Status, '<>%1', BSLNAccApp.Status::Rejected);
                if BSLNAccApp.FindFirst() then begin
                    Error('This account %1 is in another application record %2 which is in status %3', "Member No.", BSLNAccApp."No.", BSLNAccApp.Status);
                end;
            end;
        }
        field(5; Name; Text[80])
        {
            Caption = 'Name';

            FieldClass = FlowField;
            CalcFormula = lookup(Members.Name where("No." = field("Member No.")));

            Editable = false;
        }


        field(6; "Phone No."; Text[80])
        {
            Caption = 'Phone No.';
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Phone No." where("No." = field("Member No.")));
            Editable = false;
        }

        field(7; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,Blocked);
            end;
        }
        field(8; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Last Date Modified");
            end;
        }
        field(9; "Responsibility Center"; Code[25])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility CenterBR";
            Editable = false;
        }

        field(10; Status; enum "Workflow Status Main Flags")
        {
            Editable = false;
        }

        field(11; "Application Date"; Date)
        {
            Editable = false;
        }
        field(12; "Created By"; Code[50])
        {
            Editable = false;
        }

        field(13; "Registration Date"; Date)
        {
            Editable = false;
        }

        field(14; "Account Created"; Boolean)
        {
            Editable = false;
        }
        field(15; "Type of Business"; Enum "Business Type")
        {

        }
        field(16; "Business Location"; Code[50])
        {

        }

        field(17; "Relationship Manager"; Code[10])
        {
            TableRelation = "HR Employees" WHERE(Status = FILTER(Active),"Global Dimension 2 Code" = field("Global Dimension 2 Code"));
        }

        field(18; "Wholesale/Retail"; Option)
        {
            OptionMembers = " ",Wholesale,Retail;
        }
        field(19; "Current Capital"; Decimal)
        {

        }
        field(20; "No. of Employees"; Integer)
        {

        }
        field(21; "Annual Turnover"; Decimal)
        {

        }
        field(22; "Application Type"; Option)
        {
            OptionMembers = New;
        }
        field(23; "Destination Group No."; Code[30])
        {
            TableRelation = Members."No." where("Account Type" = FILTER(<> "Single Member Account"), "Account Type" = filter("Group Account"));
        }
        field(24; "Transfer Reason"; Text[250])
        {

        }
        field(25; Gender; Enum Gender)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Gender where("No." = field("Member No.")));
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin

        AccountApplication.Reset;
        AccountApplication.SetFilter(Status, '%1', AccountApplication.Status::Open);
        AccountApplication.SetRange("Created By", UserId);
        if AccountApplication.Find('-') then begin
            if AccountApplication.Count > 2 then
                Error('Kindly use the open document first for you to create a new one');
        end;

        if "No." = '' then begin

            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Business Loan Acc App");
            NoSeriesMgt.InitSeries(SeriesSetup."Business Loan Acc App", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Application Date" := Today;
        "Created By" := UserId;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end;
    end;

    var
        SeriesSetup: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ProductFactory: Record "Product Factory";
        GeneralSetUp: Record "General Set-Up";
        UserSetup: Record "User Setup";
        SavingsAccounts: Record "Savings Accounts";
        AccountExistsError: Label 'Applicant already has a similar Account No.%1 Name %2 .';
        CountryRegion: Record "Country/Region";
        AccountApplication: Record "Savings Account Application";
}

