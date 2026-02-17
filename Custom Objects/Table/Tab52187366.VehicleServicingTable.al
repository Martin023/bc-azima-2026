table 52187366 "Vehicle Servicing Table"
{
    Caption = 'Vehicle Servicing Table';
    DataClassification = ToBeClassified;
    LookupPageId = "Vehicle Servicing List Page";
    DrillDownPageId = "Vehicle Servicing List Page";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No';
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeriesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."Service No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Asset No."; Code[100])
        {
        }
        field(3; "Registration No."; Code[150])
        {
        }
        field(4; "Description"; Code[100])
        {
        }
        field(10; "Service Date"; Date)
        {
            trigger OnValidate()
            begin
                if "Service Date" > Today
                then begin
                    Error('Service Date Cannot be in the future!');
                end;

            end;
        }
        // field(22; "Service Vendor No."; Code [20])
        // {
        //     TableRelation = Vendor."No.";
        //     trigger OnValidate()
        //     begin
        //         Vendor.Reset();
        //         Vendor.SetRange(Vendor."No.", "Service Vendor No." );
        //         if Vendor.Find ('-') then begin
        //             "Service Garage/Workshop" := Vendor.Name;
        //         end;
        //     end;
        // }
        field(11; "Service Garage/Workshop"; Text[100])
        {
        }
        field(12; "Service description"; Text[250])
        {
        }
        field(13; "Last service date"; Date)
        {
            NotBlank = true;
        }
        field(14; "Next Service Mileage"; Integer)
        {
        }
        field(15; "Next Service Date"; Date)
        {
        }
        field(17; "No. Series"; Code[20])
        {
        }
        field(18; "Created by"; Code[50])
        {
        }
        field(19; "Created at"; DateTime)
        {
        }
        field(20; "Supervisor Staff No."; Code[120])
        {
            TableRelation = "HR Employees"."No.";

            trigger OnValidate()
            begin
                HREmployees.RESET();
                HREmployees.SetRange("No.", "Supervisor Staff No.");
                if HREmployees.Find('-') then begin
                    "Supervisor Name" := HREmployees."Full Name";
                end;
            end;
        }
        field(21; "Supervisor Name"; Code[150]) { }

        field(24; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin

            end;
        }
        field(23; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin

            end;
        }
        field(25; "Record ID"; Code[120])
        {
        }
        field(26; "Resposibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(27; Status; Enum "Workflow Status Main Flags")
        {

        }
        field(28; "Vehicle No."; Code[50])
        {
            TableRelation = "Company Vehicles"."No.";
            trigger OnValidate()
            begin
                CompanyVehicles.RESET();
                CompanyVehicles.SetRange("No.", "Vehicle No.");
                if CompanyVehicles.Find('-') then begin
                    "Asset No." := CompanyVehicles."Asset No.";
                    "Registration No." := CompanyVehicles."Registration No.";
                    "Description" := CompanyVehicles.Description;
                end;
            end;
        }
        field(29; "Driver No."; Code[50])
        {
            TableRelation = "Hr Drivers"."No.";
            trigger OnValidate()
            begin
                Drivers.RESET();
                Drivers.SetRange("No.", Rec."Driver No.");
                if Drivers.Find('-') then begin
                    "Supervisor Staff No." := Drivers."Staff Number";
                    "Supervisor Name" := Drivers."Driver Name";
                end;
            end;
        }
    }
    keys
    {
        key(PK; "No.", "Record ID")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Motor Vehicle Request No.");
            "No." := NoSeriesMgt.GetNextNo(SeriesSetup."Motor Vehicle Request No.");
            // NoSeriesMgt.InitSeries(SeriesSetup."Motor Vehicle Request No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Created by" := USERID;
        "Created at" := CURRENTDATETIME;
        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Resposibility Center" := UserSetup."Responsibility Centre";
        end;
    end;

    var
        SeriesSetup: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit "No. Series";
        HREmployees: Record "HR Employees";
        Vendor: Record Vendor;
        FA: Record "Fixed Asset";
        CompanyVehicles: Record "Company Vehicles";
        UserSetup: Record "User Setup";
        Drivers: Record "HR Drivers";
}
