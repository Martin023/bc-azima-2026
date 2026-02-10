#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185659 pageextension52185659 extends "Electronic Document Format" 
{
    Caption = 'Electronic Document Format';
    layout
    {
        modify(CodeFilter)
        {
            ApplicationArea = Basic;
        }
        modify(UsageFilter)
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
        modify(Usage)
        {
            ApplicationArea = Basic;
        }
        modify("Codeunit ID")
        {
            ApplicationArea = Basic;
        }
        modify("Codeunit Caption")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CodeFilter(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "UsageFilter(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Code(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Usage(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Codeunit ID"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Codeunit Caption"(Control 7)".

        modify("Delivery Codeunit ID")
        {
            Visible = false;
        }
        modify("Delivery Codeunit Caption")
        {
            Visible = false;
        }
    }

    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ElectronicDocumentFormat.INIT;
        ElectronicDocumentFormat.OnDiscoverElectronicFormat;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ElectronicDocumentFormat.INIT;
        */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
