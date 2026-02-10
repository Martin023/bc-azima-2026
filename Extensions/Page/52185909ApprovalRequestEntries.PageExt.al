#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185909 pageextension52185909 extends "Approval Request Entries" 
{
    layout
    {
        modify(Overdue)
        {
            ToolTip = 'Overdue Entry';
            ApplicationArea = Basic;
        }
        modify("Table ID")
        {
            ApplicationArea = Basic;
        }
        modify("Document Type")
        {
            ApplicationArea = Basic;
        }
        modify("Document No.")
        {
            ApplicationArea = Basic;
        }
        modify(RecordIDText)
        {
            ApplicationArea = Basic;
        }
        modify("Sequence No.")
        {
            ApplicationArea = Basic;
        }
        modify("Sender ID")
        {
            ApplicationArea = Basic;
        }
        modify("Salespers./Purch. Code")
        {
            ApplicationArea = Basic;
        }
        modify("Approver ID")
        {
            ApplicationArea = Basic;
        }
        modify(Status)
        {
            ApplicationArea = Basic;
        }
        modify("Date-Time Sent for Approval")
        {
            ApplicationArea = Basic;
        }
        modify("Last Date-Time Modified")
        {
            ApplicationArea = Basic;
        }
        modify("Last Modified By User ID")
        {
            ApplicationArea = Basic;
        }
        modify(Comment)
        {
            ApplicationArea = Basic;
        }
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }
        modify("Available Credit Limit (LCY)")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Table ID"(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Type"(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document No."(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RecordIDText(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sequence No."(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sender ID"(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salespers./Purch. Code"(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Approver ID"(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date-Time Sent for Approval"(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Date-Time Modified"(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Last Modified By User ID"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Comment(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Available Credit Limit (LCY)"(Control 24)".

        modify(Amount)
        {
            Visible = false;
        }
        modify("Amount (LCY)")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify("Record")
        {
            ApplicationArea = Basic;
        }
        modify(Comments)
        {
            ApplicationArea = Basic;
        }
        modify("O&verdue Entries")
        {
            ApplicationArea = Basic;
        }
        modify("All Entries")
        {
            ApplicationArea = Basic;
        }
        modify("&Delegate")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Record(Action 35)".


        //Unsupported feature: Property Deletion (Enabled) on "Record(Action 35)".


        //Unsupported feature: Code Insertion (VariableCollection) on "Comments(Action 36).OnAction".

        //trigger (Variable: ApprovalCommentLine)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on "Comments(Action 36).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
            /*
            RecRef.GET("Record ID to Approve");
            CLEAR(ApprovalsMgmt);
            ApprovalsMgmt.GetApprovalCommentForWorkflowStepInstanceID(RecRef,"Workflow Step Instance ID");
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ApprovalCommentLine.SETRANGE("Table ID","Table ID");
            ApprovalCommentLine.SETRANGE("Record ID to Approve","Record ID to Approve");
            PAGE.RUN(PAGE::"Approval Comments",ApprovalCommentLine);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Comments(Action 36)".


        //Unsupported feature: Property Deletion (Enabled) on "Comments(Action 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""O&verdue Entries"(Action 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""All Entries"(Action 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Delegate"(Action 25)".

    }

    var
        ApprovalCommentLine: Record "Approval Comment Line";

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
