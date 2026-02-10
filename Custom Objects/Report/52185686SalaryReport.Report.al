// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185686 "Salary Report"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-kenpipe-2024/Layout/Salary Report.rdl';

//     dataset
//     {
//         dataitem("Salary Header";"Salary Header")
//         {
//             column(ReportForNavId_7; 7)
//             {
//             }
//             // column(Picture;CompanyInfo.Picture)
//             // {
//             // }
//             column(CurrReport_PAGENO;CurrReport.PageNo)
//             {
//             }
//             column(us;UserId)
//             {
//             }
//             column(date;Format(Today,0,4))
//             {
//             }
//             column(CompName;COMPANYNAME)
//             {
//             }
//             column(No;"Salary Header".No)
//             {
//             }
//             column(DocNo;"Salary Header"."Document No")
//             {
//             }
//             column(AmountHeader;"Salary Header".Amount)
//             {
//             }
//             column(IncomeType;"Salary Header"."Income Type")
//             {
//             }
//             column(EnteredBy;"Salary Header"."Entered By")
//             {
//             }
//             dataitem("Salary Lines";"Salary Lines")
//             {
//                 DataItemLink = "Salary Header No."=field(No);
//                 column(ReportForNavId_1; 1)
//                 {
//                 }
//                 column(Account;"Salary Lines"."Account No.")
//                 {
//                 }
//                 column(StaffNo;"Salary Lines"."Staff No.")
//                 {
//                 }
//                 column(Name;"Salary Lines".Name)
//                 {
//                 }
//                 column(ID;"Salary Lines"."ID No.")
//                 {
//                 }
//                 column(Amount;"Salary Lines".Amount)
//                 {
//                 }
//             }

//             trigger OnPreDataItem()
//             begin
//                 CompanyInfo.Get;
//                 CompanyInfo.CalcFields(CompanyInfo.Picture);
//             end;
//         }
//     }

//     requestpage
//     {

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
//         CompanyInfo: Record "Company Information";
// }
