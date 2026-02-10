table 52185943 Milestones
{

    fields
    {
        field(1; "Contract No"; Code[30])
        {
            TableRelation = Contracts;
        }
        field(3; "Milestone Stage"; Code[30])
        {

            trigger OnValidate()
            begin
                // Milestones.RESET;
                // Milestones.SETCURRENTKEY("Line No");
                // Milestones.SETRANGE("Contract No",Rec."Contract No");
                // Milestones.SETFILTER("Milestone Stage",<>);
                // IF Milestones.FINDLAST THEN BEGIN
                //
                // END;
            end;
        }
        field(4; "Start Date"; Date)
        {
        }
        field(5; "End Date"; Date)
        {
        }
        field(6; "Completed %"; Decimal)
        {
        }
        field(8; "Stage Description"; Text[30])
        {
            Editable = true;
        }
        field(9; "Committee Remarks"; Option)
        {
            OptionCaption = ',Fully Completed,Partially Completed';
            OptionMembers = " ","Fully Completed","Partially Completed";
        }
        field(11; "Milestone Status"; Option)
        {
            OptionMembers = New,"In Progress","In Testing","On Hold",Completed;
        }
        field(12; "Line No"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Contract No", "Milestone Stage")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ContractCycle: Record "Contract Cycle";
        ContractCycleStage: Record "Contract Cycle Stage";
        Milestones: Record Milestones;
}

