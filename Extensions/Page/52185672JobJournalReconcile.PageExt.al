#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185672 pageextension52185672 extends "Job Journal Reconcile" 
{
    layout
    {
        modify("Unit of Measure Code")
        {
            ApplicationArea = Basic;
        }
        modify("Work Type Code")
        {
            ApplicationArea = Basic;
        }
        modify(Quantity)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Unit of Measure Code"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Work Type Code"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quantity(Control 10)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetJobJnlLine(PROCEDURE 1)".

}
