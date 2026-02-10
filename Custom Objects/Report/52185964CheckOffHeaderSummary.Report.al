// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185964 "CheckOff Header Summary"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/CheckOff Header Summary.rdl';

//     dataset
//     {
//         dataitem(CheckoffHeader; CheckoffHeader)
//         {
//             RequestFilterFields = "No.", "Account No.", "No.";
//             column(ReportForNavId_1; 1)
//             {
//             }
//             column(No; CheckoffHeader."No.")
//             {
//             }
//             column(Date_Entered; CheckoffHeader."Date Entered")
//             {
//             }
//             column(Entered_By; CheckoffHeader."Entered By")
//             {
//             }
//             column(Posting_Date; CheckoffHeader."Posting Date")
//             {
//             }
//             column(Account_Type; CheckoffHeader."Account Type")
//             {
//             }
//             column(Account_No; CheckoffHeader."Account No.")
//             {
//             }
//             column(Account_Name; CheckoffHeader."Account Name")
//             {
//             }
//             column(Document_No; CheckoffHeader."Document No.")
//             {
//             }
//             column(Amount; CheckoffHeader.Amount)
//             {
//             }
//             column(Description; CheckoffHeader.Description)
//             {
//             }
//             column(Sceduled_Amount; CheckoffHeader."Scheduled Amount")
//             {
//             }
//             column(Total_Caount; CheckoffHeader."Total Count")
//             {
//             }
//             column(Comapny_Name; Comapny.Name)
//             {
//             }
//             column(Comapny_Picture; Comapny.Picture)
//             {
//             }
//             column(LoansCount; LoansCount)
//             {
//             }
//             column(LoanAmount; LoanAmount)
//             {
//             }
//             column(sShareCount; sShareCount)
//             {
//             }
//             column(sShareAmount; sShareAmount)
//             {
//             }
//             column(IntCount; IntCount)
//             {
//             }
//             column(IntAmount; IntAmount)
//             {
//             }
//             column(sInvestCount; sInvestCount)
//             {
//             }
//             column(sInvestAmount; sInvestAmount)
//             {
//             }
//             column(sFundCount; sFundCount)
//             {
//             }
//             column(sFundAmount; sFundAmount)
//             {
//             }
//             column(sJoiningCount; sJoiningCount)
//             {
//             }
//             column(sJoiningAmount; sJoiningAmount)
//             {
//             }
//             column(Posted; CheckoffHeader.Posted)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 LoansCount := 0;
//                 LoanAmount := 0;
//                 IntAmount := 0;
//                 IntCount := 0;
//                 sShareAmount := 0;
//                 sShareCount := 0;
//                 sJoiningCount := 0;
//                 sJoiningAmount := 0;
//                 sFundAmount := 0;
//                 sFundCount := 0;
//                 sInvestAmount := 0;
//                 sInvestCount := 0;


//                 CheckoffLines.Reset;
//                 CheckoffLines.SetRange("Checkoff Header", CheckoffHeader."No.");
//                 CheckoffLines.SetRange(Type, CheckoffLines.Type::sInterest);
//                 if CheckoffLines.Find('-') then begin
//                     CheckoffLines.CalcSums(Amount);
//                     IntAmount := CheckoffLines.Amount;
//                     IntCount := CheckoffLines.Count;
//                 end;

//                 CheckoffLines.Reset;
//                 CheckoffLines.SetRange("Checkoff Header", CheckoffHeader."No.");
//                 CheckoffLines.SetRange(Type, CheckoffLines.Type::sLoan);
//                 if CheckoffLines.Find('-') then begin
//                     CheckoffLines.CalcSums(Amount);
//                     LoanAmount := CheckoffLines.Amount;
//                     LoansCount := CheckoffLines.Count;
//                 end;

//                 CheckoffLines.Reset;
//                 CheckoffLines.SetRange("Checkoff Header", CheckoffHeader."No.");
//                 CheckoffLines.SetRange(Type, CheckoffLines.Type::sShare);
//                 if CheckoffLines.Find('-') then begin
//                     CheckoffLines.CalcSums(Amount);
//                     sShareAmount := CheckoffLines.Amount;
//                     sShareCount := CheckoffLines.Count;
//                 end;

//                 CheckoffLines.Reset;
//                 CheckoffLines.SetRange("Checkoff Header", CheckoffHeader."No.");
//                 CheckoffLines.SetRange(Type, CheckoffLines.Type::wCont);
//                 if CheckoffLines.Find('-') then begin
//                     CheckoffLines.CalcSums(Amount);
//                     sFundAmount := CheckoffLines.Amount;
//                     sFundCount := CheckoffLines.Count;
//                 end;

//                 CheckoffLines.Reset;
//                 CheckoffLines.SetRange("Checkoff Header", CheckoffHeader."No.");
//                 CheckoffLines.SetRange(Type, CheckoffLines.Type::sJoining);
//                 if CheckoffLines.Find('-') then begin
//                     CheckoffLines.CalcSums(Amount);
//                     sJoiningAmount := CheckoffLines.Amount;
//                     sJoiningCount := CheckoffLines.Count;
//                 end;

//                 CheckoffLines.Reset;
//                 CheckoffLines.SetRange("Checkoff Header", CheckoffHeader."No.");
//                 CheckoffLines.SetRange(Type, CheckoffLines.Type::Investment);
//                 if CheckoffLines.Find('-') then begin
//                     CheckoffLines.CalcSums(Amount);
//                     sInvestAmount := CheckoffLines.Amount;
//                     sInvestCount := CheckoffLines.Count;
//                 end;
//             end;

//             trigger OnPreDataItem()
//             begin
//                 Comapny.Get;
//                 Comapny.CalcFields(Picture);
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
//         Comapny: Record "Company Information";
//         LoansCount: Integer;
//         LoanAmount: Decimal;
//         sShareCount: Integer;
//         sShareAmount: Decimal;
//         CheckoffLines: Record "Checkoff Lines";
//         IntCount: Integer;
//         IntAmount: Decimal;
//         sInvestCount: Integer;
//         sInvestAmount: Decimal;
//         sFundCount: Integer;
//         sFundAmount: Decimal;
//         sJoiningCount: Integer;
//         sJoiningAmount: Decimal;
// }
