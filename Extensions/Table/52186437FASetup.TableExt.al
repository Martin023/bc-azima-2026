#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186437 tableextension52186437 extends "FA Setup"
{
    fields
    {
        field(50050; "Asset Transfer Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(39003900; "Asset Clearance"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(39003901; "Asset Journal"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39003902; "Asset Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39003903; "Inward Donation Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(39003904; "Asset Issue"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}
