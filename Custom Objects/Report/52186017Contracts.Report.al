// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52186017 Contracts
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-kenpipe-2024/Layout/Contracts.rdl';

//     dataset
//     {
//         dataitem(Contracts;Contracts)
//         {
//             RequestFilterFields = Status,Terminated,"Contract No","User Department";
//             column(ReportForNavId_1; 1)
//             {
//             }
//             column(ContractNo;Contracts."Contract No")
//             {
//             }
//             column(TypeOfService;Contracts."Type Of Service")
//             {
//             }
//             column(ContractAmount;Contracts."Contract Amount")
//             {
//             }
//             column(ResponsibleEmployeeName;Contracts."Responsible Employee Name")
//             {
//             }
//             column(ResponsibleEmployee;Contracts."Responsible Employee")
//             {
//             }
//             column(SupportPeriod;Contracts."Support Period")
//             {
//             }
//             column(TelNo;Contracts."Tel No.")
//             {
//             }
//             column(ContractorName;Contracts."Contractor Name")
//             {
//             }
//             column(ContractorNo;Contracts."Contractor No")
//             {
//             }
//             column(EndDate;Contracts."End Date")
//             {
//             }
//             column(StartDate;Contracts."Start Date")
//             {
//             }
//             column(UserID;LogUserID)
//             {
//             }
//             column(PrintedAt;PrintedAt)
//             {
//             }
//             column(PrintedBy;PrintedBy)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 Duration:='';

//                     // if  ( Contracts."Start Date"<> 0D) then
//                     // Duration:= HRCodeunit.DetermineAge(Contracts."Start Date",Contracts."End Date");
//             end;
//         }
//         dataitem("Company Information";"Company Information")
//         {
//             column(ReportForNavId_13; 13)
//             {
//             }
//             column(Picture_CompanyInformation;"Company Information".Picture)
//             {
//             }
//             column(Website;Website)
//             {
//             }
//             column(Email;Email)
//             {
//             }
//             column(DateAndTime;DateAndTime)
//             {
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

//     labels
//     {
//     }

//     trigger OnPreReport()
//     begin
//         CompInf.Get;
//         CompInf.CalcFields(Picture);
//         Website:="Company Information"."Home Page";
//         Email:="Company Information"."E-Mail";
//         PrintedBy := UserId;
//         Pos := StrPos(PrintedBy,'\')+1;
//         PrintedBy := CopyStr(PrintedBy,Pos,StrLen(PrintedBy));
//         PrintedAt:=CurrentDatetime;
//         DateAndTime:= Format(CurrentDatetime,0,'<Day,2>/<Month,2>/<Year4>');
//     end;

//     var
//         CompInf: Record "Company Information";
//         Duration: Text[100];
//         HRCodeunit: Codeunit "HR Codeunit";
//         LogUserID: Code[10];
//         Website: Text;
//         Email: Text;
//         PrintedBy: Text;
//         Pos: Integer;
//         PrintedAt: DateTime;
//         DateAndTime: Text;
// }
