// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185459 pageextension52185459 extends "Purchase Order"
{
    
    



    layout
    {
        //         modify("No.")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Buy-from Vendor No.")
        //         {
        //             ApplicationArea = Basic;



        //             ShowMandatory = true;
        //         }

        //         modify("Buy-from Address")
        //         {

        //             ApplicationArea = Basic;

        //         }
        //         modify("Buy-from Address 2")
        //         {

        //             ApplicationArea = Basic;
        //         }


        //         modify("Buy-from City")
        //         {



        //             ApplicationArea = Basic;


        //         }
        //         modify("Buy-from Post Code")
        //         {


        //             ApplicationArea = Basic;


        //         }
        //         modify("Buy-from Contact No.")
        //         {


        //             ApplicationArea = Basic;


        //         }
        //         modify("Buy-from Contact")
        //         {
        //             ApplicationArea = Basic;




        //         }
        //         modify("Document Date")
        //         {
        //             ApplicationArea = Basic;
        //         }

        //         modify("Due Date")
        //         {
        //             ApplicationArea = Basic;



        //         }
        modify("Vendor Invoice No.")
        {
            ApplicationArea = Basic;
            Enabled = false;
            ShowMandatory = false;
        }
       
        //         modify("Purchaser Code")
        //         {
        //             ApplicationArea = Basic;



        //         }
        //         modify("No. of Archived Versions")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Order Date")
        //         {
        //             ApplicationArea = Basic;


        //             Caption = 'Delivery Date';
        //         }
        //         modify("Quote No.")
        //         {
        //             ApplicationArea = Basic;


        //         }
        //         modify("Vendor Order No.")
        //         {
        //             ApplicationArea = Basic;


        //         }
        //         modify("Vendor Shipment No.")
        //         {
        //             ApplicationArea = Basic;


        //         }
        //         modify("Order Address Code")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Responsibility Center")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Assigned User ID")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify(Status)
        //         {
        //             ApplicationArea = Basic;


        //             Editable = false;
        //         }
        //         modify("Job Queue Status")
        //         {
        //             ApplicationArea = Basic;


        //         }
        //         modify("Invoice Details")
        //         {
        //             Caption = 'Invoicing';


        //         }
        //         modify("Currency Code")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Expected Receipt Date")
        //         {
        //             ApplicationArea = Basic;
        //         }
                modify("VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                    visible=true;
                }
        //         modify("Payment Terms Code")
        //         {
        //             ApplicationArea = Basic;


        //         }
        //         modify("Payment Method Code")
        //         {
        //             ApplicationArea = Basic;


        //         }
        //         modify("Payment Discount %")
        //         {
        //             ApplicationArea = Basic;


        //         }
        //         modify("Pmt. Discount Date")
        //         {
        //             ApplicationArea = Basic;


        //         }
        //         modify("Shipment Method Code")
        //         {
        //             ApplicationArea = Basic;


        //         }

        //         modify("Creditor No.")
        //         {
        //             ApplicationArea = Basic;
        //             visible = false;
        //         }
        //         modify("On Hold")
        //         {
        //             ApplicationArea = Basic;


        //         }

        //         modify("Requested Receipt Date")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Promised Receipt Date")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Shipping and Payment")
        //         {
        //             Caption = 'Shipping';



        //         }

        //         modify("Location Code")
        //         {



        //             ApplicationArea = Basic;
        //         }
        //         modify("Sell-to Customer No.")
        //         {



        //             ApplicationArea = Basic;
        //             Visible = false;


        //         }
        //         modify("Ship-to Code")
        //         {


        //             ApplicationArea = Basic;


        //         }
        //         modify("Ship-to Name")
        //         {


        //             ApplicationArea = Basic;


        //         }
        //         modify("Ship-to Address")
        //         {


        //             ApplicationArea = Basic;


        //         }

        //         modify("Ship-to City")
        //         {


        //             ApplicationArea = Basic;


        //         }
        //         modify("Ship-to Post Code")
        //         {


        //             ApplicationArea = Basic;


        //         }
        //         modify("Ship-to Contact")
        //         {


        //             ApplicationArea = Basic;


        //         }

        //         modify("Pay-to Address")
        //         {


        //             ApplicationArea = Basic;
        //         }
        //         modify("Pay-to Address 2")
        //         {


        //             ApplicationArea = Basic;


        //         }
        //         modify("Pay-to City")
        //         {


        //             ApplicationArea = Basic;


        //         }
        //         modify("Pay-to Post Code")
        //         {


        //             ApplicationArea = Basic;


        //         }
        //         modify("Pay-to Contact No.")
        //         {


        //             ApplicationArea = Basic;


        //         }
        //         modify("Pay-to Contact")
        //         {


        //             ApplicationArea = Basic;


        //         }



        //         modify("Transaction Specification")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Transaction Type")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Transport Method")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Entry Point")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Area")
        //         {
        //             ApplicationArea = Basic;
        //         }


        //         modify("Prepayment %")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Compress Prepayment")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Prepmt. Payment Terms Code")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Prepayment Due Date")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Prepmt. Payment Discount %")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Prepmt. Pmt. Discount Date")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Vendor Cr. Memo No.")
        //         {
        //             ApplicationArea = Basic;
        //         }


        //         modify(Control94)
        //         {
        //             Visible = false;
        //         }
        //         modify(ShippingOptionWithLocation)
        //         {
        //             Visible = false;
        //         }

        //         modify(Control99)
        //         {
        //             Visible = false;
        //         }
        //         modify(Control98)
        //         {
        //             Visible = false;
        //         }


        //         modify(Control101)
        //         {
        //             Visible = false;
        //         }



        //         modify(Control124)
        //         {
        //             Visible = false;
        //         }
        //         modify("Ship-to County")
        //         {
        //             Visible = false;
        //         }



        //         modify("Ship-to Country/Region Code")
        //         {
        //             Visible = false;
        //         }



        //         modify(PayToOptions)
        //         {
        //             Visible = false;
        //         }
        //         modify(Control95)
        //         {
        //             Visible = false;
        //         }

        //         modify(Control123)
        //         {
        //             Visible = false;
        //         }
        //         modify("Pay-to County")
        //         {
        //             Visible = false;
        //         }



        //         modify("Pay-to Country/Region Code")
        //         {
        //             Visible = false;
        //         }



        //         modify("Attached Documents")
        //         {
        //             Visible = false;
        //         }


        //         addafter("Due Date")
        //         {

        //             field("Contract Ref No"; Rec."Contract Ref No")
        //             {
        //                 ApplicationArea = Basic;
        //             }
        //             field("Quotation Date"; Rec."Quotation Date")
        //             {
        //                 ApplicationArea = Basic;
        //             }
        //         }
        //         addafter(Control83)
        //         {
        //             field("Receiving No. Series"; Rec."Receiving No. Series")
        //             {
        //                 ApplicationArea = Basic;
        //                 Visible = false;
        //             }
        //         }
        //         addfirst("Invoice Details")
        //         {
        //             field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
        //             {
        //                 ApplicationArea = Basic;
        //                 Importance = Promoted;

        //                 trigger OnValidate()
        //                 begin
        //                     PaytoVendorNoOnAfterValidate;
        //                 end;
        //             }
        //         }
        //         moveafter("Buy-from Vendor No."; "Buy-from Contact No.")
        //         moveafter("Buy-from Vendor Name"; "Buy-from Address 2")
        //         moveafter("Buy-from Address 2"; "Buy-from Address")
        //         moveafter("Buy-from Address"; "Buy-from Post Code")
        //         moveafter("Buy-from Post Code"; "Buy-from City")
        //         moveafter("Buy-from City"; "Buy-from Contact")
        //         moveafter("Buy-from Contact"; "No. of Archived Versions")
        //         moveafter("No. of Archived Versions"; "Posting Date")
        //         moveafter("Posting Date"; "Order Date")

        //         moveafter("Order Address Code"; "Purchaser Code")
        //         moveafter("Purchaser Code"; "Responsibility Center")
        //         moveafter("Responsibility Center"; Control71)
        //         moveafter("Shortcut Dimension 2 Code"; "Assigned User ID")
        //         moveafter("Prices Including VAT"; Control83)
        //         moveafter("Posting Description"; PurchLines)
        //         moveafter("Pay-to Contact No."; "Pay-to Name")
        //         moveafter("Pay-to Address 2"; "Pay-to Post Code")
        //         moveafter("Pay-to Post Code"; "Pay-to City")
        //         moveafter("Pay-to City"; "Pay-to Contact")
        //         moveafter("Pay-to Contact"; "Payment Terms Code")
        //         moveafter("Due Date"; "Payment Discount %")
        //         moveafter("Pmt. Discount Date"; "Payment Method Code")
        //         moveafter("Payment Method Code"; "Payment Reference")
        //         moveafter("On Hold"; "VAT Bus. Posting Group")
        //         moveafter("VAT Bus. Posting Group"; "Shipping and Payment")
        //         moveafter("Ship-to Address 2"; "Ship-to Post Code")
        //         moveafter("Ship-to Post Code"; "Ship-to City")
        //         moveafter("Ship-to City"; "Ship-to Contact")
        //         moveafter("Ship-to Contact"; "Location Code")
        //         moveafter("Location Code"; "Inbound Whse. Handling Time")
        //         moveafter("Inbound Whse. Handling Time"; "Shipment Method Code")
        //         moveafter("Shipment Method Code"; "Lead Time Calculation")
        //         moveafter("Promised Receipt Date"; "Expected Receipt Date")
        //         moveafter("Expected Receipt Date"; "Sell-to Customer No.")
        //         moveafter("Ship-to Code"; "Foreign Trade")
        //         moveafter("Currency Code"; "Transaction Type")
        //     }
        //     actions
        //     {
        //         modify(Dimensions)
        //         {
        //             ApplicationArea = Basic;



        //         }
        //         modify(Statistics)
        //         {
        //             ApplicationArea = Basic;


        //         }
        //         modify(Vendor)
        //         {
        //             Caption = 'Card';
        //             ApplicationArea = Basic;


        //         }
        //         modify(Approvals)
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Co&mments")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify(Receipts)
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify(Invoices)
        //         {
        //             ApplicationArea = Basic;


        //         }
        //         modify(PostedPrepaymentInvoices)
        //         {


        //             ApplicationArea = Basic;
        //         }
        //         modify(PostedPrepaymentCrMemos)
        //         {


        //             ApplicationArea = Basic;
        //         }
        //         modify("In&vt. Put-away/Pick Lines")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Whse. Receipt Lines")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Warehouse_GetSalesOrder")
        //         {


        //             ApplicationArea = Basic;
        //         }
        //         modify("Get &Sales Order")
        //         {
        //             ApplicationArea = Basic;


        //         }

        //         modify(Reject)
        //         {


        //             Caption = 'Print LSO';
        //             ApplicationArea = Basic;




        //         }
        //         modify(Release)
        //         {
        //             ApplicationArea = Basic;


        //         }
        //         modify(Reopen)
        //         {
        //             ApplicationArea = Basic;


        //         }
        //         modify(CalculateInvoiceDiscount)
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify(GetRecurringPurchaseLines)
        //         {


        //             Caption = 'Get St&d. Vend. Purchase Codes';
        //             ApplicationArea = Basic;
        //         }
        //         modify(CopyDocument)
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify(MoveNegativeLines)
        //         {


        //             ApplicationArea = Basic;
        //         }
        //         modify("Functions_GetSalesOrder")
        //         {


        //             ApplicationArea = Basic;
        //         }
        //         modify(Action187)
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Archive Document")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Send Intercompany Purchase Order")
        //         {
        //             Caption = 'Send IC Purchase Order';
        //             ApplicationArea = Basic;


        //         }
        //         modify(IncomingDocCard)
        //         {
        //             ToolTip = '';
        //             ApplicationArea = Basic;
        //         }
        //         modify(SelectIncomingDoc)
        //         {
        //             ToolTip = '';
        //             ApplicationArea = Basic;
        //         }
        //         modify(IncomingDocAttachFile)
        //         {
        //             ToolTip = '';
        //             ApplicationArea = Basic;
        //         }
        //         modify(RemoveIncomingDoc)
        //         {
        //             ToolTip = '';
        //             ApplicationArea = Basic;
        //         }
        //         modify(SendApprovalRequest)
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify(CancelApprovalRequest)
        //         {
        //             ApplicationArea = Basic;


        //         }

        //         modify("Create &Whse. Receipt")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Create Inventor&y Put-away/Pick")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify(Post)
        //         {
        //             ApplicationArea = Basic;
        //             visible = false;


        //         }
        //         modify(Preview)
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Post and &Print")
        //         {
        //             ApplicationArea = Basic;


        //         }
        //         modify("Test Report")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Post &Batch")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Remove From Job Queue")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Prepayment Test &Report")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify(PostPrepaymentInvoice)
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Post and Print Prepmt. Invoic&e")
        //         {
        //             ApplicationArea = Basic;
        //         }



        //         modify(PostPrepaymentCreditMemo)
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("Post and Print Prepmt. Cr. Mem&o")
        //         {
        //             ApplicationArea = Basic;
        //         }
        //         modify("&Print")
        //         {
        //             ApplicationArea = Basic;



        //         }



        //         modify(DocAttach)
        //         {
        //             Visible = false;
        //         }






        //         modify(Approve)
        //         {
        //             Visible = false;
        //         }





        //         modify(Delegate)
        //         {
        //             Visible = false;
        //         }
        //         modify(Comment)
        //         {
        //             Visible = false;
        //         }








        //         modify(SeeFlows)
        //         {
        //             Visible = false;
        //         }


        //         modify(PreviewPrepmtInvoicePosting)
        //         {
        //             Visible = false;
        //         }



        //         modify(PreviewPrepmtCrMemoPosting)
        //         {
        //             Visible = false;
        //         }




        //         modify(SendCustom)
        //         {
        //             Visible = false;
        //         }
        //         addfirst(Warehouse)
        //         {
        //             separator(Action181)
        //             {
        //             }
        //         }
        //         addafter("Whse. Receipt Lines")
        //         {
        //             separator(Action182)
        //             {
        //             }
        //         }
        //         addafter(Reopen)
        //         {
        //             separator(Action611)
        //             {
        //             }
        //         }
        //         addafter(CalculateInvoiceDiscount)
        //         {
        //             separator(Action190)
        //             {
        //             }
        //         }
        //         addafter(GetRecurringPurchaseLines)
        //         {
        //             separator(Action75)
        //             {
        //             }
        //         }
        //         addafter(MoveNegativeLines)
        //         {
        //             action("Check Budget Availability")
        //             {
        //                 ApplicationArea = Basic;
        //                 Image = Balance;
        //                 Promoted = true;
        //                 PromotedCategory = Category5;
        //                 PromotedIsBig = true;

        //                 trigger OnAction()
        //                 var
        //                     Doctype: Option LPO,Requisition,Imprest,"Payment Voucher",PettyCash,PurchInvoice,StaffClaim,StaffAdvance;
        //                     PurchaseLine: Record "Purchase Line";
        //                     RequisitionLine: Record "Purchase Line";
        //                     CommittmentLine: Record 52185867;
        //                 begin
        //                     Rec.TestField(Rec.Status, Rec.Status::Open);

        //                     BCSetup.Get;
        //                     if not BCSetup.Mandatory then
        //                         exit;

        //                     if Rec.Status = Rec.Status::Released then
        //                         Error('This document has already been released. This functionality is available for open documents only');

        //                     PurchaseLine.Reset;
        //                     PurchaseLine.SetRange("Document No.", Rec."No.");
        //                     PurchaseLine.SetFilter("Requisition No", '<>%1', '');
        //                     if PurchaseLine.FindSet then
        //                         repeat
        //                             CommittmentLine.Reset;
        //                             CommittmentLine.SetRange(CommittmentLine."Document No.", PurchaseLine."Requisition No");
        //                             CommittmentLine.SetRange(CommittmentLine."Document Line No.", PurchaseLine."Requisition Line No.");
        //                             CommittmentLine.SetRange(CommittmentLine.Committed, false);
        //                             if not CommittmentLine.FindFirst then
        //                                 Commitment.ReverseEntries(Doctype::Requisition, PurchaseLine."Requisition No");
        //                         until PurchaseLine.Next = 0;
        //                     if SomeLinesCommitted then begin
        //                         if not Confirm('Some or All the Lines Are already Committed do you want to continue', true, Rec."Document Type") then
        //                             Error('Budget Availability Check and Commitment Aborted');
        //                         DeleteCommitment.Reset;
        //                         DeleteCommitment.SetRange(DeleteCommitment."Document Type", DeleteCommitment."document type"::LPO);
        //                         DeleteCommitment.SetRange(DeleteCommitment."Document No.", Rec."No.");
        //                         DeleteCommitment.DeleteAll;
        //                     end;
        //                     Commitment.CheckPurchase(Rec);
        //                     Message('Budget Availability Checking Complete');
        //                 end;
        //             }
        //         }
        //         addafter("Send Intercompany Purchase Order")
        //         {
        //             separator(Action189)
        //             {
        //             }
        //         }
        //         addafter("Create Inventor&y Put-away/Pick")
        //         {
        //             separator(Action74)
        //             {
        //             }
        //         }
        //         addafter("Remove From Job Queue")
        //         {
        //             separator(Action201)
        //             {
        //             }
        //         }
        //         addfirst(Print)
        //         {

        //             action(Printing)
        //             {
        //                 ApplicationArea = Basic, Suite;
        //                 Caption = 'Print';
        //                 Image = Print;
        //                 Promoted = true;
        //                 PromotedCategory = Process;
        //                 Visible = true;

        //                 trigger OnAction()
        //                 begin
        //                     //IF Posted=FALSE THEN ERROR('Post the receipt before printing.');
        //                     rec.Reset;
        //                     rec.SetFilter("No.", Rec."No.");
        //                     REPORT.Run(Report::"Purchase Order", true, true, Rec);
        //                     //rec.Reset;
        //                     end;
        //             }
        //         }
        }
    
                    actions
                        {
                            modify("&Print")
                            {
                                trigger OnBeforeAction()
                                var
                                    PurchaseHeader: Record "Purchase Header";
                                begin
                                    // Apply filter to current record
                                    PurchaseHeader := Rec;
                                    CurrPage.SetSelectionFilter(PurchaseHeader);
                                    
                                    // Example: Custom logic before printing
                                    if PurchaseHeader.FindFirst() then begin
                                        REPORT.RUN(Report::"Purchase Order", true, true, PurchaseHeader);
                                    end;
                                end;
                            }
                        }

        //         addafter(Reject)
        //         {
        //             action("EDMS [Case 360]")
        //             {
        //                 ApplicationArea = Basic;
        //                 Image = Document;
        //                 Promoted = true;
        //                 PromotedCategory = Category5;

        //                 trigger OnAction()
        //                 var
        //                     DMS: Record 52185686;
        //                 begin


        //                 end;
        //             }
        //         }

        //         moveafter("Post and Print Prepmt. Invoic&e"; PostPrepaymentCreditMemo)
        //     }

        //     var

        //     var
        //         PurchLine: Record "Purchase Line";

        //     var
        //         PurchPostYesNo: Codeunit "Purch.-Post (Yes/No)";




        //     var
        //         DocPrint: Codeunit "Document-Print";

        //     var
        //         Commitment: Codeunit 52185483;
        //         BCSetup: Record 52185866;
        //         DeleteCommitment: Record 52185867;
        //         PurchaseHeader: Record "Purchase Header";
        //         PurchaseLine: Record "Purchase Line";
























        //     local procedure BuyfromVendorNoOnAfterValidate()
        //     begin
        //         if Rec.GetFilter(Rec."Buy-from Vendor No.") = xRec."Buy-from Vendor No." then
        //             if Rec."Buy-from Vendor No." <> xRec."Buy-from Vendor No." then
        //                 Rec.SetRange(Rec."Buy-from Vendor No.");
        //         CurrPage.Update;
        //     end;

        //     local procedure PurchaserCodeOnAfterValidate()
        //     begin
        //         CurrPage.PurchLines.Page.UpdateForm(true);
        //     end;

        //     local procedure PaytoVendorNoOnAfterValidate()
        //     begin
        //         CurrPage.Update;
        //     end;

        //     local procedure ShortcutDimension1CodeOnAfterV()
        //     begin
        //         CurrPage.Update;
        //     end;

        //     local procedure ShortcutDimension2CodeOnAfterV()
        //     begin
        //         CurrPage.Update;
        //     end;

        //     local procedure PricesIncludingVATOnAfterValid()
        //     begin
        //         CurrPage.Update;
        //     end;

        //     local procedure Prepayment37OnAfterValidate()
        //     begin
        //         CurrPage.Update;
        //     end;

        //     procedure LinesCommitted() Exists: Boolean
        //     var
        //         PurchLines: Record "Purchase Line";
        //     begin
        //         if BCSetup.Get() then begin
        //             if not BCSetup.Mandatory then begin
        //                 Exists := false;
        //                 exit;
        //             end;
        //         end else begin
        //             Exists := false;
        //             exit;
        //         end;
        //         if BCSetup.Get then begin
        //             Exists := false;
        //             PurchLines.Reset;
        //             PurchLines.SetRange(PurchLines."Document Type", Rec."Document Type");
        //             PurchLines.SetRange(PurchLines."Document No.", Rec."No.");
        //             PurchLines.SetRange(PurchLines.Committed, false);
        //             if PurchLines.Find('-') then
        //                 Exists := true;
        //         end else
        //             Exists := false;
        //     end;

        //     procedure SomeLinesCommitted() Exists: Boolean
        //     var
        //         PurchLines: Record "Purchase Line";
        //     begin
        //         if BCSetup.Get then begin
        //             Exists := false;
        //             PurchLines.Reset;
        //             PurchLines.SetRange(PurchLines."Document Type", Rec."Document Type");
        //             PurchLines.SetRange(PurchLines."Document No.", Rec."No.");
        //             PurchLines.SetRange(PurchLines.Committed, true);
        //             if PurchLines.Find('-') then
        //                 Exists := true;
        //         end else
        //             Exists := false;
        //     end;


    }
