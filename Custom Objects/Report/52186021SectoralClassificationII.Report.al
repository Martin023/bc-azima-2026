// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52186021 "Sectoral Classification II"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/Sectoral Classification II.rdl';

//     dataset
//     {
//         dataitem("Sectoral Classification"; "Sectoral Classification")
//         {
//             DataItemTableView = sorting("Sub Sector Level2") order(ascending);
//             column(ReportForNavId_1; 1)
//             {
//             }
//             column(MainSector; "Sectoral Classification"."Main Sector")
//             {
//             }
//             column(SubLevel1; "Sectoral Classification"."Sub Sector Level1")
//             {
//             }
//             column(SubLevel2; "Sectoral Classification"."Sub Sector Level2")
//             {
//             }
//             column(MainDescription; "Sectoral Classification"."Main Sector Description")
//             {
//             }
//             column(SubLevel1Description; "Sectoral Classification"."Sub Sector Level1 Description")
//             {
//             }
//             column(SubLevel2Description; "Sectoral Classification"."Sub Sector Level2 Description")
//             {
//             }
//             column(Bal; Bal)
//             {
//             }
//             column(StartDate; StartDate)
//             {
//             }
//             column(EndDate; EndDate)
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
//             column(TotalOutstandingBal; TotalOutstandingBal)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 year := Date2dmy(StartDate, 3);
//                 Bal := 0;
//                 TotalOutstandingBal := 0;
//                 OutstandingBal := 0;
//                 OutstandingInterest := 0;
//                 CountNo := 0;
//                 Loans.Reset;
//                 Loans.SetRange("Sub Sector Level2", "Sectoral Classification"."Sub Sector Level2");
//                 Loans.SetRange("Disbursement Date", StartDate, EndDate);
//                 Loans.SetFilter("Outstanding Balance", '>0');
//                 if Loans.Find('-') then begin
//                     repeat
//                         Loans.CalcFields("Outstanding Balance", "Outstanding Interest");
//                         //Bal:=Bal+Loans."Approved Amount";
//                         OutstandingBal := Loans."Outstanding Balance";
//                         OutstandingInterest := Loans."Outstanding Interest";
//                         if OutstandingBal <= 0 then OutstandingBal := 0;
//                         if OutstandingInterest <= 0 then OutstandingInterest := 0;

//                         TotalOutstandingBal += OutstandingBal + OutstandingInterest;

//                         CountNo := CountNo + 1;
//                     until Loans.Next = 0;
//                 end else
//                     CurrReport.Skip;
//             end;

//             trigger OnPreDataItem()
//             begin
//                 if StartDate = 0D then Error('Kindly Specify The Start Date');
//                 if EndDate = 0D then Error('Kindly Specify The End Date');
//                 CompanyInfo.Get();
//                 CompanyInfo.CalcFields(Picture);
//                 CountNo := 0;
//             end;
//         }
//     }

//     requestpage
//     {

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
//         Loans: Record Loans;
//         Bal: Decimal;
//         StartDate: Date;
//         EndDate: Date;
//         Dfilter: Text;
//         CompanyInfo: Record "Company Information";
//         year: Integer;
//         CountNo: Integer;
//         OutstandingBal: Decimal;
//         OutstandingInterest: Decimal;
//         TotalOutstandingBal: Decimal;
// }
