table 52186255 "Salary Grade Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Salary Grade"; Code[20])
        {
            Editable = false;
            NotBlank = true;
            TableRelation = "Salary Grades"."Salary Grade";
        }
        field(2; Amount; Decimal)
        {

        }
        field(3; "Transaction Description"; text[100])
        {
            TableRelation = "PR Transaction Codes"."Transaction Name";
            Editable = false;

        }

        field(5; "Transaction Code"; Code[20])
        {

            TableRelation = "PR Transaction Codes"."Transaction Code";
            trigger OnValidate()
            var
                TransactionCodes: record "PR Transaction Codes";
            begin
                TransactionCodes.reset();
                TransactionCodes.SetRange("Transaction Code", rec."Transaction Code");
                if TransactionCodes.findset() then begin
                    "Transaction Description" := TransactionCodes."Transaction Name";
                    Frequency := TransactionCodes.Frequency;
                end;

            end;

        }
        field(6; Frequency; Option)
        {
            Description = 'Fixed,Varied';
            OptionMembers = "Fixed",Varied;
        }

    }

    keys
    {
        key(Key1; "Salary Grade", "Transaction Code")
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