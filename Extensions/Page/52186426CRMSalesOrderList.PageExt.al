#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186426 pageextension52186426 extends "CRM Sales Order List"
{
    Caption = 'Microsoft Dynamics CRM Sales Orders';
    layout
    {
        modify(OrderNumber)
        {
            ApplicationArea = Basic;
        }
        modify(Name)
        {
            ApplicationArea = Basic;
        }
        modify(TransactionCurrencyIdName)
        {
            ApplicationArea = Basic;
        }
        modify(PriceLevelIdName)
        {
            ApplicationArea = Basic;
        }
        modify(IsPriceLocked)
        {
            ApplicationArea = Basic;
        }
        modify(TotalAmount)
        {
            ApplicationArea = Basic;
        }
        modify(StateCode)
        {
            ApplicationArea = Basic;
        }
        modify(StatusCode)
        {
            ApplicationArea = Basic;
        }
        modify(RequestDeliveryBy)
        {
            ApplicationArea = Basic;
        }
        modify(DateFulfilled)
        {
            ApplicationArea = Basic;
        }
        modify(ShippingMethodCode)
        {
            ApplicationArea = Basic;
        }
        modify(PaymentTermsCode)
        {
            ApplicationArea = Basic;
        }
        modify(FreightTermsCode)
        {
            ApplicationArea = Basic;
        }
        modify("BillTo_Composite")
        {
            ApplicationArea = Basic;
        }
        modify(WillCall)
        {
            ApplicationArea = Basic;
        }
        modify("ShipTo_Composite")
        {
            ApplicationArea = Basic;
        }
        modify(OpportunityIdName)
        {
            ApplicationArea = Basic;
        }
        modify(QuoteIdName)
        {
            ApplicationArea = Basic;
        }
        modify(ContactIdName)
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "OrderNumber(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TransactionCurrencyIdName(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PriceLevelIdName(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on "IsPriceLocked(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalAmount(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "StateCode(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "StatusCode(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RequestDeliveryBy(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DateFulfilled(Control 13)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShippingMethodCode(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PaymentTermsCode(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "FreightTermsCode(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BillTo_Composite"(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "WillCall(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ShipTo_Composite"(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "OpportunityIdName(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "QuoteIdName(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ContactIdName(Control 23)".

        addfirst(Group)
        {
            field(Coupled; CRMIsCoupledToRecord)
            {
                ApplicationArea = Basic;
                Caption = 'Coupled';
            }
        }
        addafter(QuoteIdName)
        {
            field(GetCustomerName; GetCustomerName)
            {
                ApplicationArea = Basic;
                Caption = 'Account';
            }
        }
    }
    actions
    {
        modify(ActionGroupCRM)
        {
            Caption = 'Dynamics CRM';

            //Unsupported feature: Property Insertion (Visible) on "ActionGroupCRM(Action 25)".

        }
        modify(CRMGoToSalesOrder)
        {
            ToolTip = 'Open the coupled Microsoft Dynamics CRM sales order.';
            ApplicationArea = Basic;
        }
        modify(ActionGroupNAV)
        {
            Caption = 'Dynamics NAV';
        }
        modify(CreateInNAV)
        {
            Caption = 'Create in Dynamics NAV';
            ApplicationArea = Basic;
            Enabled = CanCreateInNAV;
        }


        //Unsupported feature: Code Modification on "CRMGoToSalesOrder(Action 11).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ISEMPTY THEN
          EXIT;
        HYPERLINK(CRMIntegrationManagement.GetCRMEntityUrlFromCRMID(DATABASE::"CRM Salesorder",SalesOrderId));
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        HYPERLINK(
          CRMIntegrationManagement.GetCRMEntityUrlFromCRMID(DATABASE::"CRM Salesorder",SalesOrderId));
        */
        //end;

        //Unsupported feature: Property Deletion (RunPageOnRec) on "CRMGoToSalesOrder(Action 11)".


        //Unsupported feature: Property Deletion (Enabled) on "CRMGoToSalesOrder(Action 11)".



        //Unsupported feature: Code Modification on "CreateInNAV(Action 29).OnAction".

        //trigger OnAction()
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        IF ISEMPTY THEN
          EXIT;

        IF CRMSalesOrderToSalesOrder.CreateInNAV(Rec,SalesHeader) THEN BEGIN
          COMMIT;
          PAGE.RUNMODAL(PAGE::"Sales Order",SalesHeader);
        END;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        IF CRMSalesOrderToSalesOrder.CreateInNAV(Rec,SalesHeader) THEN BEGIN
          COMMIT;
          CRMIsCoupledToRecord :=
            CRMCouplingManagement.IsRecordCoupledToNAV(SalesOrderId,DATABASE::"Sales Header") AND CRMIntegrationEnabled;
          PAGE.RUNMODAL(PAGE::"Sales Order",SalesHeader);
        END;
        RecalculateRecordCouplingStatus;
        */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "CreateInNAV(Action 29)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "CreateInNAV(Action 29)".

        addfirst(ActionGroupNAV)
        {
            action(NAVOpenSalesOrderCard)
            {
                ApplicationArea = Basic;
                Caption = 'Sales Order';
                Enabled = CRMIsCoupledToRecord;
                Image = "Order";
                ToolTip = 'Open the sales order card.';
                //Visible = CRMIntegrationEnabled;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    CRMSalesOrderToSalesOrder: Codeunit "CRM Sales Order to Sales Order";
                begin
                    if not CRMSalesOrderToSalesOrder.GetCoupledSalesHeader(Rec, SalesHeader) then
                        Error(GetLastErrorText);
                    Page.RunModal(Page::"Sales Order", SalesHeader);
                    RecalculateRecordCouplingStatus;
                end;
            }
        }
    }

    var
        CRMCouplingManagement: Codeunit "CRM Coupling Management";

    var
        CRMIsCoupledToRecord: Boolean;
        CanCreateInNAV: Boolean;


    //Unsupported feature: Code Modification on "OnAfterGetCurrRecord".

    //trigger OnAfterGetCurrRecord()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    HasRecords := NOT ISNULLGUID(SalesOrderId);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    RecalculateRecordCouplingStatus;
    */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
    /*
    CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;
    RecalculateCanCreateInNAV;
    */
    //end;

    local procedure RecalculateRecordCouplingStatus()
    var
        CRMSalesOrderToSalesOrder: Codeunit "CRM Sales Order to Sales Order";
    begin
        //CRMIsCoupledToRecord := CRMSalesOrderToSalesOrder.CRMIsCoupledToValidRecord(Rec, Database::"Sales Header");
        RecalculateCanCreateInNAV;
    end;

    local procedure GetCustomerName(): Text
    var
        CRMAccount: Record "CRM Account";
        CRMContact: Record "CRM Contact";
    begin
        if (Rec.CustomerIdType = Rec.Customeridtype::account) and (not IsNullGuid(Rec.CustomerId)) then begin
            if CRMAccount.Get(Rec.CustomerId) then
                exit(CRMAccount.Name);
        end else
            if Rec.CustomerIdType = Rec.Customeridtype::contact then
                if CRMContact.Get(Rec.CustomerId) then
                    if CRMAccount.Get(CRMContact.ParentCustomerId) then
                        exit(CRMAccount.Name);
    end;

    local procedure RecalculateCanCreateInNAV()
    begin
        if Rec.Count = 0 then
            CanCreateInNAV := false
        // else
        //CanCreateInNAV := CRMIntegrationEnabled and not CRMIsCoupledToRecord;
    end;

    //Unsupported feature: Property Deletion (ApplicationArea).


    //Unsupported feature: Property Deletion (UsageCategory).

}
