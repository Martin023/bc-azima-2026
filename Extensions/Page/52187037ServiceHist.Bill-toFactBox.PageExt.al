#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187037 pageextension52187037 extends "Service Hist. Bill-to FactBox" 
{
    Caption = 'Customer Service History - Bill-to Customer';
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify(NoOfQuotes)
        {

            //Unsupported feature: Property Modification (Level) on "NoOfQuotes(Control 2)".

            ApplicationArea = Basic;
        }
        modify(NoOfOrders)
        {

            //Unsupported feature: Property Modification (Level) on "NoOfOrders(Control 4)".

            ApplicationArea = Basic;
        }
        modify(NoOfInvoices)
        {

            //Unsupported feature: Property Modification (Level) on "NoOfInvoices(Control 11)".

            ApplicationArea = Basic;
        }
        modify(NoOfCreditMemos)
        {

            //Unsupported feature: Property Modification (Level) on "NoOfCreditMemos(Control 13)".

            ApplicationArea = Basic;
        }
        modify(NoOfPostedShipments)
        {

            //Unsupported feature: Property Modification (Level) on "NoOfPostedShipments(Control 15)".

            ApplicationArea = Basic;
        }
        modify(NoOfPostedInvoices)
        {

            //Unsupported feature: Property Modification (Level) on "NoOfPostedInvoices(Control 17)".

            ApplicationArea = Basic;
        }
        modify(NoOfPostedCreditMemos)
        {

            //Unsupported feature: Property Modification (Level) on "NoOfPostedCreditMemos(Control 19)".

            ApplicationArea = Basic;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 10)".

        modify(Control1)
        {
            Visible = false;
        }

        //Unsupported feature: Code Modification on "NoOfQuotes(Control 2).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ServiceHeader.SETRANGE("Bill-to Customer No.","No.");
            PAGE.RUN(PAGE::"Service Quotes",ServiceHeader);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ServiceHeader.SETRANGE("Bill-to Customer No.","No.");
            ServiceQuotes.SETTABLEVIEW(ServiceHeader);
            ServiceQuotes.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "NoOfQuotes(Control 2)".



        //Unsupported feature: Code Modification on "NoOfOrders(Control 4).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ServiceHeader.SETRANGE("Bill-to Customer No.","No.");
            PAGE.RUN(PAGE::"Service Orders",ServiceHeader);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ServiceHeader.SETRANGE("Bill-to Customer No.","No.");
            ServiceOrders.SETTABLEVIEW(ServiceHeader);
            ServiceOrders.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "NoOfOrders(Control 4)".



        //Unsupported feature: Code Modification on "NoOfInvoices(Control 11).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ServiceHeader.SETRANGE("Bill-to Customer No.","No.");
            PAGE.RUN(PAGE::"Service Invoices",ServiceHeader);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ServiceHeader.SETRANGE("Bill-to Customer No.","No.");
            ServiceInvoices.SETTABLEVIEW(ServiceHeader);
            ServiceInvoices.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "NoOfInvoices(Control 11)".



        //Unsupported feature: Code Modification on "NoOfCreditMemos(Control 13).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ServiceHeader.SETRANGE("Bill-to Customer No.","No.");
            PAGE.RUN(PAGE::"Service Credit Memos",ServiceHeader);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ServiceHeader.SETRANGE("Bill-to Customer No.","No.");
            ServiceCreditMemos.SETTABLEVIEW(ServiceHeader);
            ServiceCreditMemos.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "NoOfCreditMemos(Control 13)".



        //Unsupported feature: Code Insertion (VariableCollection) on "NoOfPostedShipments(Control 15).OnDrillDown".

        //trigger (Variable: ServiceShipmentHdrList)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on "NoOfPostedShipments(Control 15).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ServiceShipmentHdr.SETRANGE("Bill-to Customer No.","No.");
            PAGE.RUN(PAGE::"Posted Service Shipments",ServiceShipmentHdr);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ServiceShipmentHdr.SETRANGE("Bill-to Customer No.","No.");
            ServiceShipmentHdrList.SETTABLEVIEW(ServiceShipmentHdr);
            ServiceShipmentHdrList.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "NoOfPostedShipments(Control 15)".



        //Unsupported feature: Code Insertion (VariableCollection) on "NoOfPostedInvoices(Control 17).OnDrillDown".

        //trigger (Variable: ServiceInvoiceHdrList)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on "NoOfPostedInvoices(Control 17).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ServiceInvoiceHdr.SETRANGE("Bill-to Customer No.","No.");
            PAGE.RUN(PAGE::"Posted Service Invoices",ServiceInvoiceHdr);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ServiceInvoiceHdr.SETRANGE("Bill-to Customer No.","No.");
            ServiceInvoiceHdrList.SETTABLEVIEW(ServiceInvoiceHdr);
            ServiceInvoiceHdrList.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "NoOfPostedInvoices(Control 17)".



        //Unsupported feature: Code Insertion (VariableCollection) on "NoOfPostedCreditMemos(Control 19).OnDrillDown".

        //trigger (Variable: ServiceCrMemoHdrList)()
        //Parameters and return type have not been exported.
        //begin
            /*
            */
        //end;


        //Unsupported feature: Code Modification on "NoOfPostedCreditMemos(Control 19).OnDrillDown".

        //trigger OnDrillDown()
        //>>>> ORIGINAL CODE:
        //begin
            /*
            ServiceCrMemoHdr.SETRANGE("Bill-to Customer No.","No.");
            PAGE.RUN(PAGE::"Posted Service Credit Memos",ServiceCrMemoHdr);
            */
        //end;
        //>>>> MODIFIED CODE:
        //begin
            /*
            ServiceCrMemoHdr.SETRANGE("Bill-to Customer No.","No.");
            ServiceCrMemoHdrList.SETTABLEVIEW(ServiceCrMemoHdr);
            ServiceCrMemoHdrList.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on "NoOfPostedCreditMemos(Control 19)".

        modify(Control14)
        {
            Visible = false;
        }
        modify(NoOfQuotesTile)
        {
            Visible = false;
        }
        modify(NoOfOrdersTile)
        {
            Visible = false;
        }
        modify(NoOfInvoicesTile)
        {
            Visible = false;
        }
        modify(NoOfCreditMemosTile)
        {
            Visible = false;
        }
        modify(NoOfPostedShipmentsTile)
        {
            Visible = false;
        }
        modify(NoOfPostedInvoicesTile)
        {
            Visible = false;
        }
        modify(NoOfPostedCreditMemosTile)
        {
            Visible = false;
        }
    }

    var
        ServiceQuotes: Page "Service Quotes";

    var
        ServiceOrders: Page "Service Orders";

    var
        ServiceInvoices: Page "Service Invoices";

    var
        ServiceCreditMemos: Page "Service Credit Memos";

    var
        ServiceShipmentHdrList: Page "Posted Service Shipments";

    var
        ServiceInvoiceHdrList: Page "Posted Service Invoices";

    var
        ServiceCrMemoHdrList: Page "Posted Service Credit Memos";
}
