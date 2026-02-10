#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186762 pageextension52186762 extends "Enter Quantity to Create" 
{
    layout
    {
        modify(ItemNo)
        {
            ApplicationArea = Basic;
        }
        modify(VariantCode)
        {
            ApplicationArea = Basic;
        }
        modify(QtyToCreate)
        {
            ApplicationArea = Basic;
        }
        modify(CreateNewLotNo)
        {
            ApplicationArea = Basic;
        }
    }

    //Unsupported feature: Property Deletion (Attributes) on "SetFields(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "GetFields(PROCEDURE 2)".

}
