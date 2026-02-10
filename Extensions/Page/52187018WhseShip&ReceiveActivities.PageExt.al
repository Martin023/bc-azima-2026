#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187018 pageextension52187018 extends "Whse Ship & Receive Activities" 
{
    layout
    {
        modify("Rlsd. Sales Orders Until Today")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Rlsd. Sales Orders Until Today"(Control 5)".


            //Unsupported feature: Property Modification (Name) on ""Rlsd. Sales Orders Until Today"(Control 5)".

        }
        modify("Posted Sales Shipments - Today")
        {
            ApplicationArea = Basic;
        }
        modify("Exp. Purch. Orders Until Today")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Exp. Purch. Orders Until Today"(Control 12)".


            //Unsupported feature: Property Modification (Name) on ""Exp. Purch. Orders Until Today"(Control 12)".

        }
        modify("Posted Purch. Receipts - Today")
        {
            ApplicationArea = Basic;
        }
        modify("Invt. Picks Until Today")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Invt. Picks Until Today"(Control 19)".


            //Unsupported feature: Property Modification (Name) on ""Invt. Picks Until Today"(Control 19)".

        }
        modify("Invt. Put-aways Until Today")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Invt. Put-aways Until Today"(Control 17)".


            //Unsupported feature: Property Modification (Name) on ""Invt. Put-aways Until Today"(Control 17)".

        }

        //Unsupported feature: Property Deletion (CaptionML) on ""Rlsd. Sales Orders Until Today"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Rlsd. Sales Orders Until Today"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Sales Shipments - Today"(Control 3)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Exp. Purch. Orders Until Today"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Exp. Purch. Orders Until Today"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posted Purch. Receipts - Today"(Control 10)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Invt. Picks Until Today"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invt. Picks Until Today"(Control 19)".


        //Unsupported feature: Property Deletion (CaptionML) on ""Invt. Put-aways Until Today"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invt. Put-aways Until Today"(Control 17)".

        modify("Open Phys. Invt. Orders")
        {
            Visible = false;
        }
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
       // modify("""Outbound - Today""(Control 1).""New Transfer Order""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("""Inbound - Today""(Control 7).""New Purchase Order""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Internal(Control 15).""New Inventory Pick""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Internal(Control 15).""New Inventory Put-away""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Internal(Control 15).""Edit Item Reclassification Journal""")
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Outbound - Today"(Control 1)."New Transfer Order"(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Inbound - Today"(Control 7)."New Purchase Order"(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Internal(Control 15)."New Inventory Pick"(Action 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Internal(Control 15)."New Inventory Put-away"(Action 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Internal(Control 15)."Edit Item Reclassification Journal"(Action 23)".

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

        LocationCode := WhseWMSCue.GetEmployeeLocation(USERID);
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
