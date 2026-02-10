// // #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// // Report 52185812 "Purchase Document Test"
// // {
// //     DefaultLayout = RDLC;
// //     RDLCLayout = './bc-azima-2026/Layout/Purchase Document Test.rdl';
// //     Caption = 'Purchase Document Test';

// //     dataset
// //     {
// //         dataitem("Purchase Heade "Purchase Header")
//         {
//             DataItemTableView = where("Document Type" = filter(<> Quote));
//             RequestFilterFields = "Document Type", e","No.";
// //             RequestFilterHeading = 'Purchase Document';
// //             column(ReportForNavId_4458; 4458)
// //             {
// //             }
// //             column(Purchase_Header_Document_Ty pe;"Purchase Header"."Document Type")
// //             {
// //             }
// //             column(Purchase_Header_N o_;"Purchase Header"."No.")
// //             {
// //             }
// //             dataitem(PageCount "Integer")
//             {
//                 DataItemTableView = sorting(Number) where(Number = er=const(1));
// //                 column(ReportForNavId_8098; 8098)
// //                 {
// //                 }
// //                 column(FORMAT_TODAY_0_ 4_;Format(Tod 0, ,0,4))
// //                 {
// //                 }
// //                 column(COMPANYNA ME;COMPANYNAME)
// //                 {
// //                 }
// //                 column(CurrReport_PAGE NO;CurrReport.PageNo)
// //                 {
// //                 }
// //                 column(USER ID;UserId)
// //                 {
// //                 }
// //                 column(STRSUBSTNO_Text018_PurchHeaderFilte r_;StrSubstNo(Text0 18,PurchHeaderFilter))
// //                 {
// //                 }
// //                 column(PurchHeaderFilt er;PurchHeaderFilter)
// //                 {
// //                 }
// //                 column(ReceiveInvoiceTe xt;ReceiveInvoiceText)
// //                 {
// //                 }
// //                 column(ShipInvoiceTe xt;ShipInvoiceText)
// //                 {
// //                 }
// //                 column(Purchase_Header___Sell_to_Customer_No __;"Purchase Header"."Sell-to Customer No.")
// //                 {
// //                 }
// //                 column(ShipToAddr_ 1_;ShipToAddr[1])
// //                 {
// //                 }
// //                 column(ShipToAddr_ 2_;ShipToAddr[2])
// //                 {
// //                 }
// //                 column(ShipToAddr_ 3_;ShipToAddr[3])
// //                 {
// //                 }
// //                 column(ShipToAddr_ 4_;ShipToAddr[4])
// //                 {
// //                 }
// //                 column(ShipToAddr_ 5_;ShipToAddr[5])
// //                 {
// //                 }
// //                 column(ShipToAddr_ 6_;ShipToAddr[6])
// //                 {
// //                 }
// //                 column(ShipToAddr_ 7_;ShipToAddr[7])
// //                 {
// //                 }
// //                 column(ShipToAddr_ 8_;ShipToAddr[8])
// //                 {
// //                 }
// //                 column(FORMAT__Purchase_Header___Document_Type____________Purchase_Header___No __;Format("Purchase Header"."Document Type") + ' ' + "Purchase Header"."No.")
// //                 {
// //                 }
// //                 column(BuyFromAddr_ 8_;BuyFromAddr[8])
// //                 {
// //                 }
// //                 column(BuyFromAddr_ 7_;BuyFromAddr[7])
// //                 {
// //                 }
// //                 column(BuyFromAddr_ 6_;BuyFromAddr[6])
// //                 {
// //                 }
// //                 column(BuyFromAddr_ 5_;BuyFromAddr[5])
// //                 {
// //                 }
// //                 column(BuyFromAddr_ 4_;BuyFromAddr[4])
// //                 {
// //                 }
// //                 column(BuyFromAddr_ 3_;BuyFromAddr[3])
// //                 {
// //                 }
// //                 column(BuyFromAddr_ 2_;BuyFromAddr[2])
// //                 {
// //                 }
// //                 column(BuyFromAddr_ 1_;BuyFromAddr[1])
// //                 {
// //                 }
// //                 column(Purchase_Header___Buy_from_Vendor_No __;"Purchase Header"."Buy-from Vendor No.")
// //                 {
// //                 }
// //                 column(Purchase_Header___Document_Typ e_;Format("Purchase Header"."Document Typ 0, ,0,2))
// //                 {
// //                 }
// //                 column(Purchase_Header___VAT_Base_Discount_ __;"Purchase Header"."VAT Base Discount %")
// //                 {
// //                 }
// //                 column(PricesInclVATt xt;PricesInclVATtxt)
// //                 {
// //                 }
// //                 column(ShowItemChargeAssg nt;ShowItemChargeAssgnt)
// //                 {
// //                 }
// //                 column(PayToAddr_ 1_;PayToAddr[1])
// //                 {
// //                 }
// //                 column(PayToAddr_ 2_;PayToAddr[2])
// //                 {
// //                 }
// //                 column(PayToAddr_ 3_;PayToAddr[3])
// //                 {
// //                 }
// //                 column(PayToAddr_ 4_;PayToAddr[4])
// //                 {
// //                 }
// //                 column(PayToAddr_ 5_;PayToAddr[5])
// //                 {
// //                 }
// //                 column(PayToAddr_ 6_;PayToAddr[6])
// //                 {
// //                 }
// //                 column(PayToAddr_ 7_;PayToAddr[7])
// //                 {
// //                 }
// //                 column(PayToAddr_ 8_;PayToAddr[8])
// //                 {
// //                 }
// //                 column(Purchase_Header___Pay_to_Vendor_No __;"Purchase Header"."Pay-to Vendor No.")
// //                 {
// //                 }
// //                 column(Purchase_Header___Purchaser_Cod e_;"Purchase Header"."Purchaser Code")
// //                 {
// //                 }
// //                 column(Purchase_Header___Your_Referenc e_;"Purchase Header"."Your Reference")
// //                 {
// //                 }
// //                 column(Purchase_Header___Vendor_Posting_Grou p_;"Purchase Header"."Vendor Posting Group")
// //                 {
// //                 }
// //                 column(Purchase_Header___Posting_Dat e_;Format("Purchase Header"."Posting Date"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Document_Dat e_;Format("Purchase Header"."Document Date"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Prices_Including_VA T_;"Purchase Header"."Prices Including VAT")
// //                 {
// //                 }
// //                 column(Purchase_Header___Payment_Terms_Cod e_;"Purchase Header"."Payment Terms Code")
// //                 {
// //                 }
// //                 column(Purchase_Header___Payment_Discount_ __;"Purchase Header"."Payment Discount %")
// //                 {
// //                 }
// //                 column(Purchase_Header___Due_Dat e_;Format("Purchase Header"."Due Date"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Pmt__Discount_Dat e_;Format("Purchase Header"."Pmt. Discount Date"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Shipment_Method_Cod e_;"Purchase Header"."Shipment Method Code")
// //                 {
// //                 }
// //                 column(Purchase_Header___Payment_Method_Cod e_;"Purchase Header"."Payment Method Code")
// //                 {
// //                 }
// //                 column(Purchase_Header___Vendor_Order_No __;"Purchase Header"."Vendor Order No.")
// //                 {
// //                 }
// //                 column(Purchase_Header___Vendor_Shipment_No __;"Purchase Header"."Vendor Delivery Note No.")
// //                 {
// //                 }
// //                 column(Purchase_Header___Vendor_Invoice_No __;"Purchase Header"."Vendor Invoice No.")
// //                 {
// //                 }
// //                 column(Purchase_Header___Vendor_Posting_Group__Control1 04;"Purchase Header"."Vendor Posting Group")
// //                 {
// //                 }
// //                 column(Purchase_Header___Posting_Date__Control1 06;Format("Purchase Header"."Posting Date"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Document_Date__Control1 07;Format("Purchase Header"."Document Date"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Order_Dat e_;Format("Purchase Header"."Order Date"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Expected_Receipt_Dat e_;Format("Purchase Header"."Expected Receipt Date"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Prices_Including_VAT__Control2 12;"Purchase Header"."Prices Including VAT")
// //                 {
// //                 }
// //                 column(Purchase_Header___Payment_Discount____Control 14;"Purchase Header"."Payment Discount %")
// //                 {
// //                 }
// //                 column(Purchase_Header___Payment_Terms_Code__Control 18;"Purchase Header"."Payment Terms Code")
// //                 {
// //                 }
// //                 column(Purchase_Header___Due_Date__Control 19;Format("Purchase Header"."Due Date"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Pmt__Discount_Date__Control 22;Format("Purchase Header"."Pmt. Discount Date"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Payment_Method_Code__Control 30;"Purchase Header"."Payment Method Code")
// //                 {
// //                 }
// //                 column(Purchase_Header___Shipment_Method_Code__Control 33;"Purchase Header"."Shipment Method Code")
// //                 {
// //                 }
// //                 column(Purchase_Header___Vendor_Shipment_No___Control 34;"Purchase Header"."Vendor Delivery Note No.")
// //                 {
// //                 }
// //                 column(Purchase_Header___Vendor_Invoice_No___Control 35;"Purchase Header"."Vendor Invoice No.")
// //                 {
// //                 }
// //                 column(Purchase_Header___Vendor_Posting_Group__Control1 10;"Purchase Header"."Vendor Posting Group")
// //                 {
// //                 }
// //                 column(Purchase_Header___Posting_Date__Control1 12;Format("Purchase Header"."Posting Date"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Document_Date__Control1 13;Format("Purchase Header"."Document Date"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Prices_Including_VAT__Control2 14;"Purchase Header"."Prices Including VAT")
// //                 {
// //                 }
// //                 column(Purchase_Header___Vendor_Cr__Memo_No __;"Purchase Header"."Vendor Cr. Memo No.")
// //                 {
// //                 }
// //                 column(Purchase_Header___Applies_to_Doc__Typ e_;"Purchase Header"."Applies-to Doc. Type")
// //                 {
// //                 }
// //                 column(Purchase_Header___Applies_to_Doc__No __;"Purchase Header"."Applies-to Doc. No.")
// //                 {
// //                 }
// //                 column(Purchase_Header___Vendor_Posting_Group__Control1 28;"Purchase Header"."Vendor Posting Group")
// //                 {
// //                 }
// //                 column(Purchase_Header___Posting_Date__Control1 30;Format("Purchase Header"."Posting Date"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Document_Date__Control1 31;Format("Purchase Header"."Document Date"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Prices_Including_VAT__Control2 16;"Purchase Header"."Prices Including VAT")
// //                 {
// //                 }
// //                 column(PageCounter_Numb er;PageCounter.Number)
// //                 {
// //                 }
// //                 column(Purchase_Document___TestCapti on;Purchase_Document___TestCaptionLbl)
// //                 {
// //                 }
// //                 column(CurrReport_PAGENOCapti on;CurrReport_PAGENOCaptionLbl)
// //                 {
// //                 }
// //                 column(Purchase_Header___Sell_to_Customer_No__Capti on;"Purchase Header".FieldCaption("Sell-to Customer No."))
// //                 {
// //                 }
// //                 column(Ship_toCapti on;Ship_toCaptionLbl)
// //                 {
// //                 }
// //                 column(Buy_fromCapti on;Buy_fromCaptionLbl)
// //                 {
// //                 }
// //                 column(Purchase_Header___Buy_from_Vendor_No__Capti on;"Purchase Header".FieldCaption("Buy-from Vendor No."))
// //                 {
// //                 }
// //                 column(Pay_toCapti on;Pay_toCaptionLbl)
// //                 {
// //                 }
// //                 column(Purchase_Header___Pay_to_Vendor_No__Capti on;"Purchase Header".FieldCaption("Pay-to Vendor No."))
// //                 {
// //                 }
// //                 column(Purchase_Header___Purchaser_Code_Capti on;"Purchase Header".FieldCaption("Purchaser Code"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Your_Reference_Capti on;"Purchase Header".FieldCaption("Your Reference"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Vendor_Posting_Group_Capti on;"Purchase Header".FieldCaption("Vendor Posting Group"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Posting_Date_Capti on;Purchase_Header___Posting_Date_CaptionLbl)
// //                 {
// //                 }
// //                 column(Purchase_Header___Document_Date_Capti on;Purchase_Header___Document_Date_CaptionLbl)
// //                 {
// //                 }
// //                 column(Purchase_Header___Prices_Including_VAT_Capti on;"Purchase Header".FieldCaption("Prices Including VAT"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Payment_Terms_Code_Capti on;"Purchase Header".FieldCaption("Payment Terms Code"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Payment_Discount___Capti on;"Purchase Header".FieldCaption("Payment Discount %"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Due_Date_Capti on;Purchase_Header___Due_Date_CaptionLbl)
// //                 {
// //                 }
// //                 column(Purchase_Header___Pmt__Discount_Date_Capti on;Purchase_Header___Pmt__Discount_Date_CaptionLbl)
// //                 {
// //                 }
// //                 column(Purchase_Header___Shipment_Method_Code_Capti on;"Purchase Header".FieldCaption("Shipment Method Code"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Payment_Method_Code_Capti on;"Purchase Header".FieldCaption("Payment Method Code"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Vendor_Order_No__Capti on;"Purchase Header".FieldCaption("Vendor Order No."))
// //                 {
// //                 }
// //                 column(Purchase_Header___Vendor_Shipment_No__Capti on;"Purchase Header".FieldCaption("Vendor Delivery Note No."))
// //                 {
// //                 }
// //                 column(Purchase_Header___Vendor_Invoice_No__Capti on;"Purchase Header".FieldCaption("Vendor Invoice No."))
// //                 {
// //                 }
// //                 column(Purchase_Header___Vendor_Posting_Group__Control104Capti on;"Purchase Header".FieldCaption("Vendor Posting Group"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Posting_Date__Control106Capti on;Purchase_Header___Posting_Date__Control106CaptionLbl)
// //                 {
// //                 }
// //                 column(Purchase_Header___Document_Date__Control107Capti on;Purchase_Header___Document_Date__Control107CaptionLbl)
// //                 {
// //                 }
// //                 column(Purchase_Header___Order_Date_Capti on;Purchase_Header___Order_Date_CaptionLbl)
// //                 {
// //                 }
// //                 column(Purchase_Header___Expected_Receipt_Date_Capti on;Purchase_Header___Expected_Receipt_Date_CaptionLbl)
// //                 {
// //                 }
// //                 column(Purchase_Header___Prices_Including_VAT__Control212Capti on;"Purchase Header".FieldCaption("Prices Including VAT"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Payment_Discount____Control14Capti on;"Purchase Header".FieldCaption("Payment Discount %"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Payment_Terms_Code__Control18Capti on;"Purchase Header".FieldCaption("Payment Terms Code"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Due_Date__Control19Capti on;Purchase_Header___Due_Date__Control19CaptionLbl)
// //                 {
// //                 }
// //                 column(Purchase_Header___Pmt__Discount_Date__Control22Capti on;Purchase_Header___Pmt__Discount_Date__Control22CaptionLbl)
// //                 {
// //                 }
// //                 column(Purchase_Header___Payment_Method_Code__Control30Capti on;"Purchase Header".FieldCaption("Payment Method Code"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Shipment_Method_Code__Control33Capti on;"Purchase Header".FieldCaption("Shipment Method Code"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Vendor_Shipment_No___Control34Capti on;"Purchase Header".FieldCaption("Vendor Delivery Note No."))
// //                 {
// //                 }
// //                 column(Purchase_Header___Vendor_Invoice_No___Control35Capti on;"Purchase Header".FieldCaption("Vendor Invoice No."))
// //                 {
// //                 }
// //                 column(Purchase_Header___Vendor_Posting_Group__Control110Capti on;"Purchase Header".FieldCaption("Vendor Posting Group"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Posting_Date__Control112Capti on;Purchase_Header___Posting_Date__Control112CaptionLbl)
// //                 {
// //                 }
// //                 column(Purchase_Header___Document_Date__Control113Capti on;Purchase_Header___Document_Date__Control113CaptionLbl)
// //                 {
// //                 }
// //                 column(Purchase_Header___Prices_Including_VAT__Control214Capti on;"Purchase Header".FieldCaption("Prices Including VAT"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Vendor_Cr__Memo_No__Capti on;"Purchase Header".FieldCaption("Vendor Cr. Memo No."))
// //                 {
// //                 }
// //                 column(Purchase_Header___Applies_to_Doc__Type_Capti on;"Purchase Header".FieldCaption("Applies-to Doc. Type"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Applies_to_Doc__No__Capti on;"Purchase Header".FieldCaption("Applies-to Doc. No."))
// //                 {
// //                 }
// //                 column(Purchase_Header___Vendor_Posting_Group__Control128Capti on;"Purchase Header".FieldCaption("Vendor Posting Group"))
// //                 {
// //                 }
// //                 column(Purchase_Header___Posting_Date__Control130Capti on;Purchase_Header___Posting_Date__Control130CaptionLbl)
// //                 {
// //                 }
// //                 column(Purchase_Header___Document_Date__Control131Capti on;Purchase_Header___Document_Date__Control131CaptionLbl)
// //                 {
// //                 }
// //                 column(Purchase_Header___Prices_Including_VAT__Control216Capti on;"Purchase Header".FieldCaption("Prices Including VAT"))
// //                 {
// //                 }
// //                 dataitem(DimensionLoo "Integer")
//                 {
//                     DataItemTableView = sorting(Number) where(Number = filter(1 r(1..));
// //                     column(ReportForNavId_7574; 7574)
// //                     {
// //                     }
// //                     column(DimTe xt;DimText)
// //                     {
// //                     }
// //                     column(DimensionLoop1_Numb er;DimensionLoop1.Number)
// //                     {
// //                     }
// //                     column(DimText_Control1 63;DimText)
// //                     {
// //                     }
// //                     column(Header_DimensionsCapti on;Header_DimensionsCaptionLbl)
// //                     {
// //                     }

