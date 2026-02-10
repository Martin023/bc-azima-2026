// query 52186145 "Loan Products Report"
// {
//     APIGroup = 'crm';
//     APIPublisher = 'sky';
//     APIVersion = 'v1.0';
//     EntityName = 'member';
//     EntitySetName = 'members';
//     QueryType = API;

//     elements
//     {
//         dataitem(Product_Factory; "Product Factory")
//         {
//           column(Product_ID; "Product ID") { }
//             column(Product_Category; "Product Description") 
//             { 

//             }
//             column(Product_Class_Type; "Product Class Type") 
//             {

//             }
//             column(Interest_Rate__Min__; "Interest Rate (Min.)") 
//             {

//             }

//             trigger OnAfterGetRecord()
//             var
//                 myInt: Integer;

//             begin
//                 LoansCount := 0;

//                 Loans.RESET;
//                 Loans.SETRANGE("Loan Product Type", "Product ID");
//                 Loans.SetRange("Posted", true);
//                 Loans.SetFilter("Disbursement Date", '%1..%2', StartDate, EndDate);
//                 if Loans.Find('-') then begin
//                     LoansCount := Loans.Count;
//                     TotalAmountBorrowed := TotalAmountBorrowed + Loans."Approved Amount";
//                 end
//             end;
//         }
//     }

//         }
//     }

//     trigger OnBeforeOpen()
//     begin

//         CompInfo.Get;
//         CompInfo.CalcFields(Picture);
//     end;

//     var
//         CompInfo: Record "Company Information";
//         EmployerName: Text;
//         CompanyAddress: Text;
//         CompanyTelephone: Text;
//         CommunicationOnline: Text;
//         SavingsAccount: Record "Savings Accounts";
//         BOSADeposits: Decimal;
//         SharesBal: Decimal;
//         OutstandingBalance: Decimal;
//         ProductSetup: Record "Product Factory";
//         InterestRate: Decimal;
//         StartDate: Date;
//         EndDate: Date;
//         Loans: Record Loans;
//         LoansCount: Integer;
//         TotalAmountBorrowed: Decimal;
// }
