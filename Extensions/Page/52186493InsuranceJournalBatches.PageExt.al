#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186493 pageextension52186493 extends "Insurance Journal Batches" 
{
    layout
    {
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("No. Series")
        {
            ApplicationArea = Basic;
        }
        modify("Posting No. Series")
        {
            ApplicationArea = Basic;
        }
        modify("Reason Code")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. Series"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting No. Series"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Reason Code"(Control 6)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Edit Journal")
        {
            ApplicationArea = Basic;
        }
        modify("Test Report")
        {
            ApplicationArea = Basic;
        }
        modify("P&ost")
        {
            ApplicationArea = Basic;
        }
        modify("Post and &Print")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Edit Journal"(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Test Report"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""P&ost"(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post and &Print"(Action 15)".

    }
}
