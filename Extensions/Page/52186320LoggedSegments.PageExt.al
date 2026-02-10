#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186320 pageextension52186320 extends "Logged Segments" 
{
    layout
    {
        modify(Canceled)
        {
            ApplicationArea = Basic;
        }
        modify("Entry No.")
        {
            ApplicationArea = Basic;
        }
        modify("Creation Date")
        {
            ApplicationArea = Basic;
        }
        modify("User ID")
        {
            ApplicationArea = Basic;
        }
        modify("Segment No.")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }
        modify("No. of Interactions")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Campaign Entries")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Canceled(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Entry No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Creation Date"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""User ID"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Segment No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Interactions"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Campaign Entries"(Control 10)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Interaction Log E&ntry")
        {
            ApplicationArea = Basic;
        }
        modify("&Campaign Entry")
        {
            ApplicationArea = Basic;
        }
        modify("Switch Check&mark in Canceled")
        {
            ApplicationArea = Basic;
        }
        modify(Resend)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Interaction Log E&ntry"(Action 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Campaign Entry"(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Switch Check&mark in Canceled"(Action 23)".


        //Unsupported feature: Code Modification on "Resend(Action 22).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            InteractLogEntry.SETRANGE("Logged Segment Entry No.","Entry No.");
            REPORT.RUN(REPORT::"Resend Attachments",TRUE,FALSE,InteractLogEntry);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            InteractLogEntry.SETRANGE("Logged Segment Entry No.","Entry No.");
            ResendAttachments.SETTABLEVIEW(InteractLogEntry);
            ResendAttachments.RUNMODAL;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Resend(Action 22)".

        modify("Delete Canceled Segments")
        {
            Visible = false;
        }
    }

    var
        ResendAttachments: Report "Resend Attachments";

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
