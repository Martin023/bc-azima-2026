#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185907 pageextension52185907 extends "Approval Comments" 
{

    //Unsupported feature: Property Modification (DataCaptionFields) on ""Approval Comments"(Page 660)".

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
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Comment(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date and Time"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 2)".

    }
}
