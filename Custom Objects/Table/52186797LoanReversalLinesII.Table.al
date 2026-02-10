table 52186797 "Loan Reversal Lines II"
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
        field(22; "Attached Amount"; Decimal)
        {

        }
        field(23; "Opening Loan Balance"; Decimal)
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
        field(14; "Interest Refund"; Decimal)
        {
            trigger OnValidate()
            begin
                if "Refund Type" = Rec."Refund Type"::"Guarantor Payoff" then begin
                    "Total FOSA Refund" := "Interest Refund" + "Principle Refund";
                    "Total Int To Defaulter" := "Interest Refund" + "Guarantor Interest Balance";
                    "Total Loan To Defaulter" := "Interest Refund" + "Principle Refund" + "Guarantor Interest Balance" + "Guarantor Principal Balance";
                end;
                if "Refund Type" = Rec."Refund Type"::"Deposits Reversal" then begin
                    if "Interest Refund" > "Attached Amount" then Error('Interest amount cannot be greater than the total attached amount');

                    "Total Int To Defaulter" := "Interest Refund";
                    "Principle Refund" := "Attached Amount" - "Interest Refund";
                    "Total Pr To Defaulter" := "Principle Refund";

                    "Total Loan To Defaulter" := "Attached Amount";
                    
                end;
            end;
        }
        field(15; "Principle Refund"; Decimal)
        {
            trigger OnValidate()
            begin
                if "Refund Type" = Rec."Refund Type"::"Guarantor Payoff" then begin
                    "Total FOSA Refund" := "Interest Refund" + "Principle Refund";
                    "Total Pr To Defaulter" := "Principle Refund" + "Guarantor Principal Balance";
                    "Total Loan To Defaulter" := "Interest Refund" + "Principle Refund" + "Guarantor Interest Balance" + "Guarantor Principal Balance";
                end;
                if "Refund Type" = Rec."Refund Type"::"Deposits Reversal" then begin
                    if "Principle Refund" > "Attached Amount" then Error('Principle amount can not be greater than the total attached amount');
                    "Total Pr To Defaulter" := "Principle Refund";

                    "Total Int To Defaulter" := "Attached Amount" -"Principle Refund";
                    "Interest Refund" := "Total Int To Defaulter";

                    "Total Loan To Defaulter" := "Attached Amount";

                end;

                if "Principle Refund" > "Attached Amount" then Error('Principle refund cannot be greater than the attached amount');
            end;

        }
        field(16; "FOSA Reappotionments"; Decimal)
        {

        }

        field(17; "Total FOSA Refund"; Decimal)
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
        key(PK; "Header No.", "Guarantor Member No.")
        {
            Clustered = true;
        }
    }
}
