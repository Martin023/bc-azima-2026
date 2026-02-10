// report 52187362 "Members Register - Active"
// {
//     ApplicationArea = All;
//     Caption = 'Member Listing';
//     UsageCategory = ReportsAndAnalysis;
//     DeFaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/Members Register Active.rdl';
//     dataset
//     {
//         dataitem(Members; Members)
//         {
//             RequestFilterFields = "No.", Status, "Employer Code", "Member Class", "Registration Date";
//             //DataItemTableView =  WHERE 
//             // column(No; "No.")
//             // {
//             // }
//             // column(Name; Name)
//             // {
//             // }
//             // column(Status; Status)
//             // {
//             // }
//             // column(Subflag; Subflag)
//             // {
//             // }
//             // column(RegistrationDate; "Registration Date")
//             // {
//             // }
//             // column(Phone_No_; "Phone No.") { }
//             // column(Transactional_Mobile_Number; "Transactional Mobile Number") { }
//             // column(Primary_Identification_Type; "Primary Identification Type") { }
//             // column(Primary_Identification; "Primary Identification") { }
//             // column(P_I_N_Number; "P.I.N Number") { }
//             // column(ReadmissionDate; Members."Rejoinig Date") { }
//             // column(BBFBal; BBFBal) { }
//             // column(FOSAAcStatus; FOSAAcStatus) { }
//             // column(FOSAccNo; FOSAccNo) { }
//             // column(Payroll_Staff_No_; "Payroll/Staff No.") { }
//             // column(LoanBal; LoanBal) { }
//             // column(Contribution_Effective_Date; "Contribution Effective Date")
//             // {
//             // }
//             // column(GlobalDimension1Code; "Global Dimension 1 Code")
//             // {
//             // }
//             // column(GlobalDimension2Code; "Global Dimension 2 Code")
//             // {
//             // }
//             // column(EmployerCode; "Employer Code")
//             // {
//             // }
//             // column(EmployerName; "Employer Name")
//             // {
//             // }
//             // column(CurrentAddress; "Current Address")
//             // {
//             // }
//             // column(DateofBirth; "Date of Birth")
//             // {
//             // }
//             // column(EMail; "E-Mail")
//             // {
//             // }
//             // column(RecruitedBy; "Recruited By")
//             // {
//             // }

//             // column(RecruitedByName; "Recruited By Name")
//             // {
//             // }
//             // column(RecruitedbyType; "Recruited by Type")
//             // {
//             // }
//             // COLUMN(RecruiterIDType; RecruiterIDType) { }
//             // column(RecruiterID; RecruiterID) { }
//             // column(UnallocatedFunBal; UnallocatedFunBal) { }
//             // column(ShareCapBal; ShareCapBal) { }
//             // column(Prorata; Prorata) { }
//             // column(MinimumContr; MinimumContr) { }

//             // column(MemberClass; "Member Class")
//             // {
//             // }
//             // column(Salutation; Salutation)
//             // {
//             // }
//             // column(MaritalStatus; "Marital Status")
//             // {
//             // }
//             // column(Date_Approved; "Date Approved")
//             // {
//             // }
//             // column(MemberAge; Age)
//             // {
//             // }
//             // column(CompanyInformation_Name; CompanyInformation.Name)
//             // {
//             // }
//             // column(CompanyInformation_Picture; CompanyInformation.Picture)
//             // {
//             // }
//             // column(CompanyAddress; CompanyAddress)
//             // {
//             // }
//             // column(CompanyTelephone; CompanyTelephone)
//             // {
//             // }
//             // column(CommunicationOnline; CommunicationOnline)
//             // {
//             // }
//             // column(Delegates_Zone; "Electrol Zone Descr.")
//             // {
//             //     //"Electrol Zone Descr."
//             // }
//             // column(RiskBalance; RiskBalance)
//             // {
//             // }
//             // column(RiskMonthlyContribution; RiskMonthlyContribution)
//             // {
//             // }
//             // column(RegistrationFee; RegistrationFee)
//             // {
//             // }
//             // column(FOSABalance; FOSABalance)
//             // {
//             // }
//             // column(BusinessDeposits; BusinessDeposits)
//             // {
//             // }
//             // column(BOSADepositBalance; BOSADepositBalance)
//             // {
//             // }
//             // column(BOSADepositsMonthlyContribution; DepositsMonthlyContribution)
//             // {
//             // }
//             // column(BBFMonthlyContribution; BBFMonthlyContribution)
//             // {
//             // }
//             column(Daterange; Daterange)
//             { }
//             // column(Gender; Gender)
//             // { }
//             // column(County; County)
//             // { }
//             // column(transferredSC; transferredSC) { }

//             trigger OnPreDataItem()
//             var
//                 myInt: Integer;
//             begin
//                 CompanyInformation.Get;
//                 CompanyInformation.CalcFields(Picture);
//                 Daterange := Members.GetFilters;
//             end;

//             trigger OnAfterGetRecord()
//             begin
//                 RiskBalance := 0;
//                 BOSADepositBalance := 0;
//                 DepositsMonthlyContribution := 0;
//                 Prorata := 0;
//                 MinimumContr := 0;
//                 FOSABalance := 0;
//                 BusinessDeposits := 0;
//                 RegistrationFee := 0;
//                 RiskMonthlyContribution := 0;
//                 BBFMonthlyContribution := 0;
//                 Age := 0;
//                 Days := 0;
//                 BBFBal := 0;
//                 FOSAAcStatus := ' ';
//                 FOSAccNo := ' ';
//                 RecruiterID := ' ';
//                 RecruiterIDType := ' ';
//                 LoanBal := 0;
//                 ShareCapBal := 0;
//                 transferredSC := 0;

