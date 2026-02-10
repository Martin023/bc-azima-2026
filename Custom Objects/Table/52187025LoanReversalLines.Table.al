table 52187025 "Loan Reversal Lines"
{
    Caption = 'Loan Reversal Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Header No."; Code[30])
        {
        }
        field(2; "Defaulter Member No."; Code[30])
        {

        }
        field(3; "Defaulter Loan No"; Code[30])
        {
            TableRelation = Loans;
        }
        field(4; "Refund Type"; Option)
        {
            OptionMembers = "Deposits Reversal","Guarantor Payoff";
        }

        field(5; "Interest Attached Amount"; Decimal)
        {
        }
        field(18; "Principle Attached Amount"; Decimal)
        {
        }
        field(6; "Guarantor Member No."; Code[30])
        {
            TableRelation = Members;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                CalcFields("Guarantor Name");
            end;
        }

        field(7; "Guarantor Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Name where("No." = field("Guarantor Member No.")));
        }

        field(8; "Guarantor Loan No"; Code[30])
        {
            TableRelation = Loans;
        }

        field(9; "Guarantor Interest Balance"; Decimal)
        {
            Description = 'This money is to be posted to the main loan as principle balance//To balance with the main loan';
        }

        field(10; "Guarantor Principal Balance"; Decimal)
        {
            Description = 'This money is to be posted to the main loan as interest balance//To balance with the main loan';
        }

        field(11; "Interests Accrued"; Decimal)
        {

        }

        field(12; "Interest Paid By Guarantor"; Decimal)
        {
            Description = 'This money is to be posted to the main loan as interest balance against guarantor FOSA//Can pass through the guarantor loan';

        }
        field(13; "Principle Paid By Guarantor"; Decimal)
        {
            Description = 'This money is to be posted to the main loan as principle balance against guarantor FOSA//Can pass through the guarantor loan';

        }
        field(14; "Interest Reappotionments"; Decimal)
        {

        }
        field(15; "Principle Reappotionments"; Decimal)
        {

        }
        field(16; "FOSA Reappotionments"; Decimal)
        {

        }

        field(17; "FOSA Refund"; Decimal)
        {

        }

        field(19; "Total Int To Defaulter"; Decimal)
        {

        }
        field(20; "Total Pr To Defaulter"; Decimal)
        {

        }

        field(21; "Total Loan To Defaulter"; Decimal)
        {

        }

    }
    keys
    {
        key(PK; "Header No.", "Guarantor Member No.","Refund Type")
        {
            Clustered = true;
        }
    }
}
