table 52187002 "Certificate Management"
{
    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Record ID"; Code[30])
        {
            Editable = false;
        }
        field(3; "Document Type"; Option)
        {
            OptionMembers = "Tax Exemption","Passport","Contract";
            Editable = false;
        }
        field(4; "Start Date"; Date)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "End Date" <> 0D then begin
                    if "End Date" <= "Start Date" then
                    Error('Start date cannot be greater than end date');
                end;
            end;
        }
        field(5; "End Date"; Date)
        {
            trigger OnValidate()
            begin
                if "Start Date" <> 0D then begin
                    if "End Date" <= "Start Date" then
                        Error('Start date cannot be greater than end date');
                end;
                if "End Date" <= Today then Message('The certificate has already expired!');                
            end;
        }
        field(6; Description; Text[100])
        {
        }
        field(7; "Document No."; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "No.", "Record ID", "Document Type")
        {
        }
    }
}