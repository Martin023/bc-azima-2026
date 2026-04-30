// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Report 52185508 "Accounts FallOff Report"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/Accounts Falloff.rdl';


//     dataset
//     {
//         dataitem("Savings Accounts"; "Savings Accounts")
//         {
//             RequestFilterFields = "No.", "Product Type", "ID No.", "Payroll/Staff No.", "Employer Code", "Member No.";

//             column(CompanyInformation_Picture; CompanyInformation.Picture)
//             {
//             }
//             column(CompanyName; CompanyName)
//             {

//             }
//             column(BuldingName; BuldingName)
//             {
//             }
//             column(CompanyAddress; CompanyAddress)
//             {
//             }
//             column(CompanyTelephone; CompanyTelephone)
//             {
//             }
//             column(CompanyEmail; CompanyEmail)
//             {
//             }
//             column(PrintingDate; PrintingDate)
//             {

//             }
//             column(PrintingTime; PrintingTime)
//             {

//             }
//             column(PrintedBy; PrintedBy)
//             {

//             }
//             column(CreatedBy; CreatedBy)
//             {

//             }
//             column(AccountNo; AccountNo)
//             {

//             }
//             column(ProdDesc; ProdDesc)
//             {

//             }
//             column(ProdType; ProdType)
//             {

//             }
//             column(MemberNo; MemberNo)
//             {

//             }
//             column(MemberName; MemberName)
//             {

//             }
//             column(PhoneNumber; PhoneNumber)
//             {

//             }
//             column(PayrollNumber; PayrollNumber)
//             {

//             }
//             column(NationalId; NationalId)
//             {

//             }
//             column(EmployerCode; EmployerCode)
//             {

//             }
//             column(AccountStatus; AccountStatus)
//             {

//             }
//             column(MonthlyCont; MonthlyCont)
//             {

//             }
//             column(Prorata; Prorata)
//             {

//             }
//             column(ActualAmtReceived; ActualAmtReceived)
//             {

//             }
//             column(Variance; Variance)
//             {

//             }
//             column(LastPaidAmt; LastPaidAmt)
//             {

//             }
//             column(LastPaidDateText; LastPaidDateText)
//             {

//             }
//             column(AmtInArrears; AmtInArrears)
//             {

//             }
//             column(DaysInArrears; DaysInArrears)
//             {

//             }
//             column(DurationInArrears; DurationInArrears)
//             {

//             }
//             column(Balance; Balance)
//             {

//             }
//             column(RegistrationDate; RegistrationDate)
//             {

//             }
//             column(BranchCode; BranchCode)
//             {

//             }
//             column(ActivityCode; ActivityCode)
//             {

//             }

//             trigger OnAfterGetRecord()
//             begin
//                 "Savings Accounts".CalcFields(Balance);
//                 AccountNo := "No.";
//                 ProdDesc := "Product Name";
//                 ProdType := "Product Type";
//                 MemberNo := "Member No.";
//                 MemberName := Name;
//                 PhoneNumber := "Phone No.";
//                 if PhoneNumber = '' then PhoneNumber := "Mobile Phone No";
//                 if PhoneNumber = '' then PhoneNumber := "Phone No.";
//                 if PhoneNumber = '' then PhoneNumber := "Transactional Mobile No";
//                 PayrollNumber := "Payroll/Staff No.";
//                 NationalId := "ID No.";
//                 EmployerCode := "Employer Code";
//                 AccountStatus := Format(Status);
//                 MonthlyCont := "Monthly Contribution";
//                 Prorata := CustomCuesCodeunit.Prorata("Savings Accounts"."Member No.", "Savings Accounts"."Product Type");


//                 SavingsAccounts.Reset();
//                 SavingsAccounts.SetFilter("Date Filter", '%1..%2', StartDate, EndDate);
//                 SavingsAccounts.SetRange("No.", "Savings Accounts"."No.");
//                 if SavingsAccounts.FindFirst() then begin
//                     SavingsAccounts.CalcFields(Balance);
//                     ActualAmtReceived := SavingsAccounts.Balance;
//                 end;

//                 Variance := MonthlyCont - ActualAmtReceived;
//                 if Prorata > MonthlyCont then
//                     Variance := Prorata - ActualAmtReceived;

//                 SavingsLedger.Reset();
//                 SavingsLedger.SetRange("Customer No.", "No.");
//                 SavingsLedger.SetRange(Reversed, false);
//                 SavingsLedger.SetFilter("Credit Amount", '>0');
//                 if SavingsLedger.FindLast() then begin
//                     LastPaidAmt := Abs(SavingsLedger.Amount);
//                     LastPaidDateDate := SavingsLedger."Posting Date";
//                 end;

