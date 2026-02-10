// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185842 "Process Batch Invoices"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/Process Batch Invoices.rdl';

//     dataset
//     {
//         dataitem(Lease; Lease)
//         {
//             RequestFilterFields = "Next Bill Date";


//             column(No_Lease; Lease."No.")
//             {
//             }
//             column(DateRegistered_Lease; Lease."Date Registered")
//             {
//             }
//             column(PropertyNo_Lease; Lease."Property No.")
//             {
//             }
//             column(LRNo_Lease; Lease."L.R. No.")
//             {
//             }
//             column(PropertyName_Lease; Lease."Property Name")
//             {
//             }
//             column(FloorNo_Lease; Lease."Floor No.")
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin

//                 //new processing format
//                 //new processing generation

//                 Lease.SetFilter(Blocked, Format(false));
//                 Lease.SetFilter(Commenced, Format(true));
//                 Lease.SetFilter("Expiry Date", '>=%1', Today);
//                 if Lease.Find('-') then begin
//                     BilledLease.Reset;
//                     if BilledLease.FindLast then
//                         LineNo1 := BilledLease.InvoiceNo + 1;

//                     //mkirema
//                     repeat
//                         Lease.CalcFields("Total Amount Excl. VAT", "Total VAT Amount");

//                         BilledLease.Reset;
//                         BilledLease.SetRange(BilledLease."No.", "No.");
//                         BilledLease.SetRange(BilledLease."Next Bill Date", "Next Bill Date");
//                         BilledLease.SetRange(BilledLease.Posted, false);
//                         if BilledLease.Find('-') then
//                             BilledLease.DeleteAll;

//                         BilledLease.Reset;
//                         BilledLease.SetRange(BilledLease."No.", "No.");
//                         BilledLease.SetRange(BilledLease."Next Bill Date", "Next Bill Date");
//                         if not BilledLease.Find('-') = true then begin
//                             //Get Batch No
//                             BatchNo.Reset;
//                             BatchNo.SetRange(BatchNo.Posted, false);
//                             if BatchNo.FindLast then begin
//                                 if BatchNo."Batch No." <> '' then
//                                     BatchNo1 := BatchNo."Batch No.";
//                             end;
//                             //Insert the each lease charge lines in the batch lines
//                             LeaseL.Reset;
//                             LeaseL.SetRange(LeaseL."Lease No.", "No.");
//                             if LeaseL.Find('-') then begin
//                                 if "Last Bill Date" = "Next Bill Date" then begin
//                                     repeat
//                                         LeaseL.CalcFields(LeaseL."No.");
//                                         //insert the leases that are billed for the first time (whole charges including charge once)
//                                         HOLDLEASE := HOLDLEASE1;
//                                         if (LeaseL."Lease No." = HOLDLEASE) then begin
//                                             LineNo1 := LineNo1;
//                                             BilledLease.Init;
//                                             BilledLease.InvoiceNo := LineNo1;
//                                             BilledLease."No." := "No.";
//                                             BilledLease."Next Bill Date" := "Next Bill Date";
//                                             BilledLease."Date Registered" := "Date Registered";
//                                             BilledLease."Property No." := "Property No.";
//                                             BilledLease."L.R. No." := "L.R. No.";
//                                             BilledLease."Property Name" := "Property Name";
//                                             BilledLease."Unit Code" := "Unit Code";
//                                             BilledLease."Batch No" := BatchNo1;
//                                             //insert charge name
//                                             BilledLease."Charge Name" := LeaseL."Charge Name";
//                                             BilledLease."Currency Code" := "Currency Code";
//                                             BilledLease.Description := LeaseL."Charge Name";
//                                             BilledLease."Landlord No." := "Landlord No.";
//                                             BilledLease."Landlord Name" := "Landlord Name";
//                                             BilledLease."Tenant No." := "Tenant No.";
//                                             BilledLease."Tenant Name" := "Tenant Name";
//                                             BilledLease."Expiry Date" := "Expiry Date";
//                                             LeaseL.CalcFields(LeaseL."No.");
//                                             BilledLease."G/L Account" := LeaseL."No.";
//                                             BilledLease."Global Dimension 1 Code" := "Global Dimension 1 Code";
//                                             BilledLease."Global Dimension 2 Code" := "Global Dimension 2 Code";
//                                             //bill monthly
//                                             if (Lease."Billing Frequency" = Lease."billing frequency"::Monthly) then begin
//                                                 BilledLease."Leased Amount" := ROUND(LeaseL."Amount Exclusive VAT", 1, '=');
//                                                 BilledLease."Leased VAT Amount" := ROUND(LeaseL."VAT Amount", 1, '=');
//                                                 BilledLease."Total Incl. VAT" := ROUND(LeaseL."Total Amount Inclusive VAT", 1, '=');
//                                             end else
//                                                 if (Lease."Billing Frequency" = Lease."billing frequency"::Quarterly) then begin
//                                                     BilledLease."Leased Amount" := ROUND(LeaseL."Amount Exclusive VAT", 1, '=');
//                                                     BilledLease."Leased VAT Amount" := ROUND(LeaseL."VAT Amount", 1, '=');
//                                                     BilledLease."Total Incl. VAT" := ROUND(LeaseL."Total Amount Inclusive VAT", 1, '=');
//                                                 end else
//                                                     if (Lease."Billing Frequency" = Lease."billing frequency"::Annually) then begin
//                                                         BilledLease."Leased Amount" := ROUND(LeaseL."Amount Exclusive VAT", 1, '=');
//                                                         BilledLease."Leased VAT Amount" := ROUND(LeaseL."VAT Amount", 1, '=');
//                                                         BilledLease."Total Incl. VAT" := ROUND(LeaseL."Total Amount Inclusive VAT", 1, '=');
//                                                     end else
//                                                         if (Lease."Billing Frequency" = Lease."billing frequency"::"Semi Annually") then begin
//                                                             BilledLease."Leased Amount" := ROUND(LeaseL."Amount Exclusive VAT", 1, '=');
//                                                             BilledLease."Leased VAT Amount" := ROUND(LeaseL."VAT Amount", 1, '=');
//                                                             BilledLease."Total Incl. VAT" := ROUND(LeaseL."Total Amount Inclusive VAT", 1, '=');
//                                                         end;

