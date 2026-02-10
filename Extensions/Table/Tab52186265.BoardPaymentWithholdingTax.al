table 52186265 "Deleg. Payment Withholding Tax"
{
    Caption = 'Board Payment Withholding Tax';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Deleg. Payment Withholding Tax";

    fields
    {
        field(1; No; Integer)
        {
            Caption = 'No';
        }
        field(2; "Payment No"; Code[50])
        {
            Caption = 'Payment No';
        }
        field(3; "Member No"; Code[50])
        {
            Caption = 'Member No';
            trigger OnValidate()
            begin
                if Members.Get("Member No") then
                    "Delegate KRA PIN" := Members."P.I.N Number";
            end;
        }
        field(4; "Date paid"; Date)
        {
            Caption = 'Date paid';
        }
        field(5; "Total Payment"; Decimal)
        {
            Caption = 'Total Payment';
        }
        field(6; "Withholding Tax Amount"; Decimal)
        {
            Caption = 'Withholding Tax Amount';
        }
        field(7; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
        field(9; "Withholding Tax Acc."; Code[20])
        {
            Caption = 'Withholding Tax Acc.';
        }
        field(10; "Delegate KRA PIN"; Code[20])
        {
            Caption = 'Delegate KRA PIN';
        }
    }
    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }
    }
    trigger Ondelete()
    begin
        Error('Deletion is not allowed for this Table')
    end;

    var
        Members: Record Members;
}
