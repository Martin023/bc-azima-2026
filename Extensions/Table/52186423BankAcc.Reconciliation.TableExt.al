#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186423 tableextension52186423 extends "Bank Acc. Reconciliation"
{
    fields
    {
        field(50000; Reconciled; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //check if the type of entry that the user has selected is difference
                //if Rec.Type = Rec.Type::Difference then begin
                //  Error('Differences cannot be reconciled');
                //end;
            end;
        }
        field(50001; "Notes Line 1"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Notes Line 2"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Notes Line 3"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Notes Line 4"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Notes Line 5"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Notes Line 6"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Approved;
        }
        field(39005981; "Reconciliation Type"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionMembers = " ",Auto,Manual;
        }
    }
}
