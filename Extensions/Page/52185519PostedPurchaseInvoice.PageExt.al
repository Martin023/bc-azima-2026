#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
PageExtension 52185519 pageextension52185519 extends "Posted Purchase Invoice"
{
    layout
    {
        modify("No.")
        {
            ApplicationArea = Basic;
        }
        modify("Buy-from Vendor Name")
        {
            ApplicationArea = Basic;
        }
    }
    actions
    {

    }
}
//         // modify("Buy-from")
//         // {

//         //     //Unsupported feature: Property Modification (ControlType) on ""Buy-from"(Control 4)".


//         //     //Unsupported feature: Property Modification (Name) on ""Buy-from"(Control 4)".


//         //     //Unsupported feature: Property Insertion (SourceExpr) on ""Buy-from"(Control 4)".


//         //     //Unsupported feature: Property Insertion (Importance) on ""Buy-from"(Control 4)".

//         //     Editable = false;
//         //     ApplicationArea = Basic;
//         // }
//         modify("Buy-from Address")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Buy-from Address"(Control 61)".

//             ApplicationArea = Basic;
//         }
//         modify("Buy-from Address 2")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Buy-from Address 2"(Control 63)".

//             ApplicationArea = Basic;
//         }
//         modify("Buy-from City")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Buy-from City"(Control 65)".

//             ApplicationArea = Basic;
//         }
//         modify("Buy-from Post Code")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Buy-from Post Code"(Control 6)".

//             ApplicationArea = Basic;
//         }
//         modify("Buy-from Contact No.")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Buy-from Contact No."(Control 100)".

//             ApplicationArea = Basic;
//         }
//         modify("Buy-from Contact")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Posting Date")
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
//         modify("Quote No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Order No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Vendor Invoice No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Vendor Order No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Pre-Assigned No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("No. Printed")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Order Address Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Purchaser Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Responsibility Center")
//         {
//             ApplicationArea = Basic;
//         }
//         // modify(Corrective)
//         // {
//         //     ApplicationArea = Basic;

//         //     //Unsupported feature: Property Modification (SourceExpr) on "Corrective(Control 18)".


//         //Unsupported feature: Property Modification (Importance) on "Corrective(Control 18)".


//         //Unsupported feature: Property Modification (Name) on "Corrective(Control 18)".

//         //     Editable = false;
//         // }
//         modify("Invoice Details")
//         {
//             Caption = 'Invoicing';

//             //Unsupported feature: Property Modification (Name) on ""Invoice Details"(Control 1905885101)".

//         }
//         modify("Currency Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Expected Receipt Date")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Payment Terms Code")
//         {
//             ApplicationArea = Basic;
//         }
//         // modify("Payment Method Code")
//         // {
//         //     ApplicationArea = Basic;
//         // }
//         modify("Shortcut Dimension 1 Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Shortcut Dimension 2 Code")
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
//         modify("Location Code")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (Importance) on ""Location Code"(Control 76)".

//         }
//         modify("Shipment Method Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Payment Reference")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Creditor No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Ship-to")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Ship-to"(Control 1906801201)".

//             Caption = 'Shipping';

//             //Unsupported feature: Property Modification (Name) on ""Ship-to"(Control 1906801201)".

//         }
//         modify("Ship-to Name")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Ship-to Name"(Control 38)".

//             ApplicationArea = Basic;
//         }
//         modify("Ship-to Address")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Ship-to Address"(Control 40)".

//             ApplicationArea = Basic;
//         }
//         modify("Ship-to Address 2")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Ship-to Address 2"(Control 42)".

//             ApplicationArea = Basic;
//         }
//         modify("Ship-to City")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Ship-to City"(Control 44)".

//             ApplicationArea = Basic;
//         }
//         modify("Ship-to Post Code")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Ship-to Post Code"(Control 8)".

//             ApplicationArea = Basic;
//         }
//         modify("Ship-to Contact")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Ship-to Contact"(Control 46)".

