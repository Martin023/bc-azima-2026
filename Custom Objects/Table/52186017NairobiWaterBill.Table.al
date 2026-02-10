table 52186017 "Nairobi Water Bill"
{
    LookupPageID = "B/hole Water Bill List";

    fields
    {
        field(1; "Property No."; Code[30])
        {
            TableRelation = "Property Details"."No.";

            trigger OnValidate()
            begin
                GSetup.Get();

                PropDetails.Reset;
                PropDetails.SetRange(PropDetails."No.", "Property No.");
                if PropDetails.Find('-') then begin
                    "L/R No." := PropDetails."L.R. No.";
                    PropDetails.CalcFields(PropDetails."total Units[Occupied]");
                    "Total No Of Units" := PropDetails."total Units[Occupied]";


                    UnitsDetails.Reset;
                    UnitsDetails.SetRange(UnitsDetails."Property No.", "Property No.");
                    UnitsDetails.SetFilter(Blocked, '%1', false);
                    UnitsDetails.SetFilter(Commenced, '%1', true);

                    if UnitsDetails.Find('-') then begin
                        //update meter details
                        Invoice := GSetup.NairobiInv;

                        repeat

                            UnitMReading.Init;
                            UnitMReading.InvoiceNo := Invoice;
                            UnitMReading."Lease No" := UnitsDetails."No.";
                            UnitMReading."Nairobi Water Bill No" := "No.";
                            UnitMReading."Property No" := UnitsDetails."Property No.";
                            UnitMReading."Property Name" := UnitsDetails."Property Name";
                            UnitMReading."Floor Code" := UnitsDetails."Floor No.";
                            UnitMReading."Unit Code" := UnitsDetails."Unit Code";
                            UnitMReading."Meter No" := UnitsDetails."Meter No.";
                            UnitMReading."Tenant No." := UnitsDetails."Tenant No.";
                            UnitMReading."Tenant Name" := UnitsDetails."Tenant Name";
                            UnitMReading.Water := Water;
                            UnitMReading."Sewer charge" := "Sewer charge";
                            UnitMReading."Global Dimension 1 Code" := UnitsDetails."Global Dimension 1 Code";
                            UnitMReading."Global Dimension 2 Code" := UnitsDetails."Global Dimension 2 Code";
                            UnitMReading."Previous Reading" := UnitsDetails."Nairobi Pr Reading";
                            UnitMReading."Current Reading" := UnitsDetails."Nairobi Cur Reading";
                            UnitMReading.Consumption := 0;
                            UnitMReading."Total Water due" := 0;
                            UnitMReading."Total Sewer Due" := 0;
                            UnitMReading."Total Due" := 0;

                            UnitMReading.Insert(true);
                            UnitMReading.Modify;
                            Invoice := Invoice + 1;
                        until UnitsDetails.Next = 0;
                    end;
                    GSetup.NairobiInv := Invoice;
                    GSetup.Modify;


                end;
            end;
        }
        field(2; "Meter Category"; Option)
        {
            OptionCaption = ' ,Residential,Commercial';
            OptionMembers = " ",Residential,Commercial;
        }
        field(3; "L/R No."; Code[80])
        {
        }
        field(4; "Account No.[Bill Account]"; Decimal)
        {
        }
        field(5; "Bill No."; Decimal)
        {
        }
        field(6; "Property Sequence"; Decimal)
        {
        }
        field(7; "Meter Reading Date"; Date)
        {
        }
        field(8; "Bill Item"; Option)
        {
            OptionCaption = ' ,Water,Sewer';
            OptionMembers = " ",Water,Sewer;
        }
        field(9; "Meter No."; Integer)
        {
        }
        field(10; "Previous Reading"; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(11; "Current[Present] reading"; Decimal)
        {
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                if Confirm('Are you sure you have entered the correct readings', false) = false then begin Error('') end;
                "Previous Reading" := xRec."Current[Present] reading";
                Consumption := "Current[Present] reading" - "Previous Reading";
                "Consumption[Computing]" := "Current[Present] reading" - "Previous Reading";
                "Consumption[ComputingSewer]" := "Current[Present] reading" - "Previous Reading";
                keepCount := 0;
                keepCounts := 0;
                // Compute from the table.
                if Water = true then begin
                    "Water Rating".Reset;
                    if "Water Rating".FindFirst then begin
                        if "Consumption[Computing]" < "Water Rating"."Bill Rate tier" then begin
                            //less than 10
                            CurrAmount := "Consumption[Computing]";
                            "Total Water due" := "Total Water due" + (CurrAmount * ("Water Rating".Rate));
                            "Consumption[Computing]" := "Consumption[Computing]" - CurrAmount;

                        end else
                            //End less than 10
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
                            //"Total Due":="Total Water due"+"Total Sewer Due";
                            until "Water Rating".Next = 0;
                    end;
                end;

                if "Sewer charge" = true then begin
                    Sewer.Reset;
                    if Sewer.FindFirst then begin
                        if "Consumption[ComputingSewer]" < Sewer."Bill Rate tier" then begin
                            //less than 10
                            CurrAmountS := "Consumption[ComputingSewer]";
                            "Total Sewer Due" := "Total Sewer Due" + (CurrAmountS * (Sewer.Rate));
                            "Consumption[ComputingSewer]" := "Consumption[ComputingSewer]" - CurrAmountS;
                        end else
                            //end less than 10
                            repeat
                                keepCounts += 1;
                                CurrAmountS := "Consumption[ComputingSewer]";
                                //IF "Consumption[ComputingSewer]"=0 THEN EXIT;
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
        field(12; Consumption; Decimal)
        {
            DecimalPlaces = 0 : 0;
        }
        field(13; "Charge[KES.]"; Decimal)
        {
        }
        field(14; "Total Water due"; Decimal)
        {
        }
        field(15; "Due Date"; Date)
        {
        }
        field(16; "Billing date"; Date)
        {
        }
        field(17; "Consumption[Computing]"; Decimal)
        {
        }
        field(18; "Total Sewer Due"; Decimal)
        {
        }
        field(19; "Total Due"; Decimal)
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
        field(24; "Total No Of Units"; Integer)
        {
        }
        field(25; "Units Total [Water]"; Decimal)
        {
            CalcFormula = Sum("Units meter Ratings"."Total Water due" WHERE("Property No" = FIELD("Property No.")));
            FieldClass = FlowField;
        }
        field(26; "Units total [Sewer]"; Decimal)
        {
            CalcFormula = Sum("Units meter Ratings"."Total Sewer Due" WHERE("Property No" = FIELD("Property No.")));
            FieldClass = FlowField;
        }
        field(27; "No."; Code[30])
        {
        }
        field(28; "No. Series"; Code[20])
        {
        }
        field(29; "billed tenants"; Boolean)
        {
        }
        field(30; "Water Account"; Code[10])
        {
            TableRelation = Charges."Account No.";
        }
        field(31; "Water Description"; Text[100])
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Property No.", "Meter Reading Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            GSetup.Get();
            GSetup.TestField(GSetup."Water billing No.");
            NoSeriesMgt.InitSeries(GSetup."Water billing No.", xRec."No. Series", Today, "No.", "No. Series");
        end;
    end;

    var
        PropDetails: Record "Property Details";
        "Water Rating": Record "Water Billing rate";
        Sewer: Record "Sewer Billing rate";
        keepCount: Integer;
        CurrAmount: Decimal;
        keepCounts: Integer;
        CurrAmountS: Decimal;
        UnitsDetails: Record Lease;
        UnitMReading: Record "Units meter Ratings";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GSetup: Record "General Setup";
        Leaseline: Record "Lease Line";
        CAreaCharge: Record "Common Area Charges";
        Invoice: Integer;
        Charges: Record Charges;
}

