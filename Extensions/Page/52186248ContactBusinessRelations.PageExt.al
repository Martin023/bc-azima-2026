#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186248 pageextension52186248 extends "Contact Business Relations" 
{
    layout
    {
        modify("Business Relation Code")
        {
            ApplicationArea = Basic;
        }
        modify("Business Relation Description")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Business Relation Code"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Business Relation Description"(Control 4)".

        modify("Contact Name")
        {
            Visible = false;
        }
        modify("Link to Table")
        {
            Visible = false;
        }
        modify("No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
}
