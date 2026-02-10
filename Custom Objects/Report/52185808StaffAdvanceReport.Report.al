// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185808 "Staff Advance Report"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-kenpipe-2024/Layout/Staff Advance Report.rdl';

//     dataset
//     {
//         dataitem("Company Information"; "Company Information")
//         {
//             DataItemTableView = sorting("Primary Key");
//             column(ReportForNavId_58; 58)
//             {
//             }
//             column(Name_CompanyInformation; "Company Information".Name)
//             {
//             }
//             column(Address_CompanyInformation; "Company Information".Address)
//             {
//             }
//             column(Picture_CompanyInformation; "Company Information".Picture)
//             {
//             }
//             column(Dim1Code; Dim1Code)
//             {
//             }
//             column(Dim2Code; Dim2Code)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 "Company Information".CalcFields("Company Information".Picture);
//                 GenLedgerSetup.Get;
//                 Dim1Code := GenLedgerSetup."Global Dimension 1 Code";
//                 Dim2Code := GenLedgerSetup."Global Dimension 2 Code";
//             end;
//         }
//         dataitem(52185914;52185914)
//         {
//             RequestFilterFields = "No.";
//             column(ReportForNavId_1; 1)
//             {
//             }
//             column(No_StaffAdvanceHeader;"Staff Advance Header"."No.")
//             {
//             }
//             column(Date_StaffAdvanceHeader;"Staff Advance Header".Date)
//             {
//             }
//             column(CurrencyCode_StaffAdvanceHeader;"Staff Advance Header"."Currency Code")
//             {
//             }
//             column(Cashier_StaffAdvanceHeader;"Staff Advance Header".Cashier)
//             {
//             }
//             column(PayingBankAccount_StaffAdvanceHeader;"Staff Advance Header"."Paying Bank Account")
//             {
//             }
//             column(GlobalDimension1Code_StaffAdvanceHeader;"Staff Advance Header"."Global Dimension 1 Code")
//             {
//             }
//             column(Status_StaffAdvanceHeader;"Staff Advance Header".Status)
//             {
//             }
//             column(PaymentType_StaffAdvanceHeader;"Staff Advance Header"."Payment Type")
//             {
//             }
//             column(ShortcutDimension2Code_StaffAdvanceHeader;"Staff Advance Header"."Shortcut Dimension 2 Code")
//             {
//             }
//             column(FunctionName_StaffAdvanceHeader;"Staff Advance Header"."Function Name")
//             {
//             }
//             column(BudgetCenterName_StaffAdvanceHeader;"Staff Advance Header"."Budget Center Name")
//             {
//             }
//             column(BankName_StaffAdvanceHeader;"Staff Advance Header"."Bank Name")
//             {
//             }
//             column(TotalVATAmount_StaffAdvanceHeader;"Staff Advance Header"."Total VAT Amount")
//             {
//             }
//             column(TotalWitholdingTaxAmount_StaffAdvanceHeader;"Staff Advance Header"."Total Witholding Tax Amount")
//             {
//             }
//             column(TotalNetAmount_StaffAdvanceHeader;"Staff Advance Header"."Total Net Amount")
//             {
//             }
//             column(PayMode_StaffAdvanceHeader;"Staff Advance Header"."Pay Mode")
//             {
//             }
//             column(PaymentReleaseDate_StaffAdvanceHeader;"Staff Advance Header"."Payment Release Date")
//             {
//             }
//             column(NoPrinted_StaffAdvanceHeader;"Staff Advance Header"."No. Printed")
//             {
//             }
//             column(ResponsibilityCenter_StaffAdvanceHeader;"Staff Advance Header"."Responsibility Center")
//             {
//             }
//             column(Purpose_StaffAdvanceHeader;"Staff Advance Header".Purpose)
//             {
//             }
//             column(Payee_StaffAdvanceHeader;"Staff Advance Header".Payee)
//             {
//             }
//             column(ReportLabel;ReportLabel)
//             {
//             }
//             column(ChequeNo_StaffAdvanceHeader;"Staff Advance Header"."Cheque No.")
//             {
//             }
//             column(NumberText_1_;NumberText[1])
//             {
//             }
//             column(StrCopyText;StrCopyText)
//             {
//             }
//             dataitem(52185915;52185915)
//             {
//                 DataItemLink = No=field("No.");
//                 DataItemTableView = sorting("Line No.",No);
//                 column(ReportForNavId_2; 2)
//                 {
//                 }
//                 column(No_StaffAdvanceLines;"Staff Advance Lines".No)
//                 {
//                 }
//                 column(AccountNo_StaffAdvanceLines;"Staff Advance Lines"."Account No:")
//                 {
//                 }
//                 column(AccountName_StaffAdvanceLines;"Staff Advance Lines"."Account Name")
//                 {
//                 }
//                 column(Amount_StaffAdvanceLines;"Staff Advance Lines".Amount)
//                 {
//                 }
//                 column(DueDate_StaffAdvanceLines;"Staff Advance Lines"."Due Date")
//                 {
//                 }
//                 column(AdvanceHolder_StaffAdvanceLines;"Staff Advance Lines"."Advance Holder")
//                 {
//                 }
//                 column(ActualSpent_StaffAdvanceLines;"Staff Advance Lines"."Actual Spent")
//                 {
//                 }
//                 column(GlobalDimension1Code_StaffAdvanceLines;"Staff Advance Lines"."Global Dimension 1 Code")
//                 {
//                 }
//                 column(Applyto_StaffAdvanceLines;"Staff Advance Lines"."Apply to")
//                 {
//                 }
//                 column(ApplytoID_StaffAdvanceLines;"Staff Advance Lines"."Apply to ID")
//                 {
//                 }
//                 column(SurrenderDate_StaffAdvanceLines;"Staff Advance Lines"."Surrender Date")
//                 {
//                 }
//                 column(Surrendered_StaffAdvanceLines;"Staff Advance Lines".Surrendered)
//                 {
//                 }
//                 column(MRNo_StaffAdvanceLines;"Staff Advance Lines"."M.R. No")
//                 {
//                 }
//                 column(DateIssued_StaffAdvanceLines;"Staff Advance Lines"."Date Issued")
//                 {
//                 }
//                 column(TypeofSurrender_StaffAdvanceLines;"Staff Advance Lines"."Type of Surrender")
//                 {
//                 }
//                 column(DeptVchNo_StaffAdvanceLines;"Staff Advance Lines"."Dept. Vch. No.")
//                 {
//                 }
//                 column(CashSurrenderAmt_StaffAdvanceLines;"Staff Advance Lines"."Cash Surrender Amt")
//                 {
//                 }
//                 column(BankPettyCash_StaffAdvanceLines;"Staff Advance Lines"."Bank/Petty Cash")
//                 {
//                 }
//                 column(SurrenderDocNo_StaffAdvanceLines;"Staff Advance Lines"."Surrender Doc No.")
//                 {
//                 }
//                 column(DateTaken_StaffAdvanceLines;"Staff Advance Lines"."Date Taken")
//                 {
//                 }
//                 column(Purpose_StaffAdvanceLines;"Staff Advance Lines".Purpose)
//                 {
//                 }
//                 column(ShortcutDimension2Code_StaffAdvanceLines;"Staff Advance Lines"."Shortcut Dimension 2 Code")
//                 {
//                 }
//                 column(BudgetaryControlAC_StaffAdvanceLines;"Staff Advance Lines"."Budgetary Control A/C")
//                 {
//                 }
//                 column(Committed_StaffAdvanceLines;"Staff Advance Lines".Committed)
//                 {
//                 }
//                 column(AdvanceType_StaffAdvanceLines;"Staff Advance Lines"."Advance Type")
//                 {
//                 }
//                 column(CurrencyFactor_StaffAdvanceLines;"Staff Advance Lines"."Currency Factor")
//                 {
//                 }
//                 column(CurrencyCode_StaffAdvanceLines;"Staff Advance Lines"."Currency Code")
//                 {
//                 }
//                 column(AmountLCY_StaffAdvanceLines;"Staff Advance Lines"."Amount LCY")
//                 {
//                 }
//                 column(LineNo_StaffAdvanceLines;"Staff Advance Lines"."Line No.")
//                 {
//                 }
//                 column(ClaimReceiptNo_StaffAdvanceLines;"Staff Advance Lines"."Claim Receipt No")
//                 {
//                 }
//                 column(ExpenditureDate_StaffAdvanceLines;"Staff Advance Lines"."Expenditure Date")
//                 {
//                 }
//                 column(AttendeeOrganizationNames_StaffAdvanceLines;"Staff Advance Lines"."Attendee/Organization Names")
//                 {
//                 }
//                 column(Grouping_StaffAdvanceLines;"Staff Advance Lines".Grouping)
//                 {
//                 }
//             }
//             dataitem("Approval Entry";"Approval Entry")
//             {
//                 DataItemLink = "Document No."=field("No.");
//                 DataItemTableView = sorting("Entry No.") where(Status=const(Approved));
//                 column(ReportForNavId_60; 60)
//                 {
//                 }
//                 column(DocumentNo_ApprovalEntry;"Approval Entry"."Document No.")
//                 {
//                 }
//                 column(SequenceNo_ApprovalEntry;"Approval Entry"."Sequence No.")
//                 {
//                 }
//                 column(SenderID_ApprovalEntry;"Approval Entry"."Sender ID")
//                 {
//                 }
//                 column(ApproverID_ApprovalEntry;"Approval Entry"."Approver ID")
//                 {
//                 }
//                 column(Status_ApprovalEntry;"Approval Entry".Status)
//                 {
//                 }
//                 column(DateTimeSentforApproval_ApprovalEntry;"Approval Entry"."Date-Time Sent for Approval")
//                 {
//                 }
//                 column(LastDateTimeModified_ApprovalEntry;"Approval Entry"."Last Date-Time Modified")
//                 {
//                 }
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 StrCopyText:='';
//                 if "No. Printed">=1 then
//                   begin
//                     StrCopyText:='DUPLICATE';
//                   end
//                 else begin
//                 StrCopyText:='ORIGINAL';
//                 end;

//                 UnknownTable52185914.CalcFields("Total Net Amount");
//                 CheckReport.InitTextVariable();
//                 CheckReport.FormatNoText(NumberText,("Total Net Amount"),"Currency Code");
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
//         ReportLabel: label 'Advance Request';
//         CompanyInfo: Record "Company Information";
//         Dim1Code: Code[10];
//         Dim2Code: Code[10];
//         GenLedgerSetup: Record "General Ledger Setup";
//         CheckReport: Report Check;
//                          NumberText: array [2] of Text[80];
//                          StrCopyText: Text;
// }
