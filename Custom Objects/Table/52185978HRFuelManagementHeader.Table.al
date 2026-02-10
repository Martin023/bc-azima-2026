table 52185978 "HR Fuel Management Header"

{
    LookupPageId = "Motor Vehicle Fueling List";
    DrillDownPageId = "Motor Vehicle Fueling List";

    fields
    {
        field(1; "No."; Code[20])
        {
        trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    MembNoSeries.Get;
                    NoSeriesMgt.TestManual(MembNoSeries."Fueling No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2;"Vehicle No."; Code [20])
        {
            TableRelation = "Company Vehicles"."No.";
            trigger OnValidate()
            begin
                CompanyVehicles.RESET;
                if CompanyVehicles.Get("Vehicle No.") then
                //CompanyVehicles.SetRange(CompanyVehicles."No.", "Vehicle No.");
                //CompanyVehicles.SetRange(CompanyVehicles."Vehicle Status", CompanyVehicles."Vehicle Status"::Active);
               // if CompanyVehicles.Find('-') then
                //begin
                    "Vehicle Registration No." := CompanyVehicles."Registration No.";
                    "Type of Vehicle" := CompanyVehicles."Type of Vehicle";
                    "Name Vehicle" := CompanyVehicles.Description;
                //end;      
            end;
        }
        field(3; "Vehicle Registration No."; Code[20])
        {
        }
        field(4; "Type of Vehicle"; Text[20])
        {
        }
        field(5; "Fuel Type"; Option)
        {
            OptionCaption = ' ,Petrol, Diesel';
            OptionMembers = " ",Petrol, Diesel;
        }
        field(6; "Type Of Payment"; Option)
        {
            OptionCaption = ' ,Card, Cash, Direct Fueling';
            OptionMembers = " ",Card,Cash,"Direct Fueling";
            trigger OnValidate()
            begin
                Rec."Fuel Type" := 0;
                Rec."Date of Fueling" := 0D;
                Rec."Fuel Balance"  := 0;
                Rec.Quantity := 0;
                Rec.Cost := 0;
                Rec."Motor Vehicle Fuel Ceiling" := 0;
                Rec."Petrol Station Name" := '';
                Rec."Card No" := '';
                Rec."Cash Paid" := 0;
                
            end;
        }
        field(7; "Fuel Card Number"; Code[20])
        {
        }
        field(8; "Cash Payment"; Decimal)
        {
        }
        field(9; "Quantity of Fuel"; Decimal)
        {
        }
        field(10; "Total Cost"; Decimal)
        {
        }
        field(11; "Driver Staff No."; Code[20])
        {
            TableRelation = "HR Drivers"."No.";
            Trigger OnValidate()
            begin
                HrDrivers.RESET;
                if HRDrivers.Get("Driver Staff No.") then
                    Rec."Driver Name" := HRDrivers."Driver Name";
                    Rec."Driver No." := HRDrivers.Code; 
            end;
        }
        field(12; "Driver Name"; Text[100])
        {
        }
        field(13; "Motor Vehicle Fuel Ceiling"; Decimal)
        {
        }
        field(14; "Fuel Balance"; Decimal)
        {
        }
        // field(15; "Petrol Station Vendor No"; Code[20])
        // {
        //     TableRelation = Vendor;
        //     trigger OnValidate()
        //     begin
        //         //Vendor.Get();
        //         if Vendor.Find('-') then
        //             "Petrol Station Name" := Vendor.Name;
        //     end;
        // }
        field(16; "Petrol Station Name"; Text[100])
        {
        }
        field(17; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        // field(50009; "Vehicle Fueled"; Code[20])
        // {
        //     trigger OnValidate()
        //     begin
        //         FixedAsset.Reset;
        //         FixedAsset.SetRange(FixedAsset."No.", "Vehicle Registration No.");
        //         if FixedAsset.Find('-') then
        //             "Name Vehicle" := FixedAsset.Description;
        //     end;
        // }
        field(18; "Name Vehicle"; Text[100])
        {
        }
        field(19; "E-Mail"; Text[80])
        {
        }
        field(20; Performance; Text[40])
        {
        }
        field(21; "Source of Fueling"; Text[30])
        {
        }
        field(22; "Fuel Cost"; Decimal)
        {
        }
        field(23; "Fuel Consumed"; Integer)
        {
        }
        field(24; "Date of Fueling"; Date)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Rec."Date of Fueling" > Today then 
                Error('Date cannot be in the future!');
            end;
        }
        field(25; "Card No"; Code[20])
        {
        }
        field(26; "Work Ticket No."; Code[20])
        {
        }
        field(27; "Created at"; DateTime)
        {
        }
        field(28; "Created By"; Code[50])
        {
        }
        field(29; "Cost Center"; Code[20])
        {
        }
        field(30; "Quantity"; Integer)
        {
        }
        field(31; "Cost"; Decimal)
        {
        }
        field(32; "Cash Paid"; Decimal)
        {
        }    
        field(33; Status; Enum "Workflow Status Main Flags")
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
        field(37; "User ID"; Code[50])
        {
        }
        field(38; "Driver No." ; Code[20])
        {
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
    }

    trigger OnInsert()
    var
    SeriesSetup: Record "Credit Nos. Series";
    begin
        //if "No." = '' then begin
            //HrSetup.Get;
            //begin
                //TestNoSeries;
                //NoSeriesMgt.InitSeries(HrSetup."Fuel Maintenance No", xRec."No. Series", 0D, "No.", "No. Series");
            if "No." = '' then 
            begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Fueling No.");
            NoSeriesMgt.InitSeries(SeriesSetup."Fueling No.", xRec."No. Series", 0D, "No.", "No. Series");
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
        FixedAsset: Record "Fixed Asset";
        HrSetup: Record "HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        MembNoSeries: Record "Credit Nos. Series";
        CompanyVehicles: Record "Company Vehicles";
        HRDrivers: Record "HR Drivers";
        Vendor: Record Vendor;
        UserSetup: Record "User Setup";

    local procedure TestNoSeries(): Boolean
    begin
        /*CASE "Document Type" OF
          "Document Type"::Quote:
            PurchSetup.TESTFIELD("Quote Nos.");
        
          "Document Type"::Order:
            PurchSetup.TESTFIELD("Order Nos.");
          "Document Type"::Invoice:
            BEGIN
              PurchSetup.TESTFIELD("Invoice Nos.");
              PurchSetup.TESTFIELD("Posted Invoice Nos.");
            END;
          "Document Type"::"Return Order":
            PurchSetup.TESTFIELD("Return Order Nos.");
          "Document Type"::"Credit Memo":
            BEGIN
              PurchSetup.TESTFIELD("Credit Memo Nos.");
              PurchSetup.TESTFIELD("Posted Credit Memo Nos.");
            END;
          "Document Type"::"Blanket Order":
            PurchSetup.TESTFIELD("Blanket Order Nos.");
        END;
        */

    end;
}