// //                     trigger OnAfterGetRecord()
// //                     begin
// //                         if DimensionLoop1.Number = 1 then begin
// //                             if not DimSetEntry1.FindSet then
// //                                 CurrReport.Break;
// //                         end else
// //                             if not Continue then
// //                                 CurrReport.Break;
// //                         DimText := '';
// //                         Continue := false;
// //                         repeat
// //                             OldDimText := DimText;
// //                             if DimText = '' then
// //                                 DimText := StrSubstNo('%1 - % 2',DimSetEntry1."Dimension Cod e",DimSetEntry1."Dimension Value Code")
// //                          else
//                                 DimText :=
//                                   StrSubstNo(
//                                     '%1; %2 - %3', DimText, xt,DimSetEntry1."Dimension Cod e",DimSetEntry1."Dimension Value Code");
// //                             if StrLen(DimText) > MaxStrLen(OldDimText) then begin
// //                                 DimText := OldDimText;
// //                                 Continue := true;
// //                              exit;
//   //                           end;
// //                         until DimSetEntry1.Next = 0;
// //                     end;

// //                     trigger OnPreDataItem()
// //                     begin
// //                         if not ShowDim then
// //                             CurrReport.Break;
// //                     end;
// //                 }
// //                 dataitem(HeaderErrorCount er;"Integer")
// //                 {
// //                     DataItemTableView = sorting(Number);
// //                     column(ReportForNavId_3850; 3850)
// //                     {
// //                     }
// //                     column(ErrorText_Numbe r_;ErrorText[HeaderErrorCounter.Number])
// //                     {
// //                     }
// //                     column(HeaderErrorCounter_Numb er;HeaderErrorCounter.Number)
// //                     {
// //                     }
// //                     column(ErrorText_Number_Capti on;ErrorText_Number_CaptionLbl)
// //                     {
// //                     }

// //                     trigger OnPostDataItem()
// //                     begin
// //                         ErrorCounter := 0;
// //                     end;

// //                     trigger OnPreDataItem()
// //                     begin
// //                         HeaderErrorCounter.SetRange(HeaderErrorCounter.Numb 1, ,1,ErrorCounter);
// //                     end;
// //                 }
// //                 dataitem(CopyLo op;"Integer")
// //                 {
// //                     DataItemTableView = sorting(Number);
// //                     MaxIteration = 1;
// //                     column(ReportForNavId_5701; 5701)
// //                     {
// //                     }
// //                     dataitem("Purchase Lin "Purchase Line")
//                     {
//                         DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
//                         DataItemLinkReference = "Purchase Header";
//                         DataItemTableView = sorting("Document Type", "Document No.", .","Line No.");
// //                         column(ReportForNavId_6547; 6547)
// //                         {
// //                         }
// //                         column(Purchase_Line_Document_Ty pe;"Purchase Line"."Document Type")
// //                         {
// //                         }
// //                         column(Purchase_Line_Document_N o_;"Purchase Line"."Document No.")
// //                         {
// //                         }
// //                         column(Purchase_Line_Line_N o_;"Purchase Line"."Line No.")
// //                         {
// //                         }

// //                         trigger OnPreDataItem()
// //                         begin
// //                             if "Purchase Line".Find('+') then
// //                                 OrigMaxLineNo := "Purchase Line"."Line No.";
// //                             CurrReport.Break;
// //                         end;
// //                     }
// //                     dataitem(RoundLo op;"Integer")
// //                     {
// //                         DataItemTableView = sorting(Number);
// //                         column(ReportForNavId_7551; 7551)
// //                         {
// //                         }
// //                         column(QtyToHandleCapti on;QtyToHandleCaption)
// //                         {
// //                         }
// //                         column(Purchase_Line__Ty pe;"Purchase Line".Type)
// //                         {
// //                         }
// //                         column(Purchase_Line___Line_Amoun t_;"Purchase Line"."Line Amount")
// //                         {
// //                             AutoFormatExpression = "Purchase Line"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(Purchase_Line___VAT_Identifie r_;"Purchase Line"."VAT Identifier")
// //                         {
// //                         }
// //                         column(Purchase_Line___Allow_Invoice_Disc __;"Purchase Line"."Allow Invoice Disc.")
// //                         {
// //                         }
// //                         column(Purchase_Line___Line_Discount_ __;"Purchase Line"."Line Discount %")
// //                         {
// //                         }
// //                         column(Purchase_Line___Direct_Unit_Cos t_;"Purchase Line"."Direct Unit Cost")
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 2;
// //                         }
// //                         column(Purchase_Line___Qty__to_Invoic e_;"Purchase Line"."Qty. to Invoice")
// //                         {
// //                         }
// //                         column(QtyToHand le;QtyToHandle)
// //                         {
// //                             DecimalPlaces  :  0:5;
// //                         }
// //                         column(Purchase_Line__Quanti ty;"Purchase Line".Quantity)
// //                         {
// //                         }
// //                         column(Purchase_Line__Descripti on;"Purchase Line".Description)
// //                         {
// //                         }
// //                         column(Purchase_Line___No __;"Purchase Line"."No.")
// //                         {
// //                         }
// //                         column(Purchase_Line___Line_No __;"Purchase Line"."Line No.")
// //                         {
// //                         }
// //                         column(Purchase_Line___Inv__Discount_Amoun t_;"Purchase Line"."Inv. Discount Amount")
// //                         {
// //                         }
// //                         column(AllowInvDisct xt;AllowInvDisctxt)
// //                         {
// //                         }
// //                         column(TempPurchLine__Inv__Discount_Amoun t_;-TempPurchLine."Inv. Discount Amount")
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(TempPurchLine__Line_Amoun t_;TempPurchLine."Line Amount")
// //                         {
// //                             AutoFormatExpression = "Purchase Line"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(TotalTe xt;TotalText)
// //                         {
// //                         }
// //                         column(TempPurchLine__Line_Amount____TempPurchLine__Inv__Discount_Amoun t_;TempPurchLine."Line Amount" - TempPurchLine."Inv. Discount Amount")
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(TotalInclVATTe xt;TotalInclVATText)
// //                         {
// //                         }
// //                         column(VATAmountLine_VATAmountTe xt;VATAmountLine.VATAmountText)
// //                         {
// //                         }
// //                         column(TotalExclVATTe xt;TotalExclVATText)
// //                         {
// //                         }
// //                         column(TempPurchLine__Line_Amount____TempPurchLine__Inv__Discount_Amount____VATAmou nt;TempPurchLine."Line Amount" - TempPurchLine."Inv. Discount Amount" + VATAmount)
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VATAmou nt;VATAmount)
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(TempPurchLine__Line_Amount____TempPurchLine__Inv__Discount_Amount__Control2 24;TempPurchLine."Line Amount" - TempPurchLine."Inv. Discount Amount")
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(SumInvDiscountAmou nt;SumInvDiscountAmount)
// //                         {
// //                         }
// //                         column(SumLineAmou nt;SumLineAmount)
// //                         {
// //                         }
// //                         column(VATDiscountAmou nt;-VATDiscountAmount)
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(TotalInclVATText_Control1 55;TotalInclVATText)
// //                         {
// //                         }
// //                         column(VATAmountLine_VATAmountText_Control1 51;VATAmountLine.VATAmountText)
// //                         {
// //                         }
// //                         column(TotalExclVATText_Control1 53;TotalExclVATText)
// //                         {
// //                         }
// //                         column(VATBaseAmou nt;VATBaseAmount)
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VATBaseAmount___VATAmou nt;VATBaseAmount + VATAmount)
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VATAmount_Control1 50;VATAmount)
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(RoundLoop_Numb er;RoundLoop.Number)
// //                         {
// //                         }
// //                         column(AmountCapti on;AmountCaptionLbl)
// //                         {
// //                         }
// //                         column(Purchase_Line___VAT_Identifier_Capti on;"Purchase Line".FieldCaption("VAT Identifier"))
// //                         {
// //                         }
// //                         column(Purchase_Line___Allow_Invoice_Disc__Capti on;"Purchase Line".FieldCaption("Allow Invoice Disc."))
// //                         {
// //                         }
// //                         column(Purchase_Line___Line_Discount___Capti on;Purchase_Line___Line_Discount___CaptionLbl)
// //                         {
// //                         }
// //                         column(Direct_Unit_CostCapti on;Direct_Unit_CostCaptionLbl)
// //                         {
// //                         }
// //                         column(Purchase_Line___Qty__to_Invoice_Capti on;"Purchase Line".FieldCaption("Qty. to Invoice"))
// //                         {
// //                         }
// //                         column(Purchase_Line__QuantityCapti on;"Purchase Line".FieldCaption(Quantity))
// //                         {
// //                         }
// //                         column(Purchase_Line__DescriptionCapti on;"Purchase Line".FieldCaption(Description))
// //                         {
// //                         }
// //                         column(Purchase_Line___No__Capti on;"Purchase Line".FieldCaption("No."))
// //                         {
// //                         }
// //                         column(Purchase_Line__TypeCapti on;"Purchase Line".FieldCaption(Type))
// //                         {
// //                         }
// //                         column(TempPurchLine__Inv__Discount_Amount_Capti on;TempPurchLine__Inv__Discount_Amount_CaptionLbl)
// //                         {
// //                         }
// //                         column(SubtotalCapti on;SubtotalCaptionLbl)
// //                         {
// //                         }
// //                         column(VATDiscountAmountCapti on;VATDiscountAmountCaptionLbl)
// //                         {
// //                         }
// //                         dataitem(DimensionLoo "Integer")
//                         {
//                             DataItemTableView = sorting(Number) where(Number = filter(1 r(1..));
// //                             column(ReportForNavId_3591; 3591)
// //                             {
// //                             }
// //                             column(DimText_Control1 65;DimText)
// //                             {
// //                             }
// //                             column(DimensionLoop2_Numb er;DimensionLoop2.Number)
// //                             {
// //                             }
// //                             column(DimText_Control1 67;DimText)
// //                             {
// //                             }
// //                             column(Line_DimensionsCapti on;Line_DimensionsCaptionLbl)
// //                             {
// //                             }