//                                             BilledLease."Billing Frequency" := "Billing Frequency";
//                                             BilledLease."Billing Frequency Value" := "Billing Frequency Value";
//                                             BilledLease."Last Bill Date" := "Last Bill Date";
//                                             BilledLease."Transaction Code" := LeaseL."Transaction Code";
//                                             BilledLease."Property No." := "Property No.";
//                                             BilledLease.Charged := LeaseL.Charged;
//                                             BilledLease."Transaction Name" := LeaseL."Charge Name";
//                                             BilledLease.Insert;
//                                             BilledLease.Modify;
//                                             HOLDLEASE1 := LeaseL."Lease No.";
//                                         end
//                                         else
//                                             if (LeaseL."Lease No." <> HOLDLEASE) then begin
//                                                 LineNo1 := LineNo1 + 1;
//                                                 BilledLease.Init;
//                                                 BilledLease.InvoiceNo := LineNo1;
//                                                 BilledLease."No." := "No.";
//                                                 BilledLease."Next Bill Date" := "Next Bill Date";
//                                                 BilledLease."Date Registered" := "Date Registered";
//                                                 BilledLease."Property No." := "Property No.";
//                                                 BilledLease."L.R. No." := "L.R. No.";
//                                                 BilledLease."Property Name" := "Property Name";
//                                                 BilledLease."Unit Code" := "Unit Code";
//                                                 BilledLease."Batch No" := BatchNo1;
//                                                 BilledLease."Currency Code" := "Currency Code";
//                                                 //insert charge name
//                                                 BilledLease."Charge Name" := LeaseL."Charge Name";
//                                                 BilledLease.Description := LeaseL."Charge Name";
//                                                 BilledLease."Landlord No." := "Landlord No.";
//                                                 BilledLease."Landlord Name" := "Landlord Name";
//                                                 BilledLease."Tenant No." := "Tenant No.";
//                                                 BilledLease."Tenant Name" := "Tenant Name";
//                                                 BilledLease."Expiry Date" := "Expiry Date";
//                                                 LeaseL.CalcFields(LeaseL."No.");
//                                                 BilledLease."G/L Account" := LeaseL."No.";
//                                                 BilledLease."Global Dimension 1 Code" := "Global Dimension 1 Code";
//                                                 BilledLease."Global Dimension 2 Code" := "Global Dimension 2 Code";
//                                                 //bill monthly
//                                                 if (Lease."Billing Frequency" = Lease."billing frequency"::Monthly) then begin
//                                                     BilledLease."Leased Amount" := ROUND(LeaseL."Amount Exclusive VAT", 1, '=');
//                                                     BilledLease."Leased VAT Amount" := ROUND(LeaseL."VAT Amount", 1, '=');
//                                                     BilledLease."Total Incl. VAT" := ROUND(LeaseL."Total Amount Inclusive VAT", 1, '=');
//                                                 end else
//                                                     if (Lease."Billing Frequency" = Lease."billing frequency"::Quarterly) then begin
//                                                         BilledLease."Leased Amount" := ROUND(LeaseL."Amount Exclusive VAT", 1, '=');
//                                                         BilledLease."Leased VAT Amount" := ROUND(LeaseL."VAT Amount", 1, '=');
//                                                         BilledLease."Total Incl. VAT" := ROUND(LeaseL."Total Amount Inclusive VAT", 1, '=');
//                                                     end else
//                                                         if (Lease."Billing Frequency" = Lease."billing frequency"::Annually) then begin
//                                                             BilledLease."Leased Amount" := ROUND(LeaseL."Amount Exclusive VAT", 1, '=');
//                                                             BilledLease."Leased VAT Amount" := ROUND(LeaseL."VAT Amount", 1, '=');
//                                                             BilledLease."Total Incl. VAT" := ROUND(LeaseL."Total Amount Inclusive VAT", 1, '=');
//                                                         end else
//                                                             if (Lease."Billing Frequency" = Lease."billing frequency"::"Semi Annually") then begin
//                                                                 BilledLease."Leased Amount" := ROUND(LeaseL."Amount Exclusive VAT", 1, '=');
//                                                                 BilledLease."Leased VAT Amount" := ROUND(LeaseL."VAT Amount", 1, '=');
//                                                                 BilledLease."Total Incl. VAT" := ROUND(LeaseL."Total Amount Inclusive VAT", 1, '=');
//                                                             end;

