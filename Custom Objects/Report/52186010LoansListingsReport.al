// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52186010 "Loans Listing Report"
// {
//     DefaultLayout = RDLC;
//     // RDLCLayout = './bc-azima-2026/Layout/Loans Listings Report.rdl';
//     RDLCLayout = './bc-azima-2026/Layout/For the sake.rdl';
//     ProcessingOnly = true;

//     dataset
//     {
//         dataitem(Loans; Loans)
//         {
//             DataItemTableView = where(Posted = const(true), "Outstanding Balance" = filter(> 0));
//             RequestFilterFields = "Employer Code", "Source Unit", "Member No.", "Loan Product Type";
//             column(LoanNo_Loans; Loans."Loan No.")
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 BulkProcessing.LoanListingProcessing(Loans, BatchNo, AsAt);
//             end;

//             trigger OnPreDataItem()
//             var
//                 LoanListing: Record "Loan Listing Report List";
//                 BulkErrors: Record "Bulk Processing Errors";
//             begin
//                 BatchNo := Format(CurrentDateTime);


//                 LoanListing.Reset();
//                 LoanListing.DeleteAll();

//                 BulkErrors.Reset();
//                 BulkErrors.SetRange(Process, BulkErrors.Process::"Loan Listing");
//                 BulkErrors.DeleteAll();
//             end;
//         }

//     }


//     requestpage
//     {
//         SaveValues = true;

//         layout
//         {
//             area(content)
//             {
//                 field(asAt; asAt)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'As At Date';
//                     ToolTip = 'Select a date for filtering report data.';
//                 }
//             }
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     trigger OnPreReport()
//     begin
//         if AsAt = 0D then AsAt := Today;
//     end;

//     var


//         Company: Record "Company Information";
//         BulkProcessing: Codeunit "Bulk Processing";
//         BatchNo: Code[100];
//         AsAt: Date;


// }
