table 52186801 "Debt Lines Logs"
{
    Caption = 'Loan Reversal Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Header No."; code[50])
        {
            Editable = false;
        }
        field(2; "Loan No."; Code[30])
        {
            TableRelation = "Debt Lines"."Loan No." where("Header No." = field("Header No."));

            trigger OnValidate()
            var
                Loans: Record Loans;
            begin

            end;
        }
        field(16; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(3; "Amount Collected"; Decimal)
        {
            trigger OnValidate()
            begin
                "Commision Amount" := 0;
                CalculateAmount();
            end;
        }
        field(4; "Document No."; Code[100])
        {

        }
        field(5; "Commision Percentgae"; Decimal)
        {
            MinValue = 0;
            MaxValue = 100;
            trigger OnValidate()
            begin
                "Commision Amount" := 0;
                CalculateAmount();
            end;
        }
        field(6; "Commision Amount"; Decimal)
        {

        }
        field(14; "Entry Time"; DateTime)
        {
            Editable = false;
        }
        field(15; "Entered By"; Code[50])
        {
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Header No.", "Loan No.","Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Entered By" := UserId;
        "Entry Time" := CurrentDateTime;
    end;

    var
        RecoveryHeader: Record "Loan Recovery Header";
        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        UserSetup: Record "User Setup";

    procedure CalculateAmount()
    begin
        if ("Amount Collected" <> 0) and ("Commision Percentgae" <> 0) then begin
            "Commision Amount" := Round(("Amount Collected" * ("Commision Percentgae" / 100)), 1, '<')
        end;
    end;
}
