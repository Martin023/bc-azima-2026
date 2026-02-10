#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185559 pageextension52185559 extends "Incoming Document Approvers" 
{
    layout
    {
        modify("User Name")
        {
            ApplicationArea = Basic;
        }
        modify("Full Name")
        {
            ApplicationArea = Basic;
        }
        modify(IsApprover)
        {
            ApplicationArea = Basic;
        }
        modify("License Type")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""User Name"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Full Name"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "IsApprover(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""License Type"(Control 6)".

    }
}
