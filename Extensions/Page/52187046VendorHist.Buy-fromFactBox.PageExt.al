#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52187046 pageextension52187046 extends "Vendor Hist. Buy-from FactBox" 
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("No. of Quotes")
        {

            //Unsupported feature: Property Modification (Level) on ""No. of Quotes"(Control 2)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""No. of Quotes"(Control 2)".


            //Unsupported feature: Property Modification (Name) on ""No. of Quotes"(Control 2)".


            //Unsupported feature: Property Insertion (DrillDown) on ""No. of Quotes"(Control 2)".

            Editable = true;
        }
        modify("No. of Blanket Orders")
        {

            //Unsupported feature: Property Modification (Level) on ""No. of Blanket Orders"(Control 4)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""No. of Blanket Orders"(Control 4)".


            //Unsupported feature: Property Modification (Name) on ""No. of Blanket Orders"(Control 4)".


            //Unsupported feature: Property Insertion (DrillDown) on ""No. of Blanket Orders"(Control 4)".

            Editable = true;
        }
        modify("No. of Orders")
        {

            //Unsupported feature: Property Modification (Level) on ""No. of Orders"(Control 6)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""No. of Orders"(Control 6)".


            //Unsupported feature: Property Modification (Name) on ""No. of Orders"(Control 6)".


            //Unsupported feature: Property Insertion (DrillDown) on ""No. of Orders"(Control 6)".

            Editable = true;
        }
        modify("No. of Invoices")
        {

            //Unsupported feature: Property Modification (Level) on ""No. of Invoices"(Control 8)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""No. of Invoices"(Control 8)".


            //Unsupported feature: Property Modification (Name) on ""No. of Invoices"(Control 8)".


            //Unsupported feature: Property Insertion (DrillDown) on ""No. of Invoices"(Control 8)".

            Editable = true;
        }
        modify("No. of Return Orders")
        {

            //Unsupported feature: Property Modification (Level) on ""No. of Return Orders"(Control 10)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""No. of Return Orders"(Control 10)".


            //Unsupported feature: Property Modification (Name) on ""No. of Return Orders"(Control 10)".


            //Unsupported feature: Property Insertion (DrillDown) on ""No. of Return Orders"(Control 10)".

            Editable = true;
        }
        modify("No. of Credit Memos")
        {

            //Unsupported feature: Property Modification (Level) on ""No. of Credit Memos"(Control 12)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""No. of Credit Memos"(Control 12)".


            //Unsupported feature: Property Modification (Name) on ""No. of Credit Memos"(Control 12)".


            //Unsupported feature: Property Insertion (DrillDown) on ""No. of Credit Memos"(Control 12)".

            Editable = true;
        }
        modify("No. of Pstd. Return Shipments")
        {

            //Unsupported feature: Property Modification (Level) on ""No. of Pstd. Return Shipments"(Control 14)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""No. of Pstd. Return Shipments"(Control 14)".


            //Unsupported feature: Property Modification (Name) on ""No. of Pstd. Return Shipments"(Control 14)".


            //Unsupported feature: Property Insertion (DrillDown) on ""No. of Pstd. Return Shipments"(Control 14)".

            Editable = true;
        }
        modify("No. of Pstd. Receipts")
        {

            //Unsupported feature: Property Modification (Level) on ""No. of Pstd. Receipts"(Control 16)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""No. of Pstd. Receipts"(Control 16)".


            //Unsupported feature: Property Modification (Name) on ""No. of Pstd. Receipts"(Control 16)".


            //Unsupported feature: Property Insertion (DrillDown) on ""No. of Pstd. Receipts"(Control 16)".

            Editable = true;
        }
        modify("No. of Pstd. Invoices")
        {

            //Unsupported feature: Property Modification (Level) on ""No. of Pstd. Invoices"(Control 18)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""No. of Pstd. Invoices"(Control 18)".


            //Unsupported feature: Property Modification (Name) on ""No. of Pstd. Invoices"(Control 18)".


            //Unsupported feature: Property Insertion (DrillDown) on ""No. of Pstd. Invoices"(Control 18)".

            Editable = true;
        }
        modify("No. of Pstd. Credit Memos")
        {

            //Unsupported feature: Property Modification (Level) on ""No. of Pstd. Credit Memos"(Control 20)".

            ApplicationArea = Basic;

            //Unsupported feature: Property Modification (SourceExpr) on ""No. of Pstd. Credit Memos"(Control 20)".


            //Unsupported feature: Property Modification (Name) on ""No. of Pstd. Credit Memos"(Control 20)".


            //Unsupported feature: Property Insertion (DrillDown) on ""No. of Pstd. Credit Memos"(Control 20)".

            Editable = true;
        }

        //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 21)".


        //Unsupported feature: Property Deletion (Visible) on ""No."(Control 21)".

        modify(Control23)
        {
            Visible = false;
        }

        //Unsupported feature: Code Insertion on "NoOfQuotes(Control 2)".

        //trigger OnDrillDown()
        //var
            //PurchHdr: Record "Purchase Header";
            //PurchaseQuotes: Page "Purchase Quotes";
        //begin
            /*
            PurchHdr.SETRANGE("Buy-from Vendor No.","No.");
            PurchaseQuotes.SETTABLEVIEW(PurchHdr);
            PurchaseQuotes.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Quotes"(Control 2)".


        //Unsupported feature: Property Deletion (DrillDownPageID) on ""No. of Quotes"(Control 2)".



        //Unsupported feature: Code Insertion on "NoOfBlanketOrders(Control 4)".

        //trigger OnDrillDown()
        //var
            //PurchHdr: Record "Purchase Header";
        //begin
            /*
            PurchHdr.SETRANGE("Buy-from Vendor No.","No.");
            PAGE.RUN(PAGE::"Blanket Purchase Orders",PurchHdr);
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Blanket Orders"(Control 4)".


        //Unsupported feature: Property Deletion (DrillDownPageID) on ""No. of Blanket Orders"(Control 4)".



        //Unsupported feature: Code Insertion on "NoOfOrders(Control 6)".

        //trigger OnDrillDown()
        //var
            //PurchHdr: Record "Purchase Header";
            //PurchaseOrderList: Page "Purchase Order List";
        //begin
            /*
            PurchHdr.SETRANGE("Buy-from Vendor No.","No.");
            PurchaseOrderList.SETTABLEVIEW(PurchHdr);
            PurchaseOrderList.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Orders"(Control 6)".


        //Unsupported feature: Property Deletion (DrillDownPageID) on ""No. of Orders"(Control 6)".



        //Unsupported feature: Code Insertion on "NoOfInvoices(Control 8)".

        //trigger OnDrillDown()
        //var
            //PurchHdr: Record "Purchase Header";
            //PurchaseInvoices: Page "Purchase Invoices";
        //begin
            /*
            PurchHdr.SETRANGE("Buy-from Vendor No.","No.");
            PurchaseInvoices.SETTABLEVIEW(PurchHdr);
            PurchaseInvoices.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Invoices"(Control 8)".


        //Unsupported feature: Property Deletion (DrillDownPageID) on ""No. of Invoices"(Control 8)".



        //Unsupported feature: Code Insertion on "NoOfReturnOrders(Control 10)".

        //trigger OnDrillDown()
        //var
            //PurchHdr: Record "Purchase Header";
            //PurchaseReturnOrderList: Page "Purchase Return Order List";
        //begin
            /*
            PurchHdr.SETRANGE("Buy-from Vendor No.","No.");
            PurchaseReturnOrderList.SETTABLEVIEW(PurchHdr);
            PurchaseReturnOrderList.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Return Orders"(Control 10)".


        //Unsupported feature: Property Deletion (DrillDownPageID) on ""No. of Return Orders"(Control 10)".



        //Unsupported feature: Code Insertion on "NoOfCreditMemos(Control 12)".

        //trigger OnDrillDown()
        //var
            //PurchHdr: Record "Purchase Header";
            //PurchaseCreditMemos: Page "Purchase Credit Memos";
        //begin
            /*
            PurchHdr.SETRANGE("Buy-from Vendor No.","No.");
            PurchaseCreditMemos.SETTABLEVIEW(PurchHdr);
            PurchaseCreditMemos.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Credit Memos"(Control 12)".


        //Unsupported feature: Property Deletion (DrillDownPageID) on ""No. of Credit Memos"(Control 12)".



        //Unsupported feature: Code Insertion on "NoOfPostedReturnShipments(Control 14)".

        //trigger OnDrillDown()
        //var
            //PurchReturnShptList: Page "Posted Return Shipments";
            //PurchReturnShptHdr: Record "Return Shipment Header";
        //begin
            /*
            PurchReturnShptHdr.SETRANGE("Buy-from Vendor No.","No.");
            PurchReturnShptList.SETTABLEVIEW(PurchReturnShptHdr);
            PurchReturnShptList.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Pstd. Return Shipments"(Control 14)".



        //Unsupported feature: Code Insertion on "NoOfPostedReceipts(Control 16)".

        //trigger OnDrillDown()
        //var
            //PurchReceiptList: Page "Posted Purchase Receipts";
            //PurchReceiptHdr: Record "Purch. Rcpt. Header";
        //begin
            /*
            PurchReceiptHdr.SETRANGE("Buy-from Vendor No.","No.");
            PurchReceiptList.SETTABLEVIEW(PurchReceiptHdr);
            PurchReceiptList.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Pstd. Receipts"(Control 16)".



        //Unsupported feature: Code Insertion on "NoOfPostedInvoices(Control 18)".

        //trigger OnDrillDown()
        //var
            //PurchInvList: Page "Posted Purchase Invoices";
            //PurchInvHdr: Record "Purch. Inv. Header";
        //begin
            /*
            PurchInvHdr.SETRANGE("Buy-from Vendor No.","No.");
            PurchInvList.SETTABLEVIEW(PurchInvHdr);
            PurchInvList.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Pstd. Invoices"(Control 18)".



        //Unsupported feature: Code Insertion on "NoOfPostedCreditMemos(Control 20)".

        //trigger OnDrillDown()
        //var
            //PurchCrMemoList: Page "Posted Purchase Credit Memos";
            //PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        //begin
            /*
            PurchCrMemoHdr.SETRANGE("Buy-from Vendor No.","No.");
            PurchCrMemoList.SETTABLEVIEW(PurchCrMemoHdr);
            PurchCrMemoList.RUN;
            */
        //end;

        //Unsupported feature: Property Deletion (ToolTipML) on ""No. of Pstd. Credit Memos"(Control 20)".

        modify(NoOfIncomingDocuments)
        {
            Visible = false;
        }
        modify(Control1)
        {
            Visible = false;
        }
        modify(CueQuotes)
        {
            Visible = false;
        }
        modify(CueBlanketOrders)
        {
            Visible = false;
        }
        modify(CueOrders)
        {
            Visible = false;
        }
        modify(CueInvoices)
        {
            Visible = false;
        }
        modify(CueReturnOrders)
        {
            Visible = false;
        }
        modify(CueCreditMemos)
        {
            Visible = false;
        }
        modify(CuePostedRetShip)
        {
            Visible = false;
        }
        modify(CuePostedReceipts)
        {
            Visible = false;
        }
        modify(CuePostedInvoices)
        {
            Visible = false;
        }
        modify(CuePostedCreditMemos)
        {
            Visible = false;
        }
        modify(CueIncomingDocuments)
        {
            Visible = false;
        }
    }

    var
        NoOfQuotes: Integer;
        NoOfBlanketOrders: Integer;
        NoOfOrders: Integer;
        NoOfInvoices: Integer;
        NoOfReturnOrders: Integer;
        NoOfCreditMemos: Integer;
        NoOfPostedReturnShipments: Integer;
        NoOfPostedReceipts: Integer;
        NoOfPostedInvoices: Integer;
        NoOfPostedCreditMemos: Integer;


    //Unsupported feature: Code Insertion on "OnAfterGetRecord".

    //trigger OnAfterGetRecord()
    //begin
        /*
        CalcNoOfBuyRecords;
        */
    //end;


    //Unsupported feature: Code Insertion on "OnFindRecord".

    //trigger OnFindRecord()
    //Parameters and return type have not been exported.
    //begin
        /*
        NoOfQuotes := 0;
        NoOfBlanketOrders := 0;
        NoOfOrders := 0;
        NoOfInvoices := 0;
        NoOfReturnOrders := 0;
        NoOfCreditMemos := 0;
        NoOfPostedReturnShipments := 0;
        NoOfPostedReceipts := 0;
        NoOfPostedInvoices := 0;
        NoOfPostedCreditMemos := 0;

        EXIT(FIND(Which));
        */
    //end;


    //Unsupported feature: Code Modification on "OnOpenPage".

    //trigger OnOpenPage()
    //>>>> ORIGINAL CODE:
    //begin
        /*
        RegularFastTabVisible := ClientTypeManagement.GetCurrentClientType = CLIENTTYPE::Windows;
        CuesVisible := (NOT RegularFastTabVisible) OR OfficeManagement.IsAvailable;
        */
    //end;
    //>>>> MODIFIED CODE:
    //begin
        /*
        CalcNoOfBuyRecords;
        */
    //end;

    local procedure CalcNoOfBuyRecords()
    var
        PurchHeader: Record "Purchase Header";
        PurchReturnShptHeader: Record "Return Shipment Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        PurchReceiptHeader: Record "Purch. Rcpt. Header";
    begin
        PurchHeader.Reset;
        PurchHeader.SetRange("Document Type",PurchHeader."document type"::Quote);
        PurchHeader.SetRange("Buy-from Vendor No.",Rec."No.");
        NoOfQuotes := PurchHeader.Count;

        PurchHeader.Reset;
        PurchHeader.SetRange("Document Type",PurchHeader."document type"::"Blanket Order");
        PurchHeader.SetRange("Buy-from Vendor No.",Rec."No.");
        NoOfBlanketOrders := PurchHeader.Count;

        PurchHeader.Reset;
        PurchHeader.SetRange("Document Type",PurchHeader."document type"::Order);
        PurchHeader.SetRange("Buy-from Vendor No.",Rec."No.");
        NoOfOrders := PurchHeader.Count;

        PurchHeader.Reset;
        PurchHeader.SetRange("Document Type",PurchHeader."document type"::"Return Order");
        PurchHeader.SetRange("Buy-from Vendor No.",Rec."No.");
        NoOfReturnOrders := PurchHeader.Count;

        PurchHeader.Reset;
        PurchHeader.SetRange("Document Type",PurchHeader."document type"::Invoice);
        PurchHeader.SetRange("Buy-from Vendor No.",Rec."No.");
        NoOfInvoices := PurchHeader.Count;

        PurchHeader.Reset;
        PurchHeader.SetRange("Document Type",PurchHeader."document type"::"Credit Memo");
        PurchHeader.SetRange("Buy-from Vendor No.",Rec."No.");
        NoOfCreditMemos := PurchHeader.Count;

        PurchReturnShptHeader.Reset;
        PurchReturnShptHeader.SetRange("Buy-from Vendor No.",Rec."No.");
        NoOfPostedReturnShipments := PurchReturnShptHeader.Count;

        PurchInvHeader.Reset;
        PurchInvHeader.SetRange("Buy-from Vendor No.",Rec."No.");
        NoOfPostedInvoices := PurchInvHeader.Count;

        PurchCrMemoHeader.Reset;
        PurchCrMemoHeader.SetRange("Buy-from Vendor No.",Rec."No.");
        NoOfPostedCreditMemos := PurchCrMemoHeader.Count;

        PurchReceiptHeader.Reset;
        PurchReceiptHeader.SetRange("Buy-from Vendor No.",Rec."No.");
        NoOfPostedReceipts := PurchReceiptHeader.Count;
    end;
}
