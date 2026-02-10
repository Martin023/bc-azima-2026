#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186205 pageextension52186205 extends "Sent Notification Entries" 
{
    layout
    {
        modify(ID)
        {
            ApplicationArea = Basic;
        }
        modify(Type)
        {
            ApplicationArea = Basic;
        }
        modify("Recipient User ID")
        {
            ApplicationArea = Basic;
        }
        modify("FORMAT(""Triggered By Record"")")
        {
            ApplicationArea = Basic;
        }
        modify("Created Date-Time")
        {
            ApplicationArea = Basic;
        }
        modify("Created By")
        {
            ApplicationArea = Basic;
        }
        modify("Sent Date-Time")
        {
            ApplicationArea = Basic;
        }
        modify("Notification Method")
        {
            ApplicationArea = Basic;
        }
        modify("Aggregated with Entry")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ID(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Type(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Recipient User ID"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""FORMAT(""Triggered By Record"")"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Created Date-Time"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Created By"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sent Date-Time"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Notification Method"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Aggregated with Entry"(Control 13)".

    }
    actions
    {
        modify(ExportContent)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ExportContent(Action 8)".

    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
