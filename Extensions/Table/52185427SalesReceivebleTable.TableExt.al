TableExtension 52185427 tableextension52185427 extends "Sales & Receivables Setup"
{
    fields
    {
        field(10001; "Tenant Nos"; Code[100])
        {

            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}