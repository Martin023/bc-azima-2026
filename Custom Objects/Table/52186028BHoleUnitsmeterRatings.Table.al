table 52186028 "B/Hole Units meter Ratings"
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

                // TenantsDistribution;
                // SumConsumption(Consumption);
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
        }
        field(31; No; Code[20])
        {
        }
        field(32; "Water Bill No"; Code[20])
        {
            TableRelation = "B/Hole Water Bill"."No.";
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
        field(37; "line no"; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Water Bill No", "line no")
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
        BHcharges: Record "Common Area Charges";

    [Scope('OnPrem')]
    procedure SumConsumption(SConsumption: Decimal) "Sum": Decimal
    begin

        UnitMeterRatings.Reset;
        UnitMeterRatings.SetRange(UnitMeterRatings."Property No", "Property No");
        if UnitMeterRatings.Find('-') then begin
            NairobiWater.Reset;
            NairobiWater.SetRange(NairobiWater."Property No.", "Property No");
            if NairobiWater.Find('-') then begin
                repeat
                    SConsumption := SConsumption + UnitMeterRatings.Consumption;
                until UnitMeterRatings.Next = 0;
                if SConsumption > NairobiWater.Consumption then begin
                    Error('Tenants Consumption is More than The Property Consumption');
                end
            end
        end
    end;

    [Scope('OnPrem')]
    procedure TenantsDistribution(): Decimal
    begin

        "Previous Reading" := xRec."Current Reading";
        Consumption := "Current Reading" - "Previous Reading";
        if "Current Reading" < "Previous Reading" then
            Error('Current Reading CANNOT be less than Previous Reading');

        "Consumption[Computing]" := "Current Reading" - "Previous Reading";
        "Consumption[ComputingSewer]" := "Current Reading" - "Previous Reading";
        keepCount := 0;
        keepCounts := 0;
        // Compute from the table.
        if Water = true then begin
            "Water Rating".Reset;
            if "Water Rating".FindFirst then begin
                if "Consumption[Computing]" < "Water Rating"."Bill Rate tier" then begin
                    //LESS THAN 10
                    CurrAmount := ("Consumption[Computing]");
                    "Total Water due" := "Total Water due" + (CurrAmount * ("Water Rating".Rate));
                    "Consumption[Computing]" := "Consumption[Computing]" - CurrAmount;
                    //END LESS THAN 10
                end else
                    repeat
                        keepCount += 1;
                        CurrAmount := "Consumption[Computing]";
                        //IF "Consumption[Computing]"=0 THEN EXIT;
                        if keepCount = "Water Rating".Count then
                            "Consumption[Computing]" := CurrAmount
                        else
                            if CurrAmount >= "Water Rating"."Bill Rate tier" then
                                CurrAmount := "Water Rating"."Bill Rate tier"
                            else
                                CurrAmount := CurrAmount;
                        "Total Water due" := "Total Water due" + (CurrAmount * ("Water Rating".Rate));
                        "Consumption[Computing]" := "Consumption[Computing]" - CurrAmount;
                        "Total Due" := "Total Water due" + "Total Sewer Due";
                    until "Water Rating".Next = 0;
            end;
        end;

        if "Sewer charge" = true then begin
            CurrAmountS := "Consumption[ComputingSewer]";
            BHcharges.Reset;
            BHcharges.SetRange(BHcharges.No, '2');
            if BHcharges.Find('-') then begin
                "Total Sewer Due" := "Total Sewer Due" + (BHcharges."B/Hole Average Sewer Charge" * CurrAmountS);
            end
        end;
        "Total Due" := "Total Water due" + "Total Sewer Due" + "Meter Rent" + "C/Area Fixed Charge";
    end;
}

