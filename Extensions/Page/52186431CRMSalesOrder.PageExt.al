#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52186431 pageextension52186431 extends "CRM Sales Order" 
{
    Caption = 'Microsoft Dynamics CRM Sales Order';
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
        modify(Account)
        {
            ApplicationArea = Basic;
        }
        modify(Contact)
        {
            ApplicationArea = Basic;
        }
        modify("Date Fulfilled")
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
        modify(Opportunity)
        {
            ApplicationArea = Basic;
        }
        modify(Quote)
        {
            ApplicationArea = Basic;
        }
        modify(PaymentTermsCode)
        {
            ApplicationArea = Basic;
        }
        modify("Price List")
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
        modify(TotalLineItemAmount)
        {
            ApplicationArea = Basic;
        }
        modify(TotalAmountLessFreight)
        {
            ApplicationArea = Basic;
        }
        modify(TotalDiscountAmount)
        {
            ApplicationArea = Basic;
        }
        modify(TotalTax)
        {
            ApplicationArea = Basic;
        }
        modify(Currency)
        {
            ApplicationArea = Basic;
        }
        modify(DiscountAmount)
        {
            ApplicationArea = Basic;
        }
        modify(DiscountPercentage)
        {
            ApplicationArea = Basic;
        }
        modify("BillTo_Name")
        {
            ApplicationArea = Basic;
        }
        modify("BillTo_ContactName")
        {
            ApplicationArea = Basic;
        }
        modify("BillTo_Line1")
        {
            ApplicationArea = Basic;
        }
        modify("BillTo_Line2")
        {
            ApplicationArea = Basic;
        }
        modify("BillTo_Line3")
        {
            ApplicationArea = Basic;
        }
        modify("BillTo_City")
        {
            ApplicationArea = Basic;
        }
        modify("BillTo_StateOrProvince")
        {
            ApplicationArea = Basic;
        }
        modify("BillTo_Country")
        {
            ApplicationArea = Basic;
        }
        modify("BillTo_PostalCode")
        {
            ApplicationArea = Basic;
        }
        modify("BillTo_Telephone")
        {
            ApplicationArea = Basic;
        }
        modify("BillTo_Fax")
        {
            ApplicationArea = Basic;
        }
        modify(RequestDeliveryBy)
        {
            ApplicationArea = Basic;
        }
        modify(ShippingMethodCode)
        {
            ApplicationArea = Basic;
        }
        modify(FreightTermsCode)
        {
            ApplicationArea = Basic;
        }
        modify("ShipTo_Name")
        {
            ApplicationArea = Basic;
        }
        modify("ShipTo_Line1")
        {
            ApplicationArea = Basic;
        }
        modify("ShipTo_Line2")
        {
            ApplicationArea = Basic;
        }
        modify("ShipTo_Line3")
        {
            ApplicationArea = Basic;
        }
        modify("ShipTo_City")
        {
            ApplicationArea = Basic;
        }
        modify("ShipTo_StateOrProvince")
        {
            ApplicationArea = Basic;
        }
        modify("ShipTo_Country")
        {
            ApplicationArea = Basic;
        }
        modify("ShipTo_PostalCode")
        {
            ApplicationArea = Basic;
        }
        modify("ShipTo_Telephone")
        {
            ApplicationArea = Basic;
        }
        modify("ShipTo_Fax")
        {
            ApplicationArea = Basic;
        }
        modify("ShipTo_FreightTermsCode")
        {
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "OrderNumber(Control 3)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Name(Control 4)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Account(Control 5)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Contact(Control 6)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Date Fulfilled"(Control 7)".


        //Unsupported feature: Property Deletion (ToolTipML) on "StateCode(Control 8)".


        //Unsupported feature: Property Deletion (ToolTipML) on "StatusCode(Control 9)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Opportunity(Control 10)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Quote(Control 11)".


        //Unsupported feature: Property Deletion (ApplicationArea) on "Lines(Control 12)".


        //Unsupported feature: Property Deletion (ToolTipML) on "PaymentTermsCode(Control 14)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""Price List"(Control 15)".


        //Unsupported feature: Property Deletion (ToolTipML) on "IsPriceLocked(Control 16)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalAmount(Control 17)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalLineItemAmount(Control 18)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalAmountLessFreight(Control 19)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalDiscountAmount(Control 20)".


        //Unsupported feature: Property Deletion (ToolTipML) on "TotalTax(Control 21)".


        //Unsupported feature: Property Deletion (ToolTipML) on "Currency(Control 22)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DiscountAmount(Control 23)".


        //Unsupported feature: Property Deletion (ToolTipML) on "DiscountPercentage(Control 24)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BillTo_Name"(Control 25)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BillTo_ContactName"(Control 26)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BillTo_Line1"(Control 28)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BillTo_Line2"(Control 29)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BillTo_Line3"(Control 30)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BillTo_City"(Control 31)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BillTo_StateOrProvince"(Control 32)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BillTo_Country"(Control 33)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BillTo_PostalCode"(Control 34)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BillTo_Telephone"(Control 35)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""BillTo_Fax"(Control 36)".


        //Unsupported feature: Property Deletion (ToolTipML) on "RequestDeliveryBy(Control 38)".


        //Unsupported feature: Property Deletion (ToolTipML) on "ShippingMethodCode(Control 39)".


        //Unsupported feature: Property Deletion (ToolTipML) on "FreightTermsCode(Control 40)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ShipTo_Name"(Control 41)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ShipTo_Line1"(Control 43)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ShipTo_Line2"(Control 44)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ShipTo_Line3"(Control 45)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ShipTo_City"(Control 46)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ShipTo_StateOrProvince"(Control 47)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ShipTo_Country"(Control 48)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ShipTo_PostalCode"(Control 49)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ShipTo_Telephone"(Control 50)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ShipTo_Fax"(Control 51)".


        //Unsupported feature: Property Deletion (ToolTipML) on ""ShipTo_FreightTermsCode"(Control 52)".

    }
    actions
    {
        modify(ActionGroupCRM)
        {
            Caption = 'Dynamics CRM';
        }
        modify(CRMGoToSalesOrderHyperlink)
        {
            ToolTip = 'Open the coupled Microsoft Dynamics CRM sales order.';
            ApplicationArea = Basic;
        }
        modify(ActionGroupNAV)
        {
            Caption = 'Dynamics NAV';
        }
        modify(NAVOpenSalesOrderCard)
        {
            ToolTip = 'Open the sales order card.';
            ApplicationArea = Basic;
        }
        modify(CreateInNAV)
        {
            Caption = 'Create in Dynamics NAV';
            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on "CreateInNAV(Action 55)".


        //Unsupported feature: Property Deletion (PromotedCategory) on "CreateInNAV(Action 55)".

    }

    //Unsupported feature: Code Modification on "RecalculateRecordCouplingStatus(PROCEDURE 1)".

    //procedure RecalculateRecordCouplingStatus();
    //Parameters and return type have not been exported.
    //>>>> ORIGINAL CODE:
    //begin
        /*
        CRMIsCoupledToRecord := CRMIntegrationEnabled;
        IF CRMIsCoupledToRecord THEN
          CRMIsCoupledToRecord := CRMSalesOrderToSalesOrder.CRMIsCoupledToValidRecord(Rec,DATABASE::"Sales Header");
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CRMIsCoupledToRecord := CRMSalesOrderToSalesOrder.CRMIsCoupledToValidRecord(Rec,DATABASE::"Sales Header");
        */
    //end;
}
