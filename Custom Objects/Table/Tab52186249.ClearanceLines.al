table 52186249 "Clearance Lines"
{
    Caption = 'Clearance Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(42; "Header No"; code[20])
        {

        }
        field(43; Date9; date)
        {
            Editable = false;

        }
        field(44; "Responsibility Centre"; code[40])
        {
            Editable = false;
        }
        field(2; Liabilities; decimal)
        {
            Editable = false;
        }
        field(3; "Company Assets"; text[100])
        {

        }
        field(4; Comments; text[100])
        {
            Trigger OnValidate()
            begin
                Approver := '';

                ClearanceHeader.reset();
                if ClearanceHeader.find('-') then begin
                    ClearanceLines.setrange("Header No", ClearanceHeader."Clearance No");
                    if ClearanceLines.Find('-') then begin
                        ClearanceLines.Approver := UserId;
                        HrEmp.reset();
                        HrEmp.setrange("User ID", ClearanceLines.Approver);
                        if HrEmp.findfirst() then begin
                            rec.Name := HrEmp.FullName;
                            rec.Designation := HrEmp."Job Title";
                            rec.Date9 := Today;

                        end;


                    end;

                end;
            end;

        }
        field(5; Name; code[100])
        {
            Editable = false;

        }
        field(6; Designation; code[100])
        {
            Editable = false;

        }
        field(7; Approver; code[100])
        {
            Editable = false;

        }


    }
    keys
    {
        key(PK; "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin

    end;

    var
        UserSetup: record "User Setup";
        HrEmp: record "HR Employees";
        ResponsibilityCentre: record "Responsibility CenterBR";
        ClearanceHeader: record "Clearance Form";
        ClearanceLines: record "Clearance Lines";

}
