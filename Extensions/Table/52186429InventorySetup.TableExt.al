#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
TableExtension 52186429 tableextension52186429 extends "Inventory Setup"
{
    fields
    {
        field(50003; "Item Jnl Template"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Template";
        }
        field(50004; "Item Jnl Batch"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch".Name;
        }
        field(50005; "Stock Keeping Nos."; code[40])
        {
            TableRelation = "No. Series".Code;
        }
         field(50006; "Disposal Nos."; code[40])
        {
            TableRelation = "No. Series".Code;
        }
        field(50007;"Item Expiry Notification";DateFormula)
        {

        }
    }
}
