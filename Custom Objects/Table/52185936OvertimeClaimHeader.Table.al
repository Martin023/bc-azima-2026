table 52185936 "Overtime Claim Header"
{

    fields
    {
        field(10; "Claim No"; Code[20])
        {
            Editable = false;
            trigger OnValidate()
            begin
                if "Claim No" <> xRec."Claim No" then begin
                    HrSetup.Get();
                    NoSeriesMgt.TestManual(HrSetup."OverTime Claim");
                    "No. Series" := '';
                end;
            end;
        }
        field(11; Department; Text[30])
        {
        }
        field(20; "Date Created"; Date)
        {
        }
        field(29; "Sent to Payroll"; Boolean)
        {
        }

        field(30; "Created By"; Code[50])
        {
        }
        field(40; "Staff No."; Code[20])
        {
            TableRelation = "HR Employees"."No." where(Status = const(Active));

            trigger OnValidate()
            var

            begin
                "Employee Group" := '';
                Department := '';

                if HREmployee.Get("Staff No.") then begin
                    Name := HREmployee.FullName();
                    "Employee Group" := HREmployee."Employee Group";
                    Department := HREmployee."Global Dimension 2 Name";


                end;
                // if HrEmployee.get("Staff No.") then begin

            end;
            //end;
        }
        field(41; "Transaction Code"; Code[20])
        {
            TableRelation = "PR Transaction Codes"."Transaction Code" where("coop parameters" = const(Overtime));


        }
        field(50; Name; Text[50])
        {
        }
        field(51; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Cancelled';
            OptionMembers = Open,"Pending Approval",Approved,Cancelled;
            Editable = false;
        }
        field(52; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility CenterBR";

            trigger OnValidate()
            begin
                // if not UserMgt.CheckRespCenter(1, "Responsibility Center") then
                //     Error(
                //       Text001,
                //       RespCenter.TableCaption, UserMgt.GetPurchasesFilter);
            end;
        }
        field(53; "Currency Code"; Code[20])
        {
        }
        field(54; Amount; Decimal)
        {
            CalcFormula = Sum("Overtime Claim Lines".Amount WHERE("Claim No" = FIELD("Claim No")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(55; "No. Series"; Code[20])
        {
        }
        field(56; "No. Printed"; Integer)
        {
        }
        field(57; "Total Overtime Hrs"; Decimal)
        {
            CalcFormula = Sum("Overtime Claim Lines"."No. of Hours" WHERE("Claim No" = FIELD("Claim No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(58; "Total Overtime Week Days"; Decimal)
        {
            CalcFormula = Sum("Overtime Claim Lines"."No. of Hours" WHERE("Overtime Type" = CONST(Weekdays),
                                                                           "Claim No" = FIELD("Claim No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "Total Overtime Weekend & Holid"; Decimal)
        {
            CalcFormula = Sum("Overtime Claim Lines"."No. of Hours" WHERE("Overtime Type" = CONST("Weekends and Holidays"),
                                                                           "Claim No" = FIELD("Claim No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "Employee Group"; code[29])
        {
            TableRelation = "Employee Group"."Employee Group";
            trigger OnValidate()
            var
            begin


            end;
        }
        field(61; "Need Request"; code[40])
        {
            TableRelation = "HR Overtime Header"."Application Code" where(status = filter(Approved));
            trigger OnValidate()
            var
                OvertimeHeader: record "HR Overtime Header";
                NeedsRequestLines: record "Overtime Need Request Lines";
                EmployeeGroup: record "Employee Group";

            begin
                EmployeeGroup.reset();
                EmployeeGroup.SetRange("Employee Group", rec."Employee Group");
                //EmployeeGroup.setrange("Overtime Claim", True);
                if EmployeeGroup.Find('-') then
                    if EmployeeGroup."Overtime Claim" = false then
                        Error('You are Not Allowed to Apply for Overtime');

                OvertimeHeader.reset();
                OvertimeHeader.setrange(status, OvertimeHeader.status::Approved);
                //OvertimeHeader.SetRange("Application Code",rec."Need Request");
                if OvertimeHeader.find('-') then begin
                    NeedsRequestLines.reset();
                    NeedsRequestLines.setrange("Need No", OvertimeHeader."Application Code");
                    if NeedsRequestLines.find('-') then begin
                        repeat
                            if NeedsRequestLines."Staff No" <> rec."Staff No." then
                                error('Kindly confirm with the Head of Department if Overtime Need Request is Approved');
                        until NeedsRequestLines.Next = 0;
                    end;
                end;
            end;
        }

    }

    keys
    {
        key(Key1; "Claim No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        "Date Created" := Today;
        "Created By" := UserId;

        //"Created By":=USERID;
        if "Claim No" = '' then begin
            HrSetup.Get;
            HrSetup.TestField(HrSetup."Overtime Claim");
            NoSeriesMgt.InitSeries(HrSetup."Overtime Claim", xRec."No. Series", 0D, "Claim No", "No. Series");
        end;
        UserSetUp.Get(UserId);
        "Staff No." := UserSetup."Employee No.";
        Name := UserSetup."Full Name";
        Department := UserSetup."Responsibility Centre";
        "Date Created" := Today;


        //Get the Employee Details
        // if UserSetup.Get(UserId) then begin
        //     if UserSetup."Employee No." = '' then
        //         Error('Your USERID should be linked to an employee account contact your system administrator');

        //     "Staff No." := UserSetup."Employee No.";
        //     if Employee.Get(UserSetup."Employee No.") then
        //         Name := Employee."No." + ' ' + Employee."First Name" + ' ' + Employee."Middle Name";

        // end;
    end;

    var
        DimMgt: Codeunit DimensionManagement;
        GenLedgerSetup: Record "Cash Office Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserMgt: Codeunit "User Setup Management BR";
        UserSetup: Record "User Setup";
        Employee: Record Employee;
        HREmployee: Record "HR Employees";
        RespCenter: Record "Responsibility CenterBR";
        Text001: Label 'Your identification is set up to process from %1 %2 only.';
        HrSetup: Record "HR Setup";
        HrEmp: record "HR Employees";
}

