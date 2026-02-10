TableExtension 52187236 tableextension52187236 extends "Sales Cr.Memo Header"
{
    fields
    {
        field(1; "Refund Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Normal Refund,Waiver Refund';
            OptionMembers = " ","Normal Refund","Waiver Refund";
        }
        field(1003; "Waiver Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(1004; "Waiver End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
}