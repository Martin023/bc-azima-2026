table 52185941 "Maintain Machne/Vehicles"
{
    LookupPageId = "Motor Vehicle Repair";
    DrilldownPageId = "Motor Vehicle Repair";
    Caption = 'Vehicle Repair';
    fields
    {
        field(1; "No."; CODE[20])
        {
             trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    MembNoSeries.Get;
                    NoSeriesMgt.TestManual(MembNoSeries."Repair No.");
                    "No. Series" := '';
                end;
                CompanyVehicles.Reset();
                //CompanyVehicles.Get("No.");
                CompanyVehicles.SetRange(CompanyVehicles."No.","Car Registration No.");
                if CompanyVehicles.Find('-') then
                    "Registration No." := CompanyVehicles."Registration No.";
            end;
        }
        field(2; "Vehicle No."; Code[20])
        {
            TableRelation = "Company Vehicles"."No.";
            Trigger OnValidate();
            begin
                CompanyVehicles.Reset();
                CompanyVehicles.SetRange("No.", "Vehicle No.");
                if CompanyVehicles.Find('-') then 
                begin
                    "Asset No." := CompanyVehicles."Asset No.";
                    "Registration No." := CompanyVehicles."Registration No.";
                    "Vehicle Description" := CompanyVehicles.Description;
                end;
            end;
        }
        field(3; "Asset No."; Code[20])
        {
        }
        field(4; "Registration No."; Code[20])
        {
        }
        field(5; "Repair Date"; Date)
        {
        }
        
        field(6; "Repair Garage/Workshop"; Text[100])
        {
        }
        field(7; "Description of Repair"; Text[2000])
        {
        }
        field(8; "Repair Cost"; Decimal)
        {
        }
        field(9; "No. Series"; Code[20])
        {
            TableRelation = "Credit Nos. Series"."Repair No.";
        }
        field(10; "Created at"; DateTime)
        {
        }
        field(11; "Created by"; Code[50])
        {
        }
        field(12; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin

            end;
        }
        field(13; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin

            end;
        }
        field(14; "Car Registration No."; Code[20])
        {
            trigger OnValidate()
            begin
                CompanyVehicles.Reset();
                //CompanyVehicles.Get("No.");
                CompanyVehicles.Get("Car Registration No.");
                CompanyVehicles.SetRange(CompanyVehicles."No.","Car Registration No.");
                IF CompanyVehicles.Find('-') then
                begin
                    "Registration No." := CompanyVehicles."Registration No.";
                end;
            end;
        }
        field(15; "Driver No."; Code[20])
        {
            TableRelation = "HR Drivers"."No.";

            trigger OnValidate()
            begin
                // HREmployees.RESET();
                // HREmployees.SetRange("No.", "Supervisor Staff No.");
                // if HREmployees.Find('-') then
                // begin
                //     "Supervisor Name" := HREmployees."Full Name";
                // end;
                Drivers.RESET();
                Drivers.SetRange("No.", "Driver No.");
                if Drivers.Find('-') then
                begin
                    "Driver Name" := Drivers."Driver Name";
                    "Driver PF No." := Drivers.Code;
                end;
            end;
        }
        field(16; "Driver Name"; Code [50])
        {
        }
        field(17; "Responsibility Center"; Code[50])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(18; Status; Enum "Workflow Status Main Flags")
        {
            
        }
        field(19; "Vehicle Description"; Text[250])
        {
        }
        field(20; "Driver PF No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Car Registration No.", "Registration No.")
        {
            Clustered = true;
        }
    }
    Trigger OnInsert()
    var
        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
    begin

        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Repair No.");
            "No." := NoSeriesMgt.GetNextNo(SeriesSetup."Repair No.");
            // NoSeriesMgt.InitSeries(SeriesSetup."Repair No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        Rec."Created at" := CURRENTDATETIME;
        Rec."Created by" := USERID;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end;
    end;

    var
        ASSET: Record "Fixed Asset";
        Contracts: Record Contracts;
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        MembNoSeries: Record "Credit Nos. Series";
        CompanyVehicles: Record "Company Vehicles";
        Vendor : Record Vendor;
        HREmployees : Record "HR Employees";
        UserSetup: Record "User Setup";
        Drivers: Record "HR Drivers";
}

