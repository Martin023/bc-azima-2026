#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187011 pageextension52187011 extends "Acc. Payables Activities"
{
    layout
    {
        modify("Purchase Documents Due Today")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Purchase Documents Due Today"(Control 9)".


            //Unsupported feature: Property Modification (Name) on ""Purchase Documents Due Today"(Control 9)".

        }
        modify("Vendors - Payment on Hold")
        {
            ApplicationArea = Basic;
        }
        modify("Purchase Return Orders")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""Purchase Return Orders"(Control 4)".

        }
        modify("POs Pending Approval")
        {
            ApplicationArea = Basic;
        }
        modify("Approved Purchase Orders")
        {
            ApplicationArea = Basic;
        }
        // modify("My User Tasks")
        // {

        //     //Unsupported feature: Property Modification (Level) on ""My User Tasks"(Control 3)".


        //     //Unsupported feature: Property Modification (ControlType) on ""My User Tasks"(Control 3)".

        //     Caption = 'Payment Vouchers';

        //     //Unsupported feature: Property Modification (Name) on ""My User Tasks"(Control 3)".


        //     //Unsupported feature: Property Insertion (SourceExpr) on ""My User Tasks"(Control 3)".

        //     ApplicationArea = Basic;
        // }
        // modify("UserTaskManagement.GetMyPendingUserTasksCount")
        // {
        //     Caption = 'Petty Cash';
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (SourceExpr) on ""UserTaskManagement.GetMyPendingUserTasksCount"(Control 2)".


        //     //Unsupported feature: Property Modification (Name) on ""UserTaskManagement.GetMyPendingUserTasksCount"(Control 2)".

        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Documents Due Today"(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendors - Payment on Hold"(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Return Orders"(Control 4)".

        modify("Outstanding Vendor Invoices")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""POs Pending Approval"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Approved Purchase Orders"(Control 13)".


        //Unsupported feature: Property Deletion (GroupType) on ""My User Tasks"(Control 3)".

        // modify("UserTaskManagement.GetMyPendingUserTasksCount")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""UserTaskManagement.GetMyPendingUserTasksCount"(Control 2)".


        //Unsupported feature: Property Deletion (Image) on ""UserTaskManagement.GetMyPendingUserTasksCount"(Control 2)".

        addafter("Approved Purchase Orders")
        {
            field("Staff Advance"; Rec."Staff Advance")
            {
                ApplicationArea = Basic;
                Caption = 'Approved Staff Advance';
            }
            field("Staff Claims"; Rec."Staff Claims")
            {
                ApplicationArea = Basic;
                Caption = 'Approved Staff Claims';
            }
        }
        // moveafter("Purchase Return Orders"; "My User Tasks")
    }
    // actions
    // {
    //     modify("Payments(Control 6).""Edit Payment Journal""")
    //     {
    //         ApplicationArea = Basic;
    //     }
    //     modify("Payments(Control 6).""New Purchase Credit Memo""")
    //     {
    //         ApplicationArea = Basic;
    //     }
    //     modify("Payments(Control 6).""Edit Purchase Journal""")
    //     {
    //         ApplicationArea = Basic;
    //     }

    //     //Unsupported feature: Property Deletion (ToolTipML) on "Payments(Control 6)."Edit Payment Journal"(Action 8)".


    //     //Unsupported feature: Property Deletion (ToolTipML) on "Payments(Control 6)."New Purchase Credit Memo"(Action 11)".


    //     //Unsupported feature: Property Deletion (ToolTipML) on "Payments(Control 6)."Edit Purchase Journal"(Action 12)".

    // }


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

    SETFILTER("Due Date Filter",'<=%1',WORKDATE);
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
