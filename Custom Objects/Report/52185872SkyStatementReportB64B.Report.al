// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185872 "Sky Statement Report B64 B."
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/Sky Statement Report B64 B..rdl';

//     dataset
//     {
//         dataitem("Savings Ledger Entry";"Savings Ledger Entry")
//         {
//             DataItemTableView = sorting("Posting Date") order(ascending);
//             column(ReportForNavId_1; 1)
//             {
//             }
//             column(Description_SavingsLedgerEntry; "Savings Ledger Entry".Description)
//             {
//             }
//             column(EntryNo_SavingsLedgerEntry; "Savings Ledger Entry"."Entry No.")
//             {
//             }
//             column(PostingDate_SavingsLedgerEntry; "Savings Ledger Entry"."Posting Date")
//             {
//             }
//             column(DocumentNo_SavingsLedgerEntry; "Savings Ledger Entry"."Document No.")
//             {
//             }
//             column(Amount_SavingsLedgerEntry; "Savings Ledger Entry".Amount)
//             {
//             }
//             column(DebitAmount_SavingsLedgerEntry; "Savings Ledger Entry"."Debit Amount")
//             {
//             }
//             column(CreditAmount_SavingsLedgerEntry; "Savings Ledger Entry"."Credit Amount")
//             {
//             }
//             column(RunningBalance; RunningBalance)
//             {
//             }
//             column(EntryType; EntryType)
//             {
//             }
//             column(SaccoName; SaccoName)
//             {
//             }
//             column(SaccoAddress; SaccoAddress)
//             {
//             }
//             column(MemberName; MemberName)
//             {
//             }
//             column(MemberAccountName; MemberAccountName)
//             {
//             }
//             column(MemberAccountNumber; MemberAccountNumber)
//             {
//             }
//             column(Slogan; Slogan)
//             {
//             }
//             column(SaccoPhone; SaccoPhone)
//             {
//             }
//             column(OpeningBal; OpeningBal)
//             {
//             }
//             column(DateRange; DateRange)
//             {
//             }
//             column(TotalCredits; TotalCredits)
//             {
//             }
//             column(TotalDebits; TotalDebits)
//             {
//             }
//             column(ClosingBal; ClosingBal)
//             {
//             }
//             column(DateIssued; DateIssued)
//             {
//             }
//             column(WholeDate; WholeDate)
//             {
//             }
//             column(Image; Image)
//             {
//             }
//             column(PostingDate; PostingDate)
//             {
//             }
//             column(memberPhone; MemberPhone)
//             {
//             }
//             column(Email; Email)
//             {
//             }
//             column(Website; Website)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 // RunningBalance := MemPort.GetRunningBalance("Savings Ledger Entry"."Entry No.", "Savings Ledger Entry"."Customer No.");
//                 // if "Savings Ledger Entry".Amount < 0 then EntryType := 'Credit';
//                 // if "Savings Ledger Entry".Amount > 0 then EntryType := 'Debit';
//                 // Amount := "Savings Ledger Entry".Amount;
//                 // Amount *= -1;
//                 // PostingDate := MemPort.FormatDate("Savings Ledger Entry"."Posting Date");
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
//         CompanyInformation.Get;
//         SaccoName := CompanyInformation.Name;
//         SaccoAddress := CompanyInformation.Address;
//         SaccoPhone := CompanyInformation."Phone No.";
//         Slogan := 'Your Future Our Concern';
//         CompanyInformation.CalcFields(Picture);
//         Image := Format(CompanyInformation.Picture);
//         Email := CompanyInformation."E-Mail";
//         Website := CompanyInformation."Home Page";

//         MemberAccountNumber := "Savings Ledger Entry".GetFilter("Customer No.");
//         SavingsAccounts.Get(MemberAccountNumber);
//         Members.Get(SavingsAccounts."Member No.");

//         MemberPhone := Members."Phone No.";

//         if MemberPhone = '' then MemberPhone := Members."Phone No.";

//         MemberName := Members.Name;

//         MemberAccountName := SavingsAccounts."Product Name";

//         DateRange := "Savings Ledger Entry".GetFilter("Posting Date");

//         if "Savings Ledger Entry".FindFirst then begin
//             FirstEntryNo := "Savings Ledger Entry"."Entry No.";
//             GetBalances(MemberAccountNumber, "Savings Ledger Entry"."Entry No.", OpeningBal, TotalCredits, TotalDebits, FirstEntryNo, LastEntryNo);
//             //Fromdate := MemPort.FormatDate("Savings Ledger Entry"."Posting Date");
//         end;

