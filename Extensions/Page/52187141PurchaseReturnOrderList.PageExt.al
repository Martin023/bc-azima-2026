#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187141 pageextension52187141 extends "Purchase Return Order List"
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Buy-from Vendor No.")
        {
            ApplicationArea = Basic;
        }
        modify("Order Address Code")
        {
            ApplicationArea = Basic;
        }
        modify("Buy-from Vendor Name")
        {
            ApplicationArea = Basic;
        }
        modify("Vendor Authorization No.")
        {
            ApplicationArea = Basic;
        }
        modify("Buy-from Post Code")
        {
            ApplicationArea = Basic;
        }
        modify("Buy-from Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("Buy-from Contact")
        {
            ApplicationArea = Basic;
        }
        modify("Pay-to Vendor No.")
        {
            ApplicationArea = Basic;
        }
        modify("Pay-to Name")
        {
            ApplicationArea = Basic;
        }
        modify("Pay-to Post Code")
        {
            ApplicationArea = Basic;
        }
        modify("Pay-to Country/Region Code")
        {
            ApplicationArea = Basic;
        }
        modify("Pay-to Contact")
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

            //Unsupported feature: Property Insertion (Visible) on ""Location Code"(Control 115)".

        }
        modify("Purchaser Code")
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
        modify("Campaign No.")
        {
            ApplicationArea = Basic;
        }
        modify("Applies-to Doc. Type")
        {
            ApplicationArea = Basic;
        }
        modify("Expected Receipt Date")
        {
            ApplicationArea = Basic;
        }
        modify("Job Queue Status")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Insertion (Visible) on "Control1901138007(Control 1901138007)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Vendor No."(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Order Address Code"(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Vendor Name"(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor Authorization No."(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Post Code"(Control 27)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Country/Region Code"(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Contact"(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Vendor No."(Control 163)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Name"(Control 161)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Post Code"(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Country/Region Code"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Contact"(Control 151)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Code"(Control 147)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Name"(Control 145)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Post Code"(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Country/Region Code"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Contact"(Control 135)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 131)".


        //Unsupported feature: Code Insertion on ""Shortcut Dimension 1 Code"(Control 113)".

        //trigger OnLookup(var Text: Text): Boolean
        //begin
        /*
        DimMgt.LookupDimValueCodeNoUpdate(1);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 113)".



        //Unsupported feature: Code Insertion on ""Shortcut Dimension 2 Code"(Control 111)".

        //trigger OnLookup(var Text: Text): Boolean
        //begin
        /*
        DimMgt.LookupDimValueCodeNoUpdate(2);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 111)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 115)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Purchaser Code"(Control 99)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Assigned User ID"(Control 31)".


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
        modify("Shipment Method Code")
        {
            Visible = false;
        }
        modify("Completely Received")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign No."(Control 1102601003)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Applies-to Doc. Type"(Control 1102601005)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Expected Receipt Date"(Control 1102601007)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Job Queue Status"(Control 5)".

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

        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1901138007(Control 1901138007)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(Statistics)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Statistics(Action 1102601027)".

        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify(Approvals)
        {
            ApplicationArea = Basic;
        }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify("Return Shipments")
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
        modify("Warehouse Shipment Lines")
        {
            Caption = 'Whse. Shipment Lines';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Warehouse Shipment Lines"(Action 1102601035)".

        }
        modify(Print)
        {
            ApplicationArea = Basic;
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
        modify("Send IC Return Order")
        {
            ApplicationArea = Basic;
        }
        modify("Create Inventor&y Put-away/Pick")
        {
            ApplicationArea = Basic;
        }
        modify("Create &Warehouse Shipment")
        {
            Caption = 'Create &Whse. Shipment';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (Name) on ""Create &Warehouse Shipment"(Action 1102601015)".

        }
        modify(TestReport)
        {
            ApplicationArea = Basic;
        }
        modify(Post)
        {
            ApplicationArea = Basic;
        }
        modify(Preview)
        {
            ApplicationArea = Basic;
        }
        modify(PostAndPrint)
        {
            ApplicationArea = Basic;
        }
        modify(PostBatch)
        {
            ApplicationArea = Basic;
        }
        modify(RemoveFromJobQueue)
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

            //Unsupported feature: Property Modification (Image) on "CancelApprovalRequest(Action 18)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 1102601027)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Statistics(Action 1102601027)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1102601032)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 1102601032)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 1102601032)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Dimensions(Action 1102601032)".



        //Unsupported feature: Code Insertion (VariableCollection) on "Approvals(Action 14).OnAction".

        //trigger (Variable: ApprovalEntries)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "Approvals(Action 14).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RECORDID,DATABASE::"Purchase Header","Document Type","No.");
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        ApprovalEntries.Setfilters(DATABASE::"Purchase Header","Document Type","No.");
        ApprovalEntries.RUN;
        */
        //end;

        //Unsupported feature: Property Deletion (AccessByPermission) on "Approvals(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Approvals(Action 14)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Approvals(Action 14)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Approvals(Action 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 1102601029)".


        //Unsupported feature: Property Deletion (Promoted) on ""Co&mments"(Action 1102601029)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Co&mments"(Action 1102601029)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Co&mments"(Action 1102601029)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Return Shipments"(Action 1102601030)".


        //Unsupported feature: Property Deletion (Promoted) on ""Return Shipments"(Action 1102601030)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Return Shipments"(Action 1102601030)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Return Shipments"(Action 1102601030)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Cred&it Memos"(Action 1102601031)".


        //Unsupported feature: Property Deletion (Promoted) on ""Cred&it Memos"(Action 1102601031)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Cred&it Memos"(Action 1102601031)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Cred&it Memos"(Action 1102601031)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""In&vt. Put-away/Pick Lines"(Action 1102601036)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Warehouse Shipment Lines"(Action 1102601035)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Print(Action 55)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Print(Action 55)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Release(Action 1102601021)".


        //Unsupported feature: Property Deletion (Promoted) on "Release(Action 1102601021)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Release(Action 1102601021)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Release(Action 1102601021)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reopen(Action 1102601022)".


        //Unsupported feature: Property Deletion (Promoted) on "Reopen(Action 1102601022)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Reopen(Action 1102601022)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Reopen(Action 1102601022)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Get Posted Doc&ument Lines to Reverse"(Action 1102601013)".


        //Unsupported feature: Property Deletion (Promoted) on ""Get Posted Doc&ument Lines to Reverse"(Action 1102601013)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Get Posted Doc&ument Lines to Reverse"(Action 1102601013)".


        //Unsupported feature: Property Deletion (PromotedOnly) on ""Get Posted Doc&ument Lines to Reverse"(Action 1102601013)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Send IC Return Order"(Action 1102601024)".

        modify("Delete Invoiced Orders")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Create Inventor&y Put-away/Pick"(Action 1102601016)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Create &Warehouse Shipment"(Action 1102601015)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TestReport(Action 51)".


        //Unsupported feature: Property Deletion (Promoted) on "TestReport(Action 51)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "TestReport(Action 51)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "TestReport(Action 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Post(Action 52)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Post(Action 52)".

        modify(PostSelected)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Preview(Action 12)".


        //Unsupported feature: Property Deletion (Promoted) on "Preview(Action 12)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Preview(Action 12)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "Preview(Action 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PostAndPrint(Action 53)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "PostAndPrint(Action 53)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PostBatch(Action 54)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "PostBatch(Action 54)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RemoveFromJobQueue(Action 3)".



        //Unsupported feature: Code Modification on "SendApprovalRequest(Action 19).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) THEN
          ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF ApprovalsMgmt.CheckPurchaseApprovalsWorkflowEnabled(Rec) THEN
          ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "SendApprovalRequest(Action 19)".


        //Unsupported feature: Property Deletion (Promoted) on "SendApprovalRequest(Action 19)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "SendApprovalRequest(Action 19)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "SendApprovalRequest(Action 19)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "SendApprovalRequest(Action 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CancelApprovalRequest(Action 18)".


        //Unsupported feature: Property Deletion (Promoted) on "CancelApprovalRequest(Action 18)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "CancelApprovalRequest(Action 18)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "CancelApprovalRequest(Action 18)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "CancelApprovalRequest(Action 18)".

        moveafter(Action1102601014; "Request Approval")
    }

    var
    //ApprovalEntries: Page "Approval Entries";

    var
        DimMgt: Codeunit DimensionManagement;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetSecurityFilterOnRespCenter;

    JobQueueActive := PurchasesPayablesSetup.JobQueueActive;

    CopyBuyFromVendorFilter;
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


    //Unsupported feature: Property Deletion (RefreshOnActivate).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