//             ApplicationArea = Basic;
//         }
//         modify("Pay-to Name")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Pay-to Name"(Control 20)".

//             ApplicationArea = Basic;
//         }
//         modify("Pay-to Address")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Pay-to Address"(Control 22)".

//             ApplicationArea = Basic;
//         }
//         modify("Pay-to Address 2")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Pay-to Address 2"(Control 24)".

//             ApplicationArea = Basic;
//         }
//         modify("Pay-to City")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Pay-to City"(Control 26)".

//             ApplicationArea = Basic;
//         }
//         modify("Pay-to Post Code")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Pay-to Post Code"(Control 78)".

//             ApplicationArea = Basic;
//         }
//         modify("Pay-to Contact No.")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Pay-to Contact No."(Control 102)".

//             ApplicationArea = Basic;
//         }
//         modify("Pay-to Contact")
//         {

//             //Unsupported feature: Property Modification (Level) on ""Pay-to Contact"(Control 28)".

//             ApplicationArea = Basic;
//         }

//         //Unsupported feature: Property Insertion (Visible) on "Control1905767507(Control 1905767507)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""No."(Control 2)".


//         //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from Vendor Name"(Control 59)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Vendor Name"(Control 59)".


//         //Unsupported feature: Property Deletion (TableRelation) on ""Buy-from Vendor Name"(Control 59)".


//         //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from"(Control 4)".


//         //Unsupported feature: Property Deletion (GroupType) on ""Buy-from"(Control 4)".


//         //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from Address"(Control 61)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Address"(Control 61)".


//         //Unsupported feature: Property Deletion (Importance) on ""Buy-from Address"(Control 61)".


//         //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from Address 2"(Control 63)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Address 2"(Control 63)".


//         //Unsupported feature: Property Deletion (Importance) on ""Buy-from Address 2"(Control 63)".


//         //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from City"(Control 65)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from City"(Control 65)".


//         //Unsupported feature: Property Deletion (Importance) on ""Buy-from City"(Control 65)".

//         modify(Control51)
//         {
//             Visible = false;
//         }
//         modify("Buy-from County")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from Post Code"(Control 6)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Post Code"(Control 6)".


//         //Unsupported feature: Property Deletion (Importance) on ""Buy-from Post Code"(Control 6)".

//         modify("Buy-from Country/Region Code")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from Contact No."(Control 100)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Contact No."(Control 100)".


//         //Unsupported feature: Property Deletion (Importance) on ""Buy-from Contact No."(Control 100)".


//         //Unsupported feature: Property Deletion (CaptionML) on ""Buy-from Contact"(Control 67)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Buy-from Contact"(Control 67)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Posting Date"(Control 12)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Document Date"(Control 71)".


//         //Unsupported feature: Property Deletion (Importance) on ""Document Date"(Control 71)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Due Date"(Control 32)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Quote No."(Control 110)".


//         //Unsupported feature: Property Deletion (Importance) on ""Quote No."(Control 110)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Order No."(Control 81)".


//         //Unsupported feature: Property Deletion (Importance) on ""Order No."(Control 81)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor Invoice No."(Control 14)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Vendor Order No."(Control 104)".


//         //Unsupported feature: Property Deletion (Importance) on ""Vendor Order No."(Control 104)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Pre-Assigned No."(Control 83)".


//         //Unsupported feature: Property Deletion (Importance) on ""Pre-Assigned No."(Control 83)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""No. Printed"(Control 16)".


//         //Unsupported feature: Property Deletion (Importance) on ""No. Printed"(Control 16)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Order Address Code"(Control 7)".


//         //Unsupported feature: Property Deletion (Importance) on ""Order Address Code"(Control 7)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Purchaser Code"(Control 10)".


//         //Unsupported feature: Property Deletion (Importance) on ""Purchaser Code"(Control 10)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Responsibility Center"(Control 92)".


//         //Unsupported feature: Property Deletion (Importance) on ""Responsibility Center"(Control 92)".

