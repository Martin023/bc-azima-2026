// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185784 "Posted Imprest Surrender"
// {

//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/Posted Imprest Surrender.rdl';

//     dataset
//     {
//         dataitem(ImprestSurrenderHeader; "Imprest Surrender Header")
//         {
//             RequestFilterFields = "Global Dimension 1 Code",Status;
//             column(ReportForNavId_8431; 8431)
//             {
//             }

//             column(No; ImprestSurrenderHeader.No)
//             {

//             }
//             column(Surrender_Date; "Surrender Date")
//             {

//             }
//             column(Account_No_; "Account No.")
//             {

//             }
//             column(Status; Status)
//             {

//             }
//             column(CompanyInformation_Name; CompanyInformation.Name)
//             {
//             }
//             column(CompanyInformation_Picture; CompanyInformation.Picture)
//             {
//             }
//             column(CompanyAddress; CompanyAddress)
//             {
//             }
//             column(CompanyTelephone; CompanyTelephone)
//             {
//             }
//             column(CommunicationOnline; CommunicationOnline)
//             {
//             }
//             dataitem(ImprestSurrender; "Imprest Surrender Details")
//             {
//                 DataItemLink = "Surrender Doc No." = field("No");
//                 column(Actual_Spent; "Actual Spent")
//                 {

//                 }
//                 column(Amount; Amount)
//                 {

//                 }
//             }
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

//    trigger OnPreReport()
//     begin
//         if CompanyInformation.Get then
//             CompanyInformation.CalcFields(CompanyInformation.Picture);
//         CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
//         CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
//         CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
//     end;
// var
//  CompanyInformation: record "Company Information";
//         CompanyAddress: Text;
//         CompanyTelephone: Text;
//         CommunicationOnline: Text;


// }