//                                                 BilledLease."Billing Frequency" := "Billing Frequency";
//                                                 BilledLease."Billing Frequency Value" := "Billing Frequency Value";
//                                                 BilledLease."Last Bill Date" := "Last Bill Date";
//                                                 BilledLease."Transaction Code" := LeaseL."Transaction Code";
//                                                 BilledLease."Property No." := "Property No.";
//                                                 BilledLease.Charged := LeaseL.Charged;
//                                                 BilledLease."Transaction Name" := LeaseL."Charge Name";
//                                                 BilledLease.Insert;
//                                                 BilledLease.Modify;
//                                                 HOLDLEASE1 := LeaseL."Lease No.";
//                                             end;
//                                     until LeaseL.Next = 0;
//                                 end else      //insert recurring charges in the batch lines
//                                     CHARGES.Reset;
//                                 CHARGES.SetRange(CHARGES.Code, LeaseL."Charge No.");
//                                 if CHARGES.Find('-') then begin
//                                     if ("Last Bill Date" <> "Next Bill Date") then begin
//                                         repeat
//                                             if (LeaseL."Charge Once" = false) and (CHARGES."Charge Once" = false) then begin
//                                                 HOLDLEASE := HOLDLEASE1;
//                                                 if (LeaseL."Lease No." = HOLDLEASE) then begin
//                                                     LineNo1 := LineNo1;
//                                                     BilledLease.Init;
//                                                     BilledLease.InvoiceNo := LineNo1;
//                                                     BilledLease."No." := "No.";
//                                                     BilledLease."Next Bill Date" := "Next Bill Date";
//                                                     BilledLease."Date Registered" := "Date Registered";
//                                                     BilledLease."Property No." := "Property No.";
//                                                     BilledLease."L.R. No." := "L.R. No.";
//                                                     BilledLease."Property Name" := "Property Name";
//                                                     BilledLease."Unit Code" := "Unit Code";
//                                                     BilledLease."Batch No" := BatchNo1;
//                                                     BilledLease."Currency Code" := "Currency Code";
//                                                     //insert charge name
//                                                     BilledLease."Charge Name" := LeaseL."Charge Name";
//                                                     BilledLease.Description := LeaseL."Charge Name";
//                                                     BilledLease."Landlord No." := "Landlord No.";
//                                                     BilledLease."Landlord Name" := "Landlord Name";
//                                                     BilledLease."Tenant No." := "Tenant No.";
//                                                     BilledLease."Tenant Name" := "Tenant Name";
//                                                     BilledLease."Expiry Date" := "Expiry Date";
//                                                     LeaseL.CalcFields(LeaseL."No.");
//                                                     BilledLease."G/L Account" := LeaseL."No.";
//                                                     BilledLease."Global Dimension 1 Code" := "Global Dimension 1 Code";
//                                                     BilledLease."Global Dimension 2 Code" := "Global Dimension 2 Code";
//                                                     //bill monthly
//                                                     if (Lease."Billing Frequency" = Lease."billing frequency"::Monthly) then begin
//                                                         BilledLease."Leased Amount" := ROUND(LeaseL."Amount Exclusive VAT", 1, '=');
//                                                         BilledLease."Leased VAT Amount" := ROUND(LeaseL."VAT Amount", 1, '=');
//                                                         BilledLease."Total Incl. VAT" := ROUND(LeaseL."Total Amount Inclusive VAT", 1, '=');
//                                                     end else
//                                                         if (Lease."Billing Frequency" = Lease."billing frequency"::Quarterly) then begin
//                                                             BilledLease."Leased Amount" := ROUND(LeaseL."Amount Exclusive VAT", 1, '=');
//                                                             BilledLease."Leased VAT Amount" := ROUND(LeaseL."VAT Amount", 1, '=');
//                                                             BilledLease."Total Incl. VAT" := ROUND(LeaseL."Total Amount Inclusive VAT", 1, '=');
//                                                         end else
//                                                             if (Lease."Billing Frequency" = Lease."billing frequency"::Annually) then begin
//                                                                 BilledLease."Leased Amount" := ROUND(LeaseL."Amount Exclusive VAT", 1, '=');
//                                                                 BilledLease."Leased VAT Amount" := ROUND(LeaseL."VAT Amount", 1, '=');
//                                                                 BilledLease."Total Incl. VAT" := ROUND(LeaseL."Total Amount Inclusive VAT", 1, '=');
//                                                             end else
//                                                                 if (Lease."Billing Frequency" = Lease."billing frequency"::"Semi Annually") then begin
//                                                                     BilledLease."Leased Amount" := ROUND(LeaseL."Amount Exclusive VAT", 1, '=');
//                                                                     BilledLease."Leased VAT Amount" := ROUND(LeaseL."VAT Amount", 1, '=');
//                                                                     BilledLease."Total Incl. VAT" := ROUND(LeaseL."Total Amount Inclusive VAT", 1, '=');
//                                                                 end;

