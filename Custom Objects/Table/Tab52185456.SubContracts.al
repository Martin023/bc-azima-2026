table 52185456 "Sub Contracts"
{
    Caption = 'Sub Contracts';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Header Contract No."; Code[20])
        {
            Caption = 'Header Contract No.';
        }
        field(2; "Sub Contract No."; Code[20])
        {
            Caption = 'Sub Contract No.';
            TableRelation = Contracts."Contract No";
            trigger OnValidate()
            begin
                Contracts.RESET;
                Contracts.GET(REC."Sub Contract No.");
                IF rec."Header Contract No." = Contracts."Contract No" then
                    Error('Sub Contract No. cannot be the same as Header Contract No.')
                else begin
                    Rec."Sub Contract Description" := Contracts."Contract Description";
                    Rec."Sub Contract Type" := Contracts."Contract Type";
                    Rec."Start Date" := Contracts."Start Date";
                    Rec."End Date" := Contracts."End Date";
                end;
            end;
        }
        field(3; "Sub Contract Description"; Code[100])
        {
            Caption = 'Contract Description';
        }
        field(4; "Sub Contract Type"; Option)
        {
            Caption = 'Contract Type';
            OptionMembers = " ","service agreement",lease,"annual maintenance","Non Disclosure Agreement","Data Protection Agreement";
        }
        field(5; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(6; "End Date"; Date)
        {
            Caption = 'End Date';
        }
    }
    keys
    {
        key(PK; "Header Contract No.", "Sub Contract No.")
        {
            Clustered = true;
        }
    }

    var
        Contracts: Record "Contracts";
}
