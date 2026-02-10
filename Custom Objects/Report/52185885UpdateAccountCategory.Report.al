// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185885 "Update Account Category"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/Update Account Category.rdl';

//     dataset
//     {
//         dataitem(Members; Members)
//         {
//             column(ReportForNavId_1; 1)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 if Members."Account Category" = Members."account category"::"Board Members" then begin
//                     Members."Account Category" := Members."account category"::Delegates;
//                     Members.Modify;
//                 end;


//                 if (Members."No." = '0002816') or (Members."No." = '0018879') or (Members."No." = '0049804') or (Members."No." = '0056992')
//                   or (Members."No." = '0060674') or (Members."No." = '0069084') or (Members."No." = '0070550') or (Members."No." = '0070611')
//                   or (Members."No." = '0104065') or (Members."No." = '0111910') or (Members."No." = '0130945') or (Members."No." = '0134190')
//                   or (Members."No." = '0141676') or (Members."No." = '0134607') then begin
//                     Members."Account Category" := Members."account category"::"Board Members";
//                     Members.Modify;
//                 end;


//                 if (Members."Account Category" = Members."account category"::"Staff Members") and (Members."Employer Code" <> '00') then begin
//                     Members."Account Category" := Members."account category"::Member;
//                     Members.Modify;
//                 end;

//                 if Members.Status = Members.Status::Active then begin
//                     if (Members."Account Category" = Members."account category"::Member) and (Members."Employer Code" = '00') then begin
//                         Members."Account Category" := Members."account category"::"Staff Members";
//                         Members.Modify;
//                     end;
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
// }
