#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186656 pageextension52186656 extends "Service Document Registers" 
{
    layout
    {
        modify("Source Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Destination Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Destination Document No.")
        {
            ApplicationArea = Basic;
        }
        modify(CustNo)
        {
            ApplicationArea = Basic;
        }
        modify(CustName)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Source Document No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Destination Document Type"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Destination Document No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CustNo(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CustName(Control 19)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Card)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Card(Action 14)".

    }

    //Unsupported feature: Property Modification (Length) on "CustName(Variable 1004)".

    //var
        //>>>> ORIGINAL VALUE:
        //CustName : 100;
        //Variable type has not been exported.
        //>>>> MODIFIED VALUE:
        //CustName : 50;
        //Variable type has not been exported.
}
