#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187016 pageextension52187016 extends "Shop Super. basic Activities"
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


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prod. Orders Routings-in Queue"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Prod. Orders Routings-in Prog."(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invt. Picks to Production"(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Invt. Put-aways from Prod."(Control 22)".

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
        //         modify("""Production Orders""(Control 11).""New Production Order""")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("""Production Orders""(Control 11).""View Production Order - Shortage List""")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("""Production Orders""(Control 11).""Change Production Order Status""")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Operations(Control 12).""Edit Order Planning""")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Operations(Control 12).""Edit Consumption Journal""")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Operations(Control 12).""Edit Output Journal""")
        //         {
        //             ApplicationArea = Basic;
        //         }

        //         //Unsupported feature: Property Deletion (ToolTipML) on ""Production Orders"(Control 11)."New Production Order"(Action 9)".


        //         //Unsupported feature: Property Deletion (ToolTipML) on ""Production Orders"(Control 11)."View Production Order - Shortage List"(Action 8)".


        //         //Unsupported feature: Property Deletion (ToolTipML) on ""Production Orders"(Control 11)."Change Production Order Status"(Action 10)".


        //         //Unsupported feature: Property Deletion (ToolTipML) on "Operations(Control 12)."Edit Order Planning"(Action 18)".


        //         //Unsupported feature: Property Deletion (ToolTipML) on "Operations(Control 12)."Edit Consumption Journal"(Action 19)".


        //         //Unsupported feature: Property Deletion (ToolTipML) on "Operations(Control 12)."Edit Output Journal"(Action 20)".

        //     }

        //     //Unsupported feature: Code Modification on "OnOpenPage".

        //     //trigger OnOpenPage()
        //     //>>>> ORIGINAL CODE:
        //     //begin
        //         /*
        //         RESET;
        //         IF NOT GET THEN BEGIN
        //           INIT;
        //           INSERT;
        //         END;
        //         SETFILTER("User ID Filter",USERID);
        //         */
        //     //end;
        //     //>>>> MODIFIED CODE:
        //     //begin
        //         /*
        //         #1..5
        //         */
        //     //end;

        //     //Unsupported feature: Property Deletion (RefreshOnActivate).

    }
}