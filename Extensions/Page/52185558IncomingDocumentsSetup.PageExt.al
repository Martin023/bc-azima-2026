#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185558 pageextension52185558 extends "Incoming Documents Setup" 
{
    layout
    {
        modify("General Journal Template Name")
        {
            ApplicationArea = Basic;
        }
        modify("General Journal Batch Name")
        {
            ApplicationArea = Basic;
        }
        modify("Require Approval To Create")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""General Journal Template Name"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""General Journal Batch Name"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Require Approval To Create"(Control 9)".

    }
    actions
    {
        modify(Approvers)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Approvers(Action 8)".


        //Unsupported feature: Property Deletion (Visible) on "Approvers(Action 8)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).

}
