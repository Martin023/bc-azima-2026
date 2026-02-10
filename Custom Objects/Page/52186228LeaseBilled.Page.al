// page 52186228 "Lease-Billed"
// {
//     //             RecordInvoice."Document Type":=RecordInvoice."Document Type"::Invoice;
//     //             RecordInvoice."Document Date":=TODAY;
//     //             RecordInvoice."Sell-to Customer No.":=RecordLease."Tenant No.";
//     //             RecordInvoice."Posting Description":='Invoice for Lease No.:' + FORMAT(RecordLease."No.");
//     //             RecordInvoice."Posting Date":=TODAY;
//     //             RecordInvoice."Due Date":=TODAY;
//     //             RecordInvoice."Document Date":=TODAY;
//     //             RecordInvoice."Shipping No. Series":=RecordInvoiceNos."Posted Shipment Nos.";
//     //             RecordInvoice."External Document No.":=RecordLease."No.";
//     //             //validate the tenant number
//     //             RecordInvoice.VALIDATE(RecordInvoice."Sell-to Customer No.");
//     //             RecordInvoice."Shortcut Dimension 1 Code":=RecordLease."Dimension 1 Code";
//     //             RecordInvoice.VALIDATE(RecordInvoice."Shortcut Dimension 1 Code");
//     //             RecordInvoice."Shortcut Dimension 2 Code":=RecordLease."Dimension 2 Code";
//     //             RecordInvoice.VALIDATE(RecordInvoice."Shortcut Dimension 2 Code");
//     //             //insert the property and the lease number into the database
//     //             RecordInvoice."Property No.":=RecordLease."Property No.";
//     //             RecordInvoice."Lease No.":=RecordLease."No.";
//     //             RecordInvoice."Source Document Type":=Source;

//     DeleteAllowed = false;
//     Editable = false;
//     PageType = ListPart;
//     SourceTable = "Leases Billed";
//     ApplicationArea = Basic, Suite;
//     UsageCategory = Lists;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1102755000)
//             {
//                 Editable = true;
//                 ShowCaption = false;
//                 field("Next Bill Date"; Rec."Next Bill Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(InvoiceNo; Rec.InvoiceNo)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field(Charged; Rec.Charged)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Batch No"; Rec."Batch No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Tenant No."; Rec."Tenant No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Tenant Name"; Rec."Tenant Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Total Incl. VAT"; Rec."Total Incl. VAT")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Transaction Name"; Rec."Transaction Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Leased VAT Amount"; Rec."Leased VAT Amount")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Leased Amount"; Rec."Leased Amount")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Property No."; Rec."Property No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("L.R. No."; Rec."L.R. No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Property Name"; Rec."Property Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field(Posted; Rec.Posted)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Landlord No."; Rec."Landlord No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Landlord Name"; Rec."Landlord Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Currency Code"; Rec."Currency Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("Function")
//             {
//                 Caption = 'Function';
//                 Visible = false;
//                 action("Preview Posted Invoice")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Preview Posted Invoice';

//                     trigger OnAction()
//                     begin
//                         Rec.showLease;
//                     end;
//                 }
//             }
//         }
//     }

//     var
//         L: Record Lease;
//         LL: Record "Lease Line";
//         IntC: Integer;
//         BL: Record "Lease Bill Lines";
//         SaleHeader: Record "Sales Header";
//         SaleLine: Record "Sales Line";
//         SRSetup: Record "Sales & Receivables Setup";
//         NextNo: Code[20];
//         NoSeriesMgt: Codeunit NoSeriesManagement;
//         LineNo: Integer;
//         FType: Text[30];
//         FValue: Integer;
//         NoSeries: Record "No. Series Line";
//         LastNo: Code[20];
//         PostInv: Boolean;
//         PrevInv: Boolean;
//         SaleSetup: Record "Sales & Receivables Setup";
//         SalesPost: Codeunit "Sales-Post";
// }

