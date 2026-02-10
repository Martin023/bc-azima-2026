table 52186812 "Employee Group"
{
    Caption = 'Employee Group';
    DataClassification = ToBeClassified;
    LookupPageId = "Employee Groups";

    fields
    {
        field(1; "Employee Group"; Code[20])
        {

        }
        field(2; "Employee Group Description"; text[30])
        {
            Caption = 'Description';

        }
        field(3; "Leave days"; decimal)
        {
            Caption = 'Leave days';
            trigger OnValidate()
            var
                HrSetup: record "HR Setup";
            begin
                HrSetup.Get();
                if HrSetup."Min Leave Days" = 0 then begin
                    Error('Kindly fill the Minimum Leave Days In Hr Setup');
                end;
                if rec."Leave Days" < HrSEtup."Min Leave Days" then
                    error('Leave days Should Not be less than the Minimum Leave Days in Hr Setup');

            end;
        }
        field(4; "Overtime Claim"; boolean)
        {

        }
    }
    keys
    {
        key(PK; "Employee Group")
        {
            Clustered = true;
        }
    }
}
