#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187017 pageextension52187017 extends "Machine Operator Activities" 
{
    layout
    {
        modify("Released Prod. Orders - All")
        {
            ApplicationArea = Basic;
        }
        modify("Rlsd. Prod. Orders Until Today")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Rlsd. Prod. Orders Until Today"(Control 1)".


            //Unsupported feature: Property Modification (Name) on ""Rlsd. Prod. Orders Until Today"(Control 1)".

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

        //Unsupported feature: Property Deletion (ToolTipML) on ""Released Prod. Orders - All"(Control 6)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Rlsd. Prod. Orders Until Today"(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Rlsd. Prod. Orders Until Today"(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prod. Orders Routings-in Queue"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prod. Orders Routings-in Prog."(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invt. Picks to Production"(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invt. Put-aways from Prod."(Control 20)".

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
        // modify("""Production Orders""(Control 4).""Consumption Journal""")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Insertion (Level) on ""Production Orders"(Control 4)."Consumption Journal"(Action 10)".

        // }
        // modify("""Production Orders""(Control 4).""Output Journal""")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Insertion (Level) on ""Production Orders"(Control 4)."Output Journal"(Action 11)".

        // }
        // modify("Operations(Control 5).""Register Absence - Machine Center""")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Insertion (Level) on "Operations(Control 5)."Register Absence - Machine Center"(Action 16)".

        // }
        // modify("Operations(Control 5).""Register Absence - Work Center""")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Insertion (Level) on "Operations(Control 5)."Register Absence - Work Center"(Action 17)".

        // }
        // modify("Operations(Control 5).""Prod. Order - Job Card""")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Insertion (Level) on "Operations(Control 5)."Prod. Order - Job Card"(Action 25)".

        // }
        // modify("""Warehouse Documents""(Control 8).""New Inventory Pick""")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Insertion (Level) on ""Warehouse Documents"(Control 8)."New Inventory Pick"(Action 23)".

        // }
        // modify("""Warehouse Documents""(Control 8).""New Inventory Put-away""")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Insertion (Level) on ""Warehouse Documents"(Control 8)."New Inventory Put-away"(Action 24)".

        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Production Orders"(Control 4)."Consumption Journal"(Action 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Production Orders"(Control 4)."Output Journal"(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Operations(Control 5)."Register Absence - Machine Center"(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Operations(Control 5)."Register Absence - Work Center"(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Operations(Control 5)."Prod. Order - Job Card"(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warehouse Documents"(Control 8)."New Inventory Pick"(Action 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warehouse Documents"(Control 8)."New Inventory Put-away"(Action 24)".

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

        SETFILTER("Date Filter",'<=%1',WORKDATE);
        SETFILTER("User ID Filter",USERID);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..6
        SETFILTER("Date Filter",'<=%1',WORKDATE)
        */
    //end;

    //Unsupported feature: Property Deletion (RefreshOnActivate).

}
