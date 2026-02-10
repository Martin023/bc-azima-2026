#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186415 tableextension52186415 extends "General Ledger Setup"
{
    fields
    {
        field(50018; "Post Bank Rec"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Vote Transfer Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50050; "SMS Sender ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50051; "SMS Sender Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50052; "EMAIL Sender Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50053; "EMAIL Sender Address"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(39004041; "Allow Posting From [Time]"; Time)
        {
            Caption = 'Allow Posting From [Time]';
            DataClassification = ToBeClassified;
        }
        field(39004042; "Allow Posting To [Time]"; Time)
        {
            Caption = 'Allow Posting To [Time]';
            DataClassification = ToBeClassified;
        }
        field(39004043; "Witness Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(39004044; Verdict; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}
