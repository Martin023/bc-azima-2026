table 52187061 "Motor Vehicle Request"
{
    Caption = 'Motor Vehicle Request';
    DataClassification = ToBeClassified;
    LookupPageId = "Motor Vehicle Request List";
    DrillDownPageId = "Motor Vehicle Request List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeriesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."Motor Vehicle Request No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(3; "Staff No."; Code[20])
        {
            //TableRelation = "HR Employees" WHERE(Status = CONST(Active));
            TableRelation = "HR Employees"."No.";
            Caption = 'Staff No.';
            trigger OnValidate()
            begin
                HrEmployees.Reset();
                HrEmployees.Get(Rec."Staff No.");
                //if HrEmployees.Find('-') then
                "Staff Name" := HrEmployees."First Name" + ' ' + HrEmployees."Middle Name" + ' ' + HrEmployees."Last Name";
            end;
        }
        field(4; "Staff Name"; Text[50])
        {
            Editable = false;
            Caption = 'Staff Name';
        }
        field(5; "Vehicle Purpose"; Text[100])
        {
            Caption = 'Vehicle Purpose';
        }
        field(6; Destination; Text[100])
        {
            Caption = 'Destination';
        }
        field(7; "Type of Travel"; Option)
        {
            Caption = 'Type of Travel';
            OptionMembers = " ",Individual,Department,Other;
        }
        field(8; "Date of Request"; Date)
        {
            Caption = 'Date of Request';
            trigger OnValidate()
            begin
                "Date of Travel" := 0D;
            end;
        }
        field(9; "Date of Travel"; Date)
        {
            Caption = 'Date of Travel';
            trigger OnValidate()
            begin
                //TestField("Date of Request");
                if "Date of Travel" < "Date of Request" then
                    Error('Date of travel should not be less than date of request.');
            end;
        }
        field(10; "Department Name"; Text[50])
        {
            Caption = 'Department Name';
            TableRelation = "Responsibility CenterBR";
        }
        field(11; "No. of Staff Traveling"; Integer)
        {
            Caption = 'No. of Staff Travelling';
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
        field(14; "Status"; Option)
        {
            Caption = 'Status';
            OptionMembers = "Open","Approved","Pending","Rejected","Deffered","Closed", "Requested Pending Allocation";
        }
        field(15; "Created By"; Code[50])
        {
            Caption = 'Created By';
        }
        field(16; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
        }
        // field(17; "Driver Status"; Option)
        // {
        //     Caption = 'Driver Status';
        //     OptionMembers = "Unallocated","Allocated","Reallocated";
        // }
        field(18; "Driver Name"; Text[50])
        {
            Caption = 'Driver Name';
        }
        // field(19; "Vehicle Status"; Option)
        // {
        //     Caption = 'Vehicle Status';
        //     OptionMembers = "Unallocated","Allocated","Reallocated";
        // }
        field(20; "Responsibility Center"; Code[20])
        {
            Caption = 'Resposnsibility Center';
            TableRelation = "Responsibility CenterBR";
        }
        field(21; "Allocated Driver"; Code[10])
        {
            //TableRelation = "HR Drivers"."No." WHERE("Driver Availability" = CONST(Available));
            TableRelation = "HR Drivers"."No.";
            trigger OnValidate()
            begin
                Drivers.Reset();
                Drivers.Setrange(Drivers."No.", Rec."Allocated Driver");
                if Drivers.Find('-') then begin
                    if Drivers."Driver Availability" = Drivers."Driver Availability"::Available then begin
                        Rec."Driver Name" := Drivers."Driver Name";
                        Rec."Driver Staff No." := Drivers.Code
                        //Error('Driver, Not avaiable. Please Select Another Driver!')
                    end
                    else begin
                        VehicleRequest.RESET;
                        VehicleRequest.SetRange("Allocated Driver", Rec."Allocated Driver");
                        VehicleRequest.SetRange(Status, Status::"Approved");
                        if VehicleRequest.Find('-') then begin
                            repeat
                                Error('Driver is allocated to request number ' + VehicleRequest."No." + ' for the date ' + Format(VehicleRequest."Date of Travel") + '.')
                            until VehicleRequest.Next = 0;
                        end;
                        Rec."Driver Name" := Drivers."Driver Name";
                        Rec."Driver Staff No." := Drivers.Code;
                    end;
                end
            end;
        }
        field(22; "User ID"; Code[50])
        {
        }
        field(23; "Allocated Vehicle"; Code[20])
        {
            //TableRelation = "Company Vehicles"."No." WHERE("Movement Status" = CONST(Stationary));
            TableRelation = "Company Vehicles"."No.";
            trigger OnValidate()
            begin

                VehicleRequest.RESET;
                VehicleRequest.Setrange(Status, VehicleRequest.Status::"Approved");
                VehicleRequest.SetRange("No.", Rec."No.");
                VehicleRequest.SetRange("Allocated Vehicle", Rec."Allocated Vehicle");
                //VehicleRequest.SetRange("Date of Travel", Rec."Date of Travel");
                if VehicleRequest.find('-') then begin
                    if VehicleRequest."Date of Travel" = Rec."Date of Travel" then
                        Error('Vehicle is already allocated for the selected date. Please Select Another Vehicle!');
                end
                else begin
                    CompanyVehicles.Reset();
                    CompanyVehicles.Setrange(CompanyVehicles."No.", "Allocated Vehicle");
                    if CompanyVehicles.find('-') then begin
                        Rec."Registration No." := CompanyVehicles."Registration No.";
                    end;
                end;
            end;
        }
        field(24; "Registration No."; Code[20])
        {
            trigger OnValidate()
            begin
                "Registration No." := '';
            end;
            //TableRelation = "Company Vehicles".No;
        }
        field(25; "Reallocation Reason"; Text[100])
        {
            Caption = 'Reallocation Reasons';
        }
        field(26; "Driver Staff No."; CODE[50])
        {
        }
        field(27; "New Vehicle"; CODE[50])
        {
            TableRelation = "Company Vehicles"."No.";
            trigger OnValidate()
            begin
                CompanyVehicles.Reset();
                if CompanyVehicles.Get("New Vehicle") then
                    if Rec."Allocated Vehicle" = Rec."New Vehicle" then
                        Error('Vehicle, Not avaiable. Please Select Another Vehicle!')
                    else begin
                        Rec."New Registration No." := CompanyVehicles."Registration No.";
                    end;
            end;
        }
        field(28; "New Registration No."; Code[50])
        {
        }
        field(29; "New allocated Driver"; CODE[50])
        {
            TableRelation = "HR Drivers"."No." WHERE("Driver Availability" = CONST(Available));
            trigger OnValidate()
            begin
                Drivers.Reset();
                if Drivers.Get("New Allocated Driver") then
                    Rec."New Driver Name" := Drivers."Driver Name";
                Rec."New Driver Staff No." := Drivers.Code;

                if Rec."Allocated Driver" = Rec."New allocated Driver" then begin
                    Error('Driver, Not avaiable. Please Select Another Driver!')
                end;
            end;
        }
        field(30; "New Driver Name"; code[50])
        {
        }
        field(31; "New Reallocation Reason"; code[50])
        {
        }
        field(32; "New Driver Staff No."; CODE[50])
        {
        }
        field(33; "Reallocated"; Boolean)
        {
        }
        field(34; "Deffer Comments"; Text[200])
        {
            Caption = 'Deffer Comments';
        }
        field(35; "Other Travel Type"; Text[100])
        {
            Caption = 'Other Travel Type';
        }
        field(36; "Return Date"; Date)
        {
            trigger OnValidate()
            begin
                if Rec."Return Date" < Rec."Date of Travel" then
                    Error('Return Date Cannot be earlier that Departure Date!');
            end;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()

    begin

        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Motor Vehicle Request No.");
            NoSeriesMgt.InitSeries(SeriesSetup."Motor Vehicle Request No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        Rec."Created Date" := CURRENTDATETIME;
        Rec."Created By" := UserId;
        Rec."Date of Request" := Today;


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
        SeriesSetup: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HrEmployees: Record "HR Employees";
        Drivers: Record "HR Drivers";
        UserSetup: Record "User Setup";
        CompanyVehicles: Record "Company Vehicles";
        VehicleRequest: Record "Motor Vehicle Request";
        VehicleMovement: Record "Vehicle Movement";

    procedure AssignDriversAndVehiclesToMovement(VehReq: Record "Motor Vehicle Request")
    begin
        if Confirm('Do you want to assign the selected driver and vehicle to the Vehicle Request?') then begin
            Drivers.RESET;
            Drivers.SetRange(Drivers."No.", Rec."Allocated Driver");
            if Drivers.Find('-') then begin
                if Drivers."Driver Availability" = Drivers."Driver Availability"::Available then begin
                    Drivers."Driver Availability" := Drivers."Driver Availability"::Unavailable;
                    Drivers.Modify;
                    Message('Driver Assigned to the Request');
                end;
            end;

            CompanyVehicles.RESET;
            CompanyVehicles.SetRange(CompanyVehicles."No.", Rec."Allocated Vehicle");
            if CompanyVehicles.Find('-') then begin
                if CompanyVehicles."Movement Status" = CompanyVehicles."Movement Status"::Stationary then begin
                    CompanyVehicles."Movement Status" := CompanyVehicles."Movement Status"::"In Transit";
                    CompanyVehicles.Modify;
                    Message('Vehicle Assigned to Request');
                end;
            end;
        end;
        Message('Request has been Approved!');
    end;
}
