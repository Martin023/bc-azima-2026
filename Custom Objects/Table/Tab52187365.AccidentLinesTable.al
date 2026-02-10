table 52187365 "Accident Lines Table"
{
    Caption = 'Accident Lines Table';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = '';
        }
        field(8; "Accident No."; Code[20])
        {
        }
        field(2; "Driver Name"; Text[50])
        {
        }
        field(3; "Driver ID No."; CODE[20])
        {
        }
        field(4; "Phone No."; Code[20])
        {
        }
        field(5; "Vehicle No."; Code[20])

        {
        }
        field(7; "Vehicle Make"; Code[20])
        {
        }
        field(6; "Vehicle Insurance"; Option)
        {
            OptionMembers = " ", Comprehensive, "Third Party";
            OptionCaption = ' , Comprehensive, Third Party';
        }
         field(9; "Captured By"; Code[50])
        {
        }
        field(10; "Captured On"; DateTime)
        {
        }
        field(11; "Driver License No."; Code[20])
        {
        }
        field(12; "Insurance Policy No."; Code[100])
        {
        }
    }
    keys
    {
        key(PK; "Code", "Accident No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    
    begin
        Rec."Captured On" := CURRENTDATETIME;
        Rec."Captured By" := UserId;
    end;
}
