#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185765 pageextension52185765 extends "Dimension Set Entries" 
{
    layout
    {
        modify("Dimension Code")
        {
            ApplicationArea = Basic;
        }
        modify("Dimension Name")
        {
            ApplicationArea = Basic;
        }
        modify(DimensionValueCode)
        {
            ApplicationArea = Basic;
        }
        modify("Dimension Value Name")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimension Code"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimension Name"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DimensionValueCode(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Dimension Value Name"(Control 4)".

    }

    //Unsupported feature: Code Insertion on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //begin
        /*
        IF FormCaption <> '' THEN
          CurrPage.CAPTION := FormCaption;
        */
    //end;


    //Unsupported feature: Code Insertion on "OnInit".

    //trigger OnInit()
    //Parameters and return type have not been exported.
    //begin
        /*
        IF FormCaption <> '' THEN
          CurrPage.CAPTION := FormCaption;
        */
    //end;

    //Unsupported feature: Property Deletion (Attributes) on "SetFormCaption(PROCEDURE 1)".

}
