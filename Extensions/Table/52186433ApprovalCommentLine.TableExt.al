#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186433 tableextension52186433 extends "Approval Comment Line"
{
    fields
    {
        field(39003900; "Approved Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(39003901; "Approved Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(39003902; "Approved Return Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(39003903; Reason; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(39003904; "Leave Allowance Granted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39003905; "Driver Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(39003906; "Vehicle Registration"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }
}
