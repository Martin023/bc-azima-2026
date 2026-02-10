// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Codeunit 52185428 "Sky Harambee Portal"
// {
//     // +254722368794 Catherine Opondo
//     // +254722578423 Andrew Nganga
//     // +254710596776 Other Guy
//     // Server.1914


//     trigger OnRun()
//     var
//         Pin: Text;
//         I: Integer;
//         SkyAuth: Record "Sky USSD Auth";
//         LoginUsernameType: Option Phone,"E-Mail";
//         // SHA256Demo: Codeunit "Sky Mbanking";
//         Records: Text;
//         Loans: Record Loans;
//         ApprovalEntry: Record "Approval Entry";
//         DateTimeModified: DateTime;
//         Members: Record Members;
//         SavingsAccounts: Record "Savings Accounts";
//         SalaryHeader: Record "Salary Header";
//         Transactions: Record "Cashier Transactions";
//         Lines: Record "Cashier Transaction Lines";
//         SkyMobileSetup: Record "Sky Mobile Setup";
//         SkyPortalSetup: Record "Sky Portal Setup";
//         MemberwithdrawalNotice: Record "Member withdrawal Notice";
//         LoanGuarantorsandSecurity: Record "Loan Guarantors and Security";
//         ATMLinkingApplications: Record "ATM Linking Applications";
//         ATMNo: Code[50];
//         "Count": Integer;
//     begin
//         // Pin := SHA256Demo.CalculateSHA256('Server.1914');
//         Records := '{' +
//             '"full_names":"Kelvin Kaimor",' +
//             '"phone_number":"254721744684",' +
//             '"email_address":"kelvin.kaimor@gmail.com",' +
//             '"gender":"MALE",' +
//             '"date_of_birth":"01/11/1999",' +
//             '"identifier_type": "NATIONAL_ID",' +
//             '"identifier":"36572638",' +
//             '"home_address": "7th Floor Western Heights, Karuna Road, Westlands, Nairobi",' +
//             '"passport_number":"316y56uy",' +
//             '"recruiter_identifier_type":"MEMBER_NUMBER",' +
//             '"citizenship":"KENYAN",' +
//             '"recruiter_identifier":"0123278"' +
//         '}';

//         Records := '{' +
//             '"loan_code":"111",' +
//             '"loan_duration":"6",' +
//             '"loan_purpose":"1180",' +
//             '"loan_branch":"KSM",' +
//             '"amount":"500000",' +
//             '"ghris_payslip_password":"123456",' +
//             '"guarantors": [' +
//             '"254722578423",' +
//             '"254722368794",' +
//             ']' +
//         '}';

//         Records := '{' +
//             '"entry_no":"429887",' +
//             '"guarantors":[' +
//               '{' +
//               '"phone_number":"254722578423",' +
//               '"action":"ADD",' +
//               '},' +
//               '{' +
//               '"phone_number":"254722368794",' +
//               '"action":"REMOVE",' +
//               '},' +
//             ']' +
//         '}';
//         //UpdateGuarantors('Update Guarantors',Pin,'254710596776',Records);
//         //ApplyLoan('Apply Loan',Pin,'254710596776',Records);
//         //ValidateGuarantors('Validate Guarantors',Pin,'254710596776','254722368794','111');
//         //MESSAGE(GetMobileLoanList('Loan List',Pin,'254710596776'));
//         //MESSAGE(CreateVirtualMemberApplication('',Pin,'254700522992',Records));

//         //MESSAGE(GetCountries('',Pin,'254796728482'));
//         //TestFunction('DMT0012239');
//         //Pin :=SHA256Demo.CalculateSHA256('DEAD79C5');
//         //MESSAGE(MemberLogin('LogIn',TRUE,'254722368794',SHA256Demo.CalculateSHA256('F5EA3938')));
//         //MESSAGE(MemberLogin('LogIn',TRUE,'254722368794',pin));

//         //MESSAGE(ResetPassword('254722368794','0123278','10895164'));

//         //OnBoardMembers;

//         //MESSAGE(GetKYC('254722368794',Pin));
//         //MESSAGE(GetKYC('M4721476587',SHA256Demo.CalculateSHA256('DEAD79C5')));

//         //MESSAGE(GetMemberPicture('0123278'));

//         //MESSAGE(SetKYC('254722368794',Pin,'000075','4835193'));
//         //MESSAGE(SetKYC('254722368794',Pin,'0123278','10895164'));
//         //MESSAGE(SetKYC('254721476587',Pin,'0126379','20546809'));
//         //MESSAGE(SetKYC('254704365759',Pin,'0195843','22078153'));

//         //AddMemberToPortal('carlton.moseti@skyworld.co.ke','254796649507','003823',LoginUsernameType::"E-Mail");  //passB79B76EB
//         //AddMemberToPortal('carlton.moseti@skyworld.co.ke','254796649507','003823',LoginUsernameType::"E-Mail");  //passB79B76EB


//         //MESSAGE(ChangeMemberPassword('Change Member PIN',TRUE,'254722368794',SHA256Demo.CalculateSHA256('CE3D7ECA'),SHA256Demo.CalculateSHA256('Msangi')));
//         //MESSAGE(ChangeMemberPassword('Change Member PIN',TRUE,'254722368794',SHA256Demo.CalculateSHA256('Pass2'),SHA256Demo.CalculateSHA256('Pass3')));


//         //MESSAGE(GetMemberDetails('Member Details',Pin,'254722368794'));
//         //MESSAGE(GetMemberDetails('Member Details','1234','254715504531'));
//         //MESSAGE(GetMemberDetails('Member Details',Pin,'254721476587'));


//         //MESSAGE(GetAccountList('Account List',Pin,'254722368794'));
//         //MESSAGE(GetAccountList('Account List',Pin,'254715504531'));


//         //MESSAGE(GetAccountDetails('Account Details',Pin,'254722368794','5050123278000'));
//         //MESSAGE(GetAccountDetails('Account Details','Sky2019$','254722368794','5050123278000','FOSA','FOSA Savings Account'));
//         ////MESSAGE(GetAccountDetails('Account Details','1111','254706405989','000075','BOSA','Shares Capital'));
//         //MESSAGE(GetAccountDetails('Account Details','1111','254706405989','020123278f','BOSA','Shares Capital'));

//         //MESSAGE(GetAccountDetails('Account Details','1234','254715504531','0101-001-02322','FOSA','ORDINARY'));
//         //MESSAGE(GetAccountDetails('Account Details','1234','254715504531','002778','BOSA','Deposit Contribution'));

//         //MESSAGE(GetAccountStatement('Account Statement',Pin,'254722368794','29/10/2021','08/11/2021',1,3,'5050123278000'));//total recs 10

//         //MESSAGE(GetAccountStatementReport('Account STMT RPT',Pin,'254722368794','29/10/2021','08/11/2021','PDF','5050123278000'));
//         //MESSAGE(GetAccountStatementReport('Account STMT RPT',Pin,'254722368794','29/10/2021','08/11/2021','PkjhkF','5050123278000'));

//         //MESSAGE(GetLoanType('Loan List',Pin,'254722368794'));
//         //MESSAGE(GetLoanType('Loan List',Pin,'254715504531'));

//         //MESSAGE(GetLoanList('Loan List',Pin,'254722368794'));
//         //MESSAGE(GetLoanList('Loan List',Pin,'254706405989'));

//         //MESSAGE(GetLoanList('Loan List',SHA256Demo.CalculateSHA256('Pa$$w2rd*2010'),'254720423063'));

//         //MESSAGE(GetLoanDetails(Pin,'254722368794','LN00277358'));

//         /*------------------------------Loan stmt data-------------------------------*/
//         //Member No: 001944
//         //FOSA Acc : 0101-001-00586
//         //Phone    : +254721494631
//         //Loan No  : LB006096
//         //Pin      : 0000
//         /*------------------------------Loan stmt data-------------------------------*/

//         //MESSAGE(GetLoanStatement('Loan Statement',Pin,'254722368794','LN00277358','11/08/2021','09/11/2021',18,2));
//         //MESSAGE(GetLoanStatementReport('Loan Statement',Pin,'254722368794','PDF','LN00277358','11/08/2021','09/11/2021'));
//         //MESSAGE(GetLoanStatementReport('Loan Statement',Pin,'254706405989','PDF','LB009228','10/01/2017','20/12/2021'));

//         //MESSAGE(GetLoanGuaranteed('Loans Guaranteed',Pin,'254722368794'));

//         //MESSAGE(GetLoanGuarantors('Loan Guarantors',Pin,'254722368794','LN00277358'));
//         //MESSAGE(GetLoanGuarantors('Loan Guarantors','2222','254707889422','LF018275'));
//         //MESSAGE(GetLoanGuarantors('Loan Guarantors','2222','254707889422','LF0182722'));

//         //MESSAGE(LoanCalculator('111'));

//         //MESSAGE(SetLoginAttemptDetails('254706405989',0,'','',''));
//         //MESSAGE(SetLoginAttemptDetails('254722368794',0,'','',''));

//         //MESSAGE(GetLoginAttemptDetails('254714207176'));
//         //MESSAGE(GetLoginAttemptDetails('254722368794'));

//         //MESSAGE(SetOTPAttemptDetails('254706405989',0,'','',''));
//         //MESSAGE(SetOTPAttemptDetails('254722368794',0,'','',''));

//         //MESSAGE(GetOTPAttemptDetails('254706405989'));
//         //MESSAGE(GetOTPAttemptDetails('254722368794'));


//         //MESSAGE(FORMAT(CreateDate('01/01/2017')));
//         //MESSAGE(FORMAT(FormatDateTime('2021-10-26 10:15:29')));

//         //MESSAGE(FormatDateTimeReverse(CURRENTDATETIME));

//         //MESSAGE(FORMAT(CURRENTDATETIME));

//         //TestB64();
//         //AddMemberToPortal('msangicyprian@gmail.com','254706405989','000075',LoginUsernameType::Phone);

//         // MESSAGE(SetKYC('254706405989',SHA256Demo.CalculateSHA256('1111'),'000075','4835193'));

//         //MESSAGE(GetMemberOTPChannel('254722368794'));

//         //OnBoardMembers;

//         //MESSAGE(PushSMS('254723099300','Your OTP is 1234'));

//         /*
//         /***Catherines Account Test***/
//         // IDNo :10895164
//         // Member No :0123278
//         // Staff No :0009509257
//         // Phone Number :254722368794
//         // Password: Sky2010
//         // Acc No :5050123278000
//         // /***----------------------***/
//         // */
//         //MESSAGE(GetStaffLeaveTypes('Leave type',Pin,'254710250817'));

//         //MESSAGE(GetStaffLeaveRelievers('Leave Reliever',Pin,'254722368794'));
//         //MESSAGE(GetStaffLeaveEnd('Leave END',Pin,'254722368794','17/11/2021',3));
//         //MESSAGE(StaffApplyLeave('Apply Leave',Pin,'254720532576','31/10/2022','LTY01',3,'201502368'));
//         //MESSAGE(StaffApplyLeave('Apply Leave',SHA256Demo.CalculateSHA256('4F587356'),'254708277227','19/07/2022','LTY01',3,'0008908120'));
//         //MESSAGE(GetStaffLeaveApplications( 'Leave Application',Pin,'254722368794','01/01/2021','19/11/2021',1,3));

//         //MESSAGE(GetStaffPayslipPeriods( 'Payroll Periods',Pin,'254722368794',2022));

//         //MESSAGE(GetStaffPayslipReport('Payslip',Pin,'254722368794','01/10/2021'));
//         //MESSAGE(GetStaffPayslipPeriods)
//         //MESSAGE(StaffCancelLeaveApplication('Cancel Leave',Pin,'254722368794','LAPP02545'));
//         //MESSAGE(TestFunction('0123278'));
//         //MESSAGE(GetStaffP9Report('P9',Pin,'254722368794',2019));
//         //MESSAGE(GetDividendPayslip('dividend pay',Pin,'254722368794',2020));
//         //MESSAGE(GetDividendPayslipPeriods('Dividend Periods',Pin,'254722368794'));
//         // DeleteFunction;
//         // Records := '{"data":[{"name":"CARL JOHN","relationship":"brother","date_of_birth":"01/01/2000","id_number":"123456789",'+
//         // '"allocation":100,"address":"NAIROBI, KENYA","mobile_number":"254700112233","email":"carl@john.com"},'+
//         //
//         // '{"name":"msangi manyatta","relationship":"brother","date_of_birth":"01/01/2000","id_number":"123456789",'+
//         // '"allocation":100,"address":"NAIROBI, KENYA","mobile_number":"254700112233","email":"carl@john.com"}'+
//         // ']}';

//         //MESSAGE(CreateNextOfKin('Create NOK',Pin,'254722368794',Records));
//         //TestB64;
//         //TestFunction();
//         //MESSAGE(FORMAT(GetRemainingInstallments('LN00233290')));
//         //MESSAGE(FORMAT(GetLoanNewMonthlyRepayment('LN00233290',32)));
//         // IF Loans.GET('LN00386187') THEN BEGIN
//         //  Loans.Status := Loans.Status::Approved;
//         //  Loans.MODIFY;
//         // EN
//         // s
//         // Loans.RESET;
//         // Loans.SETRANGE("Disbursement Date",20220401D,20220430D);
//         // Loans.SETRANGE(Posted,TRUE);
//         // //Loans.SETFILTER("Outstanding Balance",'>0');
//         // IF Loans.FINDFIRST THEN MESSAGE(FORMAT(Loans.COUNT));

//         //MESSAGE(GetDelegatesBranchDetails('Get Delegates Branch Details',Pin,'254724958846'));
//         //MESSAGE(GetDelegatesMonthlyReturnEntries('Get Delegates Monthly Return Entries',Pin,'254724958846'));


//         //MESSAGE(SubmitDelegateCorrespondence('Action',Pin,'254724537204',Records));
//         //MESSAGE(GetDelegateMeetingReport('Get Meeting Reprt',Pin,'254724537204','DMT0012232'));

//         //MESSAGE(GetStaffLeaveTypes('Action',Pin,'254721656369'));

//         //MESSAGE(GetComplaintsCategories('Complaints',Pin,'254722980975'));

//         //RemoveMeeting('DMT0012562');

//         // IF SavingsAccounts.GET('5050123278000') THEN BEGIN
//         // ATMNo := SavingsAccounts."Transactional Mobile No";
//         // END;
//         //
//         // IF SavingsAccounts.GET('5050123235000') THEN BEGIN
//         // SavingsAccounts."ATM No." := ATMNo;
//         // SavingsAccounts.MODIFY;
//         // END;


//         // ATMLinkingApplications.RESET;
//         // ATMLinkingApplications.SETRANGE("Account No",'5050123235000');
//         // ATMLinkingApplications.SETRANGE(Collected,TRUE);
//         // IF ATMLinkingApplications.FINDFIRST THEN BEGIN
//         //  ATMLinkingApplications."Linked Date" := 20221015D;
//         //  ATMLinkingApplications.MODIFY;
//         // END;

//         //
//         // IF Members.GET('0126379') THEN BEGIN
//         //  Members."Region Code" := '0100';
//         //  Members.MODIFY;
//         // END;

//         // Members.RESET;
//         // Members.SETFILTER("Region Code",'<>%1','');
//         // IF Members.FINDSET THEN
//         //  MESSAGE(FORMAT(Members.COUNT()));
//         // MESSAGE(FormatDate(20990101D));

//         SavingsAccounts.Reset;
//         SavingsAccounts.SetRange("Product Category", SavingsAccounts."Product Category"::"BOSA Deposits");
//         SavingsAccounts.SetRange(Status, SavingsAccounts.Status::Active);
//         SavingsAccounts.SetRange("Balance (LCY)", 120000, 170000);
//         if SavingsAccounts.FindSet then begin
//             repeat
//                 Members.Reset;
//                 Members.SetRange("No.", SavingsAccounts."Member No.");
//                 Members.SetRange(Status, Members.Status::Active);
//                 Members.SetFilter("Phone No.", '%1', '+2547*');
//                 if Members.FindFirst then begin
//                     Count += 1;
//                     Message(Members."No.");
//                 end;
//             until (SavingsAccounts.Next = 0) or (Count = 5);
//         end;
//         Message('Done');

//     end;

//     var
//         JSonString: code[100];//dotnet String;
//         JObject: code[100];//dotnet JObject;
//         ArrayString: Text;
//         JSONArray: code[100];//dotnet JArray;
//         ArrayString1: code[100];//dotnet String;
//         JToken: code[100];//dotnet JToken;
//         TempJObject: code[100];//dotnet JObject;
//         StringBuilder: code[100];//dotnet StringBuilder;
//         StringWriter: code[100];//dotnet StringWriter;
//         GlobalNULL: Variant;
//         JsonTextWriter: code[100];//dotnet JsonTextWriter;
//         JsonFormatting: code[100];//dotnet Formatting;
//         GenSetUp: Record "Credit Nos. Series";
//         Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN;
//         Eligibility: Boolean;
//         SaccoTrans: Codeunit "Sacco Transactions";
//         SkyMobileLoans: Record "Sky Mobile Loans";
//         diffrence: Decimal;
//         memberHandler: Record "Portal Member App Handlers";
//         membN: Code[20];
//         Hremployee: Record "HR Employees";
//         Country: Record "Country/Region";
//         Name: Text;
//         countryCode: Text;
//         HMember: Record Members;
//         Priority: Integer;
//         Sep: label '\::/';
//         Null: label 'NULL';
//         Success: label '200';
//         Account_Does_Not_Exist: label '300';
//         Parameters_Not_Valid_Or_Missing: label '400';
//         Caller_Not_Authorized_For_This_Request: label '401';
//         Insufficient_Funds: label '402';
//         Daily_Amount_Limit_Reached: label '403';
//         Operation_Does_Not_Exist: label '404';
//         Daily_Frequency_Limit_Reached: label '405';
//         Severe_problem_Has_Occured: label '500';
//         StatusOK: label '200';
//         StatusNotFound: label '404';
//         ChannelThroughFosa: label 'You do not qualify for this product. Kindly channel your Salary through Harambee Sacco';
//         UssdCode: label '*357#';
//         Br: label '';
//         PaybillNo: label '525200';
//         HelpDesk: label '0709943000';
//         loans: Record Loans;

//     local procedure TestFunction(Parameter: Code[30]) Response: Text
//     var
//         Members: Record Members;
//         ImageData: Record "Image Data";
//         OutStr: OutStream;
//         TextEncoding: TextEncoding;
//         NoteText: BigText;
//         Data: InStream;
//         File1: File;
//         Line: Text[1024];
//         SkyAuth: Record "Sky USSD Auth";
//         SavingsAccounts: Record "Savings Accounts";
//         DelegatesMinutesHeader: Record "Delegates Minutes Header";
//         DelegatesMeetingAttendees: Record "Delegates Meeting Attendees";
//         DelegatesMonthlyReturns: Record "Delegates Monthly Returns";
//         DelegatesReturnsLines: Record "Delegates Returns Lines";
//         ComplainandRemarks: Record "Complain and Remarks";
//     begin
//         // 52186056 Delegates Minutes Header
//         // 52186057 Delegates Meeting Attendees
//         // 52186225 Delegates Monthly Returns
//         // 52186226 Delegates Returns Lines
//         // 52186227 Complain and Remarks


//         DelegatesMinutesHeader.Reset;
//         DelegatesMinutesHeader.SetRange(Code, Parameter);
//         if DelegatesMinutesHeader.FindFirst then
//             DelegatesMinutesHeader.DeleteAll;

//         DelegatesMeetingAttendees.Reset;
//         DelegatesMeetingAttendees.SetRange("Header No", Parameter);
//         if DelegatesMeetingAttendees.FindFirst then
//             DelegatesMeetingAttendees.DeleteAll;

//         DelegatesMonthlyReturns.Reset;
//         DelegatesMonthlyReturns.SetRange("Header No", Parameter);
//         if DelegatesMonthlyReturns.FindFirst then
//             DelegatesMonthlyReturns.DeleteAll;

//         DelegatesReturnsLines.Reset;
//         DelegatesReturnsLines.SetRange("Header No", Parameter);
//         if DelegatesReturnsLines.FindFirst then
//             DelegatesReturnsLines.DeleteAll;

//         ComplainandRemarks.Reset;
//         ComplainandRemarks.SetRange("Header No", Parameter);
//         if ComplainandRemarks.FindFirst then
//             ComplainandRemarks.DeleteAll;

//         Message('Update Done');
//     end;

//     local procedure TestB64()
//     var
//         FileManagement: Codeunit "File Management";
//         // TempBlob: Record TempBlob;
//         Base64PDF: Text;
//         FileName: Text;
//     begin
//         FileName := 'C:\b64\sample.pdf';
//         // REPORT.SAVEASPDF(50018,FileName,SkyAgentsTransactions);
//         // FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
//         //MESSAGE('%1',TempBlob.ToBase64String);
//         // Base64PDF := FORMAT(TempBlob.ToBase64String);
//         Message(Base64PDF);



//         //FileName :=  'C:\NAV\Service Invoices\PSI0000081.pdf';

//         //FileManagement.BLOBImportFromServerFile(TempBlob,FileName);

//         //MESSAGE('%1',TempBlob.ToBase64String);
//     end;

//     local procedure Initialize(Indent: Boolean)
//     begin
//         // StringBuilder := StringBuilder.StringBuilder;
//         // StringWriter := StringWriter.StringWriter(StringBuilder);
//         // JsonTextWriter := JsonTextWriter.JsonTextWriter(StringWriter);
//         // if Indent then begin JsonTextWriter.Formatting := JsonFormatting.Indented; end;

//         Clear(GlobalNULL);
//     end;

//     local procedure GetJSon(Indent: Boolean) JSon: Text
//     begin
//         // JSon := StringBuilder.ToString;
//         Initialize(Indent);
//     end;

//     local procedure GenerateJSONResponse("Action": Code[50]; Status: Code[50]; Payload: Text; Indent: Boolean) Response: Text
//     begin
//         // Initialize(Indent);
//         // JsonTextWriter.WriteStartObject;
//         // JsonTextWriter.WritePropertyName('response');
//         // JsonTextWriter.WriteStartObject;
//         // JsonTextWriter.WritePropertyName('action');
//         // JsonTextWriter.WriteValue(Action);
//         // JsonTextWriter.WritePropertyName('status');
//         // JsonTextWriter.WriteValue(Status);
//         // JsonTextWriter.WritePropertyName('payload');
//         // JsonTextWriter.WriteRawValue(Payload);
//         // JsonTextWriter.WriteEndObject;
//         // JsonTextWriter.WriteEndObject;

//         // JsonTextWriter.Flush;
//         // JSonString := GetJSon(Indent);

//         // Response := JSonString.ToString;
//     end;


//     procedure SetKYC(Username: Text; Password: Text; IDNo: Code[30]) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SkyAuth: Record "Sky USSD Auth";
//         Phone: Text;
//         PasswordAndSalt: Text;
//         // SHA256Demo: Codeunit "Sky Mbanking";
//         AccountNo: Code[30];
//         RealMemberNo: Code[30];
//         SavingsAccounts: Record "Savings Accounts";
//         Members: Record Members;
//         RealIDNo: Code[30];
//         KYCPass: Boolean;
//         StaffNo: Code[30];
//     begin
//         // //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        // LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        // LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);


//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         KYCPass := false;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         if SkyAuth.FindFirst then begin
//             Status := 'SUCCESS';
//             ResponseMessage := 'Member Found';
//             AccountNo := SkyAuth."Account No.";
//             SavingsAccounts.Get(AccountNo);
//             RealMemberNo := SavingsAccounts."Member No.";
//             Members.Get(RealMemberNo);
//             RealIDNo := SavingsAccounts."ID No.";
//             StaffNo := SavingsAccounts."Payroll/Staff No.";

//             PasswordAndSalt := GetPassFromUserName(Username, Password);
//             if Status = 'SUCCESS' then begin
//                 if /*((RealMemberNo = MemberNo) OR (StaffNo = MemberNo)) AND*/ (RealIDNo = IDNo) and (PasswordAndSalt = SkyAuth.Password) then begin
//                     KYCPass := true;
//                     SkyAuth."KYC Test" := true;
//                     SkyAuth.Modify;
//                     Status := 'SUCCESS';
//                     ResponseMessage := 'KYC Test Passed';
//                 end else begin
//                     KYCPass := false;
//                     SkyAuth."KYC Test" := false;
//                     SkyAuth.Modify;
//                     Status := 'FAILED';
//                     ResponseMessage := 'KYC Test Failed';
//                 end;
//             end;
//         end else begin
//             Status := 'FAILED';
//             ResponseMessage := 'Member Not Found';
//         end;

//         //        // LocalJsonTextWriter.WriteStartObject;
//         //        // LocalJsonTextWriter.WritePropertyName('data');
//         //        // LocalJsonTextWriter.WriteStartObject;

//         // if KYCPass then begin
//         //        //     LocalJsonTextWriter.WritePropertyName('kyc_test');
//         //        //     LocalJsonTextWriter.WriteValue('TRUE');
//         //     //ResponseMessage:= 'KYC Test Set';
//         // end else begin
//         //        //     LocalJsonTextWriter.WritePropertyName('kyc_test');
//         //        //     LocalJsonTextWriter.WriteValue('FALSE');
//         //     // ResponseMessage:= 'KYC Test failed';
//         // end;


//         //        // LocalJsonTextWriter.WriteEndObject;
//         //        // LocalJsonTextWriter.WritePropertyName('title');
//         //        // LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        // LocalJsonTextWriter.WritePropertyName('message');
//         //        // LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        // LocalJsonTextWriter.WriteEndObject;

//         // //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse('KYC Test', Status, Payload, true);

//     end;


//     procedure GetKYC(Username: Text; Password: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         Vendor: Record Vendor;
//         Product: Record "Loan Charges";
//         SkyAuth: Record "Sky USSD Auth";
//         // SkyMBanking: Codeunit "Sky Mbanking";
//         AccountNo: Code[30];
//     begin
//         // //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        // LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        // LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;



//         Status := 'FAILED';
//         ResponseTitle := 'Get KYC';
//         ResponseMessage := 'Internal Error';

//         //        // LocalJsonTextWriter.WriteStartObject;
//         //        // LocalJsonTextWriter.WritePropertyName('data');
//         //        // LocalJsonTextWriter.WriteStartObject;
//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange(SkyAuth."Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if SkyAuth.FindFirst then begin

//             //            // LocalJsonTextWriter.WritePropertyName('initial_password_changed');
//             // if SkyAuth."Initial Password Changed" then
//             //            //     LocalJsonTextWriter.WriteValue('TRUE')
//             // else
//             //            //     LocalJsonTextWriter.WriteValue('FALSE');

//             //            // LocalJsonTextWriter.WritePropertyName('member_verified');
//             // if SkyAuth."KYC Test" then
//             //            //     LocalJsonTextWriter.WriteValue('TRUE')
//             // else
//             //            //     LocalJsonTextWriter.WriteValue('FALSE');

//             Status := 'SUCCESS';
//             ResponseMessage := 'KYC Results Fetched';
//         end else begin
//             //            // LocalJsonTextWriter.WritePropertyName('initial_password_changed');
//             //            // LocalJsonTextWriter.WriteValue('FALSE');
//             //            // LocalJsonTextWriter.WritePropertyName('member_verified');
//             //            // LocalJsonTextWriter.WriteValue('FALSE');

//             Status := 'FAILED';
//             ResponseMessage := 'Member Not Found';
//         end;
//         //        // LocalJsonTextWriter.WriteEndObject;
//         //        // LocalJsonTextWriter.WritePropertyName('title');
//         //        // LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        // LocalJsonTextWriter.WritePropertyName('message');
//         //        // LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        // LocalJsonTextWriter.WriteEndObject;

//         // //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse('Get KYC', Status, Payload, true);

//     end;


//     procedure MemberLogin("Action": Code[50]; Indent: Boolean; Username: Text[100]; Password: Text[100]) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SkyAuth: Record "Sky USSD Auth";
//         AttemptsCount: Integer;
//         Checker: Boolean;
//         AccountNo: Code[30];
//         RealMemberNo: Code[30];
//         SavingsAccounts: Record "Savings Accounts";
//         HashedPassAndSalt: Text;
//         // SHA256Demo: Codeunit "Sky Mbanking";
//         Members: Record Members;
//         ActivityType: Option Fresh,Refresh;
//     begin
//         // //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        // LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        // LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         //        // if Indent then begin LocalJsonTextWriter.Formatting := JsonFormatting.Indented; end;

//         //Username := PIN;

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange(SkyAuth."Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         //SkyAuth.SETRANGE(Password,GetPassFromUserName(Username,Password));
//         if SkyAuth.FindFirst then begin

//             Status := 'FAILED';
//             ResponseTitle := 'Login Failed';
//             ResponseMessage := 'Member Login Failed';
//             Checker := true;

//             if ((SkyAuth."Login Attempts Action P" = 'SUSPEND') or (SkyAuth."OTP Attempts Action P" = 'SUSPEND')) then begin
//                 if Checker then begin
//                     if ((SkyAuth."Login Attempts Action P" = 'SUSPEND') and (SkyAuth."OTP Attempts Action P" <> 'SUSPEND')) then begin
//                         if (SkyAuth."Login Attempts Action Expiry P" > CurrentDatetime) then begin
//                             Status := 'FAILED';
//                             ResponseTitle := 'Member Suspended';
//                             ResponseMessage := 'Member is Suspended';
//                             Checker := false;
//                         end;
//                     end;
//                 end;

//                 if Checker then begin
//                     if ((SkyAuth."Login Attempts Action P" <> 'SUSPEND') and (SkyAuth."OTP Attempts Action P" = 'SUSPEND')) then begin
//                         if (SkyAuth."OTP Attempts Action Expiry P" > CurrentDatetime) then begin
//                             Status := 'FAILED';
//                             ResponseTitle := 'Member Suspended';
//                             ResponseMessage := 'Member is Suspended';
//                             Checker := false;


//                         end;
//                     end;
//                 end;

//                 if ((SkyAuth."Login Attempts Action P" = 'SUSPEND') and (SkyAuth."OTP Attempts Action P" = 'SUSPEND')) then begin
//                     if (SkyAuth."Login Attempts Action Expiry P" > SkyAuth."OTP Attempts Action Expiry P") then begin
//                         if Checker then begin
//                             if (SkyAuth."Login Attempts Action Expiry P" > CurrentDatetime) then begin
//                                 Status := 'FAILED';
//                                 ResponseTitle := 'Member Suspended';
//                                 ResponseMessage := 'Member is Suspended';
//                                 Checker := false;


//                             end;
//                         end;
//                     end
//                     else begin
//                         if Checker then begin
//                             if (SkyAuth."OTP Attempts Action Expiry P" > CurrentDatetime) then begin
//                                 ResponseTitle := 'Member Suspended';
//                                 ResponseMessage := 'Member is Suspended';
//                                 Checker := false;


//                             end;
//                         end;
//                     end;
//                 end;
//             end;



//             //    IF Checker THEN BEGIN
//             //      IF (SkyAuth.Status = SkyAuth.Status::Inactive) OR (SkyAuth.Status = SkyAuth.Status::" ")  THEN BEGIN
//             //          Status := 'FAILED';
//             //          ResponseTitle:= 'Member Blocked';
//             //          ResponseMessage:= 'Member is Blocked';
//             //          Checker:=FALSE;
//             //      END;
//             //    END;

//             if Checker then begin
//                 if SkyAuth."Password Expiry Time" <> 0DT then begin
//                     if CurrentDatetime > SkyAuth."Password Expiry Time" then begin
//                         Status := 'FAILED';
//                         ResponseTitle := 'Password Expired';
//                         ResponseMessage := 'Initial Password has Expired';
//                         Checker := false;
//                     end;
//                 end;
//             end;

//             if Checker then begin
//                 if SkyAuth.Password <> GetPassFromUserName(Username, Password) then begin
//                     Status := 'FAILED';
//                     ResponseTitle := 'Invalid Login';
//                     ResponseMessage := 'Wrong Username or Password';
//                     Checker := false;
//                     //SetLoginAttemptDetails('254706405989',3,'SUSPEND','SUSPEND','2021-10-31 19:15:29');//remove
//                 end;
//             end;

//             //Member status
//             if Checker then begin
//                 if SavingsAccounts.Get(SkyAuth."Account No.") then begin
//                     if Members.Get(SavingsAccounts."Member No.") then begin
//                         if (Members.Status = Members.Status::Deceased) or (Members.Status = Members.Status::Closed) then begin
//                             Status := 'FAILED';
//                             ResponseTitle := 'Member Status';
//                             ResponseMessage := 'Member status is ' + Format(Members.Status);
//                             Checker := false;
//                         end;
//                     end;
//                 end;
//             end;

//         end else begin
//             Status := 'FAILED';
//             ResponseTitle := 'Invalid Login';
//             ResponseMessage := 'Wrong Username or Password';
//             Checker := false;
//         end;

//         //        // LocalJsonTextWriter.WriteStartObject;
//         //        // LocalJsonTextWriter.WritePropertyName('data');
//         //        // LocalJsonTextWriter.WriteStartObject;
//         //        // LocalJsonTextWriter.WritePropertyName('login_attempts');
//         //        // LocalJsonTextWriter.WriteValue(Format(SkyAuth."Login Attempts Count P"));
//         //        // LocalJsonTextWriter.WritePropertyName('login_attempts_flag');
//         //        // LocalJsonTextWriter.WriteValue(SkyAuth."Login Attempts Tag P");
//         //        // LocalJsonTextWriter.WritePropertyName('login_attempts_action');
//         //        // LocalJsonTextWriter.WriteValue(Format(SkyAuth."Login Attempts Action P"));
//         //        // LocalJsonTextWriter.WritePropertyName('login_attempts_expiry');
//         //        // LocalJsonTextWriter.WriteValue(FormatDateTimeReverse(SkyAuth."Login Attempts Action Expiry P"));
//         //        // LocalJsonTextWriter.WritePropertyName('initial_password_changed');
//         // if SkyAuth."Initial Password Changed" then
//         //        //     LocalJsonTextWriter.WriteValue('TRUE')
//         // else
//         //        //     LocalJsonTextWriter.WriteValue('FALSE');
//         // //-----------------------------------------------------------------
//         //        // LocalJsonTextWriter.WritePropertyName('member_verified');
//         // if SkyAuth."KYC Test" then
//         //        //     LocalJsonTextWriter.WriteValue('TRUE')
//         // else
//         //        //     LocalJsonTextWriter.WriteValue('FALSE');

//         //        // LocalJsonTextWriter.WriteEndObject;


//         if Checker then begin
//             Status := 'SUCCESS';
//             ResponseTitle := 'Login Succesfull';
//             ResponseMessage := 'Member Logged In Successifully';
//             SkyPortalUsers(GetPassFromUserName(Username, Password), SkyAuth."Account No.", false, Activitytype::Refresh);
//         end;


//         /*---------------------------------------------LOGIN CODE-------------------------------------*/
//         //        // LocalJsonTextWriter.WritePropertyName('title');
//         //        // LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        // LocalJsonTextWriter.WritePropertyName('message');
//         //        // LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        // LocalJsonTextWriter.WriteEndObject;

//         // //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, Indent);

//     end;


//     procedure ChangeMemberPassword("Action": Code[50]; Indent: Boolean; Username: Text; MemberOldPassword: Text; MemberNewPassword: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SkyAuth: Record "Sky USSD Auth";
//         Status: Text;
//         FinalPassword: Text;
//         PasswordHistory: Record "Password History";
//         PasswordLimit: Integer;
//         PasswordHistoryCount: Integer;
//         GeneralSetUp: Record "General Set-Up";
//         EntryNo: Integer;
//         PasswordHistor: Record "Password History";
//         ActivityType: Option Fresh,Refresh;
//     begin
//         GeneralSetUp.Get();
//         // //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        // LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        // LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         //        // if Indent then begin LocalJsonTextWriter.Formatting := JsonFormatting.Indented; end;

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         ResponseTitle := 'Change Password';
//         // ResponseMessage:= 'Password changed Failed';

//         Status := 'SUCCESS';

//         //Can Log In With Mail Or Phone Number
//         PasswordHistory.Reset;
//         PasswordHistory.SetRange("Phone Number", Username);
//         if PasswordHistory.FindFirst then
//             PasswordHistoryCount := PasswordHistory.Count;

//         PasswordHistory.Reset;
//         PasswordHistory.SetRange("E-Mail", Username);
//         if PasswordHistory.FindFirst then
//             PasswordHistoryCount := PasswordHistory.Count;

//         PasswordLimit := GeneralSetUp."Password History Limit";

//         PasswordHistory.Reset;
//         PasswordHistory.SetRange("Phone Number", Username);
//         PasswordHistory.SetRange(Password, GetPassFromUserName(Username, MemberNewPassword));
//         if PasswordHistory.FindFirst then begin
//             Status := 'FAILED';
//             ResponseMessage := 'Kindly use a password that you have not used before';
//         end;

//         PasswordHistory.Reset;
//         PasswordHistory.SetRange("E-Mail", Username);
//         PasswordHistory.SetRange(Password, GetPassFromUserName(Username, MemberNewPassword));
//         if PasswordHistory.FindFirst then begin
//             Status := 'FAILED';
//             ResponseMessage := 'Kindly use a password that you have not used before';
//         end;
//         //Can Log In With Mail Or Phone Number


//         //        // LocalJsonTextWriter.WriteStartObject;
//         //        // LocalJsonTextWriter.WritePropertyName('data');
//         //        // LocalJsonTextWriter.WriteStartObject;

//         if Status = 'SUCCESS' then begin
//             SkyAuth.Reset;
//             if CopyStr(Username, 1, 4) = '+254' then
//                 SkyAuth.SetRange("Mobile No.", Username)
//             else
//                 SkyAuth.SetRange("Account No.");
//             SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, MemberOldPassword));
//             if SkyAuth.FindFirst then begin
//                 SkyAuth.Password := GetPassFromUserName(Username, MemberNewPassword);
//                 SkyAuth."Initial Password Changed" := true;
//                 SkyAuth."Password Expiry Time" := 0DT;
//                 SkyAuth.Modify;


//                 PasswordHistory.Reset;
//                 PasswordHistory.SetRange("E-Mail", Username);
//                 if PasswordHistory.FindFirst then begin
//                     repeat
//                         PasswordHistory."Current Password" := false;
//                         PasswordHistory.Modify;
//                     until PasswordHistory.Next = 0;
//                 end;


//                 if PasswordHistoryCount = PasswordLimit then begin
//                     PasswordHistory.Reset;
//                     PasswordHistory.SetRange("E-Mail", Username);
//                     if PasswordHistory.FindFirst then
//                         PasswordHistory.Delete;

//                     PasswordHistory.Reset;
//                     PasswordHistory.SetRange("Phone Number", Username);
//                     if PasswordHistory.FindFirst then
//                         PasswordHistory.Delete;
//                 end;

//                 PasswordHistor.Reset;
//                 if PasswordHistor.FindLast then
//                     EntryNo := PasswordHistor."Entry No" + 1;

//                 PasswordHistory.Init;
//                 PasswordHistory."Entry No" := EntryNo;
//                 PasswordHistory."Account Number" := SkyAuth."Account No.";
//                 PasswordHistory."Phone Number" := SkyAuth."Mobile No.";
//                 PasswordHistory.Password := GetPassFromUserName(Username, MemberNewPassword);
//                 PasswordHistory."E-Mail" := SkyAuth.Username;
//                 PasswordHistory."Current Password" := true;
//                 PasswordHistory.Insert;

//                 ResponseMessage := 'Password changed Successfully';
//                 Status := 'SUCCESS';

//                 //                //LocalJsonTextWriter.WriteStartObject;
//                 //                // LocalJsonTextWriter.WritePropertyName('login_attempts');
//                 //                // LocalJsonTextWriter.WriteValue(Format(SkyAuth."Login Attempts Count P"));
//                 //                // LocalJsonTextWriter.WritePropertyName('login_attempts_flag');
//                 //                // LocalJsonTextWriter.WriteValue(SkyAuth."Login Attempts Tag P");
//                 //                // LocalJsonTextWriter.WritePropertyName('login_attempts_action');
//                 //                // LocalJsonTextWriter.WriteValue(Format(SkyAuth."Login Attempts Action P"));
//                 //                // LocalJsonTextWriter.WritePropertyName('login_attempts_expiry');
//                 //                // LocalJsonTextWriter.WriteValue(FormatDateTimeReverse(SkyAuth."Login Attempts Action Expiry P"));
//                 //                // LocalJsonTextWriter.WritePropertyName('initial_password_changed');
//                 // if SkyAuth."Initial Password Changed" then
//                 //                //     LocalJsonTextWriter.WriteValue('TRUE')
//                 // else
//                 //                //     LocalJsonTextWriter.WriteValue('FALSE');
//                 // //-----------------------------------------------------------------
//                 //                // LocalJsonTextWriter.WritePropertyName('member_verified');
//                 // if SkyAuth."KYC Test" then
//                 //                //     LocalJsonTextWriter.WriteValue('TRUE')
//                 // else
//                 //                //     LocalJsonTextWriter.WriteValue('FALSE');

//                 //                //LocalJsonTextWriter.WriteEndObject;
//                 SkyPortalUsers(GetPassFromUserName(Username, MemberNewPassword), SkyAuth."Account No.", true, Activitytype::Fresh);
//             end else begin
//                 ResponseMessage := 'Password changed Failed';
//                 Status := 'FAILED';
//             end;
//         end;

//         //        // LocalJsonTextWriter.WriteEndObject;

//         //        // LocalJsonTextWriter.WritePropertyName('title');
//         //        // LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        // LocalJsonTextWriter.WritePropertyName('message');
//         //        // LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        // LocalJsonTextWriter.WriteEndObject;

//         // //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, Indent);

//     end;


//     procedure ResetPassword(Username: Text; IDNo: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SkyAuth: Record "Sky USSD Auth";
//         Status: Text;
//         FinalPassword: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         Members: Record Members;
//         PasswordReset: Text;
//         ActivityType: Option Fresh,Refresh;
//         UsesPhone: Boolean;
//     begin
//         // //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        // LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        // LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         UsesPhone := false;
//         if CopyStr(Username, 1, 3) = '254' then begin
//             Username := '+' + Username;
//             UsesPhone := true;
//         end;



//         ResponseTitle := 'Reset Password';
//         ResponseMessage := 'Reset Password Failed';

//         //        // LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');

//         PasswordReset := 'FALSE';

//         Status := 'SUCCESS';

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(Username, Username);
//         if SkyAuth.FindFirst then begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             if (Members."Primary Identification" = IDNo) /*AND ((Members."No." = MemberNo) OR (Members."Payroll/Staff No." = MemberNo))*/ then begin

//                 if UsesPhone then
//                     AddMemberToPortal('', Username, SavingsAccounts."Member No.", SkyAuth."login username type"::Phone, Activitytype::Refresh)
//                 else
//                     AddMemberToPortal(Username, '', SavingsAccounts."Member No.", SkyAuth."login username type"::"E-Mail", Activitytype::Refresh);


//                 ResponseMessage := 'Password Reset Successfully';
//                 PasswordReset := 'TRUE';
//             end else begin
//                 ResponseTitle := 'Reset Password';
//                 ResponseMessage := 'Your Account Details do not Match';
//                 PasswordReset := 'FALSE';
//                 Status := 'FAILED';
//             end;
//         end else begin
//             ResponseTitle := 'Reset Password';
//             ResponseMessage := 'User Not Found';
//             PasswordReset := 'FALSE';
//             Status := 'FAILED';
//         end;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('password_reset');
//         //        LocalJsonTextWriter.WriteValue(PasswordReset);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse('Password Reset', Status, Payload, true);

//     end;


//     procedure GetMemberDetails("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         MemberDetails: Record Members;
//         SkyAuth: Record "Sky USSD Auth";
//         MemberNo: Code[30];
//         NOK: Record "Next of KIN";
//         AccountNo: Code[30];
//         IsStaff: Text[10];
//         Members: Record Members;
//         ImageData: Record "Image Data";
//         SkyMbanking: Codeunit "Sky Mbanking";
//         DelegateMemberss: Record "Delegate Members";
//         IsDelegate: Boolean;
//         DimensionValue: Record "Dimension Value";
//         BranchName: Text;
//         CanProcessMemberApplications: Text;
//         PortalMemberAppHandlers: Record "Portal Member App Handlers";
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         ResponseTitle := 'Get Member Details';
//         ResponseMessage := 'Member Details Fetched Successfully';


//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             AccountNo := SkyAuth."Account No.";
//             Status := 'SUCCESS';
//         end;

//         if Status = 'SUCCESS' then begin
//             if SavingsAccounts.Get(AccountNo) then begin
//                 MemberNo := SavingsAccounts."Member No.";
//             end else begin
//                 ResponseMessage := 'Member Not Found';
//                 Status := 'FAILED';
//             end;
//         end;


//         IsStaff := 'FALSE';
//         Members.Get(MemberNo);
//         if Members."Employer Code" = '00' then IsStaff := 'TRUE';

//         CanProcessMemberApplications := 'FALSE';
//         if PortalMemberAppHandlers.Get(Members."Payroll/Staff No.") then begin
//             if PortalMemberAppHandlers.Status = PortalMemberAppHandlers.Status::Active then
//                 CanProcessMemberApplications := 'TRUE';
//         end;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         if Status = 'SUCCESS' then begin
//             if Members.Get(MemberNo) then begin
//                 DimensionValue.Reset;
//                 DimensionValue.SetRange(Code, Members."Branch Code");
//                 if DimensionValue.FindFirst then begin
//                     BranchName := DimensionValue.Name;
//                 end;
//                 DelegateMemberss.Reset;
//                 DelegateMemberss.SetRange("Delegate MNO.", MemberNo);
//                 DelegateMemberss.SetRange(Retired, false);
//                 DelegateMemberss.SetFilter("Electoral Zone", '<>ALL');

//                 if DelegateMemberss.FindFirst then IsDelegate := true;
//                 //                LocalJsonTextWriter.WritePropertyName('member_no');
//                 //                LocalJsonTextWriter.WriteValue(Members."No.");
//                 //                LocalJsonTextWriter.WritePropertyName('name');
//                 //                LocalJsonTextWriter.WriteValue(Members.Name);
//                 //                LocalJsonTextWriter.WritePropertyName('id_no');
//                 //                LocalJsonTextWriter.WriteValue(Members."Primary Identification");
//                 //                LocalJsonTextWriter.WritePropertyName('phone_no');
//                 //                LocalJsonTextWriter.WriteValue(SavingsAccounts."Mobile Phone No");
//                 //                LocalJsonTextWriter.WritePropertyName('location');
//                 //                LocalJsonTextWriter.WriteValue(Members."Current Address");
//                 //                LocalJsonTextWriter.WritePropertyName('date_of_birth');
//                 //                LocalJsonTextWriter.WriteValue(FormatDate(Members."Date of Birth"));
//                 //                LocalJsonTextWriter.WritePropertyName('email');
//                 //                LocalJsonTextWriter.WriteValue(Members."E-Mail");
//                 //                LocalJsonTextWriter.WritePropertyName('is_staff');
//                 //                LocalJsonTextWriter.WriteValue(IsStaff);
//                 //                LocalJsonTextWriter.WritePropertyName('picture');
//                 //                LocalJsonTextWriter.WriteValue(GetMemberPicture(Members."No."));
//                 //                LocalJsonTextWriter.WritePropertyName('is_delegate');
//                 //                LocalJsonTextWriter.WriteValue(Format(IsDelegate));
//                 //                LocalJsonTextWriter.WritePropertyName('can_process_member_applications');
//                 //                LocalJsonTextWriter.WriteValue(Format(CanProcessMemberApplications));
//                 //                LocalJsonTextWriter.WritePropertyName('branch_code');
//                 //                LocalJsonTextWriter.WriteValue(Format(Members."Branch Code"));
//                 //                LocalJsonTextWriter.WritePropertyName('branch_name');
//                 //                LocalJsonTextWriter.WriteValue(Format(BranchName));
//                 //                LocalJsonTextWriter.WritePropertyName('next_of_kin');
//                 //                LocalJsonTextWriter.WriteStartArray;
//                 NOK.Reset;
//                 NOK.SetRange(NOK."Account No", SavingsAccounts."Member No.");
//                 if NOK.Find('-') then begin
//                     repeat
//                     //                        LocalJsonTextWriter.WriteStartObject;
//                     //                        LocalJsonTextWriter.WritePropertyName('name');
//                     //                        LocalJsonTextWriter.WriteValue(NOK.Name);
//                     //                        LocalJsonTextWriter.WritePropertyName('id_no');
//                     //                        LocalJsonTextWriter.WriteValue(NOK."ID No.");
//                     //                        LocalJsonTextWriter.WritePropertyName('address');
//                     //                        LocalJsonTextWriter.WriteValue(NOK.Address);
//                     //                        LocalJsonTextWriter.WritePropertyName('relationship');
//                     //                        LocalJsonTextWriter.WriteValue(Format(NOK.Relationship));
//                     //                        LocalJsonTextWriter.WritePropertyName('allocation');
//                     //                        LocalJsonTextWriter.WriteValue(Format(NOK."%Allocation") + '%');
//                     //                        LocalJsonTextWriter.WriteEndObject;
//                     until NOK.Next = 0;
//                 end;
//                 //                LocalJsonTextWriter.WriteEndArray;
//                 //default account - FOSA
//                 SavingsAccounts.Get(AccountNo);
//                 SavingsAccounts.CalcFields(Balance);
//                 //                LocalJsonTextWriter.WritePropertyName('fosa_account');
//                 //                LocalJsonTextWriter.WriteStartObject;
//                 //                LocalJsonTextWriter.WritePropertyName('account_no');
//                 //                LocalJsonTextWriter.WriteValue(AccountNo);

//                 //                LocalJsonTextWriter.WritePropertyName('account_name');
//                 //                LocalJsonTextWriter.WriteValue(SavingsAccounts."Product Name");

//                 //                LocalJsonTextWriter.WritePropertyName('book_balance');
//                 //                LocalJsonTextWriter.WriteValue(Format(SavingsAccounts.Balance));

//                 //                LocalJsonTextWriter.WritePropertyName('available_balance');
//                 //                LocalJsonTextWriter.WriteValue(Format(SkyMbanking.GetAccountBalance(SavingsAccounts."No.")));

//                 //                LocalJsonTextWriter.WriteEndObject;
//                 ResponseMessage := 'Member Details Fetched Successfully';
//             end;
//         end;

//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetAccountList("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Loan Charges";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         AccountBal: Decimal;
//         AccountNo: Code[30];
//         IDNo: Text;
//         SavingsAcc: Record "Savings Accounts";
//         ProductFactory: Record "Product Factory";
//         Category: Option;
//         BookBalance: Decimal;
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         ResponseTitle := 'Get Accounts List';
//         ResponseMessage := 'Account List Fetched Successfully';

//         if CopyStr(Username, 1, 3) = '254' then
//             Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             AccountNo := SkyAuth."Account No.";
//             Status := 'SUCCESS';
//         end;

//         if Status = 'SUCCESS' then begin
//             if SavingsAccounts.Get(AccountNo) then begin
//                 ResponseMessage := 'Member Found';
//                 Status := 'SUCCESS';
//                 MemberNo := SavingsAccounts."Member No.";
//                 IDNo := SavingsAccounts."ID No.";
//             end else begin
//                 ResponseMessage := 'Member not Found';
//                 Status := 'FAILED';
//             end;
//         end;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartArray;

//         if Status = 'SUCCESS' then begin

//             ProductFactory.Reset;
//             ProductFactory.SetCurrentkey("Portal Order");
//             ProductFactory.Ascending(true);
//             ProductFactory.SetRange("Portal Viewable", true);
//             if ProductFactory.FindFirst then begin
//                 repeat
//                     SavingsAcc.Reset;
//                     SavingsAcc.SetRange("Member No.", MemberNo);
//                     SavingsAcc.SetRange("Product Type", ProductFactory."Product ID");
//                     if SavingsAcc.FindSet then begin
//                         repeat
//                             SavingsAcc.CalcFields("Balance (LCY)", "Authorised Over Draft", "Uncleared Cheques", "ATM Transactions", "Lien Placed");
//                             if SavingsAcc."Product Type" = '505' then begin
//                                 BookBalance := (SavingsAcc."Balance (LCY)" + SavingsAcc."Authorised Over Draft") -
//                                 (SavingsAcc."Uncleared Cheques" + SavingsAcc."ATM Transactions" + 1000 + SavingsAcc."Lien Placed");
//                             end else
//                                 BookBalance := SavingsAcc."Balance (LCY)";
//                             SavingsAcc.CalcFields("Balance (LCY)");
//                         //                            LocalJsonTextWriter.WriteStartObject;
//                         //                            LocalJsonTextWriter.WritePropertyName('account_no');
//                         //                            LocalJsonTextWriter.WriteValue(SavingsAcc."No.");
//                         //                            LocalJsonTextWriter.WritePropertyName('name');
//                         //                            LocalJsonTextWriter.WriteValue(SavingsAcc.Name);
//                         //                            LocalJsonTextWriter.WritePropertyName('account_name');
//                         //                            LocalJsonTextWriter.WriteValue(SavingsAcc."Product Name");
//                         //                            LocalJsonTextWriter.WritePropertyName('account_type');
//                         //                            LocalJsonTextWriter.WriteValue(Format(ProductFactory.Category));
//                         //                            LocalJsonTextWriter.WritePropertyName('account_status');
//                         //                            LocalJsonTextWriter.WriteValue(Format(SavingsAcc.Status));
//                         //                            LocalJsonTextWriter.WritePropertyName('currency');
//                         //                            LocalJsonTextWriter.WriteValue('KES');
//                         //                            LocalJsonTextWriter.WritePropertyName('book_balance');
//                         //                            LocalJsonTextWriter.WriteValue(Format(SavingsAcc."Balance (LCY)"));
//                         //                            LocalJsonTextWriter.WritePropertyName('available_balance');
//                         //                            LocalJsonTextWriter.WriteValue(Format(BookBalance));
//                         //                            LocalJsonTextWriter.WritePropertyName('actions');
//                         //                            LocalJsonTextWriter.WriteValue(Format(ProductFactory."Mobile Transaction"));
//                         //                            LocalJsonTextWriter.WriteEndObject;
//                         until SavingsAcc.Next = 0;
//                     end;
//                 until ProductFactory.Next = 0;
//                 ResponseMessage := 'Account List Fetched Successfully';
//             end else begin
//                 ResponseMessage := 'This user has no accounts';
//             end;
//         end;
//         //        LocalJsonTextWriter.WriteEndArray;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetAccountDetails("Action": Text; Password: Text; Username: Text; AccNo: Code[30]) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Loan Charges";
//         SavingsAcc: Record "Savings Accounts";
//         MemberNo: Code[30];
//         Members: Record "Social Listening Sites App.";
//         SkyAuth: Record "Sky USSD Auth";
//         TransactionType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Penalty Charged","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Insurance Contribution",Prepayment,"Withdrawable Deposits","Xmas Contribution","Penalty Paid","Dev Shares","Co-op Shares","School Fee","Idd Fitr";
//         MemLedge: Record "Interest Due Period";
//         CreditAmount: Decimal;
//         Balance: Decimal;
//         DebitAmount: Decimal;
//         AccountCheck: Boolean;
//         AccountNo: Code[30];
//         ProductFactory: Record "Product Factory";
//         Category: Option;
//         ProductId: Code[10];
//         BookBalance: Decimal;
//     begin


//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Get Account Details';
//         ResponseMessage := 'Account Details Fetched Successfully';

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             AccountNo := SkyAuth."Account No.";
//             Status := 'SUCCESS';
//         end;
//         if SavingsAccounts.Get(AccountNo) then begin
//             MemberNo := SavingsAccounts."Member No.";
//         end;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;

//         if Status = 'SUCCESS' then begin

//             SavingsAcc.Reset;
//             SavingsAcc.SetRange("No.", AccNo);
//             if SavingsAcc.FindFirst then begin
//                 SavingsAcc.CalcFields("Balance (LCY)", "Authorised Over Draft", "Uncleared Cheques", "ATM Transactions", "Lien Placed");
//                 if SavingsAcc."Product Type" = '505' then begin
//                     BookBalance := (SavingsAcc."Balance (LCY)" + SavingsAcc."Authorised Over Draft") -
//                     (SavingsAcc."Uncleared Cheques" + SavingsAcc."ATM Transactions" + 1000 + SavingsAcc."Lien Placed");
//                 end else
//                     BookBalance := SavingsAcc."Balance (LCY)";

//                 ProductFactory.Get(SavingsAcc."Product Type");
//                 SavingsAcc.SetFilter("Product Category", ProductId);
//                 // SavingsAcc.CALCFIELDS("Balance (LCY)");
//                 SavingsAcc.CalcFields("Balance (LCY)", "Credit Amount (LCY)", "Debit Amount (LCY)");
//                 //                LocalJsonTextWriter.WritePropertyName('account_no');
//                 //                LocalJsonTextWriter.WriteValue(SavingsAcc."No.");
//                 //                LocalJsonTextWriter.WritePropertyName('account_name');
//                 //                LocalJsonTextWriter.WriteValue(SavingsAcc.Name);
//                 //                LocalJsonTextWriter.WritePropertyName('account_name');
//                 //                LocalJsonTextWriter.WriteValue(SavingsAcc."Product Name");
//                 //                LocalJsonTextWriter.WritePropertyName('account_type');
//                 //                LocalJsonTextWriter.WriteValue(Format(ProductFactory.Category));
//                 //                LocalJsonTextWriter.WritePropertyName('account_status');
//                 //                LocalJsonTextWriter.WriteValue(Format(SavingsAcc.Status));
//                 //                LocalJsonTextWriter.WritePropertyName('account_balance');
//                 //                LocalJsonTextWriter.WriteValue(Format(SavingsAcc."Balance (LCY)"));
//                 //                LocalJsonTextWriter.WritePropertyName('available_balance');
//                 //                LocalJsonTextWriter.WriteValue(Format(BookBalance));
//                 //                LocalJsonTextWriter.WritePropertyName('credits');
//                 //                LocalJsonTextWriter.WriteValue(Format(SavingsAcc."Credit Amount (LCY)"));
//                 //                LocalJsonTextWriter.WritePropertyName('debits');
//                 //                LocalJsonTextWriter.WriteValue(Format(SavingsAcc."Debit Amount (LCY)"));
//                 //UNTIL SavingsAcc.NEXT=0;
//                 ResponseMessage := 'Account Details Fetched Successfully';
//             end;
//         end;



//         //        LocalJsonTextWriter.WriteEndObject;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetAccountStatement("Action": Text; Password: Text; Username: Text; FromDate: Text; ToDate: Text; PageNo: Integer; RecordsCount: Integer; AccountNo: Code[30]) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Loan Charges";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         TransactionType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Penalty Charged","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Insurance Contribution",Prepayment,"Withdrawable Deposits","Xmas Contribution","Penalty Paid","Dev Shares","Co-op Shares","School Fee","Idd Fitr";
//         MemLedge: Record "Interest Due Period";
//         CreditAmount: Decimal;
//         Balance: Decimal;
//         DebitAmount: Decimal;
//         "Count": Integer;
//         TotalFoundRecords: Integer;
//         FirstRow: Integer;
//         LastRow: Integer;
//         FromDateD: Date;
//         ToDateD: Date;
//         RunBal: Decimal;
//         FirstEntryNo: Integer;
//         FileName: Text;
//         FileManagement: Codeunit "File Management";
//         // TempBlob: Record TempBlob;
//         Base64PDF: Text;
//         AccountCheck: Boolean;
//         AcctNo: Code[30];
//         SavingsLedgerEntry: Record "Savings Ledger Entry";
//         RealMemberNo: Code[30];
//         RSavingsAccounts: Record "Savings Accounts";
//     begin
//         FromDateD := CreateDate(FromDate);
//         ToDateD := CreateDate(ToDate);     //continue
//                                            //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//                                            //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//                                            //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Get Account Statement';

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             AcctNo := SkyAuth."Account No.";
//             SavingsAccounts.Get(AccountNo);
//             MemberNo := SavingsAccounts."Member No.";
//             Status := 'SUCCESS';
//         end;

//         RSavingsAccounts.Get(AcctNo);
//         RealMemberNo := SavingsAccounts."Member No.";

//         if Status = 'SUCCESS' then begin
//             if MemberNo = RealMemberNo then begin
//                 ResponseMessage := 'Account Number Found';
//                 Status := 'SUCCESS';
//                 SavingsAccounts.Get(AcctNo);
//                 MemberNo := SavingsAccounts."Member No.";
//             end else begin
//                 ResponseMessage := 'Account Number Does not Match your Details';
//                 Status := 'FAILED';
//             end;
//         end;
//         //ResponseMessage:= 'Account Statement Fetched Successfully';

//         /*-------------------------------------------------------------------------------------*/

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartArray;

//         if Status = 'SUCCESS' then begin

//             Count := 0;
//             FirstRow := ((PageNo - 1) * RecordsCount) + 1;
//             LastRow := PageNo * RecordsCount;

//             SavingsLedgerEntry.Reset;
//             SavingsLedgerEntry.SetCurrentkey("Entry No.");
//             SavingsLedgerEntry.Ascending(false);
//             SavingsLedgerEntry.SetRange("Customer No.", AccountNo);
//             SavingsLedgerEntry.SetRange("Posting Date", FromDateD, ToDateD);
//             if SavingsLedgerEntry.FindFirst then begin
//                 TotalFoundRecords := SavingsLedgerEntry.Count;
//                 SavingsAccounts.Get(AccountNo);
//                 SavingsAccounts.CalcFields("Balance (LCY)", "Authorised Over Draft", "Uncleared Cheques", "ATM Transactions", "Lien Placed");
//                 //      RunBal := (SavingsAccounts."Balance (LCY)"+SavingsAccounts."Authorised Over Draft")-
//                 //                (SavingsAccounts."Uncleared Cheques"+SavingsAccounts."ATM Transactions"+1000+SavingsAccounts."Lien Placed");
//                 repeat
//                     Count += 1;
//                     if (Count >= FirstRow) and (Count <= LastRow) then begin
//                         //RunBal := GetAccountLineBalance('FOSA',VenLedge."Entry No.",TransactionType,AccountNo);
//                         //                        LocalJsonTextWriter.WriteStartObject;
//                         //                        LocalJsonTextWriter.WritePropertyName('entry_no');
//                         //                        LocalJsonTextWriter.WriteValue(Format(SavingsLedgerEntry."Entry No."));
//                         //                        LocalJsonTextWriter.WritePropertyName('document_no');
//                         //                        LocalJsonTextWriter.WriteValue(Format(SavingsLedgerEntry."Document No."));
//                         //                        LocalJsonTextWriter.WritePropertyName('posting_date');
//                         //                        LocalJsonTextWriter.WriteValue(FormatDate(SavingsLedgerEntry."Posting Date"));
//                         //                        LocalJsonTextWriter.WritePropertyName('description');
//                         //                        LocalJsonTextWriter.WriteValue(SavingsLedgerEntry.Description);
//                         //                        LocalJsonTextWriter.WritePropertyName('amount');
//                         //                        LocalJsonTextWriter.WriteValue(Format(Abs(SavingsLedgerEntry."Amount (LCY)")));
//                         //                        LocalJsonTextWriter.WritePropertyName('running_balance');
//                         //                        LocalJsonTextWriter.WriteValue(Format(GetRunningBalance(SavingsLedgerEntry."Entry No.", SavingsLedgerEntry."Customer No.")));
//                         //                        LocalJsonTextWriter.WritePropertyName('entry_type');
//                         if SavingsLedgerEntry.Amount < 0 then
//                             //                            LocalJsonTextWriter.WriteValue('Credit');
//                             if SavingsLedgerEntry.Amount > 0 then
// //                            LocalJsonTextWriter.WriteValue('Debit');
// //                        LocalJsonTextWriter.WriteEndObject;
//                     end;
//                 until (Count = LastRow) or (SavingsLedgerEntry.Next = 0);
//                         ResponseMessage := 'Account Statement Fetched Successfully';
//                     end else begin
//                         ResponseMessage := 'No Account Statement Found Within the Specified Period';
//                         // Status := 'FAILED';
//                     end;
//         end;

//                 //        LocalJsonTextWriter.WriteEndArray;
//                 //        //LocalJsonTextWriter.WritePropertyName('pdf');
//                 //        //LocalJsonTextWriter.WriteValue(Base64PDF);

//                 //        LocalJsonTextWriter.WritePropertyName('current_page');
//                 //        LocalJsonTextWriter.WriteValue(PageNo);
//                 //        LocalJsonTextWriter.WritePropertyName('count');
//                 //        LocalJsonTextWriter.WriteValue(RecordsCount);
//                 //        LocalJsonTextWriter.WritePropertyName('total');
//                 //        LocalJsonTextWriter.WriteValue(TotalFoundRecords);
//                 //        LocalJsonTextWriter.WritePropertyName('title');
//                 //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//                 //        LocalJsonTextWriter.WritePropertyName('message');
//                 //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//                 //        LocalJsonTextWriter.WriteEndObject;

//                 //Payload := LocalStringBuilder.ToString;

//                 /*-------------------------------------------------------------------------------------*/
//                 Response := GenerateJSONResponse(Action, Status, Payload, true);

//             end;


//     procedure GetAccountStatementReport("Action": Text; Password: Text; Username: Text; FromDate: Text; ToDate: Text; FileType: Text; AccountNo: Code[30]) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Loan Charges";
//         MemL: Record "Interest Due Period";
//         AccountStat: Record "Detailed Vendor Ledg. Entry";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         TransactionType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Penalty Charged","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Insurance Contribution",Prepayment,"Withdrawable Deposits","Xmas Contribution","Penalty Paid","Dev Shares","Co-op Shares","School Fee","Idd Fitr";
//         MemLedge: Record "Interest Due Period";
//         CreditAmount: Decimal;
//         Balance: Decimal;
//         DebitAmount: Decimal;
//         "Count": Integer;
//         VenLedge: Record "Vendor Ledger Entry";
//         TotalFoundRecords: Integer;
//         FirstRow: Integer;
//         LastRow: Integer;
//         FromDateD: Date;
//         ToDateD: Date;
//         RunBal: Decimal;
//         FirstEntryNo: Integer;
//         FileName: Text;
//         FileManagement: Codeunit "Sky File Management";
//         TempBlob: Record "Sky TempBlob";
//         Base64PDF: Text;
//         SavingsLedgerEntry: Record "Savings Ledger Entry";
//         Testfile: File;
//         varString: Text;
//         varLength: Integer;
//         RealFileName: Text;
//         AcctNo: Code[30];
//         AccountCheck: Boolean;
//         CurrDT: Text;
//         DateS: Text;
//         TimeS: Text;
//         GeneralSetUp: Record "General Set-Up";
//         RealMemberNo: Code[30];
//     begin
//         GeneralSetUp.Get();
//         FromDateD := CreateDate(FromDate);
//         ToDateD := CreateDate(ToDate);     //continue
//                                            //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//                                            //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//                                            //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Get Account Statement';


//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             AcctNo := SkyAuth."Account No.";
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//             SavingsAccounts.Get(AcctNo);
//             RealMemberNo := SavingsAccounts."Member No.";
//         end;

//         if SavingsAccounts.Get(AccountNo) then begin
//             MemberNo := SavingsAccounts."Member No.";
//         end;


//         if Status = 'SUCCESS' then begin
//             if MemberNo = RealMemberNo then begin
//                 ResponseMessage := 'Member Found';
//                 Status := 'SUCCESS';
//             end else begin
//                 ResponseMessage := 'Account Number Does not Match your Details';
//                 Status := 'FAILED';
//             end;
//         end;

//         /*-------------------------------------------------------------------------------------*/
//         CurrDT := DT2TimeStamp(CurrentDatetime);

//         if Status = 'SUCCESS' then begin

//             Count := 0;

//             //  SavingsAccounts.RESET;
//             //  SavingsAccounts.SETCURRENTKEY("No.");
//             //  SavingsAccounts.ASCENDING(FALSE);
//             //   SavingsAccounts.SETRANGE(AccountNo,AcctNo);
//             //   SavingsAccounts.SETRANGE(from);
//             SavingsLedgerEntry.Reset;
//             SavingsLedgerEntry.SetCurrentkey("Entry No.");
//             SavingsLedgerEntry.Ascending(false);
//             SavingsLedgerEntry.SetRange("Customer No.", AccountNo);
//             SavingsLedgerEntry.SetRange("Posting Date", FromDateD, ToDateD);
//             if SavingsLedgerEntry.FindFirst then begin
//                 TotalFoundRecords := SavingsLedgerEntry.Count;
//                 if FileType = 'PDF' then begin
//                     FileName := GeneralSetUp."PDF B64 Folder" + '\' + MemberNo + ' ' + Format(SavingsAccounts."Product Name") + ' Statement ' + CurrDT + '.pdf';
//                     Report.SaveAsPdf(52185872, FileName, SavingsLedgerEntry);
//                     RealFileName := MemberNo + ' ' + Format(SavingsAccounts."Product Name") + ' Statement ' + CurrDT + '.pdf';
//                 end else begin
//                     FileName := GeneralSetUp."PDF B64 Folder" + '\' + MemberNo + ' ' + Format(SavingsAccounts."Product Name") + ' Statement ' + CurrDT + '.xlsx';
//                     Report.SaveAsExcel(Report::"Sky Stmt xlsx Report B64 B.", FileName, SavingsLedgerEntry);
//                     RealFileName := MemberNo + ' ' + Format(SavingsAccounts."Product Name") + ' Statement ' + CurrDT + '.xlsx';
//                 end;

//                 FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
//                 Base64PDF := Format(TempBlob.ToBase64String);

//                 Testfile.Open(FileName);
//                 varLength := Testfile.LEN;
//                 Testfile.Close;

//                 ResponseMessage := 'Account Statement Fetched Successfully';
//                 Erase(FileName);
//             end;
//         end;


//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('file');
//         //        LocalJsonTextWriter.WriteValue(Base64PDF);
//         //        LocalJsonTextWriter.WritePropertyName('file_type');
//         //        LocalJsonTextWriter.WriteValue(FileType);
//         //        LocalJsonTextWriter.WritePropertyName('file_name');
//         //        LocalJsonTextWriter.WriteValue(RealFileName);
//         //        LocalJsonTextWriter.WritePropertyName('file_size');
//         //        LocalJsonTextWriter.WriteValue(varLength);
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('count');
//         //        LocalJsonTextWriter.WriteValue(TotalFoundRecords);
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetLoanType("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Product Factory";
//         SkyAuth: Record "Sky USSD Auth";
//         Staff: Boolean;
//         Members: Record Members;
//         Loans: Record Loans;
//         ViewOnlineLoans: Boolean;
//         ViewOnlineBosaLoans: Boolean;
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Get Loan Type';
//         ResponseMessage := 'Loan Types Fetched Successfully';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         ViewOnlineLoans := true;
//         ViewOnlineBosaLoans := true;
//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             if SavingsAccounts.Get(SkyAuth."Account No.") then begin
//                 Members.Get(SavingsAccounts."Member No.");// Vendor."BOSA Account No");
//                 if (Members."Employer Code" = '9901') or (Members."Employer Code" = '9902') then
//                     ViewOnlineLoans := false;
//                 if (Members."Employer Code" = 'O5') or (Members."Employer Code" = '99') then
//                     ViewOnlineBosaLoans := false;
//             end;
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;


//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartArray;

//         if Status = 'SUCCESS' then begin
//             Product.Reset;
//             Product.SetRange("Product Class Type", Product."product class type"::Loan);
//             Product.SetRange("Portal Viewable", true);
//             if not ViewOnlineLoans then
//                 Product.SetRange(AvailableOnMobile, false);
//             if not ViewOnlineBosaLoans then
//                 Product.SetFilter(Category, '<>%1', Product.Category::"BOSA Loan");
//             if Product.FindFirst then begin
//                 repeat
//                 //                    LocalJsonTextWriter.WriteStartObject;
//                 //                    LocalJsonTextWriter.WritePropertyName('loan_code');
//                 //                    LocalJsonTextWriter.WriteValue(Product."Product ID");
//                 //                    LocalJsonTextWriter.WritePropertyName('product_name');
//                 //                    LocalJsonTextWriter.WriteValue(Product."Product Description");
//                 //                    LocalJsonTextWriter.WritePropertyName('maximum_guarantors');
//                 //                    LocalJsonTextWriter.WriteValue(Format(Product."Maximum Guarantors"));
//                 //                    LocalJsonTextWriter.WritePropertyName('source');
//                 //                    LocalJsonTextWriter.WriteValue(CopyStr(Format(Product.Category), 1, 4));

//                 //                    LocalJsonTextWriter.WritePropertyName('maximum_amount');
//                 //                    LocalJsonTextWriter.WriteValue(Format(Product."Maximum Loan Amount"));
//                 //                    LocalJsonTextWriter.WritePropertyName('minimum_amount');
//                 //                    LocalJsonTextWriter.WriteValue(Format(Product."Minimum Loan Amount"));
//                 //                    LocalJsonTextWriter.WriteEndObject;
//                 until Product.Next = 0;
//                 ResponseMessage := 'Loan Types Fetched Successfully';
//             end;
//         end;

//         //        LocalJsonTextWriter.WriteEndArray;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetLoanList("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         LoanList: Record Loans;
//         Amount: Decimal;
//         SkyAuth: Record "Sky USSD Auth";
//         MemberNo: Code[30];
//         Product: Record "Product Factory";
//         OB: Decimal;
//         OI: Decimal;
//         AccountNo: Code[30];
//         Members: Record Members;
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         //Phone := '+'+Phone;
//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Get Loan List';
//         ResponseMessage := 'Loans List Fetched Successfully';
//         /*-------------------------------------------------------------------------------------*/


//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             AccountNo := SkyAuth."Account No.";
//             Status := 'SUCCESS';
//         end;

//         SavingsAccounts.Get(AccountNo);

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartArray;

//         if Status = 'SUCCESS' then begin
//             LoanList.Reset;
//             LoanList.SetCurrentkey("Disbursement Date");
//             LoanList.Ascending(false);
//             LoanList.SetRange("Member No.", SavingsAccounts."Member No.");
//             LoanList.SetFilter(LoanList."Outstanding Balance", '>0');
//             if LoanList.FindFirst then begin
//                 repeat
//                     Product.Get(LoanList."Loan Product Type");
//                     LoanList.CalcFields("Outstanding Balance", "Outstanding Interest");
//                     OB := LoanList."Outstanding Balance";
//                     OI := LoanList."Outstanding Interest";
//                     if OI < 0 then OI := 0;
//                 //                    LocalJsonTextWriter.WriteStartObject;


//                 //                    LocalJsonTextWriter.WritePropertyName('loan_no');
//                 //                    LocalJsonTextWriter.WriteValue(LoanList."Loan No.");
//                 //                    LocalJsonTextWriter.WritePropertyName('loan_type');
//                 //                    LocalJsonTextWriter.WriteValue(Product."Product Description");
//                 //                    LocalJsonTextWriter.WritePropertyName('loan_source');
//                 //                    LocalJsonTextWriter.WriteValue(CopyStr(Format(Product.Category), 1, 4));
//                 //                    LocalJsonTextWriter.WritePropertyName('total_outstanding');
//                 //                    LocalJsonTextWriter.WriteValue(Format(OB + OI));
//                 //                    LocalJsonTextWriter.WritePropertyName('installments');
//                 //                    LocalJsonTextWriter.WriteValue(Format(LoanList.Installments));
//                 //                    LocalJsonTextWriter.WritePropertyName('loan_status');
//                 //                    LocalJsonTextWriter.WriteValue(Format(LoanList.Status));
//                 //                    LocalJsonTextWriter.WritePropertyName('repayment_amount');
//                 //                    LocalJsonTextWriter.WriteValue(Format(LoanList.Repayment));
//                 //                    LocalJsonTextWriter.WritePropertyName('currency');
//                 //                    LocalJsonTextWriter.WriteValue('KES');
//                 //                    LocalJsonTextWriter.WritePropertyName('loan_principal');
//                 //                    LocalJsonTextWriter.WriteValue(Format(LoanList."Approved Amount"));
//                 //                    LocalJsonTextWriter.WritePropertyName('next_repayment_date');
//                 //                    LocalJsonTextWriter.WriteValue(GetNextRepaymentDate(LoanList."Loan No."));
//                 //                    LocalJsonTextWriter.WritePropertyName('expected_date_of_completion');
//                 //                    LocalJsonTextWriter.WriteValue(GetCompletionDate(LoanList."Loan No."));
//                 //                    LocalJsonTextWriter.WritePropertyName('recovery_mode');
//                 //                    LocalJsonTextWriter.WriteValue(Format(LoanList."Recovery Mode"));

//                 //                    LocalJsonTextWriter.WriteEndObject;
//                 until LoanList.Next = 0;
//                 ResponseMessage := 'Loans List Fetched Successfully';
//             end;
//         end;

//         //        LocalJsonTextWriter.WriteEndArray;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetLoanDetails(Password: Text; Username: Text; LoanNo: Code[30]) Response: Text
//     var
//         //        LocalJsonTextWriter: Code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: Code[100];//dotnet StringBuilder;
//         LocalStringWriter: Code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: Code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         LoanDetails: Record Loans;
//         SkyAuth: Record "Sky USSD Auth";
//         Product: Record "Product Factory";
//         OI: Decimal;
//         MemberNo: Code[30];
//         Loans: Record Loans;
//         AcctNo: Code[30];
//         "Outstanding Balance": Integer;
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Get Loan Details';
//         ResponseMessage := 'Loan Details Fetched Successfully';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             AcctNo := SkyAuth."Account No.";
//             Status := 'SUCCESS';
//             ResponseMessage := 'Member Found';
//         end;

//         if SavingsAccounts.Get(AcctNo) then begin
//             MemberNo := SavingsAccounts."Member No.";
//         end;


//         if Status = 'SUCCESS' then begin
//             if Loans.Get(LoanNo) then begin
//                 if Loans."Member No." <> MemberNo then begin
//                     ResponseMessage := 'Loan Number does not match your details';
//                     Status := 'FAILED';
//                 end;
//             end else begin
//                 ResponseMessage := 'Invalid Loan Number';
//                 Status := 'SUCCESS';
//             end;
//         end;


//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         if Status = 'SUCCESS' then begin

//             if LoanDetails.Get(LoanNo) then begin
//                 LoanDetails.CalcFields(LoanDetails."Outstanding Balance", LoanDetails."Outstanding Interest");
//                 OI := LoanDetails."Outstanding Interest";
//                 if OI < 0 then OI := 0;
//                 Product.Get(LoanDetails."Loan Product Type");

//                 //                LocalJsonTextWriter.WritePropertyName('loan_no');
//                 //                LocalJsonTextWriter.WriteValue(LoanDetails."Loan No.");
//                 //                LocalJsonTextWriter.WritePropertyName('product_type');
//                 //                LocalJsonTextWriter.WriteValue(Product."Product Description");
//                 //                LocalJsonTextWriter.WritePropertyName('product_source');
//                 //                LocalJsonTextWriter.WriteValue(CopyStr(Format(Product.Category), 1, 4));
//                 //                LocalJsonTextWriter.WritePropertyName('application_date');
//                 //                LocalJsonTextWriter.WriteValue(FormatDate(LoanDetails."Application Date"));
//                 //                LocalJsonTextWriter.WritePropertyName('posting_date');
//                 //                LocalJsonTextWriter.WriteValue(FormatDate(LoanDetails."Disbursement Date"));
//                 //                LocalJsonTextWriter.WritePropertyName('outstanding_balance');
//                 //                LocalJsonTextWriter.WriteValue(Format(LoanDetails."Outstanding Balance" + OI));
//                 //                LocalJsonTextWriter.WritePropertyName('loan_principal');
//                 //                LocalJsonTextWriter.WriteValue(Format(LoanDetails."Approved Amount"));
//                 //                LocalJsonTextWriter.WritePropertyName('outstanding_interest');
//                 //                LocalJsonTextWriter.WriteValue(Format(OI));
//                 //                LocalJsonTextWriter.WritePropertyName('loan_installments');
//                 //                LocalJsonTextWriter.WriteValue(LoanDetails.Installments);
//                 //                LocalJsonTextWriter.WritePropertyName('loan_category');
//                 //                LocalJsonTextWriter.WriteValue(Format(LoanDetails."Loans Category-SASRA"));
//                 //                LocalJsonTextWriter.WritePropertyName('next_repayment_date');
//                 //                LocalJsonTextWriter.WriteValue(GetNextRepaymentDate(LoanDetails."Loan No."));
//                 //                LocalJsonTextWriter.WritePropertyName('expected_date_of_completion');
//                 //                LocalJsonTextWriter.WriteValue(GetCompletionDate(LoanDetails."Loan No."));
//                 //                LocalJsonTextWriter.WritePropertyName('remaining_number_instalments');
//                 //                LocalJsonTextWriter.WriteValue(Format(GetRemainingInstallments(LoanDetails."Loan No.")));
//                 //                LocalJsonTextWriter.WritePropertyName('monthly_repayment');
//                 //                LocalJsonTextWriter.WriteValue(Format(LoanDetails.Repayment));

//                 ResponseMessage := 'Loan Details Fetched Successfully';
//             end else
//                 ResponseMessage := 'Invalid Loan Number';

//         end;
//         //        LocalJsonTextWriter.WriteEndObject;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse('Get Loan Details', Status, Payload, true);

//     end;


//     procedure GetLoanStatementReport("Action": Text; Password: Text; Username: Text; FileType: Text; LoanNo: Code[30]; FromDate: Text; ToDate: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Loan Charges";
//         CreditLedgerEntry: Record "Credit Ledger Entry";
//         FromDateD: Date;
//         ToDateD: Date;
//         Holder: Integer;
//         SkyAuth: Record "Sky USSD Auth";
//         "Count": Integer;
//         FirstRow: Integer;
//         LastRow: Integer;
//         TotalFoundRecords: Integer;
//         MemberNo: Code[30];
//         Loans: Record Loans;
//         RunBal: Decimal;
//         TransactionType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Penalty Charged","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Insurance Contribution",Prepayment,"Withdrawable Deposits","Xmas Contribution","Penalty Paid","Dev Shares","Co-op Shares","School Fee","Idd Fitr";
//         FileManagement: Codeunit "Sky File Management";
//         TempBlob: Record "Sky TempBlob";
//         FileName: Text;
//         Base64PDF: Text;
//         TestFile: File;
//         RealFileName: Text;
//         varLength: Integer;
//         AcctNo: Code[30];
//         CurrDT: Text;
//         GeneralSetup: Record "General Set-Up";
//     begin
//         GeneralSetup.Get();
//         FromDateD := CreateDate(FromDate);
//         ToDateD := CreateDate(ToDate);

//         Message(Format(FromDate));
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */

//         /*-------------------------------------------------------------------------------------*/

//         ResponseTitle := 'Get Loan Statement';
//         ResponseMessage := 'Loan Statement Fetched Successfully';

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             AcctNo := SkyAuth."Account No.";
//             ResponseMessage := 'Member found';
//             Status := 'SUCCESS';
//         end;

//         if SavingsAccounts.Get(AcctNo) then begin
//             MemberNo := SavingsAccounts."Member No.";
//         end;


//         if Status = 'SUCCESS' then begin
//             if Loans.Get(LoanNo) then begin
//                 if Loans."Member No." <> MemberNo then begin
//                     ResponseMessage := 'Loan Number does not match your details';
//                     Status := 'FAILED';
//                 end;
//             end else begin
//                 ResponseMessage := 'Invalid Loan Number';
//                 Status := 'SUCCESS';
//             end;
//         end;

//         Loans.Get(LoanNo);
//         if Status = 'SUCCESS' then begin
//             Count := 0;

//             CreditLedgerEntry.Reset;
//             CreditLedgerEntry.SetCurrentkey("Entry No.");
//             CreditLedgerEntry.Ascending(false);
//             CreditLedgerEntry.SetRange("Loan No", LoanNo);
//             CreditLedgerEntry.SetRange("Posting Date", FromDateD, ToDateD);
//             CreditLedgerEntry.SetFilter("Transaction Type", '<>%1', CreditLedgerEntry."transaction type"::Bills);
//             if CreditLedgerEntry.FindFirst then begin
//                 TotalFoundRecords := CreditLedgerEntry.Count;
//                 CurrDT := DT2TimeStamp(CurrentDatetime);
//                 if FileType = 'PDF' then begin
//                     FileName := GeneralSetup."PDF B64 Folder" + '\' + MemberNo + ' Loan Statement ' + Loans."Loan Product Type Name" + ' ' + CurrDT + '.pdf';
//                     Report.SaveAsPdf(52185873, FileName, CreditLedgerEntry);
//                     RealFileName := MemberNo + ' Loan Statement ' + Loans."Loan Product Type Name" + ' ' + CurrDT + '.pdf';
//                 end else begin
//                     FileName := GeneralSetup."PDF B64 Folder" + '\' + MemberNo + 'Loan Statement ' + Loans."Loan Product Type Name" + ' ' + CurrDT + '.xlsx';
//                     Report.SaveAsExcel(Report::"Sky Stmt xlsx Loan Report B64.", FileName, CreditLedgerEntry);
//                     RealFileName := MemberNo + 'Loan Statement ' + Loans."Loan Product Type Name" + ' ' + CurrDT + '.xlsx';
//                 end;

//                 FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
//                 Base64PDF := Format(TempBlob.ToBase64String);

//                 TestFile.Open(FileName);
//                 varLength := TestFile.LEN;
//                 TestFile.Close;

//                 ResponseMessage := 'Customer Loan Statement Fetched Successfully';
//                 Erase(FileName);
//             end;
//         end;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('file');
//         //        LocalJsonTextWriter.WriteValue(Base64PDF);
//         //        LocalJsonTextWriter.WritePropertyName('file_type');
//         //        LocalJsonTextWriter.WriteValue(FileType);
//         //        LocalJsonTextWriter.WritePropertyName('file_name');
//         //        LocalJsonTextWriter.WriteValue(RealFileName);
//         //        LocalJsonTextWriter.WritePropertyName('file_size');
//         //        LocalJsonTextWriter.WriteValue(varLength);
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('total');
//         //        LocalJsonTextWriter.WriteValue(TotalFoundRecords);
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetLoanStatement("Action": Text; Password: Text; Username: Text; LoanNo: Code[30]; FromDate: Text; ToDate: Text; PageNo: Integer; RecordsCount: Integer) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Loan Charges";
//         CreditLedgerEntry: Record "Credit Ledger Entry";
//         FromDateD: Date;
//         ToDateD: Date;
//         Holder: Integer;
//         SkyAuth: Record "Sky USSD Auth";
//         "Count": Integer;
//         FirstRow: Integer;
//         LastRow: Integer;
//         TotalFoundRecords: Integer;
//         MemberNo: Code[30];
//         Loans: Record Loans;
//         RunBal: Decimal;
//         TransactionType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Penalty Charged","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Insurance Contribution",Prepayment,"Withdrawable Deposits","Xmas Contribution","Penalty Paid","Dev Shares","Co-op Shares","School Fee","Idd Fitr";
//         AcctNo: Code[30];
//     begin
//         FromDateD := CreateDate(FromDate);
//         ToDateD := CreateDate(ToDate);

//         Message(Format(FromDate));
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             AcctNo := SkyAuth."Account No.";
//             Status := 'SUCCESS';
//             ResponseMessage := 'Member Found';
//         end;

//         if SavingsAccounts.Get(AcctNo) then begin
//             MemberNo := SavingsAccounts."Member No.";
//         end;

//         //
//         // ResponseTitle:= 'Get Loan Statement';
//         // ResponseMessage:= 'Loan Statement Fetched Successfully';


//         if Status = 'SUCCESS' then begin
//             if Loans.Get(LoanNo) then begin
//                 if Loans."Member No." <> MemberNo then begin
//                     ResponseMessage := 'Loan Number does not match your details';
//                     Status := 'FAILED';
//                 end;
//             end else begin
//                 ResponseMessage := 'Invalid Loan Number';
//                 Status := 'SUCCESS';
//             end;
//         end;



//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartArray;

//         if Status = 'SUCCESS' then begin
//             Count := 0;
//             FirstRow := ((PageNo - 1) * RecordsCount) + 1;
//             LastRow := PageNo * RecordsCount;

//             CreditLedgerEntry.Reset;
//             CreditLedgerEntry.SetCurrentkey("Entry No.");
//             CreditLedgerEntry.Ascending(false);
//             CreditLedgerEntry.SetRange("Loan No", LoanNo);
//             CreditLedgerEntry.SetRange("Posting Date", FromDateD, ToDateD);
//             CreditLedgerEntry.SetFilter("Transaction Type", '<>%1', CreditLedgerEntry."transaction type"::Bills);
//             if CreditLedgerEntry.FindFirst then begin
//                 TotalFoundRecords := CreditLedgerEntry.Count;
//                 repeat
//                     Count += 1;
//                     if (Count >= FirstRow) and (Count <= LastRow) then begin

//                         RunBal := GetLoanRunningBal(CreditLedgerEntry."Entry No.", LoanNo);
//                         //                        LocalJsonTextWriter.WriteStartObject;
//                         //                        LocalJsonTextWriter.WritePropertyName('loan_no');
//                         //                        LocalJsonTextWriter.WriteValue(LoanNo);
//                         //                        LocalJsonTextWriter.WritePropertyName('entry_no');
//                         //                        LocalJsonTextWriter.WriteValue(CreditLedgerEntry."Entry No.");
//                         //                        LocalJsonTextWriter.WritePropertyName('document_no');
//                         //                        LocalJsonTextWriter.WriteValue(CreditLedgerEntry."Document No.");
//                         //                        LocalJsonTextWriter.WritePropertyName('description');
//                         //                        LocalJsonTextWriter.WriteValue(Format(CreditLedgerEntry.Description));
//                         //                        LocalJsonTextWriter.WritePropertyName('posting_date');
//                         //                        LocalJsonTextWriter.WriteValue(FormatDate(CreditLedgerEntry."Posting Date"));
//                         //                        LocalJsonTextWriter.WritePropertyName('amount');
//                         //                        LocalJsonTextWriter.WriteValue(Format(Abs(CreditLedgerEntry.Amount)));
//                         //                        LocalJsonTextWriter.WritePropertyName('running_balance');
//                         //                        LocalJsonTextWriter.WriteValue(Format(RunBal));
//                         //                        LocalJsonTextWriter.WritePropertyName('entry_type');
//                         if CreditLedgerEntry.Amount < 0 then
//                             //                            LocalJsonTextWriter.WriteValue('Credit');
//                             if CreditLedgerEntry.Amount > 0 then
// //                            LocalJsonTextWriter.WriteValue('Debit');
// //                        LocalJsonTextWriter.WriteEndObject;
//                     end;
//                 until (Count = LastRow) or (CreditLedgerEntry.Next = 0);
//                         ResponseMessage := 'Customer Loan Statement Fetched Successfully';
//                     end else begin
//                         ResponseMessage := 'No Loan Statement Found Within the Specified Period';
//                         // Status := 'FAILED';
//                     end;
//         end;

//                 //        LocalJsonTextWriter.WriteEndArray;
//                 //        LocalJsonTextWriter.WritePropertyName('current_page');
//                 //        LocalJsonTextWriter.WriteValue(PageNo);
//                 //        LocalJsonTextWriter.WritePropertyName('count');
//                 //        LocalJsonTextWriter.WriteValue(RecordsCount);
//                 //        LocalJsonTextWriter.WritePropertyName('total');
//                 //        LocalJsonTextWriter.WriteValue(TotalFoundRecords);
//                 //        LocalJsonTextWriter.WritePropertyName('title');
//                 //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//                 //        LocalJsonTextWriter.WritePropertyName('message');
//                 //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//                 //        LocalJsonTextWriter.WriteEndObject;

//                 //Payload := LocalStringBuilder.ToString;

//                 /*-------------------------------------------------------------------------------------*/
//                 Response := GenerateJSONResponse(Action, Status, Payload, true);

//             end;

//         end;
//     end


//     procedure GetLoanGuarantors("Action": Text; Password: Text; Username: Text; LoanNo: Code[30]) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Loan Charges";
//         MemL: Record "Interest Due Period";
//         LoanGuarantorsandSecurity: Record "Loan Guarantors and Security";
//         Loans: Record Loans;
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         Ven: Record Vendor;
//         Members: Record Members;
//         AcctNo: Code[30];
//         Customer: Record Customer;
//     begin

//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Loan Guarantors';
//         ResponseMessage := 'Loan Guarantors Fetched Successfully';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             AcctNo := SkyAuth."Account No.";
//             Status := 'SUCCESS';
//         end;

//         if SavingsAccounts.Get(AcctNo) then begin
//             MemberNo := SavingsAccounts."Member No.";
//         end;


//         if Status = 'SUCCESS' then begin
//             if Loans.Get(LoanNo) then begin
//                 if Loans."Member No." <> MemberNo then begin
//                     ResponseMessage := 'Loan Number does not match your details';
//                     Status := 'FAILED';
//                 end;
//             end else begin
//                 ResponseMessage := 'Invalid Loan Number';
//                 Status := 'SUCCESS';
//             end;
//         end;


//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartArray;

//         Loans.Get(LoanNo);
//         if Status = 'SUCCESS' then begin
//             if Loans.Source = Loans.Source::CREDIT then begin
//                 LoanGuarantorsandSecurity.Reset;
//                 LoanGuarantorsandSecurity.SetRange("Loan No", LoanNo);
//                 LoanGuarantorsandSecurity.SetRange(Substituted, false);
//                 if LoanGuarantorsandSecurity.FindFirst then begin
//                     repeat
//                         if SavingsAccounts.Get(LoanGuarantorsandSecurity."Savings Account No./Member No.") then begin
//                             Members.Get(SavingsAccounts."Member No.");
//                             //                            LocalJsonTextWriter.WriteStartObject;
//                             //                            LocalJsonTextWriter.WritePropertyName('member_no');
//                             //                            LocalJsonTextWriter.WriteValue(Members."No.");
//                             //                            LocalJsonTextWriter.WritePropertyName('name');
//                             //                            LocalJsonTextWriter.WriteValue(LoanGuarantorsandSecurity.Name);
//                             //                            LocalJsonTextWriter.WritePropertyName('id_no');
//                             //                            LocalJsonTextWriter.WriteValue(Members."Primary Identification");
//                             //                            LocalJsonTextWriter.WritePropertyName('mobile_no');
//                             //                            LocalJsonTextWriter.WriteValue(Members."Phone No.");
//                             //                            LocalJsonTextWriter.WritePropertyName('loan_no');
//                             //                            LocalJsonTextWriter.WriteValue(LoanGuarantorsandSecurity."Loan No");
//                             //                            LocalJsonTextWriter.WritePropertyName('loan_name');
//                             //                            LocalJsonTextWriter.WriteValue(Loans."Loan Product Type Name");
//                             //                            LocalJsonTextWriter.WritePropertyName('account_no');
//                             //                            LocalJsonTextWriter.WriteValue(LoanGuarantorsandSecurity."Savings Account No./Member No.");
//                             //                            LocalJsonTextWriter.WritePropertyName('amount_guaranteed');
//                             //                            LocalJsonTextWriter.WriteValue(Format(LoanGuarantorsandSecurity."Amount Guaranteed"));
//                             //                            LocalJsonTextWriter.WritePropertyName('employer_name');
//                             if Customer.Get(Members."Employer Code") then
//                                 //                                LocalJsonTextWriter.WriteValue(Format(Customer.Name))
//                                 else
// //                                LocalJsonTextWriter.WriteValue('N/A');
// //                            LocalJsonTextWriter.WriteEndObject;
//                         end;
//                     until LoanGuarantorsandSecurity.Next = 0;
//                             ResponseMessage := 'Loan Guarantors Fetched Succesfully';
//                         end else
//                             ResponseMessage := 'Loan Has No Guarantors';
//             end;
//                 end;

//                 //        LocalJsonTextWriter.WriteEndArray;

//                 //        LocalJsonTextWriter.WritePropertyName('title');
//                 //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//                 //        LocalJsonTextWriter.WritePropertyName('message');
//                 //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//                 //        LocalJsonTextWriter.WriteEndObject;

//                 //Payload := LocalStringBuilder.ToString;

//                 /*-------------------------------------------------------------------------------------*/
//                 Response := GenerateJSONResponse(Action, Status, Payload, true);

//             end;


//     procedure GetLoanGuaranteed("Action": Text; Password: Text; Username: Text[30]) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Loan Charges";
//         MemL: Record "Interest Due Period";
//         LoanG: Record "Loan Guarantors and Security";
//         Loans: Record Loans;
//         LoanGFOSA: Record "Appraisal Salary Details";
//         MemberNo: Code[30];
//         AccountNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         Phone: Text;
//         AcctNo: Code[30];
//         DepositsAccount: Record "Savings Accounts";
//         DepAccNo: Code[30];
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Get Loans Guaranteed';
//         ResponseMessage := 'Loans Guaranteed Fetched Successfully';

//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             AccountNo := SkyAuth."Account No.";
//             Phone := SkyAuth."Mobile No.";
//         end;

//         if SavingsAccounts.Get(AccountNo) then begin
//             MemberNo := SavingsAccounts."Member No.";
//         end;

//         DepositsAccount.Reset;
//         DepositsAccount.SetRange("Product Type", '02');
//         DepositsAccount.SetRange("Member No.", MemberNo);
//         if DepositsAccount.FindFirst then
//             DepAccNo := DepositsAccount."No.";


//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartArray;

//         if Status = 'SUCCESS' then begin
//             LoanG.Reset;
//             LoanG.SetRange("Savings Account No./Member No.", DepAccNo);
//             LoanG.SetRange(Substituted, false);
//             LoanG.SetFilter("Outstanding Balance", '>%1', 0);
//             if LoanG.FindFirst then begin
//                 repeat
//                     LoanG.CalcFields("Outstanding Balance");
//                     Loans.Get(LoanG."Loan No");
//                     Members.Get(Loans."Member No.");
//                 //                    LocalJsonTextWriter.WriteStartObject;
//                 //                    LocalJsonTextWriter.WritePropertyName('member_no');
//                 //                    LocalJsonTextWriter.WriteValue(Loans."Member No.");
//                 //                    LocalJsonTextWriter.WritePropertyName('name');
//                 //                    LocalJsonTextWriter.WriteValue(Loans."Member Name");
//                 //                    LocalJsonTextWriter.WritePropertyName('id_no');
//                 //                    LocalJsonTextWriter.WriteValue(Members."Primary Identification");
//                 //                    LocalJsonTextWriter.WritePropertyName('mobile_no');
//                 //                    LocalJsonTextWriter.WriteValue(Members."Phone No.");
//                 //                    LocalJsonTextWriter.WritePropertyName('loan_no');
//                 //                    LocalJsonTextWriter.WriteValue(LoanG."Loan No");
//                 //                    LocalJsonTextWriter.WritePropertyName('loan_name');
//                 //                    LocalJsonTextWriter.WriteValue(Loans."Loan Product Type Name");
//                 //                    LocalJsonTextWriter.WritePropertyName('account_no');
//                 //                    LocalJsonTextWriter.WriteValue(Loans."Disbursement Account No");
//                 //                    LocalJsonTextWriter.WritePropertyName('amount_guaranteed');
//                 //                    LocalJsonTextWriter.WriteValue(Format(LoanG."Amount Guaranteed"));
//                 //                    LocalJsonTextWriter.WritePropertyName('sasra_categorisation');
//                 //                    LocalJsonTextWriter.WriteValue(Format(Loans."Loans Category-SASRA"));
//                 //                    LocalJsonTextWriter.WritePropertyName('loan_balance');
//                 //                    LocalJsonTextWriter.WriteValue(Format(LoanG."Outstanding Balance"));
//                 //                    LocalJsonTextWriter.WritePropertyName('application_date');
//                 //                    LocalJsonTextWriter.WriteValue(FormatDate(Loans."Application Date"));

//                 //                    LocalJsonTextWriter.WriteEndObject;

//                 until LoanG.Next = 0;
//                 ResponseMessage := 'Loans Guaranteed Fetched Successfully';
//             end else
//                 ResponseMessage := 'You Have Guaranteed No Loan';
//         end;

//         //        LocalJsonTextWriter.WriteEndArray;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure FormatName(MemberNo: Code[30]) MemberName: Text
//     var
//         Members: Record Members;
//         NameWithoutSalutation: Text;
//         Firstname: Text;
//         SecondName: Text;
//         ThirdName: Text;
//     begin
//         //not in use
//         //IF Members.GET(MemberNo) THEN BEGIN
//         //    MemberName := Members."First Name"+' '+Members."Middle Name";

//         //    IF Members."First Name" = '' THEN
//         //      MemberName := Members."Middle Name"+' '+Members."Last Name"

//         //    ELSE IF Members."Middle Name" = '' THEN
//         //      MemberName := Members."First Name"+' '+Members."Last Name"

//         //    ELSE IF Members."Last Name" = '' THEN
//         //      MemberName := Members."First Name"+' '+Members."Middle Name"

//         //    ELSE IF (Members."First Name" = '') AND (Members."Middle Name" = '') THEN
//         //      MemberName := Members."Last Name"

//         //    ELSE IF (Members."First Name" = '') AND (Members."Last Name" = '') THEN
//         //      MemberName := Members."Middle Name"

//         //    ELSE IF (Members."Middle Name" = '') AND (Members."Last Name" = '') THEN
//         //      MemberName := Members."First Name";
//         //END;
//     end;

//     local procedure CreateDate(TextDate: Text) RealDate: Date
//     var
//         Day: Integer;
//         Month: Integer;
//         Year: Integer;
//     begin
//         if TextDate = '' then exit(0D);
//         Evaluate(Day, CopyStr(TextDate, 1, 2));
//         Evaluate(Month, CopyStr(TextDate, 4, 2));
//         Evaluate(Year, CopyStr(TextDate, 7, 4));
//         RealDate := Dmy2date(Day, Month, Year);
//     end;


//     procedure GetLoginAttemptDetails(Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         CurrentTime: DateTime;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SkyAuth: Record "Sky USSD Auth";
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         //        LocalJsonTextWriter.Formatting := JsonFormatting.Indented;

//         //PhoneNumber := '+'+PhoneNumber;

//         /*-------------------------------------------------------------------------------------*/
//         ResponseTitle := 'Login Attempts Details';
//         ResponseMessage := 'SUCCESS';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         Status := 'FAILED';

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         if SkyAuth.FindFirst then begin
//             //            //LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('login_attempts');
//             //            LocalJsonTextWriter.WriteValue(Format(SkyAuth."Login Attempts Count P"));
//             //            LocalJsonTextWriter.WritePropertyName('login_attempts_flag');
//             //            LocalJsonTextWriter.WriteValue(SkyAuth."Login Attempts Tag P");
//             //            LocalJsonTextWriter.WritePropertyName('login_attempts_action');
//             //            LocalJsonTextWriter.WriteValue(Format(SkyAuth."Login Attempts Action P"));
//             //            LocalJsonTextWriter.WritePropertyName('login_attempts_expiry');
//             //            LocalJsonTextWriter.WriteValue(FormatDateTimeReverse(SkyAuth."Login Attempts Action Expiry P"));
//             //            //LocalJsonTextWriter.WriteEndObject;
//             ResponseMessage := 'SUCCESS';
//             Status := 'SUCCESS';
//         end else begin
//             //            LocalJsonTextWriter.WritePropertyName('login_attempts');
//             //            LocalJsonTextWriter.WriteValue(Format(SkyAuth."Login Attempts Count P"));
//             //            LocalJsonTextWriter.WritePropertyName('login_attempts_flag');
//             //            LocalJsonTextWriter.WriteValue(SkyAuth."Login Attempts Tag P");
//             //            LocalJsonTextWriter.WritePropertyName('login_attempts_action');
//             //            LocalJsonTextWriter.WriteValue(Format(SkyAuth."Login Attempts Action P"));
//             //            LocalJsonTextWriter.WritePropertyName('login_attempts_expiry');
//             //            LocalJsonTextWriter.WriteValue(FormatDateTimeReverse(SkyAuth."Login Attempts Action Expiry P"));

//             Status := 'FAILED';
//             ResponseMessage := 'Phone Number Not Found';
//         end;
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;
//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse('Login Attempts Details', Status, Payload, true);

//     end;


//     procedure SetLoginAttemptDetails(Username: Text; LoginAttempts: Integer; LoginAttemptsFlag: Text; LoginAttemptsAction: Text; LoginAttemptsExpiry: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         CurrentTime: DateTime;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SkyAuth: Record "Sky USSD Auth";
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         //        LocalJsonTextWriter.Formatting := JsonFormatting.Indented;

//         //PhoneNumber := '+'+PhoneNumber;

//         /*-------------------------------------------------------------------------------------*/
//         ResponseTitle := 'Set Login Attempts';
//         ResponseMessage := 'SUCCESS';
//         /*-------------------------------------------------------------------------------------*/


//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         Status := 'FAILED';

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         if SkyAuth.FindFirst then begin
//             SkyAuth."Login Attempts Count P" := LoginAttempts;
//             SkyAuth."Login Attempts Tag P" := LoginAttemptsFlag;
//             SkyAuth."Login Attempts Action P" := LoginAttemptsAction;
//             SkyAuth."Login Attempts Action Expiry P" := FormatDateTime(LoginAttemptsExpiry);
//             SkyAuth.Modify;
//             Commit;

//             SkyAuth.Reset;
//             if CopyStr(Username, 1, 4) = '+254' then
//                 SkyAuth.SetRange("Mobile No.", Username)
//             else
//                 SkyAuth.SetRange(SkyAuth.Username, Username);
//             if SkyAuth.FindFirst then begin
//                 //                //LocalJsonTextWriter.WriteStartObject;
//                 //                LocalJsonTextWriter.WritePropertyName('login_attempts');
//                 //                LocalJsonTextWriter.WriteValue(Format(SkyAuth."Login Attempts Count P"));
//                 //                LocalJsonTextWriter.WritePropertyName('login_attempts_flag');
//                 //                LocalJsonTextWriter.WriteValue(SkyAuth."Login Attempts Tag P");
//                 //                LocalJsonTextWriter.WritePropertyName('login_attempts_action');
//                 //                LocalJsonTextWriter.WriteValue(Format(SkyAuth."Login Attempts Action P"));
//                 //                LocalJsonTextWriter.WritePropertyName('login_attempts_expiry');
//                 //                LocalJsonTextWriter.WriteValue(FormatDateTimeReverse(SkyAuth."Login Attempts Action Expiry P"));
//                 //                //LocalJsonTextWriter.WriteEndObject;
//             end;

//             ResponseMessage := 'SUCCESS';
//             Status := 'SUCCESS';
//         end else begin
//             //            LocalJsonTextWriter.WritePropertyName('login_attempts');
//             //            LocalJsonTextWriter.WriteValue(Format(SkyAuth."Login Attempts Count P"));
//             //            LocalJsonTextWriter.WritePropertyName('login_attempts_flag');
//             //            LocalJsonTextWriter.WriteValue(SkyAuth."Login Attempts Tag P");
//             //            LocalJsonTextWriter.WritePropertyName('login_attempts_action');
//             //            LocalJsonTextWriter.WriteValue(Format(SkyAuth."Login Attempts Action P"));
//             //            LocalJsonTextWriter.WritePropertyName('login_attempts_expiry');
//             //            LocalJsonTextWriter.WriteValue(FormatDateTimeReverse(SkyAuth."Login Attempts Action Expiry P"));

//             Status := 'FAILED';
//             ResponseMessage := 'Phone Number Not Found';
//         end;
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;
//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse('Login Attempts Details', Status, Payload, true);

//     end;


//     procedure GetOTPAttemptDetails(Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         CurrentTime: DateTime;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SkyAuth: Record "Sky USSD Auth";
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         //        LocalJsonTextWriter.Formatting := JsonFormatting.Indented;

//         //PhoneNumber := '+'+PhoneNumber;
//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         /*-------------------------------------------------------------------------------------*/
//         ResponseTitle := 'OTP Attempts Details';
//         ResponseMessage := 'SUCCESS';
//         /*-------------------------------------------------------------------------------------*/


//         Status := 'FAILED';

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         if SkyAuth.FindFirst then begin
//             //            //LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('otp_attempts');
//             //            LocalJsonTextWriter.WriteValue(Format(SkyAuth."OTP Attempts Count P"));
//             //            LocalJsonTextWriter.WritePropertyName('otp_attempts_flag');
//             //            LocalJsonTextWriter.WriteValue(SkyAuth."OTP Attempts Tag P");
//             //            LocalJsonTextWriter.WritePropertyName('otp_attempts_action');
//             //            LocalJsonTextWriter.WriteValue(Format(SkyAuth."OTP Attempts Action P"));
//             //            LocalJsonTextWriter.WritePropertyName('otp_attempts_expiry');
//             //            LocalJsonTextWriter.WriteValue(FormatDateTimeReverse(SkyAuth."OTP Attempts Action Expiry P"));
//             //            //LocalJsonTextWriter.WriteEndObject;
//             ResponseMessage := 'SUCCESS';
//             Status := 'SUCCESS';
//         end else begin
//             //            LocalJsonTextWriter.WritePropertyName('otp_attempts');
//             //            LocalJsonTextWriter.WriteValue(Format(SkyAuth."OTP Attempts Count P"));
//             //            LocalJsonTextWriter.WritePropertyName('otp_attempts_flag');
//             //            LocalJsonTextWriter.WriteValue(SkyAuth."OTP Attempts Tag P");
//             //            LocalJsonTextWriter.WritePropertyName('otp_attempts_action');
//             //            LocalJsonTextWriter.WriteValue(Format(SkyAuth."OTP Attempts Action P"));
//             //            LocalJsonTextWriter.WritePropertyName('otp_attempts_expiry');
//             //            LocalJsonTextWriter.WriteValue(FormatDateTimeReverse(SkyAuth."OTP Attempts Action Expiry P"));

//             Status := 'FAILED';
//             ResponseMessage := 'Phone Number Not Found';
//         end;
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;
//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse('OTP Attempts Details', Status, Payload, true);

//     end;


//     procedure SetOTPAttemptDetails(Username: Text; OTPAttempts: Integer; OTPAttemptsFlag: Text; OTPAttemptsAction: Text; OTPAttemptsExpiry: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         CurrentTime: DateTime;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SkyAuth: Record "Sky USSD Auth";
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         //        LocalJsonTextWriter.Formatting := JsonFormatting.Indented;

//         //PhoneNumber := '+'+PhoneNumber;

//         /*-------------------------------------------------------------------------------------*/
//         ResponseTitle := 'Set OTP Attempts';
//         ResponseMessage := 'SUCCESS';
//         /*-------------------------------------------------------------------------------------*/
//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         Status := 'FAILED';

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         if SkyAuth.FindFirst then begin
//             SkyAuth."OTP Attempts Count P" := OTPAttempts;
//             SkyAuth."OTP Attempts Tag P" := OTPAttemptsFlag;
//             SkyAuth."OTP Attempts Action P" := OTPAttemptsAction;
//             SkyAuth."OTP Attempts Action Expiry P" := FormatDateTime(OTPAttemptsExpiry);
//             SkyAuth.Modify;
//             Commit;


//             SkyAuth.Reset;
//             if CopyStr(Username, 1, 4) = '+254' then
//                 SkyAuth.SetRange("Mobile No.", Username)
//             else
//                 SkyAuth.SetRange(SkyAuth.Username, Username);
//             if SkyAuth.FindFirst then begin
//                 //                //LocalJsonTextWriter.WriteStartObject;
//                 //                LocalJsonTextWriter.WritePropertyName('otp_attempts');
//                 //                LocalJsonTextWriter.WriteValue(Format(SkyAuth."OTP Attempts Count P"));
//                 //                LocalJsonTextWriter.WritePropertyName('otp_attempts_flag');
//                 //                LocalJsonTextWriter.WriteValue(SkyAuth."OTP Attempts Tag P");
//                 //                LocalJsonTextWriter.WritePropertyName('otp_attempts_action');
//                 //                LocalJsonTextWriter.WriteValue(Format(SkyAuth."OTP Attempts Action P"));
//                 //                LocalJsonTextWriter.WritePropertyName('otp_attempts_expiry');
//                 //                LocalJsonTextWriter.WriteValue(Format(SkyAuth."OTP Attempts Action Expiry P"));
//                 //                //LocalJsonTextWriter.WriteEndObject;
//             end;

//             ResponseMessage := 'SUCCESS';
//             Status := 'SUCCESS';
//         end else begin
//             //            LocalJsonTextWriter.WritePropertyName('otp_attempts');
//             //            LocalJsonTextWriter.WriteValue(Format(SkyAuth."OTP Attempts Count P"));
//             //            LocalJsonTextWriter.WritePropertyName('otp_attempts_flag');
//             //            LocalJsonTextWriter.WriteValue(SkyAuth."OTP Attempts Tag P");
//             //            LocalJsonTextWriter.WritePropertyName('otp_attempts_action');
//             //            LocalJsonTextWriter.WriteValue(Format(SkyAuth."OTP Attempts Action P"));
//             //            LocalJsonTextWriter.WritePropertyName('otp_attempts_expiry');
//             //            LocalJsonTextWriter.WriteValue(FormatDateTimeReverse(SkyAuth."OTP Attempts Action Expiry P"));

//             Status := 'FAILED';
//             ResponseMessage := 'Phone Number Not Found';
//         end;
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;
//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse('OTP Attempts Details', Status, Payload, true);

//     end;


//     procedure LoanCalculator(LoanProductType: Code[30]) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         InterestAmount: Decimal;
//         IntSetUp: Record "Checkoff Advice Header";
//         Product: Record "Product Factory";
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Loan Calculator';
//         ResponseMessage := 'Loan Product Type Parameters Fetched Successfully';
//         /*-------------------------------------------------------------------------------------*/

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;


//         if Status = 'SUCCESS' then begin
//             if Product.Get(LoanProductType) then begin
//                 //                LocalJsonTextWriter.WritePropertyName('loan_code');
//                 //                LocalJsonTextWriter.WriteValue(Product."Product ID");
//                 //                LocalJsonTextWriter.WritePropertyName('product_name');
//                 //                LocalJsonTextWriter.WriteValue(Product."Product Description");
//                 //                LocalJsonTextWriter.WritePropertyName('repayment_frequency');
//                 //                LocalJsonTextWriter.WriteValue(Format(Product."Repayment Frequency"));
//                 //                LocalJsonTextWriter.WritePropertyName('max_loan_amount');
//                 //                LocalJsonTextWriter.WriteValue(Product."Maximum Loan Amount");
//                 //                LocalJsonTextWriter.WritePropertyName('interest_rate');
//                 //                LocalJsonTextWriter.WriteValue(Product."Interest Rate (Max.)");
//                 //                LocalJsonTextWriter.WritePropertyName('max_installments');
//                 //                LocalJsonTextWriter.WriteValue(Product."Prefferential Default installm");
//                 //                LocalJsonTextWriter.WritePropertyName('min_no_of_guarantors');
//                 //                LocalJsonTextWriter.WriteValue(Format(Product."Minimum Guarantors"));
//                 //                LocalJsonTextWriter.WritePropertyName('max_no_of_guarantors');
//                 //                LocalJsonTextWriter.WriteValue(Format(Product."Maximum Guarantors"));
//                 //                LocalJsonTextWriter.WritePropertyName('share_multiplier');
//                 //                LocalJsonTextWriter.WriteValue(Product."Ordinary Deposits Multiplier");
//                 //                LocalJsonTextWriter.WritePropertyName('recovery_mode');
//                 //                LocalJsonTextWriter.WriteValue(Format(Product."Repay Mode"));
//                 //                LocalJsonTextWriter.WritePropertyName('source');
//                 //                LocalJsonTextWriter.WriteValue(CopyStr(Format(Product.Category), 1, 4));
//                 //                LocalJsonTextWriter.WritePropertyName('interest_calculation_method');
//                 //                LocalJsonTextWriter.WriteValue(Format(Product."Interest Calculation Method"));
//                 ResponseMessage := 'Loan Product Type Parameters Fetched Successfully';
//             end;
//         end;

//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse('Loan Calculator', Status, Payload, true);

//     end;


//     procedure GetMemberOTPChannel(Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SkyAuth: Record "Sky USSD Auth";
//         Channel: Text;
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);



//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         ResponseTitle := 'OTP Channel';
//         ResponseMessage := 'OTP Channel';
//         /*-------------------------------------------------------------------------------------*/

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         if SkyAuth.FindFirst then begin
//             Channel := 'SMS';
//             if SkyAuth."Login Username Type" = SkyAuth."login username type"::"E-Mail" then
//                 Channel := 'EMAIL';
//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('otp_channel');
//             //            LocalJsonTextWriter.WriteValue(Channel);
//             //            LocalJsonTextWriter.WriteEndObject;
//             ResponseMessage := 'OTP Channel Fetched';
//         end else begin
//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('otp_channel');
//             //            LocalJsonTextWriter.WriteValue('FAILED');
//             //            LocalJsonTextWriter.WriteEndObject;

//         end;


//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse('OTP Channel', Status, Payload, true);

//     end;


//     procedure PushSMS(phone: Text; msg: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         Vendor: Record Vendor;
//         Product: Record "Loan Charges";
//         SkyAuth: Record "Sky USSD Auth";
//         SkyMBanking: Codeunit "Sky Mbanking";
//         AccountNo: Code[30];
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         Status := 'FAILED';
//         ResponseTitle := 'SMS Push Failed';
//         ResponseMessage := 'Internal Error';

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         SkyAuth.Reset;
//         SkyAuth.SetRange("Mobile No.", '+' + phone);
//         if SkyAuth.FindFirst then begin
//             AccountNo := SkyAuth."Account No.";
//             SkyMBanking.SendSms(Source::MBANKING, phone, msg, AccountNo, '', true, 200, false);
//             //            LocalJsonTextWriter.WritePropertyName('sms_status');
//             //            LocalJsonTextWriter.WriteValue('TRUE');
//             Status := 'SUCCESS';
//             ResponseTitle := 'SMS Pushed';
//             ResponseMessage := 'SMS Pushed Successfully';
//         end else begin
//             //            LocalJsonTextWriter.WritePropertyName('sms_status');
//             //            LocalJsonTextWriter.WriteValue('FALSE');
//             Status := 'FAILED';
//             ResponseTitle := 'SMS Push Failed';
//             ResponseMessage := 'Member Not Found';
//         end;
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse('Push SMS', Status, Payload, true);

//     end;


//     procedure FormatDateTime(DateTimeString: Text): DateTime
//     var
//         Day: Text;
//         Month: Text;
//         Year: Text;
//         Hour: Text;
//         Minute: Text;
//         Second: Text;
//         RealTime: Time;
//         RealDate: Date;
//         DayI: Integer;
//         MonthI: Integer;
//         YearI: Integer;
//     begin
//         if DateTimeString = '' then exit(0DT);
//         Day := CopyStr(DateTimeString, 9, 2);
//         Evaluate(DayI, Day);
//         Month := CopyStr(DateTimeString, 6, 2);
//         Evaluate(MonthI, Month);
//         Year := CopyStr(DateTimeString, 1, 4);
//         Evaluate(YearI, Year);

//         RealDate := Dmy2date(DayI, MonthI, YearI);

//         Hour := CopyStr(DateTimeString, 12, 2);
//         Minute := CopyStr(DateTimeString, 15, 2);
//         Second := CopyStr(DateTimeString, 18, 2);

//         Evaluate(RealTime, Hour + Minute + Second);
//         exit(CreateDatetime(RealDate, RealTime));
//     end;


//     procedure FormatDate(RealDate: Date) DateText: Text
//     var
//         Day: Integer;
//         Month: Integer;
//         Year: Integer;
//         Time: Integer;
//         FormatedDate: Text;
//         FormatedMonth: Text;
//     begin
//         if RealDate <> 0D then begin
//             Day := Date2dmy(RealDate, 1);
//             Month := Date2dmy(RealDate, 2);
//             Year := Date2dmy(RealDate, 3);
//         end;

//         if Month = 1 then FormatedMonth := 'Jan';
//         if Month = 2 then FormatedMonth := 'Feb';
//         if Month = 3 then FormatedMonth := 'Mar';
//         if Month = 4 then FormatedMonth := 'Apr';
//         if Month = 5 then FormatedMonth := 'May';
//         if Month = 6 then FormatedMonth := 'June';
//         if Month = 7 then FormatedMonth := 'July';
//         if Month = 8 then FormatedMonth := 'Aug';
//         if Month = 9 then FormatedMonth := 'Sept';
//         if Month = 10 then FormatedMonth := 'Oct';
//         if Month = 11 then FormatedMonth := 'Nov';
//         if Month = 12 then FormatedMonth := 'Dec';


//         DateText := Format(Day) + ' ' + FormatedMonth + ' ' + Format(Year);

//         if RealDate = 0D then DateText := '';

//         //EXIT(DateText);
//     end;


//     procedure GetLoanRunningBal(EntryNo: Integer; LoanNo: Code[30]) RunBal: Decimal
//     var
//         CreditLedgerEntry: Record "Credit Ledger Entry";
//         Ven: Record "Vendor Ledger Entry";
//         TotalPaid: Decimal;
//         PrincipleBal: Decimal;
//         Loans: Record EDMS;
//         InterestBal: Decimal;
//     begin
//         CreditLedgerEntry.Reset;
//         CreditLedgerEntry.SetRange("Loan No", LoanNo);
//         CreditLedgerEntry.SetFilter("Entry No.", '<=%1', EntryNo);
//         CreditLedgerEntry.SetFilter("Transaction Type", '=%1|=%2', CreditLedgerEntry."transaction type"::Loan, CreditLedgerEntry."transaction type"::Repayment);
//         if CreditLedgerEntry.FindFirst then begin
//             CreditLedgerEntry.CalcSums(Amount);
//             PrincipleBal := CreditLedgerEntry.Amount;
//         end;

//         CreditLedgerEntry.Reset;
//         CreditLedgerEntry.SetRange("Loan No", LoanNo);
//         CreditLedgerEntry.SetFilter("Entry No.", '<=%1', EntryNo);
//         CreditLedgerEntry.SetFilter("Transaction Type", '=%1|=%2', CreditLedgerEntry."transaction type"::"Interest Due", CreditLedgerEntry."transaction type"::"Interest Paid");
//         if CreditLedgerEntry.FindFirst then begin
//             CreditLedgerEntry.CalcSums(Amount);
//             InterestBal := CreditLedgerEntry.Amount;

//             if InterestBal < 0 then InterestBal := 0;
//         end;

//         RunBal := PrincipleBal + InterestBal;
//     end;

//     local procedure GetBOSAAccountBalances(TransactionType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Penalty Charged","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Insurance Contribution",Prepayment,"Withdrawable Deposits","Xmas Contribution","Penalty Paid","Dev Shares","Co-op Shares","School Fee","Idd Fitr"; AccountNo: Code[30]) RunBal: Decimal
//     var
//         MemL: Record "Interest Due Period";
//         Ven: Record "Vendor Ledger Entry";
//         TotalPaid: Decimal;
//         PrincipleBal: Decimal;
//         Loans: Record EDMS;
//         InterestBal: Decimal;
//     begin
//         // MemL.RESET;
//         // MemL.SETRANGE(MemL."New Fiscal Year",AccountNo);
//         // MemL.SETRANGE(MemL."Transaction Type",TransactionType);
//         // IF MemL.FINDFIRST THEN BEGIN
//         //    REPEAT
//         //      RunBal += MemL."Amount (LCY)";
//         //    UNTIL MemL.NEXT = 0;
//         // END;
//         // RunBal := RunBal*-1;
//     end;

//     local procedure GetNextRepaymentDate(LoanNo: Code[30]) RepayDate: Text
//     var
//         Loans: Record Loans;
//         NextPayDate: Date;
//         Schedule: Record "Ideal Repayment Schedule";
//     begin

//         Loans.Get(LoanNo);

//         Schedule.Reset;
//         Schedule.SetRange("Loan No.", LoanNo);
//         if not Schedule.FindFirst then
//             NextPayDate := Today;


//         Schedule.Reset;
//         Schedule.SetCurrentkey("Repayment Date");
//         Schedule.Ascending(true);
//         Schedule.SetRange("Loan No.", LoanNo);
//         Schedule.SetFilter("Repayment Date", '>=%1', Today);
//         if Schedule.FindFirst then NextPayDate := Schedule."Repayment Date";

//         Schedule.Reset;
//         Schedule.SetCurrentkey("Repayment Date");
//         Schedule.Ascending(true);
//         Schedule.SetRange("Loan No.", LoanNo);
//         if Schedule.FindLast then begin
//             if Schedule."Repayment Date" < Today then begin
//                 NextPayDate := CalcDate(Format(Loans.Installments) + 'M', Loans."Repayment Start Date");
//             end;
//         end;

//         RepayDate := FormatDate(NextPayDate);
//     end;

//     local procedure GetCompletionDate(LoanNo: Code[30]) CompletionDate: Text
//     var
//         Loans: Record Loans;
//         EndDate: Date;
//     begin
//         Loans.Get(LoanNo);
//         if (Loans."Repayment Start Date" <> 0D) and (Loans.Installments <> 0) then begin
//             EndDate := CalcDate(Format(Loans.Installments) + 'M', Loans."Repayment Start Date");
//             CompletionDate := Format(Date2dmy(EndDate, 1)) + '-' + Format(Date2dmy(EndDate, 2)) + '-' + Format(Date2dmy(EndDate, 3));
//         end;
//     end;


//     procedure FormatDateTimeReverse(RealDateTime: DateTime): Text
//     begin
//         if RealDateTime = 0DT then exit('');
//         exit(Format(Date2dmy(Dt2Date(RealDateTime), 3)) + '-' + Format(Date2dmy(Dt2Date(RealDateTime), 2)) + '-' + Format(Date2dmy(Dt2Date(RealDateTime), 1)) + ' ' + Format(Dt2Time(RealDateTime), 8, '<Hours24,2>:<Minutes,2>:<Seconds,2>'));
//     end;

//     local procedure GeneratePin(var CreatedPassword: Text; var HashedPassword: Text)
//     var
//         ValidChar: array[21] of Char;
//     // SHA256Demo: Codeunit "Sky Mbanking";
//     begin
//         CreatedPassword := CreateGuid;
//         CreatedPassword := DelChr(CreatedPassword, '=', '{}-01');
//         CreatedPassword := CopyStr(CreatedPassword, 1, 8);
//         //MESSAGE(RandomDigit) ;
//         HashedPassword := SHA256Demo.CalculateSHA256(CreatedPassword);
//     end;


//     procedure AddMemberToPortal("E-Mail": Text; PhoneNumber: Text; MemberNumber: Code[30]; LoginUsernameType: Option Phone,"E-Mail"; ActivityType: Option Fresh,Refresh)
//     var
//         Vendor: Record Vendor;
//         AccountNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         // SHA256Demo: Codeunit "Sky Mbanking";
//         Password: Text;
//         HashedPassword: Text;
//         Concatenation: Text;
//         msg: Text;
//         Priority: Integer;
//         SkyMbanking: Codeunit "Sky Mbanking";
//         Phone: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         Members: Record "Social Listening Sites App.";
//         Name: Text;
//         // SMTP: Codeunit 400;
//         // SMTPMailSetup: Record "SMTP Mail Setup";
//         PortalSetUp: Record "Portal SetUp";
//     begin

//         PortalSetUp.Get(1);
//         SMTPMailSetup.Get();
//         SavingsAccounts.Reset;
//         SavingsAccounts.SetRange("Member No.", MemberNumber);
//         SavingsAccounts.SetRange("Product Type", '505');
//         if SavingsAccounts.FindFirst then begin
//             AccountNo := SavingsAccounts."No.";
//             Phone := SavingsAccounts."Transactional Mobile No";
//             if Phone = '' then
//                 Phone := PhoneNumber;
//         end;

//         SkyAuth.Reset;
//         SkyAuth.SetRange(SkyAuth."Account No.", AccountNo);
//         if SkyAuth.FindFirst then begin
//             GeneratePin(Password, HashedPassword);
//             Message(Password);
//             Concatenation := HashedPassword + SHA256Demo.CalculateSHA256(MemberNumber);
//             SkyAuth.Password := SHA256Demo.CalculateSHA256(Concatenation);
//             SkyAuth."Login Username Type" := LoginUsernameType;
//             //IF LoginUsernameType = LoginUsernameType::"E-Mail" THEN
//             SkyAuth.Username := "E-Mail";
//             SkyAuth."Password Expiry Time" := CurrentDatetime + 1000 * 60 * 60 * 72;
//             SkyAuth."Initial Password Changed" := false;
//             SkyAuth."KYC Test" := false;

//             SkyAuth."Login Attempts Count P" := 0;
//             SkyAuth."Login Attempts Action Expiry P" := 0DT;
//             SkyAuth."Login Attempts Action P" := '';
//             SkyAuth."Login Attempts Tag P" := '';

//             SkyAuth."OTP Attempts Action Expiry P" := 0DT;
//             SkyAuth."OTP Attempts Action P" := '';
//             SkyAuth."OTP Attempts Count P" := 0;
//             SkyAuth."OTP Attempts Tag P" := '';
//             SkyAuth.Modify;

//             //SENDNOTIFICATION
//             if ActivityType = Activitytype::Fresh then begin
//                 msg := 'Dear member, your initial password for Members Portal is ' + Password + '. Log on to '
//                 + PortalSetUp."Portal Url" + '. Password is valid till ' + FormatDateTimeReverse(SkyAuth."Password Expiry Time");
//             end else begin
//                 msg := 'Dear member, your password request has been processed. Your new Members'' Portal password is ' +
//                     Password + ' DO NOT SHARE.';
//             end;

//             if LoginUsernameType = Loginusernametype::Phone then begin
//                 if SkyAuth."Mobile No." <> '' then Phone := SkyAuth."Mobile No.";
//                 Priority := 201;
//                 SkyMbanking.SendSms(Source::MOBILE_PIN, Phone, msg, AccountNo, '', true, Priority, false);
//             end else begin
//                 SMTP.CreateMessage(SMTPMailSetup."Email Sender Name", SMTPMailSetup."Email Sender Address", SkyAuth.Username, 'HARAMBEE PORTAL', msg, true);
//                 SMTP.Send();
//             end;
//             SkyPortalUsers(SkyAuth.Password, SkyAuth."Account No.", false, Activitytype::Fresh);
//         end else begin
//             GeneratePin(Password, HashedPassword);
//             Message(Password);
//             SkyAuth.Init;
//             SkyAuth."Mobile No." := '+' + PhoneNumber;
//             SkyAuth."Account No." := AccountNo;
//             SkyAuth."Date Created" := Today;
//             SkyAuth."Password Expiry Time" := CurrentDatetime + 1000 * 60 * 60 * 72;
//             SkyAuth.Username := "E-Mail";
//             SkyAuth."Initial Password Changed" := false;
//             Concatenation := HashedPassword + SHA256Demo.CalculateSHA256(MemberNumber);
//             SkyAuth.Password := SHA256Demo.CalculateSHA256(Concatenation);
//             SkyAuth."Login Username Type" := LoginUsernameType;
//             SkyAuth."KYC Test" := false;
//             SkyAuth."Login Attempts Count P" := 0;
//             SkyAuth."Login Attempts Action Expiry P" := 0DT;
//             SkyAuth."Login Attempts Action P" := '';
//             SkyAuth."Login Attempts Tag P" := '';

//             SkyAuth."OTP Attempts Action Expiry P" := 0DT;
//             SkyAuth."OTP Attempts Action P" := '';
//             SkyAuth."OTP Attempts Count P" := 0;
//             SkyAuth."OTP Attempts Tag P" := '';
//             SkyAuth.Insert;

//             if ActivityType = Activitytype::Fresh then begin
//                 msg := 'Dear member, your initial password for Members Portal is ' + Password + '. Log on to '
//                 + PortalSetUp."Portal Url" + '. Password is valid till ' + FormatDateTimeReverse(SkyAuth."Password Expiry Time");
//             end else begin
//                 msg := 'Dear member, your password request has been processed. Your new Members'' Portal password is ' +
//                     Password + ' DO NOT SHARE.';
//             end;

//             if LoginUsernameType = Loginusernametype::Phone then begin
//                 if SkyAuth."Mobile No." <> '' then Phone := SkyAuth."Mobile No.";
//                 Priority := 201;
//                 SkyMbanking.SendSms(Source::MOBILE_PIN, Phone, msg, AccountNo, '', true, Priority, false);
//             end else begin
//                 SMTP.CreateMessage(SMTPMailSetup."Email Sender Name", SMTPMailSetup."Email Sender Address", SkyAuth.Username, 'HARAMBEE PORTAL', msg, true);
//                 SMTP.Send();
//             end;
//             SkyPortalUsers(SkyAuth.Password, SkyAuth."Account No.", false, Activitytype::Fresh);
//         end;
//     end;

//     local procedure GetPassFromUserName(Username: Text; Password: Text): Text
//     var
//         SkyAuth: Record "Sky USSD Auth";
//         RealMemberNumber: Code[30];
//         SavingsAccounts: Record "Savings Accounts";
//         AccountNumber: Code[30];
//         PasswordAndSalt: Text;
//         // SHA256Demo: Codeunit "Sky Mbanking";
//         Concatenation: Text;
//     begin
//         //IF COPYSTR(Username,1,4) = '+254' THEN Username := '+'+Username;
//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange(SkyAuth."Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         if SkyAuth.FindFirst then begin
//             //AccountNumber :=  SkyAuth."Account No.";
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             //Vendor.GET(SkyAuth.Name);
//             RealMemberNumber := SavingsAccounts."Member No.";
//             Concatenation := Password + SHA256Demo.CalculateSHA256(RealMemberNumber);
//             PasswordAndSalt := SHA256Demo.CalculateSHA256(Concatenation);
//         end;
//         exit(PasswordAndSalt);
//     end;


//     procedure OnBoardMembers()
//     var
//         SkyAuth: Record "Sky USSD Auth";
//         SavingsAccounts: Record "Savings Accounts";
//         Members: Record Members;
//         PortalSetUp: Record "Portal SetUp";
//         msg: Text;
//         SkyMbanking: Codeunit "Sky Mbanking";
//         Priority: Integer;
//         ActivityType: Option Fresh,Refresh;
//     begin
//         msg := 'Dear member, in order to serve you better, we have unveiled a new Members'' Portal. Thank you for your support.';
//         PortalSetUp.Get(1);
//         Priority := 201;
//         SkyAuth.Reset;
//         if SkyAuth.FindFirst then begin
//             repeat
//                 SavingsAccounts.Get(SkyAuth."Account No.");
//                 Members.Reset;
//                 Members.SetRange("No.", SavingsAccounts."Member No.");
//                 Members.SetRange(Status, Members.Status::Active);
//                 if Members.FindFirst then begin
//                     if PortalSetUp."Member Type" = PortalSetUp."member type"::Staff then begin
//                         if Members."Employer Code" = '00' then begin
//                             if PortalSetUp."SMS Type" = PortalSetUp."sms type"::Informational then begin
//                                 SkyMbanking.SendSms(Source::NEW_ACCOUNT, SkyAuth."Mobile No.", msg, SkyAuth."Account No.", '', true, Priority, false);
//                             end else begin
//                                 if CopyStr(SkyAuth."Mobile No.", 1, 4) = '+254' then begin
//                                     AddMemberToPortal('', SkyAuth."Mobile No.", SavingsAccounts."Member No.", SkyAuth."login username type"::Phone, Activitytype::Fresh);
//                                 end;
//                             end;
//                         end;
//                     end else
//                         if PortalSetUp."Member Type" = PortalSetUp."member type"::"Non-Staff" then begin
//                             if Members."Employer Code" <> '00' then begin
//                                 if PortalSetUp."SMS Type" = PortalSetUp."sms type"::Informational then begin
//                                     SkyMbanking.SendSms(Source::NEW_ACCOUNT, SkyAuth."Mobile No.", msg, SkyAuth."Account No.", '', true, Priority, false);
//                                 end else begin
//                                     if CopyStr(SkyAuth."Mobile No.", 1, 4) = '+254' then begin
//                                         AddMemberToPortal('', SkyAuth."Mobile No.", SavingsAccounts."Member No.", SkyAuth."login username type"::Phone, Activitytype::Fresh);
//                                     end;
//                                 end;
//                             end;
//                         end else
//                             if PortalSetUp."Member Type" = PortalSetUp."member type"::All then begin
//                                 if PortalSetUp."SMS Type" = PortalSetUp."sms type"::Informational then begin
//                                     SkyMbanking.SendSms(Source::NEW_ACCOUNT, SkyAuth."Mobile No.", msg, SkyAuth."Account No.", '', true, Priority, false);
//                                 end else begin
//                                     if CopyStr(SkyAuth."Mobile No.", 1, 4) = '+254' then begin
//                                         AddMemberToPortal('', SkyAuth."Mobile No.", SavingsAccounts."Member No.", SkyAuth."login username type"::Phone, Activitytype::Fresh);
//                                     end;
//                                 end;
//                             end;
//                 end;
//             until SkyAuth.Next = 0;
//             //MESSAGE('Done');
//         end;
//     end;

//     local procedure DT2TimeStamp(RealDateTime: DateTime): Text
//     begin
//         if RealDateTime = 0DT then exit('');
//         exit(Format(Date2dmy(Dt2Date(RealDateTime), 3)) + Format(Date2dmy(Dt2Date(RealDateTime), 2)) + Format(Date2dmy(Dt2Date(RealDateTime), 1)) + Format(Dt2Time(RealDateTime), 8, '<Hours24,2><Minutes,2><Seconds,2>'));
//     end;


//     procedure GetRunningBalance(EntryNo: Integer; AccountNo: Code[30]): Decimal
//     var
//         SavingsLedgerEntry: Record "Savings Ledger Entry";
//         RunningBalance: Decimal;
//     begin
//         SavingsLedgerEntry.Reset;
//         SavingsLedgerEntry.SetRange("Customer No.", AccountNo);
//         SavingsLedgerEntry.SetFilter("Entry No.", '<=%1', EntryNo);
//         if SavingsLedgerEntry.FindFirst then begin
//             SavingsLedgerEntry.CalcSums(Amount);
//             RunningBalance := SavingsLedgerEntry.Amount;
//             RunningBalance *= -1;
//         end;
//         exit(RunningBalance);
//     end;


//     procedure GetStaffLeaveTypes("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Product Factory";
//         SkyAuth: Record "Sky USSD Auth";
//         Staff: Boolean;
//         Members: Record Members;
//         Loans: Record Loans;
//         ViewOnlineLoans: Boolean;
//         ViewOnlineBosaLoans: Boolean;
//         HRLeaveTypes: Record "HR Leave Types";
//         AccountNo: Code[30];
//         Gender: Text;
//         DaysLeft: Decimal;
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Get Leave Type';
//         ResponseMessage := 'Leave Types Fetched Successfully';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             if Members.Gender = Members.Gender::Female then Gender := 'FEMALE' else Gender := 'MALE';
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartArray;
//         if Status = 'SUCCESS' then begin
//             HRLeaveTypes.Reset;
//             HRLeaveTypes.SetRange(Active, true);
//             if Gender = 'MALE' then
//                 HRLeaveTypes.SetFilter(Code, '<>%1', 'LTY03')
//             else
//                 HRLeaveTypes.SetFilter(Code, '<>%1', 'LTY04');
//             if HRLeaveTypes.FindFirst then begin
//                 repeat
//                     GetLeaveStats(HRLeaveTypes.Code, Members."No.", DaysLeft);
//                 //                    LocalJsonTextWriter.WriteStartObject;
//                 //                    LocalJsonTextWriter.WritePropertyName('code');
//                 //                    LocalJsonTextWriter.WriteValue(HRLeaveTypes.Code);
//                 //                    LocalJsonTextWriter.WritePropertyName('description');
//                 //                    LocalJsonTextWriter.WriteValue(HRLeaveTypes.Description);
//                 //                    LocalJsonTextWriter.WritePropertyName('gender');
//                 //                    LocalJsonTextWriter.WriteValue(Format(HRLeaveTypes.Gender));
//                 //                    LocalJsonTextWriter.WritePropertyName('balance');
//                 //                    LocalJsonTextWriter.WriteValue(Format(DaysLeft));
//                 //                    LocalJsonTextWriter.WriteEndObject;
//                 until HRLeaveTypes.Next = 0;
//             end;
//         end;

//         //        LocalJsonTextWriter.WriteEndArray;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetLeaveStats(LeaveType: Text[50]; MemberNo: Code[30]; var DaysLeft: Decimal)
//     var
//         dAlloc: Decimal;
//         dEarnd: Decimal;
//         dTaken: Decimal;
//         dLeft: Decimal;
//         cReimbsd: Decimal;
//         cPerDay: Decimal;
//         cbf: Decimal;
//         HREmp: Record "HR Employees";
//         Members: Record Members;
//         HRLeaveCal: Record "HR Leave Calendar";
//         HRLeaveLedgerEntries: Record "HR Leave Ledger Entries";
//     begin
//         dAlloc := 0;
//         dEarnd := 0;
//         dTaken := 0;
//         dLeft := 0;
//         cReimbsd := 0;
//         cPerDay := 0;
//         cbf := 0;
//         Members.Get(MemberNo);
//         HREmp.Reset;
//         if HREmp.Get(Members."Payroll/Staff No.") then begin

//             HRLeaveCal.Reset;
//             HRLeaveCal.SetRange(HRLeaveCal."Current Leave Calendar", true);
//             if not HRLeaveCal.Find('-') then Error('Leave Calendar not setup');

//             //Filter by Leave Period from HR Setup
//             HRLeaveLedgerEntries.Reset;
//             HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Staff No.", Members."Payroll/Staff No.");
//             HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Leave Entry Type", HRLeaveLedgerEntries."leave entry type"::Positive, HRLeaveLedgerEntries."leave entry type"::Reimbursement);
//             HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Leave Calendar Code", HRLeaveCal."Calendar Code");
//             HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Leave Type", LeaveType);
//             if HRLeaveLedgerEntries.Find('-') then begin
//                 dAlloc := 0;
//                 repeat
//                     dAlloc := HRLeaveLedgerEntries."No. of days" + dAlloc;
//                 until HRLeaveLedgerEntries.Next = 0;
//             end;


//             HRLeaveLedgerEntries.Reset;
//             HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Staff No.", Members."Payroll/Staff No.");
//             HRLeaveLedgerEntries.SetRange("Leave Entry Type", HRLeaveLedgerEntries."leave entry type"::Negative);//'%1|%2',,HRLeaveLedgerEntries."Leave Entry Type"::Reimbursement
//             HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Leave Calendar Code", HRLeaveCal."Calendar Code");
//             HRLeaveLedgerEntries.SetRange(HRLeaveLedgerEntries."Leave Type", LeaveType);
//             if HRLeaveLedgerEntries.Find('-') then begin
//                 dTaken := 0;
//                 repeat
//                     dTaken := HRLeaveLedgerEntries."No. of days" + dTaken;
//                 until HRLeaveLedgerEntries.Next = 0;
//             end;

//             //Leave Balance
//             dEarnd := dAlloc - dTaken;
//             dLeft := dAlloc; // +  dTaken;

//             //Reimbursed Leave Days
//             cbf := HREmp."Reimbursed Leave Days";
//             cReimbsd := HREmp."Cash - Leave Earned";
//             cPerDay := HREmp."Cash per Leave Day";

//         end;
//         DaysLeft := dLeft;
//     end;


//     procedure GetStaffLeaveRelievers("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Product Factory";
//         SkyAuth: Record "Sky USSD Auth";
//         Staff: Boolean;
//         Members: Record Members;
//         Loans: Record Loans;
//         ViewOnlineLoans: Boolean;
//         ViewOnlineBosaLoans: Boolean;
//         HRLeaveTypes: Record "HR Leave Types";
//         AccountNo: Code[30];
//         Gender: Text;
//         DaysLeft: Decimal;
//         HREmployee: Record "HR Employees";
//         HREmployees: Record "HR Employees";
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Get Leave Releivers';
//         ResponseMessage := 'Leave Relievers Fetched Successfully';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             HREmployee.Get(Members."Payroll/Staff No.");
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartArray;
//         if Status = 'SUCCESS' then begin
//             HREmployees.Reset;
//             HREmployees.SetFilter("No.", '<>%1', HREmployee."No.");
//             HREmployees.SetRange(Status, HREmployees.Status::Active);
//             HREmployees.SetRange("Global Dimension 1 Code", HREmployee."Global Dimension 1 Code");
//             HREmployees.SetRange("Global Dimension 2 Code", HREmployee."Global Dimension 2 Code");
//             if HREmployees.FindFirst then begin
//                 repeat
//                     GetLeaveStats(HRLeaveTypes.Code, Members."No.", DaysLeft);
//                 //                    LocalJsonTextWriter.WriteStartObject;
//                 //                    LocalJsonTextWriter.WritePropertyName('reliever_code');
//                 //                    LocalJsonTextWriter.WriteValue(HREmployees."No.");
//                 //                    LocalJsonTextWriter.WritePropertyName('name');
//                 //                    LocalJsonTextWriter.WriteValue(HREmployees."Full Name");
//                 //                    LocalJsonTextWriter.WritePropertyName('activity_code');
//                 //                    LocalJsonTextWriter.WriteValue(Format(HREmployees."Global Dimension 1 Code"));
//                 //                    LocalJsonTextWriter.WritePropertyName('branch_code');
//                 //                    LocalJsonTextWriter.WriteValue(Format(HREmployees."Global Dimension 2 Code"));
//                 //                    LocalJsonTextWriter.WritePropertyName('company_email');
//                 //                    LocalJsonTextWriter.WriteValue(Format(HREmployees."Company E-Mail"));
//                 //                    LocalJsonTextWriter.WritePropertyName('contract_type');
//                 //                    LocalJsonTextWriter.WriteValue(Format(HREmployees."Contract Type"));
//                 //                    LocalJsonTextWriter.WritePropertyName('grade');
//                 //                    LocalJsonTextWriter.WriteValue(Format(HREmployees.Grade));
//                 //                    LocalJsonTextWriter.WritePropertyName('status');
//                 //                    LocalJsonTextWriter.WriteValue(Format(HREmployees.Status));
//                 //                    LocalJsonTextWriter.WriteEndObject;
//                 until HREmployees.Next = 0;
//                 ResponseMessage := 'Leave Relievers Fetched Successfully';
//             end else begin
//                 ResponseMessage := 'No leave Releavers Found for this Member';
//             end;
//         end;

//         //        LocalJsonTextWriter.WriteEndArray;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetStaffLeaveApplications("Action": Text; Password: Text; Username: Text; FromDate: Text; ToDate: Text; PageNo: Integer; RecordsCount: Integer) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Product Factory";
//         SkyAuth: Record "Sky USSD Auth";
//         Staff: Boolean;
//         Members: Record Members;
//         Loans: Record Loans;
//         ViewOnlineLoans: Boolean;
//         ViewOnlineBosaLoans: Boolean;
//         HRLeaveTypes: Record "HR Leave Types";
//         AccountNo: Code[30];
//         Gender: Text;
//         DaysLeft: Integer;
//         HREmployee: Record "HR Employees";
//         HREmployees: Record "HR Employees";
//         HRLeaveApplication: Record "HR Leave Application";
//         FirstRow: Integer;
//         LastRow: Integer;
//         "Count": Integer;
//         TotalFoundRecords: Integer;
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);


//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Get Leave Applications';
//         ResponseMessage := 'Leave Applications Fetched Successfully';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             HREmployee.Get(Members."Payroll/Staff No.");
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;


//         Count := 0;
//         FirstRow := ((PageNo - 1) * RecordsCount) + 1;
//         LastRow := PageNo * RecordsCount;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartArray;
//         if Status = 'SUCCESS' then begin
//             HRLeaveApplication.Reset;
//             HRLeaveApplication.SetCurrentkey("Application Date");
//             HRLeaveApplication.Ascending(false);
//             HRLeaveApplication.SetRange("Applicant Staff No.", Members."Payroll/Staff No.");
//             HRLeaveApplication.SetRange("Application Date", CreateDate(FromDate), CreateDate(ToDate));
//             if HRLeaveApplication.FindFirst then begin
//                 TotalFoundRecords := HRLeaveApplication.Count;
//                 repeat
//                     Count += 1;
//                     if (Count >= FirstRow) and (Count <= LastRow) then begin
//                         //                        LocalJsonTextWriter.WriteStartObject;
//                         HRLeaveTypes.Get(HRLeaveApplication."Leave Type");

//                         //                        LocalJsonTextWriter.WritePropertyName('leave_application_code');
//                         //                        LocalJsonTextWriter.WriteValue(HRLeaveApplication."Application Code");
//                         //                        LocalJsonTextWriter.WritePropertyName('leave_type_code');
//                         //                        LocalJsonTextWriter.WriteValue(Format(HRLeaveApplication."Leave Type"));
//                         //                        LocalJsonTextWriter.WritePropertyName('leave_type_description');
//                         //                        LocalJsonTextWriter.WriteValue(HRLeaveTypes.Description);
//                         //                        LocalJsonTextWriter.WritePropertyName('applicant_name');
//                         //                        LocalJsonTextWriter.WriteValue(HRLeaveApplication.Names);
//                         //                        LocalJsonTextWriter.WritePropertyName('applicant_staff_no');
//                         //                        LocalJsonTextWriter.WriteValue(HRLeaveApplication."Applicant Staff No.");
//                         //                        LocalJsonTextWriter.WritePropertyName('days_applied');
//                         //                        LocalJsonTextWriter.WriteValue(Format(HRLeaveApplication."Days Applied"));
//                         //                        LocalJsonTextWriter.WritePropertyName('start_date');
//                         //                        LocalJsonTextWriter.WriteValue(FormatDate(HRLeaveApplication."Start Date"));
//                         //                        LocalJsonTextWriter.WritePropertyName('return_date');
//                         //                        LocalJsonTextWriter.WriteValue(FormatDate(HRLeaveApplication."Return Date"));
//                         //                        LocalJsonTextWriter.WritePropertyName('status');
//                         //                        LocalJsonTextWriter.WriteValue(Format(HRLeaveApplication.Status));
//                         //                        LocalJsonTextWriter.WritePropertyName('application_date');
//                         //                        LocalJsonTextWriter.WriteValue(FormatDate(HRLeaveApplication."Application Date"));
//                         //                        LocalJsonTextWriter.WriteEndObject;
//                     end;
//                 until (Count = LastRow) or (HRLeaveApplication.Next = 0);
//                 ResponseMessage := 'Leave Applications Fetched Successfully';
//             end else begin
//                 ResponseMessage := 'No leave Applications Found for this Member';
//             end;
//         end;

//         //        LocalJsonTextWriter.WriteEndArray;

//         //        LocalJsonTextWriter.WritePropertyName('current_page');
//         //        LocalJsonTextWriter.WriteValue(PageNo);
//         //        LocalJsonTextWriter.WritePropertyName('count');
//         //        LocalJsonTextWriter.WriteValue(RecordsCount);
//         //        LocalJsonTextWriter.WritePropertyName('total');
//         //        LocalJsonTextWriter.WriteValue(TotalFoundRecords);
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetStaffLeaveEnd("Action": Text; Password: Text; Username: Text; StartDate: Text; NumberOfDays: Decimal) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Product Factory";
//         SkyAuth: Record "Sky USSD Auth";
//         Staff: Boolean;
//         Members: Record Members;
//         AccountNo: Code[30];
//         StartDateD: Date;
//         HRLeaveApplication: Record "HR Leave Application";
//         ReturnDate: Text;
//         EndDate: Text;
//         ReturnDateD: Date;
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         StartDateD := CreateDate(StartDate);
//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Get Staff Leave End';
//         ResponseMessage := 'Leave Staff End Fetched Successfully';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             //HREmployee.GET(Members."Payroll/Staff No.");
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;

//         ReturnDateD := HRLeaveApplication.DetermineLeaveReturnDate(StartDateD, NumberOfDays);
//         ReturnDate := FormatDate(HRLeaveApplication.DetermineLeaveReturnDate(StartDateD, NumberOfDays));
//         EndDate := FormatDate(HRLeaveApplication.DeterminethisLeaveEndDate(ReturnDateD));


//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         if Status = 'SUCCESS' then begin
//             //            LocalJsonTextWriter.WritePropertyName('return_date');
//             //            LocalJsonTextWriter.WriteValue(ReturnDate);
//             //            LocalJsonTextWriter.WritePropertyName('end_date');
//             //            LocalJsonTextWriter.WriteValue(EndDate);
//             ResponseMessage := 'Leave Staff End Fetched Successfully';
//         end;
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//         //  "Return Date" := DetermineLeaveReturnDate("Start Date","Days Applied");
//         //  "End Date" := DeterminethisLeaveEndDate("Return Date");

//     end;


//     procedure StaffApplyLeave("Action": Text; Password: Text; Username: Text; StartDate: Text; LeaveType: Text; DaysTaken: Decimal; RelieverStaffNumber: Code[30]) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Product Factory";
//         SkyAuth: Record "Sky USSD Auth";
//         Staff: Boolean;
//         Members: Record Members;
//         AccountNo: Code[30];
//         StartDateD: Date;
//         HRLeaveApplication: Record "HR Leave Application";
//         ReturnDate: Text;
//         EndDate: Text;
//         ReturnDateD: Date;
//         HRSetup: Record "HR Setup";
//         // NoSeriesMgt: Codeunit NoSeriesManagement;
//         xRexNoSeries: Code[50];
//         NoSeries: Code[50];
//         ApplicationCode: Code[50];
//         HREmp: Record "HR Employees";
//         Calendar: Record Date;
//         empMonths: Integer;
//         UserSetUp: Record "User Setup";
//         CustomApprovalsCodeunit: Codeunit "Custom Approvals Codeunit";
//         VarVariant: Variant;
//         EndDateD: Date;
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         StartDateD := CreateDate(StartDate);
//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Get Staff Leave End';
//         /*-------------------------------------------------------------------------------------*/
//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             //HREmployee.GET(Members."Payroll/Staff No.");
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;
//         if Status = 'SUCCESS' then begin
//             if DaysTaken = 0 then begin
//                 ResponseMessage := 'Days Applied Cannot be 0';
//                 Status := 'FAILED';
//             end;
//         end;
//         if Status = 'SUCCESS' then begin
//             HRLeaveApplication.Reset;
//             HRLeaveApplication.SetRange("Applicant Staff No.", Members."Payroll/Staff No.");
//             HRLeaveApplication.SetFilter(Status, '=%1|=%2', HRLeaveApplication.Status::New, HRLeaveApplication.Status::"Pending Approval");
//             if HRLeaveApplication.FindFirst then begin
//                 ResponseMessage := 'You have another ' + Format(HRLeaveApplication.Status) + ' application.';
//                 Status := 'FAILED';
//             end;
//         end;

//         ReturnDateD := HRLeaveApplication.DetermineLeaveReturnDate(StartDateD, DaysTaken);
//         ReturnDate := FormatDate(HRLeaveApplication.DetermineLeaveReturnDate(StartDateD, DaysTaken));
//         EndDateD := HRLeaveApplication.DeterminethisLeaveEndDate(ReturnDateD);

//         if Status = 'SUCCESS' then begin
//             if Date2dmy(Today, 3) < Date2dmy(EndDateD, 3) then begin
//                 ResponseMessage := 'Your leave application must be within the current year ' + Format(Date2dmy(Today, 3));
//                 Status := 'FAILED';
//             end;
//         end;

//         if Status = 'SUCCESS' then begin
//             HREmp.Reset;
//             HREmp.SetRange("No.", Members."Payroll/Staff No.");
//             if HREmp.FindFirst then begin
//                 UserSetUp.Reset;
//                 UserSetUp.SetRange("User ID", HREmp."User ID");
//                 if not UserSetUp.FindFirst then begin
//                     ResponseMessage := 'You are not setup in the User Setup Table. Kindly Contact ICT';
//                     Status := 'FAILED';
//                 end;
//             end;
//         end;

//         if Status = 'SUCCESS' then begin
//             HREmp.Reset;
//             HREmp.SetRange("No.", Members."Payroll/Staff No.");
//             if HREmp.FindFirst then begin
//                 UserSetUp.Reset;
//                 UserSetUp.SetRange("User ID", HREmp."User ID");
//                 UserSetUp.SetRange("Approver ID", '');
//                 if UserSetUp.FindFirst then begin
//                     ResponseMessage := 'Approver ID Must have a value in the user setup';
//                     Status := 'FAILED';
//                 end;
//             end;
//         end;



//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         if Status = 'SUCCESS' then begin
//             with HRLeaveApplication do begin
//                 Init;
//                 HRSetup.Get;
//                 HRSetup.TestField(HRSetup."Leave Application Nos.");
//                 NoSeriesMgt.InitSeries(HRSetup."Leave Application Nos.", "No series", 0D, "Application Code", "No series");
//                 ApplicationCode := "Application Code";
//                 HREmp.Reset;
//                 HREmp.SetRange("No.", Members."Payroll/Staff No.");
//                 if HREmp.FindFirst then begin
//                     //HREmp.TESTFIELD(HREmp."Date Of Join");
//                     Calendar.Reset;
//                     Calendar.SetRange("Period Type", Calendar."period type"::Month);
//                     Calendar.SetRange("Period Start", HREmp."Date Of Join", Today);
//                     empMonths := Calendar.Count;


//                     //Populate fields
//                     UserSetUp.Get(HREmp."User ID");
//                     "Applicant Staff No." := HREmp."No.";
//                     Names := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
//                     Gender := HREmp.Gender;
//                     "Application Date" := Today;
//                     "Applicant User ID" := UserId;
//                     "Job Tittle" := HREmp."Job Title";
//                     HREmp.CalcFields(HREmp.Picture);
//                     "Global Dimension 1 Code" := HREmp."Global Dimension 1 Code";
//                     "Global Dimension 2 Code" := HREmp."Global Dimension 2 Code";
//                     "Responsibility Center" := UserSetUp."Responsibility Centre";

//                     Picture := HREmp.Picture;
//                     //"Responsibility Center":=HREmp."Responsibility Center";
//                     //Approver details
//                     GetApplicantSupervisor(HREmp."User ID");
//                 end;
//                 HRLeaveApplication."Days Applied" := DaysTaken;
//                 Message(Format(HRLeaveApplication."Days Applied"));
//                 "Start Date" := StartDateD;
//                 Reliever := RelieverStaffNumber;
//                 "Leave Type" := LeaveType;
//                 Insert;

//                 Commit;
//             end;

//             //            LocalJsonTextWriter.WritePropertyName('applied');
//             //            LocalJsonTextWriter.WriteValue('TRUE');
//             ResponseMessage := 'Leave Application Successfully';

//             if HRLeaveApplication.Get(ApplicationCode) then begin
//                 HRLeaveApplication.Validate("Days Applied");
//                 HRLeaveApplication.Validate("Start Date");
//                 HRLeaveApplication.Validate(Reliever);

//                 VarVariant := HRLeaveApplication;
//                 if CustomApprovalsCodeunit.CheckApprovalsWorkflowEnabled(VarVariant) then begin
//                     CustomApprovalsCodeunit.OnSendDocForApproval(VarVariant);
//                 end else begin
//                     ResponseMessage := 'There is no workflow associated with this document';
//                 end;
//             end;
//         end;// ELSE BEGIN
//             //ResponseMessage:= 'Leave Application Failed';
//             //END;

//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//         //  "Return Date" := DetermineLeaveReturnDate("Start Date","Days Applied");
//         //  "End Date" := DeterminethisLeaveEndDate("Return Date");

//     end;


//     procedure GetStaffPayslipPeriods("Action": Text; Password: Text; Username: Text; Year: Integer) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Product Factory";
//         SkyAuth: Record "Sky USSD Auth";
//         Staff: Boolean;
//         Members: Record Members;
//         Loans: Record Loans;
//         ViewOnlineLoans: Boolean;
//         ViewOnlineBosaLoans: Boolean;
//         HRLeaveTypes: Record "HR Leave Types";
//         AccountNo: Code[30];
//         Gender: Text;
//         DaysLeft: Integer;
//         HREmployee: Record "HR Employees";
//         HREmployees: Record "HR Employees";
//         HRLeaveApplication: Record "HR Leave Application";
//         FirstRow: Integer;
//         LastRow: Integer;
//         "Count": Integer;
//         TotalFoundRecords: Integer;
//         PRPayrollPeriods: Record "PR Payroll Periods";
//         DateMemberJoined: Date;
//         FromDateFilter: Date;
//         ToDateFilter: Date;
//         DayMontYear: Text;
//         SalaryHeader: Record "Salary Header";
//         LastSalaryPostingDate: Date;
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);


//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Get Payslip Periods';
//         ResponseMessage := 'Payslip Periods Fetched Successfully';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;



//         if HREmployee.Get(Members."Payroll/Staff No.") then begin
//             //Date member joined
//             DateMemberJoined := HREmployee."Date Of Join";
//             FromDateFilter := CalcDate('-CM', DateMemberJoined);
//         end;

//         if Date2dmy(Today, 1) >= 25 then
//             ToDateFilter := CalcDate('-CM', Today)
//         else
//             ToDateFilter := CalcDate('-1M-CM', Today);

//         SalaryHeader.Reset;
//         SalaryHeader.SetCurrentkey("Posting date");
//         SalaryHeader.Ascending(false);
//         SalaryHeader.SetRange(Posted, true);
//         SalaryHeader.SetRange("Employer Code", '00');
//         if SalaryHeader.FindFirst then LastSalaryPostingDate := SalaryHeader."Posting date";

//         ToDateFilter := LastSalaryPostingDate;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartArray;
//         if Status = 'SUCCESS' then begin
//             PRPayrollPeriods.Reset;
//             PRPayrollPeriods.SetCurrentkey("Date Opened");
//             PRPayrollPeriods.Ascending(false);
//             PRPayrollPeriods.SetRange("Period Year", Year);
//             PRPayrollPeriods.SetRange("Date Opened", FromDateFilter, ToDateFilter); //All dates greater than the day the meber joined
//             if PRPayrollPeriods.FindFirst then begin
//                 TotalFoundRecords := PRPayrollPeriods.Count;
//                 repeat

//                     DayMontYear := Format(Date2dmy(PRPayrollPeriods."Date Opened", 1)) + '/' + Format(+Date2dmy(PRPayrollPeriods."Date Opened", 2)) + '/' + Format(Date2dmy(PRPayrollPeriods."Date Opened", 3));
//                 //                    LocalJsonTextWriter.WriteStartObject;
//                 //                    LocalJsonTextWriter.WritePropertyName('period_name');
//                 //                    LocalJsonTextWriter.WriteValue(PRPayrollPeriods."Period Name");
//                 //                    LocalJsonTextWriter.WritePropertyName('period_year');
//                 //                    LocalJsonTextWriter.WriteValue(Format(PRPayrollPeriods."Period Year"));
//                 //                    LocalJsonTextWriter.WritePropertyName('period_month');
//                 //                    LocalJsonTextWriter.WriteValue(PRPayrollPeriods."Period Month");
//                 //                    LocalJsonTextWriter.WritePropertyName('period_date');
//                 //                    LocalJsonTextWriter.WriteValue(DayMontYear);
//                 //                    LocalJsonTextWriter.WriteEndObject;
//                 until PRPayrollPeriods.Next = 0;
//                 ResponseMessage := 'Payslip Periods Fetched Successfully';
//             end else begin
//                 ResponseMessage := 'No Payslip Periods Found for this Member';
//             end;
//         end;

//         //        LocalJsonTextWriter.WriteEndArray;
//         //        LocalJsonTextWriter.WritePropertyName('total');
//         //        LocalJsonTextWriter.WriteValue(TotalFoundRecords);
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetStaffPayslipReport("Action": Text; Password: Text; Username: Text; Period: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Loan Charges";
//         MemL: Record "Interest Due Period";
//         AccountStat: Record "Detailed Vendor Ledg. Entry";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         TransactionType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Penalty Charged","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Insurance Contribution",Prepayment,"Withdrawable Deposits","Xmas Contribution","Penalty Paid","Dev Shares","Co-op Shares","School Fee","Idd Fitr";
//         MemLedge: Record "Interest Due Period";
//         CreditAmount: Decimal;
//         Balance: Decimal;
//         DebitAmount: Decimal;
//         "Count": Integer;
//         VenLedge: Record "Vendor Ledger Entry";
//         TotalFoundRecords: Integer;
//         FirstRow: Integer;
//         LastRow: Integer;
//         FromDateD: Date;
//         ToDateD: Date;
//         RunBal: Decimal;
//         FirstEntryNo: Integer;
//         FileName: Text;
//         FileManagement: Codeunit "Sky File Management";
//         TempBlob: Record "Sky TempBlob";
//         Base64PDF: Text;
//         Testfile: File;
//         varString: Text;
//         varLength: Integer;
//         RealFileName: Text;
//         AcctNo: Code[30];
//         AccountCheck: Boolean;
//         CurrDT: Text;
//         DateS: Text;
//         TimeS: Text;
//         GeneralSetUp: Record "General Set-Up";
//         RealMemberNo: Code[30];
//         AccountNo: Code[30];
//         PRSalaryCard: Record "PR Salary Card";
//         Members: Record Members;
//     begin
//         GeneralSetUp.Get();
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Get Payslip';


//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             AcctNo := SkyAuth."Account No.";
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//             SavingsAccounts.Get(AcctNo);
//             RealMemberNo := SavingsAccounts."Member No.";
//         end;
//         Members.Get(RealMemberNo);

//         /*-------------------------------------------------------------------------------------*/
//         CurrDT := DT2TimeStamp(CurrentDatetime);

//         if Status = 'SUCCESS' then begin
//             FromDateD := CreateDate(Period);

//             Count := 0;
//             PRSalaryCard.Reset;
//             PRSalaryCard.SetRange("Employee Code", Members."Payroll/Staff No.");
//             PRSalaryCard.SetRange("Period Filter", FromDateD);

//             if PRSalaryCard.FindFirst then begin
//                 TotalFoundRecords := PRSalaryCard.Count;

//                 FileName := GeneralSetUp."PDF B64 Folder" + '\' + RealMemberNo + ' payslip ' + CurrDT + '.pdf';
//                 Report.SaveAsPdf(52185876, FileName, PRSalaryCard);

//                 RealFileName := RealMemberNo + ' payslip ' + CurrDT + '.pdf';

//                 FileManagement.BLOBImportFromServerFile(TempBlob, FileName);

//                 Base64PDF := Format(TempBlob.ToBase64String);

//                 Testfile.Open(FileName);
//                 varLength := Testfile.LEN;
//                 Testfile.Close;

//                 ResponseMessage := 'Payslip Fetched Successfully';
//                 Erase(FileName);
//             end;
//         end;


//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('file');
//         //        LocalJsonTextWriter.WriteValue(Base64PDF);
//         //        LocalJsonTextWriter.WritePropertyName('file_type');
//         //        LocalJsonTextWriter.WriteValue('PDF');
//         //        LocalJsonTextWriter.WritePropertyName('file_name');
//         //        LocalJsonTextWriter.WriteValue(RealFileName);
//         //        LocalJsonTextWriter.WritePropertyName('file_size');
//         //        LocalJsonTextWriter.WriteValue(varLength);
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('count');
//         //        LocalJsonTextWriter.WriteValue(TotalFoundRecords);
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure StaffCancelLeaveApplication("Action": Text; Password: Text; Username: Text; LeaveApplicationCode: Code[30]) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Product Factory";
//         SkyAuth: Record "Sky USSD Auth";
//         Staff: Boolean;
//         Members: Record Members;
//         AccountNo: Code[30];
//         StartDateD: Date;
//         HRLeaveApplication: Record "HR Leave Application";
//         ReturnDate: Text;
//         EndDate: Text;
//         ReturnDateD: Date;
//         HRSetup: Record "HR Setup";
//         // NoSeriesMgt: Codeunit NoSeriesManagement;
//         xRexNoSeries: Code[50];
//         NoSeries: Code[50];
//         ApplicationCode: Code[50];
//         HREmp: Record "HR Employees";
//         Calendar: Record Date;
//         empMonths: Integer;
//         UserSetUp: Record "User Setup";
//         CustomApprovalsCodeunit: Codeunit "Custom Approvals Codeunit";
//         VarVariant: Variant;
//         Cancelled: Text;
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Cance Leave';
//         /*-------------------------------------------------------------------------------------*/
//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             //HREmployee.GET(Members."Payroll/Staff No.");
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;


//         if HRLeaveApplication.Get(LeaveApplicationCode) then begin
//             HRLeaveApplication.Validate("Days Applied");
//             HRLeaveApplication.Validate("Start Date");
//             HRLeaveApplication.Validate(Reliever);
//             HRLeaveApplication.Validate("Leave Type");

//             HRLeaveApplication.Status := HRLeaveApplication.Status::Rejected;
//             HRLeaveApplication.Modify;
//             Cancelled := 'TRUE';
//             ResponseMessage := 'The Leave Application Has Been Cancelled';


//         end else begin
//             Cancelled := 'FALSE';
//             ResponseMessage := 'The Leave Application Has Been Cancellation has Failed';
//         end;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('cancelled');
//         //        LocalJsonTextWriter.WriteValue(Cancelled);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//         //  "Return Date" := DetermineLeaveReturnDate("Start Date","Days Applied");
//         //  "End Date" := DeterminethisLeaveEndDate("Return Date");

//     end;


//     procedure GetStaffP9Report("Action": Text; Password: Text; Username: Text; Period: Integer) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Loan Charges";
//         MemL: Record "Interest Due Period";
//         AccountStat: Record "Detailed Vendor Ledg. Entry";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         TransactionType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Penalty Charged","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Insurance Contribution",Prepayment,"Withdrawable Deposits","Xmas Contribution","Penalty Paid","Dev Shares","Co-op Shares","School Fee","Idd Fitr";
//         MemLedge: Record "Interest Due Period";
//         CreditAmount: Decimal;
//         Balance: Decimal;
//         DebitAmount: Decimal;
//         "Count": Integer;
//         VenLedge: Record "Vendor Ledger Entry";
//         TotalFoundRecords: Integer;
//         FirstRow: Integer;
//         LastRow: Integer;
//         FromDateD: Date;
//         ToDateD: Date;
//         RunBal: Decimal;
//         FirstEntryNo: Integer;
//         FileName: Text;
//         FileManagement: Codeunit "Sky File Management";
//         TempBlob: Record "Sky TempBlob";
//         Base64PDF: Text;
//         Testfile: File;
//         varString: Text;
//         varLength: Integer;
//         RealFileName: Text;
//         AcctNo: Code[30];
//         AccountCheck: Boolean;
//         CurrDT: Text;
//         DateS: Text;
//         TimeS: Text;
//         GeneralSetUp: Record "General Set-Up";
//         RealMemberNo: Code[30];
//         AccountNo: Code[30];
//         PRSalaryCard: Record "PR Salary Card";
//         Members: Record Members;
//         HREmployees: Record "HR Employees";
//     begin
//         GeneralSetUp.Get();
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Get Payslip';


//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             AcctNo := SkyAuth."Account No.";
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//             SavingsAccounts.Get(AcctNo);
//             RealMemberNo := SavingsAccounts."Member No.";
//         end;
//         Members.Get(RealMemberNo);

//         /*-------------------------------------------------------------------------------------*/
//         CurrDT := DT2TimeStamp(CurrentDatetime);

//         if Status = 'SUCCESS' then begin

//             Count := 0;

//             HREmployees.Reset;
//             HREmployees.SetRange("No.", Members."Payroll/Staff No.");
//             if HREmployees.FindFirst then begin
//                 HREmployees.Year := Period;
//                 HREmployees.Modify;
//                 Commit;
//             end;

//             HREmployees.Reset;
//             HREmployees.SetRange("No.", Members."Payroll/Staff No.");
//             HREmployees.SetRange(Year, Period);
//             if PRSalaryCard.FindFirst then begin
//                 TotalFoundRecords := PRSalaryCard.Count;

//                 FileName := GeneralSetUp."PDF B64 Folder" + '\' + RealMemberNo + ' P9 ' + CurrDT + '.pdf';
//                 //REPORT.RUN(52186029,TRUE,FALSE,HREmployees);
//                 Report.SaveAsPdf(52185877, FileName, HREmployees);
//                 RealFileName := RealMemberNo + ' P9 ' + CurrDT + '.pdf';

//                 FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
//                 Base64PDF := Format(TempBlob.ToBase64String);

//                 Testfile.Open(FileName);
//                 varLength := Testfile.LEN;
//                 Testfile.Close;

//                 ResponseMessage := 'P9 Fetched Successfully';
//                 Erase(FileName);
//             end;
//         end;


//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('file');
//         //        LocalJsonTextWriter.WriteValue(Base64PDF);
//         //        LocalJsonTextWriter.WritePropertyName('file_type');
//         //        LocalJsonTextWriter.WriteValue('PDF');
//         //        LocalJsonTextWriter.WritePropertyName('file_name');
//         //        LocalJsonTextWriter.WriteValue(RealFileName);
//         //        LocalJsonTextWriter.WritePropertyName('file_size');
//         //        LocalJsonTextWriter.WriteValue(varLength);
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('count');
//         //        LocalJsonTextWriter.WriteValue(TotalFoundRecords);
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;

//     local procedure SkyPortalUsers(Password: Text; AccountNo: Code[30]; ChangedPassword: Boolean; ActivityType: Option Fresh,Refresh)
//     var
//         Members: Record Members;
//         SavingsAccounts: Record "Savings Accounts";
//         SkyPortalUsers: Record "Sky Portal Users.";
//     begin
//         if SavingsAccounts.Get(AccountNo) then begin
//             if Members.Get(SavingsAccounts."Member No.") then begin
//                 if SkyPortalUsers.Get(Members."Primary Identification") then begin
//                     SkyPortalUsers.Password := Password;
//                     if not SkyPortalUsers."Changed Password" then
//                         SkyPortalUsers."Changed Password" := ChangedPassword;
//                     if ActivityType = Activitytype::Refresh then
//                         SkyPortalUsers."Last Login" := CurrentDatetime;
//                     SkyPortalUsers.Modify;
//                 end else begin
//                     SkyPortalUsers.Init;
//                     SkyPortalUsers."ID Number" := Members."Primary Identification";
//                     SkyPortalUsers.Password := Password;
//                     SkyPortalUsers."Date Created" := CurrentDatetime;
//                     SkyPortalUsers."Changed Password" := ChangedPassword;
//                     SkyPortalUsers."Last Login" := 0DT;
//                     SkyPortalUsers."BOSA No" := Members."No.";
//                     SkyPortalUsers."FOSA No" := SavingsAccounts."No.";
//                     SkyPortalUsers.Insert;
//                 end;
//             end;
//         end;
//     end;

//     local procedure GetMemberPicture(MemberNo: Code[30]) Response: Text
//     var
//         Members: Record Members;
//         ImageData: Record "Image Data";
//         Bytes: code[100];//dotnet Array;
//         Convert: code[100];//dotnet Convert;
//         MemoryStream: code[100];//dotnet MemoryStream;
//         OutStream: OutStream;
//         Picture: BigText;
//         InStream: InStream;
//     begin
//         if Members.Get(MemberNo) then begin
//             if ImageData.Get(Members."No.") then begin
//                 ImageData.CalcFields(Picture);
//                 ImageData.Picture.CreateInstream(InStream);

//                 MemoryStream := MemoryStream.MemoryStream();
//                 CopyStream(MemoryStream, InStream);
//                 Bytes := MemoryStream.GetBuffer();
//                 Picture.AddText(Convert.ToBase64String(Bytes));
//             end;
//         end;
//         Response := Format(Picture);
//     end;


//     procedure GetDividendPayslip("Action": Text; Password: Text; Username: Text; Period: Integer) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Loan Charges";
//         MemL: Record "Interest Due Period";
//         AccountStat: Record "Detailed Vendor Ledg. Entry";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         TransactionType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Penalty Charged","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Insurance Contribution",Prepayment,"Withdrawable Deposits","Xmas Contribution","Penalty Paid","Dev Shares","Co-op Shares","School Fee","Idd Fitr";
//         MemLedge: Record "Interest Due Period";
//         CreditAmount: Decimal;
//         Balance: Decimal;
//         DebitAmount: Decimal;
//         "Count": Integer;
//         VenLedge: Record "Vendor Ledger Entry";
//         TotalFoundRecords: Integer;
//         FirstRow: Integer;
//         LastRow: Integer;
//         FromDateD: Date;
//         ToDateD: Date;
//         RunBal: Decimal;
//         FirstEntryNo: Integer;
//         FileName: Text;
//         FileManagement: Codeunit "Sky File Management";
//         TempBlob: Record "Sky TempBlob";
//         Base64PDF: Text;
//         Testfile: File;
//         varString: Text;
//         varLength: Integer;
//         RealFileName: Text;
//         AcctNo: Code[30];
//         AccountCheck: Boolean;
//         CurrDT: Text;
//         DateS: Text;
//         TimeS: Text;
//         GeneralSetUp: Record "General Set-Up";
//         RealMemberNo: Code[30];
//         AccountNo: Code[30];
//         PRSalaryCard: Record "PR Salary Card";
//         Members: Record Members;
//         DividendProgression: Record "Dividend Progression";
//     begin
//         GeneralSetUp.Get();
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Get Dividend Payslip';


//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             AcctNo := SkyAuth."Account No.";
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//             SavingsAccounts.Get(AcctNo);
//             RealMemberNo := SavingsAccounts."Member No.";
//         end;
//         Members.Get(RealMemberNo);

//         /*-------------------------------------------------------------------------------------*/
//         CurrDT := DT2TimeStamp(CurrentDatetime);

//         if Status = 'SUCCESS' then begin

//             Count := 0;


//             DividendProgression.Reset;
//             DividendProgression.SetRange("Member No", RealMemberNo);
//             DividendProgression.SetRange(Year, Period);
//             if DividendProgression.FindFirst then begin


//                 FileName := GeneralSetUp."PDF B64 Folder" + '\' + RealMemberNo + ' - Dividend Payslip - ' + CurrDT + '.pdf';
//                 //REPORT.RUN(52186029,TRUE,FALSE,HREmployees);
//                 Report.SaveAsPdf(Report::"Dividend Slip B64", FileName, DividendProgression);
//                 RealFileName := RealMemberNo + ' - Dividend Payslip - ' + CurrDT + '.pdf';

//                 FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
//                 Base64PDF := Format(TempBlob.ToBase64String);

//                 Testfile.Open(FileName);
//                 varLength := Testfile.LEN;
//                 Testfile.Close;

//                 ResponseMessage := 'Dividend Payslip Fetched Successfully';
//                 //ERASE(FileName);
//             end;
//         end;


//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('file');
//         //        LocalJsonTextWriter.WriteValue(Base64PDF);
//         //        LocalJsonTextWriter.WritePropertyName('file_type');
//         //        LocalJsonTextWriter.WriteValue('PDF');
//         //        LocalJsonTextWriter.WritePropertyName('file_name');
//         //        LocalJsonTextWriter.WriteValue(RealFileName);
//         //        LocalJsonTextWriter.WritePropertyName('file_size');
//         //        LocalJsonTextWriter.WriteValue(varLength);
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('count');
//         //        LocalJsonTextWriter.WriteValue(TotalFoundRecords);
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetDividendPayslipPeriods("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Product Factory";
//         SkyAuth: Record "Sky USSD Auth";
//         Staff: Boolean;
//         Members: Record Members;
//         Loans: Record Loans;
//         ViewOnlineLoans: Boolean;
//         ViewOnlineBosaLoans: Boolean;
//         HRLeaveTypes: Record "HR Leave Types";
//         AccountNo: Code[30];
//         Gender: Text;
//         DaysLeft: Integer;
//         HREmployee: Record "HR Employees";
//         HREmployees: Record "HR Employees";
//         HRLeaveApplication: Record "HR Leave Application";
//         FirstRow: Integer;
//         LastRow: Integer;
//         "Count": Integer;
//         TotalFoundRecords: Integer;
//         PRPayrollPeriods: Record "PR Payroll Periods";
//         DateMemberJoined: Date;
//         FromDateFilter: Date;
//         ToDateFilter: Date;
//         DayMontYear: Text;
//         DividendProgression: Record "Dividend Progression";
//         MemberNo: Code[30];
//         DividendSlipYearsBuffer: Record "Dividend Slip Years Buffer";
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);


//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Get Payslip Periods';
//         ResponseMessage := 'Payslip Periods Fetched Successfully';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//             MemberNo := SavingsAccounts."Member No.";
//         end;

//         if HREmployee.Get(Members."Payroll/Staff No.") then begin
//             //Date member joined
//             DateMemberJoined := HREmployee."Date Of Join";
//             FromDateFilter := CalcDate('-CM', DateMemberJoined);
//         end;

//         if Date2dmy(Today, 1) >= 25 then
//             ToDateFilter := CalcDate('-CM', Today)
//         else
//             ToDateFilter := CalcDate('-1M-CM', Today);


//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartArray;
//         if Status = 'SUCCESS' then begin
//             DividendProgression.Reset;
//             DividendProgression.SetCurrentkey(Year);
//             DividendProgression.Ascending(false);
//             DividendProgression.SetRange("Member No", MemberNo);
//             if DividendProgression.FindFirst then begin
//                 repeat
//                     if not DividendSlipYearsBuffer.Get(DividendProgression.Year) then begin
//                         DividendSlipYearsBuffer.Init;
//                         DividendSlipYearsBuffer.Year := DividendProgression.Year;
//                         DividendSlipYearsBuffer.Insert;
//                     end;
//                 until DividendProgression.Next = 0;
//             end;
//             DividendSlipYearsBuffer.Reset;
//             if DividendSlipYearsBuffer.FindFirst then begin
//                 TotalFoundRecords := DividendSlipYearsBuffer.Count;
//                 repeat
//                 //DayMontYear  := FORMAT(DATE2DMY(PRPayrollPeriods."Date Opened",1))+'/'+FORMAT(+DATE2DMY(PRPayrollPeriods."Date Opened",2))+'/'+FORMAT(DATE2DMY(PRPayrollPeriods."Date Opened",3));
//                 //                    LocalJsonTextWriter.WriteStartObject;
//                 //                    //                      LocalJsonTextWriter.WritePropertyName('period_name');
//                 //                    //                      LocalJsonTextWriter.WriteValue(PRPayrollPeriods."Period Name");
//                 //                    LocalJsonTextWriter.WritePropertyName('period_year');
//                 //                    LocalJsonTextWriter.WriteValue(Format(DividendSlipYearsBuffer.Year));
//                 //                    //                      LocalJsonTextWriter.WritePropertyName('period_month');
//                 //                    //                      LocalJsonTextWriter.WriteValue(PRPayrollPeriods."Period Month");
//                 //                    //                      LocalJsonTextWriter.WritePropertyName('period_date');
//                 //                    //                      LocalJsonTextWriter.WriteValue(DayMontYear);
//                 //                    LocalJsonTextWriter.WriteEndObject;
//                 until DividendSlipYearsBuffer.Next = 0;
//                 ResponseMessage := 'Payslip Periods Fetched Successfully';
//             end else begin
//                 ResponseMessage := 'No Payslip Periods Found for this Member';
//             end;
//         end;
//         //        LocalJsonTextWriter.WriteEndArray;
//         //        LocalJsonTextWriter.WritePropertyName('total');
//         //        LocalJsonTextWriter.WriteValue(TotalFoundRecords);
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         DividendSlipYearsBuffer.Reset;
//         DividendSlipYearsBuffer.DeleteAll;
//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure CreateNextOfKin("Action": Text; Password: Text; Username: Text; Records: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Loan Charges";
//         MemL: Record "Interest Due Period";
//         AccountStat: Record "Detailed Vendor Ledg. Entry";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         TransactionType: Option " ","Registration Fee",Loan,Repayment,Withdrawal,"Interest Due","Interest Paid","Benevolent Fund","Deposit Contribution","Penalty Charged","Application Fee","Appraisal Fee",Investment,"Unallocated Funds","Shares Capital","Loan Adjustment",Dividend,"Withholding Tax","Administration Fee","Insurance Contribution",Prepayment,"Withdrawable Deposits","Xmas Contribution","Penalty Paid","Dev Shares","Co-op Shares","School Fee","Idd Fitr";
//         MemLedge: Record "Interest Due Period";
//         CreditAmount: Decimal;
//         Balance: Decimal;
//         DebitAmount: Decimal;
//         "Count": Integer;
//         VenLedge: Record "Vendor Ledger Entry";
//         TotalFoundRecords: Integer;
//         FirstRow: Integer;
//         LastRow: Integer;
//         FromDateD: Date;
//         ToDateD: Date;
//         RunBal: Decimal;
//         FirstEntryNo: Integer;
//         FileName: Text;
//         FileManagement: Codeunit "Sky File Management";
//         TempBlob: Record "Sky TempBlob";
//         Base64PDF: Text;
//         Testfile: File;
//         varString: Text;
//         varLength: Integer;
//         RealFileName: Text;
//         AcctNo: Code[30];
//         AccountCheck: Boolean;
//         CurrDT: Text;
//         DateS: Text;
//         TimeS: Text;
//         GeneralSetUp: Record "General Set-Up";
//         RealMemberNo: Code[30];
//         AccountNo: Code[30];
//         PRSalaryCard: Record "PR Salary Card";
//         Members: Record Members;
//         DividendProgression: Record "Dividend Progression";
//         JSONArray: code[100];//dotnet JArray;
//         JObject: code[100];//dotnet JObject;
//         ArrayString: Text;
//         JSONString: Text;
//         MemberChange: Record "Reactivate/Deactivate Header";
//         HeaderNo: Code[30];
//         NextofKINApplication: Record "Next of KIN Application";
//         Allocation: Decimal;
//         BBF: Decimal;
//         dob: Date;
//         SeriesSetup: Record "Credit Nos. Series";
//         // NoSeriesMgt: Codeunit NoSeriesManagement;
//         MemberChangeExists: Record "Reactivate/Deactivate Header";
//         EntryNo: Integer;
//     begin
//         GeneralSetUp.Get();
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Create NOK';


//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             AcctNo := SkyAuth."Account No.";
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//             SavingsAccounts.Get(AcctNo);
//             RealMemberNo := SavingsAccounts."Member No.";
//         end;
//         Members.Get(RealMemberNo);

//         /*-------------------------------------------------------------------------------------*/
//         CurrDT := DT2TimeStamp(CurrentDatetime);


//         MemberChangeExists.Reset;
//         MemberChangeExists.SetRange("Account No.", RealMemberNo);
//         MemberChangeExists.SetFilter(Status, '=%1|=%2', MemberChangeExists.Status::Open, MemberChangeExists.Status::Pending);
//         if MemberChangeExists.FindFirst then begin
//             ResponseMessage := 'Member has a member change application that is underway';
//             Status := 'FAILED';
//         end;

//         if Status = 'SUCCESS' then begin

//             //here do the writing


//             SeriesSetup.Get;
//             SeriesSetup.TestField(SeriesSetup."Member Reactivation Nos.");
//             NoSeriesMgt.InitSeries(SeriesSetup."Member Reactivation Nos.", MemberChange."No. Series", 0D, HeaderNo, MemberChange."No. Series");

//             MemberChange.Init;
//             MemberChange."No." := HeaderNo;
//             MemberChange."Account Type" := MemberChange."account type"::Member;
//             MemberChange."Account No." := RealMemberNo;
//             MemberChange.Validate("Account No.");
//             MemberChange."Application Date" := Today;
//             MemberChange."Application Time" := Time;
//             MemberChange."Created By" := 'HARAMBEESACCO\WEBPORTAL';
//             MemberChange."Member Change Reason" := 'Portal NOK Update';
//             MemberChange.Insert;
//             Commit;

//             ArrayString := Records;

//             if ArrayString <> '' then
//                 JObject := JObject.Parse(Format(ArrayString));
//             ArrayString := JObject.SelectToken('data').ToString;
//             Clear(JObject);
//             JSONArray := JSONArray.Parse(ArrayString);


//             foreach JObject in JSONArray do begin
//                 dob := CreateDate(Format(JObject.GetValue('date_of_birth')));
//                 Evaluate(Allocation, Format(JObject.GetValue('allocation')));

//                 NextofKINApplication.Reset;
//                 if NextofKINApplication.FindLast then
//                     EntryNo := NextofKINApplication."Entry No." + 1;
//                 NextofKINApplication.Init;
//                 NextofKINApplication."Entry No." := EntryNo;
//                 NextofKINApplication."Account No" := HeaderNo;
//                 NextofKINApplication.Name := Format(JObject.GetValue('name'));
//                 NextofKINApplication.Relationship := Format(JObject.GetValue('relationship'));
//                 NextofKINApplication."Date of Birth" := dob;
//                 NextofKINApplication."ID No." := Format(JObject.GetValue('id_number'));
//                 NextofKINApplication."%Allocation" := Allocation;
//                 NextofKINApplication.Address := Format(JObject.GetValue('address'));
//                 NextofKINApplication.Telephone := Format(JObject.GetValue('telephone'));
//                 NextofKINApplication.Email := Format(JObject.GetValue('email'));
//                 NextofKINApplication."Portal Application" := true;
//                 NextofKINApplication."BBF Entitlement" := 0;
//                 NextofKINApplication."%Allocation" := Allocation;
//                 NextofKINApplication.Insert;

//                 ResponseMessage := 'Request received successfully and is being processed!';
//             end;
//         end;


//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('text');
//         //        LocalJsonTextWriter.WriteValue(Base64PDF);
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('count');
//         //        LocalJsonTextWriter.WriteValue(TotalFoundRecords);
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetNextOfKinRelationships("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Product Factory";
//         SkyAuth: Record "Sky USSD Auth";
//         Staff: Boolean;
//         Members: Record Members;
//         RelationshipTypes: Record "Relationship Types";
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Get NOK Relationships';
//         ResponseMessage := 'NOK Relationships Fetched Successfully';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartArray;
//         if Status = 'SUCCESS' then begin
//             RelationshipTypes.Reset;
//             if RelationshipTypes.FindFirst then begin
//                 repeat
//                 //                    LocalJsonTextWriter.WriteStartObject;
//                 //                    LocalJsonTextWriter.WritePropertyName('description');
//                 //                    LocalJsonTextWriter.WriteValue(RelationshipTypes.Description);
//                 //                    LocalJsonTextWriter.WritePropertyName('minimun_age');
//                 //                    LocalJsonTextWriter.WriteValue(Format(RelationshipTypes."Min. Age"));
//                 //                    LocalJsonTextWriter.WritePropertyName('maximum_age');
//                 //                    LocalJsonTextWriter.WriteValue(Format(RelationshipTypes."Max. Age"));
//                 //                    LocalJsonTextWriter.WritePropertyName('maximum_age_allowed');
//                 //                    LocalJsonTextWriter.WriteValue(Format(RelationshipTypes."BBF Max. Allowed"));
//                 //                    LocalJsonTextWriter.WriteEndObject;
//                 until RelationshipTypes.Next = 0;
//                 ResponseMessage := 'NOK Relationships Fetched Successfully';
//             end else begin
//                 ResponseMessage := 'No NOK Relationships Found';
//             end;
//         end;

//         //        LocalJsonTextWriter.WriteEndArray;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetNextOfKinBBFEntitlements("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Product Factory";
//         SkyAuth: Record "Sky USSD Auth";
//         Staff: Boolean;
//         Members: Record Members;
//         BBFEntitlement: Record "BBF Entitlement";
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Get BBF Entitlements';
//         ResponseMessage := 'BBF Entitlements Fetched Successfully';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartArray;
//         if Status = 'SUCCESS' then begin

//             BBFEntitlement.Reset;
//             if BBFEntitlement.FindFirst then begin
//                 repeat
//                 //                    LocalJsonTextWriter.WriteStartObject;
//                 //                    LocalJsonTextWriter.WritePropertyName('code');
//                 //                    LocalJsonTextWriter.WriteValue(BBFEntitlement.Code);
//                 //                    LocalJsonTextWriter.WritePropertyName('description');
//                 //                    LocalJsonTextWriter.WriteValue(BBFEntitlement.Description);
//                 //                    LocalJsonTextWriter.WriteEndObject;
//                 until BBFEntitlement.Next = 0;
//                 ResponseMessage := 'NOK Relationships Fetched Successfully';
//             end else begin
//                 ResponseMessage := 'No NOK Relationships Found';
//             end;
//         end;

//         //        LocalJsonTextWriter.WriteEndArray;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetNextOfKin("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Product Factory";
//         SkyAuth: Record "Sky USSD Auth";
//         Staff: Boolean;
//         Members: Record Members;
//         NextofKIN: Record "Next of KIN";
//         MemberNumber: Code[30];
//         NextofKINApplication: Record "Next of KIN Application";
//         MemberChange: Record "Reactivate/Deactivate Header";
//         HeaderNo: Code[30];
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Get NOK';
//         ResponseMessage := 'NOK Fetched Successfully';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             MemberNumber := Members."No.";
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartArray;
//         if Status = 'SUCCESS' then begin
//             NextofKIN.Reset;
//             NextofKIN.SetRange("Account No", MemberNumber);
//             if NextofKIN.FindFirst then begin
//                 repeat
//                 //                    LocalJsonTextWriter.WriteStartObject;
//                 //                    LocalJsonTextWriter.WritePropertyName('name');
//                 //                    LocalJsonTextWriter.WriteValue(NextofKIN.Name);
//                 //                    LocalJsonTextWriter.WritePropertyName('relationship');
//                 //                    LocalJsonTextWriter.WriteValue(Format(NextofKIN.Relationship));
//                 //                    LocalJsonTextWriter.WritePropertyName('id_number');
//                 //                    LocalJsonTextWriter.WriteValue(Format(NextofKIN."ID No."));
//                 //                    LocalJsonTextWriter.WritePropertyName('address');
//                 //                    LocalJsonTextWriter.WriteValue(Format(NextofKIN.Address));
//                 //                    LocalJsonTextWriter.WritePropertyName('telephone');
//                 //                    LocalJsonTextWriter.WriteValue(NextofKIN.Telephone);
//                 //                    LocalJsonTextWriter.WritePropertyName('email');
//                 //                    LocalJsonTextWriter.WriteValue(Format(NextofKIN.Email));
//                 //                    LocalJsonTextWriter.WritePropertyName('status');
//                 //                    LocalJsonTextWriter.WriteValue('Approved');
//                 //                    LocalJsonTextWriter.WritePropertyName('allocation');
//                 //                    LocalJsonTextWriter.WriteValue(Format(NextofKIN."%Allocation"));
//                 //                    LocalJsonTextWriter.WritePropertyName('type');
//                 //                    LocalJsonTextWriter.WriteValue(Format(NextofKIN.Type));
//                 //                    LocalJsonTextWriter.WriteEndObject;
//                 until NextofKIN.Next = 0;
//             end else begin
//                 ResponseMessage := 'No approved NOK Relationships Found';
//             end;
//             MemberChange.Reset;
//             MemberChange.SetRange("Account No.", MemberNumber);
//             MemberChange.SetFilter(Status, '=%1|=%2', MemberChange.Status::Pending, MemberChange.Status::Open);
//             if MemberChange.FindFirst then HeaderNo := MemberChange."No.";

//             NextofKINApplication.Reset;
//             NextofKINApplication.SetRange("Account No", HeaderNo);
//             NextofKINApplication.SetRange("Portal Application", true);
//             if NextofKINApplication.FindFirst then begin
//                 repeat
//                 //                    LocalJsonTextWriter.WriteStartObject;
//                 //                    LocalJsonTextWriter.WritePropertyName('name');
//                 //                    LocalJsonTextWriter.WriteValue(NextofKINApplication.Name);
//                 //                    LocalJsonTextWriter.WritePropertyName('relationship');
//                 //                    LocalJsonTextWriter.WriteValue(Format(NextofKINApplication.Relationship));
//                 //                    LocalJsonTextWriter.WritePropertyName('id_number');
//                 //                    LocalJsonTextWriter.WriteValue(Format(NextofKINApplication."ID No."));
//                 //                    LocalJsonTextWriter.WritePropertyName('address');
//                 //                    LocalJsonTextWriter.WriteValue(Format(NextofKINApplication.Address));
//                 //                    LocalJsonTextWriter.WritePropertyName('telephone');
//                 //                    LocalJsonTextWriter.WriteValue(NextofKINApplication.Telephone);
//                 //                    LocalJsonTextWriter.WritePropertyName('email');
//                 //                    LocalJsonTextWriter.WriteValue(Format(NextofKINApplication.Email));
//                 //                    LocalJsonTextWriter.WritePropertyName('status');
//                 //                    LocalJsonTextWriter.WriteValue('Pending');
//                 //                    LocalJsonTextWriter.WritePropertyName('allocation');
//                 //                    LocalJsonTextWriter.WriteValue(Format(NextofKINApplication."%Allocation"));
//                 //                    LocalJsonTextWriter.WritePropertyName('type');
//                 //                    LocalJsonTextWriter.WriteValue(Format(NextofKINApplication.Type));
//                 //                    LocalJsonTextWriter.WriteEndObject;
//                 until NextofKINApplication.Next = 0;
//                 ResponseMessage := 'NOK Relationships Fetched Successfully';
//             end;
//         end;

//         //        LocalJsonTextWriter.WriteEndArray;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure DeleteFunction()
//     var
//         ReactivateDeactivateHeader: Record "Reactivate/Deactivate Header";
//     begin
//         // ReactivateDeactivateHeader.RESET;
//         // ReactivateDeactivateHeader.SETRANGE("Account No.",'0123278');
//         // ReactivateDeactivateHeader.SETRANGE(Status,ReactivateDeactivateHeader.Status::Open);
//         // IF ReactivateDeactivateHeader.FINDFIRST THEN
//         // ReactivateDeactivateHeader.DELETEALL;
//     end;


//     procedure ApplySalaryAccount("Action": Text; Password: Text; Username: Text; File: Text; WithEffectFrom: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Product Factory";
//         SkyAuth: Record "Sky USSD Auth";
//         Staff: Boolean;
//         Members: Record Members;
//         MemberNumber: Code[30];
//         SalaryAgreement: Record "Salary Agreement";
//         GeneralSetUp: Record "General Setup";
//         TempBlob: Record "Sky TempBlob";
//         FileManagement: Codeunit "Sky File Management";
//         FileName: Text;
//         EDMS: Record EDMS;
//         url: Text;
//         FilePath: Text;
//         InterestDuePeriod: Record "Interest Due Period";
//         SalesSetup: Record "Sales & Receivables Setup";
//         // NoSeriesMgt: Codeunit NoSeriesManagement;
//         HeaderNo: Code[30];
//     begin

//         GeneralSetUp.Get();
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Salary Account Application';
//         ResponseMessage := 'Salary Account Application Successful';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             MemberNumber := Members."No.";
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;

//         if Status = 'SUCCESS' then begin
//             SalaryAgreement.Reset;
//             SalaryAgreement.SetRange("Member No", MemberNumber);
//             SalaryAgreement.SetFilter(Status, '<>%1', SalaryAgreement.Status::Rejected);
//             if SalaryAgreement.FindFirst then begin
//                 ResponseMessage := 'Dear member, you already have an ongoing application with status: ' + Format(SalaryAgreement.Status);
//                 Status := 'FAILED';
//             end;
//         end;

//         if Status = 'SUCCESS' then begin
//             SalesSetup.Get();
//             SalesSetup.TestField(SalesSetup."Salary Agreement Nos");
//             NoSeriesMgt.InitSeries(SalesSetup."Salary Agreement Nos", SalaryAgreement."No.Series", 0D, HeaderNo, SalaryAgreement."No.Series");

//             //Do the application
//             SalaryAgreement.Init;
//             SalaryAgreement.No := HeaderNo;
//             SalaryAgreement."Member No" := MemberNumber;
//             SalaryAgreement."With Effect From" := CreateDate(WithEffectFrom);
//             SalaryAgreement.Category := SalaryAgreement.Category::"Salary Agreement Form";
//             SalaryAgreement.User := UserId;
//             SalaryAgreement.Validate("Member No");
//             SalaryAgreement.Insert;

//             //Save the file

//             ResponseMessage := 'Salary Account Application Successful';
//             EDMS.Reset;
//             EDMS.SetRange(Key, EDMS.Key::"Appraisal File");
//             if EDMS.FindFirst then begin
//                 FileName := url + 'Payslip - ' + MemberNumber + '.pdf';
//                 TempBlob.FromBase64String(File);
//                 if Exists(FileName) then Erase(FileName);
//                 FileManagement.BLOBExportToServerFile(TempBlob, FileName);

//             end;
//         end;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        //  LocalJsonTextWriter.WriteStartArray;
//         //    IF Status = 'SUCCESS' THEN BEGIN
//         //        NextofKIN.RESET;
//         //        NextofKIN.SETRANGE("Account No",MemberNumber);
//         //        IF NextofKIN.FINDFIRST THEN BEGIN
//         //            REPEAT
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('name');
//         //        LocalJsonTextWriter.WriteValue('name');
//         //        LocalJsonTextWriter.WriteEndObject;
//         //            UNTIL NextofKIN.NEXT=0;
//         //        END ELSE BEGIN
//         //            ResponseMessage:= 'No approved NOK Relationships Found';
//         //        END;
//         //    END;
//         //        //  LocalJsonTextWriter.WriteEndArray;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;

//     local procedure FileFunction()
//     var
//         FileName: Text;
//         FileManagement: Codeunit "Sky File Management";
//         TempBlob: Record "Sky TempBlob";
//         Base64PDF: Text;
//         GeneralSetUp: Record "General Set-Up";
//     begin
//         FileName := 'E:\files\file.pdf';
//         FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
//         Base64PDF := Format(TempBlob.ToBase64String);
//         Message(Base64PDF);
//     end;


//     procedure GetSalaryAccountEffectPeriods("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SkyAuth: Record "Sky USSD Auth";
//         Staff: Boolean;
//         Members: Record Members;
//         AccountNo: Code[30];
//         InterestDuePeriod: Record "Interest Due Period";
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);


//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Get Salary Account Effect Periods';
//         ResponseMessage := 'Salary Account Periods Fetched Successfully';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             //  SavingsAccounts.GET(SkyAuth."Account No.");
//             //  Members.GET(SavingsAccounts."Member No.");
//             ResponseMessage := 'Salary account periods fetched successfully.';
//             Status := 'SUCCESS';
//             // MemberNo := SavingsAccounts."Member No.";
//         end;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartArray;
//         InterestDuePeriod.Reset;
//         InterestDuePeriod.SetFilter("Interest Due Date", '>=%', Today);
//         if InterestDuePeriod.FindFirst then begin
//             repeat
//             //                LocalJsonTextWriter.WriteStartObject;
//             //                LocalJsonTextWriter.WritePropertyName('name');
//             //                LocalJsonTextWriter.WriteValue(InterestDuePeriod.Name);
//             //                LocalJsonTextWriter.WritePropertyName('date');
//             //                LocalJsonTextWriter.WriteValue(FormatDateDayMontYear(InterestDuePeriod."Interest Due Date"));
//             //                LocalJsonTextWriter.WriteEndObject;
//             until InterestDuePeriod.Next = 0;
//         end;

//         //        LocalJsonTextWriter.WriteEndArray;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;


//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;

//     local procedure FormatDateDayMontYear(RealDate: Date): Text
//     var
//         DayMontYear: Text;
//     begin
//         DayMontYear := Format(Date2dmy(RealDate, 1)) + '/' + Format(+Date2dmy(RealDate, 2))
//         + '/' + Format(Date2dmy(RealDate, 3));
//         exit(DayMontYear);
//     end;


//     procedure ApplyMBanking("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Product Factory";
//         SkyAuth: Record "Sky USSD Auth";
//         Staff: Boolean;
//         Members: Record Members;
//         MemberNumber: Code[30];
//         SalaryAgreement: Record "Salary Agreement";
//         GeneralSetUp: Record "General Setup";
//         InterestDuePeriod: Record "Interest Due Period";
//         SalesSetup: Record "Sales & Receivables Setup";
//         // NoSeriesMgt: Codeunit NoSeriesManagement;
//         HeaderNo: Code[30];
//         NoSetup: Record "Banking No Setup";
//         MSACCOApplications: Record "M-SACCO Applications";
//         Ordinary: Record "Savings Accounts";
//         OrdinaryAccount: Code[30];
//     begin
//         GeneralSetUp.Get();
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Salary Account Application';
//         ResponseMessage := 'Salary Account Application Successful';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             MemberNumber := Members."No.";

//             Ordinary.Reset;
//             Ordinary.SetRange("Member No.", MemberNumber);
//             Ordinary.SetRange("Product Type", '505');
//             if Ordinary.FindFirst then OrdinaryAccount := Ordinary."No.";
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;



//         Members.Get(MemberNumber);
//         if Status = 'SUCCESS' then begin
//             if (Members."Phone No." = '') then begin
//                 ResponseMessage := 'Your Mobile Phone No in members register is empty. Kindly contact the sacco for assistance';
//                 Status := 'FAILED';
//             end;
//         end;


//         if Status = 'SUCCESS' then begin
//             if (StrLen(Members."Phone No.") = 13) and (CopyStr(Members."Phone No.", 1, 4) <> '+254') then begin
//                 ResponseMessage := 'Your do not have a Mobile Phone No in members register. Kindly contact the sacco for assistance';
//                 Status := 'FAILED';
//             end;
//         end;

//         if Status = 'SUCCESS' then begin
//             if (StrLen(Members."Phone No.") = 10) and (CopyStr(Members."Phone No.", 1, 2) <> '07') then begin
//                 ResponseMessage := 'Your do not have a Mobile Phone No in members register. Kindly contact the sacco for assistance';
//                 Status := 'FAILED';
//             end;
//         end;


//         if Status = 'SUCCESS' then begin
//             NoSetup.Get;
//             NoSetup.TestField(NoSetup."M-SACCO Application Nos");
//             NoSeriesMgt.InitSeries(NoSetup."M-SACCO Application Nos", MSACCOApplications."No. Series", 0D, HeaderNo, MSACCOApplications."No. Series");

//             //Do the application
//             MSACCOApplications.Init;
//             MSACCOApplications.No := HeaderNo;
//             MSACCOApplications."Application Type" := MSACCOApplications."application type"::Initial;
//             MSACCOApplications."Document Serial No" := HeaderNo;
//             MSACCOApplications."Document Date" := Today;
//             MSACCOApplications."Account No" := OrdinaryAccount;
//             MSACCOApplications.Validate("Account No");
//             MSACCOApplications."Date Entered" := Today;
//             MSACCOApplications.Comments := 'New App';
//             MSACCOApplications."Time Entered" := Time;
//             MSACCOApplications."Entered By" := 'HARAMBEESACCO\WEBPORTAL';
//             MSACCOApplications."Virtual Registration" := true;
//             MSACCOApplications.Insert;
//             //Save the file

//             ResponseMessage := 'Application successful';
//         end;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        //  LocalJsonTextWriter.WriteStartArray;
//         //    IF Status = 'SUCCESS' THEN BEGIN
//         //        NextofKIN.RESET;
//         //        NextofKIN.SETRANGE("Account No",MemberNumber);
//         //        IF NextofKIN.FINDFIRST THEN BEGIN
//         //            REPEAT
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('name');
//         //        LocalJsonTextWriter.WriteValue('name');
//         //        LocalJsonTextWriter.WriteEndObject;
//         //            UNTIL NextofKIN.NEXT=0;
//         //        END ELSE BEGIN
//         //            ResponseMessage:= 'No approved NOK Relationships Found';
//         //        END;
//         //    END;
//         //        //  LocalJsonTextWriter.WriteEndArray;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetMBankingStatus("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Product Factory";
//         SkyAuth: Record "Sky USSD Auth";
//         Staff: Boolean;
//         Members: Record Members;
//         MemberNumber: Code[30];
//         SalaryAgreement: Record "Salary Agreement";
//         GeneralSetUp: Record "General Setup";
//         InterestDuePeriod: Record "Interest Due Period";
//         SalesSetup: Record "Sales & Receivables Setup";
//         // NoSeriesMgt: Codeunit NoSeriesManagement;
//         HeaderNo: Code[30];
//         NoSetup: Record "Banking No Setup";
//         MSACCOApplications: Record "M-SACCO Applications";
//         Ordinary: Record "Savings Accounts";
//         OrdinaryAccount: Code[30];
//         CanApply: Boolean;
//         RealStatus: Text;
//         OnGoing: Boolean;
//         message: Text;
//     begin
//         GeneralSetUp.Get();
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Salary Account Application';
//         ResponseMessage := 'Salary Account Application Successful';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             MemberNumber := Members."No.";

//             Ordinary.Reset;
//             Ordinary.SetRange("Member No.", MemberNumber);
//             Ordinary.SetRange("Product Type", '505');
//             if Ordinary.FindFirst then OrdinaryAccount := Ordinary."No.";

//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;

//         CanApply := false;
//         if Status = 'SUCCESS' then begin
//             SkyAuth.Reset;
//             SkyAuth.SetRange("Account No.", OrdinaryAccount);
//             SkyAuth.SetFilter("PIN No.", '<>%1', ' ');
//             if SkyAuth.FindFirst then begin
//                 message := 'You are already registered on mobile banking. Call 0709943000 to get a pin reset';
//                 RealStatus := 'Active';
//             end else begin
//                 MSACCOApplications.Reset;
//                 MSACCOApplications.SetRange("Account No", OrdinaryAccount);
//                 if MSACCOApplications.FindFirst then begin
//                     if MSACCOApplications.Status = MSACCOApplications.Status::Rejected then CanApply := true;

//                     if (MSACCOApplications.Status = MSACCOApplications.Status::Open) or
//                     (MSACCOApplications.Status = MSACCOApplications.Status::Pending) or
//                     (MSACCOApplications.Status = MSACCOApplications.Status::Approved) then
//                         message := 'You have an ongoing MBanking application. In case of any issues contact the SACCO';
//                     RealStatus := Format(MSACCOApplications.Status);
//                 end else begin
//                     CanApply := true;
//                     message := 'Proceed with application';
//                 end;
//             end;
//             ResponseMessage := 'Status retrieved successfully';
//         end;





//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        //  LocalJsonTextWriter.WriteStartArray;
//         //    IF Status = 'SUCCESS' THEN BEGIN
//         //        NextofKIN.RESET;
//         //        NextofKIN.SETRANGE("Account No",MemberNumber);
//         //        IF NextofKIN.FINDFIRST THEN BEGIN
//         //            REPEAT
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('mbanking_status');
//         //        LocalJsonTextWriter.WriteValue(RealStatus);
//         //        LocalJsonTextWriter.WritePropertyName('can_apply');
//         //        LocalJsonTextWriter.WriteValue(Format(CanApply));
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(message);
//         //        LocalJsonTextWriter.WriteEndObject;
//         //            UNTIL NextofKIN.NEXT=0;
//         //        END ELSE BEGIN
//         //            ResponseMessage:= 'No approved NOK Relationships Found';
//         //        END;
//         //    END;
//         //        //  LocalJsonTextWriter.WriteEndArray;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure CreateStandingOrder("Action": Text; Password: Text; Username: Text; records: Text; Amount: Decimal; IncomeType: Text; EffectiveStartDate: Text; Frequency: Integer; Duration: Integer; Description: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         GeneralSetUp: Record "General Set-Up";
//         Members: Record Members;
//         JSONArray: code[100];//dotnet JArray;
//         JObject: code[100];//dotnet JObject;
//         ArrayString: Text;
//         JSONString: Text;
//         HeaderNo: Code[30];
//         SeriesSetup: Record "Banking No Setup";
//         // NoSeriesMgt: Codeunit NoSeriesManagement;
//         EntryNo: Integer;
//         StandingOrderHeader: Record "Standing Order Header";
//         OrdinaryAccount: Code[30];
//         Ordinary: Record "Savings Accounts";
//         IncomeTypeOption: Option Periodic,Salary,Pension,Milk,Tea,Coffee;
//         STOLines: Record "Standing Order Lines";
//         DestinationAccountType: Option "G/L Account",Customer,Vendor,External,"Fixed Asset","IC Partner",Internal,Credit;
//         STOLineAmount: Decimal;
//         RealMemberNo: Code[30];
//         FrequencyDF: DateFormula;
//         DuratinDF: DateFormula;
//         DurationT: Text;
//         DestinationAccountNo: Code[30];
//         Loans: Record Loans;
//         DestinationAccountName: Text;
//     begin
//         GeneralSetUp.Get();
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Create NOK';


//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             RealMemberNo := SavingsAccounts."Member No.";
//         end;
//         Members.Get(RealMemberNo);

//         Ordinary.Reset;
//         Ordinary.SetRange("Member No.", MemberNo);
//         Ordinary.SetRange("Product Type", '505');
//         if Ordinary.FindFirst then begin
//             OrdinaryAccount := Ordinary."No.";
//         end;
//         /*-------------------------------------------------------------------------------------*/

//         if Status = 'SUCCESS' then begin

//             if IncomeType = 'SALARY' then IncomeTypeOption := Incometypeoption::Salary;
//             if IncomeType = 'PENSION' then IncomeTypeOption := Incometypeoption::Pension;
//             if IncomeType = 'PERIODIC' then IncomeTypeOption := Incometypeoption::Periodic;

//             SeriesSetup.Get;
//             SeriesSetup.TestField(SeriesSetup."Standing Order Nos.");
//             NoSeriesMgt.InitSeries(SeriesSetup."Standing Order Nos.", StandingOrderHeader."No. Series", 0D, HeaderNo, StandingOrderHeader."No. Series");
//             Evaluate(FrequencyDF, '1M');
//             DurationT := Format(Duration) + 'M';
//             Evaluate(DuratinDF, DurationT);
//             StandingOrderHeader.Init;
//             StandingOrderHeader."No." := HeaderNo;
//             StandingOrderHeader."Member No." := Members."No.";
//             StandingOrderHeader."Application Date" := Today;
//             StandingOrderHeader."Transaction Type" := 'STANDING ORDER';
//             StandingOrderHeader."Source Account Type" := StandingOrderHeader."source account type"::Savings;
//             StandingOrderHeader."Source Account No." := SavingsAccounts."No.";
//             StandingOrderHeader.Validate("Source Account No.");
//             StandingOrderHeader."Income Type" := IncomeTypeOption;
//             StandingOrderHeader.Amount := Amount;
//             StandingOrderHeader."Activity Code" := 'BANKING';
//             StandingOrderHeader."Branch Code" := 'NBI';
//             StandingOrderHeader."Effective/Start Date" := CreateDate(EffectiveStartDate);
//             StandingOrderHeader."Frequency (Months)" := FrequencyDF;
//             StandingOrderHeader."Duration (Months)" := DuratinDF;
//             StandingOrderHeader.Validate("Duration (Months)");
//             StandingOrderHeader.Description := Description;
//             StandingOrderHeader."Created By" := 'HARAMBEESACCO\WEBPORTAL';
//             StandingOrderHeader.Insert;

//             //STO LINES
//             ArrayString := records;
//             if ArrayString <> '' then
//                 //JObject := JObject.Parse(FORMAT(ArrayString));
//                 //ArrayString := JObject.SelectToken('destinations').ToString;
//                 //CLEAR(JObject);
//                 JSONArray := JSONArray.Parse(ArrayString);


//             foreach JObject in JSONArray do begin
//                 STOLines.Reset;
//                 if STOLines.FindLast then
//                     EntryNo := STOLines."Entry No." + 1;

//                 if Format(JObject.GetValue('destination_account_type')) = 'SAVINGS_INTERNAL' then DestinationAccountType := Destinationaccounttype::Internal;
//                 if Format(JObject.GetValue('destination_account_type')) = 'CREDIT' then DestinationAccountType := Destinationaccounttype::Credit;

//                 //destination account
//                 if DestinationAccountType = Destinationaccounttype::Credit then begin
//                     Loans.Get(Format(JObject.GetValue('destination_account_no')));
//                     DestinationAccountName := Loans."Member Name";
//                     DestinationAccountNo := Loans."Loan Account";
//                 end else begin
//                     SavingsAccounts.Get(Format(JObject.GetValue('destination_account_no')));
//                     DestinationAccountNo := SavingsAccounts."No.";
//                     DestinationAccountName := SavingsAccounts.Name;
//                 end;

//                 //IF DestinationAccountNo = '' THEN DestinationAccountNo := FORMAT(JObject.GetValue('destination_account_no'));
//                 Evaluate(STOLineAmount, Format(JObject.GetValue('amount')));

//                 STOLines.Init;
//                 STOLines."Entry No." := EntryNo;
//                 STOLines."Document No." := HeaderNo;
//                 STOLines."Destination Account Type" := DestinationAccountType;
//                 STOLines."Destination Account No." := DestinationAccountNo;
//                 STOLines."Loan No." := Loans."Loan No.";
//                 STOLines."Destination Account Name" := DestinationAccountName;
//                 //STOLines.VALIDATE("Destination Account No.");
//                 STOLines.Amount := STOLineAmount;
//                 STOLines."Member No" := RealMemberNo;
//                 STOLines.Insert;

//                 ResponseMessage := 'Standing Order received successfully and is being processed!';
//             end;
//         end;


//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        //            LocalJsonTextWriter.WritePropertyName('text');
//         //        //            LocalJsonTextWriter.WriteValue(Base64PDF);
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetStandingOrderEndDate("Action": Text; Password: Text; Username: Text; EffectiveStartDate: Text; Duration: Integer) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SkyAuth: Record "Sky USSD Auth";
//         Staff: Boolean;
//         Members: Record Members;
//         AccountNo: Code[30];
//         EndDate: Text;
//         StartDate: Date;
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);


//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Get STO end date';
//         ResponseMessage := 'Behold, STO end date';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;


//         StartDate := CreateDate(EffectiveStartDate);
//         EndDate := FormatDateDayMontYear(CalcDate(Format(Duration) + 'M', StartDate));

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         if Status = 'SUCCESS' then begin
//             ResponseMessage := 'Behold, STO end date';
//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('end_date');
//             //            LocalJsonTextWriter.WriteValue(EndDate);
//             //            LocalJsonTextWriter.WriteEndObject;
//         end else begin
//             ResponseMessage := 'STO end date not calculated';
//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('end_date');
//             //            LocalJsonTextWriter.WriteValue('');
//             //            LocalJsonTextWriter.WriteEndObject;
//         end;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;


//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure FundsTransfer("Action": Text; Password: Text; Username: Text; SessionID: Code[50]; TransactionType: Text; SourceAccountNo: Code[30]; DestinationAccountNo: Code[30]; Amount: Decimal) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Product Factory";
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         MemberNumber: Code[30];
//         GeneralSetUp: Record "General Setup";
//         SkyPortalTransactions: Record "Sky Portal Transactions";
//         AccountNo: Code[30];
//         TransactionTypeOption: Option " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Pesalink Transfer",Airtime,"Bank Deposit","Bank Agent Deposit","Bank Transfer","Agent Withdrawal","Check Beneficiary","Pin Reset";
//         LoanAccount: Code[30];
//         Loans: Record Loans;
//         Description: Text;
//         LoanNumber: Code[30];
//         DestinationAccountName: Text;
//         DestinationAccount: Record "Savings Accounts";
//         AccountBalance: Decimal;
//         SkyMbanking: Codeunit "Sky Mbanking";
//         Guid: Text[50];
//         LoansProcess: Codeunit "Loans Process";
//         SkyPortalSetup: Record "Sky Portal Setup";
//         TotalFundsTransacted: Decimal;
//     begin
//         GeneralSetUp.Get();
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Funds Transfer';
//         ResponseMessage := 'Funds transfer completed successfully';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             MemberNumber := Members."No.";
//             AccountNo := SkyAuth."Account No.";
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;


//         if Status = 'SUCCESS' then begin
//             SkyPortalSetup.Reset;
//             SkyPortalSetup.SetRange(Code, TransactionType);
//             if SkyPortalSetup.FindFirst then begin
//                 if Amount > SkyPortalSetup."Transaction Limit" then begin
//                     ResponseMessage := 'Transaction amount KES ' + Format(Amount) + ' is greater than the transaction limit of KES ' + Format(SkyPortalSetup."Transaction Limit");
//                     Status := 'FAILED';
//                 end;
//             end;
//         end;

//         if Status = 'SUCCESS' then begin
//             SkyPortalTransactions.Reset;
//             SkyPortalTransactions.SetRange("Transaction Date", Today);
//             SkyPortalTransactions.SetRange("Member Account", AccountNo);
//             if SkyPortalTransactions.FindFirst then begin
//                 SkyPortalTransactions.CalcSums(Amount);
//                 TotalFundsTransacted := SkyPortalTransactions.Amount;
//             end;
//             SkyPortalSetup.Reset;
//             SkyPortalSetup.SetRange(Code, TransactionType);
//             if SkyPortalSetup.FindFirst then begin
//                 if TotalFundsTransacted > SkyPortalSetup."Daily Limit" then begin
//                     ResponseMessage := 'Your transaction will exceed your daily limit of KES ' + Format(SkyPortalSetup."Transaction Limit") + '. You can only transact KES '
//                     + Format(SkyPortalSetup."Transaction Limit" - TotalFundsTransacted) + '.';
//                     Status := 'FAILED';
//                 end;
//             end;
//         end;

//         if Status = 'SUCCESS' then begin
//             //check balance
//             AccountBalance := SkyMbanking.GetAccountBalance(SourceAccountNo);

//             if Amount > AccountBalance then begin
//                 ResponseMessage := 'Balance Insufficient';
//                 Status := 'FAILED';
//             end;

//             if Amount <= 0 then begin
//                 ResponseMessage := 'Balance Insufficient';
//                 Status := 'FAILED';
//             end;
//         end;

//         if Status = 'SUCCESS' then begin
//             if TransactionType = 'LOAN REPAYMENT' then begin
//                 TransactionTypeOption := Transactiontypeoption::"Loan Repayment";
//                 Loans.Get(DestinationAccountNo);
//                 LoanNumber := DestinationAccountNo;
//                 DestinationAccountNo := Loans."Loan Account";
//                 DestinationAccountName := Loans."Loan Product Type Name";
//                 Description := 'Loan Payment. ' + AccountNo + ' -> ' + DestinationAccountNo;
//             end;
//             if TransactionType = 'ACCOUNT TRANSFER' then begin
//                 DestinationAccount.Get(DestinationAccountNo);
//                 DestinationAccountName := DestinationAccount."Product Name";
//                 TransactionTypeOption := Transactiontypeoption::"Account Transfer";
//                 Description := 'Acc Trans. ' + SourceAccountNo + ' -> ' + DestinationAccountNo;
//             end;

//             SkyPortalTransactions.Reset;
//             SkyPortalTransactions.SetRange("Session ID", SessionID);
//             if SkyPortalTransactions.FindFirst then begin
//                 ResponseMessage := 'Transaction already exists';
//                 Status := 'FAILED';
//             end else begin
//                 SkyPortalTransactions.Init;
//                 SkyPortalTransactions."Entry No." := SessionID;
//                 SkyPortalTransactions."Transaction ID" := SessionID;
//                 SkyPortalTransactions."Session ID" := SessionID;
//                 SkyPortalTransactions."Transaction Date" := Today;
//                 SkyPortalTransactions."Transaction Time" := Time;
//                 SkyPortalTransactions."Member Account" := AccountNo;
//                 SkyPortalTransactions.Description := Description;
//                 SkyPortalTransactions.Amount := Amount;
//                 SkyPortalTransactions."Transaction Type" := TransactionTypeOption;
//                 SkyPortalTransactions."Transaction Name" := TransactionType;
//                 SkyPortalTransactions."Loan No." := LoanNumber;
//                 SkyPortalTransactions."Mobile No." := SavingsAccounts."Transactional Mobile No";
//                 SkyPortalTransactions."Client Name" := SavingsAccounts.Name;
//                 SkyPortalTransactions."Source Account No" := SourceAccountNo;
//                 SkyPortalTransactions."Destination Account" := DestinationAccountNo;
//                 SkyPortalTransactions."Destination Name" := DestinationAccountName;
//                 SkyPortalTransactions.Insert;
//             end;
//         end;
//         Commit;

//         if Status = 'SUCCESS' then begin
//             //post the transaction
//             if PostPortalTransaction(SkyPortalTransactions."Session ID") then begin
//                 ResponseMessage := 'Transaction posted successfully';
//                 Status := 'SUCCESS';

//             end else begin
//                 ResponseMessage := 'Transaction not found';
//                 Status := 'FAILED';
//             end;
//         end;


//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue('value');
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure PostPortalTransaction(SessionID: Code[50]) Response: Boolean
//     var
//         SaccoFee: Decimal;
//         VendorCommission: Decimal;
//         TotalCharge: Decimal;
//         SavAcc: Record "Savings Accounts";
//         SaccoAccount: Code[20];
//         VendorAccount: Code[20];
//         SkyPTrans: Record "Sky Portal Transactions";
//         TransAmt: Decimal;
//         BUser: Record "Banking User Template";
//         JTemplate: Code[10];
//         JBatch: Code[10];
//         DocNo: Code[20];
//         PDate: Date;
//         AcctType: Enum "Gen. Journal Account Type";
//         BalAccType: Enum "Gen. Journal Account Type";
//         TransType: Enum "Transaction Types";
//         AccNo: Code[20];
//         BalAccNo: Code[20];
//         SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes","Cashier Below Limit","Cashier Above Limit","Chq Book","Bankers Cheque","Teller Cheque Transfer","Defaulter Loan Issued";
//         ExtDoc: Code[20];
//         LoanNo: Code[20];
//         Dim1: Code[20];
//         Dim2: Code[20];
//         SystCreated: Boolean;
//         RunBal: Decimal;
//         AccBal: Decimal;
//         Loans: Record Loans;
//         IntAmt: Decimal;
//         PrAmt: Decimal;
//         ATMTrans: Record "ATM Transactions";
//         SafcomCharges: Record "Sky Safcom Corporate Charges";
//         SafcomAcc: Code[20];
//         SafcomFee: Decimal;
//         SkyAgentWithdrawalsBuffer: Record "Sky Agent Withdrawals Buffer";
//         msg: Text;
//         PrePaymentGL: Code[20];
//         NewLoanBal: Decimal;
//         LoanType: Record "Product Factory";
//         LT: Text;
//         AccountToCharge: Code[20];
//         BillAcc: Record "Savings Accounts";
//         IntRate: Decimal;
//         MemberName: Text;
//         Depositor: Text;
//         GenSetup: Record "General Set-Up";
//         DepDesc: Text;
//         MobileNo: Code[20];
//         ExciseDutyGL: Code[30];
//         ExciseDutyRate: Decimal;
//         ExciseDuty: Decimal;
//         SMSAccount: Code[30];
//         SMSCharge: Decimal;
//         AgentTarriffHeader: Record "Agent Tarriff Header";
//         GenJournalBatch: Record "Gen. Journal Batch";
//         SaccoTrans: Codeunit "Sacco Transactions";
//         Priority: Integer;
//         AgentCommision: Decimal;
//         AgentAccount: Code[30];
//         Source: Option ,Agency;
//         AgentTariffDetails: Record "Agent Tariff Details";
//         SaccoComm: Decimal;
//         SaccoCommAcc: Code[30];
//         AgentCommAcc: Code[30];
//         ProductFactory: Record "Product Factory";
//         Bills: Decimal;
//         AgentCode: Code[30];
//         Desc: Text;
//         DescLoanNo: Text;
//         SkyMbanking: Codeunit "Sky Mbanking";
//         LoansProcess: Codeunit "Loans Process";
//         TotalCustomerCharge: Decimal;
//         DestinationBalance: Decimal;
//         SourceBalance: Decimal;
//         DestinationAccountName: Text;
//         SourceAccountName: Text;
//         AdviceType: Option Variation,Payment;
//     begin
//         Response := true;
//         SkyPTrans.Reset;
//         SkyPTrans.SetRange("Session ID", SessionID);
//         SkyPTrans.SetRange(Posted, false);
//         SkyPTrans.SetRange("Needs Change", false);
//         if SkyPTrans.FindFirst then begin
//             JTemplate := 'GENERAL';
//             JBatch := 'DEFAULT';

//             GenJournalBatch.Reset;
//             GenJournalBatch.SetRange("Journal Template Name", JTemplate);
//             GenJournalBatch.SetRange(Name, JBatch);
//             if not GenJournalBatch.FindFirst then begin
//                 GenJournalBatch.Init;
//                 GenJournalBatch."Journal Template Name" := JTemplate;
//                 GenJournalBatch.Name := JBatch;
//                 GenJournalBatch.Description := 'Sky World Batch';
//                 GenJournalBatch.Init;
//             end;

//             SavAcc.Get(SkyPTrans."Member Account");

//             DocNo := SkyPTrans."Transaction ID";
//             PDate := SkyPTrans."Transaction Date";

//             ExtDoc := '';
//             LoanNo := '';
//             TransType := Transtype::" ";
//             Dim1 := SavAcc."Global Dimension 1 Code";
//             Dim2 := SavAcc."Global Dimension 2 Code";
//             TransAmt := SkyPTrans.Amount;
//             LoanNo := SkyPTrans."Loan No.";
//             SystCreated := true;

//             SaccoTrans.InitJournal(JTemplate, JBatch);

//             if Response then begin
//                 RunBal := SkyPTrans.Amount;
//                 AccBal := SkyMbanking.GetAccountBalance(SkyPTrans."Source Account No");
//                 if AccBal < RunBal then RunBal := AccBal;
//                 if (SkyPTrans."Transaction Type" = SkyPTrans."transaction type"::"Account Transfer") then begin
//                     //Credit destination account
//                     SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, SkyPTrans."Destination Account",
//                     SkyPTrans.Description, Balacctype::"G/L Account", '', -RunBal, ExtDoc, LoanNo, TransType,
//                     Dim1, Dim2, SystCreated);

//                     //Debit source account
//                     SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, SkyPTrans."Source Account No",
//                     SkyPTrans.Description, Balacctype::"G/L Account", '', RunBal, ExtDoc, LoanNo, TransType,
//                     Dim1, Dim2, SystCreated);

//                     //Advice shares
//                     SavAcc.Get(SkyPTrans."Destination Account");
//                     if SavAcc."Product Type" = '02' then begin
//                         LoansProcess.AdviceShares(SavAcc, Abs(RunBal), SavAcc."Monthly Contribution");
//                     end;
//                 end;

//                 if SkyPTrans."Transaction Type" = SkyPTrans."transaction type"::"Loan Repayment" then begin
//                     RunBal := SkyPTrans.Amount;
//                     AccBal := SkyMbanking.GetAccountBalance(SavAcc."No.");
//                     if AccBal < RunBal then RunBal := AccBal;

//                     if RunBal > 0 then begin
//                         Loans.Reset;
//                         Loans.SetRange("Loan No.", SkyPTrans."Loan No.");
//                         Loans.SetRange("Member No.", SavAcc."Member No.");
//                         if Loans.FindFirst then begin
//                             Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Outstanding Bills");
//                             IntAmt := Loans."Outstanding Interest";
//                             if Loans."Mobile Loan" then
//                                 IntAmt := 0;
//                             if IntAmt > 0 then begin
//                                 if IntAmt > RunBal then
//                                     IntAmt := RunBal;
//                                 AccNo := SkyPTrans."Member Account";
//                                 ExtDoc := '';
//                                 TransType := Transtype::"Interest Paid";
//                                 SystCreated := true;

//                                 SkyPTrans."Interest Paid" := IntAmt;
//                                 SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, SkyPTrans.Description,
//                                 Balacctype::"G/L Account", '', IntAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated);

//                                 AccNo := Loans."Loan Account";
//                                 SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, SkyPTrans.Description
//                                 , Balacctype::"G/L Account", '', -IntAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated);

//                                 RunBal -= IntAmt;
//                             end;

//                             if Loans."Outstanding Balance" > 0 then begin
//                                 PrAmt := Loans."Outstanding Balance";
//                                 if PrAmt > RunBal then
//                                     PrAmt := RunBal;
//                                 Bills := PrAmt;

//                                 if PrAmt > Loans."Outstanding Bills" then
//                                     Bills := Loans."Outstanding Bills";

//                                 ProductFactory.Get(Loans."Loan Product Type");
//                                 AccNo := SkyPTrans."Member Account";
//                                 ExtDoc := '';
//                                 LoanNo := Loans."Loan No.";
//                                 TransType := Transtype::Repayment;
//                                 SystCreated := true;

//                                 SkyPTrans."Principal Paid" := PrAmt;

//                                 SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccNo, SkyPTrans.Description,
//                                               Balacctype::"G/L Account", '', PrAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated);
//                                 AccNo := Loans."Loan Account";
//                                 SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, SkyPTrans.Description,
//                                               Balacctype::"G/L Account", '', -PrAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated);
//                                 //Bills
//                                 SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, Loans."Loan Account", SkyPTrans.Description,
//                                               Balacctype::"G/L Account", '', -Bills, ExtDoc, LoanNo, Transtype::Bills, Dim1, Dim2, SystCreated);
//                                 SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", ProductFactory."Billed Account", SkyPTrans.Description,
//                                               Balacctype::"G/L Account", '', Bills, ExtDoc, '', Transtype::" ", Dim1, Dim2, SystCreated);

//                                 RunBal -= PrAmt;

//                                 //Advide loan


//                             end;
//                         end;
//                     end;
//                 end;



//                 //***msa
//                 SkyPTrans.Posted := true;
//                 SkyPTrans."Posted By" := UserId;
//                 SkyPTrans."Date Posted" := Today;
//                 SkyPTrans."Time Posted" := Time;
//                 SkyPTrans.Modify;

//                 Priority := 211;

//                 SaccoTrans.PostJournal(JTemplate, JBatch);

//                 if SkyPTrans."Transaction Type" = SkyPTrans."transaction type"::"Loan Repayment" then begin
//                     if Loans.Get(LoanNo) then begin
//                         Loans.CalcFields("Outstanding Balance");
//                         LT := Loans."Loan Product Type Name";
//                         if LoanType.Get(Loans."Loan Product Type") then
//                             LT := LoanType."USSD Product Name";

//                         NewLoanBal := Loans."Outstanding Balance";
//                         msg := 'Dear Member, ' + Format(SkyPTrans."Transaction Type") + ' of KES ' + Format(SkyPTrans.Amount) +
//                         ' has been processed successfully. Interest Paid is ' + Format(SkyPTrans."Interest Paid") +
//                         ', Principal Paid is ' + Format(SkyPTrans."Principal Paid") + ', New ' + LT + ' Balance is ' + Format(NewLoanBal);
//                     end;
//                     AdviceLoan(Loans."Loan No.", IntAmt + PrAmt, Advicetype::Payment, 0);
//                 end else begin

//                     if SavAcc.Get(SkyPTrans."Destination Account") then begin
//                         DestinationBalance := SkyMbanking.GetAccountBalance(SkyPTrans."Destination Account");
//                         DestinationAccountName := SavAcc."Product Name";
//                     end;
//                     if SavAcc.Get(SkyPTrans."Source Account No") then begin
//                         SourceBalance := SkyMbanking.GetAccountBalance(SkyPTrans."Source Account No");
//                         SourceAccountName := SavAcc."Product Name";
//                     end;

//                     msg := 'Dear Member, ' + Format(SkyPTrans."Transaction Type") + ' of KES ' + Format(SkyPTrans.Amount) +
//                         ' has been processed successfully. ' + SourceAccountName + ' balance is KES ' + Format(SourceBalance) +
//                         ', ' + DestinationAccountName + ' balance is KES ' + Format(DestinationBalance);
//                 end;

//                 SkyMbanking.SendSmsWithID(Source::Agency, MobileNo, msg, Format(SkyPTrans."Session ID"), '', true, Priority, false, 'PORTAL', SkyPTrans."Session ID", 'PORTAL');
//             end;
//         end else
//             Response := false;
//     end;


//     procedure GetRemainingInstallments(LoanNumber: Code[30]): Decimal
//     var
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Product Factory";
//         SkyAuth: Record "Sky USSD Auth";
//         Staff: Boolean;
//         Members: Record Members;
//         MemberNumber: Code[30];
//         GeneralSetUp: Record "General Setup";
//         SalesSetup: Record "Sales & Receivables Setup";
//         // NoSeriesMgt: Codeunit NoSeriesManagement;
//         HeaderNo: Code[30];
//         NoSetup: Record "Credit Nos. Series";
//         LoanRescheduling: Record "Loan Rescheduling";
//         Loan: Record Loans;
//         LoanSched: Record "Ideal Repayment Schedule";
//         PaymentMethodsApplication: Record "Payment Methods Application";
//         RemInstallments: Integer;
//         PaymentMethods: Record "Payment Methods";
//     begin
//         if Loan.Get(LoanNumber) then begin
//             Loan.CalcFields(Loan."Outstanding Balance", Loan."Outstanding Interest");
//             //Delete schedule if any.
//             //  LoanSched.RESET;
//             //  LoanSched.SETRANGE(LoanSched."Loan No.",LoanNumber);
//             //  IF LoanSched.FIND('-') THEN LoanSched.DELETEALL;

//             //Generate schedule.
//             //LoanRescheduling.GenerateSchedule(LoanNumber);

//             //Check if Ever Rescheduled.
//             //  LoanRescheduling.RESET;
//             //  LoanRescheduling.SETRANGE(LoanRescheduling."Loan No.",LoanNumber);
//             //  LoanRescheduling.SETRANGE(LoanRescheduling.Rescheduled, TRUE);
//             //  IF LoanRescheduling.FINDFIRST THEN BEGIN
//             //    REPEAT
//             //      LoanRescheduling.RecreateOldSchedules(LoanRescheduling."No.");
//             //    UNTIL LoanRescheduling.NEXT=0;
//             //  END;

//             // PaymentMethodsApplication.RESET;
//             //  PaymentMethodsApplication.SETRANGE("Loan No.",Loan."Loan No.");
//             //  IF PaymentMethodsApplication.FIND('-') THEN BEGIN
//             //    PaymentMethodsApplication.DELETEALL;
//             //  END;
//             //
//             //  PaymentMethods.RESET;
//             //  PaymentMethods.SETRANGE("Loan No.",Loan."Loan No.");
//             //  IF PaymentMethods.FIND('-') THEN BEGIN
//             //    REPEAT
//             //      PaymentMethodsApplication.INIT;
//             //      PaymentMethodsApplication."Loan No.":=PaymentMethods."Loan No.";
//             //      PaymentMethodsApplication."Payment Method":=PaymentMethods."Payment Method";
//             //      PaymentMethodsApplication."Member No.":=Loan."Member No.";
//             //      PaymentMethodsApplication.Amount:=PaymentMethods.Amount;
//             //     // PaymentMethodsApplication."Reschedule No":="No.";
//             //      PaymentMethodsApplication.INSERT;
//             //    UNTIL PaymentMethods.NEXT=0;
//             //  END;

//             //Check schedule details
//             LoanSched.Reset;
//             LoanSched.SetRange(LoanSched."Loan No.", LoanNumber);
//             //LoanSched.SETRANGE(LoanSched."Repayment Date",TODAY,99901230D);
//             LoanSched.SetFilter(LoanSched."Repayment Date", '>%1', Today);
//             if LoanSched.Find('-') then begin
//                 RemInstallments += 1;
//             end;
//         end;
//         exit(RemInstallments);
//     end;


//     procedure RescheduleLoan("Action": Text; Password: Text; Username: Text; LoanNumber: Code[30]; NewInstallments: Integer) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Product Factory";
//         SkyAuth: Record "Sky USSD Auth";
//         Staff: Boolean;
//         Members: Record Members;
//         MemberNumber: Code[30];
//         GeneralSetUp: Record "General Setup";
//         SalesSetup: Record "Sales & Receivables Setup";
//         // NoSeriesMgt: Codeunit NoSeriesManagement;
//         HeaderNo: Code[30];
//         NoSetup: Record "Credit Nos. Series";
//         LoanRescheduling: Record "Loan Rescheduling";
//         Loan: Record Loans;
//         LoanSched: Record "Ideal Repayment Schedule";
//         PaymentMethodsApplication: Record "Payment Methods Application";
//         RemInstallments: Integer;
//         PaymentMethods: Record "Payment Methods";
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';

//         ResponseTitle := 'Loan Rescheduling';
//         ResponseMessage := 'Loan Rescheduling was Successful';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             MemberNumber := Members."No.";

//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;

//         if Status = 'SUCCESS' then begin
//             NoSetup.Get();
//             NoSetup.TestField(NoSetup."Loan Reschedule");
//             NoSeriesMgt.InitSeries(NoSetup."Loan Reschedule", LoanRescheduling."No. Series", 0D, HeaderNo, LoanRescheduling."No. Series");

//             Loan.Get(LoanNumber);
//             LoanRescheduling.Init;
//             LoanRescheduling."No." := HeaderNo;
//             LoanRescheduling."Schedule Type" := LoanRescheduling."schedule type"::Reschedule;
//             LoanRescheduling."Rescheduling Date" := Today;
//             LoanRescheduling."Rescheduled By" := 'HARAMBEESACCO\WEBPORTAL';
//             LoanRescheduling."Member No." := Loan."Member No.";
//             LoanRescheduling.Validate("Member No.");
//             LoanRescheduling."Loan No." := LoanNumber;
//             LoanRescheduling.Validate("Loan No.");
//             LoanRescheduling."New Installments" := NewInstallments;
//             LoanRescheduling.Validate("New Installments");
//             if NewInstallments > LoanRescheduling."Remaining Installments" then begin
//                 ResponseMessage := 'New installments ' + Format(NewInstallments) +
//               ' cannot be grater than remaining installments ' + Format(LoanRescheduling."Remaining Installments") + '.';
//                 Status := 'FAILED';
//             end else begin
//                 ResponseMessage := 'Loan rescheduling request was successful';
//                 LoanRescheduling.Insert;
//             end;
//         end;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(Format(RemInstallments));
//         //        LocalJsonTextWriter.WriteEndObject;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetLoanNewMonthlyRepayment("Action": Text; Password: Text; Username: Text; LoanNumber: Code[30]; NewInstalments: Integer) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SkyAuth: Record "Sky USSD Auth";
//         Staff: Boolean;
//         Members: Record Members;
//         AccountNo: Code[30];
//         EndDate: Text;
//         StartDate: Date;
//         LoanRescheduling: Record "Loan Rescheduling";
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);


//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Get STO end date';
//         ResponseMessage := 'Behold, STO end date';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;




//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('new_loan_repayment');
//         //        LocalJsonTextWriter.WriteValue('');
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;


//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetDepositContributionDetails("Action": Text; Password: Text; Username: Text; Period: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Product Factory";
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         MemberNumber: Code[30];
//         MinimumAmount: Decimal;
//         CurrentContribution: Decimal;
//         AccountNo: Code[30];
//         AccountName: Text;
//         SavLedger: Record "Savings Ledger Entry";
//         CheckoffAdviceLine: Record "Checkoff Advice Line";
//         AmountOn: Decimal;
//         AdviceDate: Date;
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Deposit Contribution Details';
//         ResponseMessage := 'Deposits contribution details fetched Successfully';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             MemberNumber := Members."No.";
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;

//         if Status = 'SUCCESS' then begin
//             if Product.Get('02') then begin
//                 MinimumAmount := Product."Minimum Contribution";
//                 AccountName := Product."Product Description";
//                 SavingsAccounts.Reset;
//                 SavingsAccounts.SetRange("Member No.", MemberNumber);
//                 SavingsAccounts.SetRange("Product Type", '02');
//                 if SavingsAccounts.FindFirst then begin
//                     AccountNo := SavingsAccounts."No.";
//                     CurrentContribution := SavingsAccounts."Monthly Contribution";
//                     CurrentContribution := Abs(CurrentContribution);

//                 end;
//             end;

//             if Period <> '' then begin
//                 CheckoffAdviceLine.Reset;
//                 CheckoffAdviceLine.SetRange(Type, CheckoffAdviceLine.Type::Savings);
//                 CheckoffAdviceLine.SetRange("Member No.", MemberNumber);
//                 if CheckoffAdviceLine.FindLast then begin
//                     AmountOn := CheckoffAdviceLine."Amount On";
//                     AdviceDate := CheckoffAdviceLine."Advice Date";
//                 end;
//             end;
//             ResponseMessage := 'Deposits contribution details fetched Successfully';
//         end;



//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('account_name');
//         //        LocalJsonTextWriter.WriteValue(AccountName);
//         //        LocalJsonTextWriter.WritePropertyName('account_number');
//         //        LocalJsonTextWriter.WriteValue(AccountNo);
//         //        LocalJsonTextWriter.WritePropertyName('minimum_contribution');
//         //        LocalJsonTextWriter.WriteValue(Format(MinimumAmount));
//         //        LocalJsonTextWriter.WritePropertyName('current_contribution');
//         //        LocalJsonTextWriter.WriteValue(Format(CurrentContribution));
//         //        LocalJsonTextWriter.WriteEndObject;

//         //        LocalJsonTextWriter.WritePropertyName('existing_variation');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('amount');
//         //        LocalJsonTextWriter.WriteValue(Format(AmountOn));
//         //        LocalJsonTextWriter.WritePropertyName('date');
//         //        LocalJsonTextWriter.WriteValue(Format(AdviceDate));
//         //        LocalJsonTextWriter.WriteEndObject;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure UpdateDepositContribution("Action": Text; Password: Text; Username: Text; NewAmount: Decimal; Period: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Product Factory";
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         MemberNumber: Code[30];
//         MinimumAmount: Decimal;
//         CurrentContribution: Decimal;
//         AccountNo: Code[30];
//         AccountName: Text;
//         SavLedger: Record "Savings Ledger Entry";
//         CheckoffAdviceLine: Record "Checkoff Advice Line";
//         EntryNo: Integer;
//         DepositContribution: Record "Savings Accounts";
//         Balance: Decimal;
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Deposit variations';
//         ResponseMessage := 'Deposits variation success';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             MemberNumber := Members."No.";
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;

//         DepositContribution.Reset;
//         DepositContribution.SetRange("No.", '02' + MemberNumber);
//         if DepositContribution.FindFirst then begin
//             CurrentContribution := DepositContribution."Monthly Contribution";
//             CurrentContribution := Abs(CurrentContribution);
//             DepositContribution.CalcFields(Balance);
//             Balance := DepositContribution.Balance;


//             if Status = 'SUCCESS' then begin
//                 CheckoffAdviceLine.Reset;
//                 if CheckoffAdviceLine.FindLast then
//                     EntryNo := CheckoffAdviceLine."Entry No" + 1;
//                 CheckoffAdviceLine.Init;
//                 CheckoffAdviceLine."Entry No" := EntryNo;
//                 CheckoffAdviceLine.Names := Members.Name;
//                 CheckoffAdviceLine."Payroll No" := Members."Payroll/Staff No.";
//                 CheckoffAdviceLine."Employer Code" := Members."Employer Code";
//                 CheckoffAdviceLine."Employer Account No." := DepositContribution."Employer Account No";
//                 CheckoffAdviceLine."Advice Date" := Today;
//                 CheckoffAdviceLine."Product Type" := '02';
//                 CheckoffAdviceLine.Type := CheckoffAdviceLine.Type::Savings;
//                 CheckoffAdviceLine."Member No." := MemberNumber;
//                 CheckoffAdviceLine."Account No." := '02' + MemberNumber;
//                 CheckoffAdviceLine."Amount On" := NewAmount;
//                 CheckoffAdviceLine."Amount Off" := CurrentContribution;
//                 CheckoffAdviceLine."Balance Off" := 0;
//                 CheckoffAdviceLine."Balance On" := Balance;
//                 CheckoffAdviceLine."Product Type" := '02';
//                 CheckoffAdviceLine."Captured  By" := UserId;
//                 CheckoffAdviceLine."Advice Type" := CheckoffAdviceLine."advice type"::Variations;
//                 CheckoffAdviceLine.Period := Period;
//                 //CheckoffAdviceLine.VALIDATE("Account No.");
//                 //CheckoffAdviceLine.VALIDATE("Amount On");
//                 CheckoffAdviceLine.Insert;
//                 ResponseMessage := 'Deposits contribution application success';
//             end;
//         end;
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('member_number');
//         //        LocalJsonTextWriter.WriteValue(MemberNumber);
//         //        //     LocalJsonTextWriter.WritePropertyName('minimum_contribution');
//         //        //     LocalJsonTextWriter.WriteValue(FORMAT(MinimumAmount));
//         //        //     LocalJsonTextWriter.WritePropertyName('current_contribution');
//         //        //     LocalJsonTextWriter.WriteValue(FORMAT(CurrentContribution));
//         //        LocalJsonTextWriter.WriteEndObject;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure SubmitDelegateCorrespondence("Action": Text; Password: Text; Username: Text; Records: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         MemberNumber: Code[30];
//         SalesSetup: Record "Sales & Receivables Setup";
//         // NoSeriesMgt: Codeunit NoSeriesManagement;
//         HeaderNo: Code[30];
//         DelegatesHeader: Record "Delegates Minutes Header";
//         MembNoSeries: Record "Banking No Setup";
//         DelegateMemberss: Record "Delegate Members";
//         ElectralCode: Code[30];
//         MonthlyReturnArray: code[100];//dotnet JArray;
//         JObject: code[100];//dotnet JObject;
//         MonthlyReturnEntries: Text;
//         JSONString: Text;
//         ComplaiintsAndRemarks: Text;
//         JObjectLevel2: code[100];//dotnet JObject;
//         MembersString: Text;
//         MembersArray: code[100];//dotnet JArray;
//         CorrespondencePayload: code[100];//dotnet JObject;
//         ComplainsAndRemarksArray: code[100];//dotnet JArray;
//         OtherRemarksArray: code[100];//dotnet JArray;
//         TotalBranchMembers: Text;
//         DelegatesMonthlyReturns: Record "Delegates Monthly Returns";
//         DelegatesReturnsLines: Record "Delegates Returns Lines";
//         ComplainandRemarks: Record "Complain and Remarks";
//         TotalBranchMembersInt: Integer;
//         MemberName: Text[100];
//         OtherRemarks: Text;
//         LineNo: Integer;
//         DelegateName: Text;
//         DelegatesMeetingAttendees: Record "Delegates Meeting Attendees";
//         JObject3: code[100];//dotnet JObject;
//         Numbering: Integer;
//         MeetingDate: Text;
//         MeetingVenue: Text;
//         MeetingDateD: Date;
//         MemberNo: Code[30];
//         HMember: Record Members;
//         FName: Text;
//         Salute: Text;
//         SkyMbanking: Codeunit "Sky Mbanking";
//         MonthName: Text;
//         YearName: Text;
//         DelegateRegion: Text;
//         CurrentDateTimeText: Text;
//         msg: Text;
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Delegate Correspondence';
//         ResponseMessage := 'Delegate correspondence successful';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             MemberNumber := Members."No.";
//             DelegateName := Members.Name;
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;

//         if Status = 'SUCCESS' then begin
//             DelegateMemberss.Reset;
//             DelegateMemberss.SetRange("Delegate MNO.", MemberNumber);
//             DelegateMemberss.SetRange(Retired, false);
//             DelegateMemberss.SetFilter("Electoral Zone", '<>ALL');
//             if DelegateMemberss.FindFirst then begin
//                 ElectralCode := DelegateMemberss.Code;
//             end;

//             DelegatesHeader.Reset;
//             DelegatesHeader.SetRange("Delegate Region", ElectralCode);
//             DelegatesHeader.SetRange(Month, Date2dmy(Today, 2));
//             DelegatesHeader.SetRange(Year, Date2dmy(Today, 3));
//             if DelegatesHeader.FindFirst then begin
//                 ResponseMessage := 'Meeting for month ' + IntToMonthName(Date2dmy(Today, 2)) + ', year ' + Format(Date2dmy(Today, 3)) + ' and Electral zone '
//                 + DelegatesHeader."Electoral Name" + ' has already been created';
//                 Status := 'FAILED';
//             end;
//         end;

//         if Status = 'SUCCESS' then begin


//             ArrayString := Records;
//             if ArrayString <> '' then
//                 CorrespondencePayload := JObject.Parse(Format(ArrayString));

//             MonthlyReturnEntries := CorrespondencePayload.SelectToken('monthly_return_entries').ToString;
//             ComplaiintsAndRemarks := CorrespondencePayload.SelectToken('complaints_and_remarks').ToString;
//             TotalBranchMembers := CorrespondencePayload.SelectToken('total_branch_members').ToString;
//             MeetingDate := CorrespondencePayload.SelectToken('meeting_date').ToString;
//             MeetingDateD := CreateDate(MeetingDate);
//             MeetingVenue := CorrespondencePayload.SelectToken('meeting_venue').ToString;
//             OtherRemarks := CorrespondencePayload.SelectToken('other_remarks').ToString;
//             Clear(CorrespondencePayload);

//             MonthlyReturnArray := MonthlyReturnArray.Parse(MonthlyReturnEntries);

//             MembNoSeries.Get;
//             MembNoSeries.TestField(MembNoSeries."Delegate Minutes Nos.");
//             NoSeriesMgt.InitSeries(MembNoSeries."Delegate Minutes Nos.", DelegatesHeader."No. Series", 0D, HeaderNo, DelegatesHeader."No. Series");

//             //Do the application
//             DelegatesHeader.Init;
//             DelegatesHeader.Code := HeaderNo;
//             DelegatesHeader."Meeting Date" := MeetingDateD;
//             DelegatesHeader.Venue := MeetingVenue;
//             DelegatesHeader.Type := DelegatesHeader.Type::Normal;
//             DelegatesHeader."Delegate Region" := ElectralCode;
//             DelegatesHeader.Month := Date2dmy(Today, 2);
//             DelegatesHeader.Year := Date2dmy(Today, 3);
//             DelegatesHeader."Created By" := UserId;
//             DelegatesHeader.Validate("Delegate Region");
//             DelegatesHeader."Delegate Member No" := MemberNumber;
//             DelegatesHeader."Delegate Name" := DelegateName;
//             if DelegatesHeader.Insert then begin
//                 DelegatesMeetingAttendees.Reset;
//                 DelegatesMeetingAttendees.SetRange("Header No", HeaderNo);
//                 if DelegatesMeetingAttendees.FindFirst then
//                     DelegatesMeetingAttendees.DeleteAll;
//             end;

//             //Delegate submitter
//             DelegatesMeetingAttendees.Init;
//             DelegatesMeetingAttendees."Header No" := HeaderNo;
//             DelegatesMeetingAttendees."Delegate Region" := ElectralCode;
//             DelegatesMeetingAttendees."Delegate No." := MemberNumber;
//             DelegatesMeetingAttendees.Validate("Delegate No.");
//             DelegatesMeetingAttendees."Electoral Zone" := DelegatesHeader."Electoral Zone";
//             DelegatesMeetingAttendees.Insert;

//             foreach JObject in MonthlyReturnArray do begin
//                 DelegatesMonthlyReturns.Init;
//                 DelegatesMonthlyReturns."Header No" := HeaderNo;
//                 DelegatesMonthlyReturns."Caption Type" := Format(JObject.GetValue('type'));
//                 DelegatesMonthlyReturns.Caption := Format(JObject.GetValue('caption'));
//                 DelegatesMonthlyReturns.Insert;

//                 MembersString := Format(JObject.GetValue('members'));
//                 MembersArray := MembersArray.Parse(MembersString);
//                 foreach JObjectLevel2 in MembersArray do begin
//                     MemberNo := '';
//                     MemberName := '';
//                     if Format(JObject.GetValue('type')) <> 'NEW_MEMBERS' then begin
//                         if Format(JObjectLevel2.GetValue('identifier_type')) = 'ID_NUMBER' then begin
//                             Members.Reset;
//                             Members.SetRange("ID No.", Format(JObjectLevel2.GetValue('identifier')));
//                             if Members.FindFirst then begin
//                                 MemberName := Members.Name;
//                                 MemberNo := Members."No.";
//                             end;
//                         end;
//                         if Format(JObjectLevel2.GetValue('identifier_type')) = 'PAYROLL_NUMBER' then begin
//                             Members.Reset;
//                             Members.SetRange("Payroll/Staff No.", Format(JObjectLevel2.GetValue('identifier')));
//                             if Members.FindFirst then begin
//                                 MemberName := Members.Name;
//                                 MemberNo := Members."No.";
//                             end;
//                         end;
//                         if Format(JObjectLevel2.GetValue('identifier_type')) = 'MEMBER_NUMBER' then begin
//                             Members.Reset;
//                             Members.SetRange("No.", Format(JObjectLevel2.GetValue('identifier')));
//                             if Members.FindFirst then begin
//                                 MemberName := Members.Name;
//                                 MemberNo := Members."No.";
//                             end;
//                         end;
//                         if MemberNo = '' then
//                             Error('%1 %2 is not a member in meeting attendees.', Format(JObjectLevel2.GetValue('identifier_type')), Format(JObjectLevel2.GetValue('identifier')));

//                     end;
//                     if MemberNumber/*Submitter member number*/ <> MemberNo/*Meeting Attendee*/ then begin
//                         if Format(JObject.GetValue('type')) = 'MEETING_ATTENDEES' then begin
//                             DelegatesMeetingAttendees.Init;
//                             DelegatesMeetingAttendees."Header No" := HeaderNo;
//                             DelegatesMeetingAttendees."Delegate Region" := ElectralCode;
//                             DelegatesMeetingAttendees."Delegate No." := MemberNo;
//                             DelegatesMeetingAttendees.Validate("Delegate No.");
//                             DelegatesMeetingAttendees."Electoral Zone" := DelegatesHeader."Electoral Zone";
//                             DelegatesMeetingAttendees.Insert;
//                         end;
//                     end;

//                     if Format(JObject.GetValue('type')) <> 'MEETING_ATTENDEES' then begin
//                         DelegatesReturnsLines.Init;
//                         DelegatesReturnsLines."Header No" := HeaderNo;
//                         DelegatesReturnsLines."Caption Type" := Format(JObject.GetValue('type'));
//                         DelegatesReturnsLines."Phone Number" := Format(JObjectLevel2.GetValue('phone_number'));
//                         DelegatesReturnsLines."ID/Personal/Member Number" := Format(JObjectLevel2.GetValue('identifier'));
//                         DelegatesReturnsLines.Name := MemberName;
//                         DelegatesReturnsLines.Insert;
//                     end;
//                 end;
//             end;

//             ComplainsAndRemarksArray := ComplainsAndRemarksArray.Parse(ComplaiintsAndRemarks);

//             ComplainandRemarks.Reset;
//             if ComplainandRemarks.FindLast then
//                 LineNo := ComplainandRemarks."Line No" + 1;
//             Numbering := 1;
//             foreach JObject3 in ComplainsAndRemarksArray do begin
//                 ComplainandRemarks.Init;
//                 ComplainandRemarks."Header No" := HeaderNo;
//                 ComplainandRemarks."Line No" := LineNo;
//                 ComplainandRemarks.Type := ComplainandRemarks.Type::"Complains and Remarks";
//                 ComplainandRemarks."Complaint Catagory" := Format(JObject3.GetValue('complaint_category'));
//                 ComplainandRemarks.Complain := Format(JObject3.GetValue('complaint'));
//                 ComplainandRemarks.Suggestion := Format(JObject3.GetValue('suggestion'));
//                 ComplainandRemarks.Numbering := Numbering;
//                 ComplainandRemarks.Insert;

//                 LineNo += 1;
//                 Numbering += 1;
//             end;

//             //Fill Total Branch Members
//             Evaluate(TotalBranchMembersInt, TotalBranchMembers);
//             DelegatesMonthlyReturns.Init;
//             DelegatesMonthlyReturns."Header No" := HeaderNo;
//             DelegatesMonthlyReturns."Caption Type" := 'TOTAL_BRANCH_MEMBERS';
//             DelegatesMonthlyReturns.Caption := 'Total Branch Members';
//             DelegatesMonthlyReturns."Total Branch Members" := TotalBranchMembersInt;
//             DelegatesMonthlyReturns.Insert;


//             LineNo += 1;

//             ComplainandRemarks.Init;
//             ComplainandRemarks."Header No" := HeaderNo;
//             ComplainandRemarks."Line No" := LineNo;
//             ComplainandRemarks.Type := ComplainandRemarks.Type::"Other Remarks";
//             ComplainandRemarks."Proposed Resolutions" := OtherRemarks;
//             ComplainandRemarks.Insert;

//             MonthName := GetMonthName(Date2dmy(Today, 2));
//             YearName := Format(Date2dmy(Today, 3));
//             CurrentDateTimeText := FormatDateTimeReverse(CurrentDatetime);
//             //Send SMS
//             DelegateMemberss.Reset;
//             DelegateMemberss.SetRange(Code, ElectralCode);
//             DelegateMemberss.SetRange(Retired, false);
//             DelegateMemberss.SetFilter("Electoral Zone", '<>%1', 'ALL');
//             DelegateMemberss.SetFilter("Delegate MNO.", '<>%1', '');
//             if DelegateMemberss.FindFirst then begin
//                 repeat
//                     if HMember.Get(DelegateMemberss."Delegate MNO.") then begin
//                         FName := HMember."First Name";
//                         if FName = '' then
//                             FName := HMember."Middle Name";
//                         Salute := 'Dear ' + SkyMbanking.FirstName(FName) + ',' + SkyMbanking.NewLine;
//                         if DelegatesHeader.Get(HeaderNo) then
//                             DelegateRegion := DelegatesHeader."Electoral Name";

//                         msg := Salute + 'Monthly returns for ' + MonthName + ' ' + YearName + ' for your branch ' + DelegateRegion + ' were successfully submitted by ' + DelegateName
//                         + ' on ' + CurrentDateTimeText + '. REF#' + HeaderNo;

//                         SkyMbanking.SendSms(Source::MBANKING, HMember."Phone No.", msg, HeaderNo, '', true, 250, false);
//                     end;
//                 until DelegateMemberss.Next = 0;
//             end;

//             ResponseMessage := 'Delegate correspondence submitted successfully';
//         end;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('name');
//         //        LocalJsonTextWriter.WriteValue('name');
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetDelegateMeetings("Action": Text; Password: Text; Username: Text; Year: Integer) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Loan Charges";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         FileName: Text;
//         FileManagement: Codeunit "Sky File Management";
//         TempBlob: Record "Sky TempBlob";
//         Base64PDF: Text;
//         Testfile: File;
//         RealFileName: Text;
//         Members: Record Members;
//         DelegateMemberss: Record "Delegate Members";
//         DelegateMeetings: Record "Delegates Minutes Header";
//         Atendees: Record "Delegates Meeting Attendees";
//         EDMS: Record EDMS;
//         FromFile: Text;
//         Name: Text;
//         url: Text;
//         GeneralSetUp: Record "General Set-Up";
//     begin
//         GeneralSetUp.Get();
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Get Dividend Payslip';


//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             MemberNo := SavingsAccounts."Member No.";
//         end;
//         Members.Get(MemberNo);

//         /*-------------------------------------------------------------------------------------*/

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartArray;
//         if Status = 'SUCCESS' then begin
//             DelegateMemberss.Reset;
//             DelegateMemberss.SetRange("Delegate MNO.", MemberNo);
//             DelegateMemberss.SetRange(Retired, false);
//             DelegateMemberss.SetFilter("Electoral Zone", '<>ALL');
//             if DelegateMemberss.FindFirst then begin
//                 DelegateMeetings.Reset;
//                 DelegateMeetings.SetRange("Delegate Region", DelegateMemberss.Code);
//                 DelegateMeetings.SetRange(DelegateMeetings.Year, Year);
//                 if DelegateMeetings.FindFirst then begin
//                     repeat
//                         FileName := GeneralSetUp."PDF B64 Folder" + '\' + 'meeting - ' + DelegateMeetings.Code + '.pdf';
//                         if Exists(FileName) then begin
//                             FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
//                             Base64PDF := Format(TempBlob.ToBase64String);
//                         end;
//                         //                        LocalJsonTextWriter.WriteStartObject;
//                         //                        LocalJsonTextWriter.WritePropertyName('meeting_code');
//                         //                        LocalJsonTextWriter.WriteValue(DelegateMeetings.Code);
//                         //                        LocalJsonTextWriter.WritePropertyName('meeting_type');
//                         //                        LocalJsonTextWriter.WriteValue(Format(DelegateMeetings.Type));
//                         //                        LocalJsonTextWriter.WritePropertyName('electral_zone');
//                         //                        LocalJsonTextWriter.WriteValue(DelegateMeetings."Electoral Zone");
//                         //                        LocalJsonTextWriter.WritePropertyName('electral_name');
//                         //                        LocalJsonTextWriter.WriteValue(DelegateMeetings."Electoral Name");
//                         //                        LocalJsonTextWriter.WritePropertyName('electral_region');
//                         //                        LocalJsonTextWriter.WriteValue(DelegateMeetings."Electoral Region");
//                         //                        LocalJsonTextWriter.WritePropertyName('month');
//                         //                        LocalJsonTextWriter.WriteValue(IntToMonthName(DelegateMeetings.Month));
//                         //                        LocalJsonTextWriter.WritePropertyName('year');
//                         //                        LocalJsonTextWriter.WriteValue(Format(DelegateMeetings.Year));
//                         //                        LocalJsonTextWriter.WritePropertyName('posted');
//                         //                        LocalJsonTextWriter.WriteValue(Format(DelegateMeetings.Posted));
//                         //                        LocalJsonTextWriter.WritePropertyName('file');
//                         //                        LocalJsonTextWriter.WriteValue(Format(Base64PDF));
//                         //                        LocalJsonTextWriter.WritePropertyName('atendees');
//                         //                        LocalJsonTextWriter.WriteStartArray;
//                         Atendees.Reset;
//                         Atendees.SetRange("Header No", DelegateMeetings.Code);
//                         if Atendees.FindFirst then begin
//                             repeat
//                             //                                LocalJsonTextWriter.WriteStartObject;
//                             //                                LocalJsonTextWriter.WritePropertyName('delegate_no');
//                             //                                LocalJsonTextWriter.WriteValue(Atendees."Delegate No.");
//                             //                                LocalJsonTextWriter.WritePropertyName('delegate_name');
//                             //                                LocalJsonTextWriter.WriteValue(Atendees."Delegate Name");
//                             //                                LocalJsonTextWriter.WritePropertyName('delegate_phone');
//                             //                                LocalJsonTextWriter.WriteValue(Atendees."Delegate Phone");
//                             //                                LocalJsonTextWriter.WritePropertyName('delegate_position');
//                             //                                LocalJsonTextWriter.WriteValue(Atendees."Delegate Position");
//                             //                                LocalJsonTextWriter.WriteEndObject;
//                             until Atendees.Next = 0;
//                         end;
//                     //                        LocalJsonTextWriter.WriteEndArray;
//                     //                        LocalJsonTextWriter.WriteEndObject;
//                     until DelegateMeetings.Next = 0;
//                     ResponseMessage := 'Delegate meetings fetched successfully';
//                 end;
//             end;
//         end;
//         //        LocalJsonTextWriter.WriteEndArray;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetDelegateMeetingReport("Action": Text; Password: Text; Username: Text; MeetingCode: Code[30]) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Loan Charges";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         FileName: Text;
//         FileManagement: Codeunit "Sky File Management";
//         TempBlob: Record "Sky TempBlob";
//         Base64PDF: Text;
//         Testfile: File;
//         RealFileName: Text;
//         Members: Record Members;
//         DelegateMemberss: Record "Delegate Members";
//         DelegateMeetings: Record "Delegates Minutes Header";
//         Atendees: Record "Delegates Meeting Attendees";
//         EDMS: Record EDMS;
//         FromFile: Text;
//         Name: Text;
//         url: Text;
//         GeneralSetUp: Record "General Set-Up";
//         varLength: Integer;
//         DelegatesMonthlyReturns: Record "Delegates Monthly Returns";
//     begin
//         GeneralSetUp.Get();
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Get Dividend Payslip';


//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             MemberNo := SavingsAccounts."Member No.";
//         end;
//         Members.Get(MemberNo);

//         /*-------------------------------------------------------------------------------------*/
//         if Status = 'SUCCESS' then begin
//             DelegateMeetings.Reset;
//             DelegateMeetings.SetRange(DelegateMeetings.Code, MeetingCode);
//             if DelegateMeetings.FindFirst then begin

//                 FileName := GeneralSetUp."PDF B64 Folder" + '\' + 'meeting - ' + DelegateMeetings.Code + '.pdf';

//                 DelegatesMonthlyReturns.Reset;
//                 DelegatesMonthlyReturns.SetRange("Header No", MeetingCode);
//                 if DelegatesMonthlyReturns.FindFirst then begin
//                     Report.SaveAsPdf(Report::"Delegates Correspondence", FileName, DelegateMeetings);
//                     if Exists(FileName) then begin
//                         FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
//                         Base64PDF := Format(TempBlob.ToBase64String);
//                         RealFileName := 'meeting - ' + DelegateMeetings.Code + '.pdf';
//                         ResponseMessage := 'Report generated successfully';
//                         Testfile.Open(FileName);
//                         varLength := Testfile.LEN;
//                         Testfile.Close;
//                         Erase(FileName);
//                     end else begin
//                         ResponseMessage := 'The file cannot be found';
//                         Status := 'FAILED';
//                     end;
//                 end else begin
//                     Name := 'meeting - ' + MeetingCode;
//                     if Exists(FromFile) then begin
//                         FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
//                         Base64PDF := Format(TempBlob.ToBase64String);
//                         RealFileName := 'meeting - ' + DelegateMeetings.Code + '.pdf';
//                         ResponseMessage := 'Report generated successfully';
//                         Testfile.Open(FileName);
//                         varLength := Testfile.LEN;
//                         Testfile.Close;
//                     end else begin
//                         ResponseMessage := 'The file cannot be found';
//                         Status := 'FAILED';
//                     end;
//                 end;
//             end;
//         end;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('file');
//         //        LocalJsonTextWriter.WriteValue(Base64PDF);
//         //        LocalJsonTextWriter.WritePropertyName('file_type');
//         //        LocalJsonTextWriter.WriteValue('PDF');
//         //        LocalJsonTextWriter.WritePropertyName('file_name');
//         //        LocalJsonTextWriter.WriteValue(RealFileName);
//         //        LocalJsonTextWriter.WritePropertyName('file_size');
//         //        LocalJsonTextWriter.WriteValue(varLength);
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure SetLoanVariation("Action": Text; Password: Text; Username: Text; NewAmount: Decimal; Period: Text; LoanNumber: Code[30]) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Product Factory";
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         MemberNumber: Code[30];
//         MinimumAmount: Decimal;
//         CurrentRepayment: Decimal;
//         AccountNo: Code[30];
//         AccountName: Text;
//         SavLedger: Record "Savings Ledger Entry";
//         CheckoffAdviceLine: Record "Checkoff Advice Line";
//         EntryNo: Integer;
//         Loans: Record Loans;
//         Repayment: Decimal;
//         LoanAccountNo: Code[30];
//         LoanProduct: Code[30];
//         AdviceType: Option Variation,Payment;
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Loan variations';
//         ResponseMessage := 'Loan variation success';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             MemberNumber := Members."No.";
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;

//         CheckoffAdviceLine.Reset;
//         CheckoffAdviceLine.SetRange(Type, CheckoffAdviceLine.Type::Credit);
//         CheckoffAdviceLine.SetRange("Loan No.", LoanNumber);
//         if CheckoffAdviceLine.FindLast then begin
//             CurrentRepayment := CheckoffAdviceLine."Amount On";
//         end;

//         if CurrentRepayment = 0 then begin
//             if Loans.Get(LoanNumber) then begin
//                 CurrentRepayment := Loans.Repayment;
//                 Repayment := Loans.Repayment;
//                 LoanAccountNo := Loans."Loan Account";
//                 LoanProduct := Loans."Loan Product Type";
//             end;
//         end;

//         if Loans.Get(LoanNumber) then begin
//             LoanAccountNo := Loans."Loan Account";
//             LoanProduct := Loans."Loan Product Type";
//         end;

//         if NewAmount < Repayment then begin
//             ResponseMessage := 'Your variation amount of KES ' + Format(NewAmount) + ' should not be less than loan repayment of KES ' + Format(Repayment);
//             Status := 'FAILED';
//         end;

//         CheckoffAdviceLine.Reset;
//         CheckoffAdviceLine.SetRange(Type, CheckoffAdviceLine.Type::Credit);
//         CheckoffAdviceLine.SetRange("Loan No.", LoanNumber);
//         CheckoffAdviceLine.SetRange(CheckoffAdviceLine.Period, Period);
//         if CheckoffAdviceLine.FindFirst then begin
//             ResponseMessage := 'You can only do another advice after the current one for ' + Period + ', has been affected';
//             Status := 'FAILED';
//         end;

//         if CheckoffAdviceLine.FindLast then begin
//             CurrentRepayment := CheckoffAdviceLine."Amount On";
//         end;

//         if Status = 'SUCCESS' then begin
//             AdviceLoan(LoanNumber, 0, Advicetype::Variation, NewAmount);
//             ResponseMessage := 'Loan variation application successful';
//         end;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('member_number');
//         //        LocalJsonTextWriter.WriteValue(MemberNumber);
//         //        //     LocalJsonTextWriter.WritePropertyName('minimum_contribution');
//         //        //     LocalJsonTextWriter.WriteValue(FORMAT(MinimumAmount));
//         //        //     LocalJsonTextWriter.WritePropertyName('current_contribution');
//         //        //     LocalJsonTextWriter.WriteValue(FORMAT(CurrentContribution));
//         //        LocalJsonTextWriter.WriteEndObject;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetLoanVariationDetails("Action": Text; Password: Text; Username: Text; Period: Text; LoanNumber: Code[30]) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Product Factory";
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         MemberNumber: Code[30];
//         MinimumAmount: Decimal;
//         CurrentContribution: Decimal;
//         AccountNo: Code[30];
//         AccountName: Text;
//         SavLedger: Record "Savings Ledger Entry";
//         CheckoffAdviceLine: Record "Checkoff Advice Line";
//         AmountOn: Decimal;
//         AdviceDate: Date;
//         Loans: Record Loans;
//         CanVary: Boolean;
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Loan variation Details';
//         ResponseMessage := 'Loan Variation details fetched Successfully';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             MemberNumber := Members."No.";
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;

//         if Status = 'SUCCESS' then begin
//             CanVary := false;
//             if Period <> '' then begin
//                 CheckoffAdviceLine.Reset;
//                 CheckoffAdviceLine.SetCurrentkey("Entry No");
//                 CheckoffAdviceLine.Ascending(false);
//                 CheckoffAdviceLine.SetRange("Loan No.", LoanNumber);
//                 CheckoffAdviceLine.SetRange(CheckoffAdviceLine.Period, Period);
//                 if CheckoffAdviceLine.FindFirst then begin
//                     AmountOn := CheckoffAdviceLine."Amount On";
//                     AdviceDate := CheckoffAdviceLine."Advice Date";
//                     if Date2dmy(CheckoffAdviceLine."Advice Date", 3) = Date2dmy(Today, 3) then begin
//                         CanVary := false;
//                     end else begin
//                         CanVary := true;
//                     end;
//                 end else
//                     CanVary := true;
//             end;
//             ResponseMessage := 'Loan variation details fetched Successfully';
//         end;

//         if AmountOn = 0 then begin
//             if Loans.Get(LoanNumber) then begin
//                 AmountOn := Loans.Repayment;
//             end;
//         end;



//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('amount');
//         //        LocalJsonTextWriter.WriteValue(Format(AmountOn));
//         //        LocalJsonTextWriter.WritePropertyName('date');
//         //        LocalJsonTextWriter.WriteValue(FormatDate(AdviceDate));
//         //        LocalJsonTextWriter.WritePropertyName('can_vary');
//         //        LocalJsonTextWriter.WriteValue(Format(CanVary));
//         //        LocalJsonTextWriter.WriteEndObject;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure AdviceLoan(LoanNo: Code[20]; RepaymentAmount: Decimal; AdviceType: Option Variation,Payment; VariationAmount: Decimal)
//     var
//         iEntryNo: Integer;
//         CheckoffAdvice: Record "Checkoff Advice Line";
//         PaymentMethods: Record "Payment Methods";
//         Memb: Record Members;
//         Loans: Record Loans;
//         InterestAmount: Decimal;
//         InterestTotalsFlat: Decimal;
//         NoOfMonths: Integer;
//         MortgageInsurance: Decimal;
//         ProdFac: Record "Product Factory";
//         EmployerBal: Decimal;
//     begin
//         if Loans.Get(LoanNo) then begin

//             ProdFac.Get(Loans."Loan Product Type");

//             GenSetUp.Get;
//             if Loans."Recovery Mode" = Loans."recovery mode"::Checkoff then begin //KIgen Added to block non checkoff from advising
//                 Loans.CalcFields(Loans."Outstanding Balance");
//                 InterestAmount := ((Loans."Outstanding Balance" * Loans.Interest / 1200) / Loans.Installments);
//                 if InterestAmount < 0 then
//                     InterestAmount := 0;

//                 MortgageInsurance := 0;
//                 MortgageInsurance := Loans."Mortgage Insurance Amount";

//                 CheckoffAdvice.Reset;
//                 CheckoffAdvice.SetRange(CheckoffAdvice."Advice Date", Today);
//                 CheckoffAdvice.SetRange(CheckoffAdvice."Loan No.", Loans."Loan No.");
//                 if CheckoffAdvice.Find('-') then
//                     CheckoffAdvice.DeleteAll;

//                 iEntryNo := 0;
//                 CheckoffAdvice.Reset;
//                 if CheckoffAdvice.Find('+') then
//                     iEntryNo := CheckoffAdvice."Entry No" + 1;

//                 CheckoffAdvice.Init;
//                 CheckoffAdvice."Entry No" := iEntryNo;
//                 CheckoffAdvice."Account No." := Loans."Loan Account";
//                 CheckoffAdvice."Product Type" := Loans."Loan Product Type";
//                 CheckoffAdvice.Type := CheckoffAdvice.Type::Credit;
//                 CheckoffAdvice.Validate("Product Type");
//                 CheckoffAdvice."Loan No." := Loans."Loan No.";
//                 if Memb.Get(Loans."Member No.") then
//                     CheckoffAdvice."ID No." := Memb."ID No.";
//                 CheckoffAdvice."Member No." := Loans."Member No.";
//                 CheckoffAdvice.Validate("Member No.");
//                 CheckoffAdvice."Employer Code" := Memb."Employer Code";
//                 CheckoffAdvice.Names := Loans."Member Name";
//                 if Loans."Employer Loan No." <> '' then
//                     CheckoffAdvice."Employer Account No." := Loans."Employer Loan No."
//                 else
//                     CheckoffAdvice."Employer Account No." := Loans."Loan No.";
//                 CheckoffAdvice."Loan No." := Loans."Loan No.";

//                 if AdviceType = Advicetype::Payment then begin
//                     if Loans."Outstanding Balance" + InterestAmount <= 0 then begin
//                         CheckoffAdvice."Advice Type" := CheckoffAdvice."advice type"::Stoppage;
//                         CheckoffAdvice."Balance On" := 0;
//                     end else begin
//                         CheckoffAdvice."Advice Type" := CheckoffAdvice."advice type"::Adjustment;
//                         if Loans."Employer Balance" = 0 then
//                             CheckoffAdvice."Balance On" := Loans."Outstanding Balance"
//                         else
//                             CheckoffAdvice."Balance On" := Loans."Employer Balance" - RepaymentAmount;
//                     end;

//                     CheckoffAdvice."Amount On" := Loans.Repayment;
//                     CheckoffAdvice."Amount Off" := Loans.Repayment;
//                     CheckoffAdvice."Balance Off" := 0;

//                 end else begin
//                     CheckoffAdvice."Advice Type" := CheckoffAdvice."advice type"::Variations;
//                     CheckoffAdvice."Amount On" := VariationAmount;
//                     CheckoffAdvice."Amount Off" := Loans.Repayment;
//                     CheckoffAdvice."Balance Off" := 0;
//                     CheckoffAdvice."Balance On" := Loans."Employer Balance";
//                     if Loans."Employer Balance" = 0 then
//                         CheckoffAdvice."Balance On" := Loans."Outstanding Balance";

//                 end;
//                 CheckoffAdvice."Advice Date" := Today;
//                 CheckoffAdvice."Payroll No" := Memb."Payroll/Staff No.";
//                 CheckoffAdvice.Interest := Loans."Loan Interest Repayment";
//                 CheckoffAdvice."Captured  By" := UserId;
//                 CheckoffAdvice.Insert;
//             end;
//         end;
//     end;

//     local procedure IntToMonthName(MonthNumber: Integer): Code[10]
//     var
//         Text000: label '<Month Text>';
//         BuildDate: Date;
//     begin
//         BuildDate := Dmy2date(1, MonthNumber, 2022);
//         exit(Format(BuildDate, 0, Text000));
//     end;

//     local procedure EditDelegateCorrespondence(HeaderNo: Code[30]; File: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Product Factory";
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         MemberNumber: Code[30];
//         GeneralSetUp: Record "General Set-Up";
//         TempBlob: Record "Sky TempBlob";
//         FileManagement: Codeunit "Sky File Management";
//         FileName: Text;
//         EDMS: Record EDMS;
//         url: Text;
//         FilePath: Text;
//         SalesSetup: Record "Sales & Receivables Setup";
//         // NoSeriesMgt: Codeunit NoSeriesManagement;
//         DelegatesHeader: Record "Delegates Minutes Header";
//         MembNoSeries: Record "Banking No Setup";
//         DelegateMemberss: Record "Delegate Members";
//         ElectralCode: Code[30];
//     begin
//         // GeneralSetUp.GET();
//         // //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        // LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        // LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         //
//         // {-------------------------------------------------------------------------------------}
//         // Status := 'SUCCESS';
//         // {
//         // Possible Response Statuses:
//         // ---------------------------
//         // SUCCESS
//         // ERROR
//         // FAILED
//         // NOT_FOUND
//         // ---------------------------
//         // }
//         // ResponseTitle:= 'Delegate Correspondence';
//         // ResponseMessage:= 'Delegate correspondence successful';
//         // {-------------------------------------------------------------------------------------}
//         //
//         // IF COPYSTR(Username,1,3) = '254' THEN Username := '+'+Username;
//         //
//         //
//         // SkyAuth.RESET;
//         // IF COPYSTR(Username,1,4) = '+254' THEN
//         // SkyAuth.SETRANGE("Mobile No.",Username)
//         // ELSE
//         // SkyAuth.SETRANGE(SkyAuth.Username,Username);
//         // SkyAuth.SETRANGE(SkyAuth.Password,GetPassFromUserName(Username,Password));
//         // IF NOT SkyAuth.FINDFIRST THEN  BEGIN
//         //  ResponseMessage := 'Username or Password is incorrect';
//         //  Status :='FAILED';
//         // END ELSE BEGIN
//         //  SavingsAccounts.GET(SkyAuth."Account No.");
//         //  Members.GET(SavingsAccounts."Member No.");
//         //  MemberNumber := Members."No.";
//         //  ResponseMessage := 'Member Found';
//         //  Status :='SUCCESS';
//         // END;
//         //
//         // IF Status = 'SUCCESS' THEN BEGIN
//         //  DelegateMemberss.RESET;
//         //  DelegateMemberss.SETRANGE("Delegate MNO.",MemberNumber);
//         //  DelegateMemberss.SETRANGE(Retired,FALSE);
//         //  DelegateMemberss.SETFILTER("Electoral Zone",'<>ALL');
//         //  IF DelegateMemberss.FINDFIRST THEN BEGIN
//         //    ElectralCode := DelegateMemberss.Code;
//         //  END;
//         //
//         //  DelegatesHeader.RESET;
//         //  DelegatesHeader.SETRANGE("Delegate Region",ElectralCode);
//         //  DelegatesHeader.SETRANGE(Month,DATE2DMY(TODAY,2));
//         //  DelegatesHeader.SETRANGE(Year,DATE2DMY(TODAY,3));
//         //  IF DelegatesHeader.FINDFIRST THEN BEGIN
//         //      ResponseMessage := 'Meeting for month '+IntToMonthName(DATE2DMY(TODAY,2))+', year '+FORMAT(DATE2DMY(TODAY,3))+' and Electral zone '
//         //      +DelegatesHeader."Electoral Name"+' has already been created';
//         //      Status :='FAILED';
//         //  END;
//         // END;
//         //
//         // IF Status = 'SUCCESS' THEN BEGIN
//         //  MembNoSeries.GET;
//         //  MembNoSeries.TESTFIELD(MembNoSeries."Delegate Minutes Nos.");
//         //  NoSeriesMgt.InitSeries(MembNoSeries."Delegate Minutes Nos.",DelegatesHeader."No. Series",0D,HeaderNo,DelegatesHeader."No. Series");
//         //
//         //  //Do the application
//         //  DelegatesHeader.INIT;
//         //  DelegatesHeader.Code := HeaderNo;
//         //  DelegatesHeader.Type := DelegatesHeader.Type::Normal;
//         //  DelegatesHeader."Delegate Region" := ElectralCode;
//         //  DelegatesHeader.Month := DATE2DMY(TODAY,2);
//         //  DelegatesHeader.Year := DATE2DMY(TODAY,3);
//         //  DelegatesHeader."Created By" := USERID;
//         //  DelegatesHeader.VALIDATE("Delegate Region");
//         //  DelegatesHeader.INSERT;
//         //  //Save the file
//         //
//         //  ResponseMessage:= 'Delegate correspondence submitted successfully';
//         //
//         //    FileName := GeneralSetUp."PDF B64 Folder"+'\'+'meeting - '+HeaderNo+'.pdf';
//         //    TempBlob.FromBase64String(File);
//         //    IF EXISTS(FileName) THEN ERASE(FileName);
//         //    FileManagement.BLOBExportToServerFile(TempBlob,FileName);
//         //
//         //
//         //  ResponseMessage:= 'Delegate correspondence successful';
//         // END;
//         //
//         //        // LocalJsonTextWriter.WriteStartObject;
//         //        // LocalJsonTextWriter.WritePropertyName('data');
//         //        // //  LocalJsonTextWriter.WriteStartArray;
//         // //    IF Status = 'SUCCESS' THEN BEGIN
//         // //        NextofKIN.RESET;
//         // //        NextofKIN.SETRANGE("Account No",MemberNumber);
//         // //        IF NextofKIN.FINDFIRST THEN BEGIN
//         // //            REPEAT
//         //        //              LocalJsonTextWriter.WriteStartObject;
//         //        //                LocalJsonTextWriter.WritePropertyName('name');
//         //        //                LocalJsonTextWriter.WriteValue('name');
//         //        //              LocalJsonTextWriter.WriteEndObject;
//         // //            UNTIL NextofKIN.NEXT=0;
//         // //        END ELSE BEGIN
//         // //            ResponseMessage:= 'No approved NOK Relationships Found';
//         // //        END;
//         // //    END;
//         //        // //  LocalJsonTextWriter.WriteEndArray;
//         //
//         //        // LocalJsonTextWriter.WritePropertyName('title');
//         //        // LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        // LocalJsonTextWriter.WritePropertyName('message');
//         //        // LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        // LocalJsonTextWriter.WriteEndObject;
//         //
//         // //Payload := LocalStringBuilder.ToString;
//         //
//         // {-------------------------------------------------------------------------------------}
//         // Response := GenerateJSONResponse(Action, Status, Payload, TRUE);
//     end;


//     procedure GetDelegatesBranchDetails("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Loan Charges";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         FileName: Text;
//         FileManagement: Codeunit "Sky File Management";
//         TempBlob: Record "Sky TempBlob";
//         Base64PDF: Text;
//         Testfile: File;
//         RealFileName: Text;
//         Members: Record Members;
//         DelegateMemberss: Record "Delegate Members";
//         DelegateMeetings: Record "Delegates Minutes Header";
//         Atendees: Record "Delegates Meeting Attendees";
//         EDMS: Record EDMS;
//         FromFile: Text;
//         Name: Text;
//         url: Text;
//         GeneralSetUp: Record "General Set-Up";
//         BranchName: Text;
//         ActiveMembers: Integer;
//         DimensionValue: Record "Dimension Value";
//         CountingMembers: Record Members;
//         NewMembers: Integer;
//         DeceasedMembers: Integer;
//         DormantMembers: Integer;
//         OtherMembers: Integer;
//         WithdrawnMembers: Integer;
//         TotalMembers: Integer;
//         ElectralCode: Code[30];
//         ElectralName: Text;
//         DelegateRegion: Record "Delegate Region";
//     begin
//         GeneralSetUp.Get();
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Get Delegates Branch Details';


//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             MemberNo := SavingsAccounts."Member No.";
//         end;
//         Members.Get(MemberNo);



//         CountingMembers.Reset;
//         CountingMembers.SetRange("Global Dimension 2 Code", Members."Global Dimension 2 Code");
//         if CountingMembers.FindFirst then begin
//             TotalMembers := CountingMembers.Count;
//             //  REPEAT
//             //    IF CountingMembers.Status = CountingMembers.Status::New THEN
//             //      NewMembers += 1;
//             //    IF CountingMembers.Status = CountingMembers.Status::Active THEN
//             //      ActiveMembers += 1;
//             //    IF CountingMembers.Status = CountingMembers.Status::Deceased THEN
//             //      DeceasedMembers += 1;
//             //    IF CountingMembers.Status = CountingMembers.Status::Dormant THEN
//             //      DormantMembers += 1;
//             //    IF CountingMembers.Status = CountingMembers.Status::Closed THEN
//             //      WithdrawnMembers += 1;
//             //    IF (CountingMembers.Status <> CountingMembers.Status::New) AND
//             //        (CountingMembers.Status <> CountingMembers.Status::Active) AND
//             //        (CountingMembers.Status <> CountingMembers.Status::Deceased) AND
//             //        (CountingMembers.Status <> CountingMembers.Status::Closed) AND
//             //        (CountingMembers.Status <> CountingMembers.Status::Dormant) THEN
//             //        OtherMembers += 1;
//             //  UNTIL CountingMembers.NEXT = 0;
//         end;
//         /*-------------------------------------------------------------------------------------*/
//         DelegateMemberss.Reset;
//         DelegateMemberss.SetRange("Delegate MNO.", MemberNo);
//         DelegateMemberss.SetRange(Retired, false);
//         DelegateMemberss.SetFilter("Electoral Zone", '<>ALL');
//         if DelegateMemberss.FindFirst then begin
//             ElectralCode := DelegateMemberss.Code;

//             DelegateRegion.Reset;
//             DelegateRegion.SetRange(Code, ElectralCode);
//             if DelegateRegion.FindFirst then
//                 ElectralName := DelegateRegion."Delegate Region Description";
//         end;
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        //LocalJsonTextWriter.WriteStartArray;
//         if Status = 'SUCCESS' then begin
//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('zone_code');
//             //            LocalJsonTextWriter.WriteValue(ElectralCode);
//             //            LocalJsonTextWriter.WritePropertyName('zone_name');
//             //            LocalJsonTextWriter.WriteValue(ElectralName);
//             //            LocalJsonTextWriter.WritePropertyName('total_members');
//             //            LocalJsonTextWriter.WriteValue(Format(TotalMembers));
//             //            //            LocalJsonTextWriter.WriteStartObject;
//             //            //              LocalJsonTextWriter.WritePropertyName('new_members');
//             //            //              LocalJsonTextWriter.WriteValue(FORMAT(NewMembers));
//             //            //              LocalJsonTextWriter.WritePropertyName('active_members');
//             //            //              LocalJsonTextWriter.WriteValue(FORMAT(ActiveMembers));
//             //            //              LocalJsonTextWriter.WritePropertyName('dormant_members');
//             //            //              LocalJsonTextWriter.WriteValue(FORMAT(DormantMembers));
//             //            //              LocalJsonTextWriter.WritePropertyName('deceased_members');
//             //            //              LocalJsonTextWriter.WriteValue(FORMAT(DeceasedMembers));
//             //            //              LocalJsonTextWriter.WritePropertyName('withdrawn_members');
//             //            //              LocalJsonTextWriter.WriteValue(FORMAT(WithdrawnMembers));
//             //            //              LocalJsonTextWriter.WritePropertyName('other_members');
//             //            //              LocalJsonTextWriter.WriteValue(FORMAT(OtherMembers));
//             //            //              LocalJsonTextWriter.WritePropertyName('total_members');
//             //            //              LocalJsonTextWriter.WriteValue(FORMAT(TotalMembers));
//             //            //            LocalJsonTextWriter.WriteEndObject;
//             //            LocalJsonTextWriter.WriteEndObject;
//             ResponseMessage := 'Branch details fetched successfully';
//         end;
//         //        //LocalJsonTextWriter.WriteEndArray;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetDelegatesMonthlyReturnEntries("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Get Delegates Monthly Return Entries';

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             MemberNo := SavingsAccounts."Member No.";
//         end;
//         Members.Get(MemberNo);

//         /*-------------------------------------------------------------------------------------*/

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         if Status = 'SUCCESS' then begin
//             //            LocalJsonTextWriter.WriteStartArray;
//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('caption');
//             //            LocalJsonTextWriter.WriteValue('Meeting Attendees');
//             //            LocalJsonTextWriter.WritePropertyName('type');
//             //            LocalJsonTextWriter.WriteValue('MEETING_ATTENDEES');
//             //            LocalJsonTextWriter.WriteEndObject;

//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('caption');
//             //            LocalJsonTextWriter.WriteValue('New Members Recruited');
//             //            LocalJsonTextWriter.WritePropertyName('type');
//             //            LocalJsonTextWriter.WriteValue('NEW_MEMBERS');
//             //            LocalJsonTextWriter.WriteEndObject;

//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('caption');
//             //            LocalJsonTextWriter.WriteValue('Rejoiners');
//             //            LocalJsonTextWriter.WritePropertyName('type');
//             //            LocalJsonTextWriter.WriteValue('REJOINERS');
//             //            LocalJsonTextWriter.WriteEndObject;

//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('caption');
//             //            LocalJsonTextWriter.WriteValue('Withdrawals / Exits');
//             //            LocalJsonTextWriter.WritePropertyName('type');
//             //            LocalJsonTextWriter.WriteValue('WITHDRAWALS');
//             //            LocalJsonTextWriter.WriteEndObject;

//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('caption');
//             //            LocalJsonTextWriter.WriteValue('New Loans');
//             //            LocalJsonTextWriter.WritePropertyName('type');
//             //            LocalJsonTextWriter.WriteValue('NEW_LOANS');
//             //            LocalJsonTextWriter.WriteEndObject;

//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('caption');
//             //            LocalJsonTextWriter.WriteValue('Wafanisi Accounts');
//             //            LocalJsonTextWriter.WritePropertyName('type');
//             //            LocalJsonTextWriter.WriteValue('WAFANISI_ACCOUNTS');
//             //            LocalJsonTextWriter.WriteEndObject;

//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('caption');
//             //            LocalJsonTextWriter.WriteValue('Salary Accounts');
//             //            LocalJsonTextWriter.WritePropertyName('type');
//             //            LocalJsonTextWriter.WriteValue('SALARY_ACCOUNTS');
//             //            LocalJsonTextWriter.WriteEndObject;

//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('caption');
//             //            LocalJsonTextWriter.WriteValue('Variation Up');
//             //            LocalJsonTextWriter.WritePropertyName('type');
//             //            LocalJsonTextWriter.WriteValue('VARIATION_UP');
//             //            LocalJsonTextWriter.WriteEndObject;

//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('caption');
//             //            LocalJsonTextWriter.WriteValue('Toto Accounts');
//             //            LocalJsonTextWriter.WritePropertyName('type');
//             //            LocalJsonTextWriter.WriteValue('TOTO_ACCOUNTS');
//             //            LocalJsonTextWriter.WriteEndObject;

//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('caption');
//             //            LocalJsonTextWriter.WriteValue('Mortgage Loan: Home/Jenga Loan');
//             //            LocalJsonTextWriter.WritePropertyName('type');
//             //            LocalJsonTextWriter.WriteValue('MORTGAGE_LOAN');
//             //            LocalJsonTextWriter.WriteEndObject;

//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('caption');
//             //            LocalJsonTextWriter.WriteValue('Defaulters');
//             //            LocalJsonTextWriter.WritePropertyName('type');
//             //            LocalJsonTextWriter.WriteValue('DEFAULTERS');
//             //            LocalJsonTextWriter.WriteEndObject;
//             //            LocalJsonTextWriter.WriteEndArray;

//             ResponseMessage := 'Branch details fetched successfully';
//         end;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;

//     local procedure SubmitDelegateCorrespondence2("Action": Text; Password: Text; Username: Text; File: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Product Factory";
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         MemberNumber: Code[30];
//         GeneralSetUp: Record "General Set-Up";
//         TempBlob: Record "Sky TempBlob";
//         FileManagement: Codeunit "Sky File Management";
//         FileName: Text;
//         EDMS: Record EDMS;
//         url: Text;
//         FilePath: Text;
//         SalesSetup: Record "Sales & Receivables Setup";
//         // NoSeriesMgt: Codeunit NoSeriesManagement;
//         HeaderNo: Code[30];
//         DelegatesHeader: Record "Delegates Minutes Header";
//         MembNoSeries: Record "Banking No Setup";
//         DelegateMemberss: Record "Delegate Members";
//         ElectralCode: Code[30];
//     begin
//         GeneralSetUp.Get();
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Delegate Correspondence';
//         ResponseMessage := 'Delegate correspondence successful';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             MemberNumber := Members."No.";
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;

//         if Status = 'SUCCESS' then begin
//             DelegateMemberss.Reset;
//             DelegateMemberss.SetRange("Delegate MNO.", MemberNumber);
//             DelegateMemberss.SetRange(Retired, false);
//             DelegateMemberss.SetFilter("Electoral Zone", '<>ALL');
//             if DelegateMemberss.FindFirst then begin
//                 ElectralCode := DelegateMemberss.Code;
//             end;

//             DelegatesHeader.Reset;
//             DelegatesHeader.SetRange("Delegate Region", ElectralCode);
//             DelegatesHeader.SetRange(Month, Date2dmy(Today, 2));
//             DelegatesHeader.SetRange(Year, Date2dmy(Today, 3));
//             if DelegatesHeader.FindFirst then begin
//                 ResponseMessage := 'Meeting for month ' + IntToMonthName(Date2dmy(Today, 2)) + ', year ' + Format(Date2dmy(Today, 3)) + ' and Electral zone '
//                 + DelegatesHeader."Electoral Name" + ' has already been created';
//                 Status := 'FAILED';
//             end;
//         end;

//         if Status = 'SUCCESS' then begin
//             MembNoSeries.Get;
//             MembNoSeries.TestField(MembNoSeries."Delegate Minutes Nos.");
//             NoSeriesMgt.InitSeries(MembNoSeries."Delegate Minutes Nos.", DelegatesHeader."No. Series", 0D, HeaderNo, DelegatesHeader."No. Series");

//             //Do the application
//             DelegatesHeader.Init;
//             DelegatesHeader.Code := HeaderNo;
//             DelegatesHeader.Type := DelegatesHeader.Type::Normal;
//             DelegatesHeader."Delegate Region" := ElectralCode;
//             DelegatesHeader.Month := Date2dmy(Today, 2);
//             DelegatesHeader.Year := Date2dmy(Today, 3);
//             DelegatesHeader."Created By" := UserId;
//             DelegatesHeader.Validate("Delegate Region");
//             DelegatesHeader.Insert;
//             //Save the file

//             ResponseMessage := 'Delegate correspondence submitted successfully';

//             FileName := GeneralSetUp."PDF B64 Folder" + '\' + 'meeting - ' + HeaderNo + '.pdf';
//             TempBlob.FromBase64String(File);
//             if Exists(FileName) then Erase(FileName);
//             FileManagement.BLOBExportToServerFile(TempBlob, FileName);


//             ResponseMessage := 'Delegate correspondence successful';
//         end;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        //  LocalJsonTextWriter.WriteStartArray;
//         //    IF Status = 'SUCCESS' THEN BEGIN
//         //        NextofKIN.RESET;
//         //        NextofKIN.SETRANGE("Account No",MemberNumber);
//         //        IF NextofKIN.FINDFIRST THEN BEGIN
//         //            REPEAT
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('name');
//         //        LocalJsonTextWriter.WriteValue('name');
//         //        LocalJsonTextWriter.WriteEndObject;
//         //            UNTIL NextofKIN.NEXT=0;
//         //        END ELSE BEGIN
//         //            ResponseMessage:= 'No approved NOK Relationships Found';
//         //        END;
//         //    END;
//         //        //  LocalJsonTextWriter.WriteEndArray;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure CheckIfMemberExists("Action": Text; Password: Text; Username: Text; IdentifierType: Code[30]; Identifier: Code[30]) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         Product: Record "Loan Charges";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         MemberExists: Text;
//         Members: Record Members;
//     begin

//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Check If Member Exists';


//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             MemberNo := SavingsAccounts."Member No.";
//         end;

//         MemberExists := 'FALSE';

//         if IdentifierType = 'ID_NUMBER' then begin
//             Members.Reset;
//             Members.SetRange("ID No.", Identifier);
//             if Members.FindFirst then
//                 MemberExists := 'TRUE';
//         end;
//         if IdentifierType = 'PAYROLL_NUMBER' then begin
//             Members.Reset;
//             Members.SetRange("Payroll/Staff No.", Identifier);
//             if Members.FindFirst then
//                 MemberExists := 'TRUE';
//         end;
//         if IdentifierType = 'MEMBER_NUMBER' then begin
//             Members.Reset;
//             Members.SetRange("No.", Identifier);
//             if Members.FindFirst then
//                 MemberExists := 'TRUE';
//         end;


//         /*-------------------------------------------------------------------------------------*/

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         if Status = 'SUCCESS' then begin
//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('member_exists');
//             //            LocalJsonTextWriter.WriteValue(MemberExists);
//             //            LocalJsonTextWriter.WriteEndObject;

//             ResponseMessage := 'Member Existence Confirmed';
//         end;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure CreateSavingsAccounts("Action": Text; Password: Text; Username: Text; AccountName: Text[100]; BusinessLocation: Text[250]; ProductCode: Text[50]; DateOfBirth: Date; BirthCertificateNumber: Code[50]; Gender: Text[10]; STOAmount: Decimal; krapin: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Members: Record Members;
//         SavingsAccounts: Record "Savings Accounts";
//         SkyBusinessAccounts: Record "Sky Business Accounts";
//         ProductFactory: Record "Product Factory";
//         SuffixText: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         AccountNo: Code[30];
//         SavingsAcc: Record "Savings Accounts";
//         AvailableAccounts: Integer;
//         NewAcountNo: Code[30];
//         MemberNo: Code[30];
//         msg: Text;
//         AccBal: Decimal;
//         JTemplate: Code[10];
//         JBatch: Code[10];
//         Dim1: Code[10];
//         Dim2: Code[10];
//         AcctType: Enum "Gen. Journal Account Type";
//         BalAccType: Enum "Gen. Journal Account Type";
//         TransType: Enum "Transaction Types";
//         BalAccNo: Code[20];
//         BusinessAccountCode: Code[30];
//         BusinessAccount: Boolean;
//         TotoSavings: Boolean;
//         FixedDeposit: Boolean;
//         Continue: Boolean;
//         SkyMbanking: Codeunit "Sky Mbanking";
//         FName: Text;
//         StandingOrderHeader: Record "Standing Order Header";
//         StandingOrderLines: Record "Standing Order Lines";
//         STONo: Code[30];
//         SeriesSetup: Record "Banking No Setup";
//         // NoSeriesMgt: Codeunit NoSeriesManagement;
//         UserSetUp: Record "User Setup";
//         Frequency: DateFormula;
//         STOInserted: Boolean;
//         STOLinesInserted: Boolean;
//         SavingsAccountCreated: Boolean;
//     begin

//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Check If Member Exists';


//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Continue := false;
//         end else begin
//             ResponseMessage := 'Member Found';
//             Continue := true;
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             MemberNo := SavingsAccounts."Member No.";
//             AccountNo := SavingsAccounts."No.";
//         end;

//         if Continue then begin
//             BusinessAccount := false;
//             TotoSavings := false;
//             FixedDeposit := false;
//             if ProductFactory.Get(ProductCode) then begin
//                 if ProductFactory."Product Category" = ProductFactory."product category"::"Business Account" then
//                     BusinessAccount := true;
//                 if ProductFactory."Product Category" = ProductFactory."product category"::"Junior Savings" then
//                     TotoSavings := true;
//                 if ProductFactory."Product Category" = ProductFactory."product category"::"Fixed Deposit" then
//                     FixedDeposit := true;
//             end else begin
//                 ResponseMessage := 'Product code not found';
//                 Continue := false;
//             end;
//         end;

//         if Continue then begin
//             Members.Get(MemberNo);
//             if Members.Status <> Members.Status::Active then begin
//                 ResponseMessage := 'Member not active';
//                 Continue := false;
//             end;
//         end;



//         if Continue then begin
//             if BusinessAccount then begin
//                 //Confirm FOSA account balance
//                 SavingsAccounts.Reset;
//                 SavingsAccounts.SetRange("Product Type", '505');
//                 SavingsAccounts.SetRange("Member No.", MemberNo);
//                 if SavingsAccounts.FindFirst then begin
//                     AccBal := SkyMbanking.GetAccountBalance(SavingsAccounts."No.");
//                     if AccBal < ProductFactory."Minimum Amt B/s Accnt" then begin
//                         ResponseMessage := 'Dear member, your application for a business account has FAILED. You have insufficient balance in your FOSA Savings Account.' +
//                         ' Kindly deposit KES ' + Format(ProductFactory."Minimum Amt B/s Accnt") + ' and try again.';
//                         Continue := false;
//                         Status := 'ERROR';
//                     end;
//                 end;
//             end;
//         end;

//         if Continue then begin
//             SavingsAccounts.Reset;
//             SavingsAccounts.SetRange("Product Type", ProductFactory."Product ID");
//             SavingsAccounts.SetRange("Member No.", Members."No.");
//             if SavingsAccounts.FindFirst then begin
//                 AvailableAccounts := SavingsAccounts.Count();
//                 if BusinessAccount then begin
//                     Response := 'You already have a bussiness account. Acc no: ' + SavingsAccounts."Business Account Code";
//                     Continue := false;
//                     Status := 'ERROR';
//                 end;
//             end;
//         end;

//         if Continue then begin
//             Members.Get(MemberNo);

//             if ProductFactory.Get(ProductCode) then begin
//                 SuffixText := ProductFactory."Account No. Suffix";
//                 NewAcountNo := ProductFactory."Account No. Prefix" + Members."No." + SuffixText + Format(AvailableAccounts + 1);
//                 if BusinessAccount then
//                     BusinessAccountCode := SkyMbanking.CreateBusinessAccountCode;

//                 SavingsAcc.Init;
//                 SavingsAcc."Business Account Code" := BusinessAccountCode;
//                 SavingsAcc."No." := NewAcountNo;
//                 SavingsAcc.Validate(SavingsAcc.Name, AccountName);
//                 if FixedDeposit then
//                     SavingsAcc.Validate(SavingsAcc.Name, Members.Name);
//                 SavingsAcc."ID No." := Members."Primary Identification";
//                 SavingsAcc."Passport No." := Members."Passport No.";
//                 SavingsAcc."Customer Posting Group" := ProductFactory."Product Posting Group";
//                 SavingsAcc.County := Members.City;
//                 SavingsAcc."Phone No." := Members."Phone No.";
//                 SavingsAcc."Mobile Phone No" := Members."Phone No.";
//                 SavingsAcc."Current Address" := Members."Current Address";
//                 SavingsAcc."Post Code" := Members."Post Code";
//                 SavingsAcc.City := Members.City;
//                 SavingsAcc.Status := SavingsAcc.Status::Active;
//                 SavingsAcc."Country/Region Code" := Members.Nationality;
//                 SavingsAcc."Home Address" := Members."Home Address";
//                 SavingsAcc."Registration Date" := Today;
//                 SavingsAcc."Recruited by Type" := Members."Recruited by Type";
//                 SavingsAcc."Relationship Manager" := Members."Allocated Officer";


//                 SavingsAcc."Date of Birth" := Members."Date of Birth";
//                 SavingsAcc."Birth Certificate No." := Members."Birth Certificate No.";
//                 SavingsAcc.Gender := Members.Gender;
//                 SavingsAcc."Marital Status" := Members."Marital Status";
//                 if TotoSavings then begin
//                     SavingsAcc."Date of Birth" := DateOfBirth;
//                     SavingsAcc."Birth Certificate No." := BirthCertificateNumber;
//                     if Gender = 'male' then
//                         SavingsAcc.Gender := SavingsAcc.Gender::Male
//                     else
//                         SavingsAcc.Gender := SavingsAcc.Gender::Female;
//                     SavingsAcc."Marital Status" := SavingsAccounts."marital status"::Single;
//                     SavingsAcc."Product Category" := SavingsAcc."product category"::"Junior Savings";
//                     SavingsAcc."ID No." := BirthCertificateNumber;
//                 end;
//                 if BusinessAccount then
//                     SavingsAcc."Product Category" := SavingsAcc."product category"::"Business Account";
//                 if FixedDeposit then
//                     SavingsAcc."Product Category" := SavingsAcc."product category"::"Fixed Deposit";


//                 SavingsAcc."Payroll/Staff No." := Members."Payroll/Staff No.";
//                 SavingsAcc."Member Category" := Members."Member Class";
//                 SavingsAcc."Old Member No." := Members."Old Member No.";
//                 SavingsAcc."Associated Member No." := Members."Principle Member";
//                 SavingsAcc."Responsibility Center" := Members."Responsibility Center";
//                 SavingsAcc."Company Registration No." := Members."Company Registration No.";
//                 SavingsAcc."Employer Code" := Members."Employer Code";
//                 SavingsAcc."Single Party/Multiple/Business" := Members."Single Party/Multiple";
//                 SavingsAcc."Global Dimension 1 Code" := Members."Global Dimension 1 Code";
//                 SavingsAcc."Global Dimension 2 Code" := Members."Global Dimension 2 Code";
//                 SavingsAcc."Group Account No" := Members."Group Account No.";
//                 SavingsAcc."Created By" := UserId;
//                 SavingsAcc."Loan Disbursement Account" := false;
//                 SavingsAcc."Product Type" := ProductFactory."Product ID";
//                 SavingsAcc."Product Name" := ProductFactory."Product Description";
//                 SavingsAcc."Member No." := Members."No.";
//                 SavingsAcc.Status := SavingsAcc.Status::Active;
//                 if SavingsAcc.Insert then
//                     SavingsAccountCreated := true;

//                 if SavingsAccountCreated then
//                     if BusinessAccount then begin
//                         SkyBusinessAccounts.Init;
//                         SkyBusinessAccounts."Member No" := Members."No.";
//                         SkyBusinessAccounts."Account No" := NewAcountNo;
//                         SkyBusinessAccounts.Status := SkyBusinessAccounts.Status::Active;
//                         SkyBusinessAccounts."Business Name" := AccountName;
//                         SkyBusinessAccounts."Business Location" := BusinessLocation;
//                         SkyBusinessAccounts."Application Date" := CurrentDatetime;
//                         SkyBusinessAccounts."Bussiness Code" := BusinessAccountCode;
//                         SkyBusinessAccounts.Insert;
//                     end;

//                 Commit;

//                 if SavingsAccountCreated then
//                     if TotoSavings then begin
//                         SeriesSetup.Get;
//                         SeriesSetup.TestField(SeriesSetup."Standing Order Nos.");
//                         NoSeriesMgt.InitSeries(SeriesSetup."Standing Order Nos.", StandingOrderHeader."No. Series", 0D, STONo, StandingOrderHeader."No. Series");

//                         StandingOrderHeader.Init;
//                         StandingOrderHeader."No." := STONo;
//                         StandingOrderHeader."Application Date" := Today;
//                         StandingOrderHeader."Created By" := UserId;
//                         UserSetUp.Reset;
//                         UserSetUp.SetRange(UserSetUp."User ID", UserId);
//                         if UserSetUp.FindFirst then begin
//                             StandingOrderHeader."Global Dimension 1 Code" := UserSetUp."Global Dimension 1 Code";
//                             StandingOrderHeader."Global Dimension 2 Code" := UserSetUp."Global Dimension 2 Code";
//                             StandingOrderHeader."Income Type" := StandingOrderHeader."income type"::Salary;
//                         end;
//                         StandingOrderHeader."Transaction Type" := 'STANDING ORDER';
//                         StandingOrderHeader."Source Account Type" := StandingOrderHeader."source account type"::Savings;
//                         StandingOrderHeader."Source Account No." := AccountNo;
//                         StandingOrderHeader.Validate("Source Account No.");
//                         StandingOrderHeader.Description := 'Auto-Portal STO on TOTO Junior Acct. opening';
//                         StandingOrderHeader.Amount := STOAmount;
//                         StandingOrderHeader.Status := StandingOrderHeader.Status::Approved;
//                         StandingOrderHeader."Effective/Start Date" := Today;
//                         Evaluate(Frequency, '1M');
//                         StandingOrderHeader."Frequency (Months)" := Frequency;
//                         StandingOrderHeader.Validate("Frequency (Months)");
//                         if StandingOrderHeader.Insert then
//                             STOInserted := true;

//                         StandingOrderLines.Reset;
//                         StandingOrderLines.SetRange("Document No.", STONo);
//                         if StandingOrderLines.FindFirst then
//                             StandingOrderLines.DeleteAll;

//                         StandingOrderLines.Init;
//                         StandingOrderLines."Destination Account Type" := StandingOrderLines."destination account type"::Internal;
//                         StandingOrderLines."Destination Account No." := NewAcountNo;
//                         StandingOrderLines."Document No." := STONo;
//                         StandingOrderLines.Amount := STOAmount;
//                         StandingOrderLines.Validate("Destination Account Type");
//                         StandingOrderLines.Validate("Destination Account No.");
//                         if StandingOrderLines.Insert then
//                             STOLinesInserted := true;
//                     end;

//                 if SavingsAccountCreated then
//                     if BusinessAccount then begin
//                         //Deposit Money
//                         JTemplate := 'RECEIPT';
//                         JBatch := 'SKYWORLD';
//                         Dim1 := SavingsAcc."Global Dimension 1 Code";
//                         Dim2 := SavingsAccounts."Global Dimension 2 Code";

//                         SaccoTrans.JournalInsert(JTemplate, JBatch, NewAcountNo, Today, Accttype::Savings, AccountNo, CopyStr('Business Account Opening', 1, 50), Balacctype::"G/L Account",
//                                                 '', ProductFactory."Minimum Amt B/s Accnt", NewAcountNo, '', TransType, Dim1, Dim2, true);

//                         SaccoTrans.JournalInsert(JTemplate, JBatch, NewAcountNo, Today, Accttype::Savings, NewAcountNo, CopyStr('Business Account Opening', 1, 50), Balacctype::"G/L Account",
//                                               '', ProductFactory."Minimum Amt B/s Accnt" * -1, NewAcountNo, '', TransType, Dim1, Dim2, true);

//                         SaccoTrans.PostJournal(JTemplate, JBatch);

//                     end;


//                 FName := Members."First Name";
//                 if FName = '' then
//                     FName := Members."Middle Name";
//                 if SavingsAccountCreated then
//                     Response := 'Dear ' + SkyMbanking.FirstName(FName) + ', your application for a ' + ProductFactory."Product Description" + ' has been completed successfully';
//             end;
//             if SavingsAccountCreated then
//                 ResponseMessage := 'Account Created Successfully'
//             else
//                 ResponseMessage := 'Error during created';
//         end;



//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('name');
//         //        LocalJsonTextWriter.WriteValue('name');
//         //        LocalJsonTextWriter.WriteEndObject;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetTransactionTypes("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         SkyPortalSetup: Record "Sky Portal Setup";
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Get Transaction Types';

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             MemberNo := SavingsAccounts."Member No.";
//         end;
//         Members.Get(MemberNo);

//         /*-------------------------------------------------------------------------------------*/

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         if Status = 'SUCCESS' then begin
//             //            LocalJsonTextWriter.WriteStartArray;
//             SkyPortalSetup.Reset;
//             if SkyPortalSetup.FindFirst then begin
//                 repeat
//                 //                    LocalJsonTextWriter.WriteStartObject;
//                 //                    LocalJsonTextWriter.WritePropertyName('transaction_code');
//                 //                    LocalJsonTextWriter.WriteValue(SkyPortalSetup.Code);
//                 //                    LocalJsonTextWriter.WritePropertyName('transaction_name');
//                 //                    LocalJsonTextWriter.WriteValue(Format(SkyPortalSetup."Transaction Type"));
//                 //                    LocalJsonTextWriter.WriteEndObject;
//                 until SkyPortalSetup.Next = 0;
//             end;

//             //            LocalJsonTextWriter.WriteEndArray;

//             ResponseMessage := 'Transaction Types Fetched Successfully';
//         end;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetTransactionLimits("Action": Text; Password: Text; Username: Text; TransactionType: Code[30]) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         SkyPortalSetup: Record "Sky Portal Setup";
//         AccountNo: Code[30];
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Get Transaction Types';

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             AccountNo := SavingsAccounts."No.";
//             MemberNo := SavingsAccounts."Member No.";
//         end;
//         Members.Get(MemberNo);

//         /*-------------------------------------------------------------------------------------*/

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         if Status = 'SUCCESS' then begin
//             //            LocalJsonTextWriter.WriteStartObject;
//             SkyPortalSetup.Reset;
//             SkyPortalSetup.SetRange(Code, TransactionType);
//             if SkyPortalSetup.FindFirst then begin
//                 //                LocalJsonTextWriter.WritePropertyName('transaction_code');
//                 //                LocalJsonTextWriter.WriteValue(SkyPortalSetup.Code);
//                 //                LocalJsonTextWriter.WritePropertyName('transaction_name');
//                 //                LocalJsonTextWriter.WriteValue(Format(SkyPortalSetup."Transaction Type"));

//                 //                LocalJsonTextWriter.WritePropertyName('transaction_limit');
//                 //                LocalJsonTextWriter.WriteValue(Format(SkyPortalSetup."Transaction Limit") + '.00');

//                 //                LocalJsonTextWriter.WritePropertyName('daily_limit');
//                 //                LocalJsonTextWriter.WriteValue(Format('0.00'));
//                 //                LocalJsonTextWriter.WritePropertyName('remaining_daily_amount');
//                 //                LocalJsonTextWriter.WriteValue(Format('0.00'));

//                 //                LocalJsonTextWriter.WritePropertyName('weekly_limit');
//                 //                LocalJsonTextWriter.WriteValue(Format('0.00'));
//                 //                LocalJsonTextWriter.WritePropertyName('remaining_weekly_amount');
//                 //                LocalJsonTextWriter.WriteValue(Format('0.00'));

//                 //                LocalJsonTextWriter.WritePropertyName('monthly_limit');
//                 //                LocalJsonTextWriter.WriteValue(Format('0.00'));
//                 //                LocalJsonTextWriter.WritePropertyName('remaining_monthly_amount');
//                 //                LocalJsonTextWriter.WriteValue(Format('0.00'));
//             end;
//             //            LocalJsonTextWriter.WriteEndObject;
//             ResponseMessage := 'Transaction Types Fetched Successfully';
//         end;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetSavingsAccountsProductCodes("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         AccountNo: Code[30];
//         ProductFactory: Record "Product Factory";
//         CanCreate: Text;
//         Msg: Text;
//         SkyMbanking: Codeunit "Sky Mbanking";
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Get Savings Account Product Codes';

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             AccountNo := SavingsAccounts."No.";
//             MemberNo := SavingsAccounts."Member No.";
//         end;
//         Members.Get(MemberNo);

//         CanCreate := 'FALSE';
//         Msg := 'Creation of Toto Junior is only applicable for members whose salary is processed through the SACCO';
//         if IsSalaryThroughFOSA(AccountNo) then begin
//             CanCreate := 'TRUE';
//             Msg := '';
//         end;

//         /*-------------------------------------------------------------------------------------*/

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         if Status = 'SUCCESS' then begin
//             //            LocalJsonTextWriter.WriteStartArray;
//             ProductFactory.Reset;
//             ProductFactory.SetFilter("Product ID", '%1|%2', '511', '513');
//             if ProductFactory.FindFirst then begin
//                 repeat
//                     if ProductFactory."Product ID" = '511' then begin
//                         CanCreate := 'TRUE';
//                         Msg := '';
//                     end;
//                 //                    LocalJsonTextWriter.WriteStartObject;
//                 //                    LocalJsonTextWriter.WritePropertyName('product_code');
//                 //                    LocalJsonTextWriter.WriteValue(ProductFactory."Product ID");
//                 //                    LocalJsonTextWriter.WritePropertyName('product_name');
//                 //                    LocalJsonTextWriter.WriteValue(ProductFactory."Product Description");
//                 //                    LocalJsonTextWriter.WritePropertyName('can_create');
//                 //                    LocalJsonTextWriter.WriteValue(CanCreate);
//                 //                    LocalJsonTextWriter.WritePropertyName('message');
//                 //                    LocalJsonTextWriter.WriteValue(Msg);
//                 //                    LocalJsonTextWriter.WriteEndObject;
//                 until ProductFactory.Next = 0;
//             end;
//             //            LocalJsonTextWriter.WriteEndArray;
//             ResponseMessage := 'Product Codes Fetched Successfully';
//         end;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetMobileLoanList2("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         MobileNo: Code[20];
//         Loans: Record Loans;
//         LoanProduct: Record "Product Factory";
//         SavAcc: Record "Savings Accounts";
//         MemberNo: Code[20];
//         MaxLoan: Decimal;
//         Cust: Record Members;
//         MobileLoanInstallments: Record "Mobile Loan Installments";
//         Success: Boolean;
//         Msg: Text;
//         LoanLimit: Decimal;
//         QualifiedAmt: Decimal;
//         TopUp: Decimal;
//         MinLoan: Decimal;
//         Salary: array[3] of Decimal;
//         SalDates: array[3] of Date;
//         LoanProductstoBridge: Record "Loan Products to Bridge";
//         SkipLoan: Boolean;
//         DepAcc: Record "Savings Accounts";
//         MaxCredit: Decimal;
//         SalaryThroughFosa: Boolean;
//         SmallestSal: Decimal;
//         CurrLoanBal: Text;
//         LoanTopUP: Record Loans;
//         UserCanApply: Boolean;
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         AccountNo: Code[30];
//         GeneralSetUp: Record "General Set-Up";
//         SkyMbanking: Codeunit "Sky Mbanking";
//         SavingsAccounts: Record "Savings Accounts";
//     begin
//         GeneralSetUp.Get();
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Get Mobile Loan List';


//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             MemberNo := SavingsAccounts."Member No.";
//         end;

//         Members.Get('MB0000001');

//         /*-------------------------------------------------------------------------------------*/

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         SavAcc.Reset;
//         SavAcc.SetRange(SavAcc."No.", '505MB00000010');
//         SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
//         if SavAcc.FindFirst then begin
//             //            LocalJsonTextWriter.WriteStartArray;
//             MemberNo := SavAcc."Member No.";
//             Members.Get(MemberNo);

//             LoanProduct.Reset;
//             LoanProduct.SetCurrentkey("Sort Order");
//             LoanProduct.SetRange("Product Class Type", LoanProduct."product class type"::Loan);
//             LoanProduct.SetRange(AvailableOnMobile, true);
//             if LoanProduct.Find('-') then begin
//                 Response := '<Loans>';
//                 repeat
//                     MaxLoan := 0;
//                     MinLoan := LoanProduct."Mobile Min. Loan Amount";
//                     Msg := '';
//                     if LoanProduct."Product ID" = '136' then begin
//                         SkyMbanking.DividendAdvanceChecks(SavAcc."Member No.", MinLoan, MaxLoan, UserCanApply, Msg);

//                     end;
//                     if LoanProduct.Category = LoanProduct.Category::"FOSA Loan" then begin
//                         if LoanProduct."Product ID" = '126' then begin
//                             SkyMbanking.MBoostaAppraisal(SavAcc."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp);//here1
//                             MaxLoan := QualifiedAmt;
//                         end else begin
//                             if LoanProduct."Salary Loans" then begin
//                                 SkyMbanking.SalaryMobileLoanAppraisal(SavAcc."No.", Success, Msg, LoanLimit, QualifiedAmt, TopUp, LoanProduct."Product ID", Salary, SalDates);
//                                 MaxLoan := QualifiedAmt;
//                                 //MESSAGE(FORMAT(TopUp));
//                                 if TopUp > 0 then begin
//                                     if LoanProduct."Min. Net after Topup" > (MaxLoan - TopUp) then begin
//                                         Message('Maxloan: ' + Format(MaxLoan));
//                                         MaxLoan := 0;
//                                         Msg := 'Net disbursed after topup should be above KES ' + Format(LoanProduct."Min. Net after Topup");
//                                     end;
//                                 end;
//                             end;
//                         end;
//                     end;

//                     if LoanProduct.Category = LoanProduct.Category::"BOSA Loan" then begin
//                         MaxLoan := LoanProduct."Mobile Max. Loan Amount";
//                         MaxCredit := 0;
//                         DepAcc.Reset;
//                         DepAcc.SetRange("Member No.", SavAcc."Member No.");
//                         DepAcc.SetRange("Product Category", DepAcc."Product Category"::"BOSA Deposits");
//                         if DepAcc.FindFirst then begin
//                             DepAcc.CalcFields("Balance (LCY)");
//                             MaxCredit := DepAcc."Balance (LCY)" * LoanProduct."Ordinary Deposits Multiplier";
//                             if MaxCredit <= 0 then
//                                 MaxCredit := DepAcc."Balance (LCY)";
//                         end;
//                         if MaxLoan > MaxCredit then
//                             MaxLoan := MaxCredit;

//                         if LoanProduct."Requires Salary Processing" then begin
//                             SalaryThroughFosa := false;
//                             SkyMbanking.GetSalaryEntries(SavAcc."No.", SalDates, SmallestSal, Salary, SalaryThroughFosa);
//                             if not SalaryThroughFosa then begin
//                                 MaxLoan := 0;
//                                 Msg := ChannelThroughFosa;
//                             end;

//                         end;
//                     end;


//                     if MaxLoan = 0 then
//                         MinLoan := 0;

//                     Cust.Get(MemberNo);

//                     CurrLoanBal := '';
//                     if LoanProduct."Product ID" = '119' then begin
//                         LoanTopUP.Reset;
//                         LoanTopUP.SetRange("Member No.", MemberNo);
//                         LoanTopUP.SetRange("Loan Product Type", '119');
//                         LoanTopUP.SetFilter("Outstanding Balance", '>0');
//                         if LoanTopUP.FindFirst then begin
//                             LoanTopUP.CalcFields("Outstanding Balance", "Outstanding Interest");
//                             if LoanTopUP."Outstanding Interest" < 0 then
//                                 LoanTopUP."Outstanding Interest" := LoanTopUP."Outstanding Interest";
//                             CurrLoanBal := ' (Loan Bal: ' + Format(LoanTopUP."Outstanding Balance" + LoanTopUP."Outstanding Interest") + ')';
//                         end;
//                     end;

//                     MaxLoan := ROUND(MaxLoan, 1000, '<');
//                     MinLoan := ROUND(MinLoan, 100, '<');
//                     if MaxLoan > LoanProduct."Mobile Max. Loan Amount" then
//                         MaxLoan := LoanProduct."Mobile Max. Loan Amount";

//                     SkipLoan := false;
//                     if LoanProduct."Available To Member" <> '' then
//                         if LoanProduct."Available To Member" <> MemberNo then
//                             SkipLoan := true;


//                     //                    LocalJsonTextWriter.WriteStartObject;
//                     if (not SkipLoan) and ((LoanProduct."Restrict to Emp. Code" = '') or (LoanProduct."Restrict to Emp. Code" = Cust."Employer Code")) then begin

//                         //                        LocalJsonTextWriter.WritePropertyName('product_code');
//                         //                        LocalJsonTextWriter.WriteValue(LoanProduct."Product ID");
//                         //                        LocalJsonTextWriter.WritePropertyName('product_name');
//                         //                        LocalJsonTextWriter.WriteValue(LoanProduct."USSD Product Name");

//                         //                        LocalJsonTextWriter.WritePropertyName('user_can_apply');
//                         if MaxLoan > 0 then
//                             //                            LocalJsonTextWriter.WriteValue('TRUE')
//                             else begin
//                                 //                            LocalJsonTextWriter.WriteValue('FALSE');
//                             end;

//                         //                        LocalJsonTextWriter.WritePropertyName('message');
//                         //                        LocalJsonTextWriter.WriteValue(Msg);

//                         //                        LocalJsonTextWriter.WritePropertyName('source');
//                         //                        LocalJsonTextWriter.WriteValue(Format(LoanProduct.Category));

//                         //                        LocalJsonTextWriter.WritePropertyName('requires_guarantors');
//                         if LoanProduct."Mobile Loan Req. Guar." then
//                             //                            LocalJsonTextWriter.WriteValue('TRUE')
//                             else
//                             //                            LocalJsonTextWriter.WriteValue('FALSE');

//                             //                        LocalJsonTextWriter.WritePropertyName('requires_purpose');
//                             if LoanProduct."Requires Purpose" then
//                                 //                            LocalJsonTextWriter.WriteValue('TRUE')
//                                 else
//                                 //                            LocalJsonTextWriter.WriteValue('FALSE');

//                                 //                        LocalJsonTextWriter.WritePropertyName('requires_purpose');
//                                 if LoanProduct."Requires Branch" then
//                                     //                            LocalJsonTextWriter.WriteValue('TRUE')
//                                     else
//                                     //                            LocalJsonTextWriter.WriteValue('FALSE');

//                                     //                        LocalJsonTextWriter.WritePropertyName('installments_type');
//                                     //                        LocalJsonTextWriter.WriteValue(Format(LoanProduct."Mobile Installments Type"));

//                                     //                        LocalJsonTextWriter.WritePropertyName('installments');
//                                     //                        LocalJsonTextWriter.WriteStartArray;
//                                     if LoanProduct."Mobile Installments Type" = LoanProduct."mobile installments type"::None then begin
//                                         //                            LocalJsonTextWriter.WriteStartObject;
//                                         //                            LocalJsonTextWriter.WritePropertyName('minimum_amount');
//                                         //                            LocalJsonTextWriter.WriteValue(Format(LoanProduct."Minimum Loan Amount"));
//                                         //                            LocalJsonTextWriter.WritePropertyName('maximum_amount');
//                                         //                            LocalJsonTextWriter.WriteValue(Format(LoanProduct."Maximum Loan Amount"));
//                                         //                            LocalJsonTextWriter.WritePropertyName('minimum_instalments');
//                                         //                            LocalJsonTextWriter.WriteValue(Format(LoanProduct."Ordinary Default Intallments"));
//                                         //                            LocalJsonTextWriter.WritePropertyName('maximum_instalments');
//                                         //                            LocalJsonTextWriter.WriteValue(Format(LoanProduct."Ordinary Default Intallments"));
//                                         //                            LocalJsonTextWriter.WriteEndObject;
//                                     end;

//                         if LoanProduct."Mobile Installments Type" = LoanProduct."mobile installments type"::Input then begin
//                             //                            LocalJsonTextWriter.WriteStartObject;
//                             //                            LocalJsonTextWriter.WritePropertyName('minimum_amount');
//                             //                            LocalJsonTextWriter.WriteValue(Format(LoanProduct."Minimum Loan Amount"));
//                             //                            LocalJsonTextWriter.WritePropertyName('maximum_amount');
//                             //                            LocalJsonTextWriter.WriteValue(Format(LoanProduct."Maximum Loan Amount"));
//                             //                            LocalJsonTextWriter.WritePropertyName('minimum_instalments');
//                             //                            LocalJsonTextWriter.WriteValue(Format(LoanProduct."Min. Mobile Installments"));
//                             //                            LocalJsonTextWriter.WritePropertyName('maximum_instalments');
//                             //                            LocalJsonTextWriter.WriteValue(Format(LoanProduct."Max. Mobile Installments"));
//                             //                            LocalJsonTextWriter.WriteEndObject;
//                         end;

//                         //                       IF LoanProduct."Mobile Installments Type" = LoanProduct."Mobile Installments Type"::Preset THEN BEGIN
//                         //
//                         //                             MobileLoanInstallments.RESET;
//                         //                             MobileLoanInstallments.SETRANGE(Product,LoanProduct."Product ID");
//                         //                             IF MobileLoanInstallments.FINDFIRST THEN BEGIN
//                         //                                 Response += '<PresetInstallments>';
//                         //                                 REPEAT
//                         //
//                         //                                     Response += '<Installment Id="'+FORMAT(MobileLoanInstallments.Installments)+'" Label="'+MobileLoanInstallments.Caption+'">';
//                         //
//                         //                                         Response += '<Qualification>';
//                         //                                             Response += '<Minimum>'+FORMAT(MinLoan)+'</Minimum>';
//                         //                                             IF LoanProduct.Category = LoanProduct.Category::"BOSA Loan" THEN
//                         //                                                 Response += '<Maximum>'+FORMAT(MaxLoan)+'</Maximum>'
//                         //                                             ELSE
//                         //                                                 Response += '<Maximum>'+FORMAT(MaxLoan)+'</Maximum>';
//                         //                                         Response += '</Qualification>';
//                         //
//                         //                                     Response += '</Installment>';
//                         //
//                         //                                 UNTIL MobileLoanInstallments.NEXT=0;
//                         //                                 Response += '</PresetInstallments>';
//                         //                             END;
//                         //
//                         //                       END;
//                         //                        LocalJsonTextWriter.WriteEndArray;

//                         //                        LocalJsonTextWriter.WritePropertyName('number_of_guarantors');
//                         //                        LocalJsonTextWriter.WriteValue(Format(LoanProduct."Mobile Min. Guarantors"));

//                         //                        LocalJsonTextWriter.WritePropertyName('interest_rate');
//                         //                        LocalJsonTextWriter.WriteValue(Format(LoanProduct."Interest Rate (Max.)") + '%');

//                         //                        LocalJsonTextWriter.WritePropertyName('minimum_qualification');
//                         //                        LocalJsonTextWriter.WriteValue(Format(MinLoan));

//                         //                        LocalJsonTextWriter.WritePropertyName('maximum_qualification');
//                         //                        LocalJsonTextWriter.WriteValue(Format(MaxLoan));


//                         //                        LocalJsonTextWriter.WritePropertyName('requires_terms_and_conditions');
//                         if LoanProduct."Requires TnC" then
//                             //                            LocalJsonTextWriter.WriteValue('TRUE')
//                             else
//                             //                            LocalJsonTextWriter.WriteValue('FALSE');

//                             //                        LocalJsonTextWriter.WritePropertyName('shows_mobile_qualification');
//                             if LoanProduct."Shows Mobile Qualification" then
//                                 //                            LocalJsonTextWriter.WriteValue('TRUE')
//                                 else
//                                 //                            LocalJsonTextWriter.WriteValue('FALSE');


//                                 //                        LocalJsonTextWriter.WritePropertyName('requires_payslip_pin');
//                                 if LoanProduct."Requires Payslip PIN" then
//                                     //                            LocalJsonTextWriter.WriteValue('TRUE')
//                                     else
// //                            LocalJsonTextWriter.WriteValue('FALSE');
//                     end;
// //                    LocalJsonTextWriter.WriteEndObject;

//                 until LoanProduct.Next = 0;
//                     end;
// //            LocalJsonTextWriter.WriteEndArray;
//         end;


//                 //        LocalJsonTextWriter.WritePropertyName('title');
//                 //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//                 //        LocalJsonTextWriter.WritePropertyName('message');
//                 //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//                 //        LocalJsonTextWriter.WriteEndObject;

//                 //Payload := LocalStringBuilder.ToString;

//                 /*-------------------------------------------------------------------------------------*/
//                 Response := GenerateJSONResponse(Action, Status, Payload, true);

//             end;


//     procedure FormatDateToMonth(month: Integer) MonthText: Text
//     var
//         FormatedMonth: Text;
//     begin

//         if month = 1 then FormatedMonth := 'January';
//         if month = 2 then FormatedMonth := 'February';
//         if month = 3 then FormatedMonth := 'March';
//         if month = 4 then FormatedMonth := 'April';
//         if month = 5 then FormatedMonth := 'May';
//         if month = 6 then FormatedMonth := 'June';
//         if month = 7 then FormatedMonth := 'July';
//         if month = 8 then FormatedMonth := 'August';
//         if month = 9 then FormatedMonth := 'Septtember';
//         if month = 10 then FormatedMonth := 'October';
//         if month = 11 then FormatedMonth := 'November';
//         if month = 12 then FormatedMonth := 'December';


//         MonthText := FormatedMonth;
//     end;

//     local procedure IsSalaryThroughFOSA(AccountNo: Code[30]): Boolean
//     var
//         SkyMbanking: Codeunit "Sky Mbanking";
//         SalDates: array[3] of Date;
//         SmallestSal: Decimal;
//         Salary: array[3] of Decimal;
//         SalaryThroughFosa: Boolean;
//     begin

//         SkyMbanking.GetSalaryEntries(AccountNo, SalDates, SmallestSal, Salary, SalaryThroughFosa);
//         if SmallestSal > 0 then
//             exit(true)
//         else
//             exit(false);
//     end;


//     procedure GetDelegateComplaintsCategories("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         ComplaintCategories: Record "Complaint Categories";
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Get Complaints Categories';

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             MemberNo := SavingsAccounts."Member No.";
//             Members.Get(MemberNo);
//         end;


//         /*-------------------------------------------------------------------------------------*/

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         if Status = 'SUCCESS' then begin
//             //            LocalJsonTextWriter.WriteStartArray;
//             ComplaintCategories.Reset;
//             if ComplaintCategories.FindFirst then begin
//                 repeat
//                 //                    LocalJsonTextWriter.WriteStartObject;
//                 //                    LocalJsonTextWriter.WritePropertyName('complaint_category');
//                 //                    LocalJsonTextWriter.WriteValue(ComplaintCategories."Complaint Category");
//                 //                    LocalJsonTextWriter.WriteEndObject;
//                 until ComplaintCategories.Next = 0;
//             end;
//             //            LocalJsonTextWriter.WriteEndArray;

//             ResponseMessage := 'Complaints Categories Fetched Successfully';
//         end else begin
//             //            LocalJsonTextWriter.WriteStartArray;
//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('complaint_category');
//             //            LocalJsonTextWriter.WriteValue('');
//             //            LocalJsonTextWriter.WriteEndObject;
//             //            LocalJsonTextWriter.WriteEndArray;
//         end;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure ValidateDelegateMeetingAttendee("Action": Text; Password: Text; Username: Text; IdentifierType: Code[30]; Identifier: Code[30]) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         AccountNo: Code[30];
//         ProductFactory: Record "Product Factory";
//         CanCreate: Text;
//         Msg: Text;
//         SkyMbanking: Codeunit "Sky Mbanking";
//         DelegateMemberss: Record "Delegate Members";
//         AtendeeMemberNo: Code[30];
//         AtendeeRegionCode: Code[30];
//         DelegateRegionCode: Code[30];
//         AtendeeMember: Record Members;
//         AtendeeValid: Text;
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Validate Delegate Meeting Atendee';

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             AccountNo := SavingsAccounts."No.";
//             MemberNo := SavingsAccounts."Member No.";
//             Members.Get(MemberNo);
//         end;


//         if Status = 'SUCCESS' then begin
//             if IdentifierType = 'ID_NUMBER' then begin
//                 AtendeeMember.Reset;
//                 AtendeeMember.SetRange("ID No.", Identifier);
//                 if AtendeeMember.FindFirst then begin
//                     AtendeeMemberNo := AtendeeMemberNo;
//                     AtendeeRegionCode := AtendeeMember."Region Code";
//                 end;
//             end;
//             if IdentifierType = 'PAYROLL_NUMBER' then begin
//                 AtendeeMember.Reset;
//                 AtendeeMember.SetRange("Payroll/Staff No.", Identifier);
//                 if AtendeeMember.FindFirst then begin
//                     AtendeeMemberNo := AtendeeMemberNo;
//                     AtendeeRegionCode := AtendeeMember."Region Code";
//                 end;
//             end;
//             if IdentifierType = 'MEMBER_NUMBER' then begin
//                 AtendeeMember.Reset;
//                 AtendeeMember.SetRange("No.", Identifier);
//                 if AtendeeMember.FindFirst then begin
//                     AtendeeMemberNo := AtendeeMemberNo;
//                     AtendeeRegionCode := AtendeeMember."Region Code";
//                 end;
//             end;

//             DelegateMemberss.Reset;
//             DelegateMemberss.SetRange("Delegate MNO.", MemberNo);
//             DelegateMemberss.SetRange(Retired, false);
//             DelegateMemberss.SetFilter("Electoral Zone", '<>ALL');
//             if DelegateMemberss.FindFirst then begin
//                 if DelegateMemberss.Code = AtendeeRegionCode then
//                     AtendeeValid := 'TRUE'
//                 else
//                     AtendeeValid := 'FALSE';
//             end;
//         end;
//         /*-------------------------------------------------------------------------------------*/

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         if Status = 'SUCCESS' then begin

//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('attendee_valid');
//             //            LocalJsonTextWriter.WriteValue(AtendeeValid);
//             //            LocalJsonTextWriter.WriteEndObject;

//             ResponseMessage := 'Success';
//         end;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;

//     local procedure RemoveMeeting(MeetingCode: Code[50])
//     var
//         DelegatesHeader: Record "Delegates Minutes Header";
//         DelegatesMonthlyReturns: Record "Delegates Monthly Returns";
//         DelegatesReturnsLines: Record "Delegates Returns Lines";
//         ComplainandRemarks: Record "Complain and Remarks";
//         DelegatesMeetingAttendees: Record "Delegates Meeting Attendees";
//     begin
//         DelegatesHeader.Reset;
//         DelegatesHeader.SetRange(Code, MeetingCode);
//         if DelegatesHeader.FindFirst then
//             DelegatesHeader.Delete;

//         DelegatesMonthlyReturns.Reset;
//         DelegatesMonthlyReturns.SetRange("Header No", MeetingCode);
//         if DelegatesMonthlyReturns.FindSet then
//             DelegatesMonthlyReturns.DeleteAll;

//         DelegatesMeetingAttendees.Reset;
//         DelegatesMeetingAttendees.SetRange("Header No", MeetingCode);
//         if DelegatesMeetingAttendees.FindSet then
//             DelegatesMeetingAttendees.DeleteAll;

//         ComplainandRemarks.Reset;
//         ComplainandRemarks.SetRange("Header No", MeetingCode);
//         if ComplainandRemarks.FindSet then
//             ComplainandRemarks.DeleteAll;

//         DelegatesReturnsLines.Reset;
//         DelegatesReturnsLines.SetRange("Header No", MeetingCode);
//         if DelegatesReturnsLines.FindSet then
//             DelegatesReturnsLines.DeleteAll;

//         Message('Meeting %1 removed successfully!', MeetingCode);
//     end;

//     local procedure GetMonthName(Month: Integer) FormatedMonth: Text
//     begin
//         if Month = 1 then FormatedMonth := 'Jan';
//         if Month = 2 then FormatedMonth := 'Feb';
//         if Month = 3 then FormatedMonth := 'Mar';
//         if Month = 4 then FormatedMonth := 'Apr';
//         if Month = 5 then FormatedMonth := 'May';
//         if Month = 6 then FormatedMonth := 'June';
//         if Month = 7 then FormatedMonth := 'July';
//         if Month = 8 then FormatedMonth := 'Aug';
//         if Month = 9 then FormatedMonth := 'Sept';
//         if Month = 10 then FormatedMonth := 'Oct';
//         if Month = 11 then FormatedMonth := 'Nov';
//         if Month = 12 then FormatedMonth := 'Dec';
//     end;


//     procedure GetDelegateMeetingQuorum("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         ComplaintCategories: Record "Complaint Categories";
//         PortalSetUp: Record "Portal SetUp";
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Get  Delegate Meeting Quorum';

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             MemberNo := SavingsAccounts."Member No.";
//             Members.Get(MemberNo);
//         end;


//         /*-------------------------------------------------------------------------------------*/

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         if Status = 'SUCCESS' then begin
//             PortalSetUp.Reset;
//             if PortalSetUp.FindFirst then begin
//                 //                LocalJsonTextWriter.WriteStartObject;
//                 //                LocalJsonTextWriter.WritePropertyName('meeting_quorum');
//                 //                LocalJsonTextWriter.WriteValue(PortalSetUp."Delegate Quorum");
//                 //                LocalJsonTextWriter.WriteEndObject;
//             end;
//             ResponseMessage := 'Complaints Categories Fetched Successfully';
//         end;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure CreateVirtualMemberApplication("Action": Text; Password: Text; Username: Text; Records: Text; IPRSFullNames: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         MemberNumber: Code[30];
//         SalesSetup: Record "Sales & Receivables Setup";
//         // NosMngtSet: Codeunit NoSeriesManagement;
//         HeaderNo: Code[30];
//         JObject: code[100];//dotnet JObject;
//         JSONString: Text;
//         CorrespondencePayload: code[100];//dotnet JObject;
//         MemberNo: Code[30];
//         HMember: Record Members;
//         SkyMbanking: Codeunit "Sky Mbanking";
//         CurrentDateTimeText: Text;
//         msg: Text;
//         SkyVirtualMember: Record "Sky Virtual Member";
//         FullName: Text;
//         PhoneNumber: Text;
//         Email: Text;
//         Gender: Code[10];
//         DateOfBirth: Text;
//         IdentifierType: Code[40];
//         IdentifierNumber: Text;
//         HomeAddress: Text;
//         RecruiterIdentifierType: Code[40];
//         RecruiterIdentifier: Text;
//         DateOfBirthD: Date;
//         SavingsAccounts: Record "Savings Accounts";
//         GenderOption: Option "  ",Male,Female;
//         IDNumber: Code[20];
//         PassportNumber: Code[20];
//         RecruiterName: Text;
//         RecruiterMemberNumber: Code[10];
//         CitizenShip: Code[10];
//         MemberApplication: Record "Member Application";
//         MemberRegister: Record Members;
//         service_number: Text;
//         id_number: Text;
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Member Application';
//         ResponseMessage := 'Member Application successful';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Invalid Username or Password';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             MemberNumber := Members."No.";
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;



//         if Status = 'SUCCESS' then begin
//             ArrayString := Records;
//             if ArrayString <> '' then
//                 CorrespondencePayload := JObject.Parse(Format(ArrayString));


//             FullName := CorrespondencePayload.SelectToken('full_names').ToString;
//             PhoneNumber := CorrespondencePayload.SelectToken('phone_number').ToString;
//             Email := CorrespondencePayload.SelectToken('email_address').ToString;
//             Gender := CorrespondencePayload.SelectToken('gender').ToString;
//             DateOfBirth := CorrespondencePayload.SelectToken('date_of_birth').ToString;
//             PassportNumber := CorrespondencePayload.SelectToken('passport_number').ToString;
//             HomeAddress := CorrespondencePayload.SelectToken('home_address').ToString;
//             service_number := CorrespondencePayload.SelectToken('service_number').ToString;
//             id_number := CorrespondencePayload.SelectToken('id_number').ToString;
//             RecruiterIdentifierType := CorrespondencePayload.SelectToken('recruiter_identifier_type').ToString;
//             RecruiterIdentifier := CorrespondencePayload.SelectToken('recruiter_identifier').ToString;
//             CitizenShip := CorrespondencePayload.SelectToken('citizenship').ToString;
//             Clear(CorrespondencePayload);


//             SkyVirtualMember.Reset;
//             SkyVirtualMember.SetRange("ID Number", id_number);
//             if SkyVirtualMember.FindFirst then begin
//                 ResponseMessage := 'ID Number is already in application process';
//                 Status := 'FAILED';
//             end;

//             MemberApplication.Reset;
//             MemberApplication.SetRange("ID No.", id_number);
//             if MemberApplication.FindFirst then begin
//                 ResponseMessage := 'ID Number is already in application process';
//                 Status := 'FAILED';
//             end;


//             memberHandler.Reset;
//             memberHandler.SetRange("Member Number", MemberNumber);
//             if memberHandler.FindFirst then begin
//                 if memberHandler.Status = memberHandler.Status::Inactive then begin
//                     ResponseMessage := 'This member cannot push the member applicant details';
//                     Status := 'FAILED';
//                 end;
//             end else begin
//                 ResponseMessage := 'This member cannot push the member applicant details';
//                 Status := 'FAILED';
//             end;


//             MemberRegister.Reset;
//             MemberRegister.SetRange("ID No.", id_number);
//             if MemberRegister.FindFirst then begin
//                 ResponseMessage := 'ID Number is already registered as a member';
//                 Status := 'FAILED';
//             end;

//             DateOfBirthD := CreateDate(DateOfBirth);
//             if Gender = 'MALE' then GenderOption := Genderoption::Male;
//             if Gender = 'FEMALE' then GenderOption := Genderoption::Female;


//             if RecruiterIdentifierType = 'ID_NUMBER' then begin
//                 Members.Reset;
//                 Members.SetRange("ID No.", RecruiterIdentifier);
//                 if Members.FindFirst then begin
//                     RecruiterName := Members.Name;
//                     RecruiterMemberNumber := Members."No.";
//                 end;
//             end;

//             if RecruiterIdentifierType = 'MEMBER_NUMBER' then begin
//                 Members.Reset;
//                 Members.SetRange("No.", RecruiterIdentifier);
//                 if Members.FindFirst then begin
//                     RecruiterName := Members.Name;
//                     RecruiterMemberNumber := Members."No.";
//                 end;
//             end;
//         end;

//         if Status = 'SUCCESS' then begin
//             NosMngtSet.InitSeries('M_PAPP', SkyVirtualMember."No. Series", 0D, HeaderNo, SkyVirtualMember."No. Series");

//             SkyVirtualMember.Init;
//             SkyVirtualMember."No." := HeaderNo;
//             SkyVirtualMember.Telephone := PhoneNumber;
//             SkyVirtualMember.Names := FullName;
//             SkyVirtualMember."Date Of Birth" := DateOfBirthD;
//             SkyVirtualMember.Gender := GenderOption;
//             SkyVirtualMember.Citizenship := '';
//             SkyVirtualMember."Entry Date" := Today;
//             SkyVirtualMember."Entry Time" := Time;
//             SkyVirtualMember."Reffered By" := RecruiterIdentifier;
//             SkyVirtualMember."Employer Name" := '';
//             SkyVirtualMember."Payroll Number" := '';
//             SkyVirtualMember.Email := Email;
//             SkyVirtualMember."ID Number" := id_number;
//             SkyVirtualMember."Service Number" := service_number;
//             SkyVirtualMember."Referer Member No" := RecruiterMemberNumber;
//             SkyVirtualMember.Address := HomeAddress;
//             SkyVirtualMember."Passport Number" := PassportNumber;
//             SkyVirtualMember.Citizenship := CitizenShip;
//             SkyVirtualMember."Source Application" := SkyVirtualMember."source application"::"Members Portal";
//             SkyVirtualMember."Pushed by Member No" := MemberNumber;
//             SkyVirtualMember."Name on IPRS" := IPRSFullNames;
//             SkyVirtualMember.Insert;

//             ResponseMessage := 'Member registration application has been submitted successfully';
//         end;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('name');
//         //        LocalJsonTextWriter.WriteValue('name');
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetCountries("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         SkyPortalSetup: Record "Sky Portal Setup";
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Get country /Region';

//         // IF COPYSTR(Username,1,3) = '254' THEN Username := '+'+Username;
//         // SkyAuth.RESET;
//         // IF COPYSTR(Username,1,4) = '+254' THEN
//         //   SkyAuth.SETRANGE("Mobile No.",Username)
//         // ELSE
//         //  SkyAuth.SETRANGE(SkyAuth.Username,Username);
//         //
//         // SkyAuth.SETRANGE(SkyAuth.Password,GetPassFromUserName(Username,Password));
//         // IF NOT SkyAuth.FINDFIRST THEN  BEGIN
//         //    ResponseMessage := 'Username or Password is incorrect';
//         //    Status :='FAILED';
//         // END ELSE BEGIN
//         //  ResponseMessage := 'Country';
//         if SkyAuth.FindFirst then begin
//             Status := 'SUCCESS';
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             MemberNo := SavingsAccounts."Member No.";
//         end;
//         // Country.GET( "Code");
//         /*-------------------------------------------------------------------------------------*/
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         if Status = 'SUCCESS' then begin
//             //            LocalJsonTextWriter.WriteStartArray;
//             Country.Reset;
//             if Country.FindFirst then begin
//                 repeat
//                 //                    LocalJsonTextWriter.WriteStartObject;
//                 //                    LocalJsonTextWriter.WritePropertyName('country_code');
//                 //                    LocalJsonTextWriter.WriteValue(Country.Code);
//                 //                    LocalJsonTextWriter.WritePropertyName('name');
//                 //                    LocalJsonTextWriter.WriteValue(Format(Country.Code));
//                 //                    LocalJsonTextWriter.WriteEndObject;
//                 until Country.Next = 0;
//             end;

//             //            LocalJsonTextWriter.WriteEndArray;

//             ResponseMessage := 'Name of the country';
//         end else begin
//             //            LocalJsonTextWriter.WriteStartArray;

//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('country_code');
//             //            LocalJsonTextWriter.WriteValue('');
//             //            LocalJsonTextWriter.WritePropertyName('name');
//             //            LocalJsonTextWriter.WriteValue(Format(''));
//             //            LocalJsonTextWriter.WriteEndObject;

//             //            LocalJsonTextWriter.WriteEndArray;
//         end;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetPortalFeatures() Response: Text
//     var
//         PortalEndpoints: Record "Portal Endpoints";
//     begin
//         Response := '<FEATURES>';
//         PortalEndpoints.Reset;
//         if PortalEndpoints.FindSet then begin
//             repeat
//                 Response +=
//                 '<FEATURE NAME="' + PortalEndpoints.Name +
//                 '" ENABLED="' + Format(PortalEndpoints.Enabled) +
//                 '" PASSWORD_VERIFICATION="' + Format(PortalEndpoints."Password Verification") +
//                 '" OTP_VERIFICATION="' + Format(PortalEndpoints."OTP Verification") + '"/>';
//             until PortalEndpoints.Next = 0;
//         end;
//         Response += '</FEATURES>';
//     end;


//     procedure GetMobileLoanList("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SavingsAccounts: Record "Savings Accounts";
//         MemberDetails: Record Members;
//         SkyAuth: Record "Sky USSD Auth";
//         MemberNo: Code[30];
//         AccountNo: Code[30];
//         Members: Record Members;
//         SkyMbanking: Codeunit "Sky Mbanking";
//         DimensionValue: Record "Dimension Value";
//         BranchName: Text;
//         LoanProduct: Record "Product Factory";
//         MaxLoan: Decimal;
//         MinLoan: Decimal;
//         Msg: Text;
//         UserCanApply: Boolean;
//         Success: Boolean;
//         LoanLimit: Decimal;
//         TopUp: Decimal;
//         Salary: array[3] of Decimal;
//         SalDates: array[3] of Date;
//         MaxCredit: Decimal;
//         SalaryThroughFosa: Boolean;
//         SmallestSal: Decimal;
//         Cust: Record Members;
//         CurrLoanBal: Text;
//         LoanTopUP: Record Loans;
//         SkipLoan: Boolean;
//         MobileLoanInstallments: Record "Mobile Loan Installments";
//         MobileGuarantorsSetup: Record "Mobile Guarantors Setup";
//         QualifiedAmt: Decimal;
//         DepAcc: Record "Savings Accounts";
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         ResponseTitle := 'Get Mobile Loan List';
//         ResponseMessage := 'Loan List Fetched Successfully';


//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             AccountNo := SkyAuth."Account No.";
//             Status := 'SUCCESS';
//         end;

//         if Status = 'SUCCESS' then begin
//             if SavingsAccounts.Get(AccountNo) then begin
//                 MemberNo := SavingsAccounts."Member No.";
//             end else begin
//                 ResponseMessage := 'Member Not Found';
//                 Status := 'FAILED';
//             end;
//         end;


//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartArray;
//         if Status = 'SUCCESS' then begin
//             LoanProduct.Reset;
//             LoanProduct.SetCurrentkey("Sort Order");
//             LoanProduct.SetRange("Product Class Type", LoanProduct."product class type"::Loan);
//             LoanProduct.SetRange(AvailableOnMobile, true);
//             if LoanProduct.FindSet then begin

//                 repeat

//                     MaxLoan := 0;
//                     MinLoan := LoanProduct."Mobile Min. Loan Amount";
//                     Msg := '';
//                     if LoanProduct."Product ID" = '136' then begin
//                         SkyMbanking.DividendAdvanceChecks(MemberNo, MinLoan, MaxLoan, UserCanApply, Msg);
//                     end;
//                     if LoanProduct.Category = LoanProduct.Category::"FOSA Loan" then begin
//                         if LoanProduct."Product ID" = '126' then begin
//                             SkyMbanking.MBoostaAppraisal(AccountNo, Success, Msg, LoanLimit, QualifiedAmt, TopUp);//here1
//                             MaxLoan := QualifiedAmt;
//                         end
//                         else begin
//                             if LoanProduct."Salary Loans" then begin
//                                 SkyMbanking.SalaryMobileLoanAppraisal(AccountNo, Success, Msg, LoanLimit, QualifiedAmt, TopUp, LoanProduct."Product ID", Salary, SalDates);
//                                 MaxLoan := QualifiedAmt;
//                                 //MESSAGE(FORMAT(TopUp));
//                                 if TopUp > 0 then begin
//                                     if LoanProduct."Min. Net after Topup" > (MaxLoan - TopUp) then begin
//                                         Message('Maxloan: ' + Format(MaxLoan));
//                                         MaxLoan := 0;
//                                         Msg := 'Net disbursed after topup should be above KES ' + Format(LoanProduct."Min. Net after Topup");
//                                     end;
//                                 end;

//                             end;
//                         end;
//                     end;

//                     if LoanProduct.Category = LoanProduct.Category::"BOSA Loan" then begin
//                         MaxLoan := LoanProduct."Mobile Max. Loan Amount";
//                         MaxCredit := 0;
//                         DepAcc.Reset;
//                         DepAcc.SetRange("Member No.", MemberNo);
//                         DepAcc.SetRange("Product Category", DepAcc."Product Category"::"BOSA Deposits");
//                         if DepAcc.FindFirst then begin
//                             DepAcc.CalcFields("Balance (LCY)");
//                             MaxCredit := DepAcc."Balance (LCY)" * LoanProduct."Ordinary Deposits Multiplier";
//                             if MaxCredit <= 0 then
//                                 MaxCredit := DepAcc."Balance (LCY)";
//                         end;
//                         if MaxLoan > MaxCredit then
//                             MaxLoan := MaxCredit;

//                         if LoanProduct."Requires Salary Processing" then begin
//                             SalaryThroughFosa := false;
//                             SkyMbanking.GetSalaryEntries(AccountNo, SalDates, SmallestSal, Salary, SalaryThroughFosa);
//                             if not SalaryThroughFosa then begin
//                                 MaxLoan := 0;
//                                 Msg := ChannelThroughFosa;
//                             end;

//                         end;
//                     end;



//                     if MaxLoan = 0 then
//                         MinLoan := 0;

//                     Cust.Get(MemberNo);

//                     CurrLoanBal := '';
//                     if LoanProduct."Product ID" = '119' then begin
//                         LoanTopUP.Reset;
//                         LoanTopUP.SetRange("Member No.", MemberNo);
//                         LoanTopUP.SetRange("Loan Product Type", '119');
//                         LoanTopUP.SetFilter("Outstanding Balance", '>0');
//                         if LoanTopUP.FindFirst then begin
//                             LoanTopUP.CalcFields("Outstanding Balance", "Outstanding Interest");
//                             if LoanTopUP."Outstanding Interest" < 0 then
//                                 LoanTopUP."Outstanding Interest" := LoanTopUP."Outstanding Interest";
//                             CurrLoanBal := ' (Loan Bal: ' + Format(LoanTopUP."Outstanding Balance" + LoanTopUP."Outstanding Interest") + ')';
//                         end;
//                     end;

//                     MaxLoan := ROUND(MaxLoan, 1000, '<');
//                     MinLoan := ROUND(MinLoan, 100, '>');
//                     if MaxLoan > LoanProduct."Mobile Max. Loan Amount" then
//                         MaxLoan := LoanProduct."Mobile Max. Loan Amount";

//                     SkipLoan := false;
//                     if LoanProduct."Available To Member" <> '' then
//                         if LoanProduct."Available To Member" <> MemberNo then
//                             SkipLoan := true;

//                     if LoanProduct.Category = LoanProduct.Category::"BOSA Loan" then begin
//                         if Cust."Employer Code" = '05' then
//                             SkipLoan := true;

//                         if Cust."Employer Code" = '99' then
//                             SkipLoan := true;
//                     end;

//                     loans.Reset;
//                     loans.SetRange(loans."Loan Product Type", LoanProduct."Product ID");
//                     loans.SetRange("Member No.", MemberNo);
//                     loans.SetRange(Posted, false);
//                     if loans.FindFirst then begin
//                         MaxLoan := 0;
//                         MinLoan := 0;
//                     end;

//                     if (not SkipLoan) and ((LoanProduct."Restrict to Emp. Code" = '') or (LoanProduct."Restrict to Emp. Code" = Cust."Employer Code")) then begin
//                         //                        LocalJsonTextWriter.WriteStartObject;
//                         //                        LocalJsonTextWriter.WritePropertyName('loan_code');
//                         //                        LocalJsonTextWriter.WriteValue(Format(LoanProduct."Product ID"));

//                         //                        LocalJsonTextWriter.WritePropertyName('loan_name');
//                         //                        LocalJsonTextWriter.WriteValue(Format(LoanProduct."USSD Product Name" + CurrLoanBal));

//                         //                        LocalJsonTextWriter.WritePropertyName('member_can_apply');
//                         if MaxLoan > 0 then
//                             //                            LocalJsonTextWriter.WriteValue('YES')
//                             else
//                             //                            LocalJsonTextWriter.WriteValue('NO');

//                             //                        LocalJsonTextWriter.WritePropertyName('message');
//                             //                        LocalJsonTextWriter.WriteValue(Msg);

//                             //                        LocalJsonTextWriter.WritePropertyName('source');
//                             //                        LocalJsonTextWriter.WriteValue(Format(LoanProduct.Category));

//                             //                        LocalJsonTextWriter.WritePropertyName('requires_guarantors');
//                             if LoanProduct."Mobile Loan Req. Guar." then
//                                 //                            LocalJsonTextWriter.WriteValue('YES')
//                                 else
//                                 //                            LocalJsonTextWriter.WriteValue('NO');

//                                 //                        LocalJsonTextWriter.WritePropertyName('requires_purpose');
//                                 if LoanProduct."Requires Purpose" then
//                                     //                            LocalJsonTextWriter.WriteValue('YES')
//                                     else
//                                     //                            LocalJsonTextWriter.WriteValue('NO');


//                                     //                        LocalJsonTextWriter.WritePropertyName('requires_branch');
//                                     if LoanProduct."Requires Branch" then
//                                         //                            LocalJsonTextWriter.WriteValue('YES')
//                                         else
//                                         //                            LocalJsonTextWriter.WriteValue('NO');


//                                         //                        LocalJsonTextWriter.WritePropertyName('installments_type');
//                                         if LoanProduct."Mobile Installments Type" = LoanProduct."mobile installments type"::None then begin
//                                             //                            LocalJsonTextWriter.WriteValue('NONE');
//                                             //                            LocalJsonTextWriter.WritePropertyName('installments');
//                                             //                            LocalJsonTextWriter.WriteStartArray;
//                                             //                            LocalJsonTextWriter.WriteStartObject;
//                                             //                            LocalJsonTextWriter.WritePropertyName('minimum');
//                                             //                            LocalJsonTextWriter.WriteValue(Format(LoanProduct."Ordinary Default Intallments"));
//                                             //                            LocalJsonTextWriter.WritePropertyName('maximum');
//                                             //                            LocalJsonTextWriter.WriteValue(Format(LoanProduct."Ordinary Default Intallments"));
//                                             //                            LocalJsonTextWriter.WriteEndObject;
//                                             //                            LocalJsonTextWriter.WriteEndArray;
//                                         end else
//                                             if LoanProduct."Mobile Installments Type" = LoanProduct."mobile installments type"::Input then begin
//                                                 //                                LocalJsonTextWriter.WriteValue('INPUT');
//                                                 //                                LocalJsonTextWriter.WritePropertyName('installments');
//                                                 //                                LocalJsonTextWriter.WriteStartArray;
//                                                 //                                LocalJsonTextWriter.WriteStartObject;
//                                                 //                                LocalJsonTextWriter.WritePropertyName('minimum');
//                                                 //                                LocalJsonTextWriter.WriteValue(Format(LoanProduct."Min. Mobile Installments"));
//                                                 //                                LocalJsonTextWriter.WritePropertyName('maximum');
//                                                 //                                LocalJsonTextWriter.WriteValue(Format(LoanProduct."Min. Mobile Installments"));
//                                                 //                                LocalJsonTextWriter.WriteEndObject;
//                                                 //                                LocalJsonTextWriter.WriteEndArray;
//                                             end else begin
//                                                 //                                LocalJsonTextWriter.WriteValue('PRESET');
//                                                 MobileLoanInstallments.Reset;
//                                                 MobileLoanInstallments.SetRange(Product, LoanProduct."Product ID");
//                                                 if MobileLoanInstallments.FindFirst then begin
//                                                     //                                    LocalJsonTextWriter.WritePropertyName('installments');
//                                                     //                                    LocalJsonTextWriter.WriteStartArray;
//                                                     repeat
//                                                     //                                        LocalJsonTextWriter.WriteStartObject;
//                                                     //                                        LocalJsonTextWriter.WritePropertyName('minimum');
//                                                     //                                        LocalJsonTextWriter.WriteValue(Format(MobileLoanInstallments.Installments));
//                                                     //                                        LocalJsonTextWriter.WritePropertyName('maximum');
//                                                     //                                        LocalJsonTextWriter.WriteValue(Format(MobileLoanInstallments.Installments));
//                                                     //                                        LocalJsonTextWriter.WriteEndObject;
//                                                     until MobileLoanInstallments.Next = 0;
//                                                     //                                    LocalJsonTextWriter.WriteEndArray;
//                                                 end;
//                                             end;

//                         //                        LocalJsonTextWriter.WritePropertyName('required_guarantors');
//                         //                        LocalJsonTextWriter.WriteStartArray;
//                         MobileGuarantorsSetup.Reset;
//                         MobileGuarantorsSetup.SetRange("Product Code", LoanProduct."Product ID");
//                         if MobileGuarantorsSetup.FindFirst then begin
//                             repeat
//                             //                                LocalJsonTextWriter.WriteStartObject;
//                             //                                LocalJsonTextWriter.WritePropertyName('lower_limit');
//                             //                                LocalJsonTextWriter.WriteValue(Format(MobileGuarantorsSetup."Lower Limit"));
//                             //                                LocalJsonTextWriter.WritePropertyName('upper_limit');
//                             //                                LocalJsonTextWriter.WriteValue(Format(MobileGuarantorsSetup."Upper Limit"));
//                             //                                LocalJsonTextWriter.WritePropertyName('guarantors');
//                             //                                LocalJsonTextWriter.WriteValue(Format(MobileGuarantorsSetup."No. of Guarantors"));
//                             //                                LocalJsonTextWriter.WriteEndObject;
//                             until MobileGuarantorsSetup.Next = 0;
//                         end else begin
//                             //                            LocalJsonTextWriter.WriteStartObject;
//                             //                            LocalJsonTextWriter.WritePropertyName('lower_limit');
//                             //                            LocalJsonTextWriter.WriteValue(Format(LoanProduct."Mobile Min. Loan Amount"));
//                             //                            LocalJsonTextWriter.WritePropertyName('upper_limit');
//                             //                            LocalJsonTextWriter.WriteValue(Format(LoanProduct."Mobile Max. Loan Amount"));
//                             //                            LocalJsonTextWriter.WritePropertyName('guarantors');
//                             //                            LocalJsonTextWriter.WriteValue(Format(LoanProduct."Mobile Max. Guarantors"));
//                             //                            LocalJsonTextWriter.WriteEndObject;
//                         end;
//                         //                        LocalJsonTextWriter.WriteEndArray;


//                         //                        LocalJsonTextWriter.WritePropertyName('interest_rate');
//                         //                        LocalJsonTextWriter.WriteValue(Format(LoanProduct."Interest Rate (Max.)"));


//                         //                        LocalJsonTextWriter.WritePropertyName('default_qualification');
//                         //                        LocalJsonTextWriter.WriteStartObject;
//                         //                        LocalJsonTextWriter.WritePropertyName('minimum');
//                         //                        LocalJsonTextWriter.WriteValue(Format(MinLoan));
//                         //                        LocalJsonTextWriter.WritePropertyName('maximun');
//                         //                        LocalJsonTextWriter.WriteValue(Format(MaxLoan));
//                         //                        LocalJsonTextWriter.WriteEndObject;

//                         //                        LocalJsonTextWriter.WritePropertyName('requires_terms_and_conditions');
//                         if LoanProduct."Requires TnC" then
//                             //                            LocalJsonTextWriter.WriteValue('YES')
//                             else
//                             //                            LocalJsonTextWriter.WriteValue('NO');

//                             //                        LocalJsonTextWriter.WritePropertyName('shows_qualification');
//                             if LoanProduct."Shows Mobile Qualification" then
//                                 //                            LocalJsonTextWriter.WriteValue('YES')
//                                 else
//                                 //                            LocalJsonTextWriter.WriteValue('NO');

//                                 //                        LocalJsonTextWriter.WritePropertyName('requires_payslip_pin');
//                                 if LoanProduct."Requires Payslip PIN" then
//                                     //                            LocalJsonTextWriter.WriteValue('YES')
//                                     else
// //                            LocalJsonTextWriter.WriteValue('NO');
// //                        LocalJsonTextWriter.WriteEndObject;
//                     end;
//                 until LoanProduct.Next = 0;
//                     end;

//                     ResponseMessage := 'Member Details Fetched Successfully';

//         end;
//                 //        LocalJsonTextWriter.WriteEndArray;
//                 //        LocalJsonTextWriter.WritePropertyName('title');
//                 //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//                 //        LocalJsonTextWriter.WritePropertyName('message');
//                 //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//                 //        LocalJsonTextWriter.WriteEndObject;

//                 //Payload := LocalStringBuilder.ToString;

//                 /*-------------------------------------------------------------------------------------*/
//                 Response := GenerateJSONResponse(Action, Status, Payload, true);

//             end;


//     procedure GetLoanPurposes("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         SkyPortalSetup: Record "Sky Portal Setup";
//         AccountNo: Code[50];
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Get Loan Purposes';



//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             AccountNo := SkyAuth."Account No.";
//             Status := 'SUCCESS';
//         end;

//         if Status = 'SUCCESS' then begin
//             if SavingsAccounts.Get(AccountNo) then begin
//                 MemberNo := SavingsAccounts."Member No.";
//             end else begin
//                 ResponseMessage := 'Member Not Found';
//                 Status := 'FAILED';
//             end;
//         end;

//         // Country.GET( "Code");
//         /*-------------------------------------------------------------------------------------*/
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         if Status = 'SUCCESS' then begin
//             //            LocalJsonTextWriter.WriteStartArray;
//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('purpose_id');
//             //            LocalJsonTextWriter.WriteValue('1180');
//             //            LocalJsonTextWriter.WritePropertyName('title');
//             //            LocalJsonTextWriter.WriteValue('Agriculture');
//             //            LocalJsonTextWriter.WriteEndObject;

//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('purpose_id');
//             //            LocalJsonTextWriter.WriteValue('2220');
//             //            LocalJsonTextWriter.WritePropertyName('title');
//             //            LocalJsonTextWriter.WriteValue('Trade');
//             //            LocalJsonTextWriter.WriteEndObject;

//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('purpose_id');
//             //            LocalJsonTextWriter.WriteValue('3120');
//             //            LocalJsonTextWriter.WritePropertyName('title');
//             //            LocalJsonTextWriter.WriteValue('Manufacturing and Services Industries');
//             //            LocalJsonTextWriter.WriteEndObject;

//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('purpose_id');
//             //            LocalJsonTextWriter.WriteValue('4120');
//             //            LocalJsonTextWriter.WritePropertyName('title');
//             //            LocalJsonTextWriter.WriteValue('Education');
//             //            LocalJsonTextWriter.WriteEndObject;

//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('purpose_id');
//             //            LocalJsonTextWriter.WriteValue('5110');
//             //            LocalJsonTextWriter.WritePropertyName('title');
//             //            LocalJsonTextWriter.WriteValue('Human Health');
//             //            LocalJsonTextWriter.WriteEndObject;

//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('purpose_id');
//             //            LocalJsonTextWriter.WriteValue('6110');
//             //            LocalJsonTextWriter.WritePropertyName('title');
//             //            LocalJsonTextWriter.WriteValue('Land and Housing');
//             //            LocalJsonTextWriter.WriteEndObject;

//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('purpose_id');
//             //            LocalJsonTextWriter.WriteValue('7210');
//             //            LocalJsonTextWriter.WritePropertyName('title');
//             //            LocalJsonTextWriter.WriteValue('Finance Investment and Insurance');
//             //            LocalJsonTextWriter.WriteEndObject;

//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('purpose_id');
//             //            LocalJsonTextWriter.WriteValue('8210');
//             //            LocalJsonTextWriter.WritePropertyName('title');
//             //            LocalJsonTextWriter.WriteValue('Consumption and Social activities');
//             //            LocalJsonTextWriter.WriteEndObject;
//             //            LocalJsonTextWriter.WriteEndArray;

//             ResponseMessage := 'Loan Purposes Fetched Successfully';
//         end;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetLoanBranches("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         SkyPortalSetup: Record "Sky Portal Setup";
//         AccountNo: Code[50];
//         DimensionValue: Record "Dimension Value";
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Get Loan Branches';



//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             AccountNo := SkyAuth."Account No.";
//             Status := 'SUCCESS';
//         end;

//         if Status = 'SUCCESS' then begin
//             if SavingsAccounts.Get(AccountNo) then begin
//                 MemberNo := SavingsAccounts."Member No.";
//             end else begin
//                 ResponseMessage := 'Member Not Found';
//                 Status := 'FAILED';
//             end;
//         end;

//         // Country.GET( "Code");
//         /*-------------------------------------------------------------------------------------*/
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         if Status = 'SUCCESS' then begin
//             //            LocalJsonTextWriter.WriteStartArray;
//             DimensionValue.Reset;
//             DimensionValue.SetRange("Global Dimension No.", 2);
//             if DimensionValue.FindSet then begin
//                 repeat
//                 //                    LocalJsonTextWriter.WriteStartObject;
//                 //                    LocalJsonTextWriter.WritePropertyName('code');
//                 //                    LocalJsonTextWriter.WriteValue(DimensionValue.Code);
//                 //                    LocalJsonTextWriter.WritePropertyName('name');
//                 //                    LocalJsonTextWriter.WriteValue(DimensionValue.Name);
//                 //                    LocalJsonTextWriter.WriteEndObject;
//                 until DimensionValue.Next = 0;
//             end;
//             //            LocalJsonTextWriter.WriteEndArray;

//             ResponseMessage := 'Loan Branches Fetched Successfully';
//         end;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure ValidateGuarantors("Action": Text; Password: Text; Username: Text; PhoneNumber: Text; LoanProductCode: Code[50]) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         SkyPortalSetup: Record "Sky Portal Setup";
//         AccountNo: Code[50];
//         DimensionValue: Record "Dimension Value";
//         GuarantorMemberNumber: Code[40];
//         LoanType: Record "Product Factory";
//         SavAcc: Record "Savings Accounts";
//         DepAc: Code[40];
//         GuarantorName: Text[100];
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Guarantor Validation';



//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             AccountNo := SkyAuth."Account No.";
//             Status := 'SUCCESS';
//         end;

//         if Status = 'SUCCESS' then begin
//             if SavingsAccounts.Get(AccountNo) then begin
//                 MemberNo := SavingsAccounts."Member No.";
//             end else begin
//                 ResponseMessage := 'Member Not Found';
//                 Status := 'FAILED'
//             end;
//         end;

//         if Status = 'SUCCESS' then begin
//             Members.Reset;
//             Members.SetFilter("Phone No.", '*' + PhoneNumber);
//             if Members.FindFirst then begin
//                 GuarantorMemberNumber := Members."No.";
//                 GuarantorName := Members.Name;
//             end else begin
//                 ResponseMessage := 'Phone number is not valid';
//                 Status := 'FAILED';
//             end;
//         end;

//         if Status = 'SUCCESS' then begin
//             if Members.Get(GuarantorMemberNumber) then begin
//                 if Members.Status <> Members.Status::Active then begin
//                     ResponseMessage := 'Member not an active member';
//                     Status := 'FAILED';
//                 end;
//             end;
//         end;

//         if Status = 'SUCCESS' then begin
//             if GuarantorMemberNumber = MemberNo then begin
//                 ResponseMessage := 'You cannot guarantee your own loan';
//                 Status := 'FAILED';
//             end;
//         end;

//         DepAc := '';
//         LoanType.Get(LoanProductCode);
//         if Status = 'SUCCESS' then begin
//             if LoanType."Minimum Guarantor Deposits" > 0 then begin
//                 SavAcc.Reset;
//                 SavAcc.SetRange("Member No.", GuarantorMemberNumber);
//                 SavAcc.SetRange("Product Category", SavAcc."Product Category"::"BOSA Deposits");
//                 if SavAcc.FindFirst then begin
//                     SavAcc.CalcFields("Balance (LCY)");
//                     if SavAcc."Balance (LCY)" < LoanType."Minimum Guarantor Deposits" then begin
//                         ResponseMessage := 'Deposits balance too low';
//                         Status := 'FAILED';
//                     end;
//                     DepAc := SavAcc."No.";
//                 end;
//             end;
//         end;

//         if LoanType."Minimum Guarantor Deposits" > 0 then begin
//             if Status = 'SUCCESS' then begin
//                 if DepAc = '' then begin
//                     ResponseMessage := 'Guarantor does not have a deposits account';
//                     Status := 'FAILED';
//                 end;
//             end;
//         end;

//         // Country.GET( "Code");
//         /*-------------------------------------------------------------------------------------*/
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         if Status = 'SUCCESS' then begin
//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('name');
//             //            LocalJsonTextWriter.WriteValue(GuarantorName);
//             //            LocalJsonTextWriter.WritePropertyName('phone_number');
//             //            LocalJsonTextWriter.WriteValue(PhoneNumber);
//             //            LocalJsonTextWriter.WritePropertyName('member_number');
//             //            LocalJsonTextWriter.WriteValue(GuarantorMemberNumber);
//             //            LocalJsonTextWriter.WriteEndObject;
//             ResponseMessage := 'Guarantor Validated Successfully';
//         end else begin
//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('name');
//             //            LocalJsonTextWriter.WriteValue('');
//             //            LocalJsonTextWriter.WritePropertyName('phone_number');
//             //            LocalJsonTextWriter.WriteValue('');
//             //            LocalJsonTextWriter.WritePropertyName('member_number');
//             //            LocalJsonTextWriter.WriteValue('');
//             //            LocalJsonTextWriter.WriteEndObject;
//         end;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure ApplyLoan("Action": Text; Password: Text; Username: Text; Records: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         MemberNumber: Code[30];
//         SalesSetup: Record "Sales & Receivables Setup";
//         // NoSeriesMgt: Codeunit NoSeriesManagement;
//         HeaderNo: Code[30];
//         MembNoSeries: Record "Banking No Setup";
//         JObject: code[100];//dotnet JObject;
//         JSONString: Text;
//         JObjectLevel2: code[100];//dotnet JObject;
//         CorrespondencePayload: code[100];//dotnet JObject;
//         LineNo: Integer;
//         JObject3: code[100];//dotnet JObject;
//         HMember: Record Members;
//         FName: Text;
//         Salute: Text;
//         SkyMbanking: Codeunit "Sky Mbanking";
//         CurrentDateTimeText: Text;
//         msg: Text;
//         ProductID: Code[30];
//         LoanDuration: Text;
//         LoanPurpose: Code[10];
//         LoanBranch: Code[10];
//         Amount: Text;
//         GHRISPassword: Text;
//         GuarantorsArray: code[100];//dotnet JArray;
//         GuarantorsString: Text;
//         SavAcc: Record "Savings Accounts";
//         LoanProduct: Record "Product Factory";
//         FOSAAccount: Code[30];
//         MobileLoans: Record "Sky Mobile Loans";
//         MobileLoanGuarantors: Record "Mobile Loan Guarantors";
//         LoanEntryNo: Integer;
//         GuarantorMobileNumber: Text;
//         GurantorMemberNumber: Code[30];
//         GuarantorRec: Record Members;
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Loan Application';
//         ResponseMessage := 'Loan Application Submitted';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             MemberNumber := Members."No.";
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;


//         ArrayString := Records;
//         if ArrayString <> '' then
//             CorrespondencePayload := JObject.Parse(Format(ArrayString));

//         GuarantorsString := CorrespondencePayload.SelectToken('guarantors').ToString;
//         ProductID := CorrespondencePayload.SelectToken('loan_code').ToString;
//         LoanDuration := CorrespondencePayload.SelectToken('loan_duration').ToString;
//         LoanPurpose := CorrespondencePayload.SelectToken('loan_purpose').ToString;
//         LoanBranch := CorrespondencePayload.SelectToken('loan_branch').ToString;
//         Amount := CorrespondencePayload.SelectToken('amount').ToString;
//         Clear(CorrespondencePayload);

//         if Status = 'SUCCESS' then begin
//             LoanProduct.Reset;
//             LoanProduct.SetRange("Product ID", ProductID);
//             LoanProduct.SetRange(AvailableOnMobile, true);
//             if not LoanProduct.FindFirst then begin
//                 ResponseMessage := 'Loan product not found';
//                 Status := 'FAILED';
//             end;
//         end;

//         if Status = 'SUCCESS' then begin
//             SavAcc.Reset;
//             SavAcc.SetRange("Member No.", MemberNumber);
//             SavAcc.SetRange("Product Type", '505');
//             SavAcc.SetFilter(Status, '<>%1', SavAcc.Status::Deceased);
//             if SavAcc.FindFirst then begin
//                 FOSAAccount := SavAcc."No.";
//             end else begin
//                 ResponseMessage := 'Savings Account Status is Deceased';
//                 Status := 'FAILED';
//             end;
//         end;

//         if Status = 'SUCCESS' then begin
//             MobileLoans.Reset;
//             MobileLoans.SetRange("Account No", FOSAAccount);
//             MobileLoans.SetFilter(Status, '<>%1&<>%2', MobileLoans.Status::Failed, MobileLoans.Status::Successful);
//             MobileLoans.SetRange("Loan Product Type", ProductID);
//             if MobileLoans.FindFirst then begin
//                 ResponseMessage := 'You have an existing loan';
//                 Status := 'FAILED';
//             end;
//         end;



//         if Status = 'SUCCESS' then begin
//             SavAcc.Get(FOSAAccount);
//             LoanProduct.Get(ProductID);
//             Members.Get(MemberNumber);
//             MobileLoans.Reset;

//             if MobileLoans.FindLast then
//                 LoanEntryNo := MobileLoans."Entry No" + 1;

//             MobileLoans.Init;
//             MobileLoans."Entry No" := LoanEntryNo;
//             MobileLoans."Account No" := SavAcc."No.";
//             MobileLoans."Account Name" := SavAcc.Name;
//             MobileLoans."Member No." := SavAcc."Member No.";
//             MobileLoans.Date := CurrentDatetime;
//             Evaluate(MobileLoans."Requested Amount", Amount);
//             MobileLoans."Requested Amount" := MobileLoans."Requested Amount";
//             MobileLoans.Status := MobileLoans.Status::Pending;
//             MobileLoans."Loan Product Type" := LoanProduct."Product ID";
//             MobileLoans."Loan Name" := LoanProduct."USSD Product Name";
//             MobileLoans."Loan Name" := LoanProduct."Product Description";
//             Evaluate(MobileLoans.Amount, Amount);
//             MobileLoans.Amount := MobileLoans.Amount;
//             MobileLoans."Entry Code" := 'WEBP' + Format(MobileLoans."Entry No");
//             MobileLoans."Session ID" := 'WEBP' + Format(MobileLoans."Entry No");
//             MobileLoans."Date Entered" := Today;
//             MobileLoans."Time Entered" := Time;
//             MobileLoans."Telephone No" := SavAcc."Transactional Mobile No";
//             if MobileLoans."Telephone No" = '' then
//                 MobileLoans."Telephone No" := Members."Phone No.";
//             Evaluate(MobileLoans."Loan Period", LoanDuration);
//             MobileLoans."Loan Period" := MobileLoans."Loan Period";
//             MobileLoans.Password := Password;
//             MobileLoans."Loan Purpose" := LoanPurpose;
//             MobileLoans.Branch := LoanBranch;
//             MobileLoans."Salary Loan" := LoanProduct."Salary Loans";
//             if LoanProduct.Category = LoanProduct.Category::"BOSA Loan" then
//                 MobileLoans.Source := 'BOSA';
//             if LoanProduct.Category = LoanProduct.Category::"FOSA Loan" then
//                 MobileLoans.Source := 'FOSA';

//             MobileLoans."Needs Guarantors" := LoanProduct."Mobile Loan Req. Guar.";
//             if MobileLoans."Needs Guarantors" then begin
//                 LoanProduct.TestField("Mobile Min. Guarantors");
//                 MobileLoans.Status := MobileLoans.Status::"Pending Guarantors";
//                 MobileLoans."Expected Guarantors" := SkyMbanking.GetNumberOfGuarantors(LoanProduct."Product ID", MobileLoans.Amount);
//             end;
//             MobileLoans.Insert;


//             if LoanProduct."Mobile Loan Req. Guar." then begin
//                 msg := GetSMSSalutation(MemberNumber) +
//                       NewLine + 'To add guarantors to your ' + MobileLoans."Loan Name" + ' request of KES ' + Format(MobileLoans.Amount) + ', Please dial ' + UssdCode + ' or use our Mobile App.' +
//                       NewLine + 'Login > Loans > Add / Remove Guarantors. ' +
//                       NewLine + 'REF: ' + MobileLoans."Entry Code";
//                 SkyMbanking.SendSms(Source::MBANKING, SavAcc."Transactional Mobile No", msg, Format(MobileLoans."Entry Code"), '', true, Priority, false);

//                 msg := 'Minimum required guarantors is ' + Format(MobileLoans."Expected Guarantors") + '. In the event their total deposits won''t be sufficient, you''ll'
//                 + ' be required to add one or more.' + NewLine + 'REF: ' + MobileLoans."Entry Code";
//                 SkyMbanking.SendSms(Source::MBANKING, SavAcc."Transactional Mobile No", msg, Format(MobileLoans."Entry Code"), '', true, Priority, false);
//             end;


//             GuarantorsArray := GuarantorsArray.Parse(GuarantorsString);

//             foreach JObject in GuarantorsArray do begin
//                 GuarantorMobileNumber := '';
//                 GuarantorMobileNumber := Format(JObject.ToString);

//                 GuarantorRec.Reset;
//                 GuarantorRec.SetFilter("Mobile Phone No", '*' + GuarantorMobileNumber);
//                 if GuarantorRec.FindFirst then begin
//                     GurantorMemberNumber := GuarantorRec."No.";
//                 end;

//                 if GurantorMemberNumber <> '' then begin
//                     MobileLoanGuarantors.Reset;
//                     MobileLoanGuarantors.SetRange("Loan Entry No.", LoanEntryNo);
//                     MobileLoanGuarantors.SetRange("Guarantor Mobile No.", GuarantorMobileNumber);
//                     if not MobileLoanGuarantors.FindFirst then begin
//                         MobileLoanGuarantors.Init;
//                         MobileLoanGuarantors."Loan Entry No." := LoanEntryNo;
//                         MobileLoanGuarantors."Guarantor Mobile No." := Format(JObject.ToString);
//                         MobileLoanGuarantors.Validate("Guarantor Member No.", GuarantorRec."No.");
//                         MobileLoanGuarantors."Loan Product" := MobileLoans."Loan Product Type";
//                         MobileLoanGuarantors."Loan Product Name" := '';
//                         MobileLoanGuarantors."Guarantor Name" := GuarantorRec."First Name" + ' ' + GuarantorRec."Last Name";
//                         MobileLoanGuarantors."Date Created" := CurrentDatetime;
//                         MobileLoanGuarantors.Insert;


//                         if SavAcc.Get(MobileLoans."Account No") then begin
//                             Priority := 211;
//                             msg := 'Dear ' + Format(MobileLoans."Account Name") + NewLine + 'You have Requested ' + MobileLoanGuarantors."Guarantor Name" +
//                             ' to be your Guarantor on ' + MobileLoans."Loan Name" + ' amounting to KES ' + Format(MobileLoans.Amount) + ' on ' + Format(FormatDate(Today)) + ' ' + Format(Time) +
//                             ' Please notify them to Accept By dialing ' + UssdCode + '.' + NewLine + 'REF: ' + Format(MobileLoans."Entry No");
//                             SkyMbanking.SendSms(Source::MBANKING, SavAcc."Transactional Mobile No", msg, SavAcc."No.", '', true, Priority, false);


//                             Priority := 211;
//                             msg := 'Dear ' + Format(MobileLoanGuarantors."Guarantor Name") + NewLine + MobileLoans."Account Name" +
//                             ' is Requesting your Guarantorship on ' + MobileLoans."Loan Name" + ' amounting to KES ' + Format(MobileLoans.Amount) + ' on ' + Format(FormatDate(Today)) + ' ' + Format(Time) +
//                             ' Please Accept/Decline By dialing ' + UssdCode + '.' + NewLine + 'REF: ' + Format(MobileLoans."Entry No");
//                             SkyMbanking.SendSms(Source::MBANKING, MobileLoanGuarantors."Guarantor Mobile No.", msg, SavAcc."No.", '', true, Priority, false);

//                         end;
//                     end;
//                 end;
//             end;
//             ResponseMessage := 'Loan Application submitted successfully';

//         end;
//         //    ComplainandRemarks."Complaint Catagory" := FORMAT(JObject3.GetValue('complaint_category'));

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('name');
//         //        LocalJsonTextWriter.WriteValue('name');
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure NewLine() NewLine: Text
//     var
//         nL: Char;
//     begin

//         nL := 13;
//         NewLine := Format(nL, 0, '<CHAR>');
//     end;

//     local procedure GetSMSSalutation(MemberNo: Code[20]) Salute: Text
//     var
//         FName: Text;
//     begin

//         HMember.Get(MemberNo);
//         FName := HMember."First Name";
//         if FName = '' then
//             FName := HMember."Middle Name";
//         Salute := 'Dear ' + FirstName(FName) + ',' + NewLine;
//     end;


//     procedure FirstName(Text: Text[100]) FName: Text[100]
//     var
//         Pos: Integer;
//     begin
//         /*
//         //New Code for Last Name
//         Pos:=1;
//         FName := Text;
//         WHILE (Pos > 0) DO BEGIN
//             Token(FName,' ');
//             Pos := STRPOS(FName,' ');
//         END;
//         */



//         //Old Code For First Name
//         Pos := StrPos(Text, ' ');

//         if Pos > 0 then begin
//             FName := CopyStr(Text, 1, Pos - 1);
//         end else begin
//             FName := Text;
//         end;

//     end;


//     procedure GetUnpostedLoans("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         SkyPortalSetup: Record "Sky Portal Setup";
//         AccountNo: Code[50];
//         DimensionValue: Record "Dimension Value";
//         SkyMobileLoans: Record "Sky Mobile Loans";
//         MobileLoanGuarantors: Record "Mobile Loan Guarantors";
//         TotalGuaranteed: Decimal;
//         LoaneeDepAcc: Code[30];
//         LoaneeDeposits: Decimal;
//         RequiresAdditionalGuarantor: Code[10];
//         DepAccountRec: Record "Savings Accounts";
//         SkyMabnking: Codeunit "Sky Mbanking";
//         ProductFactory: Record "Product Factory";
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Get Loan List';



//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             AccountNo := SkyAuth."Account No.";
//             Status := 'SUCCESS';
//         end;

//         if Status = 'SUCCESS' then begin
//             if SavingsAccounts.Get(AccountNo) then begin
//                 MemberNo := SavingsAccounts."Member No.";
//             end else begin
//                 ResponseMessage := 'Member Not Found';
//                 Status := 'FAILED';
//             end;
//         end;

//         // Country.GET( "Code");
//         /*-------------------------------------------------------------------------------------*/
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         if Status = 'SUCCESS' then begin
//             //            LocalJsonTextWriter.WriteStartArray;
//             SkyMobileLoans.Reset;
//             SkyMobileLoans.SetRange("Account No", AccountNo);
//             SkyMobileLoans.SetFilter(Status, '<>%1&<>%2', SkyMobileLoans.Status::Successful, SkyMobileLoans.Status::Failed);
//             if SkyMobileLoans.FindSet then begin
//                 repeat
//                     RequiresAdditionalGuarantor := 'NO';

//                     ProductFactory.Get(SkyMobileLoans."Loan Product Type");

//                     MobileLoanGuarantors.Reset;
//                     MobileLoanGuarantors.SetRange("Loan Entry No.", SkyMobileLoans."Entry No");
//                     MobileLoanGuarantors.SetRange("Guarantor Accepted", MobileLoanGuarantors."guarantor accepted"::Yes);
//                     if MobileLoanGuarantors.FindFirst then begin
//                         MobileLoanGuarantors.CalcSums("Amount Guaranteed");
//                         TotalGuaranteed := MobileLoanGuarantors."Amount Guaranteed";
//                     end;

//                     LoaneeDepAcc := '';
//                     LoaneeDeposits := 0;

//                     if SavingsAccounts.Get(AccountNo) then begin
//                         DepAccountRec.Reset;
//                         DepAccountRec.SetRange("Member No.", MemberNo);
//                         DepAccountRec.SetRange("Product Type", '02');
//                         if DepAccountRec.FindFirst then
//                             LoaneeDepAcc := DepAccountRec."No.";
//                     end;

//                     if LoaneeDepAcc <> '' then
//                         LoaneeDeposits := SkyMabnking.GetAccountBalance(LoaneeDepAcc);


//                     if SkyMobileLoans."Requested Amount" > (TotalGuaranteed + LoaneeDeposits) then begin
//                         RequiresAdditionalGuarantor := 'YES';
//                     end;

//                     //                    LocalJsonTextWriter.WriteStartObject;

//                     //                    LocalJsonTextWriter.WritePropertyName('entry_no');
//                     //                    LocalJsonTextWriter.WriteValue(SkyMobileLoans."Entry No");

//                     //                    LocalJsonTextWriter.WritePropertyName('requested_amount');
//                     //                    LocalJsonTextWriter.WriteValue(Format(SkyMobileLoans."Requested Amount"));

//                     //                    LocalJsonTextWriter.WritePropertyName('loan_status');
//                     //                    LocalJsonTextWriter.WriteValue(Format(SkyMobileLoans.Status));

//                     //                    LocalJsonTextWriter.WritePropertyName('loan_product_name');
//                     //                    LocalJsonTextWriter.WriteValue(Format(ProductFactory."USSD Product Name"));

//                     //                    LocalJsonTextWriter.WritePropertyName('loan_product_code');
//                     //                    LocalJsonTextWriter.WriteValue(Format(ProductFactory."Product ID"));

//                     //                    LocalJsonTextWriter.WritePropertyName('remarks');
//                     //                    LocalJsonTextWriter.WriteValue(SkyMobileLoans.Remarks);

//                     //                    LocalJsonTextWriter.WritePropertyName('date_entered');
//                     //                    LocalJsonTextWriter.WriteValue(Format(FormatDate(SkyMobileLoans."Date Entered")));

//                     //                    LocalJsonTextWriter.WritePropertyName('expected_guarantors');
//                     //                    LocalJsonTextWriter.WriteValue(Format(SkyMobileLoans."Expected Guarantors"));

//                     //                    LocalJsonTextWriter.WritePropertyName('loan_period');
//                     //                    LocalJsonTextWriter.WriteValue(Format(SkyMobileLoans."Loan Period"));

//                     //                    LocalJsonTextWriter.WritePropertyName('loan_source');
//                     //                    LocalJsonTextWriter.WriteValue(Format(SkyMobileLoans.Source));

//                     //                    LocalJsonTextWriter.WritePropertyName('requires_additional_guarantor');
//                     //                    LocalJsonTextWriter.WriteValue(RequiresAdditionalGuarantor);

//                     //                    LocalJsonTextWriter.WritePropertyName('guarantors');
//                     //                    LocalJsonTextWriter.WriteStartArray;
//                     MobileLoanGuarantors.Reset;
//                     MobileLoanGuarantors.SetRange("Loan Entry No.", SkyMobileLoans."Entry No");
//                     if MobileLoanGuarantors.FindFirst then begin
//                         repeat
//                         //                            LocalJsonTextWriter.WriteStartObject;
//                         //                            LocalJsonTextWriter.WritePropertyName('guarantor_mobile_number');
//                         //                            LocalJsonTextWriter.WriteValue(MobileLoanGuarantors."Guarantor Mobile No.");
//                         //                            LocalJsonTextWriter.WritePropertyName('guarantor_name');
//                         //                            LocalJsonTextWriter.WriteValue(MobileLoanGuarantors."Guarantor Name");
//                         //                            LocalJsonTextWriter.WritePropertyName('guarantor_accepted');
//                         //                            LocalJsonTextWriter.WriteValue(Format(MobileLoanGuarantors."Guarantor Accepted"));
//                         //                            LocalJsonTextWriter.WriteEndObject;
//                         until MobileLoanGuarantors.Next = 0;
//                     end;
//                 //                    LocalJsonTextWriter.WriteEndArray;
//                 //                    LocalJsonTextWriter.WriteEndObject;

//                 until SkyMobileLoans.Next = 0;
//             end;
//             //            LocalJsonTextWriter.WriteEndArray;

//             ResponseMessage := 'Loans Fetched Successfully';
//         end;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure CancelLoanApplication("Action": Text; Password: Text; Username: Text; EntryNo: Integer) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         SkyPortalSetup: Record "Sky Portal Setup";
//         AccountNo: Code[50];
//         DimensionValue: Record "Dimension Value";
//         SkyMobileLoans: Record "Sky Mobile Loans";
//         MobileLoanGuarantors: Record "Mobile Loan Guarantors";
//         TotalGuaranteed: Decimal;
//         LoaneeDepAcc: Code[30];
//         LoaneeDeposits: Decimal;
//         RequiresAdditionalGuarantor: Code[10];
//         DepAccountRec: Record "Savings Accounts";
//         SkyMabnking: Codeunit "Sky Mbanking";
//         FName: Text;
//         Salute: Text;
//         msg: Text;
//         LoanType: Record "Product Factory";
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Cancel Loan Application';

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             AccountNo := SkyAuth."Account No.";
//             Status := 'SUCCESS';
//         end;

//         if Status = 'SUCCESS' then begin
//             if SavingsAccounts.Get(AccountNo) then begin
//                 MemberNo := SavingsAccounts."Member No.";
//             end else begin
//                 ResponseMessage := 'Member Not Found';
//                 Status := 'FAILED';
//             end;
//         end;

//         // Country.GET( "Code");
//         /*-------------------------------------------------------------------------------------*/
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('cancel');
//         //        LocalJsonTextWriter.WriteValue('Loan cancelling');
//         //        LocalJsonTextWriter.WriteEndObject;

//         if Status = 'SUCCESS' then begin
//             SkyMobileLoans.Reset;
//             SkyMobileLoans.SetRange("Entry No", EntryNo);
//             SkyMobileLoans.SetFilter(Status, '<>%1', SkyMobileLoans.Status::Successful);
//             if SkyMobileLoans.FindSet then begin

//                 HMember.Get(SkyMobileLoans."Member No.");
//                 FName := HMember."First Name";
//                 if FName = '' then
//                     FName := HMember."Middle Name";
//                 Salute := 'Dear ' + FirstName(FName) + ',' + NewLine;
//                 LoanType.Get(SkyMobileLoans."Loan Product Type");
//                 msg := Salute + 'Your ' + LoanType."USSD Product Name" + ' request has been cancelled.';
//                 SkyMobileLoans.Remarks := 'Loan Discarded';
//                 SkyMobileLoans.Status := SkyMobileLoans.Status::Failed;
//                 SkyMobileLoans.Posted := true;
//                 SkyMobileLoans."Date Posted" := CurrentDatetime;//TODAY;
//                 SkyMobileLoans."Message Text" := msg;
//                 SkyMabnking.SendSms(Source::MBANKING, SkyMobileLoans."Telephone No", msg, Format(SkyMobileLoans."Entry No"), '', true, 250, false);
//                 SkyMobileLoans.Modify;
//             end;

//             ResponseMessage := 'Loan Discarded';
//         end;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure UpdateGuarantors("Action": Text; Password: Text; Username: Text; Records: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         MemberNumber: Code[30];
//         SalesSetup: Record "Sales & Receivables Setup";
//         // NoSeriesMgt: Codeunit NoSeriesManagement;
//         HeaderNo: Code[30];
//         MembNoSeries: Record "Banking No Setup";
//         JObject: code[100];//dotnet JObject;
//         JSONString: Text;
//         JObjectLevel2: code[100];//dotnet JObject;
//         CorrespondencePayload: code[100];//dotnet JObject;
//         LineNo: Integer;
//         JObject3: code[100];//dotnet JObject;
//         HMember: Record Members;
//         FName: Text;
//         Salute: Text;
//         SkyMbanking: Codeunit "Sky Mbanking";
//         CurrentDateTimeText: Text;
//         msg: Text;
//         ProductID: Code[30];
//         LoanDuration: Text;
//         LoanPurpose: Code[10];
//         LoanBranch: Code[10];
//         Amount: Text;
//         GHRISPassword: Text;
//         GuarantorsArray: code[100];//dotnet JArray;
//         GuarantorsString: Text;
//         SavAcc: Record "Savings Accounts";
//         LoanProduct: Record "Product Factory";
//         FOSAAccount: Code[30];
//         MobileLoans: Record "Sky Mobile Loans";
//         MobileLoanGuarantors: Record "Mobile Loan Guarantors";
//         LoanEntryNo: Integer;
//         GuarantorMobileNumber: Text;
//         GurantorMemberNumber: Code[30];
//         GuarantorRec: Record Members;
//         EntryNo: Code[10];
//         Loans: Record Loans;
//         GAction: Code[30];
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Guarantor Updation';
//         ResponseMessage := 'Guarantors Updated Successfully';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             MemberNumber := Members."No.";
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;


//         ArrayString := Records;
//         if ArrayString <> '' then
//             CorrespondencePayload := JObject.Parse(Format(ArrayString));

//         GuarantorsString := CorrespondencePayload.SelectToken('guarantors').ToString;
//         EntryNo := CorrespondencePayload.SelectToken('entry_no').ToString;

//         Evaluate(LoanEntryNo, EntryNo);

//         Clear(CorrespondencePayload);

//         if LoanEntryNo <> 0 then
//             MobileLoans.Get(LoanEntryNo);

//         if Status = 'SUCCESS' then begin
//             if (MobileLoans.Status = MobileLoans.Status::Failed) or (MobileLoans.Status = MobileLoans.Status::Successful) then begin
//                 ResponseMessage := 'Cannot update a ' + Format(MobileLoans.Status) + ' Loan';
//                 Status := 'FAILED';
//             end;
//         end;

//         if Status = 'SUCCESS' then begin
//             if Loans.Get(MobileLoans."Loan No.") then begin
//                 if Loans.Status = Loans.Status::Approved then begin
//                     ResponseMessage := 'Cannot update a ' + Format(Loans.Status) + ' Loan';
//                     Status := 'FAILED';
//                 end;
//             end;
//         end;

//         if Status = 'SUCCESS' then begin
//             GuarantorsArray := GuarantorsArray.Parse(GuarantorsString);

//             foreach JObject in GuarantorsArray do begin
//                 GuarantorMobileNumber := '';
//                 GAction := '';

//                 GuarantorMobileNumber := Format(JObject.GetValue('phone_number'));
//                 GAction := Format(JObject.GetValue('action'));

//                 if GAction = 'REMOVE' then begin
//                     MobileLoanGuarantors.Reset;
//                     MobileLoanGuarantors.SetRange("Loan Entry No.", LoanEntryNo);
//                     MobileLoanGuarantors.SetRange("Guarantor Mobile No.", GuarantorMobileNumber);
//                     if MobileLoanGuarantors.FindFirst then begin
//                         if SavAcc.Get(MobileLoans."Account No") then begin
//                             Priority := 211;
//                             msg := 'Dear ' + Format(MobileLoans."Account Name") + NewLine + 'You have removed ' + MobileLoanGuarantors."Guarantor Name" +
//                             ' from your guarantorship request on ' + MobileLoans."Loan Name" + ' loan amounting to KES ' + Format(MobileLoans.Amount) + ' on ' + Format(FormatDate(Today)) + ' ' + Format(Time) +
//                             NewLine + 'REF: ' + Format(MobileLoans."Entry No");
//                             SkyMbanking.SendSms(Source::MBANKING, SavAcc."Transactional Mobile No", msg, SavAcc."No.", '', true, Priority, false);



//                             Priority := 211;
//                             msg := 'Dear ' + Format(MobileLoanGuarantors."Guarantor Name") + NewLine + MobileLoans."Account Name" +
//                             ' has cancelled your guarantorship request on ' + MobileLoans."Loan Name" + ' loan amounting to KES ' + Format(MobileLoans.Amount) + ' on ' + Format(FormatDate(Today)) + ' ' + Format(Time) +
//                             ' Please Accept/Decline By dialing ' + UssdCode + '.' + NewLine + 'REF: ' + Format(MobileLoans."Entry No");
//                             SkyMbanking.SendSms(Source::MBANKING, MobileLoanGuarantors."Guarantor Mobile No.", msg, SavAcc."No.", '', true, Priority, false);
//                         end;

//                         MobileLoanGuarantors.Delete;
//                     end;
//                 end else begin

//                     GuarantorRec.Reset;
//                     GuarantorRec.SetFilter("Mobile Phone No", '*' + GuarantorMobileNumber);
//                     if GuarantorRec.FindFirst then begin
//                         GurantorMemberNumber := GuarantorRec."No.";
//                     end;

//                     if GurantorMemberNumber <> '' then begin
//                         MobileLoanGuarantors.Reset;
//                         MobileLoanGuarantors.SetRange("Loan Entry No.", LoanEntryNo);
//                         MobileLoanGuarantors.SetRange("Guarantor Mobile No.", GuarantorMobileNumber);
//                         if not MobileLoanGuarantors.FindFirst then begin

//                             MobileLoanGuarantors.Init;
//                             MobileLoanGuarantors."Loan Entry No." := LoanEntryNo;
//                             MobileLoanGuarantors."Guarantor Mobile No." := GuarantorMobileNumber;
//                             MobileLoanGuarantors.Validate("Guarantor Member No.", GuarantorRec."No.");
//                             MobileLoanGuarantors."Loan Product" := MobileLoans."Loan Product Type";
//                             MobileLoanGuarantors."Loan Product Name" := '';
//                             MobileLoanGuarantors."Guarantor Name" := GuarantorRec."First Name" + ' ' + GuarantorRec."Last Name";
//                             MobileLoanGuarantors."Date Created" := CurrentDatetime;
//                             MobileLoanGuarantors.Insert;


//                             if SavAcc.Get(MobileLoans."Account No") then begin
//                                 Priority := 211;
//                                 msg := 'Dear ' + Format(MobileLoans."Account Name") + NewLine + 'You have Requested ' + MobileLoanGuarantors."Guarantor Name" +
//                                 ' to be your Guarantor on ' + MobileLoans."Loan Name" + ' amounting to KES ' + Format(MobileLoans.Amount) + ' on ' + Format(FormatDate(Today)) + ' ' + Format(Time) +
//                                 ' Please notify them to Accept By dialing ' + UssdCode + '.' + NewLine + 'REF: ' + Format(MobileLoans."Entry No");
//                                 SkyMbanking.SendSms(Source::MBANKING, SavAcc."Transactional Mobile No", msg, SavAcc."No.", '', true, Priority, false);


//                                 Priority := 211;
//                                 msg := 'Dear ' + Format(MobileLoanGuarantors."Guarantor Name") + NewLine + MobileLoans."Account Name" +
//                                 ' is Requesting your Guarantorship on ' + MobileLoans."Loan Name" + ' amounting to KES ' + Format(MobileLoans.Amount) + ' on ' + Format(FormatDate(Today)) + ' ' + Format(Time) +
//                                 ' Please Accept/Decline By dialing ' + UssdCode + '.' + NewLine + 'REF: ' + Format(MobileLoans."Entry No");
//                                 SkyMbanking.SendSms(Source::MBANKING, MobileLoanGuarantors."Guarantor Mobile No.", msg, SavAcc."No.", '', true, Priority, false);

//                             end;
//                         end;
//                     end;
//                 end;
//             end;
//             ResponseMessage := 'Guarantors updation done successfully';

//         end;
//         //    ComplainandRemarks."Complaint Catagory" := FORMAT(JObject3.GetValue('complaint_category'));

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('name');
//         //        LocalJsonTextWriter.WriteValue('name');
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure ActionGuarantorship("Action": Text; Password: Text; Username: Text; EntryNo: Integer; GuarantorAction: Code[30]) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         MemberNumber: Code[30];
//         SalesSetup: Record "Sales & Receivables Setup";
//         // NoSeriesMgt: Codeunit NoSeriesManagement;
//         HeaderNo: Code[30];
//         MembNoSeries: Record "Banking No Setup";
//         JObject: code[100];//dotnet JObject;
//         JSONString: Text;
//         JObjectLevel2: code[100];//dotnet JObject;
//         CorrespondencePayload: code[100];//dotnet JObject;
//         LineNo: Integer;
//         JObject3: code[100];//dotnet JObject;
//         HMember: Record Members;
//         FName: Text;
//         Salute: Text;
//         SkyMbanking: Codeunit "Sky Mbanking";
//         CurrentDateTimeText: Text;
//         msg: Text;
//         ProductID: Code[30];
//         LoanDuration: Text;
//         LoanPurpose: Code[10];
//         LoanBranch: Code[10];
//         Amount: Text;
//         GHRISPassword: Text;
//         GuarantorsArray: code[100];//dotnet JArray;
//         GuarantorsString: Text;
//         SavAcc: Record "Savings Accounts";
//         LoanProduct: Record "Product Factory";
//         FOSAAccount: Code[30];
//         MobileLoans: Record "Sky Mobile Loans";
//         MobileLoanGuarantors: Record "Mobile Loan Guarantors";
//         LoanEntryNo: Integer;
//         GuarantorMobileNumber: Text;
//         GurantorMemberNumber: Code[30];
//         GuarantorRec: Record Members;
//         Loans: Record Loans;
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Guarantor Updation';
//         ResponseMessage := 'Response received Successfully';
//         /*-------------------------------------------------------------------------------------*/

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;


//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             SavingsAccounts.Get(SkyAuth."Account No.");
//             Members.Get(SavingsAccounts."Member No.");
//             MemberNumber := Members."No.";
//             GuarantorMobileNumber := SavingsAccounts."Transactional Mobile No";
//             if GuarantorMobileNumber = '' then
//                 GuarantorMobileNumber := Members."Phone No.";
//             ResponseMessage := 'Member Found';
//             Status := 'SUCCESS';
//         end;

//         if EntryNo <> 0 then
//             MobileLoans.Get(EntryNo);

//         if Status = 'SUCCESS' then begin
//             if (MobileLoans.Status = MobileLoans.Status::Failed) or (MobileLoans.Status = MobileLoans.Status::Successful) then begin
//                 ResponseMessage := 'Cannot update a ' + Format(MobileLoans.Status) + ' Loan';
//                 Status := 'FAILED';
//             end;
//         end;

//         if Status = 'SUCCESS' then begin
//             if Loans.Get(MobileLoans."Loan No.") then begin
//                 if Loans.Status = Loans.Status::Approved then begin
//                     ResponseMessage := 'Cannot update a ' + Format(Loans.Status) + ' Loan';
//                     Status := 'FAILED';
//                 end;
//             end;
//         end;

//         if Status = 'SUCCESS' then begin
//             MobileLoanGuarantors.Reset;
//             MobileLoanGuarantors.SetRange("Loan Entry No.", EntryNo);
//             MobileLoanGuarantors.SetRange("Guarantor Member No.", MemberNumber);
//             if MobileLoanGuarantors.FindFirst then begin
//                 if GuarantorAction = 'ACCEPT' then begin
//                     MobileLoanGuarantors."Guarantor Accepted" := MobileLoanGuarantors."guarantor accepted"::Yes;
//                     if SavAcc.Get(MobileLoans."Account No") then begin
//                         Priority := 211;
//                         msg := 'Dear ' + Format(MobileLoans."Account Name") + ', ' + MobileLoanGuarantors."Guarantor Name" +
//                         ' has accepted to guarantee the ' + MobileLoans."Loan Name" + ' amounting to KES ' + Format(MobileLoans.Amount) + ' on ' + Format(FormatDate(Today)) + ' ' + Format(Time) +
//                         NewLine + 'REF: ' + Format(MobileLoans."Entry No");
//                         SkyMbanking.SendSms(Source::MBANKING, SavAcc."Transactional Mobile No", msg, SavAcc."No.", '', true, Priority, false);

//                         Priority := 211;
//                         msg := 'Dear ' + Format(MobileLoanGuarantors."Guarantor Name") + ', you have successfully accepted to guarantee ' + MobileLoans."Account Name" +
//                         ' ' + MobileLoans."Loan Name" + ' of KES ' + Format(MobileLoans.Amount) + ' on ' + Format(FormatDate(Today)) + ' ' + Format(Time) + '.' + NewLine + 'REF: ' + Format(SkyMobileLoans."Entry No");
//                         SkyMbanking.SendSms(Source::MBANKING, MobileLoanGuarantors."Guarantor Mobile No.", msg, SavAcc."No.", '', true, Priority, false);

//                         Response := 'SUCCESS';
//                     end;
//                 end else
//                     if Action = 'REJECT' then begin
//                         MobileLoanGuarantors."Guarantor Accepted" := MobileLoanGuarantors."guarantor accepted"::No;
//                         if SavAcc.Get(SkyMobileLoans."Account No") then begin
//                             Priority := 211;
//                             msg := 'Dear ' + Format(MobileLoans."Account Name") + ', ' + MobileLoanGuarantors."Guarantor Name" +
//                             ' has rejected your request to guarantee your ' + MobileLoans."Loan Name" + ' on ' + Format(FormatDate(Today)) + ' ' + Format(Time) +
//                             ' Kindly add a new guarantor.' + NewLine + 'REF: ' + Format(MobileLoans."Entry No");
//                             SkyMbanking.SendSms(Source::MBANKING, SavAcc."Transactional Mobile No", msg, SavAcc."No.", '', true, Priority, false);

//                             Priority := 211;
//                             msg := 'Dear ' + Format(MobileLoanGuarantors."Guarantor Name") + ', you have rejected ' + MobileLoans."Account Name" + '''s request to guarantee ' +
//                             ' ' + MobileLoans."Loan Name" + ' on ' + Format(FormatDate(Today)) + ' ' + Format(Time) + '.' + NewLine + 'REF: ' + Format(MobileLoans."Entry No");
//                             SkyMbanking.SendSms(Source::MBANKING, MobileLoanGuarantors."Guarantor Mobile No.", msg, SavAcc."No.", '', true, Priority, false);
//                             Response := 'SUCCESS';
//                         end;
//                     end;
//                 MobileLoanGuarantors.Modify;
//             end;

//             Commit;

//             MobileLoans.Reset;
//             MobileLoans.SetRange("Entry No", EntryNo);
//             MobileLoans.SetRange(Status, MobileLoans.Status::"Pending Guarantors");
//             MobileLoans.SetRange(Posted, false);
//             if MobileLoans.FindFirst then begin

//                 if SkyMbanking.GetRemainingGuarantorCount(EntryNo) <= 0 then begin
//                     SkyMbanking.UpdateAmountGuaranteed(EntryNo);

//                     if SkyMbanking.MobileGuarantorsAccepted(EntryNo) = true then begin
//                         MobileLoans.Status := MobileLoans.Status::Pending;

//                         if MobileLoans.Source = 'BOSA' then begin
//                             MobileLoans.Status := MobileLoans.Status::Appraisal;
//                             SkyMbanking.CreateLoanRegister(MobileLoans);
//                         end;
//                         MobileLoans.Modify;
//                     end;

//                 end;
//             end;


//             MobileLoans.Reset;
//             MobileLoans.SetRange("Entry No", EntryNo);
//             MobileLoans.SetRange("Loan No.", '');
//             MobileLoans.SetRange(Source, 'BOSA');
//             MobileLoans.SetRange(Status, MobileLoans.Status::Pending);
//             MobileLoans.SetRange(Posted, false);
//             if MobileLoans.FindFirst then begin
//                 MobileLoans.Status := MobileLoans.Status::Appraisal;
//                 SkyMbanking.CreateLoanRegister(MobileLoans);
//             end;



//             MobileLoans.Reset;
//             MobileLoans.SetRange("Entry No", EntryNo);
//             MobileLoans.SetRange("Loan No.", '');
//             MobileLoans.SetRange(Source, 'BOSA');
//             MobileLoans.SetRange(Status, MobileLoans.Status::Appraisal);
//             MobileLoans.SetRange(Posted, false);
//             if MobileLoans.FindFirst then begin
//                 SkyMbanking.CreateLoanRegister(MobileLoans);
//             end;

//             ResponseMessage := 'Response received successfully';
//         end;
//         //    ComplainandRemarks."Complaint Catagory" := FORMAT(JObject3.GetValue('complaint_category'));

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('name');
//         //        LocalJsonTextWriter.WriteValue('name');
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;


//     procedure GetLoanGuarantorshipRequests("Action": Text; Password: Text; Username: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SavingsAccounts: Record "Savings Accounts";
//         MemberNo: Code[30];
//         SkyAuth: Record "Sky USSD Auth";
//         Members: Record Members;
//         SkyPortalSetup: Record "Sky Portal Setup";
//         AccountNo: Code[50];
//         DimensionValue: Record "Dimension Value";
//         SkyMobileLoans: Record "Sky Mobile Loans";
//         MobileLoanGuarantors: Record "Mobile Loan Guarantors";
//         TotalGuaranteed: Decimal;
//         LoaneeDepAcc: Code[30];
//         LoaneeDeposits: Decimal;
//         RequiresAdditionalGuarantor: Code[10];
//         DepAccountRec: Record "Savings Accounts";
//         SkyMabnking: Codeunit "Sky Mbanking";
//         ProductFactory: Record "Product Factory";
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         ResponseTitle := 'Get guarantor requests';

//         if CopyStr(Username, 1, 3) = '254' then Username := '+' + Username;

//         SkyAuth.Reset;
//         if CopyStr(Username, 1, 4) = '+254' then
//             SkyAuth.SetRange("Mobile No.", Username)
//         else
//             SkyAuth.SetRange(SkyAuth.Username, Username);

//         SkyAuth.SetRange(SkyAuth.Password, GetPassFromUserName(Username, Password));
//         if not SkyAuth.FindFirst then begin
//             ResponseMessage := 'Username or Password is incorrect';
//             Status := 'FAILED';
//         end else begin
//             AccountNo := SkyAuth."Account No.";
//             Status := 'SUCCESS';
//         end;

//         if Status = 'SUCCESS' then begin
//             if SavingsAccounts.Get(AccountNo) then begin
//                 MemberNo := SavingsAccounts."Member No.";
//             end else begin
//                 ResponseMessage := 'Member Not Found';
//                 Status := 'FAILED';
//             end;
//         end;

//         // Country.GET( "Code");
//         /*-------------------------------------------------------------------------------------*/
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         if Status = 'SUCCESS' then begin
//             //            LocalJsonTextWriter.WriteStartArray;
//             MobileLoanGuarantors.Reset;
//             MobileLoanGuarantors.SetRange("Guarantor Member No.", MemberNo);
//             MobileLoanGuarantors.SetRange("Guarantor Accepted", MobileLoanGuarantors."guarantor accepted"::Pending);
//             if MobileLoanGuarantors.FindFirst then begin
//                 repeat
//                     SkyMobileLoans.Reset;
//                     SkyMobileLoans.SetRange("Entry No", MobileLoanGuarantors."Loan Entry No.");
//                     SkyMobileLoans.SetFilter(Status, '<>%1', SkyMobileLoans.Status::Failed);
//                     if SkyMobileLoans.FindFirst then begin
//                         //                        LocalJsonTextWriter.WriteStartObject;

//                         ProductFactory.Get(SkyMobileLoans."Loan Product Type");

//                         //                        LocalJsonTextWriter.WritePropertyName('entry_no');
//                         //                        LocalJsonTextWriter.WriteValue(SkyMobileLoans."Entry No");

//                         //                        LocalJsonTextWriter.WritePropertyName('requested_amount');
//                         //                        LocalJsonTextWriter.WriteValue(Format(SkyMobileLoans."Requested Amount"));

//                         //                        LocalJsonTextWriter.WritePropertyName('loanee_name');
//                         //                        LocalJsonTextWriter.WriteValue(Format(SkyMobileLoans."Account Name"));

//                         //                        LocalJsonTextWriter.WritePropertyName('loan_product_name');
//                         //                        LocalJsonTextWriter.WriteValue(Format(ProductFactory."USSD Product Name"));

//                         //                        LocalJsonTextWriter.WritePropertyName('loan_product_code');
//                         //                        LocalJsonTextWriter.WriteValue(Format(ProductFactory."Product ID"));

//                         //                        LocalJsonTextWriter.WritePropertyName('loan_status');
//                         //                        LocalJsonTextWriter.WriteValue(Format(SkyMobileLoans.Status));

//                         //                        LocalJsonTextWriter.WritePropertyName('remarks');
//                         //                        LocalJsonTextWriter.WriteValue(SkyMobileLoans.Remarks);

//                         //                        LocalJsonTextWriter.WritePropertyName('date_entered');
//                         //                        LocalJsonTextWriter.WriteValue(Format(FormatDate(SkyMobileLoans."Date Entered")));

//                         //                        LocalJsonTextWriter.WritePropertyName('expected_guarantors');
//                         //                        LocalJsonTextWriter.WriteValue(Format(SkyMobileLoans."Expected Guarantors"));

//                         //                        LocalJsonTextWriter.WritePropertyName('loan_period');
//                         //                        LocalJsonTextWriter.WriteValue(Format(SkyMobileLoans."Loan Period"));

//                         //                        LocalJsonTextWriter.WritePropertyName('loan_source');
//                         //                        LocalJsonTextWriter.WriteValue(Format(SkyMobileLoans.Source));

//                         //                        LocalJsonTextWriter.WriteEndObject;
//                     end;
//                 until MobileLoanGuarantors.Next = 0;
//             end;
//             //            LocalJsonTextWriter.WriteEndArray;
//             ResponseMessage := 'Guarantor loan requests fetched successfully';
//         end;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, true);

//     end;

//     // trigger Tempjobject::PropertyChanged(sender: Variant; e: dotnet PropertyChangedEventArgs)
//     // begin
//     // end;

//     // trigger Tempjobject::PropertyChanging(sender: Variant; e: dotnet PropertyChangingEventArgs)
//     // begin
//     // end;

//     // trigger Tempjobject::ListChanged(sender: Variant; e: dotnet ListChangedEventArgs)
//     // begin
//     // end;

//     // trigger Tempjobject::AddingNew(sender: Variant; e: dotnet AddingNewEventArgs)
//     // begin
//     // end;

//     // trigger Jsonarray::ListChanged(sender: Variant; e: dotnet ListChangedEventArgs)
//     // begin
//     // end;

//     // trigger Jsonarray::AddingNew(sender: Variant; e: dotnet AddingNewEventArgs)
//     // begin
//     // end;

//     // trigger Jobject::PropertyChanged(sender: Variant; e: dotnet PropertyChangedEventArgs)
//     // begin
//     // end;

//     // trigger Jobject::PropertyChanging(sender: Variant; e: dotnet PropertyChangingEventArgs)
//     // begin
//     // end;

//     // trigger Jobject::ListChanged(sender: Variant; e: dotnet ListChangedEventArgs)
//     // begin
//     // end;

//     // trigger Jobject::AddingNew(sender: Variant; e: dotnet AddingNewEventArgs)
//     // begin
//     // end;
// }

