#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186719 pageextension52186719 extends "Service Contract Template List" 
{
    Caption = 'Service Contract Template List';
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify(Prepaid)
        {
            ApplicationArea = Basic;
        }
        modify("Serv. Contract Acc. Gr. Code")
        {
            ApplicationArea = Basic;
        }
        modify("Invoice Period")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Prepaid(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Serv. Contract Acc. Gr. Code"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invoice Period"(Control 8)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify("Service Dis&counts")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Dis&counts"(Action 20)".

        addafter(Dimensions)
        {
            separator(Action19)
            {
            }
        }
    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
