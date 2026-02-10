table 52186281 "Saving Interest Import Buffer"
{
    Caption = 'Saving Interest Import Buffer';
    DataClassification = ToBeClassified;
    DrillDownPageID = "Saving Interest Import Buffer";
    LookupPageID = "Saving Interest Import Buffer";

    fields
    {
        field(2; "Header No."; Code[20])
        {
            TableRelation = "Savings Interest Header"."No.";
        }
        field(1; No; Integer)
        {
        }
        field(3; "Member No"; Code[20])
        {

        }
        field(6; "Interest Amount"; Decimal)
        {
        }
        field(4; "Interest Date"; Date)
        {
        }
        field(10; "Lowest Bal"; Decimal)
        {
        }
        field(11; NotFound; Boolean)
        {
        }


    }

    keys
    {
        key(Key1; No, "Header No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ValidateEntries;

    end;

    trigger OnInsert()
    begin
        ValidateEntries
    end;

    trigger OnModify()
    begin
        ValidateEntries;
    end;

    procedure ValidateEntries()
    begin
        if SavingIntHeader.get(Rec."Header No.") then begin
            if (SavingIntHeader.Status <> SavingIntHeader.Status::Open) or SavingIntHeader.Posted then
                error('You can not modify entries when the header status is ' + format(SavingIntHeader.Status) + '. or Posted is true');
        end;
    end;

    var
        SavingIntHeader: Record "Savings Interest Header";
}