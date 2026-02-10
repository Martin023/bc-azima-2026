table 52186119 "Loan Product Charge Appl."
{

    fields
    {
        field(1; "Charge Code"; Code[20])
        {
            TableRelation = "Loan Charges"."Charge Code";

            trigger OnValidate()
            begin
                if LoanChg.Get("Charge Code") then begin
                    "Charge Description" := LoanChg."Charge Description";
                    "Charge Amount" := LoanChg."Charge Amount";
                    "Use Percentage" := LoanChg."Use Percentage";
                    Percentage := LoanChg.Percentage;
                    "Charging Option" := LoanChg."Charging Option";

                end;
            end;
        }
        field(2; "Charge Description"; Text[70])
        {
        }
        field(3; "Charge Amount"; Decimal)
        {
        }
        field(4; "Use Percentage"; Boolean)
        {
        }
        field(5; Percentage; Decimal)
        {
        }
        field(6; "Charge Type"; Option)
        {
            OptionCaption = 'General,Top up,External Loan,Boosting';
            OptionMembers = General,"Top up","External Loan",Boosting;
        }
        field(7; "Charging Option"; Option)
        {
            OptionMembers = ,"On Approved Amount","On Net Amount";
        }
        field(8; "Product Code"; Code[20])
        {
        }
        field(9; "Charges G_L Account"; Code[20])
        {
            TableRelation = "G/L Account"."No.";
        }
        field(10; Minimum; Decimal)
        {
        }
        field(11; Maximum; Decimal)
        {
        }
        field(12; "Additional Conditional Charge"; Decimal)
        {
        }
        field(13; "Document No."; Code[20])
        {
        }
        field(14; "Entry No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Document No.", "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        LoanChg: Record "Loan Charges";
}

