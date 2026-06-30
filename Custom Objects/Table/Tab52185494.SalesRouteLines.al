table 52185494 "Sales Route Lines"
{
    Caption = 'Sales Route Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Header No"; Code[20])
        {
            Caption = 'Header No';
        }
        field(2; "Route Date"; Date)
        {
            Caption = 'Route Date';

            trigger OnValidate()
            var
                Date: record Date;
            begin
                Date.Reset();
                Date.SetRange("Period Type", Date."Period Type"::"Date");
                Date.SetRange("Period Start", rec."Route Date");
                if Date.Find('-') then begin
                    Day := Date."Period Name";
                end;
            end;
        }
        field(3; Day; Text[200])
        {
            Caption = 'Day';
        }
        field(4; Target; Text[500])
        {
            Caption = 'Target';
        }
        field(5; "Place to Visit"; Text[100])
        {
            Caption = 'Place to Visit';
        }
    }
    keys
    {
        key(PK; "Header No", "Route Date")
        {
            Clustered = true;
        }
    }
}
