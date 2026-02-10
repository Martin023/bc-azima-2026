table 52187101 "Bosa Salary Appraisal"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(2; "Loan No"; code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Member No"; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Basic Income",Earnings,"Deductions";
        }
        field(4; "Discription Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bosa Salary Appraisal Set-up".Code;
            trigger OnValidate()
            var
                myInt: Integer;
                BosaSetup: Record "Bosa Salary Appraisal Set-up";

            begin
                BosaSetup.Reset();
                BosaSetup.SetRange(Code, Rec."Discription Type");
                if BosaSetup.FindFirst() then
                    rec.Amount := BosaSetup.Amount;

            end;
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Loan No", "Discription Type", "Member No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}