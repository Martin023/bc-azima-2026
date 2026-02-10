table 52185561 "HR OSAccident"
{
    LookupPageId ="HR OSAccident List";
    DrillDownPageId = "HR OSAccident Card";
    Caption = 'Accidents Table';

    fields
    {
        field(1; "Accident No."; Code[10])
        {
        trigger OnValidate()
        var
        NoSeriesMgt: Codeunit NoSeriesManagement;
            begin
                if "Accident No." <> xRec."Accident No." then begin
                    MembNoSeries.Get;
                    NoSeriesMgt.TestManual(MembNoSeries."Fueling No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Description; Text[100])
        {
        }
        field(3; "Accident Date"; Date)
        {
            trigger OnValidate()
            begin
                if "Accident Date" > Today then begin
                    Error('Accident Date Cannot be in the future!')
                end;
            end;
        }
        field(4; "Accident Time"; Time)
        {
        }
        field(5; "Accident Location"; Text[100])
        {
        }
        field(6; "Extent of damages"; Text[250])
        {
        }
        field(31; "Driver Staff No."; Code[20])
        {
          
        }
        field(7; "MNS Driver Name"; Text[100])
        {
        }
        field(8; "MNS Driver ID No."; Integer)
        {
        }
        field(9; "MNS Driver Phone No.";Code[20])
        {
        }
        field(10; "Other Party Driver Name"; Text[100])
        {
        }
        field(11; "Other Party Driver ID No."; CODE[100])
        {
        }
        field(12; "Other Party Phone No."; Code[20])
        {
        }
        field(21; "Other Party Phone No. 2"; Code[20])
        {
        }
        field(13; "Other Party Vehicle No."; Text[100])
        {
        }
        field(19; "Other Party Vehicle No. 2"; Text[100])
        {
        }
        field(14; "MNS Vehicle No."; Text[100])
        {
            TableRelation = "Company Vehicles"."No.";
            

            trigger OnValidate();
            begin
                CompanyVehicles.RESET();
                //CompanyVehicles.SetRange("Registration No.", CompanyVehicles."Registration No.");
                if CompanyVehicles.Get("MNS Vehicle No.") then
                //if CompanyVehicles.Find('-') then begin
                    //"MNS Vehicle Make" := CompanyVehicles."Vehicle Make";
                    "MNS Vehicle Make" := CompanyVehicles.Description;
                    "Registration No." := CompanyVehicles."Registration No.";
                //end
            end;

        }
        field(15; "MNS Vehicle Inusrance"; Option)
        {
            OptionMembers = "", Comprehensive, "Third Party";
            OptionCaption = ' " " , Comprehensive, Third Party';
        }
        field(16; "SACCO Vehicle Insurance"; Option)
        {
            OptionMembers = "", Comprehensive, "Third Party";
            OptionCaption = ' , Comprehensive, Third Party';
        }
        field(17; "Other Party Vehicle Inurance 2"; Option)
        {
            OptionMembers = " ", Comprehensive, "Third Party";
            OptionCaption =  ' ,Comprehensive, Third Party';
        }
        field(18; "Other Party Involved"; Boolean)
        {
        }
        field(23; "Other Party Driver Name 2"; Text[100])
        {
        }
        field(24; "Other Party Driver ID No. 2"; CODE[100])
        {
        }
        field(25; "MNS Vehicle Make"; Code[100])
        {
            //OptionMembers = "","Toyota","Nissan","Mitsubishi","Isuzu","Mercedes Benz","BMW","Volkswagen","Ford","Mazda","Honda","Suzuki","Hyundai","Land Rover","Range Rover","Peugeot","Audi","Volvo","Subaru","Lexus","Chevrolet","Tata","Other";
        }
        field(26; "Other Party Vehicle Make"; Option)
        {
            OptionMembers = "","Toyota","Nissan","Mitsubishi","Isuzu","Mercedes Benz","BMW","Volkswagen","Ford","Mazda","Honda","Suzuki","Hyundai","Land Rover","Range Rover","Peugeot","Audi","Volvo","Subaru","Lexus","Chevrolet","Tata","Other";
        }
        field(27; "Other Party Vehicle Make 2"; Text[100])
        {
        }
        field(28; "Other Party Vehicle Insurance2"; Option)
        {
            OptionMembers = "", Comprehensive, "Third Party";
            OptionCaption = ' , Comprehensive, Third Party';
        }
        field(29; "Created By"; Code[50])
        {
        }
        field(30; "Created at"; DateTime)
        {
        }
        field(32; Status;  Enum "Workflow Status Main Flags")
        {
        }
        
        field(22; "No. Series"; Code[10])
        {
        }
        field(34; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(35; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(36; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility CenterBR";
        }
        field(37; "User ID"; Code[50]){}
        field(38; "Registration No."; Code[50]){}
        field(39; "Type of Accident"; Option)
        {
            OptionMembers =  " ", "Single Collision", "Multiple Collision";
            OptionCaption = ' , Single Collision, Multiple Collision';
        }
        field(40; "Driver No."; Code[50])
        {
            TableRelation = "HR Drivers"."No.";
            Trigger OnValidate()
            begin
                HRDrivers.Reset();
                //HRDrivers.Get("Driver Staff No.");
                //HRDrivers.SetRange("No.", "Driver Staff No.");
                //if HRDrivers.Get('-') then
                if HRDrivers.Get("Driver No.") then begin
                    "Driver Staff No." := HRDrivers.Code;
                    "MNS Driver Name" := HRDrivers."Driver Name";
                    "MNS Driver ID No." := HRDrivers."Driver ID No.";
                    "MNS Driver Phone No." := HRDrivers."Driver Phone No.";
                end; 
            end;
        }
    }

    keys
    {
        key(PK1; "Accident No.")
        {
            Clustered = true;
        }
    }
    Trigger OnInsert()
        var
        UserSetup: Record "User Setup";
        SeriesSetup: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    
    begin
            if "Accident No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Accident No.");
            NoSeriesMgt.InitSeries(SeriesSetup."Accident No.", xRec."No. Series", 0D, "Accident No.", "No. Series");
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
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end;
    end;

var
MembNoSeries: Record "Credit Nos. Series";
NoSeriesMgt: Codeunit NoSeriesManagement;
HRDrivers: Record "HR Drivers";
CompanyVehicles: Record "Company Vehicles";
SingleCollisionVisible : Boolean;
MultipleCollisionVisible: Boolean;
}




