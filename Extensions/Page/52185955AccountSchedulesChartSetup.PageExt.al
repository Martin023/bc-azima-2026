#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185955 pageextension52185955 extends "Account Schedules Chart Setup" 
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
        modify("Account Schedule Name")
        {
            ApplicationArea = Basic;
        }
        modify("Column Layout Name")
        {
            ApplicationArea = Basic;
        }
        modify("Base X-Axis on")
        {
            ApplicationArea = Basic;
        }
        modify("Start Date")
        {
            ApplicationArea = Basic;
        }
        modify("End Date")
        {
            ApplicationArea = Basic;
        }
        modify("Period Length")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Periods")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Account Schedule Name"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Column Layout Name"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Base X-Axis on"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Start Date"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""End Date"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Period Length"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Periods"(Control 5)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "SetupYAxis(Control 9)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "SetupXAxis(Control 6)".

    }

    //Unsupported feature: Code Modification on "OnNewRecord".

    //trigger OnNewRecord(BelowxRec: Boolean)
    //>>>> ORIGINAL CODE:
    //begin
        /*
        "Start Date" := WORKDATE;
        "User ID" := USERID;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        "Start Date" := WORKDATE;
        */
    //end;
}
