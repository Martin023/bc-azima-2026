#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185563 pageextension52185563 extends "Acc. Sched. KPI Web Srv. Lines" 
{
    layout
    {
        modify("Acc. Schedule Name")
        {
            ApplicationArea = Basic;
        }
        modify("Acc. Schedule Description")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Acc. Schedule Name"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Acc. Schedule Description"(Control 4)".

    }
    actions
    {
        modify(EditAccSchedule)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "EditAccSchedule(Action 5)".

    }
}
