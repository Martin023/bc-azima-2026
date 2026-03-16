#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187136 pageextension52187136 extends "Purchase Quotes"
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
        modify(Status)
        {
            ApplicationArea = Basic;
            Editable = false;
        }

        //Unsupported feature: Property Insertion (Visible) on "Control1901138007(Control 1901138007)".


        //Unsupported feature: Property Insertion (Visible) on "Control1905767507(Control 1905767507)".


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


        //Unsupported feature: Property Deletion (ToolTipML) on ""Campaign No."(Control 1102601003)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Status(Control 1102601005)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "IncomingDocAttachFactBox(Control 5)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1901138007(Control 1901138007)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        // modify(SalesOrderStatistics)
        // {
        //     ApplicationArea = Basic;

        //     //Unsupported feature: Property Modification (PromotedCategory) on "Statistics(Action 1102601020)".

        // }
        modify("Co&mments")
        {
            ApplicationArea = Basic;
        }
        modify(Dimensions)
        {
            ApplicationArea = Basic;
        }
        modify(Approvals)
        {
            ApplicationArea = Basic;
        }
        modify(MakeOrder)
        {
            ApplicationArea = Basic;
        }
        modify(Print)
        {

            //Unsupported feature: Property Modification (Level) on "Print(Action 51)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Print(Action 51)".

        }
        modify(Release)
        {
            ApplicationArea = Basic;
        }
        modify(Reopen)
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
            //Enabled = OpenApprovalEntriesExist;

            //Unsupported feature: Property Modification (Image) on "CancelApprovalRequest(Action 8)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 1102601020)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 1102601022)".


        //Unsupported feature: Property Deletion (Promoted) on ""Co&mments"(Action 1102601022)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Co&mments"(Action 1102601022)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1102601023)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 1102601023)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 1102601023)".



        //Unsupported feature: Code Insertion (VariableCollection) on "Approvals(Action 7).OnAction".

        //trigger (Variable: ApprovalEntries)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "Approvals(Action 7).OnAction".

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

        //Unsupported feature: Property Deletion (AccessByPermission) on "Approvals(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Approvals(Action 7)".


        //Unsupported feature: Property Deletion (Promoted) on "Approvals(Action 7)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Approvals(Action 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "MakeOrder(Action 50)".

        // modify(ActionGroup12)
        // {
        //     Visible = false;
        // }


        //Unsupported feature: Code Modification on "Print(Action 51).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ApplicationAreaMgmtFacade.IsFoundationEnabled THEN
          LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);

        DocPrint.PrintPurchHeader(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        DocPrint.PrintPurchHeader(Rec);
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "Print(Action 51)".

        modify(Send)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Release(Action 1102601014)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Reopen(Action 1102601015)".



        //Unsupported feature: Code Modification on "SendApprovalRequest(Action 9).OnAction".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "SendApprovalRequest(Action 9)".


        //Unsupported feature: Property Deletion (Promoted) on "SendApprovalRequest(Action 9)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "SendApprovalRequest(Action 9)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "SendApprovalRequest(Action 9)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "SendApprovalRequest(Action 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CancelApprovalRequest(Action 8)".


        //Unsupported feature: Property Deletion (Promoted) on "CancelApprovalRequest(Action 8)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "CancelApprovalRequest(Action 8)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "CancelApprovalRequest(Action 8)".


        //Unsupported feature: Property Deletion (PromotedOnly) on "CancelApprovalRequest(Action 8)".

        // addfirst(ActionGroup3)
        // {
        //     separator(Action1102601013)
        //     {
        //     }
        // }
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

    CopyBuyFromVendorFilter;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    SetSecurityFilterOnRespCenter;
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


    //Unsupported feature: Property Deletion (AdditionalSearchTermsML).


    //Unsupported feature: Property Deletion (RefreshOnActivate).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
