#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187053 pageextension52187053 extends "Approval Comments FactBox" 
{
    layout
    {
        modify(Comment)
        {
            ApplicationArea = Basic;
        }
        modify("User ID")
        {
            ApplicationArea = Basic;
        }
        modify("Date and Time")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Comment(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date and Time"(Control 17)".

    }
}
