table 52187072 "Loan Terms And Conditions"
{
    Caption = 'Loan Terms And Conditions';
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
            TableRelation = Loans;
        }
        field(3; "Appraiser"; Code[50])
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
        fieldgroup(a; "Loan No.", Comment)
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
    begin
        if Rec.Appraiser <> UserId then
            Error('This record can only be delered by %1.', Rec.Appraiser);
    end;

    trigger OnModify()
    begin
        if Rec.Appraiser <> UserId then
            Error('This record can only be modified by %1.', Rec.Appraiser);
    end;
}