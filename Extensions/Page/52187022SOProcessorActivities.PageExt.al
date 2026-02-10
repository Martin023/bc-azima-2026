#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187022 pageextension52187022 extends "SO Processor Activities" 
{
    layout
    {
        modify("Sales Quotes - Open")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Orders - Open")
        {
            ApplicationArea = Basic;
        }
        modify(ReadyToShip)
        {
            ApplicationArea = Basic;
        }
        modify(PartiallyShipped)
        {
            ApplicationArea = Basic;
        }
        modify(DelayedOrders)
        {
            ApplicationArea = Basic;
        }
        modify("Average Days Delayed")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Return Orders - Open")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Credit Memos - Open")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Inv. - Pending Doc.Exch.")
        {
            ApplicationArea = Basic;
        }
        modify("Sales CrM. - Pending Doc.Exch.")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (Layout) on ""For Release"(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Quotes - Open"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Orders - Open"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ReadyToShip(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PartiallyShipped(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DelayedOrders(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Average Days Delayed"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Return Orders - Open"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Credit Memos - Open"(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Inv. - Pending Doc.Exch."(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales CrM. - Pending Doc.Exch."(Control 20)".

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
        modify("Set Up Cues")
        {
            ApplicationArea = Basic;
        }
        // modify("""For Release""(Control 1).""New Sales Quote""")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (Image) on ""For Release"(Control 1)."New Sales Quote"(Action 3)".

        // }
        // modify("""For Release""(Control 1).""New Sales Order""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("""Sales Orders Released Not Shipped""(Control 8).Navigate")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Returns(Control 18).""New Sales Return Order""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Returns(Control 18).""New Sales Credit Memo""")
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Set Up Cues"(Action 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""For Release"(Control 1)."New Sales Quote"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""For Release"(Control 1)."New Sales Order"(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Orders Released Not Shipped"(Control 8).Navigate(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Returns(Control 18)."New Sales Return Order"(Action 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Returns(Control 18)."New Sales Credit Memo"(Action 27)".

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
        SETRANGE("Date Filter",0D,WORKDATE - 1);
        SETFILTER("Date Filter2",'>=%1',WORKDATE);
        SETFILTER("User ID Filter",USERID);

        RoleCenterNotificationMgt.ShowNotifications;
        ConfPersonalizationMgt.RaiseOnOpenRoleCenterEvent;

        IF PageNotifier.IsAvailable THEN BEGIN
          PageNotifier := PageNotifier.Create;
          PageNotifier.NotifyPageReady;
        END;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        #1..9
        */
    //end;

    //Unsupported feature: Property Deletion (RefreshOnActivate).

}
