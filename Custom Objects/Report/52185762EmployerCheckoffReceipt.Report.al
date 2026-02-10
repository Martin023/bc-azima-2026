// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185762 "Employer Checkoff Receipt"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-kenpipe-2024/Layout/Employer Checkoff Receipt.rdl';

//     dataset
//     {
//         dataitem(Transactions; Transactions)
//         {
//             DataItemTableView = sorting(No);
//             RequestFilterFields = No;
//             column(ReportForNavId_5806; 5806)
//             {
//             }
//             column(NetDescription; NetDescription)
//             {
//             }
//             column(GCSDescription; GCSDescription)
//             {
//             }
//             column(TotalCheckoffAmnt; TotalCheckoffAmnt)
//             {
//             }
//             column(GCSAmnt; GCSAmnt)
//             {
//             }
//             column(NetAmnt; NetAmnt)
//             {
//             }
//             column(Transactions_Transactions__Book_Balance_; Transactions."Book Balance")
//             {
//             }
//             column(Transactions_No; No)
//             {
//             }
//             column(EmployerNo; Transactions."Employer No")
//             {
//             }
//             column(EmployerAccountName; Transactions."Employer  Account Name")
//             {
//             }
//             column(EmployerName; Transactions."Employer  Account Name")
//             {
//             }
//             column(AccountNo; "Account No")
//             {
//             }
//             column(AccountName; "Account Name")
//             {
//             }
//             column(Amount; Amount)
//             {
//             }
//             column(ID_NO; Transactions."ID No")
//             {
//             }
//             column(PayrollNo; StaffNo)
//             {
//             }
//             column(Prod_Name; ProductName)
//             {
//             }
//             column(Transactions__Transaction_Date_; "Transaction Date")
//             {
//             }
//             column(Transactions_Transactions__Transaction_Time_; Transactions."Transaction Time")
//             {
//             }
//             column(Transactions__Cheque_No_; "Cheque No")
//             {
//             }
//             column(Transactions_Type; Type)
//             {
//             }
//             column(CompanyInfo_Name; CompanyInfo.Name)
//             {
//             }
//             column(Company_Address; CompanyInfo.Address)
//             {
//             }
//             column(Co_phone; CompanyInfo."Phone No.")
//             {
//             }
//             column(Co_Phone2; CompanyInfo."Phone No. 2")
//             {
//             }
//             column(Company_Pic; CompanyInfo.Picture)
//             {
//             }
//             column(HomePage; CompanyInfo."Home Page")
//             {
//             }
//             column(Email; CompanyInfo."E-Mail")
//             {
//             }
//             column(Transactions_Transactions_Cashier; Transactions.Cashier)
//             {
//             }
//             column(Amount_WithdrawnCaption; Amount_WithdrawnCaptionLbl)
//             {
//             }
//             column(Book_Balance_Caption; Book_Balance_CaptionLbl)
//             {
//             }
//             column(Transaction_No_Caption; Transaction_No_CaptionLbl)
//             {
//             }
//             column(Account_No_Caption; Account_No_CaptionLbl)
//             {
//             }
//             column(Account_Name_Caption; Account_Name_CaptionLbl)
//             {
//             }
//             column(Date_Caption; Date_CaptionLbl)
//             {
//             }
//             column(Time_Caption; Time_CaptionLbl)
//             {
//             }
//             column(Transactions__Cheque_No_Caption; Transactions.FieldCaption("Cheque No"))
//             {
//             }
//             column(Member_No_Caption; Member_No_CaptionLbl)
//             {
//             }
//             column(EmptyStringCaption; EmptyStringCaptionLbl)
//             {
//             }
//             column(Signature_Caption; Signature_CaptionLbl)
//             {
//             }
//             column(I_acknowledge_receipt_of_the_above_amountCaption; I_acknowledge_receipt_of_the_above_amountCaptionLbl)
//             {
//             }
//             column(EmptyStringCaption_Control1000000048; EmptyStringCaption_Control1000000048Lbl)
//             {
//             }
//             column(I_D_No_Caption; I_D_No_CaptionLbl)
//             {
//             }
//             column(Availbal; Available_Balance_CaptionLbl)
//             {
//             }
//             column(BookBal_; Book_Balance_Caption_Control1102760006Lbl)
//             {
//             }
//             column(EmptyStringCaption_Control1102756001; EmptyStringCaption_Control1102756001Lbl)
//             {
//             }
//             column(al; Name_CaptionLbl)
//             {
//             }
//             column(Withdrawn_By_______________________________________Caption; Withdrawn_By_______________________________________CaptionLbl)
//             {
//             }
//             column(You_were_served_by__Caption; You_were_served_by__CaptionLbl)
//             {
//             }
//             column(THANK_YOUCaption; THANK_YOUCaptionLbl)
//             {
//             }
//             column(Better_life_for_our_members_globallyCaption; Better_life_for_our_members_globallyCaptionLbl)
//             {
//             }
//             column(Transactions_Transaction_Type; "Transaction Type")
//             {
//             }
//             column(ExpectedMaturityDate; "Expected Maturity Date")
//             {
//             }
//             column(ChequeNo_Transactions; Transactions."Cheque No")
//             {
//             }
//             column(TransactionDescription_Transactions; Transactions."Transaction Description")
//             {
//             }
//             column(Cashier_Transactions; Transactions.Cashier)
//             {
//             }
//             column(TransactedBy; Transactions.Remarks)
//             {
//             }
//             column(NumberText_1_; NumberText[1])
//             {
//             }
//             column(SumTransactionCharges; SumTransactionCharges)
//             {
//             }
//             column(AvailableBalance; "Available Balance")
//             {
//             }
//             column(NewAvailable; "Available Balance" - (SumTransactionCharges + Amount))
//             {
//             }
//             dataitem(52185774;52185774)
//             {
//                 DataItemLink = "Transaction Type" = field("Transaction Type");
//                 column(ReportForNavId_8541; 8541)
//                 {
//                 }
//                 column(Description; Description)
//                 {
//                 }
//                 column(ChAmount; ChAmount)
//                 {
//                 }
//                 column(Transaction_Charges_Transaction_Type; "Transaction Type")
//                 {
//                 }
//                 column(Transaction_Charges_Charge_Code; "Charge Code")
//                 {
//                 }
//             }
//             dataitem(52185683;52185683)
//             {
//                 DataItemLink = "Transaction No" = field(No);
//                 column(ReportForNavId_5; 5)
//                 {
//                 }
//                 column(CL_Account_no; "Checkoff  Receipt Trans Lines"."Account No")
//                 {
//                 }
//                 column(CL_Loan_no; "Checkoff  Receipt Trans Lines"."Loan No")
//                 {
//                 }
//                 column(CL_Amount; "Checkoff  Receipt Trans Lines".Amount)
//                 {
//                 }
//                 column(CL_TransType; CL_TransactionType)
//                 {
//                 }
//                 column(CSName; "Checkoff  Receipt Trans Lines"."Receipt Description")
//                 {
//                 }
//                 column(ProdType; "Checkoff  Receipt Trans Lines"."Product Type")
//                 {
//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     NetAmnt := 0;
//                     TotalCheckoffAmnt := 0;
//                     GCSAmnt := 0;
//                     if "Checkoff  Receipt Trans Lines".Type = "Checkoff  Receipt Trans Lines".Type::"Bank Account" then begin
//                         NetAmnt := "Checkoff  Receipt Trans Lines".Amount;
//                     end;

