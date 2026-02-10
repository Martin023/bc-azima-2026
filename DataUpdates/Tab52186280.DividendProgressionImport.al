table 52186280 "Dividend Progression Import"
{
    Caption = 'Dividend Progression Import';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Member No."; Code[100])
        {
            Caption = 'Member No.';
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(3; "Gross Div."; Decimal)
        {
            Caption = 'Gross Div.';
        }
        field(4; WTax; Decimal)
        {
            Caption = 'WTax';
        }
        field(5; "Net Div."; Decimal)
        {
            Caption = 'Net Div.';
        }
        field(6; "Qualifying Shares"; Decimal)
        {
            Caption = 'Qualifying Shares';
        }
        field(7; Shares; Decimal)
        {
            Caption = 'Shares';
        }
    }
    keys
    {
        key(PK; "Member No.", Date)
        {
            Clustered = true;
        }
    }
}
