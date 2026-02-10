#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186430 pageextension52186430 extends "CRM Synch. Job Queue" 
{
    Caption = 'Microsoft Dynamics CRM Synch. Job Queue';
    layout
    {
        modify("Last Ready State")
        {
            ApplicationArea = Basic;
        }
        modify("Error Message")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Ready State"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Error Message"(Control 11)".

    }
    actions
    {
        modify(EditJob)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "EditJob(Action 14)".

    }
}