// //                             trigger OnAfterGetRecord()
// //                             begin
// //                                 if DimensionLoop2.Number = 1 then begin
// //                                     if not DimSetEntry2.FindSet then
// //                                         CurrReport.Break;
// //                                 end else
// //                                     if not Continue then
// //                                         CurrReport.Break;
// //                                 DimText := '';
// //                                 Continue := false;
// //                                 repeat
// //                                     OldDimText := DimText;
// //                                     if DimText = '' then
// //                                         DimText := StrSubstNo('%1 - % 2',DimSetEntry2."Dimension Cod e",DimSetEntry2."Dimension Value Code")
// //                                  else
//                                         DimText :=
//                                           StrSubstNo(
//                                             '%1; %2 - %3', DimText, xt,DimSetEntry2."Dimension Cod e",DimSetEntry2."Dimension Value Code");
// //                                     if StrLen(DimText) > MaxStrLen(OldDimText) then begin
// //                                         DimText := OldDimText;
// //                                         Continue := true;
// //                                      exit;
//   //                                   end;
// //                                 until DimSetEntry2.Next = 0;
// //                             end;

// //                             trigger OnPostDataItem()
// //                             begin
// //                                 SumLineAmount := SumLineAmount + TempPurchLine."Line Amount";
// //                                 SumInvDiscountAmount := SumInvDiscountAmount + TempPurchLine."Inv. Discount Amount";
// //                             end;

// //                             trigger OnPreDataItem()
// //                             begin
// //                                 if not ShowDim then
// //                                     CurrReport.Break;
// //                             end;
// //                         }
// //                         dataitem(LineErrorCount er;"Integer")
// //                         {
// //                             DataItemTableView = sorting(Number);
// //                             column(ReportForNavId_2217; 2217)
// //                             {
// //                             }
// //                             column(ErrorText_Number__Control1 03;ErrorText[LineErrorCounter.Number])
// //                             {
// //                             }
// //                             column(LineErrorCounter_Numb er;LineErrorCounter.Number)
// //                             {
// //                             }
// //                             column(ErrorText_Number__Control103Capti on;ErrorText_Number__Control103CaptionLbl)
// //                             {
// //                             }

// //                             trigger OnPostDataItem()
// //                             begin
// //                                 ErrorCounter := 0;
// //                             end;

// //                             trigger OnPreDataItem()
// //                             begin
// //                                 LineErrorCounter.SetRange(LineErrorCounter.Numb 1, ,1,ErrorCounter);
// //                             end;
// //                         }

// //                         trigger OnAfterGetRecord()
// //                         var
// //                             TableID: aray [10] of Integer;
// //                             No: aray [10] of Code[20];
// //                             Fraction: Decimal;
// //                         begin
// //                             if RoundLoop.Number = 1 then
// //                                 TempPurchLine.Find('-')
// //                             else
// //                                 TempPurchLine.Next;
// //                             "Purchase Line" := TempPurchLine;

// //                             begin
// //                                 if not "Purchase Header"."Prices Including VAT" and
// //                                    ("Purchase Line"."VAT Calculation Type" = "Purchase Line"."vat calculation type"::"Full VAT")
// //                              then
//     //                                 TempPurchLine."Line Amount" := 0;
// //                                 DimSetEntry2.SetRange("Dimension Set I D","Purchase Line"."Dimension Set ID");
// //                                 DimMgt.GetDimensionSet(TempDimSetEnt ry,"Purchase Line"."Dimension Set ID");

// //                                 if "Purchase Line"."Document Type" in ["Purchase Line"."document type"::"Return Orde r","Purchase Line"."document type"::"Credit Memo"]
// //                              then begin
//     //                                 if "Purchase Line"."Document Type" = "Purchase Line"."document type"::"Credit Memo" then begin
// //                                         if ("Purchase Line"."Return Qty. to Ship" <> "Purchase Line".Quantity) and ("Purchase Line"."Return Shipment No." = '') then
// //                                             AddError(StrSubstNo(Text0 19,"Purchase Line".FieldCaption("Purchase Line"."Return Qty. to Ship "),"Purchase Line".Quantity));
// //                                         if "Purchase Line"."Qty. to Invoice" <> "Purchase Line".Quantity then
// //                                             AddError(StrSubstNo(Text0 19,"Purchase Line".FieldCaption("Purchase Line"."Qty. to Invoice "),"Purchase Line".Quantity));
// //                                  end;
//                                     if "Purchase Line"."Qty. to Receive" <> 0 then
//                                         AddError(StrSubstNo(Text040, "Purchase Line".FieldCaption("Purchase Line"."Qty. to Receive")));
//   //                               end else begin
// //                                     if "Purchase Line"."Document Type" = "Purchase Line"."document type"::Invoice then begin
// //                                         if ("Purchase Line"."Qty. to Receive" <> "Purchase Line".Quantity) and ("Purchase Line"."Receipt No." = '') then
// //                                             AddError(StrSubstNo(Text0 19,"Purchase Line".FieldCaption("Purchase Line"."Qty. to Receive "),"Purchase Line".Quantity));
// //                                         if "Purchase Line"."Qty. to Invoice" <> "Purchase Line".Quantity then
// //                                             AddError(StrSubstNo(Text0 19,"Purchase Line".FieldCaption("Purchase Line"."Qty. to Invoice "),"Purchase Line".Quantity));
// //                                  end;
//                                     if "Purchase Line"."Return Qty. to Ship" <> 0 then
//                                         AddError(StrSubstNo(Text040, "Purchase Line".FieldCaption("Purchase Line"."Return Qty. to Ship")));
//                                 end;

//   //                               if not "Purchase Header".Receive then
// //                                     "Purchase Line"."Qty. to Receive" := 0;
// //                                 if not "Purchase Header".Ship then
// //                                     "Purchase Line"."Return Qty. to Ship" := 0;

// //                                 if ("Purchase Line"."Document Type" = "Purchase Line"."document type"::Invoice) and ("Purchase Line"."Receipt No." <> '') then begin
// //                                     "Purchase Line"."Quantity Received" := "Purchase Line".Quantity;
// //                                     "Purchase Line"."Qty. to Receive" := 0;
// //                              end;

//   //                               if ("Purchase Line"."Document Type" = "Purchase Line"."document type"::"Credit Memo") and ("Purchase Line"."Return Shipment No." <> '') then begin
// //                                     "Purchase Line"."Return Qty. Shipped" := "Purchase Line".Quantity;
// //                                     "Purchase Line"."Return Qty. to Ship" := 0;
// //                              end;

//   //                               if "Purchase Header".Invoice then begin
// //                                     if "Purchase Line"."Document Type" = "Purchase Line"."document type"::"Credit Memo" then
// //                                         MaxQtyToBeInvoiced := "Purchase Line"."Return Qty. to Ship" + "Purchase Line"."Return Qty. Shipped" - "Purchase Line"."Quantity Invoiced"
// //                                  else
//       //                                   MaxQtyToBeInvoiced := "Purchase Line"."Qty. to Receive" + "Purchase Line"."Quantity Received" - "Purchase Line"."Quantity Invoiced";
// //                                  if Abs("Purchase Line"."Qty. to Invoice") > Abs(MaxQtyToBeInvoiced) then
//                                         "Purchase Line"."Qty. to Invoice" := MaxQtyToBeInvoiced;
//                                 end else
//                                     "Purchase Line"."Qty. to Invoice" := 0;

//   //                               if "Purchase Header".Receive then begin
// //                                     QtyToHandle := "Purchase Line"."Qty. to Receive";
// //                                     QtyToHandleCaption := "Purchase Line".FieldCaption("Purchase Line"."Qty. to Receive");
// //                              end;

//   //                               if "Purchase Header".Ship then begin
// //                                     QtyToHandle := "Purchase Line"."Return Qty. to Ship";
// //                                     QtyToHandleCaption := "Purchase Line".FieldCaption("Purchase Line"."Return Qty. to Ship");
// //                              end;

//   //                               if "Purchase Line"."Gen. Prod. Posting Group" <> '' then begin
// //                                     Clear(GenPostingSetup);
// //                                     GenPostingSetup.Reset;
// //                                     GenPostingSetup.SetRange("Gen. Bus. Posting Grou p","Purchase Line"."Gen. Bus. Posting Group");
// //                                     GenPostingSetup.SetRange("Gen. Prod. Posting Grou p","Purchase Line"."Gen. Prod. Posting Group");
// //                                  if not GenPostingSetup.FindLast then
//                                         AddError(
//                                           StrSubstNo(
//                                             Text020,
//                                             GenPostingSetup.TableCaption, "Purchase Line"."Gen. Bus. Posting Group", "Purchase Line"."Gen. Prod. Posting Group"));
//                                 end;

//                                 if "Purchase Line".Quantity <> 0 then begin
//                                     if "Purchase Line"."No." = '' then
//                                         AddError(StrSubstNo(Text006, "Purchase Line".FieldCaption("Purchase Line"."No.")));
//                                     if "Purchase Line".Type = 0 then
//                                         AddError(StrSubstNo(Text006, "Purchase Line".FieldCaption("Purchase Line".Type)));
//                                 end else
//     //                                 if "Purchase Line".Amount <> 0 then
// //                                         AddError(StrSubstNo(Text0 21,"Purchase Line".FieldCaption("Purchase Line".Amoun t),"Purchase Line".FieldCaption("Purchase Line".Quantity)));

// //                                 PurchLine := "Purchase Line";
// //                                 TestJobFields(PurchLine);
// //                                 if "Purchase Line"."Document Type" in ["Purchase Line"."document type"::"Return Orde r","Purchase Line"."document type"::"Credit Memo"]
// //                              then begin
//     //                                 PurchLine."Return Qty. to Ship" := -PurchLine."Return Qty. to Ship";
// //                                     PurchLine."Qty. to Invoice" := -PurchLine."Qty. to Invoice";
// //                              end;

//   //                               RemQtyToBeInvoiced := PurchLine."Qty. to Invoice";

// //                                 case "Purchase Line"."Document Type" of
// //                                     "Purchase Line"."document type"::"Return Orde r","Purchase Line"."document type"::"Credit Memo":
// //                                         CheckShptLines("Purchase Line");
// //                                     "Purchase Line"."document type"::Ord er,"Purchase Line"."document type"::Invoice:
// //                                         CheckRcptLines("Purchase Line");
// //                              end;

//                                 if ("Purchase Line".Type >= "Purchase Line".Type::"G/L Account") and ("Purchase Line"."Qty. to Invoice" <> 0) then
//                                     if not GenPostingSetup.Get("Purchase Line"."Gen. Bus. Posting Group", "Purchase Line"."Gen. Prod. Posting Group") then
//                                         AddError(
//                                           StrSubstNo(
//                                             Text020,
//                                             GenPostingSetup.TableCaption, "Purchase Line"."Gen. Bus. Posting Group", "Purchase Line"."Gen. Prod. Posting Group"));

//                                 if "Purchase Line"."Prepayment %" > 0 then
//                                     if not "Purchase Line"."Prepayment Line" and ("Purchase Line".Quantity > 0) then begin
//                                         Fraction := ("Purchase Line"."Qty. to Invoice" + "Purchase Line"."Quantity Invoiced") / "Purchase Line".Quantity;
//                                         if Fraction > 1 then
//                                             Fraction := 1;

//                                         case true of
//                                             (Fraction * "Purchase Line"."Line Amount" < "Purchase Line"."Prepmt Amt to Deduct") and
//                                           ("Purchase Line"."Prepmt Amt to Deduct" <> 0):
//                                                 AddError(
//                                                   StrSubstNo(
//                                                     Text053,
//                                                     "Purchase Line".FieldCaption("Purchase Line"."Prepmt Amt to Deduct"),
//                                                     ROUND(Fraction * "Purchase Line"."Line Amount", GLSetup."Amount Rounding Precision")));
//                                             (1 - Fraction) * "Purchase Line"."Line Amount" <
//                                           "Purchase Line"."Prepmt. Amt. Inv." - "Purchase Line"."Prepmt Amt Deducted" - "Purchase Line"."Prepmt Amt to Deduct":
//                                                 AddError(
//                                                   StrSubstNo(
//                                                     Text054,
//                                                     "Purchase Line".FieldCaption("Purchase Line"."Prepmt Amt to Deduct"),
//                                                     ROUND(
//                                                       "Purchase Line"."Prepmt. Amt. Inv." - "Purchase Line"."Prepmt Amt Deducted" - (1 - Fraction) * "Purchase Line"."Line Amount",
//                                                       GLSetup."Amount Rounding Precision")));
//                                         end;
//                                     end;
//                                 if not "Purchase Line"."Prepayment Line" and ("Purchase Line"."Prepmt. Line Amount" > 0) then
//                                     if "Purchase Line"."Prepmt. Line Amount" > "Purchase Line"."Prepmt. Amt. Inv." then
//                                         AddError(StrSubstNo(Text042, "Purchase Line".FieldCaption("Purchase Line"."Prepmt. Line Amount")));

