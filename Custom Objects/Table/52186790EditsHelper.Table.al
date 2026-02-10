table 52186790 "Edits Helper"
{

    fields
    {
        
        field(1; "Edits Header No."; Code[50])
        {
            Editable = false;
        }
        field(2; "Record No."; Code[50])
        {
            Editable = false;
        }
        field(3; "Workflow Status"; Enum "Workflow Status Main Flags")
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("System Edits".Status where("No." = field("Edits Header No.")));
        }
        field(4; Posted; Boolean)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("System Edits".Posted where("No." = field("Edits Header No.")));
        }
        field(5; "Edit Type"; Option)
        {
            Editable = false;
            OptionMembers = " ","Business Loan","Records";
        }
        

    }

    keys
    {
        key(Key1; "Edits Header No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

}

