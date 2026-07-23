table 52185579 "CEO Cue"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        // EMPLOYEES
        field(2; "Active Employees"; Integer)
        {
            CalcFormula = Count("HR Employees" WHERE(Status = FILTER(Active)));
            FieldClass = FlowField;
        }
        // APPRAISALS
        field(3; "Open Appraisals"; Integer)
        {
            CalcFormula = Count("HR Individual Targets Header" WHERE(Status = FILTER(Open)));
            FieldClass = FlowField;
        }
        field(4; "Pending Approval Appraisals"; Integer)
        {
            CalcFormula = Count("HR Individual Targets Header" WHERE(Status = FILTER("Pending Approval")));
            FieldClass = FlowField;
        }
        field(5; "Approved Appraisals"; Integer)
        {
            CalcFormula = Count("HR Individual Targets Header" WHERE(Status = FILTER(Approved)));
            FieldClass = FlowField;
        }
        // DEPARTMENT TARGETS
        field(6; "Open Dept Targets"; Integer)
        {
            CalcFormula = Count("HR Department Targets Header" WHERE(Status = FILTER(Open)));
            FieldClass = FlowField;
        }
        field(7; "Approved Dept Targets"; Integer)
        {
            CalcFormula = Count("HR Department Targets Header" WHERE(Status = FILTER(Approved)));
            FieldClass = FlowField;
        }
        // LEAVE
        field(8; "Pending Leave Applications"; Integer)
        {
            CalcFormula = Count("HR Leave Application" WHERE(Status = FILTER("Pending Approval")));
            FieldClass = FlowField;
        }
        // APPROVALS
        field(9; "Pending Approvals"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE(Status = CONST(Open)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
}