//                                 case "Purchase Line".Type of
//                                     "Purchase Line".Type::"G/L Account":
//                                         begin
//                                             if ("Purchase Line"."No." = '') and ("Purchase Line".Amount = 0) then
//                                                 exit;

//                                             if "Purchase Line"."No." <> '' then
//                                                 if GLAcc.Get("Purchase Line"."No.") then begin
//                                                     if GLAcc.Blocked then
//                                                         AddError(
//                                                           StrSubstNo(
//                                                             Text007,
//                                                             GLAcc.FieldCaption(Blocked), false, GLAcc.TableCaption, "Purchase Line"."No."));
//                                                     if not GLAcc."Direct Posting" and ("Purchase Line"."Line No." <= OrigMaxLineNo) then
//                                                         AddError(
//                                                           StrSubstNo(
//                                                             Text007,
//                                                             GLAcc.FieldCaption("Direct Posting"), true, GLAcc.TableCaption, "Purchase Line"."No."));
//                                                 end else
//                                                     AddError(
//                                                       StrSubstNo(
//                                                         Text008,
//                                                         GLAcc.TableCaption, "Purchase Line"."No."));
//                                         end;
//                                     "Purchase Line".Type::Item:
//                                         begin
//                                             if ("Purchase Line"."No." = '') and ("Purchase Line".Quantity = 0) then
//                                                 exit;

//                                             if "Purchase Line"."No." <> '' then
//                                                 if Item.Get("Purchase Line"."No.") then begin
//                                                     if Item.Blocked then
//                                                         AddError(
//                                                           StrSubstNo(
//                                                             Text007,
//                                                             Item.FieldCaption(Blocked), false, Item.TableCaption, "Purchase Line"."No."));
//                                                     if Item."Costing Method" = Item."costing method"::Specific then
//                                                         if Item.Reserve = Item.Reserve::Always then begin
//                                                             "Purchase Line".CalcFields("Purchase Line"."Reserved Quantity");
//                                                             if ("Purchase Line".Signed("Purchase Line".Quantity) < 0) and (Abs("Purchase Line"."Reserved Quantity") < Abs("Purchase Line"."Qty. to Receive")) then
//                                                                 AddError(
//                                                                   StrSubstNo(
//                                                                     Text019,
//                                                                     "Purchase Line".FieldCaption("Purchase Line"."Reserved Quantity"), "Purchase Line".Signed("Purchase Line"."Qty. to Receive")));
//                                                         end;
//                                                 end else
//                                                     AddError(
//                                                       StrSubstNo(
//                                                         Text008,
//                                                         Item.TableCaption, "Purchase Line"."No."));
//                                         end;
//                                     "Purchase Line".Type::"Fixed Asset":
//                                         begin
//                                             if ("Purchase Line"."No." = '') and ("Purchase Line".Quantity = 0) then
//                                                 exit;

//                                             if "Purchase Line"."No." <> '' then
//                                                 if FA.Get("Purchase Line"."No.") then begin
//                                                     if FA.Blocked then
//                                                         AddError(
//                                                           StrSubstNo(
//                                                             Text007,
//                                                             FA.FieldCaption(Blocked), false, FA.TableCaption, "Purchase Line"."No."));
//                                                     if FA.Inactive then
//                                                         AddError(
//                                                           StrSubstNo(
//                                                             Text007,
//                                                             FA.FieldCaption(Inactive), false, FA.TableCaption, "Purchase Line"."No."));
//                                                 end else
//                                                     AddError(
//                                                       StrSubstNo(
//                                                         Text008,
//                                                         FA.TableCaption, "Purchase Line"."No."));
//                                         end;
//                                 end;

//   //                               if "Purchase Line"."Line No." > OrigMaxLineNo then begin
// //                                     AddDimToTempLine("Purchase Line");
// //                                     if not DimMgt.CheckDimIDComb("Purchase Line"."Dimension Set ID") then
// //                                         AddError(DimMgt.GetDimCombErr);
// //                                     if not DimMgt.CheckDimValuePosting(Table No, No,"Purchase Line"."Dimension Set ID") then
// //                                         AddError(DimMgt.GetDimValuePostingErr);
// //                                 end else begin
// //                                     if not DimMgt.CheckDimIDComb("Purchase Line"."Dimension Set ID") then
// //                                         AddError(DimMgt.GetDimCombErr);

// //                                     TableID[1] := DimMgt.TypeToTableID3("Purchase Line".Type);
// //                                     No[1] := "Purchase Line"."No.";
// //                                     TableID[2] := Database::Job;
// //                                     No[2] := "Purchase Line"."Job No.";
// //                                     TableID[3] := Database::"Work Center";
// //                                     No[3] := "Purchase Line"."Work Center No.";
// //                                     if not DimMgt.CheckDimValuePosting(Table No, No,"Purchase Line"."Dimension Set ID") then
// //                                         AddError(DimMgt.GetDimValuePostingErr);
// //                              end;

//   //                               AllowInvDisctxt := Format("Purchase Line"."Allow Invoice Disc.");
// //                             end;
// //                         end;

// //                         trigger OnPreDataItem()
// //                         var
// //                             MoreLines: Boolean;
// //                         begin
// //                             CurrReport.CreateTotals(TempPurchLine."Line Amoun t",TempPurchLine."Inv. Discount Amount");

// //                             MoreLines := TempPurchLine.Find('+');
// //                             while MoreLines and (TempPurchLine.Description = '') and (TempPurchLine."Description 2" = '') and
// //                                   (TempPurchLine."No." = '') and (TempPurchLine.Quantity = 0) and
// //                                   (TempPurchLine.Amount = 0)
// //                             do
// //                                 MoreLines := TempPurchLine.Next(-1) <> 0;
// //                             if not MoreLines then
// //                                 CurrReport.Break;
// //                             TempPurchLine.SetRange("Line No 0, ,0,TempPurchLine."Line No.");
// //                             RoundLoop.SetRange(RoundLoop.Numb 1, ,1,TempPurchLine.Count);

// //                             SumLineAmount := 0;
// //                             SumInvDiscountAmount := 0;
// //                         end;
// //                     }
// //                     dataitem(VATCount er;"Integer")
// //                     {
// //                         DataItemTableView = sorting(Number);
// //                         column(ReportForNavId_6558; 6558)
// //                         {
// //                         }
// //                         column(VATAmountLine__VAT_Amoun t_;VATAmountLine."VAT Amount")
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VATAmountLine__VAT_Bas e_;VATAmountLine."VAT Base")
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VATAmountLine__Invoice_Discount_Amoun t_;VATAmountLine."Invoice Discount Amount")
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VATAmountLine__Inv__Disc__Base_Amoun t_;VATAmountLine."Inv. Disc. Base Amount")
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VATAmountLine__Line_Amoun t_;VATAmountLine."Line Amount")
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VATAmountLine__VAT_Amount__Control 98;VATAmountLine."VAT Amount")
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VATAmountLine__VAT_Base__Control1 38;VATAmountLine."VAT Base")
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VATAmountLine__VAT_ __;VATAmountLine."VAT %")
// //                         {
// //                             DecimalPlaces  :  0:5;
// //                         }
// //                         column(VATAmountLine__VAT_Identifie r_;VATAmountLine."VAT Identifier")
// //                         {
// //                         }
// //                         column(VATAmountLine__Line_Amount__Control1 75;VATAmountLine."Line Amount")
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VATAmountLine__Inv__Disc__Base_Amount__Control1 76;VATAmountLine."Inv. Disc. Base Amount")
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VATAmountLine__Invoice_Discount_Amount__Control1 77;VATAmountLine."Invoice Discount Amount")
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VATAmountLine__VAT_Amount__Control 95;VATAmountLine."VAT Amount")
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VATAmountLine__VAT_Base__Control1 39;VATAmountLine."VAT Base")
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VATAmountLine__Invoice_Discount_Amount__Control1 81;VATAmountLine."Invoice Discount Amount")
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VATAmountLine__Inv__Disc__Base_Amount__Control1 82;VATAmountLine."Inv. Disc. Base Amount")
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VATAmountLine__Line_Amount__Control1 83;VATAmountLine."Line Amount")
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VATAmountLine__VAT_Amount__Control 85;VATAmountLine."VAT Amount")
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VATAmountLine__VAT_Base__Control1 37;VATAmountLine."VAT Base")
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VATAmountLine__Invoice_Discount_Amount__Control1 87;VATAmountLine."Invoice Discount Amount")
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VATAmountLine__Inv__Disc__Base_Amount__Control1 88;VATAmountLine."Inv. Disc. Base Amount")
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VATAmountLine__Line_Amount__Control1 89;VATAmountLine."Line Amount")
// //                         {
// //                             AutoFormatExpression = "Purchase Header"."Currency Code";
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VATCounter_Numb er;VATCounter.Number)
// //                         {
// //                         }
// //                         column(VAT_Amount_SpecificationCapti on;VAT_Amount_SpecificationCaptionLbl)
// //                         {
// //                         }
// //                         column(VATAmountLine__VAT_Amount__Control98Capti on;VATAmountLine__VAT_Amount__Control98CaptionLbl)
// //                         {
// //                         }
// //                         column(VATAmountLine__VAT_Base__Control138Capti on;VATAmountLine__VAT_Base__Control138CaptionLbl)
// //                         {
// //                         }
// //                         column(VATAmountLine__VAT___Capti on;VATAmountLine__VAT___CaptionLbl)
// //                         {
// //                         }
// //                         column(VATAmountLine__VAT_Identifier_Capti on;VATAmountLine__VAT_Identifier_CaptionLbl)
// //                         {
// //                         }
// //                         column(VATAmountLine__Inv__Disc__Base_Amount__Control176Capti on;VATAmountLine__Inv__Disc__Base_Amount__Control176CaptionLbl)
// //                         {
// //                         }
// //                         column(VATAmountLine__Line_Amount__Control175Capti on;VATAmountLine__Line_Amount__Control175CaptionLbl)
// //                         {
// //                         }
// //                         column(VATAmountLine__Invoice_Discount_Amount__Control177Capti on;VATAmountLine__Invoice_Discount_Amount__Control177CaptionLbl)
// //                         {
// //                         }
// //                         column(VATAmountLine__VAT_Base_Capti on;VATAmountLine__VAT_Base_CaptionLbl)
// //                         {
// //                         }
// //                         column(VATAmountLine__VAT_Base__Control139Capti on;VATAmountLine__VAT_Base__Control139CaptionLbl)
// //                         {
// //                         }
// //                         column(VATAmountLine__VAT_Base__Control137Capti on;VATAmountLine__VAT_Base__Control137CaptionLbl)
// //                         {
// //                         }

// //                         trigger OnAfterGetRecord()
// //                         begin
// //                             VATAmountLine.GetLine(VATCounter.Number);
// //                         end;

// //                         trigger OnPreDataItem()
// //                         begin
// //                             VATCounter.SetRange(VATCounter.Numb 1, ,1,VATAmountLine.Count);
// //                             CurrReport.CreateTotals(
// //                               VATAmountLine."VAT Bas e",VATAmountLine."VAT Amoun t",VATAmountLine."Amount Including VAT",
// //                               VATAmountLine."Line Amoun t",VATAmountLine."Inv. Disc. Base Amount",
// //                               VATAmountLine."Invoice Discount Amount");
// //                         end;
// //                     }
// //                     dataitem(VATCounterL CY;"Integer")
// //                     {
// //                         DataItemTableView = sorting(Number);
// //                         column(ReportForNavId_2038; 2038)
// //                         {
// //                         }
// //                         column(VALExchRa te;VALExchRate)
// //                         {
// //                         }
// //                         column(VALSpecLCYHead er;VALSpecLCYHeader)
// //                         {
// //                         }
// //                         column(VALVATAmountL CY;VALVATAmountLCY)
// //                         {
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VALVATBaseL CY;VALVATBaseLCY)
// //                         {
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VALVATAmountLCY_Control2 42;VALVATAmountLCY)
// //                         {
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VALVATBaseLCY_Control2 43;VALVATBaseLCY)
// //                         {
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VATAmountLine__VAT____Control2 44;VATAmountLine."VAT %")
// //                         {
// //                             DecimalPlaces  :  0:5;
// //                         }
// //                         column(VATAmountLine__VAT_Identifier__Control2 45;VATAmountLine."VAT Identifier")
// //                         {
// //                         }
// //                         column(VALVATAmountLCY_Control2 46;VALVATAmountLCY)
// //                         {
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VALVATBaseLCY_Control2 47;VALVATBaseLCY)
// //                         {
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VALVATAmountLCY_Control2 49;VALVATAmountLCY)
// //                         {
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VALVATBaseLCY_Control2 50;VALVATBaseLCY)
// //                         {
// //                             AutoFormatType = 1;
// //                         }
// //                         column(VATCounterLCY_Numb er;VATCounterLCY.Number)
// //                         {
// //                         }
// //                         column(VALVATAmountLCY_Control242Capti on;VALVATAmountLCY_Control242CaptionLbl)
// //                         {
// //                         }
// //                         column(VALVATBaseLCY_Control243Capti on;VALVATBaseLCY_Control243CaptionLbl)
// //                         {
// //                         }
// //                         column(VATAmountLine__VAT____Control244Capti on;VATAmountLine__VAT____Control244CaptionLbl)
// //                         {
// //                         }
// //                         column(VATAmountLine__VAT_Identifier__Control245Capti on;VATAmountLine__VAT_Identifier__Control245CaptionLbl)
// //                         {
// //                         }
// //                         column(ContinuedCapti on;ContinuedCaptionLbl)
// //                         {
// //                         }
// //                         column(ContinuedCaption_Control2 48;ContinuedCaption_Control248Lbl)
// //                         {
// //                         }
// //                         column(TotalCapti on;TotalCaptionLbl)
// //                         {
// //                         }

