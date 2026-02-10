table 52186165 "HR Manager Cue"
{

    fields
    {
        field(1; Active; Integer)
        {
            CalcFormula = Count("HR Employees" WHERE(Status = FILTER(Active)));
            FieldClass = FlowField;
        }
        field(2; Female; Integer)
        {
            CalcFormula = Count("HR Employees" WHERE(Gender = FILTER(" "),
                                                      Status = FILTER(Active)));
            FieldClass = FlowField;
        }
        field(3; Male; Integer)
        {
            CalcFormula = Count("HR Employees" WHERE(Gender = FILTER(Male),
                                                      Status = FILTER(Active)));
            FieldClass = FlowField;
        }
        field(4; "Code"; Code[20])
        {
        }
        field(5; "Approved Job Posistions"; Integer)
        {
            CalcFormula = Count("HR Jobs" WHERE(Status = CONST(Approved)));
            FieldClass = FlowField;
        }
        field(6; "Requisitions Pending Approval"; Integer)
        {
            CalcFormula = Count("HR Employee Requisitions" WHERE("Approval Status" = CONST(Approved)));
            FieldClass = FlowField;
        }
        field(7; "Pending Approvals"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE(Status = CONST(Open)));
            FieldClass = FlowField;
        }
        // field(8; "Job applications"; Integer)
        // {
        //     CalcFormula = Count("HR Employees" WHERE("Contract End Date" = filter()));
        //     FieldClass = FlowField;
        // }
        field(9; "HR Promotion recommendations"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("HR Promo. Recommend Header");
        }
        field(10; "Job applications"; Integer)
        {
            FieldClass = FlowField;
            calcformula = Count("HR Job Applications");
        }
        field(11; "Approved Leave applications"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("HR Leave Application" WHERE(Status = FILTER(Approved)));
        }
        field(12; "Hr Disciplinary Cases"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("HR Disciplinary Cases");
        }
        field(13; "Approved Staff Advance loans"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Staff Advance Header" WHERE(Status = FILTER(Approved)));
        }
        // field(14; "Upcoming Staff Separation"; Integer)
        // {
        // }
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

    var
        OneMonth: Date;

}