//         modify(Cancelled)
//         {
//             Visible = false;
//         }
//         // modify(Corrective)
//         // {
//         //     Visible = false;
//         // }

//         //Unsupported feature: Property Deletion (ToolTipML) on "Corrective(Control 18)".


//         //Unsupported feature: Property Deletion (Style) on "Corrective(Control 18)".


//         //Unsupported feature: Property Deletion (StyleExpr) on "Corrective(Control 18)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on "PurchInvLines(Control 52)".


//         //Unsupported feature: Property Deletion (GroupType) on ""Invoice Details"(Control 1905885101)".


//         //Unsupported feature: Code Modification on ""Currency Code"(Control 87).OnAssistEdit".

//         //trigger OnAssistEdit()
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         ChangeExchangeRate.SetParameter("Currency Code","Currency Factor","Posting Date");
//         ChangeExchangeRate.EDITABLE(FALSE);
//         IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
//           "Currency Factor" := ChangeExchangeRate.GetParameter;
//           UpdateCurrencyFactor.ModifyPostedPurchaseInvoice(Rec);
//         END;
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         #1..4
//           MODIFY;
//         END;
//         CLEAR(ChangeExchangeRate);
//         */
//         //end;

//         //Unsupported feature: Property Deletion (ToolTipML) on ""Currency Code"(Control 87)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Expected Receipt Date"(Control 50)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Terms Code"(Control 30)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Method Code"(Control 84)".


//         //Unsupported feature: Property Deletion (Importance) on ""Payment Method Code"(Control 84)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 1 Code"(Control 72)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Shortcut Dimension 2 Code"(Control 74)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Discount %"(Control 34)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Pmt. Discount Date"(Control 36)".


//         //Unsupported feature: Property Deletion (Importance) on ""Pmt. Discount Date"(Control 36)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Location Code"(Control 76)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Shipment Method Code"(Control 48)".


//         //Unsupported feature: Property Deletion (Importance) on ""Shipment Method Code"(Control 48)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Payment Reference"(Control 3)".


//         //Unsupported feature: Property Deletion (Importance) on ""Payment Reference"(Control 3)".


//         //Unsupported feature: Property Deletion (Editable) on ""Payment Reference"(Control 3)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Creditor No."(Control 5)".


//         //Unsupported feature: Property Deletion (Importance) on ""Creditor No."(Control 5)".


//         //Unsupported feature: Property Deletion (Editable) on ""Creditor No."(Control 5)".

//         modify("Shipping and Payment")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (GroupType) on ""Ship-to"(Control 1906801201)".

//         modify("Ship-to Code")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Name"(Control 38)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Name"(Control 38)".


//         //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Address"(Control 40)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Address"(Control 40)".


//         //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Address 2"(Control 42)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Address 2"(Control 42)".


//         //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to City"(Control 44)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to City"(Control 44)".

//         modify(Control58)
//         {
//             Visible = false;
//         }
//         modify("Ship-to County")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Post Code"(Control 8)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Post Code"(Control 8)".

//         modify("Ship-to Country/Region Code")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (CaptionML) on ""Ship-to Contact"(Control 46)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Ship-to Contact"(Control 46)".

//         modify("Pay-to")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (CaptionML) on ""Pay-to Name"(Control 20)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Name"(Control 20)".


//         //Unsupported feature: Property Deletion (Importance) on ""Pay-to Name"(Control 20)".


//         //Unsupported feature: Property Deletion (CaptionML) on ""Pay-to Address"(Control 22)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Address"(Control 22)".


//         //Unsupported feature: Property Deletion (Importance) on ""Pay-to Address"(Control 22)".


//         //Unsupported feature: Property Deletion (CaptionML) on ""Pay-to Address 2"(Control 24)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Address 2"(Control 24)".


//         //Unsupported feature: Property Deletion (Importance) on ""Pay-to Address 2"(Control 24)".


