#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187010 pageextension52187010 extends "Account Manager Activities" 
{
    layout
    {
        modify("Overdue Sales Documents")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Overdue Sales Documents"(Control 7)".


            //Unsupported feature: Property Modification (Name) on ""Overdue Sales Documents"(Control 7)".

            Caption = 'Approved Payment Vouchers';
        }
        modify("Purchase Documents Due Today")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Purchase Documents Due Today"(Control 9)".


            //Unsupported feature: Property Modification (Name) on ""Purchase Documents Due Today"(Control 9)".

        }
        modify("Document Approvals")
        {
            Caption = 'Pending Retirements';

            //Unsupported feature: Property Modification (Name) on ""Document Approvals"(Control 19)".

        }
        modify("Cash Management")
        {

            //Unsupported feature: Property Modification (Level) on ""Cash Management"(Control 14)".


            //Unsupported feature: Property Modification (ControlType) on ""Cash Management"(Control 14)".

            Caption = 'Approved Staff Advance';

            //Unsupported feature: Property Modification (Name) on ""Cash Management"(Control 14)".


            //Unsupported feature: Property Insertion (SourceExpr) on ""Cash Management"(Control 14)".

            // ApplicationArea = Basic;
        }
        modify("Non-Applied Payments")
        {
            Caption = 'Approved Petty Cash Vouchers';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""Non-Applied Payments"(Control 11)".


            //Unsupported feature: Property Modification (Name) on ""Non-Applied Payments"(Control 11)".

        }
        modify("Incoming Documents")
        {
            Caption = 'My Documents';

            //Unsupported feature: Property Modification (Name) on ""Incoming Documents"(Control 2)".

        }
        modify("New Incoming Documents")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""New Incoming Documents"(Control 8)".

        }
        modify("Approved Incoming Documents")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""Approved Incoming Documents"(Control 10)".

        }
        modify("OCR Completed")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""OCR Completed"(Control 13)".

        }
        // modify("My User Tasks")
        // {

        //     //Unsupported feature: Property Modification (Level) on ""My User Tasks"(Control 17)".


        //     //Unsupported feature: Property Modification (ControlType) on ""My User Tasks"(Control 17)".

        //     Caption = 'Approved Travel Surrender';

        //     //Unsupported feature: Property Modification (Name) on ""My User Tasks"(Control 17)".


        //     //Unsupported feature: Property Insertion (SourceExpr) on ""My User Tasks"(Control 17)".

        //     ApplicationArea = Basic;
        // }
        // modify("UserTaskManagement.GetMyPendingUserTasksCount")
        // {
        //     Caption = 'Approved Staff Advance Surrender';
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (SourceExpr) on ""UserTaskManagement.GetMyPendingUserTasksCount"(Control 16)".


        //     //Unsupported feature: Property Modification (Name) on ""UserTaskManagement.GetMyPendingUserTasksCount"(Control 16)".

        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Overdue Sales Documents"(Control 7)".


        //Unsupported feature: Property Deletion (DrillDownPageID) on ""Overdue Sales Documents"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchase Documents Due Today"(Control 9)".

        modify("POs Pending Approval")
        {
            Visible = false;
        }
        modify("SOs Pending Approval")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (GroupType) on ""Cash Management"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Non-Applied Payments"(Control 11)".


        //Unsupported feature: Property Deletion (DrillDownPageID) on ""Non-Applied Payments"(Control 11)".


        //Unsupported feature: Property Deletion (Image) on ""Non-Applied Payments"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""New Incoming Documents"(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Approved Incoming Documents"(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""OCR Completed"(Control 13)".


        //Unsupported feature: Property Deletion (GroupType) on ""My User Tasks"(Control 17)".

        // modify("UserTaskManagement.GetMyPendingUserTasksCount")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""UserTaskManagement.GetMyPendingUserTasksCount"(Control 16)".


        //Unsupported feature: Property Deletion (Image) on ""UserTaskManagement.GetMyPendingUserTasksCount"(Control 16)".

        addfirst("Cash Management")
        {
            field("Staff Claims"; Rec."Staff Claims")
            {
                ApplicationArea = Basic;
                Caption = 'Approved Staff Claims';
            }
        }
        addafter("OCR Completed")
        {
            field("My Staff Advance";Rec."My Staff Advance")
            {
                ApplicationArea = Basic;
                Caption = 'My Approved Staff Advance';
            }
            field("My Staff Claims";Rec."My Staff Claims")
            {
                ApplicationArea = Basic;
                Caption = 'My Approved Staff Claims';
            }
        }       
        moveafter(Payments;"Purchase Documents Due Today")
        // moveafter("Payment Vouchers";"Non-Applied Payments")
        // moveafter("Petty Cash Vouchers";"Cash Management");
        // moveafter("Pending Retirements";"UserTaskManagement.GetMyPendingUserTasksCount");
        // moveafter("Staff Advance Surrender";"My User Tasks");
    }
    actions
    {
        // modify("Payments(Control 6).""Edit Cash Receipt Journal""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Payments(Control 6).""New Sales Credit Memo""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Payments(Control 6).""Edit Payment Journal""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("Payments(Control 6).""New Purchase Credit Memo""")
        // {
        //     ApplicationArea = Basic;
        // }
        // modify("""Document Approvals""(Control 19).""Create Reminders...""")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Insertion (Level) on ""Document Approvals"(Control 19)."Create Reminders..."(Action 25)".

        // }
        // modify("""Document Approvals""(Control 19).""Create Finance Charge Memos...""")
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Insertion (Level) on ""Document Approvals"(Control 19)."Create Finance Charge Memos..."(Action 26)".

        // }
        // modify("""Incoming Documents""(Control 2).CheckForOCR")
        // {
        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on "Payments(Control 6)."Edit Cash Receipt Journal"(Action 1)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Payments(Control 6)."New Sales Credit Memo"(Action 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Payments(Control 6)."Edit Payment Journal"(Action 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Payments(Control 6)."New Purchase Credit Memo"(Action 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Approvals"(Control 19)."Create Reminders..."(Action 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Approvals"(Control 19)."Create Finance Charge Memos..."(Action 26)".

        // modify("""Cash Management""(Control 14).""New Payment Reconciliation Journal""")
        // {
        //     Visible = false;
        // }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Incoming Documents"(Control 2).CheckForOCR(Action 12)".


        //Unsupported feature: Property Deletion (Visible) on ""Incoming Documents"(Control 2).CheckForOCR(Action 12)".

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

        SETFILTER("Due Date Filter",'<=%1',WORKDATE);
        SETFILTER("Overdue Date Filter",'<%1',WORKDATE);
        SETFILTER("User ID Filter",USERID);
        ShowCheckForOCR := OCRServiceMgt.OcrServiceIsEnable;
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
