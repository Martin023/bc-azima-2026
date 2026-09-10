table 52187009 "Member Form List"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Member Form List";

    fields
    {
        field(1; "Reference No"; Code[20])
        {
            Caption = 'Loan No./Ref No.';
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(3; "Member No."; Code[50])
        {
            Caption = 'Member No.';
            TableRelation = Members."No.";

            trigger OnValidate()
            var
                Member: Record Members;
            begin
                if Member.Get("Member No.") then
                    "Member Name" := Member.Name
                else
                    "Member Name" := '';
            end;
        }
        field(8; "Member Name"; Text[100])
        {
            Caption = 'Member Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Name WHERE("No." = FIELD("Member No.")));
            Editable = false;
        }
        field(4; "Member Form Types"; Enum "Member Form Types")
        {
            Caption = 'Form Type';
        }
        field(5; filed; Boolean)
        {
            Caption = 'Filed/Received';

            trigger OnValidate()
            begin
                "Filed By" := userid;
                "Filed Date" := Today;
                "Received Date" := Today;
            end;
        }
        field(6; "Filed By"; code[20])
        {
            Caption = 'Filed By.';
        }
        field(7; "Filed Date"; Date)
        {
            Caption = 'Filed Date';
        }
        field(9; "Received Date"; Date)
        {
            Caption = 'Received Date';
        }
        field(69; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin

            end;
        }
    }
    keys
    {
        key(PK; "Reference No", "Member No.")
        {
            Clustered = true;
        }
    }
}