//         //Unsupported feature: Property Deletion (CaptionML) on ""Pay-to City"(Control 26)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to City"(Control 26)".


//         //Unsupported feature: Property Deletion (Importance) on ""Pay-to City"(Control 26)".

//         modify(Control60)
//         {
//             Visible = false;
//         }
//         modify("Pay-to County")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (CaptionML) on ""Pay-to Post Code"(Control 78)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Post Code"(Control 78)".


//         //Unsupported feature: Property Deletion (Importance) on ""Pay-to Post Code"(Control 78)".

//         modify("Pay-to Country/Region Code")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (CaptionML) on ""Pay-to Contact No."(Control 102)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Contact No."(Control 102)".


//         //Unsupported feature: Property Deletion (Importance) on ""Pay-to Contact No."(Control 102)".


//         //Unsupported feature: Property Deletion (CaptionML) on ""Pay-to Contact"(Control 28)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Pay-to Contact"(Control 28)".

//         modify("Attached Documents")
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ApplicationArea) on "IncomingDocAttachFactBox(Control 9)".


//         //Unsupported feature: Property Deletion (Visible) on "IncomingDocAttachFactBox(Control 9)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on "Control1900383207(Control 1900383207)".


//         //Unsupported feature: Property Deletion (ApplicationArea) on "Control1905767507(Control 1905767507)".

//         addafter("Invoice Details")
//         {
//             group("Foreign Trade")
//             {
//                 Caption = 'Foreign Trade';
//             }
//         }
//         moveafter("No."; "Buy-from")
//         // moveafter("Buy-from Vendor No.";"Buy-from Contact No.")
//         moveafter("Buy-from Address 2"; "Buy-from Post Code")
//         moveafter("Buy-from Contact"; "No. Printed")
//         moveafter("Document Date"; "Quote No.")
//         moveafter("Order No."; "Pre-Assigned No.")
//         moveafter("Pre-Assigned No."; "Vendor Order No.")
//         moveafter("Vendor Order No."; "Vendor Invoice No.")
//         moveafter("Vendor Invoice No."; "Order Address Code")
//         //moveafter("Responsibility Center"; PurchInvLines)
//         // moveafter(Invoicing;Corrective)
//         // moveafter("Pay-to Vendor No.";"Pay-to Contact No.")
//         moveafter("Pay-to Contact No."; "Pay-to Name")
//         moveafter("Pay-to Address 2"; "Pay-to Post Code")
//         moveafter("Pay-to Post Code"; "Pay-to City")
//         moveafter("Pay-to City"; "Pay-to Contact")
//         moveafter("Pay-to Contact"; "Shortcut Dimension 1 Code")
//         moveafter("Shortcut Dimension 2 Code"; "Payment Terms Code")
//         moveafter("Due Date"; "Payment Discount %")
//         // moveafter("Pmt. Discount Date";"Payment Method Code")
//         // moveafter("Payment Method Code";"Payment Reference")
//         moveafter("Ship-to Address 2"; "Ship-to Post Code")
//         moveafter("Ship-to Post Code"; "Ship-to City")
//         moveafter("Ship-to City"; "Ship-to Contact")
//         moveafter("Ship-to Contact"; "Location Code")
//         moveafter("Shipment Method Code"; "Expected Receipt Date")
//     }
//     actions
//     {
//         modify(Statistics)
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (PromotedCategory) on "Statistics(Action 45)".

//         }
//         modify("Co&mments")
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Dimensions)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Approvals)
//         {
//             ApplicationArea = Basic;
//         }
//         modify("&Navigate")
//         {
//             ApplicationArea = Basic;

//             //Unsupported feature: Property Modification (PromotedCategory) on ""&Navigate"(Action 57)".

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

//         //Unsupported feature: Property Deletion (ToolTipML) on "Statistics(Action 45)".


//         //Unsupported feature: Property Deletion (PromotedIsBig) on "Statistics(Action 45)".