// //                         trigger OnAfterGetRecord()
// //                         begin
// //                             VATAmountLine.GetLine(VATCounterLCY.Number);
// //                             VALVATBaseLCY :=
// //                               VATAmountLine.GetBaseLCY(
// //                                 "Purchase Header"."Posting Dat e","Purchase Header"."Currency Cod e","Purchase Header"."Currency Factor");
// //                             VALVATAmountLCY :=
// //                               VATAmountLine.GetAmountLCY(
// //                                 "Purchase Header"."Posting Dat e","Purchase Header"."Currency Cod e","Purchase Header"."Currency Factor");
// //                         end;

// //                         trigger OnPreDataItem()
// //                         begin
// //                             if (not GLSetup."Print VAT specification in LCY") or
// //                                ("Purchase Header"."Currency Code" = '')
// //                             then
// //                                 CurrReport.Break;

// //                             VATCounterLCY.SetRange(VATCounterLCY.Numb 1, ,1,VATAmountLine.Count);
// //                             CurrReport.CreateTotals(VALVATBaseL CY,VALVATAmountLCY);

// //                             if GLSetup."LCY Code" = '' then
// //                                 VALSpecLCYHeader := Text050 + Text051
// //                             else
// //                                 VALSpecLCYHeader := Text050 + Format(GLSetup."LCY Code");

// //                             CurrExchRate.FindCurrency("Purchase Header"."Posting Dat e","Purchase Header"."Currency Cod e",1);
// //                             VALExchRate := StrSubstNo(Text0 52,CurrExchRate."Relational Exch. Rate Amoun t",CurrExchRate."Exchange Rate Amount");
// //                         end;
// //                     }
// //                     dataitem("Item Charge Assignment (Purch "Item Charge Assignment (Purch)")
//                     {
//                         DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("Document No.");
//                         DataItemLinkReference = "Purchase Line";
//                         DataItemTableView = sorting("Document Type", "Document No.", "Document Line No.", .","Line No.");
// //                         column(ReportForNavId_8938; 8938)
// //                         {
// //                         }
// //                         column(Item_Charge_Assignment__Purch___Qty__to_Assig n_;"Item Charge Assignment (Purch)"."Qty. to Assign")
// //                         {
// //                         }
// //                         column(Item_Charge_Assignment__Purch___Amount_to_Assig n_;"Item Charge Assignment (Purch)"."Amount to Assign")
// //                         {
// //                         }
// //                         column(Item_Charge_Assignment__Purch___Item_Charge_No __;"Item Charge Assignment (Purch)"."Item Charge No.")
// //                         {
// //                         }
// //                         column(PurchLine2_Descripti on;PurchLine2.Description)
// //                         {
// //                         }
// //                         column(PurchLine2_Quanti ty;PurchLine2.Quantity)
// //                         {
// //                         }
// //                         column(Item_Charge_Assignment__Purch___Item_No __;"Item Charge Assignment (Purch)"."Item No.")
// //                         {
// //                         }
// //                         column(Item_Charge_Assignment__Purch___Qty__to_Assign__Control2 04;"Item Charge Assignment (Purch)"."Qty. to Assign")
// //                         {
// //                         }
// //                         column(Item_Charge_Assignment__Purch___Unit_Cos t_;"Item Charge Assignment (Purch)"."Unit Cost")
// //                         {
// //                         }
// //                         column(Item_Charge_Assignment__Purch___Amount_to_Assign__Control2 10;"Item Charge Assignment (Purch)"."Amount to Assign")
// //                         {
// //                         }
// //                         column(Item_Charge_Assignment__Purch___Qty__to_Assign__Control1 95;"Item Charge Assignment (Purch)"."Qty. to Assign")
// //                         {
// //                         }
// //                         column(Item_Charge_Assignment__Purch___Amount_to_Assign__Control1 96;"Item Charge Assignment (Purch)"."Amount to Assign")
// //                         {
// //                         }
// //                         column(Item_Charge_Assignment__Purch___Qty__to_Assign__Control1 91;"Item Charge Assignment (Purch)"."Qty. to Assign")
// //                         {
// //                         }
// //                         column(Item_Charge_Assignment__Purch___Amount_to_Assign__Control1 93;"Item Charge Assignment (Purch)"."Amount to Assign")
// //                         {
// //                         }
// //                         column(Item_Charge_Assignment__Purch__Document_Ty pe;"Item Charge Assignment (Purch)"."Document Type")
// //                         {
// //                         }
// //                         column(Item_Charge_Assignment__Purch__Document_N o_;"Item Charge Assignment (Purch)"."Document No.")
// //                         {
// //                         }
// //                         column(Item_Charge_Assignment__Purch__Document_Line_N o_;"Item Charge Assignment (Purch)"."Document Line No.")
// //                         {
// //                         }
// //                         column(Item_Charge_Assignment__Purch__Line_N o_;"Item Charge Assignment (Purch)"."Line No.")
// //                         {
// //                         }
// //                         column(Item_Charge_SpecificationCapti on;Item_Charge_SpecificationCaptionLbl)
// //                         {
// //                         }
// //                         column(Item_Charge_Assignment__Purch___Item_Charge_No__Capti on;"Item Charge Assignment (Purch)".FieldCaption("Item Charge Assignment (Purch)"."Item Charge No."))
// //                         {
// //                         }
// //                         column(Item_Charge_Assignment__Purch___Item_No__Capti on;"Item Charge Assignment (Purch)".FieldCaption("Item Charge Assignment (Purch)"."Item No."))
// //                         {
// //                         }
// //                         column(Item_Charge_Assignment__Purch___Qty__to_Assign__Control204Capti on;"Item Charge Assignment (Purch)".FieldCaption("Item Charge Assignment (Purch)"."Qty. to Assign"))
// //                         {
// //                         }
// //                         column(Item_Charge_Assignment__Purch___Unit_Cost_Capti on;"Item Charge Assignment (Purch)".FieldCaption("Item Charge Assignment (Purch)"."Unit Cost"))
// //                         {
// //                         }
// //                         column(Item_Charge_Assignment__Purch___Amount_to_Assign__Control210Capti on;"Item Charge Assignment (Purch)".FieldCaption("Item Charge Assignment (Purch)"."Amount to Assign"))
// //                         {
// //                         }
// //                         column(DescriptionCapti on;DescriptionCaptionLbl)
// //                         {
// //                         }
// //                         column(PurchLine2_QuantityCapti on;PurchLine2_QuantityCaptionLbl)
// //                         {
// //                         }
// //                         column(ContinuedCaption_Control1 97;ContinuedCaption_Control197Lbl)
// //                         {
// //                         }
// //                         column(TotalCaption_Control1 94;TotalCaption_Control194Lbl)
// //                         {
// //                         }
// //                         column(ContinuedCaption_Control1 92;ContinuedCaption_Control192Lbl)
// //                         {
// //                         }

// //                         trigger OnAfterGetRecord()
// //                         begin
// //                             if PurchLine2.Get("Item Charge Assignment (Purch)"."Document Typ e","Item Charge Assignment (Purch)"."Document No .","Item Charge Assignment (Purch)"."Document Line No.") then;
// //                         end;

// //                         trigger OnPreDataItem()
// //                         begin
// //                             if not ShowItemChargeAssgnt then
// //                                 CurrReport.Break;
// //                             CurrReport.CreateTotals("Item Charge Assignment (Purch)"."Amount to Assig n","Item Charge Assignment (Purch)"."Qty. to Assign");
// //                         end;
// //                     }

// //                     trigger OnAfterGetRecord()
// //                     var
// //                         PurchPost: Codeunit "Purch.-Post";
// //                     begin
// //                         Clear(TempPurchLine);
// //                         Clear(PurchPost);
// //                         TempPurchLine.DeleteAll;
// //                         VATAmountLine.DeleteAll;
// //                         PurchPost.GetPurchLines("Purchase Heade TempPurchLine, ne,1);
// //                         TempPurchLine.CalcVATAmountLines "Purchase Header", TempPurchLine, ne,VATAmountLine);
// //                         TempPurchLine.UpdateVATOnLines "Purchase Header", TempPurchLine, ne,VATAmountLine);
// //                         VATAmount := VATAmountLine.GetTotalVATAmount;
// //                         VATBaseAmount := VATAmountLine.GetTotalVATBase;
// //                         VATDiscountAmount :=
// //                           VATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Cod e","Purchase Header"."Prices Including VAT");
// //                         TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;
// //                     end;
// //                 }
// //             }

// //             trigger OnAfterGetRecord()
// //             var
// //                 TableID: aray [10] of Integer;
// //                 No: aray [10] of Code[20];
// //                 InvtPeriodEndDate: Date;
// //             begin
// //                 DimSetEntry1.SetRange("Dimension Set I D","Purchase Header"."Dimension Set ID");

// //                 FormatAddr.PurchHeaderPayTo(PayToAd dr,"Purchase Header");
// //                 FormatAddr.PurchHeaderBuyFrom(BuyFromAd dr,"Purchase Header");
// //                 FormatAddr.PurchHeaderShipTo(ShipToAd dr,"Purchase Header");
// //                 if "Purchase Header"."Currency Code" = '' then begin
// //                     GLSetup.TestField("LCY Code");
// //                     TotalText := StrSubstNo(Text0 04,GLSetup."LCY Code");
// //                     TotalInclVATText := StrSubstNo(Text0 05,GLSetup."LCY Code");
// //                     TotalExclVATText := StrSubstNo(Text0 31,GLSetup."LCY Code");
// //                 end else begin
// //                     TotalText := StrSubstNo(Text0 04,"Purchase Header"."Currency Code");
// //                     TotalInclVATText := StrSubstNo(Text0 05,"Purchase Header"."Currency Code");
// //                     TotalExclVATText := StrSubstNo(Text0 31,"Purchase Header"."Currency Code");
// //                 end;

// //                 "Purchase Header".Invoice := InvOnNextPostReq;
// //                 "Purchase Header".Receive := ReceiveShipOnNextPostReq;
// //                 "Purchase Header".Ship := ReceiveShipOnNextPostReq;

// //                 if "Purchase Header"."Buy-from Vendor No." = '' then
// //                     AddError(StrSubstNo(Text0 06,"Purchase Header".FieldCaption("Purchase Header"."Buy-from Vendor No.")))
// //                 else begin
// //                     if Vend.Get("Purchase Header"."Buy-from Vendor No.") then begin
// //                         if Vend.Blocked = Vend.Blocked::All then
// //                          AddError(
//                               StrSubstNo(
//                                 Text041,
//       //                           Vend.FieldCaption(Blocke d),Vend.Block ed,Vend.TableCapti on,"Purchase Header"."Buy-from Vendor No."));
// //                  end else
//                         AddError(
//                           StrSubstNo(
//                             Text008,
//     //                         Vend.TableCapti on,"Purchase Header"."Buy-from Vendor No."));
// //                 end;

// //                 if "Purchase Header"."Pay-to Vendor No." = '' then
// //                     AddError(StrSubstNo(Text0 06,"Purchase Header".FieldCaption("Purchase Header"."Pay-to Vendor No.")))
// //                 else
// //                     if "Purchase Header"."Pay-to Vendor No." <> "Purchase Header"."Buy-from Vendor No." then begin
// //                         if Vend.Get("Purchase Header"."Pay-to Vendor No.") then begin
// //                             if Vend.Blocked = Vend.Blocked::All then
// //                              AddError(
//                                   StrSubstNo(
//                                     Text041,
//         //                             Vend.FieldCaption(Blocke d),Vend.Blocked::A ll,Vend.TableCapti on,"Purchase Header"."Pay-to Vendor No."));
// //                      end else
//                             AddError(
//                               StrSubstNo(
//                                 Text008,
//                                 Vend.TableCaption, "Purchase Header"."Pay-to Vendor No."));
//   //                   end;

// //                 PurchSetup.Get;

// //                 if "Purchase Header"."Posting Date" = 0D then
// //                     AddError(StrSubstNo(Text0 06,"Purchase Header".FieldCaption("Purchase Header"."Posting Date")))
// //                 else
// //                     if "Purchase Header"."Posting Date" <> NormalDate("Purchase Header"."Posting Date") then
// //                         AddError(StrSubstNo(Text0 09,"Purchase Header".FieldCaption("Purchase Header"."Posting Date")))
// //                  else begin
//     //                     if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
// //                             if UserId <> '' then
// //                                 if UserSetup.Get(UserId) then begin
// //                                     AllowPostingFrom := UserSetup."Allow Posting From";
// //                                     AllowPostingTo := UserSetup."Allow Posting To";
// //                              end;
//                             if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
//                                 AllowPostingFrom := GLSetup."Allow Posting From";
//                                 AllowPostingTo := GLSetup."Allow Posting To";
//                             end;
//                             if AllowPostingTo = 0D then
//                                 AllowPostingTo := 99991231D;
//                         end;
//     //                     if ("Purchase Header"."Posting Date" < AllowPostingFrom) or ("Purchase Header"."Posting Date" > AllowPostingTo) then
// //                             AddError(StrSubstNo(Text0 10,"Purchase Header".FieldCaption("Purchase Header"."Posting Date")))
// //                      else
//       //                       if IsInvtPosting then begin
// //                                 InvtPeriodEndDate := "Purchase Header"."Posting Date";
// //                                 if not InvtPeriod.IsValidDate(InvtPeriodEndDate) then
// //                                  AddError(
//           //                             StrSubstNo(Text0 10,Format("Purchase Header"."Posting Date")))
// //                          end;
//   //                   end;

