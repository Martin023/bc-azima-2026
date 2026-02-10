table 52187058 "Vehicle Movement"
{
    Caption = 'Vehicle Movement';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Motor Vehicle Movement List";
    LookupPageId = "Motor Vehicle Movement List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'Movement No.';
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    MembNoSeries.Get;
                    NoSeriesMgt.TestManual(MembNoSeries."Motor Vehicle Movement No.");
                    "Movement No. Series" := '';
                end;
            end;
        }
        field(2; "Movement No. Series"; Code[20])
        {
        }
        field(3; "Date of Travel"; Date)
        {
            // trigger OnValidate()
            // begin
            //     if Rec."Date of Travel" < Today then
            //         Error('Date of Travel Cannot be a past date!');
            // end;
        }
        field(4; "Name of Driver"; Text[100])
        {
        }
        field(5; "Driver Staff No."; Code[20])
        {
            // TableRelation = "HR Drivers".Code;
            // trigger OnValidate()
            // // begin
            // //     if "Driver Staff No." <> '' then begin
            // //         HRDrivers.Get("Driver Staff No.");
            // //         "Name of Driver" := HRDrivers."Driver Name";
            // //     end;
            // // end;

            // begin
            //     HRDrivers.Reset();
            //     if HRDrivers.Get(Rec."Driver Staff No.") then
            //         Rec."Name of Driver" := HRDrivers."Driver Name";
            // end;
        }
        field(6; "Vehicle Reg No."; Code[20])
        {
        }
        field(7; "Purpose of Journey"; Text[100])
        {
        }
        field(8; "From"; Text[100])
        {
        }
        field(9; "Destination"; Text[100])
        {
        }
        field(10; "Outward Distance"; Decimal)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "Outward Distance" > 0 then
                    "Total Distance" := "Outward Distance" + "Return Distance";
            end;
        }
        field(11; "Departure Time"; Time)
        {
        }
        field(12; "Arrival Time"; Time)
        {
        }
        field(13; "Return Departure Time"; Time)
        {
        }
        field(14; "Return Arrival Time"; Time)
        {
        }
        field(15; "Return Distance"; Decimal)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "Return Distance" > 0 then
                    "Total Distance" := "Outward Distance" + "Return Distance";
            end;
        }
        field(16; "Total Distance"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(17; "Purpose of Travel"; Text[100])
        {
        }
        field(18; Status; Enum "Workflow Status Main Flags")
        {
        }
        field(19; "Created By"; Code[50])
        {
        }
        field(20; "Global Dimension 1 Code"; Code[20])
        {
        }
        field(21; "Global Dimension 2 Code"; Code[20])
        {
        }
        field(22; "Application Date"; Date)
        {
        }
        field(23; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility CenterBR";
        }
        field(24; "Created At"; Date)
        {
        }
        field(25; Mileage; Decimal)
        {
        }
        field(26; "User ID"; Code[50])
        {
        }
        field(27; "Allocated Vehicle"; Code[20])
        {
            TableRelation = "Company Vehicles"."No." where(Status = const(Approved));
            trigger OnValidate()
            begin
                CompanyVehicles.Reset();
                CompanyVehicles.Setrange(CompanyVehicles."No.", "Allocated Vehicle");
                if CompanyVehicles.find('-') then begin
                    if CompanyVehicles."Movement Status" = CompanyVehicles."Movement Status"::"In Transit" then begin
                        Rec."Registration No." := CompanyVehicles."Registration No.";
                        //Message('Vehicle is in transit.');
                    end;

                    if CompanyVehicles."Movement Status" = CompanyVehicles."Movement Status"::Stationary then begin
                        Rec."Registration No." := CompanyVehicles."Registration No.";
                        //Message('Vehicle is Stationary.');
                    end;
                end;
            end;
        }
        field(28; "Registration No."; Code[20])
        {
        }
        field(29; "Driver No."; Code[20])
        {

            TableRelation = "HR Drivers"."No." WHERE(Status = const(Approved), Active = Const(true));
            trigger OnValidate()
            begin
                HRDrivers.Reset();
                HRDrivers.SetRange("No.", Rec."Driver No.");
                if HRDrivers.Find('-') then begin
                    begin
                        if HRDrivers."Driver Availability" = HRDrivers."Driver Availability"::"Available" then begin
                            Rec."Driver Staff No." := HRDrivers.Code;
                            Rec."Name of Driver" := HRDrivers."Driver Name";
                            //Message('Driver is Available!');
                        end;
                        //else
                        if HRDrivers."Driver Availability" = HRDrivers."Driver Availability"::"Unavailable" then begin
                            Rec."Driver Staff No." := HRDrivers.Code;
                            Rec."Name of Driver" := HRDrivers."Driver Name";
                            //Message('Driver is Unavailable!');
                        end;
                    end;
                end;
            end;
        }
        field(30; "Return Date"; Date)
        {
            trigger OnValidate()
            begin
                if Rec."Return Date" < Rec."Departure Date" then
                    Error('Return Date Cannot be earlier that Departure Date!');
            end;
        }
        field(32; "Departure Date"; Date)
        {
            // trigger OnValidate()
            // begin
            //     if Rec."Departure Date" < Today then
            //     Error('Departure Date Cannot be a past date!');
            // end;
        }
        field(33; "Movement Status"; Option)
        {
            OptionCaption = 'New,In Progress,Closed';
            OptionMembers = "New","In-Progress",Closed;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    Trigger OnInsert()
    var
        UserSetup: Record "User Setup";
        SeriesSetup: Record "Credit Nos. Series";

    begin
        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Motor Vehicle Movement No.");
            NoSeriesMgt.InitSeries(SeriesSetup."Motor Vehicle Movement No.", xRec."Movement No. Series", 0D, "No.", "Movement No. Series");
        end;
        "Created At" := Today;
        "Created By" := UserId;
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
        HRDrivers: Record "HR Drivers";
        UserSetup: Record "User Setup";
        CompanyVehicles: Record "Company Vehicles";
        Drivers: Record "HR Drivers";
        VehMov: Record "Vehicle Movement";


    procedure AssignDriversAndVehiclesToMovement(VehMov: Record "Vehicle Movement")
    begin
        if Confirm('Do you want to assign the selected driver and vehicle to the movement?') then begin
            Drivers.RESET;
            Drivers.SetRange(Drivers."No.", VehMov."Driver No.");
            //DRivers.SetRange("Staff Number", VehMov."Driver Staff No.");
            if Drivers.Find('-') then begin
                Drivers."Driver Availability" := Drivers."Driver Availability"::Unavailable;
                Drivers.Modify;
                Message('Driver Assigned to Movement');
            end;

            CompanyVehicles.RESET;
            CompanyVehicles.SetRange(CompanyVehicles."No.", VehMov."Allocated Vehicle");
            if CompanyVehicles.Find('-') then begin
                CompanyVehicles."Movement Status" := CompanyVehicles."Movement Status"::"In Transit";
                CompanyVehicles.Modify;
                Message('Vehicle Assigned to Movement');
            end;
            Message('Movement Status Updated to In-Progress.');
        end;
        // AssignDriversAndVehiclesToMovement(false)
        // else
        // exit;

    end;
}
