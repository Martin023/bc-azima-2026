#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187019 pageextension52187019 extends "WMS Ship & Receive Activities" 
{
    layout
    {
        modify("Released Sales Orders - Today")
        {
            ApplicationArea = Basic;
        }
        modify("Shipments - Today")
        {
            ApplicationArea = Basic;
        }
        modify("Picked Shipments - Today")
        {
            ApplicationArea = Basic;
        }
        modify("Posted Shipments - Today")
        {
            ApplicationArea = Basic;
        }
        modify("Expected Purchase Orders")
        {
            ApplicationArea = Basic;
        }
        modify(Arrivals)
        {
            ApplicationArea = Basic;
        }
        modify("Posted Receipts - Today")
        {
            ApplicationArea = Basic;
        }
        modify("Picks - All")
        {
            ApplicationArea = Basic;
        }
        modify("Put-aways - All")
        {
            ApplicationArea = Basic;
        }
        modify("Movements - All")
        {
            ApplicationArea = Basic;
        }
        modify("Registered Picks - Today")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Released Sales Orders - Today"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipments - Today"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Picked Shipments - Today"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Shipments - Today"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expected Purchase Orders"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Arrivals(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Receipts - Today"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Picks - All"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Put-aways - All"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Movements - All"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Registered Picks - Today"(Control 23)".

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
        // modify("""Outbound - Today""(Control 3).""New Warehouse Shipment""")
        // {
        //     Caption = 'New Whse. Shipment';
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (Name) on ""Outbound - Today"(Control 3)."New Warehouse Shipment"(Action 7)".

        // }
        // modify("""Outbound - Today""(Control 3).""New Transfer Order""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("""Inbound - Today""(Control 20).""New Purchase Order""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("""Inbound - Today""(Control 20).""New Whse. Receipt""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Internal(Control 21).""Edit Put-away Worksheet""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Internal(Control 21).""Edit Pick Worksheet""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Internal(Control 21).""Edit Movement Worksheet""")
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Outbound - Today"(Control 3)."New Warehouse Shipment"(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Outbound - Today"(Control 3)."New Transfer Order"(Action 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inbound - Today"(Control 20)."New Purchase Order"(Action 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inbound - Today"(Control 20)."New Whse. Receipt"(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Internal(Control 21)."Edit Put-away Worksheet"(Action 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Internal(Control 21)."Edit Pick Worksheet"(Action 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Internal(Control 21)."Edit Movement Worksheet"(Action 33)".

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

        SETRANGE("Date Filter",0D,WORKDATE);
        SETRANGE("Date Filter2",WORKDATE,WORKDATE);
        SETFILTER("User ID Filter",USERID);

        LocationCode := GetEmployeeLocation(USERID);
        SETFILTER("Location Filter",LocationCode);
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..8
        #10..12
        */
    //end;

    //Unsupported feature: Property Deletion (RefreshOnActivate).

}
