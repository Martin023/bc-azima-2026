#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186423 pageextension52186423 extends "CRM Product List" 
{
    Caption = 'Microsoft Dynamics CRM Products';
    layout
    {
        modify(ProductNumber)
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(Price)
        {
            ApplicationArea = Basic;
        }
        modify(StandardCost)
        {
            ApplicationArea = Basic;
        }
        modify(CurrentCost)
        {
            ApplicationArea = Basic;
        }
        modify(Coupled)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ProductNumber(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Price(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "StandardCost(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CurrentCost(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Coupled(Control 3)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetCurrentlyCoupledCRMProduct(PROCEDURE 2)".


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
