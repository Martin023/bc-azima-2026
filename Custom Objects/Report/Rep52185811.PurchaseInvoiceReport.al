report 52185811 "Purchase Invoice Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Purchase Invoice Report.rdl';

    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            DataItemTableView = where("Document Type" = const(Invoice));
            RequestFilterFields = Status;
            column(ARcdNotInvExVATLCY; "A. Rcd. Not Inv. Ex. VAT (LCY)")
            {
            }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {

            }
            column(Amount; Amount)
            {
            }

            column(AmtRcdNotInvoicedLCY; "Amt. Rcd. Not Invoiced (LCY)")
            {
            }
            column(AppliestoDocNo; "Applies-to Doc. No.")
            {
            }
            column(AppliestoDocType; "Applies-to Doc. Type")
            {
            }
            column(AppliestoID; "Applies-to ID")
            {
            }


            column(AssignedUserID; "Assigned User ID")
            {
            }
            column(BalAccountNo; "Bal. Account No.")
            {
            }
            column(BalAccountType; "Bal. Account Type")
            {
            }
            column(BuyfromAddress; "Buy-from Address")
            {
            }
            column(BuyfromAddress2; "Buy-from Address 2")
            {
            }
            column(BuyfromCity; "Buy-from City")
            {
            }
            column(BuyfromContact; "Buy-from Contact")
            {
            }
            column(BuyfromContactNo; "Buy-from Contact No.")
            {
            }
            column(BuyfromCountryRegionCode; "Buy-from Country/Region Code")
            {
            }
            column(BuyfromCounty; "Buy-from County")
            {
            }
            column(BuyfromICPartnerCode; "Buy-from IC Partner Code")
            {
            }
            column(BuyfromPostCode; "Buy-from Post Code")
            {
            }
            column(BuyfromVendorName; "Buy-from Vendor Name")
            {
            }
            column(BuyfromVendorName2; "Buy-from Vendor Name 2")
            {
            }
            column(BuyfromVendorNo; "Buy-from Vendor No.")
            {
            }
            column(CampaignNo; "Campaign No.")
            {
            }
            column(Cancelled; Cancelled)
            {
            }
            column(CancelledBy; "Cancelled By")
            {
            }
            column(CancelledDate; "Cancelled Date")
            {
            }
            column(CaseNo; "Case No")
            {
            }
            column(Comment; Comment)
            {
            }
            column(CompletelyReceived; "Completely Received")
            {
            }
            column(CompressPrepayment; "Compress Prepayment")
            {
            }
            column(ContractNo; "Contract No.")
            {
            }
            column(ContractRefNo; "Contract Ref No")
            {
            }
            column(Copied; Copied)
            {
            }
            column(Correction; Correction)
            {
            }
            column(CreditorNo; "Creditor No.")
            {
            }
            column(CurrencyCode; "Currency Code")
            {
            }
            column(CurrencyFactor; "Currency Factor")
            {
            }
            column(DebitNote; "Debit Note")
            {
            }
            column(DimensionSetID; "Dimension Set ID")
            {
            }
            column(DocNoOccurrence; "Doc. No. Occurrence")
            {
            }
            column(DocApprovalType; DocApprovalType)
            {
            }
            column(DocumentDate; "Document Date")
            {
            }
            column(DocumentType; "Document Type")
            {
            }
            column(DueDate; "Due Date")
            {
            }
            column(EntryPoint; "Entry Point")
            {
            }
            column(ExpectedReceiptDate; "Expected Receipt Date")
            {
            }
            column(FormatRegion; "Format Region")
            {
            }
            column(FrozenBy; "Frozen By")
            {
            }
            column(GenBusPostingGroup; "Gen. Bus. Posting Group")
            {
            }
            column(ICDirection; "IC Direction")
            {
            }
            column(ICReferenceDocumentNo; "IC Reference Document No.")
            {
            }
            column(ICStatus; "IC Status")
            {
            }
            column(InboundWhseHandlingTime; "Inbound Whse. Handling Time")
            {
            }
            column(IncomingDocumentEntryNo; "Incoming Document Entry No.")
            {
            }
            column(Invoice; Invoice)
            {
            }
            column(InvoiceBasis; "Invoice Basis")
            {
            }
            column(InvoiceDiscCode; "Invoice Disc. Code")
            {
            }
            column(InvoiceDiscountAmount; "Invoice Discount Amount")
            {
            }
            column(InvoiceDiscountCalculation; "Invoice Discount Calculation")
            {
            }
            column(InvoiceDiscountValue; "Invoice Discount Value")
            {
            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(InvoiceReceivedDate; "Invoice Received Date")
            {
            }
            column(JobQueueEntryID; "Job Queue Entry ID")
            {
            }
            column(JobQueueStatus; "Job Queue Status")
            {
            }
            column(JournalTemplName; "Journal Templ. Name")
            {
            }
            column(LanguageCode; "Language Code")
            {
            }
            column(LastPostingNo; "Last Posting No.")
            {
            }
            column(LastPrepaymentNo; "Last Prepayment No.")
            {
            }
            column(LastPrepmtCrMemoNo; "Last Prepmt. Cr. Memo No.")
            {
            }
            column(LastReceivingNo; "Last Receiving No.")
            {
            }
            column(LastReturnShipmentNo; "Last Return Shipment No.")
            {
            }
            column(LeadTimeCalculation; "Lead Time Calculation")
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            column(No; "No.")
            {
            }
            column(NoPrinted; "No. Printed")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(NoofArchivedVersions; "No. of Archived Versions")
            {
            }
            column(OnHold; "On Hold")
            {
            }
            column(OrderAddressCode; "Order Address Code")
            {
            }
            column(OrderClass; "Order Class")
            {
            }
            column(OrderDate; "Order Date")
            {
            }
            column(OrderPostingStatus; "Order Posting Status")
            {
            }
            column(POBoxNumber; "P.O.Box Number")
            {
            }
            column(PartiallyInvoiced; "Partially Invoiced")
            {
            }
            column(PaytoAddress; "Pay-to Address")
            {
            }
            column(PaytoAddress2; "Pay-to Address 2")
            {
            }
            column(PaytoCity; "Pay-to City")
            {
            }
            column(PaytoContact; "Pay-to Contact")
            {
            }
            column(PaytoContactNo; "Pay-to Contact No.")
            {
            }
            column(PaytoCountryRegionCode; "Pay-to Country/Region Code")
            {
            }
            column(PaytoCounty; "Pay-to County")
            {
            }
            column(PaytoICPartnerCode; "Pay-to IC Partner Code")
            {
            }
            column(PaytoName; "Pay-to Name")
            {
            }
            column(PaytoName2; "Pay-to Name 2")
            {
            }
            column(PaytoPostCode; "Pay-to Post Code")
            {
            }
            column(PaytoVendorNo; "Pay-to Vendor No.")
            {
            }
            column(PaymentDiscount; "Payment Discount %")
            {
            }
            column(PaymentMethodCode; "Payment Method Code")
            {
            }
            column(PaymentReference; "Payment Reference")
            {
            }
            column(PaymentTermsCode; "Payment Terms Code")
            {
            }
            column(PendingApprovals; "Pending Approvals")
            {
            }
            column(PhysicalAddress; "Physical Address.")
            {
            }
            column(PmtDiscountDate; "Pmt. Discount Date")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(PostingDescription; "Posting Description")
            {
            }
            column(PostingNo; "Posting No.")
            {
            }
            column(PostingNoSeries; "Posting No. Series")
            {
            }
            column(PostingfromWhseRef; "Posting from Whse. Ref.")
            {
            }
            column(Prepayment; "Prepayment %")
            {
            }
            column(PrepaymentDueDate; "Prepayment Due Date")
            {
            }
            column(PrepaymentNo; "Prepayment No.")
            {
            }
            column(PrepaymentNoSeries; "Prepayment No. Series")
            {
            }
            column(PrepmtCrMemoNo; "Prepmt. Cr. Memo No.")
            {
            }
            column(PrepmtCrMemoNoSeries; "Prepmt. Cr. Memo No. Series")
            {
            }
            column(PrepmtPaymentDiscount; "Prepmt. Payment Discount %")
            {
            }
            column(PrepmtPaymentTermsCode; "Prepmt. Payment Terms Code")
            {
            }
            column(PrepmtPmtDiscountDate; "Prepmt. Pmt. Discount Date")
            {
            }
            column(PrepmtPostingDescription; "Prepmt. Posting Description")
            {
            }
            column(PriceCalculationMethod; "Price Calculation Method")
            {
            }
            column(PricesIncludingVAT; "Prices Including VAT")
            {
            }
            column(PrintPostedDocuments; "Print Posted Documents")
            {
            }
            column(ProcurementCategoryCode; "Procurement Category Code")
            {
            }
            column(PromisedReceiptDate; "Promised Receipt Date")
            {
            }
            column(PurchaserCode; "Purchaser Code")
            {
            }
            column(QuotationDate; "Quotation Date")
            {
            }
            column(QuoteNo; "Quote No.")
            {
            }
            column(ReasonCode; "Reason Code")
            {
            }
            column(RecalculateInvoiceDisc; "Recalculate Invoice Disc.")
            {
            }
            column(Receive; Receive)
            {
            }
            column(ReceivingNo; "Receiving No.")
            {
            }
            column(ReceivingNoSeries; "Receiving No. Series")
            {
            }
            column(RemittoCode; "Remit-to Code")
            {
            }
            column(RequestedReceiptDate; "Requested Receipt Date")
            {
            }
            column(ResponsibilityCenter; "Responsibility Center")
            {
            }
            column(ReturnShipmentNo; "Return Shipment No.")
            {
            }
            column(ReturnShipmentNoSeries; "Return Shipment No. Series")
            {
            }
            column(RunningBalance; "Running Balance")
            {
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(SendICDocument; "Send IC Document")
            {
            }
            column(Ship; Ship)
            {
            }
            column(ShiptoAddress; "Ship-to Address")
            {
            }
            column(ShiptoAddress2; "Ship-to Address 2")
            {
            }
            column(ShiptoCity; "Ship-to City")
            {
            }
            column(ShiptoCode; "Ship-to Code")
            {
            }
            column(ShiptoContact; "Ship-to Contact")
            {
            }
            column(ShiptoCountryRegionCode; "Ship-to Country/Region Code")
            {
            }
            column(ShiptoCounty; "Ship-to County")
            {
            }
            column(ShiptoName; "Ship-to Name")
            {
            }
            column(ShiptoName2; "Ship-to Name 2")
            {
            }
            column(ShiptoPostCode; "Ship-to Post Code")
            {
            }
            column(ShipmentMethodCode; "Shipment Method Code")
            {
            }
            column(ShortcutDimension1Code; "Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code; "Shortcut Dimension 2 Code")
            {
            }
            column(Status; Status)
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(TaxAreaCode; "Tax Area Code")
            {
            }
            column(TaxLiable; "Tax Liable")
            {
            }
            column(TransactionSpecification; "Transaction Specification")
            {
            }
            column(TransactionType; "Transaction Type")
            {
            }
            column(TransportMethod; "Transport Method")
            {
            }
            column(UnFrozenBy; "UnFrozen By")
            {
            }
            column(UserID; "User ID")
            {
            }
            column(VATBaseDiscount; "VAT Base Discount %")
            {
            }
            column(VATBusPostingGroup; "VAT Bus. Posting Group")
            {
            }
            column(VATCountryRegionCode; "VAT Country/Region Code")
            {
            }
            column(VATRegistrationNo; "VAT Registration No.")
            {
            }
            column(VATReportingDate; "VAT Reporting Date")
            {
            }
            column(VendorAuthorizationNo; "Vendor Authorization No.")
            {
            }
            column(VendorCrMemoNo; "Vendor Cr. Memo No.")
            {
            }
            column(TotalAmountInclVAT; TotalAmountInclVAT)
            {

            }
            column(VendorInvoiceNo; "Vendor Invoice No.")
            {
            }
            column(VendorOrderNo; "Vendor Order No.")
            {
            }
            column(VendorPostingGroup; "Vendor Posting Group")
            {
            }
            column(VendorShipmentNo; "Vendor Shipment No.")
            {
            }
            column(YourReference; "Your Reference")
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(Type; Type)
                {

                }
                column(No_; "No.")
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Unit_Cost; "Unit Cost")
                {

                }
                column(Direct_Unit_Cost; "Direct Unit Cost")
                {

                }
                column(Line_Amount; "Line Amount")
                {

                }
                column(Amount_Including_VAT; "Amount Including VAT")
                {

                }

            }
            trigger OnAfterGetRecord()
            var
                TempPrepmtPurchLine: Record "Purchase Line" temporary;
                TempPurchLine: Record "Purchase Line" temporary;
                d: record 122;
            begin
                Clear(TempPurchaseLine);
                Clear(PurchPost);
                TempPurchaseLine.DeleteAll();
                TempVATAmountLine.DeleteAll();
                PurchPost.GetPurchLines(PurchaseHeader, TempPurchaseLine, 0);
                TempPurchaseLine.CalcVATAmountLines(0, PurchaseHeader, TempPurchaseLine, TempVATAmountLine);
                TempPurchaseLine.UpdateVATOnLines(0, PurchaseHeader, TempPurchaseLine, TempVATAmountLine);
                VATAmount := TempVATAmountLine.GetTotalVATAmount();
                VATBaseAmount := TempVATAmountLine.GetTotalVATBase();
                VATDiscountAmount :=
                  TempVATAmountLine.GetTotalVATDiscount(PurchaseHeader."Currency Code", PurchaseHeader."Prices Including VAT");
                TotalAmountInclVAT := TempVATAmountLine.GetTotalAmountInclVAT();

                TempPrepmtInvLineBuffer.DeleteAll();
                PurchPostPrepmt.GetPurchLines(PurchaseHeader, 0, TempPrepmtPurchLine);
                if not TempPrepmtPurchLine.IsEmpty() then begin
                    PurchPostPrepmt.GetPurchLinesToDeduct(PurchaseHeader, TempPurchLine);
                    if not TempPurchLine.IsEmpty() then
                        PurchPostPrepmt.CalcVATAmountLines(PurchaseHeader, TempPurchLine, TempPrepmtVATAmountLineDeduct, 1);
                end;
                PurchPostPrepmt.CalcVATAmountLines(PurchaseHeader, TempPrepmtPurchLine, TempPrepmtVATAmountLine, 0);
                TempPrepmtVATAmountLine.DeductVATAmountLine(TempPrepmtVATAmountLineDeduct);
                PurchPostPrepmt.UpdateVATOnLines(PurchaseHeader, TempPrepmtPurchLine, TempPrepmtVATAmountLine, 0);
                PurchPostPrepmt.BuildInvLineBuffer(PurchaseHeader, TempPrepmtPurchLine, 0, TempPrepmtInvLineBuffer);
                PrepmtVATAmount := TempPrepmtVATAmountLine.GetTotalVATAmount();
                PrepmtVATBaseAmount := TempPrepmtVATAmountLine.GetTotalVATBase();
                PrepmtTotalAmountInclVAT := TempPrepmtVATAmountLine.GetTotalAmountInclVAT();

                // if Number > 1 then
                //     CopyText := FormatDocument.GetCOPYText();
                // OutputNo := OutputNo + 1;

                TotalSubTotal := 0;
                TotalAmount := 0;
            end;
        }

    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Text004: Label 'Order %1', Comment = '%1 = Document No.';
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        TempPrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        TempPrepmtVATAmountLineDeduct: Record "VAT Amount Line" temporary;
        TempPurchaseLine: Record "Purchase Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        PrepmtDimSetEntry: Record "Dimension Set Entry";
        TempPrepmtInvLineBuffer: Record "Prepayment Inv. Line Buffer" temporary;
        RespCenter: Record "Responsibility Center";
        CurrExchRate: Record "Currency Exchange Rate";
        PurchSetup: Record "Purchases & Payables Setup";
        BuyFromContact: Record Contact;
        PayToContact: Record Contact;
        // Language: Codeunit Language;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        PurchPost: Codeunit "Purch.-Post";
        ArchiveManagement: Codeunit ArchiveManagement;
        SegManagement: Codeunit SegManagement;
        PurchPostPrepmt: Codeunit "Purchase-Post Prepayments";
        VendAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        BuyFromAddr: array[8] of Text[100];
        PurchaserText: Text[50];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        MoreLines: Boolean;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        Continue: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        Text007: Label 'VAT Amount Specification in ';
        Text008: Label 'Local Currency';
        Text009: Label 'Exchange rate: %1/%2';
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtLineAmount: Decimal;
        PricesInclVATtxt: Text[30];
        AllowInvDisctxt: Text[30];
        ArchiveDocumentEnable: Boolean;
        LogInteractionEnable: Boolean;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.';
        CompanyInfoVATRegNoCaptionLbl: Label 'VAT Registration No.';
        CompanyInfoGiroNoCaptionLbl: Label 'Giro No.';
        CompanyInfoBankNameCaptionLbl: Label 'Bank';
        CompanyInfoBankAccNoCaptionLbl: Label 'Account No.';
        OrderNoCaptionLbl: Label 'Order No.';
        PageCaptionLbl: Label 'Page';
        DocumentDateCaptionLbl: Label 'Document Date';
        HdrDimCaptionLbl: Label 'Header Dimensions';
        DirectUniCostCaptionLbl: Label 'Direct Unit Cost';
        PurchLineLineDiscCaptionLbl: Label 'Discount %';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT';
        LineDimCaptionLbl: Label 'Line Dimensions';
        PaymentDetailsCaptionLbl: Label 'Payment Details';
        VendNoCaptionLbl: Label 'Vendor No.';
        ShiptoAddressCaptionLbl: Label 'Ship-to Address';
        PrepmtInvBuDescCaptionLbl: Label 'Description';
        PrepmtInvBufGLAccNoCaptionLbl: Label 'G/L Account No.';
        PrepaymentSpecCaptionLbl: Label 'Prepayment Specification';
        PrepymtVATAmtSpecCaptionLbl: Label 'Prepayment VAT Amount Specification';
        AmountCaptionLbl: Label 'Amount';
        PurchLineInvDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        VATAmtLineVATCaptionLbl: Label 'VAT %';
        VATAmtLineVATAmtCaptionLbl: Label 'VAT Amount';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification';
        VATIdentifierCaptionLbl: Label 'VAT Identifier';
        VATAmtLineInvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        VATAmtLineLineAmtCaptionLbl: Label 'Line Amount';
        VALVATBaseLCYCaptionLbl: Label 'VAT Base';
        TotalCaptionLbl: Label 'Total';
        PaymentTermsDescCaptionLbl: Label 'Payment Terms';
        ShipmentMethodDescCaptionLbl: Label 'Shipment Method';
        PrepymtTermsDescCaptionLbl: Label 'Prepmt. Payment Terms';
        HomePageCaptionLbl: Label 'Home Page';
        EmailIDCaptionLbl: Label 'Email';
        AllowInvoiceDiscCaptionLbl: Label 'Allow Invoice Discount';
        BuyFromContactPhoneNoLbl: Label 'Buy-from Contact Phone No.';
        BuyFromContactMobilePhoneNoLbl: Label 'Buy-from Contact Mobile Phone No.';
        BuyFromContactEmailLbl: Label 'Buy-from Contact E-Mail';
        PayToContactPhoneNoLbl: Label 'Pay-to Contact Phone No.';
        PayToContactMobilePhoneNoLbl: Label 'Pay-to Contact Mobile Phone No.';
        PayToContactEmailLbl: Label 'Pay-to Contact E-Mail';
        PrepmtLoopLineNo: Integer;
        TotalPrepmtLineAmount: Decimal;


    protected var
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        NoOfCopies: Integer;
        ShowInternalInfo: Boolean;


}
