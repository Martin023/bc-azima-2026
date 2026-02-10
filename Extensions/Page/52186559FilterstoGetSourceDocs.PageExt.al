#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186559 pageextension52186559 extends "Filters to Get Source Docs." 
{
    layout
    {
        modify(ShowRequestForm)
        {
            ApplicationArea = Basic;
        }
        modify("Do Not Fill Qty. to Handle")
        {
            ApplicationArea = Basic;
        }
        modify("Code")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ShowRequestForm(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Do Not Fill Qty. to Handle"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 2)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Run)
        {
            ApplicationArea = Basic;
        }
        modify(Modify)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Run(Action 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Modify(Action 8)".

    }

    //Unsupported feature: Property Deletion (Attributes) on "SetOneCreatedShptHeader(PROCEDURE 1)".


    //Unsupported feature: Property Deletion (Attributes) on "SetOneCreatedReceiptHeader(PROCEDURE 2)".

}
