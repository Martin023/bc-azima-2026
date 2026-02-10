table 52185958 Damages
{
    DrillDownPageID = "Damages List";
    LookupPageID = "Damages List";

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; Damages; Text[250])
        {
        }
        field(4; "No. Series"; Code[20])
        {
        }
        field(5; "User ID"; Code[50])
        {
        }
        field(6; "Case No"; Code[50])
        {
        }
        field(7; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(8; "Estimated Cost"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Case No", "Line No")
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
            GenLedgerSetup.Get;
            NoSeriesMgt.InitSeries(GenLedgerSetup."Damage Number", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "User ID" := UserId;
    end;

    var
        Emp: Record "HR Employees";
        GenLedgerSetup: Record "Cash Office Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Vend: Record Vendor;
        Cust: Record Customer;
        Memb: Record Members;
        Witn: Record Witnesses;
}

