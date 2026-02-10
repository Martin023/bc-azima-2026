table 52186798 "Debt Collectors Staging"
{
    Caption = 'Loan Reversal Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Loan No."; Code[30])
        {
            TableRelation = Loans."Loan No." where(Posted = const(true));

            trigger OnValidate()
            var
                Loans: Record Loans;
            begin
                if Loans.Get("Loan No.") then begin
                    "Member No." := Loans."Member No.";
                    Validate("Member No.");
                    "Loan Product Type" := Loans."Loan Product Type";
                    Validate("Loan Product Type");
                    RecoveryHeader.GetLoanBalances(Loans."Loan No.", "Interest Balance", "Principle Balance", "Total Loan Balance");
                    Loans.CalcFields("Installments FallOff", "Days In Arrears", "Loans Category-SASRA");
                    "Days In Arreas" := Loans."Days In Arrears";
                    "Installments In Falloff" := Loans."Installments FallOff";
                    "SASRA Categorisation" := Loans."Loans Category-SASRA";
                end;
            end;
        }
        field(3; "Member No."; Code[30])
        {
            TableRelation = Members;
            Editable = false;
            trigger OnValidate()
            begin
                CalcFields("Member Name");
            end;
        }
        field(4; "Member Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Name where("No." = field("Member No.")));
            Editable = false;
        }
        field(5; "Loan Product Type"; Code[50])
        {
            Editable = false;
            trigger OnValidate()
            begin
                CalcFields("Loan Product Name");
            end;
        }
        field(16; "Loan Product Name"; Text[100])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Product Factory"."Product Description" where("Product ID" = field("Loan Product Type")));
        }
        field(6; "Principle Balance"; Decimal)
        {
            Editable = false;
        }
        field(7; "Interest Balance"; Decimal)
        {
            Editable = false;
        }
        field(8; "Installments In Falloff"; Integer)
        {
            Editable = false;
        }
        field(9; "SASRA Categorisation"; Enum "Loan Sasra categories")
        {
            Editable = false;
        }

        field(10; "Days In Arreas"; Decimal)
        {
            Editable = false;
        }

        field(11; Validated; Boolean)
        {
            Editable = false;
        }
        field(12; Posted; Boolean)
        {
            Editable = false;
        }
        field(13; "Validation Comment"; Text[100])
        {
            Editable = false;
        }

        field(14; "Entry Time"; DateTime)
        {
            Editable = false;
        }
        field(15; "Entered By"; Code[50])
        {
            Editable = false;
        }
        field(17; "Total Loan Balance"; Decimal)
        {
            Editable = false;
        }


    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Entered By" := UserId;
        "Entry Time" := CurrentDateTime;
    end;

    var
        RecoveryHeader: Record "Loan Recovery Header";
}
