// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// PageExtension 52187137 pageextension52187137 extends "Purchase Order List"
// {
//     Editable = true;
//     layout
//     {
//         modify("No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Buy-from Vendor No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Order Address Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Buy-from Vendor Name")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Vendor Authorization No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Buy-from Post Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Buy-from Country/Region Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Buy-from Contact")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Pay-to Vendor No.")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Pay-to Name")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Pay-to Post Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Pay-to Country/Region Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Pay-to Contact")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Ship-to Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Ship-to Name")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Ship-to Post Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Ship-to Country/Region Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Ship-to Contact")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Posting Date")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Shortcut Dimension 1 Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Shortcut Dimension 2 Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Location Code")
//         {
//             ApplicationArea = Basic;


//         }
//         modify("Purchaser Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Assigned User ID")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Currency Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Document Date")
//         {
//             ApplicationArea = Basic;


//         }
//         modify(Status)
//         {
//             ApplicationArea = Basic;


//         }
//         modify("Payment Terms Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Due Date")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Payment Discount %")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Payment Method Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Shipment Method Code")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Requested Receipt Date")
//         {
//             ApplicationArea = Basic;
//         }
//         modify("Job Queue Status")
//         {
//             ApplicationArea = Basic;
//         }

     
//         modify("Amount Received Not Invoiced excl. VAT (LCY)")
//         {
//             Visible = false;
//         }
//         modify("Amount Received Not Invoiced (LCY)")
//         {
//             Visible = false;
//         }
//         modify(Amount)
//         {
//             Visible = false;
//         }
//         modify("Amount Including VAT")
//         {
//             Visible = false;
//         }
//         modify("Posting Description")
//         {
//             Visible = false;
//         }

       
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
//         modify(PostedPurchaseInvoices)
//         {


//             ApplicationArea = Basic;


//         }
//         modify(PostedPurchasePrepmtInvoices)
//         {


//             ApplicationArea = Basic;
//         }
//         modify("Prepayment Credi&t Memos")
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
       
//         modify(Print)
//         {
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
//         modify("Send IC Purchase Order")
//         {
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
//         modify(TestReport)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(Post)
//         {
//             ApplicationArea = Basic;


//         }
//         modify(Preview)
//         {
//             ApplicationArea = Basic;
//         }
//         modify(PostAndPrint)
//         {
//             ApplicationArea = Basic;


//         }
//         modify(PostBatch)
//         {
//             ApplicationArea = Basic;


//         }
//         modify(RemoveFromJobQueue)
//         {
//             ApplicationArea = Basic;
//         }
      
       
//          modify(Send)
//         {
//             Visible = false;
//         }

       

//         modify("Delete Invoiced")
//         {
//             Visible = false;
//         }

//         addafter("Prepayment Credi&t Memos")
//         {
//             separator(Action1102601037)
//             {
//             }
//         }
//         addafter("Whse. Receipt Lines")
//         {
//             separator(Action1102601040)
//             {
//             }
//         }
//         addafter(Reopen)
//         {
//             separator(Action1102601023)
//             {
//             }
//         }
//         addafter("Create Inventor&y Put-away/Pick")
//         {
//             separator(Action1102601017)
//             {
//             }
//         }
//         addafter(RemoveFromJobQueue)
//         {
//             action("Delivery Note")
//             {
//                 ApplicationArea = Basic;

//                 trigger OnAction()
//                 begin
//                     DMS.Reset;
//                     DMS.SetRange(DMS.Key, DMS.Key::"Delivery Note");
//                     if DMS.Find('-') then begin
//                         Hyperlink(DMS."url path" + Rec."No.");
//                     end;
//                 end;
//             }
//         }
//     }

//     var

//     var
//         DimMgt: Codeunit DimensionManagement;

//     var
//         DocPrint: Codeunit "Document-Print";

//     var
//         DMS: Record 52185686;
// }
