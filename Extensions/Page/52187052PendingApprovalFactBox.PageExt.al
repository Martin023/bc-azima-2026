#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187052 pageextension52187052 extends "Pending Approval FactBox" 
{
    layout
    {
        modify("Sender ID")
        {
            ApplicationArea = Basic;
        }
        modify("Due Date")
        {
            ApplicationArea = Basic;
        }
        modify(Comment)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Sender ID"(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 5)".


        //Unsupported feature: Code Modification on "Comment(Control 2).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ApprovalComments.SETTABLEVIEW(ApprovalCommentLine);
            ApprovalComments.SetWorkflowStepInstanceID("Workflow Step Instance ID");
            ApprovalComments.RUNMODAL;
            CurrPage.UPDATE;
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            PAGE.RUNMODAL(PAGE::"Approval Comments",ApprovalCommentLine);
            CurrPage.UPDATE;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Comment(Control 2)".

    }


    //Unsupported feature: Code Modification on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        ApprovalCommentLine.SETRANGE("Table ID","Table ID");
        ApprovalCommentLine.SETRANGE("Record ID to Approve","Record ID to Approve");
        IF ApprovalCommentLine.FINDLAST THEN;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        ApprovalCommentLine.SETRANGE("Table ID","Table ID");
        ApprovalCommentLine.SETRANGE("Document Type","Document Type");
        ApprovalCommentLine.SETRANGE("Document No.","Document No.");
        IF ApprovalCommentLine.FINDFIRST THEN;
        */
    //end;
}
