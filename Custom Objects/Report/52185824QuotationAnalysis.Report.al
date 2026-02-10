// // #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// // Report 52185824 "Quotation Analysis"
// // {
// //     DefaultLayout = RDLC;
// //     RDLCLayout = './bc-kenpipe-2024/Layout/Quotation Analysis.rdl';

// //     dataset
// //     {
// //        dataitem(RFQHead "Purchase Header")
//         {
//             DataItemTableView = where("Document Type" = filter(Quote), DocApprovalType = filter(Quote));
//             RequestFilterFields = Field39005558, "No.", "Vendor Posting Group", "Buy-from Vendor No.", No.,Field50002;
// //             column(ReportForNavId_1; 1)
// //             {
// //             }
// //             dataitem(Quo "Purchase Header")
//             {
//                 DataItemTableView = sorting("Document Type", "No.") where("Document Type" = filter(Quote), DocApprovalType = pe=filter(Quote));
// //                 column(ReportForNavId_2; 2)
// //                 {
// //                 }
// //                 dataitem(PurchLin "Purchase Line")
//                 {
//                     DataItemLink = "Document No." = field("No.");
//                     DataItemTableView = sorting("Document Type", "Document No.", "Line No.") order(ascending) where("Document Type" = e"=filter(Quote));
// //                     column(ReportForNavId_3; 3)
// //                     {
// //                     }
// //                     column(Description_PurchLin es;PurchLines.Description)
// //                     {
// //                     }
// //                     column(Description2_PurchLin es;PurchLines."Description 2")
// //                     {
// //                     }
// //                     column(No_PurchLin es;PurchLines."No.")
// //                     {
// //                     }
// //                     dataitem(RFQLin "Purchase Line")
//                     {
//                         DataItemTableView = sorting("Document Type", "Document No.", "Line No.") order(ascending) where("Document Type" = e"=filter(Quote));
// //                         column(ReportForNavId_4; 4)
// //                         {
// //                         }
// //                         column(UnitofMeasure_RFQLin es;RFQLines."Unit of Measure")
// //                         {
// //                         }
// //                         column(Quantity_RFQLin es;RFQLines.Quantity)
// //                         {
// //                         }
// //                         column(BuyfromVendorNo_RFQLin es;RFQLines."Buy-from Vendor No.")
// //                         {
// //                         }
// //                         column(V no;VNo)
// //                         {
// //                         }
// //                         column(Vendors_Na me;Vendors.Name)
// //                         {
// //                         }
// //                         column(Amount_RFQLin es;RFQLines.Amount)
// //                         {
// //                         }

// //                         trigger OnAfterGetRecord()
// //                         begin

// //                             ShowL := e:=true;
// //                             Headers.Reset;
// //                             //Headers.SETRANGE(Headers."Document Type",Headers."Document Type"::Quote);
// //                             //Headers.SETRANGE(Headers.DocApprovalType,Headers."Document Type"::Quote);
// //                             Headers.SetRange(Headers."No .",RFQLines."Document No.");
// //                             Headers.SetRange(Headers."Invoice Basi s",RFQHeader."Invoice Basis");
// //                             if Headers.Find(' = ')=false then ShowL := e:=false;
// //                             if Vendors.Get(RFQLines."Buy-from Vendor No.") then
// //                              VNo := VNo + No+1;
// //                         end;

// //                         trigger OnPreDataItem()
// //                         begin

// //                             RFQLines.SetRange(RFQLines.Ty pe,PurchLines.Type);
// //                             RFQLines.SetRange(RFQLines."No .",PurchLines."No.");
// //                         end;
// //                     }

// //                     trigger OnAfterGetRecord()
// //                     begin

// //                         TempPurchLines.Reset;
// //                         TempPurchLines.SetRange(TempPurchLines."No .",PurchLines."No.");
// //                         TempPurchLines.SetRange(TempPurchLines.Ty pe,PurchLines.Type);
// //                         if TempPurchLines.Find('-') then begin
// //                             CurrReport.Skip;
// //                         end else begin
// //                          TempPurchLines := PurchLines;
//    //                          TempPurchLines.Insert;
// //                         end;
// //                         LineCo := LineCount + nt+1;
// //                          := o:=0;
// //                     end;
// //                 }
// //             }
// //         }
// //     }

// //     requestpage
// //     {

// //         layout
// //         {
// //         }

// //         actions
// //         {
// //         }
// //     }

// //     labels
// //     {
// //     }

// //     var
// //         TempPurchLines: Record "Purchase Line" temporary;
// //         LineCount: Integer;
// //         Headers: Record "Purchase Header";
// //         ShowLine: Boolean;
// //         Vendors: Record Vendor;
// //         VNo: Integer;
// // }
