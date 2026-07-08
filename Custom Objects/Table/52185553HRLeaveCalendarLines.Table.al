table 52185553 "HR Leave Calendar Lines"
{
    DrillDownPageId = "HR Leave Calendar Lines";

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Day; Text[40])
        {
            Editable = false;
        }
        field(3; Date; Date)
        {
            Editable = false;
        }
        field(4; "Non Working"; Boolean)
        {
            trigger OnValidate()
            var
                HolidayAdjustmentMgmt: Codeunit "Holiday Adjustment Management";
            begin
                if "Non Working" = xRec."Non Working" then
                    exit;

                if "Non Working" = true then begin
                    if Confirm('Marking this date as a holiday will automatically adjust all active leaves that include this date. Continue?', true) then
                        HolidayAdjustmentMgmt.ProcessHolidayDeclaration(Date, Code)
                    else
                        Error('Holiday declaration cancelled');
                end else begin
                    if Confirm('Unmarking this date as a holiday will reverse all adjustments made for this date. Continue?', true) then
                        HolidayAdjustmentMgmt.ReverseHolidayDeclaration(Date, Code)
                    else
                        Error('Holiday reversal cancelled');
                end;
            end;
        }
        field(5; Reason; Text[40])
        {
        }
        field(6; "Is Half Day"; Boolean)
        {
            Caption = 'Half Day';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Is Half Day" and "Non Working" then
                    Error('A date cannot be both Half Day and Non-Working. Please unmark Non-Working first.');
            end;
        }
    }

    keys
    {
        key(Key1; "Code", Date)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

