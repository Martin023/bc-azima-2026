#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185939 pageextension52185939 extends "VAT Report Setup" 
{
    layout
    {
        modify("Modify Submitted Reports")
        {
            ApplicationArea = Basic;
        }
        modify("EC Sales List No. Series")
        {

            //Unsupported feature: Property Modification (Name) on ""EC Sales List No. Series"(Control 7)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Modify Submitted Reports"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""EC Sales List No. Series"(Control 7)".

        modify("VAT Return No. Series")
        {
            Visible = false;
        }
        modify("VAT Return Period No. Series")
        {
            Visible = false;
        }
        modify("Return Period")
        {
            Visible = false;
        }
        modify("Report Version")
        {
            Visible = false;
        }
        modify("Period Reminder Calculation")
        {
            Visible = false;
        }
        modify(Control16)
        {
            Visible = false;
        }
        modify("Manual Receive Period CU ID")
        {
            Visible = false;
        }
        modify("Manual Receive Period CU Cap")
        {
            Visible = false;
        }
        modify("Receive Submitted Return CU ID")
        {
            Visible = false;
        }
        modify("Receive Submitted Return CUCap")
        {
            Visible = false;
        }
        modify("Auto Update Job")
        {
            Visible = false;
        }
        modify("Update Period Job Frequency")
        {
            Visible = false;
        }
        modify("Auto Receive Period CU ID")
        {
            Visible = false;
        }
        modify("Auto Receive Period CU Cap")
        {
            Visible = false;
        }
    }

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
