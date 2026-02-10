table 52187045 "DMU Cue"
{

    fields
    {
        field(1; "Open Attachments"; Integer)
        {
            CalcFormula = Count("Loan Recovery Header" WHERE(Status = FILTER(open), "Recovery Type" = const("Recovery and Attachment")));
            FieldClass = FlowField;
        }
        field(2; "CF Headers Pending Reversal"; Integer)
        {
            CalcFormula = Count("DMU Case Forwarding" WHERE("Case Closed" = const(false), "Case Intructions" = const(Reversals), "Current Departmrnt" = const('DMU'), "Originating Status" = const(sent)));
            FieldClass = FlowField;
        }
        field(3; "CF Fall off Headers Pending"; Integer)
        {
            CalcFormula = Count("DMU Case Forwarding" WHERE("Case Closed" = const(false), "Case Intructions" = const("Fall Off"), "Current Departmrnt" = const('DMU'), "Originating Status" = const(sent)));
            FieldClass = FlowField;
        }
        field(4; "Alerts Escalations"; Integer)
        {
            CalcFormula = Count("SMS Alerts Header" where("Auto Assign Task" = const(true),Status = const(Open)));
            FieldClass = FlowField;
        }
        
        field(6; "code"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
