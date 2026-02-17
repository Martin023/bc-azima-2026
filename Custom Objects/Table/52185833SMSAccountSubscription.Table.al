table 52185833 "SMS Account Subscription"
{

    fields
    {
        field(1; "No."; Code[10])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    NoSetup.Get;
                    NoSeriesMgt.TestManual(NoSetup."SMS Subscription");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member Creation"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(3; "Deposit Confirmation"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(4; "Cash Withdrawal"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(5; "Loan Application"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(6; "Loan Guarantors"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(7; "Loan Posted"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(8; "Loan defaulted"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(9; "Salary Posted"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(10; "Fixed Deposit Maturity"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(11; "InterAccount Transfer"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(12; "Account Status"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(13; "Status Order Creation"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(14; "EFT Effected"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(15; "ATM Application Failed"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(16; "ATM Collection"; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(17; MSACCO; Code[10])
        {
            TableRelation = "SMS Series";
        }
        field(18; "Member No"; Code[20])
        {
            TableRelation = Members;

            trigger OnValidate()
            begin
                if Members.Get("Member No") then begin
                    Name := Members.Name;
                end else
                    Name := '';
            end;
        }
        field(19; SMS; Boolean)
        {
        }
        field(20; "E-Mail"; Boolean)
        {
        }
        field(21; Name; Text[100])
        {
        }
        field(22; "No. Series"; Code[10])
        {
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

    trigger OnInsert()
    begin

        if "No." = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."SMS Subscription");
            "No." := NoSeriesMgt.GetNextNo(NoSetup."SMS Subscription");
            // NoSeriesMgt.InitSeries(NoSetup."SMS Subscription", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        Members: Record Members;
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        NoSetup: Record "Credit Nos. Series";
}

