table 52186012 "Landlord Commission Calc"
{
    DrillDownPageID = "Landlord Commission Calc list";
    LookupPageID = "Landlord Commission Calc list";

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Landlord No."; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(3; "Property No."; Code[20])
        {
            TableRelation = "Property Details"."No.";

            trigger OnValidate()
            begin
                P.Reset;
                P.SetRange(P."No.", "Property No.");
                if P.Find('-') then begin
                    "Property Name" := '[' + P."L.R. No." + ']' + P.Description;
                    "Landlord No." := P."Landlord No.";
                    "Landlord Name" := P."Landlord Name";
                    "Commission Rate" := P."Commission Rate";
                    "Commssion Flat Amount" := P."Commision Flat Amount";
                    "Letting Rate" := P."Letting Fee Rate(%)";
                    "Letting Flat Amount" := P."Letting Flat Amount";
                    "Reletting Rate" := P."Reletting Fee Rate(%)";
                    "Reletting Flat Amount" := P."Reletting Flat Amount";
                end;
            end;
        }
        field(4; "From Date"; Date)
        {
        }
        field(5; "To Date"; Date)
        {
        }
        field(6; Processed; Boolean)
        {
        }
        field(7; "Processed Date"; Date)
        {
        }
        field(8; "Processed Time"; Time)
        {
        }
        field(9; "Processed By"; Code[20])
        {
        }
        field(10; "Property Name"; Text[100])
        {
        }
        field(11; "Landlord Name"; Text[100])
        {
        }
        field(12; Inflows; Decimal)
        {
        }
        field(13; Outflows; Decimal)
        {
        }
        field(14; "Commission Rate"; Decimal)
        {
        }
        field(15; "Commission Amount"; Decimal)
        {
        }
        field(16; "Payable To Landlord"; Decimal)
        {
        }
        field(17; "Global Dimension 1 Code"; Code[20])
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
                    "Branch Name" := DimVal.Name;
                end;
            end;
        }
        field(18; "Global Dimension 2 Code"; Code[20])
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
                    "Department Name" := DimVal.Name;
                end;
            end;
        }
        field(19; "Commssion Flat Amount"; Decimal)
        {
        }
        field(20; "Paying Bank Account"; Code[30])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(21; Currency; Code[30])
        {
            TableRelation = Currency.Code;
        }
        field(22; "Cheque No"; Code[30])
        {
        }
        field(23; "Cheque date"; Date)
        {
        }
        field(24; "Letting Fee Amount"; Decimal)
        {
        }
        field(25; "Reletting Fee Amount"; Decimal)
        {
        }
        field(26; "Letting Flat Amount"; Decimal)
        {
        }
        field(27; "Reletting Flat Amount"; Decimal)
        {
        }
        field(28; "Letting Rate"; Decimal)
        {
        }
        field(29; "Reletting Rate"; Decimal)
        {
        }
        field(30; "Branch Name"; Text[50])
        {
        }
        field(31; "Department Name"; Text[50])
        {
        }
        field(32; "Last Letting Date"; Date)
        {
        }
        field(33; "Next Reletting Date"; Date)
        {
        }
        field(34; "Posting Date"; Date)
        {
        }
        field(35; "VAT on Commission"; Decimal)
        {
        }
        field(36; "Commission Fee"; Code[50])
        {
            ////TableRelation = Table39005636.Field1;
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

    var
        P: Record "Property Details";
        DimVal: Record "Dimension Value";
        GenSetup: Record "General Ledger Setup";
}

