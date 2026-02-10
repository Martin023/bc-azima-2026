table 52185531 "HR Leave Types"
{
    // LookupPageID = "HR Leave Types";

    fields
    {
        field(1; "Code"; Code[40])
        {
            NotBlank = true;
        }
        field(2; Description; Text[200])
        {
            trigger OnValidate()
            var
                Leave: record "HR Leave Types";
            begin
                Leave.reset();
                Leave.SetRange(Description, rec.Description);
                if Leave.findfirst() then begin
                    Error('Description Already Exists');
                end;
            end;
        }
        field(3; Days; Decimal)
        {

            trigger OnValidate()
            var
                HrSetup: record "HR Setup";
            begin
                HrSetup.Get();
                if HrSetup."Min Leave Days" = 0 then begin
                    Error('Kindly fill the Minimum Leave Days In Hr Setup');
                end;
                if rec."Is Annual Leave" = true then begin
                    if rec.Days < HrSEtup."Min Leave Days" then
                        error('Leave days Should Not be less than the Minimum Leave Days in Hr Setup');
                end;
                if gender = rec.gender::Female then
                    if rec.days < 90 then Error('Maternity leave days should not be less than 90 days');
                rec.validate("Leave type Enum");

            end;
        }
        field(4; "Acrue Days"; Boolean)
        {
        }
        field(5; "Unlimited Days"; Boolean)
        {
        }
        field(6; Gender; Option)
        {
            OptionCaption = 'Both,Male,Female';
            OptionMembers = Both,Male,Female;
        }
        field(7; Balance; Option)
        {
            OptionMembers = Ignore,"Carry Forward","Convert to Cash";
        }
        field(8; "Inclusive of Holidays"; Boolean)
        {
        }
        field(9; "Inclusive of Saturday"; Boolean)
        {
        }
        field(10; "Inclusive of Sunday"; Boolean)
        {
        }
        field(11; "Off/Holidays Days Leave"; Boolean)
        {
        }
        field(12; "Max Carry Forward Days"; Decimal)
        {
        }
        field(13; "Inclusive of Non Working Days"; Boolean)
        {
        }
        field(14; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(15; "Carry Forward Allowed"; Boolean)
        {
        }
        field(16; "Fixed Days"; Boolean)
        {
        }
        field(17; "Minimum Months"; DateFormula)
        {
            Caption = 'Minimum Months of Service (e.g. 3M)';
        }
        field(18; "Is Annual Leave"; Boolean)
        {
        }
        field(19; Active; Boolean)
        {
        }
        field(20; "Salary Grade"; code[40])
        {
            TableRelation = "Salary Grades"."Salary Grade";
            trigger OnValidate()
            var
                SalaryGrades: record "Salary Grades";
            begin
                SalaryGrades.reset();
                SalaryGrades.SetRange("Salary Grade", rec."Salary Grade");
                if SalaryGrades.FindSet() then begin
                    rec.Days := SalaryGrades."Leave Days";
                end;
            end;
        }
        field(21; "Leave type Enum"; enum "Leave Type Enum")
        {

        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

