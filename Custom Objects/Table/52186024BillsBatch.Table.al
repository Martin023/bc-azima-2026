table 52186024 "Bills Batch"
{
    // DrillDownPageID = "Bills List";
    // LookupPageID = "Bills List";

    fields
    {
        field(1; "Batch No."; Code[30])
        {
        }
        field(2; "Batch Name"; Code[30])
        {
        }
        field(3; "Posting Date"; Date)
        {
        }
        field(4; Posted; Boolean)
        {
        }
        field(5; "No of Billings"; Integer)
        {
            CalcFormula = Count("Leases Billed New" WHERE("Batch No" = FIELD("Batch No.")));
            FieldClass = FlowField;
        }
        field(6; "Total Amount"; Decimal)
        {
            CalcFormula = Sum("Leases Billed New"."Leased Amount" WHERE("Batch No" = FIELD("Batch No.")));
            FieldClass = FlowField;
        }
        field(7; "Billing Period"; Date)
        {
        }
        field(8; "No. Series"; Code[30])
        {
        }
        field(9; "Use Remarks"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Batch No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        if Posted = true then Error('Batch already posted');
    end;

    trigger OnInsert()
    begin
        if "Batch No." = '' then begin
            GeneralSetup.Get;
            GeneralSetup.TestField(GeneralSetup."Bill Batch No.");
            "Batch No." := NoSeriesMgt.GetNextNo(GeneralSetup."Bill Batch No.");
            // NoSeriesMgt.InitSeries(GeneralSetup."Bill Batch No.", xRec."No. Series", 0D, "Batch No.", "No. Series");
        end;
    end;

    trigger OnModify()
    begin
        if Posted = true then Error('Batch already posted');
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        GeneralSetup: Record "General Setup";
}

