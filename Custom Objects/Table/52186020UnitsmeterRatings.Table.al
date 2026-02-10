table 52186020 "Units meter Ratings"
{
    DrillDownPageID = "Units Meter Rating";
    LookupPageID = "Units Meter Rating";

    fields
    {
        field(1; "Property No"; Code[30])
        {
            TableRelation = "Property Details";
        }
        field(2; "Floor Code"; Code[30])
        {
        }
        field(3; "Unit Code"; Code[30])
        {
        }
        field(4; "Meter No"; Text[100])
        {
        }
        field(5; "Previous Reading"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(6; "Current Reading"; Decimal)
        {
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                if Confirm('Are you sure you have entered the correct readings', false) = false then begin Error('') end;

            end;
        }
        field(7; Consumption; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(8; "Amount[Bill]"; Decimal)
        {
        }
        field(9; Comments; Text[50])
        {
        }
        field(10; "Discrepancy(Units)"; Decimal)
        {
        }
        field(11; "Discrepancy(Amount)"; Decimal)
        {
        }
        field(12; "Date Of Billing"; Date)
        {
        }
        field(13; "Tenant No."; Code[30])
        {
            TableRelation = Lease."Tenant No.";
        }
        field(14; "Water Bill"; Decimal)
        {
        }
        field(15; "Sewer Bill"; Decimal)
        {
        }
        field(17; "Consumption[Computing]"; Decimal)
        {
        }
        field(21; Water; Boolean)
        {
        }
        field(22; "Sewer charge"; Boolean)
        {
        }
        field(23; "Consumption[ComputingSewer]"; Decimal)
        {
        }
        field(24; "Total Water due"; Decimal)
        {
        }
        field(25; "Total Sewer Due"; Decimal)
        {
        }
        field(26; "Total Due"; Decimal)
        {
        }
        field(27; "Water Billing No"; Code[10])
        {
        }
        field(28; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';

            trigger OnLookup()
            begin

                GenSetup.Reset;
                GenSetup.Get();
                DimVal.Reset;
                DimVal.SetRange(DimVal."Dimension Code", GenSetup."Global Dimension 1 Code");
                if PAGE.RunModal(Page::"Dimension Value List", DimVal) = ACTION::LookupOK then begin
                    "Global Dimension 1 Code" := DimVal.Code;
                end;
            end;
        }
        field(29; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';

            trigger OnLookup()
            begin

                GenSetup.Reset;
                GenSetup.Get();
                DimVal.Reset;
                DimVal.SetRange(DimVal."Dimension Code", GenSetup."Global Dimension 2 Code");
                if PAGE.RunModal(Page::"Dimension Value List", DimVal) = ACTION::LookupOK then begin
                    "Global Dimension 2 Code" := DimVal.Code;
                end;
            end;
        }
        field(30; "G/L Account"; Code[30])
        {
            TableRelation = Charges."Account No.";
        }
        field(31; No; Code[20])
        {
        }
        field(32; "Water Bill No"; Code[20])
        {
            TableRelation = "Nairobi Water Bill"."No.";
        }
        field(33; "Tenant Name"; Text[50])
        {
        }
        field(34; "Property Name"; Text[50])
        {
        }
        field(35; "Meter Rent"; Decimal)
        {
            CalcFormula = Lookup("Common Area Charges"."Meter Rent" WHERE(No = CONST('1')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(36; "C/Area Fixed Charge"; Decimal)
        {
            CalcFormula = Lookup("Common Area Charges"."C/Area Fixed Charge" WHERE(No = CONST('1')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(37; "Nairobi Water Bill No"; Code[20])
        {
            TableRelation = "Nairobi Water Bill"."No.";
        }
        field(38; InvoiceNo; Integer)
        {
        }
        field(39; "Lease No"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Property No", "Nairobi Water Bill No", "Floor Code", "Unit Code")
        {
            Clustered = true;
            SumIndexFields = "Water Bill", "Sewer Bill", Consumption, "Total Water due", "Total Sewer Due";
        }
    }

    fieldgroups
    {
    }

    var
        "Water Rating": Record "Water Billing rate";
        Sewer: Record "Sewer Billing rate";
        keepCount: Integer;
        CurrAmount: Decimal;
        keepCounts: Integer;
        CurrAmountS: Decimal;
        UnitsDetails: Record Lease;
        UnitMReading: Record "Units meter Ratings";
        NairobiWater: Record "Nairobi Water Bill";
        TotalUnits: Integer;
        GSetup: Record "General Setup";
        GenSetup: Record "General Ledger Setup";
        DimVal: Record "Dimension Value";
        UnitMeterRatings: Record "Units meter Ratings";
        Distribution: Decimal;
        propertyDet: Record "Property Details";
        NoOfUnits: Integer;
        Dist1: Decimal;
        Dist2: Decimal;
        Dist3: Decimal;
        WDist: Decimal;
        Dist4: Decimal;
        TotalDist: Decimal;
        DistS1: Decimal;
        DistS2: Decimal;
        DistS3: Decimal;
        WSDist: Decimal;
        DistS4: Decimal;
        TotalDistS: Decimal;

    [Scope('OnPrem')]
    procedure SumConsumption(SConsumption: Decimal) "Sum": Decimal
    begin
        /*
        UnitMeterRatings.RESET;
        UnitMeterRatings.SETRANGE(UnitMeterRatings."Property No","Property No");
        IF UnitMeterRatings.FIND('-') THEN BEGIN
        NairobiWater.RESET;
        NairobiWater.SETRANGE(NairobiWater."Property No.","Property No");
        IF NairobiWater.FIND('-')THEN BEGIN
        REPEAT
         SConsumption:=SConsumption + UnitMeterRatings.Consumption;
         UNTIL  UnitMeterRatings.NEXT=0;
         IF SConsumption>NairobiWater.Consumption THEN BEGIN
         ERROR('Tenants Consumption is More than The Property Consumption');
         END
        END
        END
        */

    end;

    [Scope('OnPrem')]
    procedure TenantsDistribution(): Decimal
    begin

        "Previous Reading" := xRec."Current Reading";
        Consumption := "Current Reading" - "Previous Reading";
        "Consumption[Computing]" := "Current Reading" - "Previous Reading";
        "Consumption[ComputingSewer]" := "Current Reading" - "Previous Reading";
        //17th May
        //Water charge
        propertyDet.Reset;
        propertyDet.SetRange(propertyDet."No.", "Property No");
        if propertyDet.Find('-') then begin
            propertyDet.CalcFields(propertyDet."total Units");
            NoOfUnits := propertyDet."total Units";
        end;
        CurrAmount := "Consumption[Computing]";
        //17th May
        // Compute from the table.
        if Water = true then begin
            repeat
                "Water Rating".Reset;
                if "Water Rating"."Tier Code" = '1' then begin
                    Dist1 := ("Water Rating"."Bill Rate tier" / NoOfUnits);
                    WDist := Dist1 * "Water Rating".Rate;
                    "Total Water due" := "Total Water due" + WDist;
                end else
                    if "Water Rating"."Tier Code" = '2' then begin
                        Dist2 := ("Water Rating"."Bill Rate tier" / NoOfUnits);
                        WDist := Dist2 * "Water Rating".Rate;
                        "Total Water due" := "Total Water due" + WDist;
                    end else
                        if "Water Rating"."Tier Code" = '3' then begin
                            Dist3 := ("Water Rating"."Bill Rate tier" / NoOfUnits);
                            WDist := Dist3 * "Water Rating".Rate;
                            "Total Water due" := "Total Water due" + WDist;
                        end else
                            if "Water Rating"."Tier Code" = '4' then begin
                                TotalDist := Dist1 + Dist2 + Dist3;
                                Dist4 := CurrAmount - TotalDist;
                                WDist := Dist4 * "Water Rating".Rate;
                                "Total Water due" := "Total Water due" + WDist;
                                "Total Due" := "Total Water due" + "Total Sewer Due";

                            end;
            until "Water Rating".Next = 0;
        end;
        //Sewer charge
        // Compute from the table.
        if "Sewer charge" = true then begin
            repeat
                Sewer.Reset;
                if Sewer."Tier Code" = '1' then begin
                    DistS1 := (Sewer."Bill Rate tier" / NoOfUnits);
                    WSDist := DistS1 * Sewer.Rate;
                    "Total Sewer Due" := "Total Sewer Due" + WSDist;
                end else
                    if Sewer."Tier Code" = '2' then begin
                        DistS2 := (Sewer."Bill Rate tier" / NoOfUnits);
                        WSDist := DistS2 * Sewer.Rate;
                        "Total Sewer Due" := "Total Sewer Due" + WSDist;
                    end else
                        if Sewer."Tier Code" = '3' then begin
                            DistS3 := (Sewer."Bill Rate tier" / NoOfUnits);
                            WSDist := DistS3 * Sewer.Rate;
                            "Total Sewer Due" := "Total Sewer Due" + WSDist;
                        end else
                            if Sewer."Tier Code" = '4' then begin
                                TotalDistS := DistS1 + DistS2 + DistS3;
                                DistS4 := CurrAmount - TotalDistS;
                                WSDist := DistS4 * Sewer.Rate;
                                "Total Sewer Due" := "Total Sewer Due" + WSDist;
                                "Total Due" := "Total Water due" + "Total Sewer Due";

                            end;
            until Sewer.Next = 0;
        end;

        "Total Due" := "Total Water due" + "Total Sewer Due" + "Meter Rent" + "C/Area Fixed Charge";
    end;
}

