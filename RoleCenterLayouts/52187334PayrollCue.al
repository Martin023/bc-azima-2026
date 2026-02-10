table 52187334 PayrollCue
{
    Caption = 'PayrollCue';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "code"; Code[10])
        {
            Caption = 'code';
            DataClassification = ToBeClassified;
        }
        field(2; Salaries; Integer)
        {
            Caption = 'Salary List';
            CalcFormula = COUNT("Salary Header");
            FieldClass = FlowField;
        }
        field(3; BoardEmployees; Integer)
        {
            Caption = 'Board Employees';
            CalcFormula = COUNT(prBoard);
            FieldClass = FlowField;
        }
        field(4; "Highest Salary"; Integer)
        {
            Caption = 'Highest Salary';
            TableRelation = "Salary Lines".Amount;


        }
    }
    keys
    {
        key(PK; "code")
        {
            Clustered = true;
        }
    }
}