//                                                     BilledLease."Billing Frequency" := "Billing Frequency";
//                                                     BilledLease."Billing Frequency Value" := "Billing Frequency Value";
//                                                     BilledLease."Last Bill Date" := "Last Bill Date";
//                                                     BilledLease."Transaction Code" := LeaseL."Transaction Code";
//                                                     BilledLease."Property No." := "Property No.";
//                                                     BilledLease.Charged := LeaseL.Charged;
//                                                     BilledLease."Transaction Name" := LeaseL."Charge Name";
//                                                     BilledLease.Insert;
//                                                     BilledLease.Modify;
//                                                     HOLDLEASE1 := LeaseL."Lease No.";
//                                                 end
//                                                 else
//                                                     if (LeaseL."Lease No." <> HOLDLEASE) then begin
//                                                         LineNo1 := LineNo1 + 1;
//                                                         BilledLease.Init;
//                                                         BilledLease.InvoiceNo := LineNo1;
//                                                         BilledLease."No." := "No.";
//                                                         BilledLease."Next Bill Date" := "Next Bill Date";
//                                                         BilledLease."Date Registered" := "Date Registered";
//                                                         BilledLease."Property No." := "Property No.";
//                                                         BilledLease."L.R. No." := "L.R. No.";
//                                                         BilledLease."Property Name" := "Property Name";
//                                                         BilledLease."Unit Code" := "Unit Code";
//                                                         BilledLease."Batch No" := BatchNo1;
//                                                         BilledLease."Currency Code" := "Currency Code";
//                                                         BilledLease."Landlord No." := "Landlord No.";
//                                                         //insert charge name
//                                                         BilledLease."Charge Name" := LeaseL."Charge Name";
//                                                         BilledLease.Description := LeaseL."Charge Name";
//                                                         BilledLease."Landlord Name" := "Landlord Name";
//                                                         BilledLease."Tenant No." := "Tenant No.";
//                                                         BilledLease."Tenant Name" := "Tenant Name";
//                                                         BilledLease."Expiry Date" := "Expiry Date";
//                                                         LeaseL.CalcFields(LeaseL."No.");
//                                                         BilledLease."G/L Account" := LeaseL."No.";
//                                                         BilledLease."Global Dimension 1 Code" := "Global Dimension 1 Code";
//                                                         BilledLease."Global Dimension 2 Code" := "Global Dimension 2 Code";
//                                                         //bill monthly
//                                                         if (Lease."Billing Frequency" = Lease."billing frequency"::Monthly) then begin
//                                                             BilledLease."Leased Amount" := ROUND(LeaseL."Amount Exclusive VAT", 1, '=');
//                                                             BilledLease."Leased VAT Amount" := ROUND(LeaseL."VAT Amount", 1, '=');
//                                                             BilledLease."Total Incl. VAT" := ROUND(LeaseL."Total Amount Inclusive VAT", 1, '=');
//                                                         end else
//                                                             if (Lease."Billing Frequency" = Lease."billing frequency"::Quarterly) then begin
//                                                                 BilledLease."Leased Amount" := ROUND(LeaseL."Amount Exclusive VAT", 1, '=');
//                                                                 BilledLease."Leased VAT Amount" := ROUND(LeaseL."VAT Amount", 1, '=');
//                                                                 BilledLease."Total Incl. VAT" := ROUND(LeaseL."Total Amount Inclusive VAT", 1, '=');
//                                                             end else
//                                                                 if (Lease."Billing Frequency" = Lease."billing frequency"::Annually) then begin
//                                                                     BilledLease."Leased Amount" := ROUND(LeaseL."Amount Exclusive VAT", 1, '=');
//                                                                     BilledLease."Leased VAT Amount" := ROUND(LeaseL."VAT Amount", 1, '=');
//                                                                     BilledLease."Total Incl. VAT" := ROUND(LeaseL."Total Amount Inclusive VAT", 1, '=');
//                                                                 end else
//                                                                     if (Lease."Billing Frequency" = Lease."billing frequency"::"Semi Annually") then begin
//                                                                         BilledLease."Leased Amount" := ROUND(LeaseL."Amount Exclusive VAT", 1, '=');
//                                                                         BilledLease."Leased VAT Amount" := ROUND(LeaseL."VAT Amount", 1, '=');
//                                                                         BilledLease."Total Incl. VAT" := ROUND(LeaseL."Total Amount Inclusive VAT", 1, '=');
//                                                                     end;

