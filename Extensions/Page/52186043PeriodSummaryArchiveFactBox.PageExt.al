#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186043 pageextension52186043 extends "Period Summary Archive FactBox" 
{
    layout
    {
        modify("DateQuantity[1]")
        {
            ApplicationArea = Basic;
        }
        modify("DateQuantity[2]")
        {
            ApplicationArea = Basic;
        }
        modify("DateQuantity[3]")
        {
            ApplicationArea = Basic;
        }
        modify("DateQuantity[4]")
        {
            ApplicationArea = Basic;
        }
        modify("DateQuantity[5]")
        {
            ApplicationArea = Basic;
        }
        modify("DateQuantity[6]")
        {
            ApplicationArea = Basic;
        }
        modify("DateQuantity[7]")
        {
            ApplicationArea = Basic;
        }
        modify(TotalQuantity)
        {
            ApplicationArea = Basic;
        }
        modify(PresenceQty)
        {
            ApplicationArea = Basic;
        }
        modify(AbsenceQty)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "TotalQuantity(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PresenceQty(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on "AbsenceQty(Control 6)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "UpdateData(PROCEDURE 1)".

}