//         //Unsupported feature: Property Deletion (ToolTipML) on ""Co&mments"(Action 55)".


//         //Unsupported feature: Property Deletion (Promoted) on ""Co&mments"(Action 55)".


//         //Unsupported feature: Property Deletion (PromotedCategory) on ""Co&mments"(Action 55)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Dimensions(Action 89)".


//         //Unsupported feature: Property Deletion (Promoted) on "Dimensions(Action 89)".


//         //Unsupported feature: Property Deletion (PromotedIsBig) on "Dimensions(Action 89)".


//         //Unsupported feature: Property Deletion (PromotedCategory) on "Dimensions(Action 89)".


//         //Unsupported feature: Property Deletion (AccessByPermission) on "Approvals(Action 106)".


//         //Unsupported feature: Property Deletion (ToolTipML) on "Approvals(Action 106)".


//         //Unsupported feature: Property Deletion (Promoted) on "Approvals(Action 106)".


//         //Unsupported feature: Property Deletion (PromotedCategory) on "Approvals(Action 106)".

//         // modify(Print)
//         // {
//         //     Visible = false;
//         // }
//         // modify(Correct)
//         // {
//         //     Visible = false;
//         // }
//         // modify(CorrectInvoice)
//         // {
//         //     ApplicationArea = Basic, suite;
//         // }
//         // modify(CancelInvoice)
//         // {
//         //     Visible = false;
//         // }
//         // modify(CreateCreditMemo)
//         // {
//         //     ApplicationArea = Basic, suite;
//         // }
//         // modify(ShowCreditMemo)
//         // {
//         //     ApplicationArea = Basic, suite;
//         // }
//         // modify("Actions")
//         // {

//         // }
//         // modify(Vendor)
//         // {
//         //     ApplicationArea = Basic, suite;
//         // }
//         // modify(Navigate)
//         // {
//         //     Visible = false;
//         // }
//         modify(DocAttach)
//         {
//             Visible = false;
//         }

//         //Unsupported feature: Property Deletion (ToolTipML) on ""&Navigate"(Action 57)".


//         //Unsupported feature: Property Deletion (Visible) on ""&Navigate"(Action 57)".



//         //Unsupported feature: Code Modification on "SelectIncomingDoc(Action 15).OnAction".

//         //trigger OnAction()
//         //Parameters and return type have not been exported.
//         //>>>> ORIGINAL CODE:
//         //begin
//         /*
//         IncomingDocument.SelectIncomingDocumentForPostedDocument("No.","Posting Date",RECORDID);
//         */
//         //end;
//         //>>>> MODIFIED CODE:
//         //begin
//         /*
//         IncomingDocument.SelectIncomingDocumentForPostedDocument("No.","Posting Date");
//         */
//         //end;
//         modify("Update Document")
//         {
//             Visible = false;
//         }
//         addfirst(Processing)
//         {
//             action("&Print")
//             {
//                 ApplicationArea = Basic;
//                 Caption = '&Print';
//                 Ellipsis = true;
//                 Image = Print;
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 begin
//                     // CurrPage.SetSelectionFilter(PurchInvHeader);
//                     // PurchInvHeader.PrintRecords(true);
//                 end;
//             }
//         }
//     }

//     var
//         ChangeExchangeRate: Page "Change Exchange Rate";


//     //Unsupported feature: Code Modification on "OnOpenPage".

//     //trigger OnOpenPage()
//     //>>>> ORIGINAL CODE:
//     //begin
//     /*
//     SetSecurityFilterOnRespCenter;
//     IsOfficeAddin := OfficeMgt.IsAvailable;
//     IsFoundationEnabled := ApplicationAreaMgmtFacade.IsFoundationEnabled;

//     ActivateFields;
//     */
//     //end;
//     //>>>> MODIFIED CODE:
//     //begin
//     /*
//     SetSecurityFilterOnRespCenter;
//     */
//     //end;

//     //Unsupported feature: Property Deletion (PromotedActionCategoriesML).

// }
