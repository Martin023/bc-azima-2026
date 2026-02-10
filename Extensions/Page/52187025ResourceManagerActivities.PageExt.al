#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187025 pageextension52187025 extends "Resource Manager Activities" 
{
    layout
    {
        modify("Available Resources")
        {
            ApplicationArea = Basic;
        }
        modify("Jobs w/o Resource")
        {
            ApplicationArea = Basic;
        }
        modify("Unassigned Resource Groups")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Available Resources"(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Jobs w/o Resource"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Unassigned Resource Groups"(Control 7)".

        // modify("My User Tasks")
        // {
        //     Visible = false;
        // }
        // modify("UserTaskManagement.GetMyPendingUserTasksCount")
        // {
        //     Visible = false;
        // }
    }
    actions
    {
        // modify("Allocation(Control 4).""Resource Capacity""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Allocation(Control 4).""Resource Group Capacity""")
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "Allocation(Control 4)."Resource Capacity"(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Allocation(Control 4)."Resource Group Capacity"(Action 10)".

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

        SETRANGE("Date Filter",WORKDATE,WORKDATE);
        SETFILTER("User ID Filter",USERID);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..7
        */
    //end;

    //Unsupported feature: Property Deletion (RefreshOnActivate).

}
