// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185661 "Spouse Details"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/Spouse Details.rdl';

//     dataset
//     {
//         dataitem("Next of KIN";"Next of KIN")
//         {
//             //DataItemTableView = where(Beneficiary = filter(Yes));
//             RequestFilterFields = "Account No";
//             column(ReportForNavId_1; 1)
//             {
//             }
//             column(CName; Company.Name)
//             {
//             }
//             column(CAddress; Company.Address)
//             {
//             }
//             column(CPicture; Company.Picture)
//             {
//             }
//             column(MemberNo; "Next of KIN"."Account No")
//             {
//             }
//             column(MemberName; MemberName)
//             {
//             }
//             column(MemberPayroll; MemberPayroll)
//             {
//             }
//             column(SpauseName; "Next of KIN".Name)
//             {
//             }
//             column(MobileNo; "Next of KIN".Telephone)
//             {
//             }
//             column(Address; "Next of KIN".Address)
//             {
//             }
//             column(Relation; "Next of KIN".Relationship)
//             {
//             }
//             column(IdNo; "Member Id")
//             {
//             }
//             column(EmployerCode; EmployerCode)
//             {
//             }
//             column(Type; "Next of KIN".Type)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 if Members.Get("Next of KIN"."Account No") then begin
//                     MemberName := Members.Name;
//                     MemberPayroll := Members."Payroll/Staff No.";
//                     "Member Id" :=
//                     Members."Primary Identification";
//                     EmployerCode := Members."Employer Code";
//                 end;
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

//     trigger OnPreReport()
//     begin
//         Company.Get;
//         Company.CalcFields(Picture);
//     end;

//     var
//         MemberName: Text;
//         MemberPayroll: Code[20];
//         Company: Record "Company Information";
//         Members: Record "Members";
//         "Member Id": Code[20];
//         EmployerCode: Code[10];
// }
