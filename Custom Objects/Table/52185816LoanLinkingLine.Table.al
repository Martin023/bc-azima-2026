table 52185816 "Loan Linking Line"
{

    fields
    {
        field(1; No; Code[10])
        {
        }
        field(2; "Loan No"; Code[20])
        {
            TableRelation = Loans;

            trigger OnValidate()
            begin
                if Loan.Get("Loan No") then begin
                    "Member Name" := Loan."Member Name";
                    "Member No." := Loan."Member No.";
                    "Approved Amount" := Loan."Approved Amount";
                    Posted := Loan.Posted;
                end else begin
                    "Member Name" := '';
                    "Member No." := '';
                    "Approved Amount" := 0;
                    Posted := false;
                end;
            end;
        }
        field(3; "Member No."; Code[20])
        {
        }
        field(4; "Member Name"; Code[20])
        {
        }
        field(5; "Approved Amount"; Decimal)
        {
        }
        field(6; Posted; Boolean)
        {
        }
        field(7; "Loan Linking No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; No, "Loan No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Loan: Record Loans;
}

