#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187152 pageextension52187152 extends "Service Contract Quotes" 
{
    layout
    {
        modify("Contract No.")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Code")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Name")
        {
            ApplicationArea = Basic;
        }
        modify("Starting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Expiration Date")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Contract No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customer No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Code"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Name"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Date"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expiration Date"(Control 12)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1902018507(Control 1902018507)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900316107(Control 1900316107)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify("Service Dis&counts")
        {
            ApplicationArea = Basic;
        }
        modify("Service &Hours")
        {
            ApplicationArea = Basic;
        }
        modify("&Filed Contract Quotes")
        {
            ApplicationArea = Basic;
        }
        modify("&Make Contract")
        {
            ApplicationArea = Basic;
        }
        modify("&Print")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1102601020)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 1102601021)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Dis&counts"(Action 1102601022)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service &Hours"(Action 1102601023)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Filed Contract Quotes"(Action 1102601025)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Make Contract"(Action 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Print"(Action 51)".

        addafter("Service &Hours")
        {
            separator(Action1102601024)
            {
            }
        }
    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
