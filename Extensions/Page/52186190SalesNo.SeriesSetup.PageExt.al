#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186190 pageextension52186190 extends "Sales No. Series Setup" 
{
    layout
    {
        modify("Quote Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Blanket Order Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Order Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Return Order Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Invoice Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Credit Memo Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Reminder Nos.")
        {
            ApplicationArea = Basic;
        }
        modify("Fin. Chrg. Memo Nos.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Quote Nos."(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Blanket Order Nos."(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order Nos."(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Return Order Nos."(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Nos."(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Credit Memo Nos."(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reminder Nos."(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fin. Chrg. Memo Nos."(Control 7)".

    }
    actions
    {
        modify(Setup)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Setup(Action 3)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetFieldsVisibility(PROCEDURE 1)".

}