// //                 if "Purchase Header"."Document Date" <> 0D then
// //                     if "Purchase Header"."Document Date" <> NormalDate("Purchase Header"."Document Date") then
// //                         AddError(StrSubstNo(Text0 09,"Purchase Header".FieldCaption("Purchase Header"."Document Date")));

// //                 case "Purchase Header"."Document Type" of
// //                     "Purchase Header"."document type"::Order:
// //                         "Purchase Header".Ship := false;
// //                     "Purchase Header"."document type"::Invoice:
// //                      begin
//       //                       "Purchase Header".Receive := true;
// //                             "Purchase Header".Invoice := true;
// //                             "Purchase Header".Ship := false;
// //                      end;
//   //                   "Purchase Header"."document type"::"Return Order":
// //                         "Purchase Header".Receive := false;
// //                     "Purchase Header"."document type"::"Credit Memo":
// //                      begin
//       //                       "Purchase Header".Receive := false;
// //                             "Purchase Header".Invoice := true;
// //                             "Purchase Header".Ship := true;
// //                         end;
// //                 end;

// //                 if not ("Purchase Header".Receive or "Purchase Header".Invoice or "Purchase Header".Ship) then
// //                  AddError(
//                       StrSubstNo(
//                         Text032,
//   //                       "Purchase Header".FieldCaption("Purchase Header".Receiv e),"Purchase Header".FieldCaption("Purchase Header".Invoic e),"Purchase Header".FieldCaption("Purchase Header".Ship)));

// //                 if "Purchase Header".Invoice then begin
// //                     PurchLine.Reset;
// //                     PurchLine.SetRange("Document Typ e","Purchase Header"."Document Type");
// //                     PurchLine.SetRange("Document No .","Purchase Header"."No.");
// //                     PurchLine.SetFilter(Quanti ty,'<>0');
// //                     if "Purchase Header"."Document Type" in ["Purchase Header"."document type"::Ord er,"Purchase Header"."document type"::"Return Order"] then
// //                         PurchLine.SetFilter("Qty. to Invoic e",'<>0');
// //                     "Purchase Header".Invoice := PurchLine.Find('-');
// //                  if "Purchase Header".Invoice and (not "Purchase Header".Receive) and ("Purchase Header"."Document Type" = "Purchase Header"."document type"::Order) then begin
//                         "Purchase Header".Invoice := false;
//                         repeat
//                             "Purchase Header".Invoice := PurchLine."Quantity Received" - PurchLine."Quantity Invoiced" <> 0;
//                         until "Purchase Header".Invoice or (PurchLine.Next = 0);
//                     end else
//     //                     if "Purchase Header".Invoice and (not "Purchase Header".Ship) and ("Purchase Header"."Document Type" = "Purchase Header"."document type"::"Return Order") then begin
// //                             "Purchase Header".Invoice := false;
// //                          repeat
//         //                         "Purchase Header".Invoice := PurchLine."Return Qty. Shipped" - PurchLine."Quantity Invoiced" <> 0;
// //                             until "Purchase Header".Invoice or (PurchLine.Next = 0);
// //                         end;
// //                 end;

// //                 if "Purchase Header".Receive then begin
// //                     PurchLine.Reset;
// //                     PurchLine.SetRange("Document Typ e","Purchase Header"."Document Type");
// //                     PurchLine.SetRange("Document No .","Purchase Header"."No.");
// //                     PurchLine.SetFilter(Quanti ty,'<>0');
// //                     if "Purchase Header"."Document Type" = "Purchase Header"."document type"::Order then
// //                         PurchLine.SetFilter("Qty. to Receiv e",'<>0');
// //                     PurchLine.SetRange("Receipt No .",'');
// //                     "Purchase Header".Receive := PurchLine.Find('-');
// //                 end;
// //                 if "Purchase Header".Ship then begin
// //                     PurchLine.Reset;
// //                     PurchLine.SetRange("Document Typ e","Purchase Header"."Document Type");
// //                     PurchLine.SetRange("Document No .","Purchase Header"."No.");
// //                     PurchLine.SetFilter(Quanti ty,'<>0');
// //                     if "Purchase Header"."Document Type" = "Purchase Header"."document type"::"Return Order" then
// //                         PurchLine.SetFilter("Return Qty. to Shi p",'<>0');
// //                     PurchLine.SetRange("Return Shipment No .",'');
// //                     "Purchase Header".Ship := PurchLine.Find('-');
// //                 end;

// //                 if not ("Purchase Header".Receive or "Purchase Header".Invoice or "Purchase Header".Ship) then
// //                     AddError(Text012);

// //                 if "Purchase Header".Invoice then begin
// //                     PurchLine.Reset;
// //                     PurchLine.SetRange("Document Typ e","Purchase Header"."Document Type");
// //                     PurchLine.SetRange("Document No .","Purchase Header"."No.");
// //                     PurchLine.SetFilter("Sales Order Line No .",'<>0');
// //                     if PurchLine.Find('-') then
// //                      repeat
//       //                       SalesLine.Get(SalesLine."document type"::Ord er,PurchLine."Sales Order No .",PurchLine."Sales Order Line No.");
// //                             if "Purchase Header".Receive and
// //                                "Purchase Header".Invoice and
// //                                (PurchLine."Qty. to Invoice" <> 0) and
// //                                (PurchLine."Qty. to Receive" <> 0)
// //                          then
//         //                         AddError(Text013);
// //                             if Abs(PurchLine."Quantity Received" - PurchLine."Quantity Invoiced") <
// //                                Abs(PurchLine."Qty. to Invoice")
// //                          then
//         //                         PurchLine."Qty. to Invoice" := PurchLine."Quantity Received" - PurchLine."Quantity Invoiced";
// //                             if Abs(PurchLine.Quantity - (PurchLine."Qty. to Invoice" + PurchLine."Quantity Invoiced")) <
// //                                Abs(SalesLine.Quantity - SalesLine."Quantity Invoiced")
// //                          then
//                                 AddError(
//                                   StrSubstNo(
//                                     Text014,
//         //                             PurchLine."Sales Order No."));
// //                         until PurchLine.Next = 0;
// //                 end;

// //                 if "Purchase Header".Invoice then
// //                  if not ("Purchase Header"."Document Type" in ["Purchase Header"."document type"::"Return Order", "Purchase Header"."document type"::"Credit Memo"]) then
//     //                     if "Purchase Header"."Due Date" = 0D then
// //                             AddError(StrSubstNo(Text0 06,"Purchase Header".FieldCaption("Purchase Header"."Due Date")));

// //                 if "Purchase Header".Receive and ("Purchase Header"."Receiving No." = '') then
// //                  if ("Purchase Header"."Document Type" = "Purchase Header"."document type"::Order) or
//                        (("Purchase Header"."Document Type" = "Purchase Header"."document type"::Invoice) and PurchSetup."Receipt on Invoice")
//                     then
//     //                     if "Purchase Header"."Receiving No. Series" = '' then
// //                          AddError(
//                               StrSubstNo(
//                                 Text015,
//       //                           "Purchase Header".FieldCaption("Purchase Header"."Receiving No. Series")));

// //                 if "Purchase Header".Ship and ("Purchase Header"."Return Shipment No." = '') then
// //                  if ("Purchase Header"."Document Type" = "Purchase Header"."document type"::"Return Order") or
//                        (("Purchase Header"."Document Type" = "Purchase Header"."document type"::"Credit Memo") and PurchSetup."Return Shipment on Credit Memo")
//                     then
//     //                     if "Purchase Header"."Return Shipment No. Series" = '' then
// //                          AddError(
//                               StrSubstNo(
//                                 Text015,
//       //                           "Purchase Header".FieldCaption("Purchase Header"."Return Shipment No. Series")));

// //                 if "Purchase Header".Invoice and ("Purchase Header"."Posting No." = '') then
// //                  if "Purchase Header"."Document Type" in ["Purchase Header"."document type"::Order, "Purchase Header"."document type"::"Return Order"] then
//     //                     if "Purchase Header"."Posting No. Series" = '' then
// //                          AddError(
//                               StrSubstNo(
//                                 Text015,
//       //                           "Purchase Header".FieldCaption("Purchase Header"."Posting No. Series")));

// //                 PurchLine.Reset;
// //                 PurchLine.SetRange("Document Typ e","Purchase Header"."Document Type");
// //                 PurchLine.SetRange("Document No .","Purchase Header"."No.");
// //                 PurchLine.SetFilter("Sales Order Line No .",'<>0');
// //                 if PurchLine.Find('-') then begin
// //                     DropShipOrder := true;
// //                     if "Purchase Header".Receive then
// //                      repeat
//       //                       if SalesHeader."No." <> PurchLine."Sales Order No." then begin
// //                                 SalesHeader.Get (1,PurchLine."Sales Order No.");
// //                                 if SalesHeader."Bill-to Customer No." = '' then
// //                                  AddError(
//                                       StrSubstNo(
//                                         Text016,
//           //                               SalesHeader.FieldCaption("Bill-to Customer No.")));
// //                                 if SalesHeader."Shipping No." = '' then
// //                                     if SalesHeader."Shipping No. Series" = '' then
// //                                      AddError(
//                                           StrSubstNo(
//                                             Text016,
//             //                                 SalesHeader.FieldCaption("Shipping No. Series")));
// //                          end;
//     //                     until PurchLine.Next = 0;
// //                 end;

// //                 if "Purchase Header".Invoice then
// //                  if "Purchase Header"."Document Type" in ["Purchase Header"."document type"::Order, "Purchase Header"."document type"::Invoice] then begin
//                         if PurchSetup."Ext. Doc. No. Mandatory" and ("Purchase Header"."Vendor Invoice No." = '') then
//                             AddError(StrSubstNo(Text006, "Purchase Header".FieldCaption("Purchase Header"."Vendor Invoice No.")));
//                     end else
//     //                     if PurchSetup."Ext. Doc. No. Mandatory" and ("Purchase Header"."Vendor Cr. Memo No." = '') then
// //                             AddError(StrSubstNo(Text0 06,"Purchase Header".FieldCaption("Purchase Header"."Vendor Cr. Memo No.")));

// //                 if "Purchase Header"."Vendor Invoice No." <> '' then begin
// //                     VendLedgEntry.SetCurrentkey("External Document No.");
// //                     VendLedgEntry.SetRange("Document Typ e","Purchase Header"."Document Type");
// //                     VendLedgEntry.SetRange("External Document No .","Purchase Header"."Vendor Invoice No.");
// //                     VendLedgEntry.SetRange("Vendor No .","Purchase Header"."Pay-to Vendor No.");
// //                     if VendLedgEntry.FindFirst then
// //                      AddError(
//                           StrSubstNo(
//                             Text017,
//     //                         "Purchase Header"."Document Typ e","Purchase Header"."Vendor Invoice No."));
// //                 end;

// //                 if not DimMgt.CheckDimIDComb("Purchase Header"."Dimension Set ID") then
// //                     AddError(DimMgt.GetDimCombErr);

// //                 TableID[1] := Database::Vendor;
// //                 No[1] := "Purchase Header"."Pay-to Vendor No.";
// //                 TableID[3] := Database::"Salesperson/Purchaser";
// //                 No[3] := "Purchase Header"."Purchaser Code";
// //                 TableID[4] := Database::Campaign;
// //                 No[4] := "Purchase Header"."Campaign No.";
// //                 TableID[5] := Database::"Responsibility Center";
// //                 No[5] := "Purchase Header"."Responsibility Center";

// //                 if not DimMgt.CheckDimValuePosting(Table No, No,"Purchase Header"."Dimension Set ID") then
// //                     AddError(DimMgt.GetDimValuePostingErr);

// //                 PricesInclVATtxt := Format("Purchase Header"."Prices Including VAT");
// //             end;

// //             trigger OnPreDataItem()
// //             begin
// //                 PurchHeader.Copy("Purchase Header");
// //                 PurchHeader.FilterGroup := 2;
// //                 PurchHeader.SetRange("Document Typ e",PurchHeader."document type"::Order);
// //                 if PurchHeader.FindFirst then begin
// //                     case true of
// //                         ReceiveShipOnNextPostReq and InvOnNextPostReq:
// //                             ReceiveInvoiceText := Text000;
// //                      ReceiveShipOnNextPostReq:
//       //                       ReceiveInvoiceText := Text001;
// //                      InvOnNextPostReq:
//       //                       ReceiveInvoiceText := Text002;
// //                  end;
//   //                   ReceiveInvoiceText := StrSubstNo(Text0 03,ReceiveInvoiceText);
// //                 end;
// //                 PurchHeader.SetRange("Document Typ e",PurchHeader."document type"::"Return Order");
// //                 if PurchHeader.FindFirst then begin
// //                     case true of
// //                         ReceiveShipOnNextPostReq and InvOnNextPostReq:
// //                             ShipInvoiceText := Text028;
// //                      ReceiveShipOnNextPostReq:
//       //                       ShipInvoiceText := Text029;
// //                      InvOnNextPostReq:
//       //                       ShipInvoiceText := Text002;
// //                  end;
//   //                   ShipInvoiceText := StrSubstNo(Text0 30,ShipInvoiceText);
// //                 end;
// //             end;
// //         }
// //     }

// //     requestpage
// //     {
// //         SaveValues = true;

