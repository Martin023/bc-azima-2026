table 52186018 "Defined SLA"
{
    Caption = 'Defined SLA';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[30])
        {
            Caption = 'No.';
        }
        field(2; "Origination Type"; enum "SLA Origination Type")
        {


        }
        field(3; SLA; Duration)
        {
            Caption = 'SLA';
        }
        field(4; "Commission"; Decimal)
        {
            Caption = 'Commission';
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
