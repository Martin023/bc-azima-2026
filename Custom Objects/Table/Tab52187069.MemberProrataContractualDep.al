table 52187069 "Member Prorata_Contractual Dep"
{
    Caption = 'Member Prorata_Contractual Dep';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Member No"; Code[20])
        {
            Caption = 'Member No';
            trigger OnValidate()
            var
            begin
                if Member.Get("Member No") then
                    "Member Name" := member.Name;
            end;
        }
        field(2; "Loan No"; Code[20])
        {
            Caption = 'Loan No';
        }
        field(3; "Entry Date"; Date)
        {
            Caption = 'Entry Date';
            Editable = false;
        }
        field(4; "Effective Date"; Date)
        {
            Caption = 'Effective Date';
            Editable = false;
        }
        field(5; "Captured By"; Code[50])
        {
            Caption = 'Captured By';
            Editable = false;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
        }

        field(7; "Member Name"; text[100])
        {
            Caption = 'Member Name';
            Editable = false;
        }

        field(8; "Amount Off"; Decimal)
        {
            Caption = 'Amount Off';
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "Member No", "Entry Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    var
        Member: Record Members;
}