// //         layout
// //         {
// //             area(content)
// //             {
// //                 group(Options)
// //                 {
// //                     Caption = 'Options';
// //                     group("Order/Credit Memo Posting")
// //                     {
// //                         Caption = 'Order/Credit Memo Posting';
// //                         field(ReceiveSh ip;ReceiveShipOnNextPostReq)
// //                         {
// //                             ApplicationArea = Basic;
// //                             Caption = 'Receive/Ship';

// //                             trigger OnValidate()
// //                             begin
// //                                 if not ReceiveShipOnNextPostReq then
// //                                     InvOnNextPostReq := true;
// //                             end;
// //                         }
// //                         field(Invoi ce;InvOnNextPostReq)
// //                         {
// //                             ApplicationArea = Basic;
// //                             Caption = 'Invoice';

// //                             trigger OnValidate()
// //                             begin
// //                                 if not InvOnNextPostReq then
// //                                     ReceiveShipOnNextPostReq := true;
// //                             end;
// //                         }
// //                     }
// //                     field(ShowD im;ShowDim)
// //                     {
// //                         ApplicationArea = Basic;
// //                         Caption = 'Show Dimensions';
// //                     }
// //                     field(ShowItemChargeAssignme nt;ShowItemChargeAssgnt)
// //                     {
// //                         ApplicationArea = Basic;
// //                         Caption = 'Show Item Charge Assgnt.';
// //                     }
// //                 }
// //             }
// //         }

// //         actions
// //         {
// //         }

// //         trigger OnOpenPage()
// //         begin
// //             if not ReceiveShipOnNextPostReq and not InvOnNextPostReq then begin
// //                 ReceiveShipOnNextPostReq := true;
// //                 InvOnNextPostReq := true;
// //             end;
// //         end;
// //     }

// //     labels
// //     {
// //     }

// //     trigger OnInitReport()
// //     begin
// //         GLSetup.Get;
// //     end;

// //     trigger OnPreReport()
// //     begin
// //         PurchHeaderFilter := "Purchase Header".GetFilters;
// //     end;

// //     var
// //         Text000: label 'Receive and Invoice';
// //         Text001: label 'Receive';
// //         Text002: label 'Invoice';
// //         Text003: label 'Order Posting: %1';
// //         Text004: label 'Total %1';
// //         Text005: label 'Total %1 Incl. VAT';
// //         Text006: label '%1 must be specified.';
// //         Text007: label '%1 must be %2 for %3 %4.';
// //         Text008: label '%1 %2 does not exist.';
// //         Text009: label '%1 must not be a closing date.';
// //         Text010: label '%1 is not within your allowed range of posting dates.';
// //         Text012: label 'There is nothing to post.';
// //         Text013: label 'A drop shipment from a purchase order cannot be received and invoiced at the same time.';
// //         Text014: label 'Invoice sales order %1 before invoicing this purchase order.';
// //         Text015: label '%1 must be entered.';
// //         Text016: label '%1 must be entered on the sales order header.';
// //         Text017: label 'Purchase %1 %2 already exists for this vendor.';
// //         Text018: label 'Purchase Document: %1';
// //         Text019: label '%1 must be %2.';
// //         Text020: label '%1 %2 %3 does not exist.';
// //         Text021: label '%1 must be 0 when %2 is 0.';
// //         Text022: label 'The %1 on the receipt is not the same as the %1 on the purchase header.';
// //         Text023: label '%1 must have the same sign as the receipt.';
// //         Text025: label '%1 must have the same sign as the return shipment.';
// //         Text028: label 'Ship and Invoice';
// //         Text029: label 'Ship';
// //         Text030: label 'Return Order Posting: %1';
// //         Text031: label 'Total %1 Excl. VAT';
// //         Text032: label 'Enter "Yes" in %1 and/or %2 and/or %3.';
// //         Text033: label 'Line %1 of the receipt %2, which you are attempting to invoice, has already been invoiced.';
// //         Text034: label 'Line %1 of the return shipment %2, which you are attempting to invoice, has already been invoiced.';
// //         Text036: label 'The %1 on the return shipment is not the same as the %1 on the purchase header.';
// //         Text037: label 'The quantity you are attempting to invoice is greater than the quantity in receipt %1.';
// //         Text038: label 'The quantity you are attempting to invoice is greater than the quantity in return shipment %1.';
// //         PurchSetup: Record "Purchases & Payables Setup";
// //         GLSetup: Record "General Ledger Setup";
// //         UserSetup: Record "User Setup";
// //         Vend: Record Vendor;
// //         VendLedgEntry: Record "Vendor Ledger Entry";
// //         PurchHeader: Record "Purchase Header";
// //         PurchLine: Record "Purchase Line";
// //         PurchLine2: Record "Purchase Line";
// //         TempPurchLine: Record "Purchase Line" temporary;
// //         GLAcc: Record "G/L Account";
// //         Item: Record Item;
// //         FA: Record "Fixed Asset";
// //         PurchRcptLine: Record "Purch. Rcpt. Line";
// //         ReturnShptLine: Record "Return Shipment Line";
// //         SalesHeader: Record "Sales Header";
// //         SalesLine: Record "Sales Line";
// //         GenPostingSetup: Record "General Posting Setup";
// //         VATAmountLine: Record "VAT Amount Line" temporary;
// //         DimSetEntry1: Record "Dimension Set Entry";
// //         DimSetEntry2: Record "Dimension Set Entry";
// //         TempDimSetEntry: Record "Dimension Set Entry" temporary;
// //         CurrExchRate: Record "Currency Exchange Rate";
// //         InvtPeriod: Record "Inventory Period";
// //         FormatAddr: Codeunit "Format Address";
// //         DimMgt: Codeunit DimensionManagement;
// //         PayToAddr: aray [8] of Text[50];
// //         BuyFromAddr: aray [8] of Text[50];
// //         ShipToAddr: aray [8] of Text[50];
// //         PurchHeaderFilter: Text;
// //         ErrorText: aray [99] of Text[250];
// //         DimText: Text[120];
// //         OldDimText: Text[75];
// //         ReceiveInvoiceText: Text[50];
// //         ShipInvoiceText: Text[50];
// //         TotalText: Text[50];
// //         TotalInclVATText: Text[50];
// //         TotalExclVATText: Text[50];
// //         QtyToHandleCaption: Text[30];
// //         AllowPostingFrom: Date;
// //         AllowPostingTo: Date;
// //         MaxQtyToBeInvoiced: Decimal;
// //         RemQtyToBeInvoiced: Decimal;
// //         QtyToBeInvoiced: Decimal;
// //         QtyToHandle: Decimal;
// //         VATAmount: Decimal;
// //         VATBaseAmount: Decimal;
// //         VATDiscountAmount: Decimal;
// //         TotalAmountInclVAT: Decimal;
// //         ErrorCounter: Integer;
// //         OrigMaxLineNo: Integer;
// //         DropShipOrder: Boolean;
// //         InvOnNextPostReq: Boolean;
// //         ReceiveShipOnNextPostReq: Boolean;
// //         ShowDim: Boolean;
// //         Continue: Boolean;
// //         ShowItemChargeAssgnt: Boolean;
// //         Text040: label '%1 must be zero.';
// //         Text041: label '%1 must not be %2 for %3 %4.';
// //         Text042: label '%1 must be completely preinvoiced before you can ship or invoice the line.';
// //         Text050: label 'VAT Amount Specification in ';
// //         Text051: label 'Local Currency';
// //         Text052: label 'Exchange rate: %1/%2';
// //         VALVATBaseLCY: Decimal;
// //         VALVATAmountLCY: Decimal;
// //         VALSpecLCYHeader: Text[80];
// //         VALExchRate: Text[50];
// //         Text053: label '%1 can at most be %2.';
// //         Text054: label '%1 must be at least %2.';
// //         PricesInclVATtxt: Text[30];
// //         AllowInvDisctxt: Text[30];
// //         SumLineAmount: Decimal;
// //         SumInvDiscountAmount: Decimal;
// //         Purchase_Document___TestCaptionLbl: label 'Purchase Document - Test';
// //         CurrReport_PAGENOCaptionLbl: label 'Page';
// //         Ship_toCaptionLbl: label 'Ship-to';
// //         Buy_fromCaptionLbl: label 'Buy-from';
// //         Pay_toCaptionLbl: label 'Pay-to';
// //         Purchase_Header___Posting_Date_CaptionLbl: label 'Posting Date';
// //         Purchase_Header___Document_Date_CaptionLbl: label 'Document Date';
// //         Purchase_Header___Due_Date_CaptionLbl: label 'Due Date';
// //         Purchase_Header___Pmt__Discount_Date_CaptionLbl: label 'Pmt. Discount Date';
// //         Purchase_Header___Posting_Date__Control106CaptionLbl: label 'Posting Date';
// //         Purchase_Header___Document_Date__Control107CaptionLbl: label 'Document Date';
// //         Purchase_Header___Order_Date_CaptionLbl: label 'Order Date';
// //         Purchase_Header___Expected_Receipt_Date_CaptionLbl: label 'Expected Receipt Date';
// //         Purchase_Header___Due_Date__Control19CaptionLbl: label 'Due Date';
// //         Purchase_Header___Pmt__Discount_Date__Control22CaptionLbl: label 'Pmt. Discount Date';
// //         Purchase_Header___Posting_Date__Control112CaptionLbl: label 'Posting Date';
// //         Purchase_Header___Document_Date__Control113CaptionLbl: label 'Document Date';
// //         Purchase_Header___Posting_Date__Control130CaptionLbl: label 'Posting Date';
// //         Purchase_Header___Document_Date__Control131CaptionLbl: label 'Document Date';
// //         Header_DimensionsCaptionLbl: label 'Header Dimensions';
// //         ErrorText_Number_CaptionLbl: label 'Warning!';
// //         AmountCaptionLbl: label 'Amount';
// //         Purchase_Line___Line_Discount___CaptionLbl: label 'Line Disc. %';
// //         Direct_Unit_CostCaptionLbl: label 'Direct Unit Cost';
// //         TempPurchLine__Inv__Discount_Amount_CaptionLbl: label 'Inv. Discount Amount';
// //         SubtotalCaptionLbl: label 'Subtotal';
// //         VATDiscountAmountCaptionLbl: label 'Payment Discount on VAT';
// //         Line_DimensionsCaptionLbl: label 'Line Dimensions';
// //         ErrorText_Number__Control103CaptionLbl: label 'Warning!';
// //         VAT_Amount_SpecificationCaptionLbl: label 'VAT Amount Specification';
// //         VATAmountLine__VAT_Amount__Control98CaptionLbl: label 'VAT Amount';
// //         VATAmountLine__VAT_Base__Control138CaptionLbl: label 'VAT Base';
// //         VATAmountLine__VAT___CaptionLbl: label 'VAT %';
// //         VATAmountLine__VAT_Identifier_CaptionLbl: label 'VAT Identifier';
// //         VATAmountLine__Inv__Disc__Base_Amount__Control176CaptionLbl: label 'Invoice Discount Base Amount';
// //         VATAmountLine__Line_Amount__Control175CaptionLbl: label 'Line Amount';
// //         VATAmountLine__Invoice_Discount_Amount__Control177CaptionLbl: label 'Invoice Discount Amount';
// //         VATAmountLine__VAT_Base_CaptionLbl: label 'Continued';
// //         VATAmountLine__VAT_Base__Control139CaptionLbl: label 'Continued';
// //         VATAmountLine__VAT_Base__Control137CaptionLbl: label 'Total';
// //         VALVATAmountLCY_Control242CaptionLbl: label 'VAT Amount';
// //         VALVATBaseLCY_Control243CaptionLbl: label 'VAT Base';
// //         VATAmountLine__VAT____Control244CaptionLbl: label 'VAT %';
// //         VATAmountLine__VAT_Identifier__Control245CaptionLbl: label 'VAT Identifier';
// //         ContinuedCaptionLbl: label 'Continued';
// //         ContinuedCaption_Control248Lbl: label 'Continued';
// //         TotalCaptionLbl: label 'Total';
// //         Item_Charge_SpecificationCaptionLbl: label 'Item Charge Specification';
// //         DescriptionCaptionLbl: label 'Description';
// //         PurchLine2_QuantityCaptionLbl: label 'Assignable Qty';
// //         ContinuedCaption_Control197Lbl: label 'Continued';
// //         TotalCaption_Control194Lbl: label 'Total';
// //         ContinuedCaption_Control192Lbl: label 'Continued';

// //     local procedure AddError(Text: Text[250])
// //     begin
// //         ErrorCounter := ErrorCounter + 1;
// //         ErrorText[ErrorCounter] := Text;
// //     end;

// //     local procedure CheckRcptLines(PurchLine2: Record "Purchase Line")
// //     var
// //         TempPostedDimSetEntry: Record "Dimension Set Entry" temporary;
// //     begin
// //         begin
// //             if Abs(RemQtyToBeInvoiced) > Abs(PurchLine2."Qty. to Receive") then begin
// //                 PurchRcptLine.Reset;
// //                 case PurchLine2."Document Type" of
// //                     PurchLine2."document type"::Order:
// //                      begin
//           //                   PurchRcptLine.SetCurrentkey("Order No .","Order Line No.");
// //                             PurchRcptLine.SetRange("Order No .",PurchLine2."Document No.");
// //                             PurchRcptLine.SetRange("Order Line No .",PurchLine2."Line No.");
// //                      end;
//                     PurchLine2."document type"::Invoice:
//                         begin
//                             PurchRcptLine.SetRange("Document No.", PurchLine2."Receipt No.");
//                             PurchRcptLine.SetRange("Line No.", PurchLine2."Receipt Line No.");
//                         end;
//                 end;