//                                                         BilledLease."Billing Frequency" := "Billing Frequency";
//                                                         BilledLease."Billing Frequency Value" := "Billing Frequency Value";
//                                                         BilledLease."Last Bill Date" := "Last Bill Date";
//                                                         BilledLease."Transaction Code" := LeaseL."Transaction Code";
//                                                         BilledLease."Property No." := "Property No.";
//                                                         BilledLease.Charged := LeaseL.Charged;
//                                                         BilledLease."Transaction Name" := LeaseL."Charge Name";
//                                                         BilledLease.Insert;
//                                                         BilledLease.Modify;
//                                                         HOLDLEASE1 := LeaseL."Lease No.";
//                                                     end;
//                                             end else
//                                                 ;
//                                         until LeaseL.Next = 0;
//                                     end;
//                                 end;
//                             end;
//                         end;
//                     until Lease.Next = 0;
//                 end;

//                 //end processing generation
//             end;
//         }
//     }

//     requestpage
//     {
//         SaveValues = true;

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     var
//         BilledLease: Record "Leases Billed";
//         BatchNo: Record "Bills Batch";
//         BatchNo1: Code[30];
//         LineNo1: Integer;
//         LeaseL: Record "Lease Line";
//         AmountD: Decimal;
//         CompInfo: Record "Company Information";
//         BlankExp: Integer;
//         Exp: Integer;
//         ProcessedInv: Integer;
//         HOLDLEASE: Code[10];
//         HOLDLEASE1: Code[10];
//         CHARGES: Record Charges;
// }
