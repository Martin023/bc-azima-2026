table 52185977 "HR Service Management Lines"
{

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Vehicle Registration No."; Code[10])
        {
            TableRelation = "Fixed Asset";
        }
        field(3; "Vehicle Type"; Option)
        {
            OptionCaption = 'Authority';
            OptionMembers = Authority;
        }
        field(4; "Fuel Type"; Option)
        {
            OptionCaption = ' ,Petrol';
            OptionMembers = " ",Petrol;
        }
        field(5; "Type Of Payment"; Option)
        {
            OptionCaption = ' ,Card, Cash, Direct Fueling';
            OptionMembers = " ",Card," Cash"," Direct Fueling";
        }
        field(6; "Total Cost"; Decimal)
        {
        }
        field(7; "Driver Details"; Code[20])
        {
            TableRelation = "HR Drivers";
        }
        field(107; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50009; "Vendor/Garage"; Code[20])
        {
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                FixedAsset.Reset;
                FixedAsset.SetRange(FixedAsset."No.", "Vehicle Registration No.");
                if FixedAsset.Find('-') then
                    "Name Vehicle" := FixedAsset.Description;
            end;
        }
        field(50010; "Name Vehicle"; Text[100])
        {
        }
        field(50011; "Make/Model"; Text[80])
        {
        }
        field(50012; "Service Instruction"; Text[40])
        {
        }
        field(50013; "Repaire Instruction"; Text[30])
        {
        }
        field(50014; "Fuel Cost"; Decimal)
        {
        }
        field(50015; "Type of fuel"; Text[30])
        {
        }
        field(50016; Kilometers; Integer)
        {
        }
        field(50017; "Date /Time"; DateTime)
        {
        }
        field(50018; "Date of service"; Date)
        {
        }
        field(50019; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if Code = '' then begin
            HrSetup.Get;
            begin
                TestNoSeries;
                NoSeriesMgt.InitSeries(HrSetup."Service Management No", xRec."No. Series", 0D, Code, "No. Series");
            end;
        end;
    end;

    var
        FixedAsset: Record "Fixed Asset";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HrSetup: Record "HR Setup";

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