//     //             PurchRcptLine.SetFilter("Qty. Rcd. Not Invoice d",'<>0');
// //                 if PurchRcptLine.Find('-') then
// //                  repeat
//         //                 DimMgt.GetDimensionSet(TempPostedDimSetEnt ry,PurchRcptLine."Dimension Set ID");
// //                         if not DimMgt.CheckDimIDConsistency(
// //                           TempDimSetEntry, TempPostedDimSetEntry, ry,Database::"Purchase Lin e",Database::"Purch. Rcpt. Line")
// //                      then
//           //                   AddError(DimMgt.GetDocDimConsistencyErr);
// //                         if PurchRcptLine."Buy-from Vendor No." <> PurchLine2."Buy-from Vendor No." then
// //                          AddError(
//                               StrSubstNo(
//                                 Text022,
//           //                       PurchLine2.FieldCaption(PurchLine2."Buy-from Vendor No.")));
// //                         if PurchRcptLine.Type <> PurchLine2.Type then
// //                          AddError(
//                               StrSubstNo(
//                                 Text022,
//           //                       PurchLine2.FieldCaption(PurchLine2.Type)));
// //                         if PurchRcptLine."No." <> PurchLine2."No." then
// //                          AddError(
//                               StrSubstNo(
//                                 Text022,
//           //                       PurchLine2.FieldCaption(PurchLine2."No.")));
// //                         if PurchRcptLine."Gen. Bus. Posting Group" <> PurchLine2."Gen. Bus. Posting Group" then
// //                          AddError(
//                               StrSubstNo(
//                                 Text022,
//           //                       PurchLine2.FieldCaption(PurchLine2."Gen. Bus. Posting Group")));
// //                         if PurchRcptLine."Gen. Prod. Posting Group" <> PurchLine2."Gen. Prod. Posting Group" then
// //                          AddError(
//                               StrSubstNo(
//                                 Text022,
//           //                       PurchLine2.FieldCaption(PurchLine2."Gen. Prod. Posting Group")));
// //                         if PurchRcptLine."Location Code" <> PurchLine2."Location Code" then
// //                          AddError(
//                               StrSubstNo(
//                                 Text022,
//           //                       PurchLine2.FieldCaption(PurchLine2."Location Code")));
// //                         if PurchRcptLine."Job No." <> PurchLine2."Job No." then
// //                          AddError(
//                               StrSubstNo(
//                                 Text022,
//           //                       PurchLine2.FieldCaption(PurchLine2."Job No.")));

// //                         if PurchLine."Qty. to Invoice" * PurchRcptLine.Quantity < 0 then
// //                             AddError(StrSubstNo(Text0 23,PurchLine2.FieldCaption(PurchLine2."Qty. to Invoice")));

// //                         QtyToBeInvoiced := RemQtyToBeInvoiced - PurchLine."Qty. to Receive";
// //                         if Abs(QtyToBeInvoiced) > Abs(PurchRcptLine.Quantity - PurchRcptLine."Quantity Invoiced") then
// //                             QtyToBeInvoiced := PurchRcptLine.Quantity - PurchRcptLine."Quantity Invoiced";
// //                         RemQtyToBeInvoiced := RemQtyToBeInvoiced - QtyToBeInvoiced;
// //                         PurchRcptLine."Quantity Invoiced" := PurchRcptLine."Quantity Invoiced" + QtyToBeInvoiced;
// //                     until (PurchRcptLine.Next = 0) or (Abs(RemQtyToBeInvoiced) <= Abs(PurchLine2."Qty. to Receive"))
// //              else
//                     AddError(
//                       StrSubstNo(
//                         Text033,
//       //                   PurchLine2."Receipt Line No.",
// //                         PurchLine2."Receipt No."));
// //          end;

//             if Abs(RemQtyToBeInvoiced) > Abs(PurchLine2."Qty. to Receive") then
//     //             if PurchLine2."Document Type" = PurchLine2."document type"::Invoice then
// //                  AddError(
//                       StrSubstNo(
//                         Text037,
//       //                   PurchLine2."Receipt No."))
// //         end;
// //     end;

// //     local procedure CheckShptLines(PurchLine2: Record "Purchase Line")
// //     var
// //         TempPostedDimSetEntry: Record "Dimension Set Entry" temporary;
// //     begin
// //         begin
// //             if Abs(RemQtyToBeInvoiced) > Abs(PurchLine2."Return Qty. to Ship") then begin
// //                 ReturnShptLine.Reset;
// //                 case PurchLine2."Document Type" of
// //                     PurchLine2."document type"::"Return Order":
// //                      begin
//           //                   ReturnShptLine.SetCurrentkey("Return Order No .","Return Order Line No.");
// //                             ReturnShptLine.SetRange("Return Order No .",PurchLine2."Document No.");
// //                             ReturnShptLine.SetRange("Return Order Line No .",PurchLine2."Line No.");
// //                      end;
//                     PurchLine2."document type"::"Credit Memo":
//                         begin
//                             ReturnShptLine.SetRange("Document No.", PurchLine2."Return Shipment No.");
//                             ReturnShptLine.SetRange("Line No.", PurchLine2."Return Shipment Line No.");
//                         end;
//                 end;

//     //             PurchRcptLine.SetFilter("Qty. Rcd. Not Invoice d",'<>0');
// //                 if ReturnShptLine.Find('-') then
// //                  repeat
//         //                 DimMgt.GetDimensionSet(TempPostedDimSetEnt ry,ReturnShptLine."Dimension Set ID");
// //                         if not DimMgt.CheckDimIDConsistency(
// //                           TempDimSetEntry, TempPostedDimSetEntry, ry,Database::"Purchase Lin e",Database::"Return Shipment Line")
// //                      then
//           //                   AddError(DimMgt.GetDocDimConsistencyErr);

// //                         if ReturnShptLine."Buy-from Vendor No." <> PurchLine2."Buy-from Vendor No." then
// //                          AddError(
//                               StrSubstNo(
//                                 Text036,
//           //                       PurchLine2.FieldCaption(PurchLine2."Buy-from Vendor No.")));
// //                         if ReturnShptLine.Type <> PurchLine2.Type then
// //                          AddError(
//                               StrSubstNo(
//                                 Text036,
//           //                       PurchLine2.FieldCaption(PurchLine2.Type)));
// //                         if ReturnShptLine."No." <> PurchLine2."No." then
// //                          AddError(
//                               StrSubstNo(
//                                 Text036,
//           //                       PurchLine2.FieldCaption(PurchLine2."No.")));
// //                         if ReturnShptLine."Gen. Bus. Posting Group" <> PurchLine2."Gen. Bus. Posting Group" then
// //                          AddError(
//                               StrSubstNo(
//                                 Text036,
//           //                       PurchLine2.FieldCaption(PurchLine2."Gen. Bus. Posting Group")));
// //                         if ReturnShptLine."Gen. Prod. Posting Group" <> PurchLine2."Gen. Prod. Posting Group" then
// //                          AddError(
//                               StrSubstNo(
//                                 Text036,
//           //                       PurchLine2.FieldCaption(PurchLine2."Gen. Prod. Posting Group")));
// //                         if ReturnShptLine."Location Code" <> PurchLine2."Location Code" then
// //                          AddError(
//                               StrSubstNo(
//                                 Text036,
//           //                       PurchLine2.FieldCaption(PurchLine2."Location Code")));
// //                         if ReturnShptLine."Job No." <> PurchLine2."Job No." then
// //                          AddError(
//                               StrSubstNo(
//                                 Text036,
//           //                       PurchLine2.FieldCaption(PurchLine2."Job No.")));

// //                         if -PurchLine."Qty. to Invoice" * ReturnShptLine.Quantity < 0 then
// //                             AddError(StrSubstNo(Text0 25,PurchLine2.FieldCaption(PurchLine2."Qty. to Invoice")));
// //                         QtyToBeInvoiced := RemQtyToBeInvoiced - PurchLine."Return Qty. to Ship";
// //                         if Abs(QtyToBeInvoiced) > Abs(ReturnShptLine.Quantity - ReturnShptLine."Quantity Invoiced") then
// //                             QtyToBeInvoiced := ReturnShptLine.Quantity - ReturnShptLine."Quantity Invoiced";
// //                         RemQtyToBeInvoiced := RemQtyToBeInvoiced - QtyToBeInvoiced;
// //                         ReturnShptLine."Quantity Invoiced" := ReturnShptLine."Quantity Invoiced" + QtyToBeInvoiced;
// //                     until (ReturnShptLine.Next = 0) or (Abs(RemQtyToBeInvoiced) <= Abs(PurchLine2."Return Qty. to Ship"))
// //              else
//                     AddError(
//                       StrSubstNo(
//                         Text034,
//       //                   PurchLine2."Return Shipment Line No.",
// //                         PurchLine2."Return Shipment No."));
// //          end;

//             if Abs(RemQtyToBeInvoiced) > Abs(PurchLine2."Return Qty. to Ship") then
//     //             if PurchLine2."Document Type" = PurchLine2."document type"::"Credit Memo" then
// //                  AddError(
//                       StrSubstNo(
//                         Text038,
//       //                   PurchLine2."Return Shipment No."));
// //         end;
// //     end;


// //     procedure TestJobFields(var PurchLine: Record "Purchase Line")
// //     var
// //         Job: Record Job;
// //         JT: Record "Job Task";
// //     begin
// //         begin
// //             if PurchLine."Job No." = '' then
// //              exit;
//   //           if (PurchLine.Type <> PurchLine.Type::"G/L Account") and (PurchLine.Type <> PurchLine.Type::Item) then
// //              exit;
//   //           if (PurchLine."Document Type" <> PurchLine."document type"::Invoice) and
// //                (PurchLine."Document Type" <> PurchLine."document type"::"Credit Memo")
// //          then
//                 exit;
//             if not Job.Get(PurchLine."Job No.") then
//                 AddError(StrSubstNo(Text053, Job.TableCaption, PurchLine."Job No."))
//             else
//                 if Job.Blocked > Job.Blocked::" " then
//                     AddError(
//                       StrSubstNo(
//                         Text054, Job.FieldCaption(Blocked), Job.Blocked, Job.TableCaption, PurchLine."Job No."));

//             if PurchLine."Job Task No." = '' then
//                 AddError(StrSubstNo(Text006, PurchLine.FieldCaption(PurchLine."Job Task No.")))
//             else
//     //             if not JT.Get(PurchLine."Job No .",PurchLine."Job Task No.") then
// //                     AddError(StrSubstNo(Text0 53,JT.TableCapti on,PurchLine."Job Task No."))
// //         end;
// //     end;

// //     local procedure IsInvtPosting(): Boolean
// //     var
// //         PurchLine: Record "Purchase Line";
// //     begin
// //         begin
// //             PurchLine.SetRange("Document Typ e","Purchase Header"."Document Type");
// //             PurchLine.SetRange("Document No .","Purchase Header"."No.");
// //             PurchLine.SetFilter(Ty '%1|%2', 2',PurchLine.Type::It em,PurchLine.Type::"Charge (Item)");
// //             if PurchLine.IsEmpty then
// //                 exit(false);
// //             if "Purchase Header".Receive then begin
// //                 PurchLine.SetFilter("Qty. to Receiv '<>%1', 1',0);
// //              if not PurchLine.IsEmpty then
//                     exit(true);
//             end;
//   //           if "Purchase Header".Ship then begin
// //                 PurchLine.SetFilter("Return Qty. to Shi '<>%1', 1',0);
// //              if not PurchLine.IsEmpty then
//                     exit(true);
//             end;
//   //           if "Purchase Header".Invoice then begin
// //                 PurchLine.SetFilter("Qty. to Invoic '<>%1', 1',0);
// //                 if not PurchLine.IsEmpty then
// //                     exit(true);
// //             end;
// //         end;
// //     end;


// //     procedure AddDimToTempLine(PurchLine: Record "Purchase Line")
// //     var
// //         SourceCodesetup: Record "Source Code Setup";
// //         TableID: aray [10] of Integer;
// //         No: aray [10] of Code[20];
// //     begin
// //         SourceCodesetup.Get;

// //         begin
// //             TableID[1] := DimMgt.TypeToTableID3(PurchLine.Type);
// //             No[1] := PurchLine."No.";
// //             TableID[2] := Database::Job;
// //             No[2] := PurchLine."Job No.";
// //             TableID[3] := Database::"Responsibility Center";
// //             No[3] := PurchLine."Responsibility Center";

// //             PurchLine."Shortcut Dimension 1 Code" := '';
// //             PurchLine."Shortcut Dimension 2 Code" := '';

// //             PurchLine."Dimension Set ID" :=
// //               DimMgt.GetDefaultDimID(Table No, No,SourceCodesetup.Purchas es,PurchLine."Shortcut Dimension 1 Cod e",PurchLine."Shortcut Dimension 2 Code",
// //                 PurchLine."Dimension Set I D",Database::Vendor);
// //         end;
// //     end;


// //     procedure InitializeRequest(NewReceiveShipOnNextPostReq: Boole an;NewInvOnNextPostReq: Boole an;NewShowDim: Boole an;NewShowItemChargeAssgnt: Boolean)
// //     begin
// //         ReceiveShipOnNextPostReq := NewReceiveShipOnNextPostReq;
// //         InvOnNextPostReq := NewInvOnNextPostReq;
// //         ShowDim := NewShowDim;
// //         ShowItemChargeAssgnt := NewShowItemChargeAssgnt;
// //     end;
// // }
