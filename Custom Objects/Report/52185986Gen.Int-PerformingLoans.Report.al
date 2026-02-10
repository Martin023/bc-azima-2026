// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185986 "Gen.Int-Performing Loans"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-kenpipe-2024/Layout/Gen.Int-Performing Loans.rdl';

//     dataset
//     {
//         dataitem(Loans; Loans)
//         {
//             //DataItemTableView = where("Loans Category-SASRA" = const(Perfoming), "Outstanding Balance" = filter(> 0), Posted = const(Yes));
//             column(ReportForNavId_1; 1)
//             {
//             }

//             trigger OnAfterGetRecord()
//             var
//             // RunPeriodicTrans: Codeunit "Journal Posting";
//             begin
//                 if PFactory.Get(Loans."Loan Product Type") then
//                     ProductIntAc := PFactory."Loan Interest Account [G/L]";
//                 ProductSuspIntAc := PFactory."Suspend Interest Account [G/L]";
//                 TotalInt := 0;

//                 SuspInterest.Reset;
//                 SuspInterest.SetRange("Loan No.", Loans."Loan No.");
//                 SuspInterest.SetRange("Transferred to income Ac", false);
//                 if SuspInterest.Find('-') then begin
//                     SuspInterest.CalcSums("Interest Amount");
//                     TotalInt := SuspInterest."Interest Amount";
//                     RunPeriodicTrans.InsertIntoInterestLines(DocNo, "Member No.", "Loan No.",
//                     "Loan Product Type", ProductIntAc, 0, UserId, Today, "Global Dimension 1 Code",
//                     "Global Dimension 2 Code", TotalInt, Today, ProductSuspIntAc);
//                 end;
//             end;

//             trigger OnPreDataItem()
//             begin
//                 if DocNo = '' then Error(ErrorOnMissingDocNo);
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//             area(content)
//             {
//                 field(DocNo; DocNo)
//                 {
//                     ApplicationArea = Basic;
//                     Caption = 'No.';
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
//         SuspInterest: Record "Suspended Interest Accounts";
//         DocNo: Code[80];
//         ErrorOnMissingDocNo: label 'Document No. is Blank.';
//         TotalInt: Decimal;
//         ProductIntAc: Code[100];
//         PFactory: Record "Product Factory";
//         ProductSuspIntAc: Code[100];
// }
