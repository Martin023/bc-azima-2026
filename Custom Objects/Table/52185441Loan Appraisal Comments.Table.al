table 52185441 "Loan Appraisal Comments"
{
    Caption = 'Loan Appraisal Comments';
    fields
    {

        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = Loans;
        }
        field(3; "Appraiser"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User";
        }
        field(4; "Entry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Entry Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Comment; Text[100])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if rec.Commented = true then
                    Error('You cannot edit a closed Comment');
            end;
        }
        field(7; Commented; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "client Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Loan No.", Comment)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(a; "Loan No.", Comment, "client Code")
        {
        }
    }

    trigger OnInsert()
    var

    begin
        "Entry Date" := today;
        "Entry Time" := time;
        Appraiser := UserId;
    end;

    trigger OnDelete()
    var
        Loansre: Record loans;
        ProdVariations: record "Product Variations";
    begin
        if Loansre.Get(Rec."Loan No.") then begin
            if Loansre.Status <> Loansre.Status::Open then
                Error('You  cannot delete comments when the loan status is %1', Loansre.Status);
            if Rec.Commented = true then
                Error('You cannot deleted this comment because the process was initiated');
            if Rec.Appraiser <> UserId then
                Error('This record can only be deleted by %1.', Rec.Appraiser);
        end;
        if ProdVariations.get(rec."Loan No.") then begin
            Error('You cannot delete this record because it has been used in the Product Variations: %1', ProdVariations."No.");
        end;
    end;

    trigger OnModify()
    var
        Loansre: Record loans;
        ProdVariations: record "Product Variations";
    begin
        if Loansre.Get(Rec."Loan No.") then begin
            if Loansre.Status <> Loansre.Status::Open then
                Error('You  cannot delete comments when the loan status is %1', Loansre.Status);
            if Rec.Commented = true then
                Error('You cannot Modify this comment because the process was initiated');
            if Rec.Appraiser <> UserId then
                Error('This record can only be modified by %1.', Rec.Appraiser);
        end;
        if ProdVariations.get(rec."Loan No.") then begin
            if Rec.Appraiser <> UserId then
                Error('This record can only be modified by %1.', Rec.Appraiser);
        end;
    end;
}