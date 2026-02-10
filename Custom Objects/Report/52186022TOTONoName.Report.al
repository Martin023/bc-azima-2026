// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52186022 "TOTO No Name"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-kenpipe-2024/Layout/TOTO No Name.rdl';

//     dataset
//     {
//         dataitem("Savings Accounts"; "Savings Accounts")
//         {
//             //DataItemTableView = where("Product Type" = const(511));
//             column(ReportForNavId_1; 1)
//             {
//             }
//             column(UserID; LogUserID)
//             {
//             }
//             column(No_SavingsAccounts; "Savings Accounts"."No.")
//             {
//             }
//             column(Name_SavingsAccounts; "Savings Accounts".Name)
//             {
//             }
//             column(PrintedAt; PrintedAt)
//             {
//             }
//             column(MemberNo_SavingsAccounts; "Savings Accounts"."Member No.")
//             {
//             }
//             column(PrintedBy; PrintedBy)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 if Members.Get("Savings Accounts"."Member No.") then begin
//                     if Members.Name <> "Savings Accounts".Name then CurrReport.Skip;
//                 end;
//             end;
//         }
//         dataitem("Company Information"; "Company Information")
//         {
//             column(ReportForNavId_13; 13)
//             {
//             }
//             column(Picture_CompanyInformation; "Company Information".Picture)
//             {
//             }
//             column(Website; Website)
//             {
//             }
//             column(Email; Email)
//             {
//             }
//             column(DateAndTime; DateAndTime)
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
//         Website := "Company Information"."Home Page";
//         Email := "Company Information"."E-Mail";
//         PrintedBy := UserId;
//         Pos := StrPos(PrintedBy, '\') + 1;
//         PrintedBy := CopyStr(PrintedBy, Pos, StrLen(PrintedBy));
//         PrintedAt := CurrentDatetime;
//         DateAndTime := Format(CurrentDatetime, 0, '<Day,2>/<Month,2>/<Year4>');
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
//         Members: Record "Members";
// }
