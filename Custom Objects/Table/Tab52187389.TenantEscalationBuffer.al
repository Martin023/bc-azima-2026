table 52187389 "Tenant Escalation Buffer"
{
    Caption = 'Tenant Escalation Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Escalation Date"; Date)
        {
            Caption = 'Escalation Date';
        }
        field(2; "Tenant No"; Code[30])
        {
            Caption = 'Tenant No';
        }
        field(3; "rent/fees"; Decimal)
        {
            Caption = 'rent/fees';
        }
        field(4; "Escalation Rate (%)"; Integer)
        {
            Caption = 'Escalation Rate (%)';
        }
        field(5; LeaseNo; Code[50])
        {
            Caption = 'lease No.';
        }
        field(6; "Charge No."; code[50])
        {
            Caption = 'Charge No.';
        }
        field(7; "Property No"; code[50])
        {
            Caption = 'Property No';
        }
    }
    keys
    {
        key(PK; "Escalation Date")
        {
            Clustered = true;
        }
    }
}
