#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186424 tableextension52186424 extends "Bank Acc. Reconciliation Line"
{
    fields
    {
        field(50000; Reconciled; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //check if the type of entry that the user has selected is difference
                // if Rec.Type = Rec.Type::Difference then begin
                //     Error('Differences cannot be reconciled');
                // end;
            end;
        }
        field(50052; Imported; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50053; "Payer Information"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50054; "Transaction Information"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50055; "Debit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50056; "Credit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50057; "Date Cleared"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50058; Suggested; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'To separate Suggested from typed in should not modify suggested';
        }
        field(50059; "External Document No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50060; "Bank Leger Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
}
