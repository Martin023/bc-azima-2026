#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186217 pageextension52186217 extends "Workflow User Group Members" 
{
    layout
    {
        modify("User Name")
        {
            ApplicationArea = Basic;
        }
        modify("Sequence No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""User Name"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sequence No."(Control 4)".

        addafter("Sequence No.")
        {
            // field("Minimum Amount";"Minimum Amount")
            // {
            //     ApplicationArea = Basic;
            // }
        }
    }
}
