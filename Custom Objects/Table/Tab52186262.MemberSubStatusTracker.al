table 52186262 "Member Sub-Status Tracker"
{
    Caption = 'Member Sub-Status Tracker';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Integer)
        {
            Caption = 'No';
            AutoIncrement = true;
        }
        field(2; "Member No."; Code[50])
        {
            Caption = 'Member No.';
        }
        field(3; Status; Enum "Member Status")
        {
            Caption = 'Status';
        }
        field(4; "Sub-Status"; Enum "Member Status Sub Flags")
        {
            Caption = 'Sub-Status';
        }
        field(5; "Date Modified"; Date)
        {
            Caption = 'Date Modified';
        }
        field(6; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
        }
        field(7; "Current Subflag"; Boolean)
        {
            Caption = 'Current Subflag';
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
}
