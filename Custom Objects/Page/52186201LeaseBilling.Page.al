// page 52186201 "Lease-Billing"
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

//     PageType = List;
//     SourceTable = Lease;
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
//                 field(Select; Rec.Select)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Total Amount Excl. VAT"; Rec."Total Amount Excl. VAT")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Date Registered"; Rec."Date Registered")
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
//                 field("Floor No."; Rec."Floor No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Floor Name"; Rec."Floor Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Batch No"; Rec."Batch No")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Unit Code"; Rec."Unit Code")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Unit Description"; Rec."Unit Description")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Unit Type"; Rec."Unit Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Unit Type Description"; Rec."Unit Type Description")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Unit Sub Type"; Rec."Unit Sub Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Unit Sub Type Description"; Rec."Unit Sub Type Description")
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
//                 field("Letter Of Offer"; Rec."Letter Of Offer")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Lease Agreement Ref. No."; Rec."Lease Agreement Ref. No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Lease Commence Date"; Rec."Lease Commence Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Expiry Date"; Rec."Expiry Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Billing Frequency"; Rec."Billing Frequency")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Billing Frequency Value"; Rec."Billing Frequency Value")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Duration Type"; Rec."Duration Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Duration Value"; Rec."Duration Value")
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
//                 action("Select All")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Select All';

//                     trigger OnAction()
//                     begin
//                         Rec.SetFilter(Blocked, Format(false));
//                         Rec.SetFilter(Commenced, Format(true));
//                         Rec.SetFilter("Next Bill Date", '<=' + Format(Today));
//                         repeat
//                             Rec.Select := true;
//                             Rec.Modify;
//                         until Rec.Next = 0;
//                     end;
//                 }
//                 action("Unselect All")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Unselect All';

//                     trigger OnAction()
//                     begin
//                         Rec.SetFilter(Blocked, Format(false));
//                         Rec.SetFilter(Commenced, Format(true));
//                         Rec.SetFilter("Next Bill Date", '<=' + Format(Today));
//                         repeat
//                             Rec.Select := false;
//                             Rec.Modify;
//                         until Rec.Next = 0;
//                     end;
//                 }
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin
//         Rec.SetFilter(Blocked, Format(false));
//         Rec.SetFilter(Commenced, Format(true));
//         Rec.SetFilter("Next Bill Date", '<=' + Format(Today));

//         repeat
//             Rec.CalcFields("Total Amount Excl. VAT");
//             BilledLease.Reset;
//             if BilledLease.FindLast then
//                 LineNo1 := BilledLease.InvoiceNo + 1;

//             BilledLease.Reset;
//             BilledLease.SetRange(BilledLease."No.", Rec."No.");
//             BilledLease.SetRange(BilledLease."Next Bill Date", Rec."Next Bill Date");
//             if not BilledLease.Find('-') = true then begin
//                 //Get Batch No
//                 LineNo1 := LineNo1 + 1;
//                 BatchNo.Reset;
//                 BatchNo.SetRange(BatchNo.Posted, false);
//                 if BatchNo.Find('+') then
//                     BatchNo1 := BatchNo."Batch No.";
//                 //Get Batch No
//                 BilledLease.Init;
//                 BilledLease.InvoiceNo := LineNo1;
//                 BilledLease."No." := Rec."No.";
//                 BilledLease."Next Bill Date" := Rec."Next Bill Date";
//                 BilledLease."Date Registered" := Rec."Date Registered";
//                 BilledLease."Property No." := Rec."Property No.";
//                 BilledLease."L.R. No." := Rec."L.R. No.";
//                 BilledLease."Property Name" := Rec."Property Name";
//                 BilledLease."Unit Code" := Rec."Unit Code";
//                 BilledLease."Batch No" := BatchNo1;
//                 BilledLease."Landlord No." := Rec."Landlord No.";
//                 BilledLease."Landlord Name" := Rec."Landlord Name";
//                 BilledLease."Tenant No." := Rec."Tenant No.";
//                 BilledLease."Tenant Name" := Rec."Tenant Name";
//                 BilledLease."Leased Amount" := Rec."Total Amount Excl. VAT";
//                 BilledLease."Billing Frequency" := Rec."Billing Frequency";
//                 BilledLease."Billing Frequency Value" := Rec."Billing Frequency Value";
//                 BilledLease."Last Bill Date" := Rec."Last Bill Date";
//                 BilledLease."Transaction Code" := Rec."Transaction Code";
//                 BilledLease."Property No." := Rec."Property No.";
//                 BilledLease.Insert;
//             end;
//         //END;
//         until Rec.Next = 0;
//         //MESSAGE('RECORDS ARLEADY EXIST');
//     end;

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
//         BilledLease: Record "Leases Billed";
//         //BatchNo: Record "Bills Batch";
//         BatchNo1: Code[30];
//         LineNo1: Integer;
// }