//                     if "Checkoff  Receipt Trans Lines".Type = "Checkoff  Receipt Trans Lines".Type::"G/L Account" then begin
//                         GCSAmnt := "Checkoff  Receipt Trans Lines".Amount;
//                     end;



//                     if "Checkoff  Receipt Trans Lines".Type = "Checkoff  Receipt Trans Lines".Type::" " then begin
//                         Savings.Reset;
//                         Savings.SetRange(Savings."No.", "Checkoff  Receipt Trans Lines"."Account No");
//                         if Savings.Find('-') then begin
//                             if ProductFactory.Get(Savings."Product Type") then CSName := ProductFactory."Product Description";
//                         end;
//                         CL_TransactionType := Format("Checkoff  Receipt Trans Lines"."Transaction Type");
//                     end;

//                     if ("Checkoff  Receipt Trans Lines".Type <> "Checkoff  Receipt Trans Lines".Type::" ") and
//                        ("Checkoff  Receipt Trans Lines".Type <> "Checkoff  Receipt Trans Lines".Type::"Bank Account") then
//                         CL_TransactionType := Format("Checkoff  Receipt Trans Lines".Type);
//                 end;
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 StaffNo := '';
//                 ProductName := '';
//                 TotalCheckoffAmnt := 0;
//                 NetAmnt := 0;
//                 GCSAmnt := 0;
//                 NetDescription := '';
//                 GCSDescription := '';
//                 TransLines.Reset;
//                 TransLines.SetRange("Transaction No", Transactions.No);
//                 TransLines.SetRange(Type, TransLines.Type::"Bank Account");
//                 if TransLines.Find('-') then begin
//                     TransLines.CalcSums(Amount);
//                     NetAmnt := TransLines.Amount;
//                     NetDescription := TransLines."Receipt Description";
//                     ;
//                 end;

