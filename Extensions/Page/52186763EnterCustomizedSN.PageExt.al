#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186763 pageextension52186763 extends "Enter Customized SN" 
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
        modify(CustomizedSN)
        {
            ApplicationArea = Basic;
        }
        modify(Increment)
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

    //Unsupported feature: Property Modification (Length) on "CustomizedSN(Variable 1010)".

    //var
        //>>>> ORIGINAL VALUE:
        //CustomizedSN : 50;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CustomizedSN : 20;
        //Variable type has not been exported.

    //Unsupported feature: Property Deletion (Attributes) on "SetFields(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "GetFields(PROCEDURE 2)".


    //Unsupported feature: Property Modification (Length) on "GetFields(PROCEDURE 2).GetCustomizedSN(Parameter 1002)".

}
