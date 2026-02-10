#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186432 tableextension52186432 extends "Approval Entry"
{
    fields
    {
        field(50000; "Primary Rec"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50001; "Record Identity No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Member Rec"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
}
