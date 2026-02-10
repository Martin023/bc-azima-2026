#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187015 pageextension52187015 extends "Shop Supervisor Activities" 
{
    layout
    {
        modify("Planned Prod. Orders - All")
        {
            ApplicationArea = Basic;
        }
        modify("Firm Plan. Prod. Orders - All")
        {
            ApplicationArea = Basic;
        }
        modify("Released Prod. Orders - All")
        {
            ApplicationArea = Basic;
        }
        modify("Prod. Orders Routings-in Queue")
        {
            ApplicationArea = Basic;
        }
        modify("Prod. Orders Routings-in Prog.")
        {
            ApplicationArea = Basic;
        }
        modify("Invt. Picks to Production")
        {
            ApplicationArea = Basic;
        }
        modify("Invt. Put-aways from Prod.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Planned Prod. Orders - All"(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Firm Plan. Prod. Orders - All"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Released Prod. Orders - All"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prod. Orders Routings-in Queue"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prod. Orders Routings-in Prog."(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invt. Picks to Production"(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invt. Put-aways from Prod."(Control 17)".

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
        // modify("""Production Orders""(Control 8).""Change Production Order Status""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("""Production Orders""(Control 8).""Update Unit Cost""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("""Production Orders""(Control 8).Navigate")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Operations(Control 9).""Consumption Journal""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Operations(Control 9).""Output Journal""")
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Production Orders"(Control 8)."Change Production Order Status"(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Production Orders"(Control 8)."Update Unit Cost"(Action 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Production Orders"(Control 8).Navigate(Action 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Operations(Control 9)."Consumption Journal"(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Operations(Control 9)."Output Journal"(Action 20)".

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
        SETFILTER("User ID Filter",USERID);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..5
        */
    //end;

    //Unsupported feature: Property Deletion (RefreshOnActivate).

}
