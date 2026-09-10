// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185914 "Sectoral Classification"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/Sectoral Classification.rdl';

//     dataset
//     {
//         dataitem(Loans; Loans)
//         {

//             column(ReportForNavId_1; 1)
//             {
//             }
//             column(Main_Sector; "Main Sector")
//             { }
//             column(Main_Sector_Description; "Main Sector Description")
//             {
//             }
//             column(LoanNo; "Loan No.")
//             {
//             }
//             column(Sub_Sector_Level1; "Sub Sector Level1")
//             {
//             }
//             column(Sub_Sector_Level1_Description; "Sub Sector Level1 Description")
//             {
//             }
//             column(StartDate; StartDate)
//             {
//             }
//             column(EndDate; EndDate)
//             {
//             }
//             column(Sub_Sector_Level2; "Sub Sector Level2")
//             {

//             }
//             column(Sub_Sector_Level2_Description; "Sub Sector Level2 Description")
//             {

//             }
//             column(year; year)
//             {
//             }
//             column(CompanyInfoName; CompanyInfo.Name)
//             {
//             }
//             column(Logo; CompanyInfo.Picture)
//             {
//             }
//             column(CountNo; CountNo)
//             {
//             }
//             column(Bal; Bal)
//             {

//             }


//             trigger OnAfterGetRecord()
//             begin
//                 year := Date2dmy(StartDate, 3);
//                 Bal := 0;
//                 LoanRec.Reset;
//                 LoanRec.SetRange(LoanRec."Main Sector", Loans."Main Sector");
//                 LoanRec.SetRange("Disbursement Date", StartDate, EndDate);
//                 if LoanRec.Find('-') then begin
//                     repeat
//                         Bal := Bal + LoanRec."Approved Amount";
//                         CountNo := CountNo + 1;
//                     until LoanRec.Next = 0;
//                 end else
//                     CurrReport.Skip;
//             end;

//             trigger OnPreDataItem()
//             begin
//                 if StartDate = 0D then Error('Kindly Specify The Start Date');
//                 if EndDate = 0D then Error('Kindly Specify The End Date');
//                 Loans.SetRange("Disbursement Date", StartDate, EndDate);
//                 CompanyInfo.Get();
//                 CompanyInfo.CalcFields(Picture);
//                 CountNo := 0;
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
//                 field(StartDate; StartDate)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'Start Date';
//                 }
//                 field(EndDate; EndDate)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'End Date';
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

//     var

//         Bal: Decimal;
//         StartDate: Date;
//         EndDate: Date;
//         Dfilter: Text;
//         CompanyInfo: Record "Company Information";
//         year: Integer;
//         CountNo: Integer;
//         LoanRec: Record Loans;
// }
