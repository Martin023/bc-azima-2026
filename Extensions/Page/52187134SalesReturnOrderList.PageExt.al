#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187134 pageextension52187134 extends "Sales Return Order List"
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Sell-to Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify("Sell-to Customer Name")
        {
            ApplicationArea = Basic;
        }
        modify("External Document No.")
        {
            ApplicationArea = Basic;
        }
        modify("Sell-to Post Code")
        {
            ApplicationArea = Basic;
        }
        modify("Sell-to Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("Sell-to Contact")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Customer No.")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Name")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Post Code")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("Bill-to Contact")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Code")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Name")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Post Code")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("Ship-to Contact")
        {
            ApplicationArea = Basic;
        }
        modify("Posting Date")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 1 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Shortcut Dimension 2 Code")
        {
            ApplicationArea = Basic;
        }
        modify("Location Code")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Insertion (Visible) on ""Location Code"(Control 123)".

        }
        modify("Salesperson Code")
        {
            ApplicationArea = Basic;
        }
        modify("Assigned User ID")
        {
            ApplicationArea = Basic;
        }
        modify("Currency Code")
        {
            ApplicationArea = Basic;
        }
        modify("Document Date")
        {
            ApplicationArea = Basic;
        }
        modify("Shipment Date")
        {
            ApplicationArea = Basic;
        }
        modify("Job Queue Status")
        {
            ApplicationArea = Basic;
        }
        modify("Campaign No.")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Doc. Type")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Insertion (Visible) on "Control1902018507(Control 1902018507)".


        //Unsupported feature: Property Insertion (Visible) on "Control1900316107(Control 1900316107)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Customer No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Customer Name"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""External Document No."(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Post Code"(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Country/Region Code"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Sell-to Contact"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Customer No."(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Name"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Post Code"(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Country/Region Code"(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Bill-to Contact"(Control 159)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Code"(Control 155)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Name"(Control 153)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Post Code"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Country/Region Code"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Contact"(Control 143)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 139)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 121)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 119)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 123)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Salesperson Code"(Control 99)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assigned User ID"(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 11)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 1102601001)".

        modify(Status)
        {
            Visible = false;
        }
        modify("Payment Terms Code")
        {
            Visible = false;
        }
        modify("Due Date")
        {
            Visible = false;
        }
        modify("Payment Discount %")
        {
            Visible = false;
        }
        modify("Shipping Agent Code")
        {
            Visible = false;
        }
        modify("Shipping Agent Service Code")
        {
            Visible = false;
        }
        modify("Package Tracking No.")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Date"(Control 1102601007)".

        modify("Shipping Advice")
        {
            Visible = false;
        }
        modify("Completely Shipped")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Queue Status"(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign No."(Control 1102601003)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Doc. Type"(Control 1102601005)".

        modify(Amount)
        {
            Visible = false;
        }
        modify("Amount Including VAT")
        {
            Visible = false;
        }
        modify("Posting Description")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1902018507(Control 1902018507)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900316107(Control 1900316107)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

        moveafter("Document Date"; "Campaign No.")
    }
    actions
    {
        modify(Statistics)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Statistics(Action 1102601028)".

        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Promoted) on "Dimensions(Action 1102601033)".


            //Unsupported feature: Property Modification (PromotedIsBig) on "Dimensions(Action 1102601033)".

        }
        modify(Approvals)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Promoted) on "Approvals(Action 1102601034)".


            //Unsupported feature: Property Insertion (PromotedIsBig) on "Approvals(Action 1102601034)".

        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Promoted) on ""Co&mments"(Action 1102601030)".

        }
        modify("Return Receipts")
        {
            ApplicationArea = Basic;
        }
        modify("Cred&it Memos")
        {
            ApplicationArea = Basic;
        }
        modify("In&vt. Put-away/Pick Lines")
        {
            ApplicationArea = Basic;
        }
        modify("Whse. Receipt Lines")
        {
            ApplicationArea = Basic;
        }
        modify("&Print")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""&Print"(Action 48)".

        }
        modify(Release)
        {
            ApplicationArea = Basic;
        }
        modify(Reopen)
        {
            ApplicationArea = Basic;
        }
        modify("Get Posted Doc&ument Lines to Reverse")
        {
            ApplicationArea = Basic;
        }
        modify("Send IC Return Order Cnfmn.")
        {
            ApplicationArea = Basic;
        }
        modify(SendApprovalRequest)
        {
            ApplicationArea = Basic;
        }
        modify(CancelApprovalRequest)
        {
            ApplicationArea = Basic;
            // Enabled = OpenApprovalEntriesExist;

            //Unsupported feature: Property Modification (Image) on "CancelApprovalRequest(Action 1102601020)".

        }
        modify("Create Inventor&y Put-away/Pick")
        {
            ApplicationArea = Basic;
        }
        modify("Create &Whse. Receipt")
        {
            ApplicationArea = Basic;
        }
        modify("Test Report")
        {
            ApplicationArea = Basic;
        }
        modify(Post)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Post(Action 52)".

        }
        modify("Preview Posting")
        {
            ApplicationArea = Basic;
        }
        modify("Post and &Print")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Post and &Print"(Action 51)".

        }
        modify("Post and Email")
        {
            ApplicationArea = Basic;
        }
        modify("Post &Batch")
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on ""Post &Batch"(Action 50)".

        }
        modify("Remove From Job Queue")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 1102601028)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1102601033)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 1102601033)".


        //Unsupported feature: Code Insertion (VariableCollection) on "Approvals(Action 1102601034).OnAction".

        //trigger (Variable: ApprovalEntries)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "Approvals(Action 1102601034).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RECORDID,DATABASE::"Sales Header","Document Type","No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ApprovalEntries.Setfilters(DATABASE::"Sales Header","Document Type","No.");
        ApprovalEntries.RUN;
        */
        //end;

        //Unsupported feature: Property Deletion (AccessByPermission) on "Approvals(Action 1102601034)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Approvals(Action 1102601034)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Approvals(Action 1102601034)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 1102601030)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Co&mments"(Action 1102601030)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Return Receipts"(Action 1102601031)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cred&it Memos"(Action 1102601032)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""In&vt. Put-away/Pick Lines"(Action 1102601037)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Whse. Receipt Lines"(Action 1102601036)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""&Print"(Action 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Release(Action 1102601022)".


        //Unsupported feature: Property Deletion (Promoted) on "Release(Action 1102601022)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Release(Action 1102601022)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Release(Action 1102601022)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reopen(Action 1102601023)".


        //Unsupported feature: Property Deletion (Promoted) on "Reopen(Action 1102601023)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Reopen(Action 1102601023)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Reopen(Action 1102601023)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Get Posted Doc&ument Lines to Reverse"(Action 1102601014)".


        //Unsupported feature: Property Deletion (Promoted) on ""Get Posted Doc&ument Lines to Reverse"(Action 1102601014)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Get Posted Doc&ument Lines to Reverse"(Action 1102601014)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Get Posted Doc&ument Lines to Reverse"(Action 1102601014)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Send IC Return Order Cnfmn."(Action 1102601025)".

        modify("Delete Invoiced Orders")
        {
            Visible = false;
        }


        //Unsupported feature: Code Modification on "SendApprovalRequest(Action 1102601019).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ApprovalsMgmt.CheckSalesApprovalPossible(Rec) THEN
          ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF ApprovalsMgmt.CheckSalesApprovalsWorkflowEnabled(Rec) THEN
          ApprovalsMgmt.OnSendSalesDocForApproval(Rec);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "SendApprovalRequest(Action 1102601019)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CancelApprovalRequest(Action 1102601020)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Inventor&y Put-away/Pick"(Action 1102601017)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create &Whse. Receipt"(Action 1102601016)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Test Report"(Action 54)".



        //Unsupported feature: Code Modification on "Post(Action 52).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CurrPage.SETSELECTIONFILTER(SalesHeader);
        IF SalesHeader.COUNT > 1 THEN BEGIN
          BatchProcessingMgt.AddParameter(BatchPostParameterTypes.Invoice,TRUE);
          BatchProcessingMgt.AddParameter(BatchPostParameterTypes.Receive,TRUE);

          SalesBatchPostMgt.SetBatchProcessor(BatchProcessingMgt);
          SalesBatchPostMgt.RunWithUI(SalesHeader,COUNT,ReadyToPostQst);
        END ELSE
          SendToPosting(CODEUNIT::"Sales-Post (Yes/No)");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SendToPosting(CODEUNIT::"Sales-Post (Yes/No)");
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Post(Action 52)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Preview Posting"(Action 14)".


        //Unsupported feature: Property Deletion (Promoted) on ""Preview Posting"(Action 14)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Preview Posting"(Action 14)".



        //Unsupported feature: Code Modification on ""Post and &Print"(Action 51).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        AssertSalesOrderNotEmpty;
        SendToPosting(CODEUNIT::"Sales-Post + Print");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SendToPosting(CODEUNIT::"Sales-Post + Print");
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Post and &Print"(Action 51)".



        //Unsupported feature: Code Modification on ""Post and Email"(Action 12).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        AssertSalesOrderNotEmpty;
        SalesPostPrint.PostAndEmail(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        SalesPostPrint.PostAndEmail(Rec);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Post and Email"(Action 12)".


        //Unsupported feature: Property Deletion (Promoted) on ""Post and Email"(Action 12)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Post and Email"(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Post &Batch"(Action 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Remove From Job Queue"(Action 3)".

    }

    var
    //ApprovalEntries: Page "Approval Entries";


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetSecurityFilterOnRespCenter;

    JobQueueActive := SalesSetup.JobQueueActive;

    CopySellToCustomerFilter;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..3
    */
    //end;


    //Unsupported feature: Code Modification on "SetControlAppearance(PROCEDURE 5)".

    //procedure SetControlAppearance();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
    /*
    OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);

    CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
    */
    //end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (DataCaptionFields).


    //Unsupported feature: Property Deletion (UsageCategory).


    //Unsupported feature: Property Deletion (QueryCategory).


    //Unsupported feature: Property Deletion (RefreshOnActivate).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
