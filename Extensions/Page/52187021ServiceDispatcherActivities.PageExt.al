#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187021 pageextension52187021 extends "Service Dispatcher Activities" 
{
    layout
    {
        modify("Service Orders - in Process")
        {
            ApplicationArea = Basic;
        }
        modify("Service Orders - Finished")
        {
            ApplicationArea = Basic;
        }
        modify("Service Orders - Inactive")
        {
            ApplicationArea = Basic;
        }
        modify("Open Service Quotes")
        {
            ApplicationArea = Basic;
        }
        modify("Open Service Contract Quotes")
        {
            ApplicationArea = Basic;
        }
        modify("Service Contracts to Expire")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Orders - in Process"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Orders - Finished"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Orders - Inactive"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Open Service Quotes"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Open Service Contract Quotes"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Contracts to Expire"(Control 21)".

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
        // modify("""Service Orders""(Control 12).""New Service Order""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("""Service Orders""(Control 12).""New Service Item""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("""Service Orders""(Control 12).""Edit Dispatch Board""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("""Service Orders""(Control 12).""Edit Service Tasks""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("""Service Quotes""(Control 18).""New Service Quote""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("""Service Quotes""(Control 18).Action17")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("""Service Contracts""(Control 19).""New Service Contract Quote""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("""Service Contracts""(Control 19).""New Service Contract""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify(ActionContainer10)
        // {
        //     Visible = false;
        // }
        modify("Set Up Cues")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Orders"(Control 12)."New Service Order"(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Orders"(Control 12)."New Service Item"(Action 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Orders"(Control 12)."Edit Dispatch Board"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Orders"(Control 12)."Edit Service Tasks"(Action 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Quotes"(Control 18)."New Service Quote"(Action 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Quotes"(Control 18).Action17(Action 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Contracts"(Control 19)."New Service Contract Quote"(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Service Contracts"(Control 19)."New Service Contract"(Action 26)".

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
        SETRANGE("Date Filter",0D,WORKDATE);
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
