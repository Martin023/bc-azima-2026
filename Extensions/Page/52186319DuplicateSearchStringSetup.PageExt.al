#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186319 pageextension52186319 extends "Duplicate Search String Setup"
{
    layout
    {
        modify("Part of Field")
        {
            ApplicationArea = Basic;
        }
        modify(Length)
        {
            ApplicationArea = Basic;
        }
        modify("Field Name")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Part of Field"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Length(Control 6)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        addfirst(Control1)
        {
            // field("Field";Field)
            // {
            //     ApplicationArea = Basic;
            // }
        }
    }

    //Unsupported feature: Property Deletion (DelayedInsert).

}
