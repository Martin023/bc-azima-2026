#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185921 pageextension52185921 extends "Report Inbox"
{
    layout
    {

        modify("User ID")
        {
            ApplicationArea = Basic;
        }
        modify("Created Date-Time")
        {
            ApplicationArea = Basic;
        }
        modify("Report ID")
        {
            ApplicationArea = Basic;
        }


        modify("Report Name")
        {
            Visible = true;
        }
        // addafter("Report Name")
        // {
        //     field(Description; Rec.Description)
        //     { }
        // }
        addafter("Report Name")
        {
            field("Report Output"; Rec."Report Output")
            { }
        }
        addafter("Report Name")
        {
            field("Output Type"; Rec."Output Type")
            { }
        }


        //Unsupported feature: Property Deletion (ToolTipML) on ""Report Name"(Control 6)".

    }


    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
