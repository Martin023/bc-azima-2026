#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings

PageExtension 52186371 "Customer List Ext" extends "Customer list"
{
    layout
    {
        addafter("Payments (LCY)")
        {
            field("Created By"; Rec."Created By")
            {
                Editable = false;
            }
            field("Created At"; Rec."Created At")
            {

            }
            field("Entrance Date"; Rec."Created Date")
            {
                Editable = false;
            }
        }

    }
}
