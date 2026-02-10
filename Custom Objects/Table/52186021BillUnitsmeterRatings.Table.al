table 52186021 "Bill Units meter Ratings"
{
    DrillDownPageID = "Bill Unit Meter Ratings";
    LookupPageID = "Bill Unit Meter Ratings";

    fields
    {
        field(1; "Property No"; Code[30])
        {
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
        }
        field(6; "Current Reading"; Decimal)
        {

            trigger OnValidate()
            begin

                "Previous Reading" := xRec."Current Reading";
                Consumption := "Current Reading" - "Previous Reading";
                "Consumption[Computing]" := "Current Reading" - "Previous Reading";
                "Consumption[ComputingSewer]" := "Current Reading" - "Previous Reading";
                keepCount := 0;
                keepCounts := 0;
                // Compute from the table.
                if Water = true then begin
                    "Water Rating".Reset;
                    if "Water Rating".FindFirst then begin
                        if "Consumption[Computing]" < "Water Rating"."Bill Rate tier" then exit;
                        NairobiWater.Reset;
                        NairobiWater.SetRange(NairobiWater."Property No.", "Property No");
                        if NairobiWater.Find('-') then begin
                            //NairobiWater.CALCFIELDS(NairobiWater."Total No Of Units");
                            TotalUnits := NairobiWater."Total No Of Units";
                        end;

                        repeat
                            keepCount += 1;
                            CurrAmount := ("Consumption[Computing]");
                            if "Consumption[Computing]" = 0 then exit;
                            if keepCount = "Water Rating".Count then
                                "Consumption[Computing]" := CurrAmount
                            else
                                if CurrAmount >= "Water Rating"."Bill Rate tier" then
                                    CurrAmount := "Water Rating"."Bill Rate tier"
                                else
                                    CurrAmount := CurrAmount;

                            "Total Water due" := "Total Water due" + (((CurrAmount / TotalUnits) * ("Water Rating".Rate)));
                            "Consumption[Computing]" := "Consumption[Computing]" - CurrAmount;
                            Message(Format(CurrAmount));
                        until "Water Rating".Next = 0;
                    end;
                end;

                if "Sewer charge" = true then begin
                    Sewer.Reset;
                    if Sewer.FindFirst then begin
                        if "Consumption[ComputingSewer]" < Sewer."Bill Rate tier" then exit;
                        repeat
                            keepCounts += 1;
                            CurrAmountS := "Consumption[ComputingSewer]";
                            if "Consumption[ComputingSewer]" = 0 then exit;
                            if keepCounts = Sewer.Count then
                                "Consumption[ComputingSewer]" := CurrAmountS
                            else
                                if CurrAmountS >= Sewer."Bill Rate tier" then
                                    CurrAmountS := Sewer."Bill Rate tier"
                                else
                                    CurrAmountS := CurrAmountS;
                            "Total Sewer Due" := "Total Sewer Due" + (CurrAmountS * (Sewer.Rate));
                            "Consumption[ComputingSewer]" := "Consumption[ComputingSewer]" - CurrAmountS;

                        until Sewer.Next = 0;
                    end;


                end;
                "Total Due" := "Total Water due" + "Total Sewer Due";
            end;
        }
        field(7; Consumption; Decimal)
        {
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

            trigger OnValidate()
            begin
                Charges.Reset;
                Charges.SetRange(Charges."Account No.", "G/L Account");
                if Charges.Find('-') then begin
                    "G/L Description" := Charges.Name;
                end
            end;
        }
        field(31; Select; Boolean)
        {
        }
        field(32; "G/L Description"; Text[30])
        {
        }
        field(33; Posted; Boolean)
        {
            Editable = true;
        }
        field(34; "B/Hole water bill No."; Code[20])
        {
            TableRelation = "B/Hole Water Bill"."No.";
        }
        field(35; "Invoice No."; Integer)
        {
        }
        field(36; "Posting Date"; Date)
        {
        }
        field(37; "Tenant Name"; Text[200])
        {
        }
        field(38; "Property Name"; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "B/Hole water bill No.", "Invoice No.")
        {
            Clustered = true;
            SumIndexFields = "Water Bill", "Sewer Bill";
        }
        key(Key2; "Tenant No.")
        {
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
        Charges: Record Charges;
}

