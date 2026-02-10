#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186429 pageextension52186429 extends "CRM Synch. Job Status Part" 
{
    Caption = 'Microsoft Dynamics CRM Synch. Job Status';
    layout
    {
        modify("Failed Synch. Jobs")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Failed Synch. Jobs"(Control 6)".

    }
    actions
    {
        modify("Edit Job Queue Entries")
        {
            ApplicationArea = Basic;
        }
        modify("<Page CRM Connection Setup>")
        {
            Caption = 'Microsoft Dynamics CRM Connection Setup';
            ApplicationArea = Basic;
        }
        modify(Reset)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Edit Job Queue Entries"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""<Page CRM Connection Setup>"(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reset(Action 3)".

    }
}
