namespace MNS.MNS;

using Microsoft.FixedAssets.Journal;

tableextension 52185428 "FA Reclass. Journal Line" extends "FA Reclass. Journal Line"
{
    fields
    {
        field(23; Status; Enum "Workflow Status Main Flags")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
    }
}
