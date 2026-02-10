table 52186008 Lease
{
    LookupPageID = "Lease-List";

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Date Registered"; Date)
        {
            trigger OnValidate()
            begin
                if "Date Registered" > Today then begin
                    Error('Date Cannot be in the future!')
                end
            end;
        }
        field(3; "Property No."; Code[20])
        {
            TableRelation = "Property Details"."No.";

            trigger OnValidate()
            begin

                Prop.Reset;
                //Prop.GET("Property No.");
                Prop.SetRange(Prop."No.", "Property No.");
                if Prop.Find('-') then begin
                    if Prop."Agreement Status" <> Prop."Agreement Status"::Active then
                        Error('Status must be agreed for this property')
                    else
                        "L.R. No." := Prop."L.R. No.";
                    "Property Name" := Prop.Description;
                    "Landlord No." := Prop."Landlord No.";
                    "Landlord Name" := Prop."Landlord Name";
                    "Property Type" := Prop."Property Type";
                    "Building Asset No." := Prop."Fixed Asset No.";
                    "Building Location" := Prop."Building Location";
                end;
            end;
        }
        field(4; "L.R. No."; Code[100])
        {
        }
        field(5; "Property Name"; Text[200])
        {
        }
        field(6; "Floor No."; Code[20])
        {
            TableRelation = Floor."Floor Code" WHERE("No." = FIELD("Property No."));
            trigger OnValidate()
            begin
                //Get floor no and floor name
                Flr.Reset;
                Flr.SetRange(Flr."No.", "Property No.");
                Flr.SetRange(Flr."Floor Code", "Floor No.");
                if Flr.Find('-') then begin
                    "Floor Name" := Flr.Description;
                end;
            end;
        }
        field(7; "Floor Name"; Text[100])
        {
        }
        field(8; "Unit Code"; Code[20])
        {
            TableRelation = Unit."Unit Code" WHERE("Property No." = FIELD("Property No."),
                                                    "Floor Code" = FIELD("Floor No."),
                                                    "Unit Status" = FILTER(Vacant));

            trigger OnValidate()
            begin
                //get unit no and unit name
                Unt.Reset;
                if Unt.Get("Property No.", "Floor No.", "Unit Code") then begin
                    "Unit Description" := Unt."Unit Name";
                    "Area square ft" := Unt."Area Square ft";
                    "Unit Sub Type" := Unt."Unit Sub Type";
                    "Unit Sub Type Description" := Unt."Unit Sub Type Name";
                    "Meter No." := Unt."Meter No.";
                    Unt.Modify;
                end;

                UT.Reset;
                UT.Get(Unt."Unit Type");
                "Unit Type Description" := UT.Description;
                "Unit Type" := UT.Code;
            end;
        }
        field(9; "Unit Description"; Text[100])
        {
        }
        field(10; "Unit Type"; Code[20])
        {
        }
        field(11; "Unit Type Description"; Text[100])
        {
        }
        field(12; "Unit Sub Type"; Code[20])
        {
        }
        field(13; "Unit Sub Type Description"; Text[100])
        {
        }
        field(14; "Landlord No."; Code[20])
        {
        }
        field(15; "Landlord Name"; Text[250])
        {
        }
        field(16; "Tenant No."; Code[20])
        {
            TableRelation = Customer."No." WHERE("Account Type" = CONST(Tenant));

            trigger OnValidate()
            begin
                Cust.Reset;
                Cust.SetRange(Cust."No.", "Tenant No.");
                if Cust.Find('-') then
                    "Tenant Name" := Cust.Name;
                // "Escalation For Leases" := Cust."Escalation For Leases";
                // "Escalation Frequency" := Cust."Escalation Frequency";
                // "Lease Period" := Cust."Lease Period";


                Unt.RESET;
                Unt.SETRANGE(Unt."Unit Code", "Unit Code");
                Unt.SETRANGE(Unt."Property No.", "Property No.");
                Unt.SETRANGE(Unt."Floor Code", "Floor No.");
                IF Unt.FIND('-') THEN BEGIN
                    Unt."Unit Status" := Unt."Unit Status"::Occupied;
                    Unt.MODIFY;
                END;
            end;
        }
        field(17; "Tenant Name"; Text[250])
        {
        }
        field(18; "Letter Of Offer"; Boolean)
        {
        }
        field(19; "Lease Agreement Ref. No."; Code[20])
        {
        }
        field(20; "Lease Commence Date"; Date)
        {

            trigger OnValidate()
            begin
                if REc."Lease Commence Date" < Today then
                    Error('Lease Commence Date cannot be in the past')
                else begin
                    // if "Duration Type" = "Duration Type"::Days then begin
                    //     "Expiry Date" := CalcDate(Format("Duration Value") + 'D''-1D', "Lease Commence Date");

                    // end
                    // else
                    //     if "Duration Type" = "Duration Type"::Weeks then begin
                    //         "Expiry Date" := CalcDate(Format("Duration Value") + 'W''-1D', "Lease Commence Date");
                    //     end
                    //     else
                    if "Duration Type" = "Duration Type"::Months then begin
                        "Expiry Date" := CalcDate(Format("Duration Value") + 'M''-1D', "Lease Commence Date");
                    end
                    else
                        if "Duration Type" = "Duration Type"::Quarters then begin
                            "Expiry Date" := CalcDate(Format("Duration Value") + 'Q''-1D', "Lease Commence Date");
                        end
                        else
                            if "Duration Type" = "Duration Type"::Years then begin
                                "Expiry Date" := CalcDate(Format("Duration Value") + 'Y''-1D', "Lease Commence Date");
                            end;
                end;
            end;
        }
        field(21; "Expiry Date"; Date)
        {
        }
        field(22; "Billing Frequency"; Option)
        {
            OptionCaption = 'Monthly,Quarterly,Annually,Biannually, Semi Annually';
            OptionMembers = Monthly,Quarterly,Annually,"Semi Annually";

            trigger OnValidate()
            begin

                //TESTFIELD("Next Bill Date");
                TESTFIELD(rec."Lease Commence Date");
                // TESTFIELD("Billing Frequency Value");

                //    IF "Billing Frequency"="Billing Frequency"::Daily THEN BEGIN
                //     rec."Next Bill Date":=CALCDATE('1D',"Lease Commence Date");
                //    END
                //    ELSE IF "Billing Frequency"="Billing Frequency"::Weekly THEN BEGIN
                //     rec."Next Bill Date":=CALCDATE('1W',"Lease Commence Date");
                //   END
                //    ELSE 
                IF "Billing Frequency" = "Billing Frequency"::Monthly THEN BEGIN
                    rec."Next Bill Date" := CALCDATE('1M', "Lease Commence Date");
                END
                ELSE IF "Billing Frequency" = "Billing Frequency"::Quarterly THEN BEGIN
                    rec."Next Bill Date" := CALCDATE('1Q', "Lease Commence Date");
                END
                ELSE IF "Billing Frequency" = "Billing Frequency"::Annually THEN BEGIN
                    rec."Next Bill Date" := CALCDATE('1Y', "Lease Commence Date");
                    ;
                END;

                "Billing Frequency Value" := 1;
                Validate("Billing Frequency Value");

            end;
        }
        field(23; "Billing Frequency Value"; Integer)
        {
        }
        field(24; "Duration Type"; Option)
        {
            OptionMembers = " ",Days,Weeks,Months,Quarters,Years;
        }
        field(25; "Duration Value"; Integer)
        {

            trigger OnValidate()
            begin
                //check the value selected by the user
                TestField("Lease Commence Date");
                TestField("Duration Type");

                if "Duration Type" = "Duration Type"::Days then begin
                    "Expiry Date" := CalcDate(Format("Duration Value") + 'D''-1D', "Lease Commence Date");

                end
                else
                    if "Duration Type" = "Duration Type"::Weeks then begin
                        "Expiry Date" := CalcDate(Format("Duration Value") + 'W''-1D', "Lease Commence Date");
                    end
                    else
                        if "Duration Type" = "Duration Type"::Months then begin
                            "Expiry Date" := CalcDate(Format("Duration Value") + 'M''-1D', "Lease Commence Date");
                        end
                        else
                            if "Duration Type" = "Duration Type"::Quarters then begin
                                "Expiry Date" := CalcDate(Format("Duration Value") + 'Q''-1D', "Lease Commence Date");
                            end
                            else
                                if "Duration Type" = "Duration Type"::Years then begin
                                    "Expiry Date" := CalcDate(Format("Duration Value") + 'Y''-1D', "Lease Commence Date");
                                end;


            end;
        }
        field(26; "No. Series"; Code[20])
        {
        }
        field(27; Blocked; Boolean)
        {
        }
        field(28; Commenced; Boolean)
        {
        }
        field(29; Select; Boolean)
        {
        }
        field(30; "Last Bill Date"; Date)
        {
            trigger OnValidate()
            begin
                "Next Bill Date" := CALCDATE('+30D', "Last Bill Date");
            end;
        }
        field(31; "Next Bill Date"; Date)
        {
            Caption = 'Billing Date';
        }
        field(32; "End Remarks"; Text[250])
        {
        }
        field(33; "Global Dimension 1 Code"; Code[20])
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
                    //enter branch name
                    "Branch Name" := DimVal.Name;
                end;
            end;
        }
        field(34; "Global Dimension 2 Code"; Code[20])
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
                    //enter dept name
                    "Department Name" := DimVal.Name;
                end;
            end;
        }
        field(36; User; Text[100])
        {
        }
        field(37; "Letting Fee"; Decimal)
        {
        }
        field(38; "Area square ft"; Decimal)
        {
        }
        field(39; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Lease,Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Lease,Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(40; Status; Enum "Workflow Status Main Flags")
        {
            Caption = 'Status';
            // Editable = true;
            // OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            // OptionMembers = Open,Pending, Approved, Rejected,"Pending Approval";
        }
        field(42; "Currency Code"; Code[10])
        {
            TableRelation = Currency;

            trigger OnValidate()
            var
                DOPaymentTransLogEntry: Record "DO Payment Trans. Log Entry";
            begin
                if not (CurrFieldNo in [0, FieldNo("Date Registered")]) or ("Currency Code" <> xRec."Currency Code") then
                    TestField(Status, Status::Open);
                // if DOPaymentTransLogEntry.FindFirst then
                //     DOPaymentTransLogMgt.ValidateHasNoValidTransactions("Document Type", Format("Document Type"), "No.");
                if (CurrFieldNo <> FieldNo("Currency Code")) and ("Currency Code" = xRec."Currency Code") then
                    UpdateCurrencyFactor
                else
                    if "Currency Code" <> xRec."Currency Code" then begin
                        //UpdateCurrencyFactor;
                        //  RecreateSalesLines(FIELDCAPTION("Currency Code"));
                    end else
                        if "Currency Code" <> '' then begin
                            //UpdateCurrencyFactor;
                            // if "Currency Factor" <> xRec."Currency Factor" then
                            //     Confirm//UpdateCurrencyFactor;
                        end;
            end;
        }
        field(43; "Transaction Code"; Code[30])
        {
            TableRelation = Charges.Code;
        }
        field(44; "Rental Rate"; Decimal)
        {
        }
        field(45; "Meter No."; Text[100])
        {
        }
        field(46; Expired; Boolean)
        {
        }
        field(47; "Property Type"; Code[30])
        {
        }
        field(48; "Batch No"; Code[30])
        {
            // TableRelation = "Bills Batch"."Batch No.";
        }
        field(49; "Total Amount Excl. VAT"; Decimal)
        {
            CalcFormula = Sum("Lease Line"."Amount Exclusive VAT" WHERE("Lease No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(50; Cancelled; Boolean)
        {
        }
        field(51; "Total VAT Amount"; Decimal)
        {
            CalcFormula = Sum("Lease Line"."VAT Amount" WHERE("Lease No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(52; "Branch Name"; Text[50])
        {
        }
        field(53; "Department Name"; Text[50])
        {
        }
        field(54; "Lease Agreement Signed"; Boolean)
        {
        }
        field(57; "Lease Type"; Option)
        {
            OptionCaption = 'Normal,Common Area';
            OptionMembers = Normal,"Common Area";
        }
        field(59; "Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = FIELD("Tenant No."),
                                                                         "Posting Date" = FIELD("Date Filter")));
            Caption = 'Balance (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(61; "Lease Balance"; Decimal)
        {
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Posting Date" = FIELD("Date Filter"),
                                                                         "Customer No." = FIELD("Tenant No.")));
            FieldClass = FlowField;
        }
        field(62; "Previous Reading"; Decimal)
        {
        }
        field(63; "Current Reading"; Decimal)
        {
        }
        field(64; "Nairobi Pr Reading"; Decimal)
        {
        }
        field(65; "Nairobi Cur Reading"; Decimal)
        {
        }
        field(66; "Renew Lease"; Boolean)
        {
        }
        field(67; charged; Boolean)
        {
        }
        field(68; "Penalty Code"; Code[30])
        {
            ////TableRelation = Table39005639.Field1;
        }
        field(69; "Lease Status"; Option)
        {
            OptionCaption = 'Open,Active,Terminated,Expired,Renewed';
            OptionMembers = Open,Active,Terminated,Expired,Renewed;
        }
        field(70; FirstBilling; Boolean)
        {
        }
        field(71; "Responsibility Center"; Code[10])
        {
            TableRelation = "Responsibility CenterBR";
        }
        field(72; Prepayment; Boolean)
        {
        }
        field(73; "Currency Factor"; Decimal)
        {
            Editable = false;
            MinValue = 0;
        }
        field(74; "Termination Notice Date"; Date)
        {
            Description = 'Specify Notice date of termination';
        }
        field(75; "Termination Reason"; Text[200])
        {
            Description = 'Specify reason for termination';
        }
        field(76; "Termination Date"; Date)
        {
            Description = 'Specify date of termination';
        }
        field(77; "Escalation For Leases"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(78; "Escalation Frequency"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(79; "Lease Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Last Escalation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(81; "Terminated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(82; "Created at"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(83; "Lease Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Lease Start Date" >= Today then
                    "Lease TAT" := "Lease Start Date" - "Date Registered";
            end;
        }
        field(84; "Lease TAT"; Integer)
        {
        }
        field(85; "Date Renewed"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(86; "Date Allocated"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(87; Narration; Text[100])
        {
        }
        field(88; "Send/Forward to"; Code[50])
        {
            TableRelation = "Responsibility CenterBR";
        }

        field(89; "Originating Department"; Code[50])
        {
            Editable = false;
        }
        field(90; "Current Department"; Code[50])
        {
            Editable = false;
        }
        field(91; "Size in Sq. Ft."; Decimal)
        {
        }
        field(92; "Building Asset No."; Code[200])
        {
        }
        field(93; "Building Location"; Text[200])
        {
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Property No.")
        {
        }
        key(Key3; "Tenant No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            GSetup.Get();
            GSetup.TestField(GSetup."Lease Nos.");
            NoSeriesMgt.InitSeries(GSetup."Lease Nos.", xRec."No. Series", Today, "No.", "No. Series");
        end;
        User := UserId;
        Rec."Created at" := CurrentDateTime;
        // "Billing Frequency" := "Billing Frequency"::Quarterly;
        //INSERT DIM
        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserId);
        if UserSetup.Find('-') then begin
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            UserSetup.TestField("Responsibility Centre");
            "Originating Department" := UserSetup."Responsibility Centre";
            "Current Department" := UserSetup."Responsibility Centre";
            CFPage.InsertTracker("No.", "Originating Department", true, UserId, CurrentDateTime);
        end;
        Validate("Global Dimension 1 Code");
        Validate("Global Dimension 2 Code");
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GSetup: Record "General Setup";
        Prop: Record "Property Details";
        Flr: Record Floor;
        Unt: Record Unit;
        UT: Record "Unit Type";
        UST: Record "Unit Sub Type";
        Cust: Record Customer;
        GenSetup: Record "General Ledger Setup";
        DimVal: Record "Dimension Value";
        BillUnits: Record "Bill Units meter Ratings";

        CurrencyDate: Date;
        CurrExchRate: Record "Currency Exchange Rate";
        Text021: Label 'Do you want to update the exchange rate?';
        HideValidationDialog: Boolean;
        Confirmed: Boolean;
        UserSetup: Record "User Setup";
        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;

    local procedure UpdateCurrencyFactor()
    begin
        if "Currency Code" <> '' then begin
            if "Date Registered" <> 0D then
                CurrencyDate := "Date Registered"
            else
                CurrencyDate := WorkDate;

            "Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "Currency Code");
        end else
            "Currency Factor" := 0;
    end;

    local procedure ConfirmUpdateCurrencyFactor()
    begin
        if HideValidationDialog then
            Confirmed := true
        else
            Confirmed := Confirm(Text021, false);
        if Confirmed then
            Validate("Currency Factor")
        else
            "Currency Factor" := xRec."Currency Factor";
    end;
}

