#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186197 pageextension52186197 extends "Workflow Templates" 
{
    layout
    {
        modify(Description)
        {
            ApplicationArea = Basic;
            Enabled = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 3)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control7(Control 7)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control8(Control 8)".

    }
    actions
    {
        modify(ViewAction)
        {
            ApplicationArea = Basic;
        }
        modify("New Workflow from Template")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ViewAction(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""New Workflow from Template"(Action 10)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
