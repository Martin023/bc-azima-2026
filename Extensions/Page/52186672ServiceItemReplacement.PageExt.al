#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186672 pageextension52186672 extends "Service Item Replacement" 
{
    layout
    {
        modify(ServItemNo)
        {
            ApplicationArea = Basic;
        }
        modify("Item.""No.""")
        {
            ApplicationArea = Basic;
        }
        modify("Item.Description")
        {
            ApplicationArea = Basic;
        }
        modify(ServItemVariantCode)
        {
            ApplicationArea = Basic;
        }
        modify(OldSerialNo)
        {
            ApplicationArea = Basic;
        }
        modify("Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Item Description")
        {
            ApplicationArea = Basic;
        }
        modify(VariantCode)
        {
            ApplicationArea = Basic;
        }
        modify(NewSerialNo)
        {
            ApplicationArea = Basic;
        }
        modify(CopyComponents)
        {
            ApplicationArea = Basic;
        }
        modify(Replacement)
        {
            ApplicationArea = Basic;
        }
    }

    //Unsupported feature: Property Modification (Length) on "OldSerialNo(Variable 1007)".

    //var
        //>>>> ORIGINAL VALUE:
        //OldSerialNo : 50;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //OldSerialNo : 20;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on "NewSerialNo(Variable 1008)".

    //var
        //>>>> ORIGINAL VALUE:
        //NewSerialNo : 50;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //NewSerialNo : 20;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on "VariantCode(Variable 1011)".

    //var
        //>>>> ORIGINAL VALUE:
        //VariantCode : 10;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //VariantCode : 20;
        //Variable type has not been exported.


    //Unsupported feature: Property Modification (Length) on "ServItemVariantCode(Variable 1013)".

    //var
        //>>>> ORIGINAL VALUE:
        //ServItemVariantCode : 10;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //ServItemVariantCode : 20;
        //Variable type has not been exported.

    //Unsupported feature: Property Deletion (Attributes) on "SetValues(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "ReturnSerialNo(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (Attributes) on "ReturnReplacement(PROCEDURE 4)".


    //Unsupported feature: Property Modification (Length) on "ReturnVariantCode(PROCEDURE 3).ReturnValue".


    //Unsupported feature: Property Deletion (Attributes) on "ReturnVariantCode(PROCEDURE 3)".


    //Unsupported feature: Property Deletion (Attributes) on "ReturnCopyComponentsFrom(PROCEDURE 5)".


    //Unsupported feature: Property Deletion (Attributes) on "SetParameters(PROCEDURE 6)".


    //Unsupported feature: Property Modification (Length) on "SetValues(PROCEDURE 1).VariantCode2(Parameter 1004)".


    //Unsupported feature: Property Modification (Length) on "SetParameters(PROCEDURE 6).VariantCodeFrom(Parameter 1000)".

}
