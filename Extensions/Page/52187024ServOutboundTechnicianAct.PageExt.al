#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187024 pageextension52187024 extends "Serv Outbound Technician Act." 
{
    layout
    {
        modify("Service Orders - Today")
        {
            ApplicationArea = Basic;
        }
        modify("Service Orders - to Follow-up")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Orders - Today"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Orders - to Follow-up"(Control 12)".

    //     modify("My User Tasks")
    //     {
    //         Visible = false;
    //     }
    //     modify("UserTaskManagement.GetMyPendingUserTasksCount")
    //     {
    //         Visible = false;
    //     }
     }
    actions
    {
        // modify("""Outbound Service Orders""(Control 9).""New Service Order""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("""Outbound Service Orders""(Control 9).""Service Item Worksheet""")
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Outbound Service Orders"(Control 9)."New Service Order"(Action 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Outbound Service Orders"(Control 9)."Service Item Worksheet"(Action 16)".

    }

    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        RESET;
        IF NOT GET THEN BEGIN
          INIT;
          INSERT;
        END;

        SetRespCenterFilter;
        SETRANGE("Date Filter",WORKDATE,WORKDATE);
        SETFILTER("User ID Filter",USERID);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..8
        */
    //end;

    //Unsupported feature: Property Deletion (RefreshOnActivate).
    
}
