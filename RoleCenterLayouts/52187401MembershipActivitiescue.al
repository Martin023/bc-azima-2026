table 52187401 "Membership Activities Cue"
{
    Caption = 'Membership Activities Cue';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Open Member Applications"; Integer)
        {
            Caption = 'Open Member Applications';
            CalcFormula = COUNT("Member Application" WHERE(Status = CONST(Open), "Sent Back to CRM" = const(false), "Sent Back to M-Smart" = const(false)));
            FieldClass = FlowField;
        }
        field(2; "Open Member Edits"; Integer)
        {
            Caption = 'Open Member Edits';
            CalcFormula = COUNT("System Edits" WHERE(Status = CONST(Open), "Table ID" = const(Database::members)));
            FieldClass = FlowField;
        }
        field(3; "Open CRM Member Edits"; Integer)
        {
            Caption = 'Open CRM Member Edits';
            CalcFormula = COUNT("CRM Member Edit" WHERE(Status = CONST(Open), "Sent Back to CRM" = const(false)));
            FieldClass = FlowField;
        }
        field(5; "Open M-Smart Member Edits"; Integer)
        {
            Caption = 'Open M-Smart Member Edits';
            CalcFormula = COUNT("M-Smart Member Edit" WHERE(Status = CONST(Open), "Sent Back to M-Smart" = const(false)));
            FieldClass = FlowField;
        }
        field(6; "Open M-Smart Documents"; Integer)
        {
            Caption = 'Open M-Smart Documents';
            CalcFormula = COUNT("M-Smart Documents" WHERE("Landing Department" = const(RECORDS), Status = const(Open)));
            FieldClass = FlowField;
        }
        field(7; "Open Dependancy Applications"; Integer)
        {
            Caption = 'Open Dependancy Applications';
            CalcFormula = COUNT("Dependancies Applications" where(Status = const(Open)));
            FieldClass = FlowField;
        }

        field(4; "code"; Code[10])
        {
        }
        field(8; "Members Created Today"; Integer)
        {
            Caption = 'Members Created Today';
        }
        field(9; "Total Members"; Integer)
        {
            Caption = 'Total Members';
            FieldClass = FlowField;
            CalcFormula = COUNT("Members" WHERE(Status = const(Active)));
        }
        field(10; "Open Portal Applications"; Integer)
        {
            Caption = 'Open Portal Applications';
            CalcFormula = count("Member Application" where("Source Aplication" = filter("Members Portal"), Status = const(Open)));
            FieldClass = FlowField;
        }
        field(11; "Open Depedancy Applications"; Integer)
        {
            Caption = 'Open Depedancy Applications';
            CalcFormula = count("Dependancies Applications" where("Source Application" = filter("Member Portal"), Status = const(Open)));
            FieldClass = FlowField;
        }
        field(12; "Open Signature Edits"; Integer)
        {
            Caption = 'Open Signature Edits';
            CalcFormula = COUNT("System Edits" WHERE(Status = CONST(Open), "Table ID" = const(Database::"Image Data"), "Request Source" = const("M-Portal")));
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(PK; "code")
        {
            Clustered = true;
        }
    }

}