//                 if Members."Date of Birth" <> 0D then begin
//                     Days := Today - Members."Date of Birth";
//                     Age := ROUND((Days / 365.2364), 1, '<') //Takes into Account Leap Years
//                 end
//                 else
//                     Age := 0;
//                 if MemberFact.Get(Members."No.") then begin
//                     MemberFact.CalcFields("Entrance Fee", "Transferred Share Capital", "BOSA Deposit", BBF, Risk, "Share Capital", "Unallocated Funds", "Business Deposits", "BBF Contribution", "Risk Contribution", "Bosa Monthly Contribution", "FOSA Savings", "Total Loans");
//                     RegistrationFee := MemberFact."Entrance Fee";
//                     RiskBalance := MemberFact.Risk;
//                     BusinessDeposits := memberFact."Business Deposits";
//                     BBFBal := MemberFact.BBF;
//                     BOSADepositBalance := MemberFact."BOSA Deposit";
//                     ShareCapBal := memberFact."Share Capital";
//                     transferredSC := memberFact."Transferred Share Capital";
//                     UnallocatedFunBal := memberFact."Unallocated Funds";
//                     Prorata := CustomCuesCodeunit.Prorata(Members."No.", '1');
//                     RiskMonthlyContribution := memberFact."Risk Contribution";
//                     DepositsMonthlyContribution := memberFact."Bosa Monthly Contribution";
//                     MinimumContr := memberFact."Bosa Monthly Contribution";
//                     BBFMonthlyContribution := memberFact."BBF Contribution";
//                     FOSABalance := memberFact."FOSA Savings";
//                     LoanBal := memberFact."Total Loans";
//                 end;
//                 //LoanBal := LoansProcess.GetTotalMemberLoanBalance(Members."No.", Today);

//                 if Members."Recruited by Type" = Members."Recruited by Type"::Others then begin
//                     if Memb.Get(Members."Recruited By") then
//                         RecruiterIDType := FORMAT(Memb."Primary Identification Type");
//                     RecruiterID := Memb."Primary Identification";
//                 end;

//                 FOSAccNo := '';
//                 SavingsAccount.Reset;
//                 SavingsAccount.SetRange("Member No.", Members."No.");
//                 SavingsAccount.SetLoadFields("Balance (LCY)", "No.", Status, "Product Category", "Monthly Contribution");
//                 SavingsAccount.SetRange("Product Type", '002');
//                 if SavingsAccount.FindSet() then begin
//                     FOSAccNo := SavingsAccount."No.";
//                     FOSAAcStatus := Format(SavingsAccount.Status);
//                 end;
//                 if DepositsMonthlyContribution < Prorata then
//                     DepositsMonthlyContribution := Prorata;



//             end;
//         }
//     }

//     requestpage
//     {
//         SaveValues = true;
//         layout
//         {

//         }
//         actions
//         {
//             area(processing)
//             {
//             }
//         }
//     }
//     trigger OnPreReport()
//     begin
//         // if StartDate = 0D then Error('Kindly set the start date');
//         // if EndDate = 0D then Error('Kindly set the end date');
//         if CompanyInformation.Get then
//             CompanyInformation.CalcFields(CompanyInformation.Picture);
//         CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
//         CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
//         CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
//     end;


//     Var
//         CompanyInformation: Record "Company Information";
//         CompanyAddress: Text;
//         CompanyTelephone: Text;
//         CommunicationOnline: Text;
//         RiskBalance: Decimal;
//         DepositBalance: Decimal;
//         BOSADepositBalance: Decimal;
//         FOSABalance: Decimal;
//         BusinessDeposits: Decimal;
//         RegistrationFee: Decimal;
//         RiskMonthlyContribution: Decimal;
//         BBFMonthlyContribution: Decimal;
//         DepositsMonthlyContribution: Decimal;
//         Days: Integer;
//         Age: Integer;
//         Memb: Record Members;
//         FromDate: Text[30];
//         ToDate: Text[30];
//         DateFilter: Text[100];
//         Daterange: Text;
//         SavingsAccount: Record "Savings Accounts";
//         MembersTable: Record "Members";
//         DelegateMemberss: Record "Delegate Members";
//         RecruiterID: Code[50];
//         RecruiterIDType: Code[50];
//         UnallocatedFunBal: Decimal;
//         ShareCapBal: Decimal;
//         MemberApp: Record "Member Application";
//         BBFBal: Decimal;
//         FOSAAcStatus: Code[50];
//         FOSAccNo: Code[50];
//         Loans: Record "Loans";
//         LoanBal: Decimal;
//         //Task Progress
//         intProgressTotal: Integer;
//         intProgressI: Integer;
//         TimeProgress: TIME;
//         NoOfRecsProgress: Decimal;
//         NoOfProgressed: Integer;
//         Generating: Label 'Task Progress ...';
//         diaProgress: Dialog;
//         intProgress: Integer;
//         ProductSetup: Record "Product Factory";
//         CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
//         Prorata: Decimal;
//         MinimumContr: Decimal;
//         memberFact: Record "Member FactBox";
//         transferredSC: decimal;
//         LoansProcess: codeunit "loans Process";
// }
//Feel fre to use