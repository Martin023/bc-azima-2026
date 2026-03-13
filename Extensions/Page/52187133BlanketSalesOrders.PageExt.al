#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187133 pageextension52187133 extends "Blanket Sales Orders"
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

        //Unsupported feature: Property Insertion (Visible) on "Control1902018507(Control 1902018507)".


        //Unsupported feature: Property Insertion (Visible) on "Control1900316107(Control 1900316107)".


        //Unsupported feature: Property Insertion (Visible) on "Control1905767507(Control 1905767507)".


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


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1902018507(Control 1902018507)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900316107(Control 1900316107)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

    }
    actions
    {
        modify(SalesOrderStatistics)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Statistics(Action 1102601017)".

        }
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
        modify("Re&lease")
        {
            ApplicationArea = Basic;
        }
        modify("Re&open")
        {
            ApplicationArea = Basic;
        }
        modify("Make &Order")
        {
            ApplicationArea = Basic;
        }
        modify(Print)
        {
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (PromotedCategory) on "Print(Action 78)".

        }
        modify(SendApprovalRequest)
        {
            ApplicationArea = Basic;
        }
        modify(CancelApprovalRequest)
        {
            ApplicationArea = Basic;
            // Enabled = OpenApprovalEntriesExist;

            //Unsupported feature: Property Modification (Image) on "CancelApprovalRequest(Action 1102601011)".

        }

        //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 1102601017)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Statistics(Action 1102601017)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 1102601019)".


        //Unsupported feature: Property Deletion (Promoted) on ""Co&mments"(Action 1102601019)".


        //Unsupported feature: Property Deletion (PromotedCategory) on ""Co&mments"(Action 1102601019)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 1102601020)".


        //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 1102601020)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on "Dimensions(Action 1102601020)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 1102601020)".


        //Unsupported feature: Code Insertion (VariableCollection) on "Approvals(Action 1102601021).OnAction".

        //trigger (Variable: ApprovalEntries)()
        //Parameters and return type have not been exported.
        //begin
        /*
        */
        //end;


        //Unsupported feature: Code Modification on "Approvals(Action 1102601021).OnAction".

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

        //Unsupported feature: Property Deletion (AccessByPermission) on "Approvals(Action 1102601021)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Approvals(Action 1102601021)".


        //Unsupported feature: Property Deletion (Promoted) on "Approvals(Action 1102601021)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "Approvals(Action 1102601021)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Re&lease"(Action 1102601013)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Re&open"(Action 1102601014)".

        modify("Delete Invoiced Blanket")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""Make &Order"(Action 73)".


        //Unsupported feature: Property Deletion (PromotedIsBig) on ""Make &Order"(Action 73)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Print(Action 78)".



        //Unsupported feature: Code Modification on "SendApprovalRequest(Action 1102601010).OnAction".

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

        //Unsupported feature: Property Deletion (ToolTipML) on "SendApprovalRequest(Action 1102601010)".


        //Unsupported feature: Property Deletion (ToolTipML) on "CancelApprovalRequest(Action 1102601011)".

        addfirst("F&unctions")
        {
            separator(Action1102601012)
            {
            }
        }
    }

    var
    //ApprovalEntries: Page "Approval Entries";


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetSecurityFilterOnRespCenter;

    CopySellToCustomerFilter;
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


    //Unsupported feature: Property Deletion (RefreshOnActivate).


    //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

}