//                 TransLines.Reset;
//                 TransLines.SetRange("Transaction No", Transactions.No);
//                 TransLines.SetRange(Type, TransLines.Type::"G/L Account");
//                 if TransLines.Find('-') then begin
//                     TransLines.CalcSums(Amount);
//                     GCSAmnt := TransLines.Amount;
//                     GCSDescription := TransLines."Receipt Description";
//                 end;



//                 //calculate the charges
//                 SavingsLedgerEntry.Reset;
//                 SavingsLedgerEntry.SetRange("Customer No.", "Account No");
//                 SavingsLedgerEntry.SetRange("Document No.", No);
//                 if SavingsLedgerEntry.FindSet then begin
//                     SavingsLedgerEntry.CalcSums(Amount);
//                     SumTransactionCharges := SavingsLedgerEntry.Amount - Amount;
//                     //MESSAGE('the trans charges are %1',SumTransactionCharges);
//                 end;

//                 Savings.Reset;
//                 Savings.SetRange(Savings."No.", Transactions."Account No");
//                 if Savings.Find('-') then begin
//                     StaffNo := Savings."Payroll/Staff No.";
//                     ProductName := Savings."Product Name";
//                 end;
//                 TotalCheckoffAmnt := Transactions.Amount;
//             end;

//             trigger OnPreDataItem()
//             begin
//                 CompanyInfo.Get();
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
//         Amount_WithdrawnCaptionLbl: label 'Amount Withdrawn';
//         Book_Balance_CaptionLbl: label 'Book Balance:';
//         Transaction_No_CaptionLbl: label 'Transaction No.';
//         Account_No_CaptionLbl: label 'Account No:';
//         Account_Name_CaptionLbl: label 'Account Name:';
//         Date_CaptionLbl: label 'Date:';
//         Time_CaptionLbl: label 'Time:';
//         Member_No_CaptionLbl: label 'Member No:';
//         EmptyStringCaptionLbl: label '..........................................................';
//         Signature_CaptionLbl: label 'Signature:';
//         I_acknowledge_receipt_of_the_above_amountCaptionLbl: label 'I acknowledge receipt of the above amount';
//         EmptyStringCaption_Control1000000048Lbl: label '..........................................................';
//         I_D_No_CaptionLbl: label 'I/D No.';
//         Available_Balance_CaptionLbl: label 'Available Balance:';
//         Book_Balance_Caption_Control1102760006Lbl: label 'Book Balance:';
//         EmptyStringCaption_Control1102756001Lbl: label '..........................................................';
//         Name_CaptionLbl: label 'Name:';
//         Withdrawn_By_______________________________________CaptionLbl: label 'Withdrawn By :.....................................';
//         You_were_served_by__CaptionLbl: label 'You were served by :';
//         THANK_YOUCaptionLbl: label 'THANK YOU';
//         Better_life_for_our_members_globallyCaptionLbl: label 'Better life for our members globally';
//         CompanyInfo: Record "Company Information";
//         CheckReport: Report Check;
//                          NumberText: array[2] of Text[120];
//                          SumTransactionCharges: Decimal;
//                          ChAmount: Decimal;
//                          AvailableBalance: Decimal;
//                          SavingsLedgerEntry: Record "Savings Ledger Entry";
//                          Savings5730;
//                          StaffNo: Code[20];
//                          ProductName: Text[50];
//                          Credit: Record "Credit Accounts";
//                          CSName: Text[50];
//                          ProductFactory: Record "Product Factory";
//                          CL_TransactionType: Text;
//                          TotalCheckoffAmnt: Decimal;
//                          GCSAmnt: Decimal;
//                          NetAmnt: Decimal;
//                          ReceiptTransactions: Record "Checkoff  Receipt Transactions";
//                          TransLines:Record "Checkoff  Receipt Trans Lines";
//                          NetDescription: Text;
//                          GCSDescription: Text;
// }
