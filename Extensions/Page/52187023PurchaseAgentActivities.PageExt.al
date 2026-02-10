#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187023 pageextension52187023 extends "Purchase Agent Activities" 
{
    layout
    {
        modify("To Send or Confirm")
        {
            ApplicationArea = Basic;
        }
        modify("Upcoming Orders")
        {
            ApplicationArea = Basic;
        }
        modify(OutstandingOrders)
        {
            ApplicationArea = Basic;
        }
        modify("Purchase Return Orders - All")
        {
            ApplicationArea = Basic;
        }
        modify(NotInvoiced)
        {
            Caption = 'Not Invoiced';
            ApplicationArea = Basic;
        }
        modify(PartiallyInvoiced)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""To Send or Confirm"(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Upcoming Orders"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "OutstandingOrders(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Return Orders - All"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "NotInvoiced(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PartiallyInvoiced(Control 21)".

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
        // modify("""Pre-arrival Follow-up on Purchase Orders""(Control 9).""New Purchase Quote""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("""Pre-arrival Follow-up on Purchase Orders""(Control 9).""New Purchase Order""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("""Pre-arrival Follow-up on Purchase Orders""(Control 9).""Edit Purchase Journal""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("""Post Arrival Follow-up""(Control 10).Navigate")
        // {
        //     ApplicationArea = Basic;
        // // }
        // modify("""Post Arrival Follow-up""(Control 10).""New Purchase Return Order""")
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Pre-arrival Follow-up on Purchase Orders"(Control 9)."New Purchase Quote"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pre-arrival Follow-up on Purchase Orders"(Control 9)."New Purchase Order"(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pre-arrival Follow-up on Purchase Orders"(Control 9)."Edit Purchase Journal"(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post Arrival Follow-up"(Control 10).Navigate(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post Arrival Follow-up"(Control 10)."New Purchase Return Order"(Action 17)".

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
        SETFILTER("Date Filter",'>=%1',WORKDATE);
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
