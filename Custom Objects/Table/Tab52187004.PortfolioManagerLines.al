table 52187004 "Portfolio Manager Lines"
{
    Caption = 'Portfolio Manager Lines';
    DataClassification = ToBeClassified;
    // DrillDownPageId = Port

    fields
    {
        field(1; "Header No"; Code[20])
        {
            Caption = 'Header No';
        }
        field(2; "Member No"; Code[20])
        {
            Caption = 'Member No';
            TableRelation = "Members"."No.";
        }
        field(3; Name; Text[1000])
        {
            Caption = 'Name';
        }
        field(4; "Primary Identification"; Code[30])
        {
            Caption = 'Primary Identification';
        }
        field(5; "Employer Code"; Code[30])
        {
            Caption = 'Employer Code';
        }
        field(6; Workstation; Code[20])
        {
            Caption = 'Workstation';
        }
        field(7; "Workstation Name"; Text[100])
        {
            Caption = 'Workstation Name';
        }
        field(8; "Phone No"; Code[20])
        {
            Caption = 'Phone No';
        }
        field(9; "PF Number"; Code[20])
        {
            Caption = 'PF Number';
        }
        field(10; Status; Enum "Member Status")
        {
            Caption = 'Status';
        }
        field(11; "Sub Status"; Enum "Member Status Sub Flags")
        {
            Caption = 'Sub Status';
        }
        field(12; "Member Class"; Code[20])
        {
            Caption = 'Member Class';
        }
        field(13; "Sales Rep Type"; Code[20])
        {
            Caption = 'Sales Rep Type';
        }
        field(14; "Sales Rep code"; Code[20])
        {
            Caption = 'Sales Rep Code';
        }
        field(15; Gender; Enum "Gender")
        {
            Caption = 'Gender';
        }
        field(16; "Registration Date"; Date)
        {
            Caption = 'Registration Date';
        }

    }
    keys
    {
        key(PK; "Header No", "Member No")
        {
            Clustered = true;
        }
    }
}
