table 52187019 "SMS Alerts Lines"
{
    Caption = 'SMS Alerts Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Header No"; Code[20])
        {
            Caption = 'Header No';
        }
        field(3; "Loan No"; Code[20])
        {
            Caption = 'Loan No';
            TableRelation = Loans."Loan No.";
            trigger OnValidate()
            begin
                CalcFields("Loan Product Type", "Loan Product Type Name");
            end;
        }
        field(4; Notice; Text[1000])
        {
            Caption = 'Notice';
        }
        field(5; "SMS Sent"; Boolean)
        {
            Caption = 'SMS Sent';
        }
        field(6; "Sent At"; DateTime)
        {
            Caption = 'Sent At';
        }
        field(7; "Email Address"; Text[50])
        {

        }
        field(8; "Phone Number"; Text[13])
        {

        }
        field(9; "Letter Route"; Text[250])
        {

        }
        field(10; "Email Sent"; Boolean)
        {
            Editable = false;
        }
        field(11; "Letter Genetrated"; Boolean)
        {
            Editable = false;
        }
        field(12; "Notice Type"; Option)
        {
            OptionMembers = SMS,Email,Letter;
        }
        field(13; "Member No"; Code[30])
        {
            TableRelation = Members."No.";
        }
        field(14; "Days In Arreas"; Integer)
        {

        }
        field(15; "Amount In Arreas"; Decimal)
        {

        }
        field(16; Recepient; Option)
        {
            OptionMembers = "Lonee","Guarantor";

        }
        field(17; "Notice Category"; Option)
        {
            OptionMembers = "First Notice","Second Notice","CRB Notice","CRB Listing Notice","Arrears Alert";

        }
        field(18; "Send this Notification"; Boolean)
        {

        }
        field(19; "Loan Product Type"; Code[50])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Loans."Loan Product Type" where("Loan No." = field("Loan No")));
        }
        field(20; "Loan Product Type Name"; Text[100])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Loans."Loan Product Type Name" where("Loan No." = field("Loan No")));

        }
        field(21; "Time Sent"; DateTime)
        {

        }
        field(22; "Sent By"; Code[50])
        {

        }

    }
    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }
}
