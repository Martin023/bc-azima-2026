#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186171 pageextension52186171 extends "AccountantPortal Activity Cues"
{

    //Unsupported feature: Property Modification (Name) on ""AccountantPortal Activity Cues"(Page 1314)".

    Caption = 'Recurring Customer Sales Lines';

    //Unsupported feature: Property Modification (SourceTable) on ""AccountantPortal Activity Cues"(Page 1314)".


    //Unsupported feature: Property Insertion (DataCaptionFields) on ""AccountantPortal Activity Cues"(Page 1314)".

    layout
    {

        //Unsupported feature: Property Modification (Level) on "Control1(Control 1)".


        //Unsupported feature: Property Modification (ControlType) on "Control1(Control 1)".


        //Unsupported feature: Property Insertion (GroupType) on "Control1(Control 1)".

        modify(OverduePurchInvoiceStyle)
        {

            //Unsupported feature: Property Modification (Name) on "OverduePurchInvoiceStyle(Control 4)".

            ToolTip = 'Specifies a standard sales code from the Standard Sales Code table.';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "OverduePurchInvoiceStyle(Control 4)".


            //Unsupported feature: Property Insertion (Lookup) on "OverduePurchInvoiceStyle(Control 4)".

            // LookupPageID = "Mini Standard Sales Code Card";
        }
        modify(OverdueSalesInvoiceAmount)
        {

            //Unsupported feature: Property Modification (Name) on "OverdueSalesInvoiceAmount(Control 6)".

            ToolTip = 'Specifies a description of the standard sales code. When you fill in the Code field, the program automatically copies the description from the Standard Sales Code table.';
            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on "OverdueSalesInvoiceAmount(Control 6)".

        }
        // modify(ContactName)
        // {

        //     //Unsupported feature: Property Modification (Level) on "ContactName(Control 2)".


        //     //Unsupported feature: Property Modification (ControlType) on "ContactName(Control 2)".


        //     //Unsupported feature: Property Modification (Name) on "ContactName(Control 2)".

        //     //ToolTip = 'Specifies the customer number of the customer to which the standard sales code is assigned.';

        //     //Unsupported feature: Property Insertion (SourceExpr) on "ContactName(Control 2)".


        //     //Unsupported feature: Property Insertion (Visible) on "ContactName(Control 2)".

        //     ApplicationArea = Basic;
        // }

        //Unsupported feature: Property Deletion (ContainerType) on "Control1(Control 1)".

        modify("Overdue Purchase Invoice Amount")
        {
            Visible = false;
        }
        modify(OverduePurchInvoiceAmount)
        {
            Visible = false;
        }

        //Unsupported feature: Code Insertion on "Code(Control 4)".

        //trigger OnLookup(var Text: Text): Boolean
        //var
        //StdSalesCode: Record "Standard Sales Code";
        //begin
        /*
        IF Code <> '' THEN
          StdSalesCode.GET(Code);

        IF PAGE.RUNMODAL(PAGE::"Mini Standard Sales Codes",StdSalesCode) = ACTION::LookupOK THEN BEGIN
          VALIDATE(Code,StdSalesCode.Code);
          Text := Code;
        END;

        EXIT(TRUE);
        */
        //end;

        //Unsupported feature: Property Deletion (CaptionML) on "OverduePurchInvoiceStyle(Control 4)".

        modify("Overdue Sales Invoice Amount")
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (CaptionML) on "OverdueSalesInvoiceAmount(Control 6)".

        modify(OverdueSalesInvoiceStyle)
        {
            Visible = false;
        }
        modify("NonApplied Payments")
        {
            Visible = false;
        }
        modify(NonAppliedPaymentsAmount)
        {
            Visible = false;
        }
        modify(NonAppliedPaymentsStyle)
        {
            Visible = false;
        }
        modify("Purchase Inv. Due Next Week")
        {
            Visible = false;
        }
        modify(PurchInvoicesDueNextWeekAmount)
        {
            Visible = false;
        }
        modify(PurchInvoicesDueNextWeekStyle)
        {
            Visible = false;
        }
        modify("Sales Inv. Due Next Week")
        {
            Visible = false;
        }
        modify(SalesInvoicesDueNextWeekAmount)
        {
            Visible = false;
        }
        modify(SalesInvoicesDueNextWeekStyle)
        {
            Visible = false;
        }
        modify("Ongoing Purchase Invoice")
        {
            Visible = false;
        }
        modify(OngoingPurchaseInvoicesAmount)
        {
            Visible = false;
        }
        modify(OngoingPurchaseInvoicesStyle)
        {
            Visible = false;
        }
        modify("Ongoing Sales Invoice")
        {
            Visible = false;
        }
        modify(OngoingSalesInvoicesAmount)
        {
            Visible = false;
        }
        modify(OngoingSalesInvoicesStyle)
        {
            Visible = false;
        }
        modify("Sales this Month")
        {
            Visible = false;
        }
        modify(SalesThisMonthAmount)
        {
            Visible = false;
        }
        modify(SalesThisMonthStyle)
        {
            Visible = false;
        }
        modify("Top 10 Cust Sales YTD")
        {
            Visible = false;
        }
        modify(Top10CustomerSalesYTDAmount)
        {
            Visible = false;
        }
        modify(Top10CustomerSalesYTDStyle)
        {
            Visible = false;
        }
        modify("Avg. Collection Days")
        {
            Visible = false;
        }
        modify(AverageCollectionDaysAmount)
        {
            Visible = false;
        }
        modify(AverageCollectionDaysStyle)
        {
            Visible = false;
        }
        modify("Ongoing Sales Quote")
        {
            Visible = false;
        }
        modify(OngoingSalesQuotesAmount)
        {
            Visible = false;
        }
        modify(OngoingSalesQuotesStyle)
        {
            Visible = false;
        }
        modify("Ongoing Sales Order")
        {
            Visible = false;
        }
        modify(OngoingSalesOrdersAmount)
        {
            Visible = false;
        }
        modify(OngoingSalesOrdersStyle)
        {
            Visible = false;
        }
        modify(RequestToApprove)
        {
            Visible = false;
        }
        modify(RequeststoApproveAmount)
        {
            Visible = false;
        }
        modify(RequeststoApproveStyle)
        {
            Visible = false;
        }
        modify(PurchOrders)
        {
            Visible = false;
        }
        modify(PurchaseOrdersAmount)
        {
            Visible = false;
        }
        modify(PurchaseOrdersStyle)
        {
            Visible = false;
        }
        modify(SalesInvPendDocExchange)
        {
            Visible = false;
        }
        modify(SalesInvPendDocExchangeAmount)
        {
            Visible = false;
        }
        modify(SalesInvPendDocExchangeStyle)
        {
            Visible = false;
        }
        modify(SalesCRPendDocExchange)
        {
            Visible = false;
        }
        modify(SalesCrMPendDocExchangeAmount)
        {
            Visible = false;
        }
        modify(SalesCrMPendDocExchangeStyle)
        {
            Visible = false;
        }
        modify("Incoming Documents")
        {
            Visible = false;
        }
        modify(MyIncomingDocumentsAmount)
        {
            Visible = false;
        }
        modify(MyIncomingDocumentsStyle)
        {
            Visible = false;
        }
        modify(IncDocAwaitingVerification)
        {
            Visible = false;
        }
        modify(IncDocAwaitingVerifAmount)
        {
            Visible = false;
        }
        modify(IncDocAwaitingVerifStyle)
        {
            Visible = false;
        }

        //Unsupported feature: Property Deletion (GroupType) on "ContactName(Control 2)".

        modify(ContactNameAmount)
        {
            Visible = false;
        }
        modify(ContactNameStyle)
        {
            Visible = false;
        }
        addfirst(content)
        {
        }
        //moveafter(Control1;ContactName)
    }
    actions
    {

        addfirst(processing)
        {
            group("&Sales")
            {
                Caption = '&Sales';
                Image = Sales;
                action(Card)
                {
                    ApplicationArea = Basic;
                    Caption = 'Card';
                    Image = EditLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    //RunObject = Page "Mini Standard Sales Code Card";
                    //RunPageLink = Code=field(Code);
                    Scope = Repeater;
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }
}
