table 52186253 "Employee Transfer"
{
    Caption = 'Employee Transfer';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            AutoIncrement=True;
        }
        field(2; "Employee Code"; Code[40])
        {
            Caption = 'Employee Code';
        }
        field(3; Department; Code[40])
        {
            Caption = 'Department';
        }
        field(4;date1;Date)
        {

        }
        field(5;month;integer)
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
