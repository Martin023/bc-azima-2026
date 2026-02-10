table 52186163 "Company Vehicles"
{
    drilldownpageid = "Company Vehicles List";
    LookupPageID = "Company Vehicles list";

    fields
    {
        field(211; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    MembNoSeries.Get;
                    NoSeriesMgt.TestManual(MembNoSeries."Company Vehicle Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(212; "No. Series"; Code[20])
        {
        }
        field(1; "Registration No."; Code[8])
        {

            trigger OnValidate()
            var
                Characters: Text;
            
            begin

                if StrLen("Registration No.") <> 8 then Error('Vehicle Registration Number length must not be more 8 characters');
                Characters := '1234567890!@#$%^&*()_~{}[];:"|\ ,./<>?-= ''';
                if not ValidateShouldNotHaves(CopyStr("Registration No.", 8, 1), Characters) then Error('Last character must be a letter');

                Characters := '1234567890';
                if ValidateShouldNotHaves(CopyStr("Registration No.", 2, 8), Characters) then Error('Pin number must be alphanumeric');
            end;
            
        }
        field(2; Description; Text[100])
        {
        }
        field(3; Capacity; Integer)
        {
        }
        field(4; "Asset No."; Code[100])
        {
            TableRelation = "Fixed Asset"."No.";
            trigger OnValidate()
            begin
                FA.Reset;
                if FA.Get("Asset No.") then
                    Rec."Registration No." := FA."Serial No.";
                Rec.Description := FA.Description;
                Rec."Purchase Vendor/Company" := FA."Vendor Name";

                // Insurance.RESET;
                // Insurance.SETRANGE("Fixed Asset No.", FA."No.");
                // Insurance.SetRange("Insurance Status", Insurance."Insurance Status"::Active);
                // if Insurance.Find('-') then begin
                //     Rec."Insurance Company" := Insurance."Insurer Name";
                //     Rec."Insurance Policy No." := Insurance."Policy No.";
                //     Rec."Insurance Expiry Date" := Insurance."Expiration Date";
                //     Rec."Date of last insurace" := Insurance."Effective Date";

                //end
                // else
                //     Message('No Insurance Record Found.');

                // FADepBook.RESET;
                // FADepBook.SETRANGE("FA No.", FA."No.");
                // if FADepBook.FindSet() then
                //     Rec."Purchase Date" := FADepBook."Acquisition Date";
                //     Rec."Purchase Price" := FADepBook."Acquisition Cost";
            end;
        }
        field(5; "Vehicle Type"; Text[100])
        {
        }
        field(6; "Year of Manufacture"; Integer)
        {
        }
        field(7; "Color"; Text[30])
        {
        }
        field(8; "Load Limit"; Decimal)
        {
        }
        field(9; "Logbook No."; Code[20])
        {
        }
        field(10; "Engine No."; Code[20])
        {
        }
        field(11; "Vehicle Frame Number"; Code[100])
        {
        }
        field(12; "Purchase Date"; Date)
        {
        }
        field(13; "Purchase Vendor/Company"; Text[100])
        {
        }
        field(14; "Vendor Contact Details"; code[20])
        {
        }
        field(15; "Purchase Price"; Decimal)
        {
        }
        field(16; "Insurance Company"; Text[1024])
        {
        }
        field(111; "Company Name"; Text[100])
        {
        }
        field(17; "Insurance Policy No."; Code[50])
        {
        }
        field(18; "Insurance Expiry Date"; Date)
        {
        }
        field(19; "Date of last insurace"; Date)
        {
        }
        field(20; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(21; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(22; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility CenterBR";
        }
        field(23; "Created By"; Code[50])
        {
            Editable = false;
        }
        field(24; "Type of Vehicle"; Code[100])
        {
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST("Type of Vehicle"));
        }
        field(25; "Vehicle Status"; Option)
        {
            Caption = 'Vehicle Status';
            OptionMembers = "Inactive","Active";
        }
        field(26; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = Open,Approved,"Pending Approval",Deffered,Cancelled,Rejected,Closed;
        }
        field(27; "Created at"; DateTime)
        {
            Caption = 'Creation Date';
            Editable = false;
        }
        field(28; "Vehicle Make"; CODE[100])
        {
            Caption = 'Vehicle Make';
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST("Vehicle Make"));
        }
        field(29; "User ID"; Code[50])
        {
            Editable = false;
        }
        field(30; Model; Code[100])
        {
            Caption = 'Model';
            TableRelation = "Segment/County/Dividend/Signat".Code WHERE(Type = CONST("Model"));
        }
        field(31; "Movement Status"; Option)
        {
            Caption = 'Movement Status';
            OptionMembers = "Stationary","In Transit";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Asset No.", "Registration No.", "Vehicle Make", "Vehicle Status")
        {
        }

    }

    trigger OnInsert()

    Var
        UserSetup: Record "User Setup";
        SeriesSetup: Record "Credit Nos. Series";
    begin
        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Company Vehicle Nos.");
            NoSeriesMgt.InitSeries(SeriesSetup."Company Vehicle Nos.", xRec."No. Series", 0D, "No.", "No. Series");

        end;
        "Created By" := userID;
        "Created at" := CurrentDateTime;

        "User ID" := UserId;
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
        FA: Record "Fixed Asset";
        MembNoSeries: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        XValue: code[50];
        RecordID: Code[50];
        Vendor: Record Vendor;
        FADepBook: Record "FA Depreciation Book";
        Insurance: Record "Insurance";

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