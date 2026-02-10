table 52185937 "Overtime Claim Lines"
{
    DrillDownPageID = "Overtime Claim Lines";
    LookupPageID = "Overtime Claim Lines";

    fields
    {
        field(10; "Claim Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(20; "Claim No"; Code[10])
        {
        }
        field(30; Date; Date)
        {

        }
        field(40; "Work Description/Reason"; Text[30])
        {

            trigger OnValidate()
            begin
                TestField(Date);
            end;
        }
        field(50; "No. of Hours"; Decimal)
        {
        }
        field(60; Amount; Decimal)
        {


        }
        field(61; "Overtime Type"; Option)
        {
            OptionCaption = ' ,Weekdays,Weekends and Holidays';
            OptionMembers = " ",Weekdays,"Weekends and Holidays";
            trigger OnValidate()
            var
                myInt: Integer;
                HRNonWorkingDays: Record "HR Non Working Days & Dates";

            begin

                // begin
                //     HRNonWorkingDays.Reset;
                //     HRNonWorkingDays.SetRange(Date, rec.Date);
                //     if  HRNonWorkingDays.Find('-') then begin
                //         "Overtime Type":="Overtime Type"::"Weekends and Holidays";

                //     end else
                //     "Overtime Type":="Overtime Type"::Weekdays;
                // end;
                OvertimeHeader.reset();
                if OvertimeHeader.find('-') then begin
                    overtimelines.reset();
                    overtimelines.setrange("Claim No", OvertimeHeader."Claim No");
                    if overtimelines.Find('-') then begin
                        HREmp.Reset;
                        HrEmp.setrange("No.", OvertimeHeader."Staff No.");
                        if HrEmp.FindFirst() then begin
                            PRSalaryCard.reset();
                            PRSalaryCard.setrange("Employee Code", HrEmp."No.");
                            if PRSalaryCard.FindSet() then begin
                                EmpCode := HrEmp."No.";
                                intMonth := Date2DMY(today, 2);
                                Intyear := Date2DMY(today, 3);
                                curTransAmount := 0;
                                strExtractedFrml := '';
                                if HrSetup.get() then begin
                                    if rec."Overtime Type" = rec."Overtime Type"::Weekdays then
                                        formula := HrSEtup."Weekday Overtime Formula";
                                    if rec."Overtime Type" = rec."Overtime Type"::"Weekends and Holidays" then
                                        formula := HrSEtup."Weekend Overtime Formula";
                                    IF COPYSTR(formula, 3, 4) = 'BPAY' then BEGIN
                                        //Message(COPYSTR(formula, 3, 4));
                                    Bpay := CopyStr(formula, 1, 1) + Format(PRSalaryCard."Basic Pay") + CopyStr(formula, 8, 12);
                                    message(Bpay);
                                    curTransAmount := ROUND(Payroll.fnFormulaResult(Bpay), 1, '<');
                                    rec.Amount := curTransAmount * rec."No. of Hours";
                                end;
                            end;
                        end;
                    end;
                end;
            end;
            END;
        }
        field(62; "Time From"; Time)
        {

            trigger OnValidate()
            begin
                TestField(Date);
                //TestField("Overtime Type");

                if ("Time To" <> 0T) and ("Time From" <> 0T) then
                    TimeDifference := "Time To" - "Time From";

                if TimeDifference <> 0 then
                    "No. of Hours" := TimeDifference / 3600000;
            end;
        }
        field(63; "Time To"; Time)
        {

            trigger OnValidate()
            begin
                TestField(Date);
                //TestField("Overtime Type");

                if "Time To" < "Time From" then
                    Error('Time to can not be less than the time from enter right time');

                if "Time To" = "Time From" then
                    Error('Time to can not beequal to time from enter right time');
                if ("Time To" <> 0T) and ("Time From" <> 0T) then
                    TimeDifference := "Time To" - "Time From";
                if TimeDifference <> 0 then
                    "No. of Hours" := TimeDifference / 3600000;
            end;
        }
    }

    keys
    {
        key(Key1; "Claim Line No", "Claim No")
        {
            Clustered = true;
            SumIndexFields = "No. of Hours";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        OvertimeHeader.Reset;
        OvertimeHeader.SetRange(OvertimeHeader."Claim No", "Claim No");
        if OvertimeHeader.FindFirst then begin
            if (OvertimeHeader.Status = OvertimeHeader.Status::Approved) or
                (OvertimeHeader.Status = OvertimeHeader.Status::Cancelled) or
                (OvertimeHeader.Status = OvertimeHeader.Status::"Pending Approval") then
                Error('You Cannot Modify this record its status is not Pending');
        end;
    end;

    trigger OnModify()
    begin

        OvertimeHeader.Reset;
        OvertimeHeader.SetRange(OvertimeHeader."Claim No", "Claim No");
        if OvertimeHeader.FindFirst then begin
            if (OvertimeHeader.Status = OvertimeHeader.Status::Approved) or
                (OvertimeHeader.Status = OvertimeHeader.Status::Cancelled) or
                (OvertimeHeader.Status = OvertimeHeader.Status::"Pending Approval") then
                Error('You Cannot Modify this record its status is not Pending');
        end;
    end;

    var
        OvertimeHeader: Record "Overtime Claim Header";
        TimeDifference: Decimal;
        HrSEtup: record "HR Setup";
        Payroll: codeunit "PR Payroll Processing";
        Cost: decimal;
        PRSalaryCard: Record "PR Salary Card";
        HrEmp: Record "HR Employees";
        strExtractedFrml: Text[250];
        curTransAmount: Decimal;
        EmpCode: code[20];
        intMonth: Integer;
        intYear: Integer;
        Bpay: Text[200];
        Extract: text;
        overtimelines: record "Overtime Claim Lines";
        Formula: text[100];

}

