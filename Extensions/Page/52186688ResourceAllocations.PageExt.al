#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186688 pageextension52186688 extends "Resource Allocations" 
{
    layout
    {
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("Service Item No.")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item Serial No.")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item Line No.")
        {
            ApplicationArea = Basic;
        }
        modify("Service Item Description")
        {
            ApplicationArea = Basic;
        }
        modify("Resource No.")
        {
            ApplicationArea = Basic;
        }
        modify("Resource Group No.")
        {
            ApplicationArea = Basic;
        }
        modify("Allocation Date")
        {
            ApplicationArea = Basic;
        }
        modify("Allocated Hours")
        {
            ApplicationArea = Basic;
        }
        modify("Starting Time")
        {
            ApplicationArea = Basic;
        }
        modify("Finishing Time")
        {
            ApplicationArea = Basic;
        }
        modify(Description)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item No."(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item Serial No."(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item Line No."(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Item Description"(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Resource Group No."(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allocation Date"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allocated Hours"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Starting Time"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Finishing Time"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Description(Control 25)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(ResourceAvailability)
        {
            ApplicationArea = Basic;
        }
        modify(ResGroupAvailability)
        {
            ApplicationArea = Basic;
        }
        modify("Canceled Allocation &Entries")
        {
            ApplicationArea = Basic;
        }
        modify("&Cancel Allocation")
        {
            ApplicationArea = Basic;
        }
        modify("Allocate to &all Service Items")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "ResourceAvailability(Action 3)".


        //Unsupported feature: Code Modification on "ResGroupAvailability(Action 31).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            CLEAR(ResGrAvailability);
            ResGrAvailability.SetData("Document Type","Document No.","Entry No.");
            IF "Resource Group No." <> '' THEN BEGIN
              ResGr.GET("Resource Group No.");
              ResGrAvailability.SETRECORD(ResGr);
            END;
            ResGrAvailability.RUNMODAL;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            CLEAR(ResGrAvailability);
            ResGrAvailability.SetData("Document Type","Document No.","Service Item Line No.","Entry No.");
            #3..7
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "ResGroupAvailability(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Canceled Allocation &Entries"(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Cancel Allocation"(Action 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Allocate to &all Service Items"(Action 41)".

    }
}
