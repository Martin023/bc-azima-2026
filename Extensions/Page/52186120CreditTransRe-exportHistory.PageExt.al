#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186120 pageextension52186120 extends "Credit Trans Re-export History" 
{
    layout
    {
        modify("Re-export Date")
        {
            ApplicationArea = Basic;
        }
        modify("Re-exported By")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Re-export Date"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Re-exported By"(Control 4)".

    }
}
