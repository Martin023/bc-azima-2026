table 52186032 "Leases Billed New"
{
    // DrillDownPageID = "Lease-Billed";
    // LookupPageID = "Lease-Billed";

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Date Registered"; Date)
        {
        }
        field(3; "Property No."; Code[20])
        {
            TableRelation = "Property Details"."No.";

            trigger OnValidate()
            begin

                Prop.Reset;
                Prop.Get("Property No.");
                if Prop."Agreement Status" <> Prop."Agreement Status"::Active then
                    Error('Status must be agreed for this property')
                else
                    "L.R. No." := Prop."L.R. No.";
                "Property Name" := Prop.Description;
                "Landlord No." := Prop."Landlord No.";
                "Landlord Name" := Prop."Landlord Name";
                "Property Type" := Prop."Property Type";
            end;
        }
        field(4; "L.R. No."; Code[100])
        {
        }
        field(5; "Property Name"; Text[100])
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
                Flr.Find('-');
                "Floor Name" := Flr.Description;
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
                    Unt.Occupied := true;
                    Unt.Modify;
                end;
                UT.Reset;
                UT.Get(Unt."Unit Type");
                "Unit Type Description" := UT.Description;
                "Unit Type" := UT.Code;

                /*
                UST.RESET;
                UST.GET(UST.Code);
                //IF UST.FIND('-') THEN BEGIN
                "Unit Sub Type":= Unt."Unit Type Name"
                "Unit Sub Type Description":=
                 */

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
        field(15; "Landlord Name"; Text[100])
        {
        }
        field(16; "Tenant No."; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                Cust.Reset;
                Cust.SetRange(Cust."No.", "Tenant No.");
                if Cust.Find('-') then
                    "Tenant Name" := Cust.Name;


                Unt.Reset;
                Unt.SetRange(Unt."Unit Code", "Unit Code");
                Unt.SetRange(Unt."Property No.", "Property No.");
                Unt.SetRange(Unt."Floor Code", "Floor No.");
                if Unt.Find('-') then begin
                    Unt."Unit Status" := Unt."Unit Status"::Occupied;
                    Unt.Modify;
                end;
            end;
        }
        field(17; "Tenant Name"; Text[250])
        {
        }
        field(18; "LA Signed"; Boolean)
        {
        }
        field(19; "LA Reference No."; Code[20])
        {
        }
        field(20; "Commence Date"; Date)
        {
        }
        field(21; "Expiry Date"; Date)
        {
        }
        field(22; "Billing Frequency"; Option)
        {
            OptionCaption = 'Daily,Weekly,Monthly,Quarterly,Annually';
            OptionMembers = Daily,Weekly,Monthly,Quarterly,Annually;

            trigger OnValidate()
            begin
                /*
                  // TESTFIELD("Date of Payment");
               TESTFIELD("Commence Date");
                      // TESTFIELD("Billing Frequency Value");

                   IF "Billing Frequency"="Billing Frequency"::Days THEN BEGIN
                    "Date of Payment":=CALCDATE('1D',"Commence Date");
                   END
                   ELSE IF "Billing Frequency"="Billing Frequency"::Weeks THEN BEGIN
                    "Date of Payment":=CALCDATE('1D',"Commence Date");
                  END
                   ELSE IF "Billing Frequency"="Billing Frequency"::Months THEN BEGIN
                    "Date of Payment":=CALCDATE('1D',"Commence Date");
                  END
                   ELSE IF "Billing Frequency"="Billing Frequency"::Quarters THEN BEGIN
                   "Date of Payment":=CALCDATE('1D',"Commence Date");
                  END
                   ELSE IF "Billing Frequency"="Billing Frequency"::Years THEN BEGIN
                 "Date of Payment":=CALCDATE('1D',"Commence Date");;
                  END
                   */

            end;
        }
        field(23; "Billing Frequency Value"; Integer)
        {
        }
        field(24; "Duration Type"; Option)
        {
            OptionMembers = Days,Weeks,Months,Quarters,Years;
        }
        field(25; "Duration Value"; Integer)
        {

            trigger OnValidate()
            begin
                //check the value selected by the user
                TestField("Commence Date");
                TestField("Duration Type");

                if "Duration Type" = "Duration Type"::Days then begin
                    "Expiry Date" := CalcDate(Format("Duration Value") + 'D', "Commence Date");

                end
                else
                    if "Duration Type" = "Duration Type"::Weeks then begin
                        "Expiry Date" := CalcDate(Format("Duration Value") + 'W', "Commence Date");
                    end
                    else
                        if "Duration Type" = "Duration Type"::Months then begin
                            "Expiry Date" := CalcDate(Format("Duration Value") + 'M', "Commence Date");
                        end
                        else
                            if "Duration Type" = "Duration Type"::Quarters then begin
                                "Expiry Date" := CalcDate(Format("Duration Value") + 'Q', "Commence Date");
                            end
                            else
                                if "Duration Type" = "Duration Type"::Years then begin
                                    "Expiry Date" := CalcDate(Format("Duration Value") + 'Y''-1D', "Commence Date");
                                end;

                if "Expiry Date" <= Today then
                    Error('The Lease has Expired. Kindly Confirm the Duration Value and Duration Type');
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
        }
        field(31; "Next Bill Date"; Date)
        {
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
                end;
            end;
        }
        field(36; Usage; Text[100])
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
        field(40; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Approved';
            OptionMembers = Open,"Pending Approval",Approved;
        }
        field(42; "Currency Code"; Code[10])
        {
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
        field(49; InvoiceNo; Integer)
        {
        }
        field(50; Posted; Boolean)
        {
        }
        field(51; "Leased Amount"; Decimal)
        {
        }
        field(52; DocNo; Code[30])
        {
        }
        field(53; "Leased VAT Amount"; Decimal)
        {
        }
        field(54; "Transaction Name"; Text[100])
        {
        }
        field(55; "G/L Account"; Code[30])
        {
        }
        field(56; "Total Incl. VAT"; Decimal)
        {
        }
        field(57; Charged; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; InvoiceNo, "Property No.", "Tenant No.", "No.", "Transaction Code")
        {
            Clustered = true;
            SumIndexFields = "Leased VAT Amount", "Leased Amount";
        }
        key(Key2; "Next Bill Date")
        {
        }
        key(Key3; "Batch No")
        {
            SumIndexFields = "Leased Amount";
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
        LB: Record "Leases Billed";

    [Scope('OnPrem')]
    procedure showLease()
    var
        Lease: Record Lease;
    begin

        case 39005622 of
            //show for Lease document
            DATABASE::"Leases Billed":
                begin
                    if not LB.Get("No.") then
                        exit;
                    case "Document Type" of
                        "Document Type"::Lease:
                            PAGE.Run(PAGE::"Lease-Active", Lease);
                    end;
                end;

            else
                exit;
        end;

        //end for lease doc
    end;
}

