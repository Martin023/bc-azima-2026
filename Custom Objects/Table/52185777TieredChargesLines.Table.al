table 52185777 "Tiered Charges Lines"
{
    DrillDownPageID = "Tiered Charges Lines";
    LookupPageID = "Tiered Charges Lines";

    fields
    {
        field(1; "Code"; Code[30])
        {
            NotBlank = true;
        }
        field(2; "Lower Limit"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Lower Limit" < 0 then
                    Error('Lower Limit cannot be less than Zero');

                if "Upper Limit" <> 0 then begin
                    if "Lower Limit" > "Upper Limit" then
                        Error('Lower limit cannot be greater than the upper limit');
                end;
            end;
        }
        field(3; "Upper Limit"; Decimal)
        {

            trigger OnValidate()
            begin
                if "Upper Limit" < 0 then
                    Error('Upper Limit cannot be less than Zero');
                if "Lower Limit" <> 0 then begin
                    if "Upper Limit" < "Lower Limit" then
                        Error('Upper limit cannot be less than the lower limit amount');
                end;
            end;
        }
        field(4; "Charge Amount"; Decimal)
        {
            DecimalPlaces = 3;
        }
        field(5; "Use Percentage"; Boolean)
        {

        }
        field(6; Percentage; Decimal)
        {
            DecimalPlaces = 4;
        }
        field(7; "External Vendor Charge"; Decimal)
        {
        }
        field(8; "Mobile Vendor Charge"; Decimal)
        {
        }
        field(9; "Start Date"; Date)
        {
        }
        field(10; "End Date"; Date)
        {
        }
        field(11; "Band Active"; Boolean)
        {
        }
        //Deposit Banding
        field(12; "Minimum Contribution Amount"; Decimal)
        {
            DecimalPlaces = 3;
        }
    }

    keys
    {
        key(Key1; "Code", "Lower Limit", "Start Date", "Band Active")
        {
            Clustered = true;
        }
        key(IdxCode; Code)
        {
            Clustered = false;
        }
    }

    fieldgroups
    {
    }
}