//         if "Savings Ledger Entry".FindLast then begin
//             LastEntryNo := "Savings Ledger Entry"."Entry No.";
//             GetBalances(MemberAccountNumber, "Savings Ledger Entry"."Entry No.", ClosingBal, TotalCredits, TotalDebits, FirstEntryNo, LastEntryNo);
//             //ToDate := MemPort.FormatDate("Savings Ledger Entry"."Posting Date");
//         end;
//         //MESSAGE('Opening Bal : %1 Closing Bal : %2',FORMAT(OpeningBal),FORMAT(ClosingBal));


//         //MESSAGE('Opening Bal : %1 Closing Bal : %2',FORMAT(OpeningBal),FORMAT(ClosingBal));

//         //DateIssued := MemPort.FormatDate(Today);
//         //MESSAGE('Total Credits : %1 Total Debits : %2',FORMAT(TotalCredits),FORMAT(TotalDebits));
//         WholeDate := Fromdate + ' to ' + ToDate;
//         //MESSAGE('First Entry No - Lowest: %1  Last Entry No - Highest: %2',FirstEntryNo,LastEntryNo);
//     end;

//     var
//         RunningBalance: Decimal;
//         SavingsLedgerEntry: Record "Savings Ledger Entry";
//         EntryType: Text;
//         Amount: Decimal;
//         SaccoName: Text;
//         SaccoAddress: Text;
//         MemberName: Text;
//         MemberAccountName: Text;
//         MemberAccountNumber: Code[30];
//         DateRange: Text;
//         Slogan: Text;
//         SaccoPhone: Text;
//         OpeningBal: Decimal;
//         TotalCredits: Decimal;
//         TotalDebits: Decimal;
//         ClosingBal: Decimal;
//         DateIssued: Text;
//         Members: Record "Members";
//         CompanyInformation: Record "Company Information";
//         ProductFactory: Record "Product Factory";
//         MemberNo: Code[30];
//         SavingsAccounts: Record "Savings Accounts";
//         FirstEntryNo: Integer;
//         LastEntryNo: Integer;
//         Fromdate: Text;
//         ToDate: Text;
//         WholeDate: Text;
//         Image: Text;
//         MemPort: Codeunit "Sky Harambee Portal";
//         PostingDate: Text;
//         MemberPhone: Text[30];
//         FromdateD: Date;
//         ToDateD: Date;
//         LoanName: Text;
//         Email: Text;
//         Website: Text;

//     local procedure GetBalances(CustomerNo: Code[30]; EntryNumber: Integer; var Balances: Decimal; var Crds: Decimal; var Dbts: Decimal; FirstEntry: Integer; LastEntry: Integer)
//     var
//         SavingsLedgerEntry: Record "Savings Ledger Entry";
//     begin
//         SavingsLedgerEntry.Reset;
//         SavingsLedgerEntry.SetRange("Customer No.", CustomerNo);
//         SavingsLedgerEntry.SetRange("Entry No.", FirstEntry, LastEntry);
//         if SavingsLedgerEntry.FindFirst then begin
//             SavingsLedgerEntry.CalcSums("Credit Amount", "Debit Amount");
//             Crds := SavingsLedgerEntry."Credit Amount";
//             Dbts := SavingsLedgerEntry."Debit Amount";
//         end;

//         SavingsLedgerEntry.Reset;
//         SavingsLedgerEntry.SetRange("Customer No.", CustomerNo);
//         SavingsLedgerEntry.SetFilter("Entry No.", '<=%1', FirstEntry);
//         if SavingsLedgerEntry.FindFirst then begin
//             SavingsLedgerEntry.CalcSums(Amount);
//             Balances := SavingsLedgerEntry.Amount;
//             Balances *= -1;
//         end;

//         SavingsLedgerEntry.Reset;
//         SavingsLedgerEntry.SetRange("Customer No.", CustomerNo);
//         SavingsLedgerEntry.SetFilter("Entry No.", '<=%1', LastEntry);
//         if SavingsLedgerEntry.FindFirst then begin
//             SavingsLedgerEntry.CalcSums(Amount);
//             Balances := SavingsLedgerEntry.Amount;
//             Balances *= -1;
//         end;
//     end;
// }