//                 if LastPaidDateDate <> 0D then
//                     MillisecInArrears := EndDate - LastPaidDateDate;

//                 DaysInArrears := Round(MillisecInArrears / 86400000, 1, '<');

//                 DurationInArrears := MillisecInArrears;
//                 if MillisecInArrears = 0 then DurationInArrears := 0;

//                 if LastPaidDateDate <> 0D then
//                     LastPaidDateText := GlobalFunctions.FormatDate(LastPaidDateDate);

//                 AmtInArrears := 0;

//                 Balance := "Savings Accounts".Balance;

//                 if "Registration Date" <> 0D then
//                     RegistrationDate := GlobalFunctions.FormatDate("Registration Date");

//                 CreatedBy := GlobalFunctions.FormatUserName("Savings Accounts"."Created By");
//                 BranchCode := "Global Dimension 1 Code";
//                 ActivityCode := "Global Dimension 2 Code";

//             end;

//         }
//     }

//     requestpage
//     {
//         SaveValues = true;

//         layout
//         {
//             area(Content)
//             {
//                 field(StartDate; StartDate)
//                 {

//                 }
//                 field(EndDate; EndDate)
//                 {

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

//     trigger OnPreReport()
//     begin
//         if CompanyInformation.Get then
//             CompanyInformation.CalcFields(CompanyInformation.Picture);
//         CompanyName := CompanyInformation.Name;
//         BuldingName := CompanyInformation."Building Name";
//         CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
//         CompanyTelephone := CompanyInformation."Phone No." + ',' + CompanyInformation."Phone No. 2";
//         CompanyEmail := CompanyInformation."E-Mail";
//         PrintingDate := GlobalFunctions.DMUDateFormatDate(Today);
//         PrintingTime := Format(Time);
//         PrintedBy := GlobalFunctions.FormatUserName(UserId);

//         if (StartDate = 0D) or (StartDate = 0D) then begin
//             Error('Start date and end date must have a value');
//         end;
//     end;

//     var
//         //Columns
//         CompanyName: Text;
//         BuldingName: Text;
//         CompanyAddress: Text;
//         CompanyTelephone: Text;
//         CompanyEmail: Text;
//         PrintingDate: Text;
//         PrintingTime: Text;
//         PrintedBy: Code[50];

//         AccountNo: Text;
//         ProdDesc: Text;
//         ProdType: Text;
//         MemberNo: Text;
//         MemberName: Text;
//         PhoneNumber: Text;
//         PayrollNumber: Text;
//         NationalId: Text;
//         EmployerCode: Text;
//         AccountStatus: Text;
//         MonthlyCont: Decimal;
//         Prorata: Decimal;//Minimum eXpected Contribution
//         ActualAmtReceived: Decimal;
//         Variance: Decimal;
//         LastPaidAmt: Decimal;
//         DaysInArrears: Integer;
//         DurationInArrears: Duration;
//         MillisecInArrears: Decimal;
//         LastPaidDateText: Text;//edited
//         LastPaidDateDate: Date;
//         AmtInArrears: Decimal;
//         Balance: Decimal;
//         RegistrationDate: Text;
//         CreatedBy: Text;
//         BranchCode: Text;
//         ActivityCode: Text;

//         //Request Page
//         StartDate: Date;
//         EndDate: Date;


//         //Other Variables
//         Members: Record Members;
//         CompanyInformation: Record "Company Information";
//         GlobalFunctions: Codeunit "Global Functions";
//         RecoveryHeader: Record "Loan Recovery Header";
//         CreditLedgerEntry: Record "Credit Ledger Entry";
//         LoansProcess: Codeunit "Loans Process";
//         RunLoan: Boolean;
//         Counter: Integer;
//         SASRACategory: Record "SASRA Categorization";
//         LoanAge: Integer;
//         AsAt: Date;
//         Loans: Record Loans;
//         CFTracker: Record "CF Tracker";
//         SavingsAccounts: Record "Savings Accounts";
//         SavingsLedger: Record "Savings Ledger Entry";
//         CustomCuesCodeunit: Codeunit CustomCuesCodeunit;

//         //Task Progress
//         intProgressTotal: Integer;
//         intProgressI: Integer;
//         TimeProgress: TIME;
//         NoOfRecsProgress: Decimal;
//         NoOfProgressed: Integer;
//         Generating: Label 'Task Progress ...';
//         diaProgress: Dialog;
//         intProgress: Integer;
// }
