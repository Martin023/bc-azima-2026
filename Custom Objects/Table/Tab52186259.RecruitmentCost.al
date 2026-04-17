table 52186259 "Recruitment Costs"

{
    DrillDownPageId="Recruitment Costs";
    LookupPageId="Recruitment Costs";

    fields
    {
        // FIELD FOR EMPLOYEE REQUISITION RECRUITMENT COSTS
        field(1; "Requisition No."; Code[50])
        {
            Caption = 'Requisition No.';
            TableRelation = "HR Employee Requisitions"."Requisition No.";
            Editable = false;
        }
        // FIELD FOR HR COMPANY ACTIVITIES (TRAINING) COSTS - KEPT FOR BACKWARD COMPATIBILITY
        field(5; "Training ID"; Code[50])
        {
            Caption = 'Training/Activity ID';
            TableRelation = "HR Company Activities".Code;
            Editable = false;
        }
        field(2; "Cost Item"; Code[30])
        {
            TableRelation = "HR Lookup Values".Code WHERE(Type = FILTER("Recruitment Cost"));

            trigger OnValidate()
            begin
                "Cost Item Description" := '';
                LookUpVal.Reset;
                //LookUpVal.SetRange(LookUpVal.Type, LookUpVal.Type::"Training Cost Item");
                LookUpVal.SetRange(LookUpVal.Code, "Cost Item");
                if LookUpVal.Find('-') then
                    "Cost Item Description" := LookUpVal.Description;
            end;
        }
        field(3; Cost; Decimal)
        {
        }
        field(4; "Cost Item Description"; Text[100])
        {
            Editable = false;
        }
    }

    keys
    {
        // PRIMARY KEY SUPPORTS BOTH REQUISITIONS AND TRAINING ACTIVITIES
        key(Key1; "Requisition No.", "Training ID", "Cost Item")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    
    // ADDED TRIGGER TO VALIDATE COST ITEM IS SELECTED
    trigger OnInsert()
    begin
        TestField("Cost Item");
    end;

    var
        LookUpVal: Record "HR Lookup Values";
}

