table 52187060 "Parking Space"
{
    Caption = 'Parking Management';
    DataClassification = ToBeClassified;
    LookupPageId = "Parking Space List";
    DrilldownPageID = "Parking Space List";


    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    MembNoSeries.Get;
                    NoSeriesMgt.TestManual(MembNoSeries."Parking Space No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Staff No."; Code[20])
        {

            Caption = 'Staff No.';
            TableRelation = "HR Employees"."No.";
            trigger OnValidate()
            begin
                // HREmployees.Reset();
                // HREMployees.Get("No.");
                // if HREmployees."No." <> '' then
                HREmployees.SetRange(HREmployees."No.", "Staff No.");
                if HREmployees.Find('-') then
                    "Staff Full Name" := HREmployees."Full Name";
                "Staff PF Number" := HREmployees."PF No.";
                //"Staff Department" := HREmployees."Department Name";
                "Staff Telephone Number" := HREmployees."Home Phone Number";

            end;
        }
        field(3; "Staff PF Number"; Code[20])
        {
            Caption = 'Staff PF Number';
        }

        field(4; "Staff Full Name"; Text[50])
        {
            Caption = 'Staff Full Name';
        }
        field(5; "Staff Department"; CODE[20])
        {
            Caption = 'Staff Department';
            TableRelation = "Responsibility CenterBR";
        }
        field(6; "Staff Telephone Number"; code[20])
        {
            Caption = 'Staff Telephone Number';
        }
        field(7; "External Client No."; Code[20])
        {
            Caption = 'External Client No.';
            TableRelation = Customer."No." where("Account Type" = CONST("Parking Customer"));

            trigger OnValidate()
            begin
                Customer.Reset();
                //Customer.Get("External Client No.");
                Customer.SetRange("No.", "External Client No.");
                Customer.SetRange("Account Type", Customer."Account Type"::"Parking Customer");
                if Customer.find('-') then begin
                    "External Client Details" := Customer."Name";
                end;
            end;
        }
        field(8; "External Client Details"; Text[50])
        {
            Caption = 'External Client Name';
        }
        field(9; "Parking Slot"; Code[20])
        {
            Caption = 'Parking Slot';
            TableRelation = "Parking List Table".No WHERE("Parking Slot Status" = CONST("Available"), "Parking Area" = FIELD("Parking Area"));
            Trigger OnValidate()
            begin
                ParkingList.RESET;
                ParkingList.SetRange(ParkingList.No, "Parking Slot");
                if ParkingList.Find('-') then
                    "Parking Slot Number Allocated" := ParkingList."Parking Slot Number";
            end;
        }
        field(10; "Parking Area Allocated"; Option)
        {
            Caption = 'Parking Area Allocated ';
            OptionMembers = " ",B1,B2,B3;
        }
        field(11; "Parking Slot Number Allocated"; Integer)
        {
            Caption = 'Parking Slot Number Allocated';
        }
        field(12; "Available Parking Slots"; Integer)
        {
            Caption = 'Available Parking Slots';
            TableRelation = "Parking List Table";

            CalcFormula = COUNT("Parking List Table" WHERE("Parking Slot Status" = CONST(Available), "Parking Area" = FIELD("Parking Area")));
            FieldClass = FlowField;
        }
        field(13; "Tenant Payment Schedule"; Option)
        {
            Caption = 'Tenant Payment Schedule';
            OptionMembers = Monthly,Quarterly,Annually;
        }
        field(14; "Expected Payment amounts"; Decimal)
        {
            Caption = 'Expected Payment amounts';
        }
        field(15; "Expected Pyament Date"; Date)
        {
            Caption = 'Expected Pyament Date';
        }
        field(16; "Last Payment Date"; Date)
        {
            Caption = 'Last Payment Date';
        }
        field(17; "Last Payment Amount"; Decimal)
        {
            Caption = 'Last Payment Amount';
        }
        field(18; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
        }
        field(19; "Status"; Enum "Workflow Status Main Flags")
        {
        }
        field(20; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            trigger OnValidate()
            begin

            end;
        }
        field(21; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            trigger OnValidate()
            begin

            end;
        }
        field(22; "Responsibility Centre"; Code[20])
        {
            Description = 'LookUp to Responsibility Center BR';
            TableRelation = "Responsibility Center";
        }

        field(23; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
        }
        field(24; "Client"; Option)
        {
            Caption = 'Client';
            OptionCaption = ' ,Internal(Staff), External';
            OptionMembers = " ","Internal(Staff)","External";
        }
        field(25; "Created at"; DateTime)
        {
            Caption = 'Created at';
        }
        field(26; "Approved by"; Code[50]) { }
        field(27; "Booking Status"; Option)
        {
            OptionMembers = Open,Assigned,Closed;
        }
        field(28; "Vehicle Registration No."; Code[20])
        {
            Caption = 'Vehicle Registration No.';
        }
        field(29; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(30; "New Parking Slot"; Code[20])
        {
            Caption = 'New Parking Slot';
            TableRelation = "Parking List Table".No WHERE("Parking Slot Status" = CONST("Available"), "Parking Area" = FIELD("New Parking Area"));
            trigger OnValidate()
            begin
                ParkingList.RESET;
                ParkingList.SetRange(ParkingList.No, "Parking Slot");
                if ParkingList.Find('-') then
                    "New Parking Slot Number" := ParkingList."Parking Slot Number";
            end;
        }
        field(31; "New Parking Area Allocated"; Option)
        {
            Caption = 'New Parking Area Allocated ';
            OptionMembers = " ",B1,B2,B3;
        }
        field(32; "New Parking Slot Number"; Integer)
        {
            Caption = 'New Parking Slot Number Allocated';
        }
        field(33; "New Vehicle Registration No."; Code[20])
        {
            Caption = 'New Vehicle Registration No.';
        }
        field(34; Realocated; Boolean)
        {
            Caption = 'Realocated';
        }
        field(35; "Reallocation Reasons"; Text[250])
        {
            Caption = 'Reallocation Reasons';
        }
        field(36; "Parking Area"; Option)
        {
            OptionMembers = "",B1,B2,B3;

            trigger OnValidate()
            begin
                CalcFields("Available Parking Slots");
            end;
        }
        field(37; "New Parking Area"; Option)
        {
            OptionMembers = "",B1,B2,B3;
            trigger OnValidate()
            begin
                CalcFields("Available Parking Slots");
            end;
        }
        field(38; "Realloaction Options"; Option)
        {
            OptionMembers = " ","Change Parking Slot","Change Vehicle","Change Both";
        }
        field(39; "Available Parking Slots II"; Integer)
        {
            Caption = 'Available Parking Slots II';
            TableRelation = "Parking List Table";
            CalcFormula = COUNT("Parking List Table" WHERE("Parking Slot Status" = CONST(Available), "Parking Area" = FIELD("New Parking Area")));
            FieldClass = FlowField;
        }
        field(40; Department; Code[20])
        {
            TableRelation = "Responsibility CenterBR";
        }
        field(41; "Send/Forward to"; Code[50])
        {
            TableRelation = "Responsibility CenterBR";
        }

        field(42; "Originating Department"; Code[50])
        {
            Editable = false;
        }
        field(43; "Current Department"; Code[50])
        {
            Editable = false;
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
            SeriesSetup.TestField(SeriesSetup."Parking Space No.");
            "No." := NoSeriesMgt.GetNextNo(SeriesSetup."Parking Space No.");
            // NoSeriesMgt.InitSeries(SeriesSetup."Parking Space No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        Rec."Created at" := CURRENTDATETIME;
        Rec."Created By" := UserId;

        "User ID" := UserId;
        "Created By" := UserId;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Centre" := UserSetup."Responsibility Centre";
            UserSetup.TestField("Responsibility Centre");
            "Originating Department" := UserSetup."Responsibility Centre";
            "Current Department" := UserSetup."Responsibility Centre";
            CFPage.InsertTracker("No.", "Originating Department", true, UserId, CurrentDateTime);
        end;
    end;


    var
        MembNoSeries: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit "No. Series";
        HREmployees: Record "HR Employees";
        Customer: Record Customer;
        ParkingList: Record "Parking List Table";
        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;
}
