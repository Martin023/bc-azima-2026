table 52186009 "Lease Line"
{
    fields
    {
        field(1; "Line No"; Integer)
        {
        }
        field(2; "Lease No."; Code[20])
        {
            TableRelation = Lease."No.";
        }
        field(3; "Charge No."; Code[20])
        {
            NotBlank = true;
            TableRelation = Charges.Code;

            trigger OnValidate()
            begin
                Charge.Reset;
                Charge.SetRange(Charge.Code, "Charge No.");
                if Charge.Find('-') then begin
                    "Charge Name" := Charge.Name;
                    "Transaction Code" := Charge.Code;
                    "Charge Once" := Charge."Charge Once";
                    "IsService Charge" := Charge."IsService Charge";
                end;

                Lease.Reset;
                Lease.SetRange(Lease."No.", "Lease No.");
                if Lease.Find('-') then begin
                    Rec."Currency Code" := Lease."Currency Code";
                    Rec."Review Start Date" := Lease."Lease Start Date";
                    Rec."Area Square ft" := Lease."Size in Sq. Ft.";
                    "Review Frequency" := Lease."Escalation Frequency";
                    // "Review Start Date" := CalcDate('+1Y', Lease."Lease Commence Date");
                    "Review Start Date" := CalcDate(Lease."Escalation Frequency", Lease."Lease Commence Date");
                    "Review Rate" := Lease."Escalation For Leases";
                    

                    //if Charge."Is Rent" then begin
                    //Rec.Review := true; 


                    //"Review Rate" := Lease."Escalation For Leases";

                    //Customer.Get(Lease."Tenant No.");
                    //Rec."Review Start Date" := Customer."Start Date";
                    //"Review End Date" := Customer."End Date";
                    //"Review Rate" := Customer."Escalation For Leases";

                    //end
                end;
            end;
        }
        field(4; "Charge Name"; Text[100])
        {
            Editable = false;
        }
        field(6; "Charge Once"; Boolean)
        {
        }
        field(7; Review; Boolean)
        {
        }
        field(8; "Review Start Date"; Date)
        {

            trigger OnValidate()
            begin
                Lease.Reset;
                Lease.SetRange(Lease."No.", "Lease No.");
                if Lease.Find('-') then
                    if "Review Start Date" >= Lease."Expiry Date" then
                        Error('The Review Start Date is Beyond the Lease Expiry Date');


                // Lease.Reset;
                // Lease.SetRange(Lease."No.", "Lease No.");
                // if Lease.Find('-') then
                //     if Review = true then
                //         "Review End Date" := Lease."Expiry Date";
            end;
        }
        field(9; "Review Frequency"; DateFormula)
        {
            // OptionCaption = 'Days,Weeks,Months,Quarters,Years';
            // OptionMembers = Days,Weeks,Months,Quarters,Years;
        }
        field(10; "Review Frequency Value"; Integer)
        {
        }
        field(11; "Review End Date"; Date)
        {
        }
        field(12; "Review Rate"; Decimal)
        {
        }
        field(14; "Net Amount"; Decimal)
        {
        }
        field(15; GLAccount; Code[20])
        {
        }
        field(19; "Area Square ft"; Decimal)
        {
            CalcFormula = Lookup(Lease."Area square ft" WHERE("No." = FIELD("Lease No.")));
            FieldClass = FlowField;
        }
        field(20; "Current Monthly Rent"; Decimal)
        {
        }
        field(21; "Current Service Charge"; Decimal)
        {
        }
        field(22; "Amount Exclusive VAT"; Decimal)
        {

            trigger OnValidate()
            begin
                /*
                //consider currency
                Lease.RESET;
                Lease.SETRANGE(Lease."No.","Lease No.");
                IF Lease.FIND('-')THEN BEGIN
                IF Lease."Currency Code" <> '' THEN BEGIN
                
                  "Amount Exclusive VAT" :=
                    ROUND(
                      CurrExchRate.ExchangeAmtLCYToFCY(
                        GetDate,Lease."Currency Code",
                        "Amount Exclusive VAT",Lease."Currency Factor"),
                      Currency."Unit-Amount Rounding Precision")
                END;
                END;*/


                if Confirm('Are you sure you have entered the correct Charge?', false) = false then begin Error('') end;
                Charge.Reset;
                Charge.SetRange(Charge.Code, "Charge No.");
                if Charge.Find('-') then begin
                    if Charge.Vatable = true then

                        //charges based on quarterly,annually and monthly
                        Lease.Reset;
                    Lease.SetRange(Lease."No.", "Lease No.");
                    if Lease.Find('-') then begin

                        if (Lease."Billing Frequency" = Lease."Billing Frequency"::Quarterly) and (Charge."Charge Once" = true) then begin
                            //charge once item for quarterly
                            Quantity := 1;
                            AExclVAT := "Amount Exclusive VAT" * Quantity;
                            "VAT Amount" := ((Charge."VAT Percentage(%)" / 100) * AExclVAT);
                            VATAmount := "VAT Amount";
                            TOTAL := VATAmount + AExclVAT;
                            "Amount Exclusive VAT" := AExclVAT;
                            "Total Amount Inclusive VAT" := TOTAL;
                            "Contract Amount" := TOTAL;
                        end else
                            if (Lease."Billing Frequency" = Lease."Billing Frequency"::Quarterly) and (Charge."Charge Once" = false) then begin
                                Quantity := 3;
                                AExclVAT := "Amount Exclusive VAT" * Quantity;
                                "VAT Amount" := ((Charge."VAT Percentage(%)" / 100) * AExclVAT);
                                VATAmount := "VAT Amount";
                                TOTAL := VATAmount + AExclVAT;
                                "Amount Exclusive VAT" := AExclVAT;
                                "Total Amount Inclusive VAT" := TOTAL;
                                "Contract Amount" := TOTAL;
                                //end of quarterly
                            end;

                        if (Lease."Billing Frequency" = Lease."Billing Frequency"::"Semi Annually") and (Charge."Charge Once" = true) then begin
                            //charge once item for quarterly
                            Quantity := 1;
                            AExclVAT := "Amount Exclusive VAT" * Quantity;
                            "VAT Amount" := ((Charge."VAT Percentage(%)" / 100) * AExclVAT);
                            VATAmount := "VAT Amount";
                            TOTAL := VATAmount + AExclVAT;
                            "Amount Exclusive VAT" := AExclVAT;
                            "Total Amount Inclusive VAT" := TOTAL;
                            "Contract Amount" := TOTAL;
                        end else
                            if (Lease."Billing Frequency" = Lease."Billing Frequency"::"Semi Annually") and (Charge."Charge Once" = false) then begin
                                Quantity := 6;
                                AExclVAT := "Amount Exclusive VAT" * Quantity;
                                "VAT Amount" := ((Charge."VAT Percentage(%)" / 100) * AExclVAT);
                                VATAmount := "VAT Amount";
                                TOTAL := VATAmount + AExclVAT;
                                "Amount Exclusive VAT" := AExclVAT;
                                "Total Amount Inclusive VAT" := TOTAL;
                                "Contract Amount" := TOTAL;
                                //end of Biannually
                            end;

                        //start of annually
                        if (Lease."Billing Frequency" = Lease."Billing Frequency"::Annually) and (Charge."Charge Once" = true) then begin
                            //charge once item for quarterly
                            Quantity := 1;
                            AExclVAT := "Amount Exclusive VAT" * Quantity;
                            "VAT Amount" := ((Charge."VAT Percentage(%)" / 100) * AExclVAT);
                            VATAmount := "VAT Amount";
                            TOTAL := VATAmount + AExclVAT;
                            "Amount Exclusive VAT" := AExclVAT;
                            "Total Amount Inclusive VAT" := TOTAL;
                            "Contract Amount" := TOTAL;
                        end else
                            if (Lease."Billing Frequency" = Lease."Billing Frequency"::Annually) and (Charge."Charge Once" = false) then begin
                                Quantity := 12;
                                AExclVAT := "Amount Exclusive VAT" * Quantity;
                                "VAT Amount" := ((Charge."VAT Percentage(%)" / 100) * AExclVAT);
                                VATAmount := "VAT Amount";
                                TOTAL := VATAmount + AExclVAT;
                                "Amount Exclusive VAT" := AExclVAT;
                                "Total Amount Inclusive VAT" := TOTAL;
                                "Contract Amount" := TOTAL;
                            end;
                        //end annually
                        //start of monthly
                        if Lease."Billing Frequency" = Lease."Billing Frequency"::Monthly then begin
                            Quantity := 1;
                            AExclVAT := "Amount Exclusive VAT" * Quantity;
                            "VAT Amount" := ((Charge."VAT Percentage(%)" / 100) * AExclVAT);
                            VATAmount := "VAT Amount";
                            TOTAL := VATAmount + AExclVAT;
                            "Amount Exclusive VAT" := AExclVAT;
                            "Total Amount Inclusive VAT" := TOTAL;
                            "Contract Amount" := TOTAL;
                        end;
                    end
                end
                else
                    "Total Amount Inclusive VAT" := "VAT Amount" + "Amount Exclusive VAT";
            end;

        }
        field(23; "Rent/S.Charge Rate"; Decimal)
        {
            Editable = true;
            trigger OnValidate()
            begin
                Lease.Reset;
                Lease.SetRange(Lease."No.", "Lease No.");
                if Lease.Find('-') then begin
                    if (Lease."Property Type" = 'COMMERCIAL') then begin
                        RentalCharges.Reset;
                        RentalCharges.SetRange(RentalCharges."Property Code", Lease."Property No.");
                        RentalCharges.SetRange(RentalCharges."Floor No", Lease."Floor No.");
                        RentalCharges.SetRange(RentalCharges."Unit Code", Lease."Unit Code");
                        if RentalCharges.Find('-') then begin
                            Charge.Reset;
                            Charge.SetRange(Charge.Code, "Charge No.");
                            if Charge.Find('-') then begin
                                if (Charge."Uses Rates" = true) then begin                                   
                                    if "Rent/S.Charge Rate" >= RentalCharges."Rental Rate" then begin
                                        "Current Monthly Rent" := ("Area Square ft" * "Rent/S.Charge Rate");
                                        "Amount Exclusive VAT" := "Current Monthly Rent" + "Current Service Charge";
                                    end else begin
                                        Error('The Rental Rate you have specified is below the set Unit Rental Charge');
                                        "Current Monthly Rent" := ("Area Square ft" * "Rent/S.Charge Rate");
                                        "Amount Exclusive VAT" := "Current Monthly Rent" + "Current Service Charge";
                                    end;
                                end;
                            end;
                        end;
                        "Amount Exclusive VAT" := ("Area Square ft" * "Rent/S.Charge Rate");
                    end
                    else begin
                        "Amount Exclusive VAT" := ("Area Square ft" * "Rent/S.Charge Rate");
                    end;
                end;
                Validate("Amount Exclusive VAT");
            end;
        }
        field(24; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(25; "No."; Code[20])
        {
            CalcFormula = Lookup(Charges."Account No." WHERE(Code = FIELD("Charge No.")));
            Caption = 'No.';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            var
                ICPartner: Record "IC Partner";
                ItemCrossReference: Record "Item Reference";
                PrepaymentMgt: Codeunit "Prepayment Mgt.";
            begin
            end;
        }
        field(26; "Property No"; Code[50])
        {
            CalcFormula = Lookup(Lease."Property No." WHERE("No." = FIELD("Lease No.")));
            FieldClass = FlowField;
        }
        field(43; "Transaction Code"; Code[30])
        {
            TableRelation = Charges.Code;
        }
        field(44; "Review Amount"; Decimal)
        {
        }
        field(45; "Tenant No."; Code[30])
        {
            CalcFormula = Lookup(Lease."Tenant No." WHERE("No." = FIELD("Lease No.")));
            FieldClass = FlowField;
            TableRelation = Customer."No.";
        }
        field(46; "Review Is Rate ?"; Boolean)
        {
        }
        field(47; "Review Is Amount"; Boolean)
        {
        }
        field(48; Amount; Decimal)
        {
        }
        field(49; "VAT Amount"; Decimal)
        {
        }
        field(50; "VAT%"; Decimal)
        {
        }
        field(51; "Total Amount Inclusive VAT"; Decimal)
        {
        }
        field(55; "Charge Letting Fee"; Boolean)
        {

            trigger OnValidate()
            begin
                /*
                Lease.RESET;
                Lease.SETRANGE(Lease."No.","Lease No.");
                IF Lease.FIND('-')THEN BEGIN
                IF "Charge Letting Fee"=TRUE THEN
                Lease."Charge Letting Fee":=TRUE;
                END;
                 */

            end;
        }
        field(56; "Charge Reletting Fee"; Boolean)
        {
        }
        field(57; Quantity; Decimal)
        {
        }
        field(58; "IsService Charge"; Boolean)
        {
        }
        field(59; Charged; Boolean)
        {
        }
        field(60; "Charge once date"; Date)
        {
        }
        field(61; Once; Boolean)
        {
        }
        field(62; "Contract Amount"; Decimal)
        {
        }
        field(63; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(64; "Date Vacated"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Charge No.", "Lease No.")
        {
            Clustered = true;
            SumIndexFields = Amount, "Amount Exclusive VAT", "Total Amount Inclusive VAT", "VAT Amount";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Type := Type::"G/L Account";
    end;

    var
        Charge: Record Charges;
        RentalCharges: Record "Unit Setup Charges";
        Lease: Record Lease;
        SalesHeader: Record "Sales Header";
        SalesLine2: Record "Sales Line";
        PropertyCharges: Record "Unit Setup Charges";
        ApprovalEntry: Record "Approval Entry";
        LeaseLine: Record "Lease Line";
        TOTAL: Decimal;
        AExclVAT: Decimal;
        VATAmount: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
        Currency: Record Currency;
        Customer: Record Customer;

    // [Scope('OnPrem')]
    procedure GetLeaseLine()
    begin
    end;

    // [Scope('OnPrem')]
    procedure GetDate(): Date
    begin
        if SalesHeader."Posting Date" <> 0D then
            exit(SalesHeader."Posting Date");
        exit(WorkDate);
    end;

    // [Scope('OnPrem')]
    procedure SuggestBatchLines()
    var
        LeaseBilled: Record "Leases Billed";
        EntryNo: Integer;
    begin
        LeaseBilled.Init;
        EntryNo := 1000;
        LeaseBilled."Line No" := EntryNo + 1;
        LeaseBilled."Next Bill Date" := Today;
        LeaseBilled."Tenant No." := "Tenant No.";
        LeaseBilled."Leased Amount" := Amount;
        LeaseBilled."No." := "No.";
        LeaseBilled."Property No." := "Property No";
        LeaseBilled.Insert;
    end;
}

