#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186366 pageextension52186366 extends "Alternative Address Card" 
{
    layout
    {
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(Address)
        {
            ApplicationArea = Basic;
        }
        modify("Address 2")
        {
            ApplicationArea = Basic;
        }
        modify("Post Code")
        {
            ApplicationArea = Basic;
        }
        modify(City)
        {
            ApplicationArea = Basic;
        }
        modify("Phone No.")
        {
            ApplicationArea = Basic;
        }
        modify("Phone No.2")
        {
            ApplicationArea = Basic;
        }
        modify("Fax No.")
        {
            ApplicationArea = Basic;
        }
        modify("E-Mail")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Address(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Address 2"(Control 8)".

        modify(Control5)
        {
            Visible = false;
        }
        modify(County)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Post Code"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "City(Control 17)".

        modify("Country/Region Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Phone No."(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Phone No.2"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Fax No."(Control 25)".


        //Unsupported feature: Property Deletion (ExtendedDatatype) on ""E-Mail"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""E-Mail"(Control 27)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 22)".

    }
}
