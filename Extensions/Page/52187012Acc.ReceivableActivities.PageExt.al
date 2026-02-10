#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187012 pageextension52187012 extends "Acc. Receivable Activities"
{
    layout
    {
        modify(Payments)
        {
            Caption = 'Receipts';

            //Unsupported feature: Property Modification (Name) on "Payments(Control 10)".

        }
        modify("Overdue Sales Documents")
        {
            ApplicationArea = Basic;
        }
        modify("Sales Return Orders - All")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""Sales Return Orders - All"(Control 4)".

        }
        modify("Customers - Blocked")
        {
            ApplicationArea = Basic;
        }
        modify("SOs Pending Approval")
        {
            ApplicationArea = Basic;
        }
        modify("Approved Sales Orders")
        {
            ApplicationArea = Basic;
        }
        // modify("My User Tasks")
        // {

        //     //Unsupported feature: Property Modification (Level) on ""My User Tasks"(Control 2)".


        //     //Unsupported feature: Property Modification (ControlType) on ""My User Tasks"(Control 2)".

        //     Caption = 'Approved Staff Claims';

        //     //Unsupported feature: Property Modification (Name) on ""My User Tasks"(Control 2)".


        //     //Unsupported feature: Property Insertion (SourceExpr) on ""My User Tasks"(Control 2)".

        //     ApplicationArea = Basic;
        // }
        // modify("UserTaskManagement.GetMyPendingUserTasksCount")
        // {
        //     Caption = 'Approved Imprest Surrender';
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (SourceExpr) on ""UserTaskManagement.GetMyPendingUserTasksCount"(Control 3)".


        //     //Unsupported feature: Property Modification (Name) on ""UserTaskManagement.GetMyPendingUserTasksCount"(Control 3)".

        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Overdue Sales Documents"(Control 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sales Return Orders - All"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Customers - Blocked"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""SOs Pending Approval"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Approved Sales Orders"(Control 12)".


        //Unsupported feature: Property Deletion (GroupType) on ""My User Tasks"(Control 2)".

        // modify("UserTaskManagement.GetMyPendingUserTasksCount")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""UserTaskManagement.GetMyPendingUserTasksCount"(Control 3)".


        //Unsupported feature: Property Deletion (Image) on ""UserTaskManagement.GetMyPendingUserTasksCount"(Control 3)".

        addafter("Customers - Blocked")
        {
            //     field("Pending Receipts"; Rec.Rec.Receipts)
            //     {
            //         ApplicationArea = Basic;
            //         Caption = 'Pending Receipts';
            //     }
            // field("Staff Advance Surrender"; Rec.Rec."Staff Advance Surrender")
            // {
            //     ApplicationArea = Basic;
            //     Caption = 'Approved Staff Advance Surrender';
            // }
        }
        // moveafter("Customers - Blocked"; "UserTaskManagement.GetMyPendingUserTasksCount")
    }
    actions
    {
        // modify("Payments(Control 10).""Edit Cash Receipt Journal""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Payments(Control 10).""New Sales Credit Memo""")
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "Payments(Control 10)."Edit Cash Receipt Journal"(Action 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Payments(Control 10)."New Sales Credit Memo"(Action 9)".

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

    SETFILTER("Overdue Date Filter",'<%1',WORKDATE);
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
