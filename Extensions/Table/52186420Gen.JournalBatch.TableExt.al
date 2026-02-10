#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186420 tableextension52186420 extends "Gen. Journal Batch"
{
    fields
    {
        field(50000; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Approved;
        }
        field(50004; "FingerPrint Verified"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; SystemGeneratedGuid; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(50050; "Batch Amount"; Decimal)
        {
            CalcFormula = sum("Gen. Journal Line"."Debit Amount (LCY)" where("Journal Template Name" = field("Journal Template Name"),
                                                                              "Journal Batch Name" = field(Name)));
            FieldClass = FlowField;
        }
        field(50051; "User Id"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
    }
}
