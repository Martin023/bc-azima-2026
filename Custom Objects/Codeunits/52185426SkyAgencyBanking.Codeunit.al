// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
// Codeunit 52185426 "Sky Agency Banking"
// {
//     // // //


//     trigger OnRun()
//     var
//         Pin: Text;
//         Members: Record Members;
//         SkySMSMessages: Record "Sky SMS Messages";
//     begin
//         Pin := '3a402c5ed7941c9344a95aff3dc715c964eded95263679959cf8302f170e5e4b';

//         //MESSAGE(GetAgentReport('Agent Report',TRUE,'228738',Pin,20210929D,20210929D));
//         /*MESSAGE(RegisterVirtualMember('Register Virtual Member',TRUE,'Msangi Manyatta','34497789','254707889421',20190101D,'T0001','T0001',
//         '17092021','228738','101 MPK','EMPLOYED','SKYWORLD','NAIROBI',TODAY));*/
//         //MESSAGE(GetTransactionLimits('Transactions','WITHDRAWAL'));
//         //MESSAGE(ChangeAgentPassword('Change Password',TRUE,'231738','1f0dc549c053c68ffe58cf9e3f8a8ccc4ec47a502a204de9627a2cd29ced9237','1234'));
//         //MESSAGE(RegisterVirtualMember('Register Member','Cyprian Msangi','34497789','+254723631593',20020101D,'Ambrose','MEM001','',TRUE));
//         //MESSAGE(UpdateVirtualMemberRegistration('Update Virtual Member Registration','MEM001','Path','MEM001','WHY ASK',TRUE));
//         ///MESSAGE(AgentLogin('Agent Login',TRUE,'231738','1234','IMEI','SERIAL','DeviceMake','DeviceModel','DeviceProcessorID','SoftwareID','AppVersionCode','AppEnvironment'));
//         //PerformAgentTransaction('Agent Transfer',TRUE,'AGENT USERNAME','1234','AGENT DEBIT','DEBIT TYPE','CREDIT ACC','TRANS ID','AMOUNT',
//         //'AMOUNT 2',3,'DESCRIPTION','DATE TEXT',TRUE,'IMEI','SERIAL');
//         //MESSAGE(AgentTransactions('TR001','TR001',20210101D,TODAY,'3a402c5ed7941c9344a95aff3dc715c964eded95263679959cf8302f170e5e4b','228738','CASH_WITHDRAWAL'));
//         //MESSAGE(PerformAgentTransaction('Agent Transfer',TRUE,'231738',Pin,'5120187587000','WITH','5050175187000','TR000103',5000,'Ksh 5000',3,'util to Float','21/09/2021',TRUE,'867250030108685','PP35271908001366'));
//         //MESSAGE(AgentMinistatement('TR00W','TR001',3,20210101D,20210101D,'5120187587000','0707889422','3a402c5ed7941c9344a95aff3dc715c964eded95263679959cf8302f170e5e4b','228738'));
//         //MESSAGE(FORMAT(PostAgentTransaction('TR0002','VENDOR')));
//         //MESSAGE(GetUserLoginAttemptExpiry('Agent Login',TRUE,'228738','ATTEMPTS'));
//         //MESSAGE(GetAgentData('Get Agent Data',TRUE,'228738',Pin));

//         //MESSAGE(GetAgentAccounts('Get Agent Accounts',TRUE,'228738','1234','ALL_ACCOUNTS'));

//         //MESSAGE(GetCustomerSearchOptions('Get Search Options',TRUE,'231738',Pin));

//         //MESSAGE(GetCustomerSearchResult('Search result',TRUE,'252262','',
//         //'MEMBER_NUMBER','0135834','WITHDRAWABLE'));

//         //MESSAGE(GetCustomerSearchResult('Serch result',TRUE,'231738',Pin,'MEMBER_NUMBER','0123278','LOANS'));//0079041

//         /*--------CASH_WITHDRAWAL TEST--------------*/

//         /*MESSAGE(PerformTransaction('Perfom Trans',TRUE,'228738',Pin,'5120187587000','5050123278000','FOSA Savings Account','',
//         '','Catherine','0123278','19558','254722368794','CASH_WITHDRAWAL','Withdrawal','TEST00104',50000,'Ksh 50000',
//         3,'Money Withdrawal','09/21/2021',TRUE,'IMEI000001','SERIAL0000001'));*/

//         /*--------CASH_WITHDRAWAL TEST--------------*/
//         /*MESSAGE(PerformTransaction('Perfom Trans',TRUE,'AGNT0001','1234','607AGNT0001','1110015852','RICHARD OKELLO OBONYO','',
//         'Deposit Contr','RICHARD OKELLO OBONYO','0015852','7495149','+25472271a7436','CASH_WITHDRAWAL','Cash Withdrawal','TEST00025',132,'Ksh 132',
//         4,'Cash Withdrawal','27/7/2021',TRUE,'IMEI000001','SERIAL0000001'));*/

//         /*--------CASH_DEPOSIT TEST--------------*/
//         /*MESSAGE(PerformTransaction('Perfom Trans',TRUE,'406416','1234','5120209436000','030008652','Murage Maina Murage','loanNumber',
//         'CustomerLnNam','Murage Maina Murage','0008652','6420928','+254722451627','CASH_DEPOSIT','Deposit','TEST00002',220,'220',
//         3,'Cash Deposit','08/31/2021',TRUE,'IMEI000001','SERIAL0000001'));
//         MESSAGE('Done');*/

//         /*--------ACCOUNT_BALANCE TEST--------------*/
//         /*MESSAGE(PerformTransaction('Perfom Trans',TRUE,'AGNT0001','1234','607AGNT0001','1110015852','RICHARD OKELLO OBONYO','',
//         'Deposit Contr','RICHARD OKELLO OBONYO','0015852','7495149','+254722717436','ACCOUNT_BALANCE','Account Balance','TEST00003',0,'0',
//         3,'Account Balance','23/7/2021',TRUE,'IMEI000001','SERIAL0000001'));
//         MESSAGE('Done');*/

//         /*--------LOAN REPAYMENT TEST--------------*/
//         /*MESSAGE(PerformTransaction('Perfom Trans',TRUE,'228738','1234','5120209436000','5050063382000','Bett','LN00010162',
//         'Jisaidie top Loan','Bett','0063382','0165184','+254714241111','LOAN_PAYMENT','Loan Repayment','TEST00030',5000,'5000',
//         3,'Loan Repayment','08/13/2021',TRUE,'IMEI000001','SERIAL0000001'));
//         MESSAGE('Done');*/

//         /*--------ACCOUNT_STATEMENT TEST--------------*/
//         /*MESSAGE(PerformTransaction('Perfom Trans',TRUE,'AGNT0001','1234','607AGNT0001','1110015852','RICHARD OKELLO OBONYO','',
//         'Deposit Contr','RICHARD OKELLO OBONYO','0015852','7495149','+254722717436','ACCOUNT_STATEMENT','Account Statement','TEST00014',0,'0',
//         4,'Account Statement','23/7/2021',TRUE,'IMEI000001','SERIAL0000001'));
//         MESSAGE('Done');*/

//         /*-----------------------PERFORM TRANSACTION FUNCTION PARAMETERS-----------------------------------------*/
//         /*PerformTransaction(Action : Code[50];Indent : Boolean;AgentUsername : Text;AgentPassword : Text;AgentAccountNumber : Text;
//         CustomerAccountNumber : Text;CustomerAccountName : Text;CustomerLoanNumber : Text;CustomerLoanName : Text;CustomerName : Text;
//         CustomerMemberNumber : Text;CustomerNationalIDNumber : Text;CustomerMobileNumber : Text;TransactionType : Code[50];
//         TransactionName : Text;TransactionSessionID : Text;TransactionAmount : Decimal;TransactionAmountStylized : Text;
//         TransactionStatementCount : Integer;TransactionNarration : Text;TransactionDate : Text;
//         TransactionPrintReceipt : Boolean;DeviceIMEI : Text;DeviceSerialNumber : Text) Response : Text*/

//         /*------------------POST AGENCY-TRANSACTION TEST(Withdrawal)--------------------*/
//         //MESSAGE(FORMAT(PostMpesaTransaction('TEST00001')));

//         /*------------------POST AGENCY-TRANSACTION TEST(Account statement)--------------------*/
//         //MESSAGE(FORMAT(PostMpesaTransaction('A3LLA11')));

//         /*------------------POST AGENCY-TRANSACTION TEST(Account Account Balance)--------------------*/
//         //MESSAGE(FORMAT(PostMpesaTransaction('TEST00010')));

//         /*------------------POST AGENCY-TRANSACTION TEST(Cash Deposit)------------r--------*/
//         //MESSAGE(FORMAT(PostMpesaTransaction('TEST00002')));

//         /*------------------POST AGENCY-TRANSACTION TEST(Loan Payment)--------------------*/
//         //MESSAGE(PostMpesaTransaction('TEST00002'));
//         /*GetCustomerSearchResult(Action : Code[50];Indent : Boolean;AgentUsername : Text;AgentPassword : Text;
//         CustomerSearchOption : Code[50];CustomerSearchData : Text;Accounttype : Text) Response : Text*/

//         //TestFunction();
//         //MESSAGE(FORMAT(GetLessAccountBal('5050123278000')));

//         Message('DONE');

//     end;

//     var
//         JSonString: code[100];//dotnet String;
//         JObject: code[100];//dotnet JObject;
//         ArrayString: Text;
//         JSONArray: code[100];//dotnet JArray;
//         ArrayString1: code[100];//dotnet String;
//         JToken: code[100];//dotnet JToken;
//         TempJObject: code[100];//dotnet JObject;
//         JsonTextWriter: code[100];//dotnet JsonTextWriter;
//         StringBuilder: code[100];//dotnet StringBuilder;
//         StringWriter: code[100];//dotnet StringWriter;
//         JsonFormatting: code[100];//dotnet Formatting;
//         GlobalNULL: Variant;

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

//     local procedure GenerateJSONResponse(Indent: Boolean) Response: Text
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


//     procedure AgentLogin("Action": Code[50]; Indent: Boolean; AgentUsername: Text; AgentPassword: Text; DeviceIMEI: Text; DeviceSerialNumber: Text; DeviceMake: Text; DeviceModel: Text; DeviceProcessorID: Text; SoftwareID: Text; AppVersionCode: Text; AppEnvironment: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SkyAuth: Record "Sky Agency Auth";
//         AttemptsCount: Integer;
//         Checker: Boolean;
//     begin
//         // //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        // LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        // LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         //        // if Indent then begin LocalJsonTextWriter.Formatting := JsonFormatting.Indented; end;
//         /*-------------------------------------------------------------------------------------*/
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         INCORRECT_PIN
//         SUSPENDED
//         BLOCKED
//         ---------------------------
//         */
//         Status := 'FAILED';
//         ResponseTitle := 'Login Failed';
//         ResponseMessage := 'Agent Login Failed';
//         Checker := false;
//         /*---------------------------------------------LOGIN CODE-------------------------------------*/
//         SkyAuth.Reset;
//         SkyAuth.SetRange(Username, AgentUsername);
//         SkyAuth.SetRange(Password, AgentPassword);
//         if SkyAuth.FindFirst then begin
//             Status := 'FAILED';
//             ResponseTitle := 'Login Failed';
//             ResponseMessage := 'Agent Login Failed';
//             Checker := true;

//             if ((SkyAuth."Login Attempts Action" = 'SUSPEND') or (SkyAuth."OTP Attempts Action" = 'SUSPEND')) then begin
//                 if Checker then begin
//                     if ((SkyAuth."Login Attempts Action" = 'SUSPEND') and (SkyAuth."OTP Attempts Action" <> 'SUSPEND')) then begin
//                         if (SkyAuth."Login Attempts Action Expiry" > CurrentDatetime) then begin
//                             Status := 'SUSPENDED';
//                             ResponseTitle := 'Agent Suspended';
//                             ResponseMessage := 'Agent is Suspended';
//                             Checker := false;
//                         end;
//                     end;
//                 end;

//                 if Checker then begin
//                     if ((SkyAuth."Login Attempts Action" <> 'SUSPEND') and (SkyAuth."OTP Attempts Action" = 'SUSPEND')) then begin
//                         if (SkyAuth."OTP Attempts Action Expiry" > CurrentDatetime) then begin
//                             Status := 'SUSPENDED';
//                             ResponseTitle := 'Agent Suspended';
//                             ResponseMessage := 'Agent is Suspended';
//                             Checker := false;
//                         end;
//                     end;
//                 end;

//                 if ((SkyAuth."Login Attempts Action" = 'SUSPEND') and (SkyAuth."OTP Attempts Action" = 'SUSPEND')) then begin
//                     if (SkyAuth."Login Attempts Action Expiry" > SkyAuth."OTP Attempts Action Expiry") then begin
//                         if Checker then begin
//                             if (SkyAuth."Login Attempts Action Expiry" > CurrentDatetime) then begin
//                                 Status := 'FAILED';
//                                 ResponseTitle := 'Agent Suspended';
//                                 ResponseMessage := 'Agent is Suspended';
//                                 Checker := false;
//                             end;
//                         end;
//                     end
//                     else begin
//                         if Checker then begin
//                             if (SkyAuth."OTP Attempts Action Expiry" > CurrentDatetime) then begin
//                                 Status := 'SUSPENDED';
//                                 ResponseTitle := 'Agent Suspended';
//                                 ResponseMessage := 'Agent is Suspended';
//                                 Checker := false;
//                             end;
//                         end;
//                     end;
//                 end;
//             end;



//             if Checker then begin
//                 if (SkyAuth.Status = SkyAuth.Status::Inactive) or (SkyAuth.Status = SkyAuth.Status::" ") then begin
//                     Status := 'BLOCKED';
//                     ResponseTitle := 'Agent Blocked';
//                     ResponseMessage := 'Agent is Blocked';
//                     Checker := false;
//                 end;
//             end;

//             if Checker then begin
//                 if (SkyAuth.Password = AgentPassword) then begin
//                     Status := 'SUCCESS';
//                     ResponseTitle := 'Login Success';
//                     ResponseMessage := 'Agent Login Success';
//                     Checker := true;
//                     if (SkyAuth."Software Activated" = false) then begin
//                         Status := 'SOFTWARE_INACTIVE';
//                         ResponseTitle := 'Login Failed Software Not Activated';
//                         ResponseMessage := 'Software Is Not Activated';
//                         Checker := false;
//                     end;
//                     if (SkyAuth."Device IMEI" <> DeviceIMEI) then begin
//                         Status := 'INVALID_IMEI';
//                         ResponseTitle := 'Invalid Device IMEI';
//                         ResponseMessage := 'Invalid  Device IMEI';
//                         Checker := false;
//                     end;
//                     if (SkyAuth."Device Serial Number" <> DeviceSerialNumber) then begin
//                         Status := 'INVALID_SERIAL_NUMBER';
//                         ResponseTitle := 'Filed Invalid Serial Number';
//                         ResponseMessage := 'Invalid Serial Number';
//                         Checker := false;
//                     end;
//                     /*IF (SkyAuth."Software ID"<> SoftwareID)  THEN BEGIN
//                         Status := 'INVALID_SOFTWARE_ID';
//                         ResponseTitle:= 'Invalid Software ID';
//                         ResponseMessage:= 'Invalid Sofware ID';
//                         Checker := FALSE;
//                     END;*/
//                     /*IF (SkyAuth."Processor ID"<> DeviceProcessorID)  THEN BEGIN
//                         Status := 'INVALID_PROCESSOR_ID';
//                         ResponseTitle:= 'Invalid Device Pocessor ID';
//                         ResponseMessage:= 'Invalid Device Processor ID';
//                         Checker := FALSE;
//                     END;*/
//                 end;
//             end;
//         end
//         else begin
//             if SkyAuth.Get(AgentUsername) then begin
//                 Status := 'INCORRECT_PASSWORD';
//                 ResponseTitle := 'Wrong Username or Password';
//                 ResponseMessage := 'Wrong Username or Password';
//                 Checker := false;
//             end else begin
//                 Status := 'INCORRECT_PASSWORD';
//                 ResponseTitle := 'Wrong Username or Password';
//                 ResponseMessage := 'Wrong Username or Password';
//                 Checker := false;
//             end;
//         end;


//         if Checker then begin
//             SkyAuth."Login Attempts Action" := 'NONE';
//             SkyAuth."Login Attempts Tag" := '';
//             Clear(SkyAuth."Login Attempts Action Expiry");
//             SkyAuth."Login Attempts Count" := 0;
//             SkyAuth.Modify;
//         end;

//         if (ResponseTitle = 'INCORRECT_PIN') then begin
//             if SkyAuth.Get(AgentUsername) then begin
//                 SkyAuth."Login Attempts Count" := SkyAuth."Login Attempts Count" + 1;
//                 SkyAuth.Modify;
//                 AttemptsCount := SkyAuth."Login Attempts Count";
//             end;
//         end;
//         /*---------------------------------------------LOGIN CODE-------------------------------------*/
//         //        // LocalJsonTextWriter.WriteStartObject;
//         //        // LocalJsonTextWriter.WritePropertyName('title');
//         //        // LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        // LocalJsonTextWriter.WritePropertyName('message');
//         //        // LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        // LocalJsonTextWriter.WriteEndObject;

//         // //Payload := LocalStringBuilder.ToString;

//         // /*-------------------------------------------------------------------------------------*/
//         // Response := GenerateJSONResponse(Action, Status, Payload, Indent);

//     end;


//     procedure ChangeAgentPassword("Action": Code[50]; Indent: Boolean; AgentUsername: Text; AgentOldPassword: Text; AgentNewPassword: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         SkyAgencyAuth: Record "Sky Agency Auth";
//         AgentApplications: Record "Agent Applications";
//     begin
//         // //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        // LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        // LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         //        // if Indent then begin LocalJsonTextWriter.Formatting := JsonFormatting.Indented; end;
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
//         ResponseTitle := 'Change Password';
//         ResponseMessage := 'Password changed Failed';
//         /*-------------------------------------------------------------------------------------*/

//         if AgentApplications.Get(AgentUsername) then begin
//             ResponseMessage := 'Agent Found';
//             Status := 'SUCCESS';
//         end else begin
//             ResponseMessage := 'Agent not found';
//             Status := 'FAILED';
//         end;

//         //        // LocalJsonTextWriter.WriteStartObject;
//         //        // LocalJsonTextWriter.WritePropertyName('data');
//         //        // LocalJsonTextWriter.WriteStartObject;
//         //        // LocalJsonTextWriter.WritePropertyName('response');
//         //        // LocalJsonTextWriter.WriteStartArray;

//         if Status = 'SUCCESS' then begin
//             SkyAgencyAuth.Reset;
//             SkyAgencyAuth.SetRange("Agent Code", AgentUsername);
//             SkyAgencyAuth.SetRange(Password, AgentOldPassword);
//             if SkyAgencyAuth.FindFirst then begin
//                 SkyAgencyAuth.Password := AgentNewPassword;
//                 SkyAgencyAuth.Modify;
//                 ResponseMessage := 'Password changed Successfully';
//                 Status := 'SUCCESS';
//             end else begin
//                 ResponseMessage := 'Password changed Failed';
//                 Status := 'FAILED';
//             end;
//         end;

//         //        // LocalJsonTextWriter.WriteEndArray;
//         //        // LocalJsonTextWriter.WriteEndObject;

//         //        // LocalJsonTextWriter.WritePropertyName('title');
//         //        // LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        // LocalJsonTextWriter.WritePropertyName('message');
//         //        // LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        // LocalJsonTextWriter.WriteEndObject;

//         // //Payload := LocalStringBuilder.ToString;

//         // /*-------------------------------------------------------------------------------------*/
//         // Response := GenerateJSONResponse(Action, Status, Payload, Indent);

//     end;


//     procedure GetAgentData("Action": Code[50]; Indent: Boolean; AgentUsername: Text; AgentPassword: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         AgentApplication: Record "Agent Applications";
//         AgentCode: Code[30];
//         SkyAgencies: Record "Sky Agency Companies";
//         AgencyCode: Code[30];
//         SavingsAccounts: Record "Savings Accounts";
//         MemberNo: Code[30];
//         TotalBalances: Decimal;
//         CurrencyCode: Code[30];
//         SkyAgencyAuth: Record "Sky Agency Auth";
//         SkyAgentsTransactions: Record "Sky Agents Transactions";
//         TotalDeposits: Decimal;
//         TotalWithdrawals: Decimal;
//         CommisionsToday: Decimal;
//         CommisionsThisMonth: Decimal;
//         Vendor: Record Vendor;
//         VendorLedgerEntry: Record "Vendor Ledger Entry";
//         VendorCommisions: Decimal;
//         VendorCommsMonth: Decimal;
//         DetailedVendor: Record "Detailed Vendor Ledg. Entry";
//     begin
//         // //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        // LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        // LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         //        // if Indent then begin LocalJsonTextWriter.Formatting := JsonFormatting.Indented; end;
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
//         ResponseTitle := 'Agent Data';
//         ResponseMessage := 'Agent Data Fetched Successfully';
//         /*-------------------------------------------------------------------------------------*/
//         //AgentCode := '';
//         MemberNo := '';

//         //        LocalJsonTextWriter.WriteStartObject;

//         if AgentApplication.Get(AgentUsername) then begin
//             Status := 'SUCCESS';
//         end else begin
//             Status := 'NOT_FOUND';
//             ResponseMessage := 'Agent Not found';
//         end;

//         if Status = 'SUCCESS' then begin
//             if AgentApplication.Get(AgentUsername) then begin
//                 //                // LocalJsonTextWriter.WritePropertyName('data');

//                 //                // LocalJsonTextWriter.WriteStartObject;
//                 //                // LocalJsonTextWriter.WritePropertyName('agency');
//                 //                // LocalJsonTextWriter.WriteStartObject;
//                 //                // LocalJsonTextWriter.WritePropertyName('name');
//                 //                // LocalJsonTextWriter.WriteValue(AgentApplication."Name of the Proposed Agent");
//                 //                // LocalJsonTextWriter.WritePropertyName('location');
//                 //                // LocalJsonTextWriter.WriteValue(AgentApplication."Place of Business");
//                 //                // LocalJsonTextWriter.WritePropertyName('id');
//                 //                // LocalJsonTextWriter.WriteValue(AgentApplication."Agent Code");
//                 //                // LocalJsonTextWriter.WriteEndObject;


//                 //                // //LocalJsonTextWriter.WriteStartObject;
//                 //                // LocalJsonTextWriter.WritePropertyName('user');
//                 //                // LocalJsonTextWriter.WriteStartObject;
//                 //                // LocalJsonTextWriter.WritePropertyName('name');
//                 //                // LocalJsonTextWriter.WriteValue(AgentApplication.Name);
//                 //                // LocalJsonTextWriter.WritePropertyName('username');
//                 //                // LocalJsonTextWriter.WriteValue(AgentUsername);
//                 //                // LocalJsonTextWriter.WritePropertyName('role');
//                 //                // LocalJsonTextWriter.WriteValue(Format(AgentApplication.Role));
//                 //                // LocalJsonTextWriter.WritePropertyName('mobile_number');
//                 //                // //LocalJsonTextWriter.WriteValue('+254723631593');
//                 //                // LocalJsonTextWriter.WriteValue(AgentApplication."Mobile No");
//                 //                // LocalJsonTextWriter.WriteEndObject;
//             end else begin
//                 ResponseMessage := 'Agent not found';
//                 Status := 'FAILED';
//             end;
//         end;

//         if Status = 'SUCCESS' then begin
//             //            // LocalJsonTextWriter.WritePropertyName('accounts');
//             //            // LocalJsonTextWriter.WriteStartArray;
//             SavingsAccounts.Reset;
//             SavingsAccounts.SetCurrentkey("Product Type");
//             SavingsAccounts.SetAscending("Product Type", true);
//             SavingsAccounts.SetRange("ID No.", AgentApplication."Customer ID No");
//             SavingsAccounts.SetFilter("Product Type", '=%1|=%2', '505', '512');
//             if SavingsAccounts.FindFirst then begin
//                 repeat
//                 // SavingsAccounts.CalcFields("Balance (LCY)");
//                 //                    // LocalJsonTextWriter.WriteStartObject;
//                 //                    // LocalJsonTextWriter.WritePropertyName('name');
//                 //                    // LocalJsonTextWriter.WriteValue(SavingsAccounts."Product Name");
//                 //                    // LocalJsonTextWriter.WritePropertyName('number');
//                 //                    // LocalJsonTextWriter.WriteValue(SavingsAccounts."No.");
//                 //                    // LocalJsonTextWriter.WritePropertyName('balances');
//                 //                    // LocalJsonTextWriter.WriteStartObject;
//                 //                    // LocalJsonTextWriter.WritePropertyName('book_balance');
//                 //                    // LocalJsonTextWriter.WriteValue(Format(SavingsAccounts."Balance (LCY)"));
//                 //                    // LocalJsonTextWriter.WritePropertyName('available_balance');
//                 //                    // LocalJsonTextWriter.WriteValue(Format(SavingsAccounts."Balance (LCY)"));
//                 //                    // LocalJsonTextWriter.WriteEndObject;
//                 //                    // LocalJsonTextWriter.WritePropertyName('currency');
//                 //                    // LocalJsonTextWriter.WriteStartObject;
//                 //                    // LocalJsonTextWriter.WritePropertyName('code');
//                 //                    // LocalJsonTextWriter.WriteValue(SavingsAccounts."Currency Code");
//                 //                    // LocalJsonTextWriter.WritePropertyName('symbol');
//                 //                    // LocalJsonTextWriter.WriteValue(SavingsAccounts."Currency Code");
//                 //                    // LocalJsonTextWriter.WriteEndObject;
//                 //                    // LocalJsonTextWriter.WriteEndObject;
//                 until SavingsAccounts.Next = 0;
//             end else begin
//                 ResponseMessage := 'Agent accounts not found';
//             end;
//             //            LocalJsonTextWriter.WriteEndArray;
//         end;

//         if Status = 'SUCCESS' then begin

//             //            LocalJsonTextWriter.WritePropertyName('statistics');
//             //            LocalJsonTextWriter.WriteStartArray;

//             SavingsAccounts.Reset;
//             SavingsAccounts.SetRange("No.", AgentApplication.Account);
//             SavingsAccounts.SetRange("Product Type", '512');
//             //SavingsAccounts.SETFILTER("Date Filter",FORMAT(CALCDATE('-CM',TODAY))+'..'+FORMAT(CALCDATE('CM',TODAY)));
//             if SavingsAccounts.FindFirst then begin
//                 SavingsAccounts.CalcFields("Balance (LCY)");
//                 //                LocalJsonTextWriter.WriteStartObject;
//                 //                LocalJsonTextWriter.WritePropertyName('title');
//                 //                LocalJsonTextWriter.WriteValue('Float Wallet Balance');
//                 //                LocalJsonTextWriter.WritePropertyName('value');
//                 //                LocalJsonTextWriter.WriteValue(Format(SavingsAccounts."Balance (LCY)"));
//                 //                LocalJsonTextWriter.WritePropertyName('type');
//                 //                LocalJsonTextWriter.WriteValue('CURRENCY');
//                 //                LocalJsonTextWriter.WriteEndObject;
//             end;

//             SkyAgentsTransactions.Reset;
//             SkyAgentsTransactions.SetRange("Agent Code", AgentApplication."Agent Code");
//             SkyAgentsTransactions.SetRange(Posted, true);
//             SkyAgentsTransactions.SetRange("Transaction Type", SkyAgentsTransactions."transaction type"::Deposit);
//             SkyAgentsTransactions.SetRange("Transaction Date", Today);
//             if SkyAgentsTransactions.FindFirst then begin
//                 SkyAgentsTransactions.CalcSums(Amount);
//                 TotalDeposits := SkyAgentsTransactions.Amount;
//                 //                LocalJsonTextWriter.WriteStartObject;
//                 //                LocalJsonTextWriter.WritePropertyName('title');
//                 //                LocalJsonTextWriter.WriteValue('Total deposits Today');
//                 //                LocalJsonTextWriter.WritePropertyName('value');
//                 //                LocalJsonTextWriter.WriteValue(Format(TotalDeposits));
//                 //                LocalJsonTextWriter.WritePropertyName('type');
//                 //                LocalJsonTextWriter.WriteValue('CURRENCY');
//                 //                LocalJsonTextWriter.WriteEndObject;
//             end;

//             SkyAgentsTransactions.Reset;
//             SkyAgentsTransactions.SetRange("Agent Code", AgentApplication."Agent Code");
//             SkyAgentsTransactions.SetRange(Posted, true);
//             SkyAgentsTransactions.SetRange("Transaction Type", SkyAgentsTransactions."transaction type"::Withdrawal);
//             SkyAgentsTransactions.SetRange("Transaction Date", Today);
//             if SkyAgentsTransactions.FindFirst then begin
//                 SkyAgentsTransactions.CalcSums(Amount);
//                 //                LocalJsonTextWriter.WriteStartObject;
//                 //                LocalJsonTextWriter.WritePropertyName('title');
//                 //                LocalJsonTextWriter.WriteValue('Total Withdrawals Today');
//                 //                LocalJsonTextWriter.WritePropertyName('value');
//                 //                LocalJsonTextWriter.WriteValue(Format(SkyAgentsTransactions.Amount));
//                 //                LocalJsonTextWriter.WritePropertyName('type');
//                 //                LocalJsonTextWriter.WriteValue('CURRENCY');
//                 //                LocalJsonTextWriter.WriteEndObject;
//             end;

//             VendorCommisions := 0;
//             Vendor.Reset;
//             Vendor.SetRange("No.", AgentApplication."Comm Account");
//             if Vendor.FindFirst then begin
//                 DetailedVendor.Reset;
//                 DetailedVendor.SetRange("Vendor No.", Vendor."No.");
//                 DetailedVendor.SetRange("Posting Date", Today);
//                 if DetailedVendor.FindFirst then begin
//                     repeat
//                         VendorCommisions += DetailedVendor.Amount;
//                     until DetailedVendor.Next = 0;
//                 end;

//                 //                LocalJsonTextWriter.WriteStartObject;
//                 //                LocalJsonTextWriter.WritePropertyName('title');
//                 //                LocalJsonTextWriter.WriteValue('Total Commissions Today');
//                 //                LocalJsonTextWriter.WritePropertyName('value');
//                 //                LocalJsonTextWriter.WriteValue(Format(Abs(VendorCommisions)));
//                 //                LocalJsonTextWriter.WritePropertyName('type');
//                 //                LocalJsonTextWriter.WriteValue('CURRENCY');
//                 //                LocalJsonTextWriter.WriteEndObject;
//             end;

//             VendorCommsMonth := 0;
//             Vendor.Reset;
//             Vendor.SetRange("No.", AgentApplication."Comm Account");
//             if Vendor.FindFirst then begin
//                 DetailedVendor.Reset;
//                 DetailedVendor.SetRange("Vendor No.", Vendor."No.");
//                 DetailedVendor.SetRange("Posting Date", CalcDate('-CM', Today), CalcDate('+CM', Today));
//                 if DetailedVendor.FindFirst then begin
//                     repeat
//                         VendorCommsMonth += DetailedVendor.Amount;
//                     until DetailedVendor.Next = 0;
//                 end;

//                 //                LocalJsonTextWriter.WriteStartObject;
//                 //                LocalJsonTextWriter.WritePropertyName('title');
//                 //                LocalJsonTextWriter.WriteValue('Total Commission this Month');
//                 //                LocalJsonTextWriter.WritePropertyName('value');
//                 //                LocalJsonTextWriter.WriteValue(Format(Abs(VendorCommsMonth)));
//                 //                LocalJsonTextWriter.WritePropertyName('type');
//                 //                LocalJsonTextWriter.WriteValue('CURRENCY');
//                 //                LocalJsonTextWriter.WriteEndObject;
//             end;


//             //            LocalJsonTextWriter.WriteEndArray;
//             //            LocalJsonTextWriter.WriteEndObject;
//         end;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;
//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, Indent);

//     end;


//     procedure GetAgentAccounts("Action": Code[50]; Indent: Boolean; AgentUsername: Text; AgentPassword: Text; AccountType: Code[50]) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SkyAgencyAuth: Record "Sky Agency Auth";
//         AgentCode: Code[30];
//         SavingsAccounts: Record "Savings Accounts";
//         AgentApplication: Record "Agent Applications";
//         ProductFactory: Record "Product Factory";
//         Vendor: Record Vendor;
//     begin
//         /*
//         Possible Account Types:
//         ---------------------------
//         WITHDRAWABLE - Available during customer cash withdrawal
//         DEPOSITABLE - Available during customer cash deposit
//         ALL - Allagent accounts plus FOSA & BOSA
//         TRANSFERRABLE_FROM - Available during agent float top up
//         TRANSFERRABLE_TO - Available during agent float top up
//         ---------------------------
//         */
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         //        if Indent then begin LocalJsonTextWriter.Formatting := JsonFormatting.Indented; end;
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
//         ResponseTitle := 'Agent Accounts';
//         ResponseMessage := 'Agent Accounts Fetched Successfully';
//         /*-------------------------------------------------------------------------------------*/

//         if AgentApplication.Get(AgentUsername) then begin
//             ResponseMessage := 'Agent Found';
//             Status := 'SUCCESS';
//             //AgentCode := SkyAgencyAuth."Agent Code";
//         end else begin
//             ResponseMessage := 'Agent not found';
//             Status := 'FAILED';
//         end;


//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('accounts');
//         //        LocalJsonTextWriter.WriteStartArray;
//         if Status = 'SUCCESS' then begin
//             AgentApplication.Get(AgentUsername);
//             ProductFactory.Reset;
//             ProductFactory.SetRange("Product Category", ProductFactory."product category"::"Agent Account");
//             if ProductFactory.FindFirst then begin
//                 repeat

//                     SavingsAccounts.Reset;
//                     SavingsAccounts.SetRange("Product Type", ProductFactory."Product ID");
//                     SavingsAccounts.SetFilter("ID No.", AgentApplication."Customer ID No");
//                     if SavingsAccounts.FindFirst then begin
//                         repeat
//                             SavingsAccounts.CalcFields("Balance (LCY)");
//                         //                            LocalJsonTextWriter.WriteStartObject;
//                         //                            LocalJsonTextWriter.WritePropertyName('name');
//                         //                            LocalJsonTextWriter.WriteValue(ProductFactory."Product Description");
//                         //                            LocalJsonTextWriter.WritePropertyName('number');
//                         //                            LocalJsonTextWriter.WriteValue(SavingsAccounts."No.");
//                         //                            LocalJsonTextWriter.WritePropertyName('balances');
//                         //                            LocalJsonTextWriter.WriteStartObject;
//                         //                            LocalJsonTextWriter.WritePropertyName('book_balance');
//                         //                            LocalJsonTextWriter.WriteValue(Format(SavingsAccounts."Balance (LCY)"));
//                         //                            LocalJsonTextWriter.WritePropertyName('available_balance');
//                         //                            LocalJsonTextWriter.WriteValue(Format(SavingsAccounts."Balance (LCY)"));
//                         //                            LocalJsonTextWriter.WriteEndObject;
//                         //                            LocalJsonTextWriter.WritePropertyName('currency');
//                         //                            LocalJsonTextWriter.WriteStartObject;
//                         //                            LocalJsonTextWriter.WritePropertyName('code');
//                         //                            LocalJsonTextWriter.WriteValue(SavingsAccounts."Currency Code");
//                         //                            LocalJsonTextWriter.WritePropertyName('symbol');
//                         //                            LocalJsonTextWriter.WriteValue(SavingsAccounts."Currency Code");
//                         //                            LocalJsonTextWriter.WriteEndObject;
//                         //                            LocalJsonTextWriter.WriteEndObject;
//                         until SavingsAccounts.Next = 0;
//                     end;
//                 until ProductFactory.Next = 0;
//             end;


//         end;
//         //        LocalJsonTextWriter.WriteEndArray;
//         //        LocalJsonTextWriter.WritePropertyName('transfer');
//         //        LocalJsonTextWriter.WriteStartArray;
//         /*---------------------------AGENT FOSA ACCOUNT---------------*/
//         AgentApplication.Get(AgentUsername);
//         SavingsAccounts.Reset;
//         SavingsAccounts.SetRange("ID No.", AgentApplication."Customer ID No");
//         SavingsAccounts.SetRange("Product Type", '505');
//         if SavingsAccounts.FindFirst then begin
//             SavingsAccounts.CalcFields("Balance (LCY)");
//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('name');
//             //            LocalJsonTextWriter.WriteValue(SavingsAccounts."Product Name");
//             //            LocalJsonTextWriter.WritePropertyName('allowed_transactions');
//             //            LocalJsonTextWriter.WriteValue('WITHDRAWABLE|DEPOSITABLE');
//             //            LocalJsonTextWriter.WritePropertyName('number');
//             //            LocalJsonTextWriter.WriteValue(SavingsAccounts."No.");
//             //            LocalJsonTextWriter.WritePropertyName('balances');
//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('book_balance');
//             //            LocalJsonTextWriter.WriteValue(Format(SavingsAccounts."Balance (LCY)"));
//             //            LocalJsonTextWriter.WritePropertyName('available_balance');
//             //            LocalJsonTextWriter.WriteValue(Format(SavingsAccounts."Balance (LCY)"));
//             //            LocalJsonTextWriter.WriteEndObject;
//             //            LocalJsonTextWriter.WritePropertyName('currency');
//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('code');
//             //            LocalJsonTextWriter.WriteValue(SavingsAccounts."Currency Code");
//             //            LocalJsonTextWriter.WritePropertyName('symbol');
//             //            LocalJsonTextWriter.WriteValue(SavingsAccounts."Currency Code");
//             //            LocalJsonTextWriter.WriteEndObject;
//             //            LocalJsonTextWriter.WriteEndObject;
//         end;
//         /*---------------------------AGENT COMMISION ACCOUNT---------------*/

//         /*---------------------------AGENT FLOAT ACCOUNT---------------*/
//         AgentApplication.Get(AgentUsername);
//         SavingsAccounts.Get(AgentApplication.Account);
//         SavingsAccounts.CalcFields("Balance (LCY)");
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('name');
//         //        LocalJsonTextWriter.WriteValue(ProductFactory."Product Description");
//         //        LocalJsonTextWriter.WritePropertyName('allowed_transactions');
//         //        LocalJsonTextWriter.WriteValue('WITHDRAWABLE|DEPOSITABLE');
//         //        LocalJsonTextWriter.WritePropertyName('number');
//         //        LocalJsonTextWriter.WriteValue(AgentApplication.Account);
//         //        LocalJsonTextWriter.WritePropertyName('balances');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('book_balance');
//         //        LocalJsonTextWriter.WriteValue(Format(SavingsAccounts."Balance (LCY)"));
//         //        LocalJsonTextWriter.WritePropertyName('available_balance');
//         //        LocalJsonTextWriter.WriteValue(Format(SavingsAccounts."Balance (LCY)"));
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('currency');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('code');
//         //        LocalJsonTextWriter.WriteValue(SavingsAccounts."Currency Code");
//         //        LocalJsonTextWriter.WritePropertyName('symbol');
//         //        LocalJsonTextWriter.WriteValue(SavingsAccounts."Currency Code");
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WriteEndObject;
//         /*---------------------------AGENT FLOAT ACCOUNT---------------*/

//         /*---------------------------AGENT COMMISION ACCOUNT---------------*/
//         AgentApplication.Get(AgentUsername);
//         Vendor.Get(AgentApplication."Comm Account");
//         Vendor.CalcFields("Balance (LCY)");
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('name');
//         //        LocalJsonTextWriter.WriteValue('Commission Account');
//         //        LocalJsonTextWriter.WritePropertyName('allowed_transactions');
//         //        LocalJsonTextWriter.WriteValue('WITHDRAWABLE');
//         //        LocalJsonTextWriter.WritePropertyName('number');
//         //        LocalJsonTextWriter.WriteValue(AgentApplication."Comm Account");
//         //        LocalJsonTextWriter.WritePropertyName('balances');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('book_balance');
//         //        LocalJsonTextWriter.WriteValue(Format(Vendor."Balance (LCY)"));
//         //        LocalJsonTextWriter.WritePropertyName('available_balance');
//         //        LocalJsonTextWriter.WriteValue(Format(Vendor."Balance (LCY)"));
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('currency');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('code');
//         //        LocalJsonTextWriter.WriteValue(Vendor."Currency Code");
//         //        LocalJsonTextWriter.WritePropertyName('symbol');
//         //        LocalJsonTextWriter.WriteValue(Vendor."Currency Code");
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WriteEndObject;
//         /*---------------------------AGENT COMMISION ACCOUNT---------------*/

//         //        LocalJsonTextWriter.WriteEndArray;
//         //        LocalJsonTextWriter.WriteEndObject;



//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);

//         //        LocalJsonTextWriter.WriteEndObject;


//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, Indent);

//     end;


//     procedure GetCustomerSearchOptions("Action": Code[50]; Indent: Boolean; AgentUsername: Text; AgentPassword: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SkyAgencyAuth: Record "Sky Agency Auth";
//         AgentCode: Code[30];
//         SkySearchOptions: Record "Sky Search Options";
//         AgentApplications: Record "Agent Applications";
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         //        if Indent then begin LocalJsonTextWriter.Formatting := JsonFormatting.Indented; end;
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
//         ResponseTitle := 'Customer Search Options';
//         ResponseMessage := 'Customer Search Options Fetched Successfully';
//         /*-------------------------------------------------------------------------------------*/

//         if AgentApplications.Get(AgentUsername) then begin
//             ResponseMessage := 'Agent Found';
//             Status := 'SUCCESS';
//         end else begin
//             ResponseMessage := 'Agent not found';
//             Status := 'FAILED';
//         end;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('options');
//         //        LocalJsonTextWriter.WriteStartArray;

//         if Status = 'SUCCESS' then begin
//             SkySearchOptions.Reset;
//             if SkySearchOptions.FindFirst then begin
//                 repeat
//                 //                    LocalJsonTextWriter.WriteStartObject;
//                 //                    LocalJsonTextWriter.WritePropertyName('id');
//                 //                    LocalJsonTextWriter.WriteValue(SkySearchOptions.ID);
//                 //                    LocalJsonTextWriter.WritePropertyName('caption');
//                 //                    LocalJsonTextWriter.WriteValue(SkySearchOptions.Caption);
//                 //                    LocalJsonTextWriter.WriteEndObject;
//                 until SkySearchOptions.Next = 0;
//             end else begin
//                 ResponseMessage := 'Search Options not found';
//             end;
//         end;

//         //        LocalJsonTextWriter.WriteEndArray;
//         //        LocalJsonTextWriter.WriteEndObject;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, Indent);

//     end;


//     procedure GetCustomerSearchResult("Action": Code[50]; Indent: Boolean; AgentUsername: Text; AgentPassword: Text; CustomerSearchOption: Code[50]; CustomerSearchData: Text; Accounttype: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SkyAgencyAuth: Record "Sky Agency Auth";
//         AgentCode: Code[30];
//         SkySearchOptions: Record "Sky Search Options";
//         Members: Record Members;
//         AgentApplication: Record "Agent Applications";
//         SavingsAccounts: Record "Savings Accounts";
//         MemberNo: Code[30];
//         ProductFactory: Record "Product Factory";
//         Loans: Record Loans;
//         OutstandingBalance: Decimal;
//         OutstandingInterest: Decimal;
//         CountSavings: Integer;
//         FoundLoan: Boolean;
//     begin
//         /*

//         Possible Account Types:
//         ---------------------------
//         WITHDRAWABLE - Available during customer cash withdrawal
//         DEPOSITABLE - Available during customer cash deposit
//         // // ALL - Allagent accounts plus FOSA & BOSA
//         TRANSFERRABLE_FROM - Available during agent float top up
//         TRANSFERRABLE_TO - Available during agent float top up
//         ---------------------------
//         */
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         //        if Indent then begin LocalJsonTextWriter.Formatting := JsonFormatting.Indented; end;
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
//         //        LocalJsonTextWriter.WriteStartObject;

//         ResponseTitle := 'Search Customer Data';
//         ResponseMessage := 'Customer Data Searched Successfully';
//         /*-------------------------------------------------------------------------------------*/


//         if AgentApplication.Get(AgentUsername) then begin
//             ResponseMessage := 'Agent Found';
//             Status := 'SUCCESS';
//             AgentCode := AgentApplication."Agent Code";
//         end else begin
//             ResponseMessage := 'Incorrect Username or Password';
//             Status := 'FAILED';
//         end;

//         if Status = 'SUCCESS' then begin
//             Members.Reset;
//             if CustomerSearchOption = 'MOBILE_NUMBER' then
//                 Members.SetRange("Phone No.", '+' + CustomerSearchData)
//             else
//                 if (CustomerSearchOption = 'NATIONAL_ID_NUMBER') or (CustomerSearchOption = 'SERVICE_NUMBER') then
//                     Members.SetRange("ID No.", CustomerSearchData)// 99428
//                 else
//                     if CustomerSearchOption = 'PASSPORT_NUMBER' then
//                         Members.SetRange("Passport No.", CustomerSearchData)
//                     else
//                         if CustomerSearchOption = 'MEMBER_NUMBER' then
//                             Members.SetRange("No.", CustomerSearchData);//0204111
//             if Members.FindFirst then begin


//                 //                //LocalJsonTextWriter.WriteStartObject;


//                 //                LocalJsonTextWriter.WritePropertyName('data');

//                 MemberNo := Members."No.";
//                 //                LocalJsonTextWriter.WriteStartObject;
//                 //                LocalJsonTextWriter.WritePropertyName('customer');
//                 //                LocalJsonTextWriter.WriteStartObject;
//                 //                LocalJsonTextWriter.WritePropertyName('name');
//                 //                LocalJsonTextWriter.WriteValue(Members.Name);
//                 //                LocalJsonTextWriter.WritePropertyName('mobile_number');
//                 //                //LocalJsonTextWriter.WriteValue('+254723631593');
//                 //                LocalJsonTextWriter.WriteValue(Members."Phone No.");
//                 //                LocalJsonTextWriter.WritePropertyName('id_number');
//                 //                LocalJsonTextWriter.WriteValue(Members."Primary Identification");
//                 //                LocalJsonTextWriter.WritePropertyName('member_number');
//                 //                LocalJsonTextWriter.WriteValue(Members."No.");
//                 //                LocalJsonTextWriter.WritePropertyName('display');
//                 //                LocalJsonTextWriter.WriteStartArray;
//                 //                LocalJsonTextWriter.WriteStartObject;
//                 //                LocalJsonTextWriter.WritePropertyName('title');
//                 //                LocalJsonTextWriter.WriteValue('Name');
//                 //                LocalJsonTextWriter.WritePropertyName('value');
//                 //                LocalJsonTextWriter.WriteValue(Members.Name);
//                 //                LocalJsonTextWriter.WritePropertyName('mask');
//                 //                LocalJsonTextWriter.WriteValue(false);
//                 //                LocalJsonTextWriter.WritePropertyName('mask_regex');
//                 //                LocalJsonTextWriter.WriteValue('');
//                 //                LocalJsonTextWriter.WriteEndObject;
//                 //                LocalJsonTextWriter.WriteStartObject;
//                 //                LocalJsonTextWriter.WritePropertyName('title');
//                 //                LocalJsonTextWriter.WriteValue('Mobile Number');
//                 //                LocalJsonTextWriter.WritePropertyName('value');
//                 //                LocalJsonTextWriter.WriteValue(Members."Phone No.");
//                 //                //LocalJsonTextWriter.WriteValue('+254723631593');
//                 //                LocalJsonTextWriter.WritePropertyName('mask');
//                 //                LocalJsonTextWriter.WriteValue(true);
//                 //                LocalJsonTextWriter.WritePropertyName('mask_regex');
//                 //                LocalJsonTextWriter.WriteValue('<![CDATA[(?<!^.?).(?!.?$)]]>');
//                 //                LocalJsonTextWriter.WriteEndObject;
//                 //                LocalJsonTextWriter.WriteStartObject;
//                 //                LocalJsonTextWriter.WritePropertyName('title');
//                 //                LocalJsonTextWriter.WriteValue('Member Number');
//                 //                LocalJsonTextWriter.WritePropertyName('value');
//                 //                LocalJsonTextWriter.WriteValue(Members."No.");
//                 //                LocalJsonTextWriter.WritePropertyName('mask');
//                 //                LocalJsonTextWriter.WriteValue(true);
//                 //                LocalJsonTextWriter.WritePropertyName('mask_regex');
//                 //                LocalJsonTextWriter.WriteValue('<![CDATA[(?<!^.?).(?!.?$)]]>');
//                 //                LocalJsonTextWriter.WriteEndObject;
//                 //                LocalJsonTextWriter.WriteStartObject;
//                 //                LocalJsonTextWriter.WritePropertyName('title');
//                 //                LocalJsonTextWriter.WriteValue('National ID Number');
//                 //                LocalJsonTextWriter.WritePropertyName('value');
//                 //                LocalJsonTextWriter.WriteValue(Members."Primary Identification");
//                 //                LocalJsonTextWriter.WritePropertyName('mask');
//                 //                LocalJsonTextWriter.WriteValue(true);
//                 //                LocalJsonTextWriter.WritePropertyName('mask_regex');
//                 //                LocalJsonTextWriter.WriteValue('<![CDATA[\d.{4}]]>');
//                 //                LocalJsonTextWriter.WriteEndObject;
//                 //                LocalJsonTextWriter.WriteEndArray;


//                 //                LocalJsonTextWriter.WritePropertyName('accounts');
//                 //                LocalJsonTextWriter.WriteStartArray;

//                 CountSavings := 0;
//                 ProductFactory.Reset;
//                 if Accounttype = 'CASH_DEPOSIT' then
//                     ProductFactory.SetFilter("Allowed Transaction", '=%1|=%2', ProductFactory."allowed transaction"::"Deposit Only", ProductFactory."allowed transaction"::"Withdraw & Deposit")
//                 else
//                     if Accounttype = 'WITHDRAWABLE' then
//                         ProductFactory.SetRange("Allowed Transaction", ProductFactory."allowed transaction"::"Withdraw & Deposit")
//                     else
//                         if Accounttype = 'ALL_ACCOUNTS' then
//                             ProductFactory.SetFilter("Allowed Transaction", '=%1|=%2', ProductFactory."allowed transaction"::"Deposit Only", ProductFactory."allowed transaction"::"Withdraw & Deposit")
//                         else
//                             if Accounttype = 'ACCOUNT_BALANCE' then
//                                 ProductFactory.SetFilter("Product ID", '<>%1&<>%2&<>%3&<>%2&<>%4', '01', '05', '06', '506', '04')
//                             else
//                                 if Accounttype = 'LOAN' then
//                                     ProductFactory.SetRange("Product ID", '');
//                 if ProductFactory.FindFirst then begin
//                     repeat
//                         SavingsAccounts.Reset;
//                         SavingsAccounts.SetRange("Member No.", Members."No.");
//                         SavingsAccounts.SetRange("Product Type", ProductFactory."Product ID");
//                         if (Accounttype = 'CASH_DEPOSIT') or (Accounttype = 'ALL_ACCOUNTS') or (Accounttype = 'WITHDRAWABLE') then
//                             SavingsAccounts.SetFilter(Status, '=%1|=%2', SavingsAccounts.Status::New, SavingsAccounts.Status::Active);
//                         if SavingsAccounts.FindFirst then begin
//                             repeat
//                                 CountSavings += 1;
//                                 SavingsAccounts.CalcFields("Balance (LCY)");
//                             //                                LocalJsonTextWriter.WriteStartObject;
//                             //                                LocalJsonTextWriter.WritePropertyName('name');
//                             //                                LocalJsonTextWriter.WriteValue(SavingsAccounts."Product Name");
//                             //                                LocalJsonTextWriter.WritePropertyName('number');
//                             //                                LocalJsonTextWriter.WriteValue(SavingsAccounts."No.");
//                             //                                LocalJsonTextWriter.WritePropertyName('balances');
//                             //                                LocalJsonTextWriter.WriteStartObject;
//                             //                                LocalJsonTextWriter.WritePropertyName('book_balance');
//                             //                                LocalJsonTextWriter.WriteValue(Format(SavingsAccounts."Balance (LCY)"));
//                             //                                LocalJsonTextWriter.WritePropertyName('available_balance');
//                             //                                LocalJsonTextWriter.WriteValue(Format(GetLessAccountBal(SavingsAccounts."No.")));
//                             //                                LocalJsonTextWriter.WriteEndObject;
//                             //                                LocalJsonTextWriter.WritePropertyName('currency');
//                             //                                LocalJsonTextWriter.WriteStartObject;
//                             //                                LocalJsonTextWriter.WritePropertyName('code');
//                             //                                LocalJsonTextWriter.WriteValue(SavingsAccounts."Currency Code");
//                             //                                LocalJsonTextWriter.WritePropertyName('symbol');
//                             //                                LocalJsonTextWriter.WriteValue(SavingsAccounts."Currency Code");
//                             //                                LocalJsonTextWriter.WriteEndObject;
//                             //                                LocalJsonTextWriter.WriteEndObject;
//                             until SavingsAccounts.Next = 0;
//                         end;
//                     until ProductFactory.Next = 0;
//                 end;

//                 //                LocalJsonTextWriter.WriteEndArray;
//                 if (Accounttype <> 'LOAN') and (CountSavings = 0) then begin
//                     Status := 'FAILED';
//                     ResponseMessage := 'You do not have have any active account';
//                 end;
//                 //                LocalJsonTextWriter.WritePropertyName('loans');
//                 //                LocalJsonTextWriter.WriteStartArray;
//                 FoundLoan := false;
//                 ProductFactory.Reset;
//                 if Accounttype = 'LOAN' then
//                     ProductFactory.SetRange("Product Class Type", ProductFactory."product class type"::Loan);
//                 if ProductFactory.FindFirst then begin
//                     repeat
//                         Loans.Reset;
//                         Loans.SetRange("Member No.", Members."No.");
//                         Loans.SetRange("Loan Product Type", ProductFactory."Product ID");
//                         Loans.SetFilter("Outstanding Balance", '>%1', 0);
//                         if Loans.FindFirst then begin
//                             repeat
//                                 FoundLoan := true;
//                                 Loans.CalcFields("Outstanding Interest", "Outstanding Balance");
//                                 OutstandingBalance := Loans."Outstanding Balance";
//                                 OutstandingInterest := Loans."Outstanding Interest";
//                                 if OutstandingBalance < 0 then OutstandingBalance := 0;
//                                 if OutstandingInterest < 0 then OutstandingInterest := 0;

//                                 if (Loans."Outstanding Balance" + Loans."Outstanding Interest") > 0 then begin
//                                     //                                    LocalJsonTextWriter.WriteStartObject;
//                                     //                                    LocalJsonTextWriter.WritePropertyName('name');
//                                     //                                    LocalJsonTextWriter.WriteValue(Loans."Loan Product Type Name");
//                                     //                                    LocalJsonTextWriter.WritePropertyName('number');
//                                     //                                    LocalJsonTextWriter.WriteValue(Loans."Loan No.");
//                                     //                                    LocalJsonTextWriter.WritePropertyName('balances');
//                                     //                                    LocalJsonTextWriter.WriteStartObject;
//                                     //                                    LocalJsonTextWriter.WritePropertyName('outstanding_balance');
//                                     //                                    LocalJsonTextWriter.WriteValue(Format(OutstandingBalance));
//                                     //                                    LocalJsonTextWriter.WritePropertyName('outstanding_interest');
//                                     //                                    LocalJsonTextWriter.WriteValue(Format(OutstandingInterest));
//                                     //                                    LocalJsonTextWriter.WritePropertyName('arrears');
//                                     //                                    LocalJsonTextWriter.WriteValue(Format(GetLoanBalance(Loans."Loan No.")));
//                                     //                                    LocalJsonTextWriter.WriteEndObject;
//                                     //                                    LocalJsonTextWriter.WritePropertyName('currency');
//                                     //                                    LocalJsonTextWriter.WriteStartObject;
//                                     //                                    LocalJsonTextWriter.WritePropertyName('code');
//                                     //                                    LocalJsonTextWriter.WriteValue(Loans."Currency Code");
//                                     //                                    LocalJsonTextWriter.WritePropertyName('symbol');
//                                     //                                    LocalJsonTextWriter.WriteValue(Loans."Currency Code");
//                                     //                                    LocalJsonTextWriter.WriteEndObject;
//                                     //                                    LocalJsonTextWriter.WriteEndObject;
//                                 end;
//                             until Loans.Next = 0;

//                         end;
//                     until ProductFactory.Next = 0;
//                     if (FoundLoan = false) and (Accounttype = 'LOAN') then begin
//                         Status := 'FAILED';
//                         ResponseMessage := 'You do not have have any active loan.';
//                     end;
//                 end;

//                 //                LocalJsonTextWriter.WriteEndArray;

//                 //                LocalJsonTextWriter.WriteEndObject;
//                 //                LocalJsonTextWriter.WriteEndObject;
//                 //                //LocalJsonTextWriter.WriteEndObject;
//             end else begin
//                 if Status = 'SUCCESS' then begin
//                     Status := 'FAILED';
//                     ResponseMessage := 'The system could not find a customer with the information you provided. Please check and try again.';
//                 end;
//             end;
//         end;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;
//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, Indent);

//     end;


//     procedure PerformTransaction("Action": Code[50]; Indent: Boolean; AgentUsername: Text; AgentPassword: Text; AgentAccountNumber: Text; CustomerAccountNumber: Text; CustomerAccountName: Text; CustomerLoanNumber: Text; CustomerLoanName: Text; CustomerName: Text; CustomerMemberNumber: Text; CustomerNationalIDNumber: Text; CustomerMobileNumber: Text; TransactionType: Code[50]; TransactionName: Text; TransactionSessionID: Text; TransactionAmount: Decimal; TransactionAmountStylized: Text; TransactionStatementCount: Integer; TransactionNarration: Text; TransactionDate: Text; TransactionPrintReceipt: Boolean; DeviceIMEI: Text; DeviceSerialNumber: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         PrintData: Text;
//         DisplayData: Text;
//         SMSData: Text;
//         hr: label '<hr/>';
//         br: label '<br/>';
//         logo: label '<logo/>';
//         cdata_open: label '<![CDATA[';
//         cdata_close: label ']]>';
//         TransactionAccountText: Text;
//         TransactionText: Text;
//         StatementText: Text;
//         Iterator: Integer;
//         LineBreak: Text;
//         SkyAgencyAuth: Record "Sky Agency Auth";
//         SavingsAccounts: Record "Savings Accounts";
//         SkyAgentsTransactions: Record "Sky Agents Transactions";
//         AgentTarriffHeader: Record "Agent Tarriff Header";
//         SafcomFee: Decimal;
//         SaccoFee: Decimal;
//         VendorCommission: Decimal;
//         PrePaymentGL: Code[30];
//         SMSAccount: Code[30];
//         SMSCharge: Decimal;
//         Type: Option Daily,Weekly,Monthly;
//         Limit: Decimal;
//         SafcomCharges: Record "Sky Safcom Corporate Charges";
//         TotalCharge: Decimal;
//         ExciseDuty: Decimal;
//         ExciseDutyRate: Decimal;
//         ExciseDutyGL: Code[30];
//         TransType: Option ,CASH_WITHDRAWAL,CASH_DEPOSIT,ACCOUNT_BALANCE,ACCOUNT_STATEMENT,LOAN_REPAYMENT;
//         SavingsLedgerEntry: Record "Savings Ledger Entry";
//         AgentAplication: Record "Agent Applications";
//         SkyAgentWithdrawalsBuffer: Record "Sky Agent Withdrawals Buffer";
//         Members: Record Members;
//         MemberNumber: Code[30];
//         Loans: Record Loans;
//         SkyAgencyCompanies: Record "Sky Agency Companies";
//         SkyAgencyDevices: Record "Sky Agency Devices";
//         CompanyInformation: Record "Company Information";
//         AgentAccNumber: Code[30];
//         AgentCommisionAccNumber: Code[30];
//         AgentTariffDetails: Record "Agent Tariff Details";
//         AgentComm: Decimal;
//         SaccoAcc: Code[30];
//         VendorCommAcc: Code[30];
//         AgentCode: Code[30];
//         AgentSavAcc: Record "Savings Accounts";
//         PostingDateFormated: Text;
//         CharacterCount: Integer;
//         SavAcc: Record "Savings Accounts";
//         OutstandingBal: Decimal;
//         OutstandingInt: Decimal;
//         Arrears: Decimal;
//         CustomerSav: Record "Savings Accounts";
//         TotalLoanBalance: Decimal;
//         AgentSMS: Text;
//         SendAgentSMS: Boolean;
//         SendCustomerSMS: Boolean;
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         //        if Indent then begin LocalJsonTextWriter.Formatting := JsonFormatting.Indented; end;
//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         INCORRECT_PIN
//         SUSPENDED
//         BLOCKED
//         ---------------------------
//         Possible Transaction Types:
//         CASH_WITHDRAWAL
//         CASH_DEPOSIT
//         ACCOUNT_BALANCE
//         ACCOUNT_STATEMENT
//         LOAN_PAYMENT
//         */
//         LineBreak := 'xx';
//         LineBreak[1] := 13;
//         LineBreak[2] := 10;

//         ResponseTitle := 'Agent Transaction';
//         ResponseMessage := 'Dear user, an error occured while processing your request, kindly try again later.';
//         AgentSMS := '';
//         SendAgentSMS := false;
//         SendCustomerSMS := true;
//         /*-------------------------------------------------------------------------------------*/

//         //Member number

//         if SavingsAccounts.Get(CustomerAccountNumber) then
//             MemberNumber := SavingsAccounts."Member No.";
//         if Loans.Get(CustomerLoanNumber) then
//             MemberNumber := Loans."Member No.";

//         if AgentAplication.Get(AgentUsername) then begin
//             ResponseMessage := 'Agent Found';
//             Status := 'SUCCESS';
//             AgentAccNumber := AgentAplication.Account;
//             AgentCommisionAccNumber := AgentAplication."Comm Account";
//             AgentCode := AgentAplication."Agent Code";
//         end else begin
//             ResponseMessage := 'Incorrect Username or Password';
//             Status := 'FAILED';
//         end;


//         if CustomerMemberNumber = '' then begin
//             ResponseMessage := 'You are not a member of the sacco';
//             Status := 'FAILED';
//         end;

//         if SavingsAccounts.Get(AgentAccountNumber) then begin
//             if SavingsAccounts."Member No." = CustomerMemberNumber then begin
//                 ResponseMessage := 'You cannot do a self transaction';
//                 Status := 'FAILED';
//             end;
//         end;



//         if Status = 'SUCCESS' then begin
//             SkyAgentsTransactions.Reset;
//             SkyAgentsTransactions.SetRange("Transaction ID", TransactionSessionID);
//             if SkyAgentsTransactions.FindFirst then begin
//                 ResponseMessage := 'Transaction Already Exists';
//                 Status := 'FAILED';
//             end;
//         end;
//         AgentAplication.Get(AgentUsername);

//         if Status = 'SUCCESS' then begin
//             AgentSavAcc.Get(AgentAccNumber);
//             AgentSavAcc.CalcFields("Balance (LCY)");

//             if (TransactionType = 'LOAN_PAYMENT') or (TransactionType = 'CASH_DEPOSIT') then begin
//                 if TransactionAmount > (AgentSavAcc."Balance (LCY)" - 500) then begin
//                     ResponseMessage := 'Agent balance KES: ' + Format(AgentSavAcc."Balance (LCY)" - 500) + ' is less than the transaction amount KES ' + Format(TransactionAmount);
//                     Status := 'FAILED';
//                 end;
//             end;
//         end;
//         /*----------------------------------------START: COOP CHECK UP -------------------------------------------------------*/
//         SafcomFee := 0;
//         SaccoFee := 0;
//         VendorCommission := 0;
//         PrePaymentGL := '';
//         SMSAccount := '';
//         SMSCharge := 0;

//         AgentTarriffHeader.Reset;
//         if TransactionType = 'CASH_WITHDRAWAL' then
//             AgentTarriffHeader.SetRange(Code, 'WITHDRAWAL')
//         else
//             if TransactionType = 'CASH_DEPOSIT' then
//                 AgentTarriffHeader.SetRange(Code, 'DEPOSIT')
//             else
//                 if TransactionType = 'ACCOUNT_BALANCE' then
//                     AgentTarriffHeader.SetRange(Code, 'BALANCE ENQ')
//                 else
//                     if TransactionType = 'ACCOUNT_STATEMENT' then
//                         AgentTarriffHeader.SetRange(Code, 'MINISTATEMENT')
//                     else
//                         if TransactionType = 'LOAN_PAYMENT' then
//                             AgentTarriffHeader.SetRange(Code, 'LN_REPAYMENT')
//                         else
//                             if TransactionType = 'LOAN_BALANCE' then
//                                 AgentTarriffHeader.SetRange(Code, 'LOAN_BALANCE');
//         if AgentTarriffHeader.FindFirst then begin
//             if TransactionType = 'CASH_WITHDRAWAL' then begin

//                 if CustomerSav.Get(CustomerAccountNumber) then begin
//                     CustomerSav.CalcFields("Balance (LCY)");
//                     if Status = 'SUCCESS' then begin
//                         if CustomerSav."Balance (LCY)" - (GetLessAccountBal(CustomerAccountNumber) + 1000) < 1000 then begin
//                             ResponseMessage := 'Your account balance is less than KES 1000';
//                             Status := 'FAILED';
//                         end;
//                     end;
//                     if Status = 'SUCCESS' then begin
//                         if TransactionAmount > (CustomerSav."Balance (LCY)" - 1000) then begin
//                             ResponseMessage := 'Insufficient Balance';
//                             Status := 'FAILED';
//                         end;
//                     end;
//                 end;
//                 if AgentTarriffHeader."Transaction Limit" > 0 then begin
//                     if Status = 'SUCCESS' then begin
//                         if TransactionAmount > AgentTarriffHeader."Transaction Limit" then begin
//                             ResponseMessage := 'Transaction Amount Exceeds the Limit of KES ' + Format(AgentTarriffHeader."Transaction Limit");
//                             Status := 'FAILED';
//                         end;
//                     end;
//                 end;
//                 if Status = 'SUCCESS' then begin
//                     if AgentTarriffHeader."Daily Limit" > 0 then begin
//                         Limit := AgentTarriffHeader."Daily Limit" - GetAmountTransacted('WITHDRAWAL', CustomerAccountNumber, Dt2Date(CurrentDatetime), Type::Daily);
//                         if Limit < 0 then
//                             Limit := 0;
//                         if Limit < TransactionAmount then begin
//                             if SavingsAccounts.Get(CustomerAccountNumber) then begin
//                                 //Priority := 211;
//                                 ResponseMessage := 'Transaction Amount has Exceeded the Daily of KES ' + Format(AgentTarriffHeader."Daily Limit");
//                                 Status := 'FAILED';
//                             end;
//                         end;
//                     end;
//                 end;
//                 if Status = 'SUCCESS' then begin
//                     if AgentTarriffHeader."Weekly Limit" > 0 then begin
//                         Limit := AgentTarriffHeader."Weekly Limit" - GetAmountTransacted('WITHDRAWAL', CustomerAccountNumber, Dt2Date(CurrentDatetime), Type::Weekly);
//                         if Limit < 0 then
//                             Limit := 0;
//                         if Limit < TransactionAmount then begin
//                             if SavingsAccounts.Get(CustomerAccountNumber) then begin
//                                 //Priority := 211;
//                                 ResponseMessage := 'Transaction Amount has Exceeded the Weekly Limit of KES ' + Format(AgentTarriffHeader."Weekly Limit");
//                                 Status := 'FAILED';
//                             end;
//                         end;
//                     end;
//                 end;
//                 if Status = 'SUCCESS' then begin
//                     if AgentTarriffHeader."Monthly Limit" > 0 then begin
//                         Limit := AgentTarriffHeader."Monthly Limit" - GetAmountTransacted('WITHDRAWAL', CustomerAccountNumber, Dt2Date(CurrentDatetime), Type::Monthly);
//                         if Limit < 0 then
//                             Limit := 0;
//                         if Limit < TransactionAmount then begin
//                             if SavingsAccounts.Get(CustomerAccountNumber) then begin
//                                 //Priority := 211;
//                                 ResponseMessage := 'Transaction Amount has Exceeded the Monthly Limit of KES ' + Format(AgentTarriffHeader."Monthly Limit");
//                                 Status := 'FAILED';
//                             end;
//                         end;
//                     end;
//                 end;
//             end;

//             if Status = 'SUCCESS' then begin
//                 AgentTariffDetails.Reset;
//                 AgentTariffDetails.SetRange(Code, AgentTarriffHeader.Code);
//                 if AgentTariffDetails.FindFirst then begin
//                     if TransactionType = 'CASH_WITHDRAWAL' then begin
//                         if TransactionAmount < AgentTariffDetails."Lower Limit" then begin
//                             ResponseMessage := 'You cannot withdraw less than KES ' + Format(AgentTariffDetails."Lower Limit");
//                             Status := 'FAILED';
//                         end;
//                     end;
//                     SaccoFee := AgentTariffDetails."Sacco Comm";
//                     AgentComm := AgentTariffDetails."Agent Comm";
//                     VendorCommission := AgentTariffDetails."Vendor Comm";
//                 end;
//             end;
//             //If Tiered
//             if Status = 'SUCCESS' then begin
//                 if AgentTarriffHeader.Tiered then begin
//                     AgentTariffDetails.Reset;
//                     AgentTariffDetails.SetRange(Code, AgentTarriffHeader.Code);
//                     AgentTariffDetails.SetFilter("Lower Limit", '<=%1', TransactionAmount);
//                     AgentTariffDetails.SetFilter("Upper Limit", '>=%1', TransactionAmount);
//                     if AgentTariffDetails.FindFirst then begin
//                         SaccoFee := AgentTariffDetails."Sacco Comm";
//                         AgentComm := AgentTariffDetails."Agent Comm";
//                         VendorCommission := AgentTariffDetails."Vendor Comm";
//                     end;
//                 end;
//             end;

//             SaccoAcc := AgentTarriffHeader."Sacco Comm Acc";
//             AgentCommisionAccNumber := AgentAplication."Comm Account";
//             ;
//             VendorCommAcc := AgentTarriffHeader."Vendor Comm Acc";



//             TotalCharge := SaccoFee + VendorCommission + AgentComm;
//             ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);
//         end
//         else begin
//             ResponseMessage := 'Set up Missing';
//             Status := 'FAILED';
//         end;
//         /*----------------------------------------END: COOP CHECK UP -------------------------------------------------------*/


//         //        LocalJsonTextWriter.WriteStartObject;

//         TransactionAccountText := '';
//         TransactionAccountText += 'A/C: ' + CustomerAccountName + br;
//         TransactionAccountText += 'A/C No.: ' + MaskFuction(CustomerAccountNumber) + br;

//         TransactionText := '';
//         StatementText := '';

//         SMSData := '';
//         SMSData += 'Dear Member,' + LineBreak;

//         ExciseDutyGL := GetExciseDutyGL();
//         ExciseDutyRate := GetExciseRate();
//         ExciseDuty := 0;

//         if TransactionType = 'CASH_WITHDRAWAL' then begin
//             TransactionText += hr + br;
//             TransactionText += 'Amount: KES ' + Format(TransactionAmount) + br;
//             TransactionText += 'Charge: KES ' + Format(TotalCharge + ExciseDuty) + br;
//             TransactionText += 'Reference: ' + TransactionSessionID + br;
//             if TransactionNarration <> '' then begin
//                 TransactionText += 'Narration: ' + TransactionNarration + br;
//             end;
//             TransactionText += 'Date: ' + TransactionDate + br;
//             TransactionText += hr + br;

//             if Status = 'SUCCESS' then begin
//                 SavingsAccounts.Reset;
//                 SavingsAccounts.SetRange("No.", CustomerAccountNumber);
//                 if SavingsAccounts.FindFirst then begin
//                     SavingsAccounts.CalcFields("Balance (LCY)");
//                     if ((SavingsAccounts.Status <> SavingsAccounts.Status::Active) and (SavingsAccounts.Status <> SavingsAccounts.Status::New)) or (SavingsAccounts.Blocked = SavingsAccounts.Blocked::All)
//                     or (SavingsAccounts.Blocked = SavingsAccounts.Blocked::Debit) then begin
//                         ResponseMessage := 'Account is either blocked or inactive';
//                         Status := 'FAILED';
//                     end else begin
//                         if TransactionAmount <= SavingsAccounts."Balance (LCY)" then begin
//                             //Insert into agency transactions
//                             SkyAgentsTransactions.Init;
//                             SkyAgentsTransactions."Entry No." := CreateGuid;
//                             SkyAgentsTransactions."Transaction ID" := TransactionSessionID;
//                             SkyAgentsTransactions."Session ID" := TransactionSessionID;
//                             SkyAgentsTransactions."Agent Code" := AgentCode;
//                             SkyAgentsTransactions."Transaction Type" := SkyAgentsTransactions."transaction type"::Withdrawal;
//                             SkyAgentsTransactions."Transaction Name" := TransactionName;
//                             SkyAgentsTransactions.Description := CopyStr(TransactionNarration, 1, 50);
//                             SkyAgentsTransactions."Transaction Date" := Dt2Date(CurrentDatetime);
//                             SkyAgentsTransactions."Transaction Time" := Dt2Time(CurrentDatetime);
//                             SkyAgentsTransactions."Member Account" := CustomerAccountNumber;
//                             SkyAgentsTransactions."Agent Commision Account" := AgentCommisionAccNumber;
//                             SkyAgentsTransactions."Member No" := MemberNumber;
//                             SkyAgentsTransactions.Amount := TransactionAmount;
//                             SkyAgentsTransactions."Agent Account Number" := AgentAccNumber;
//                             SkyAgentsTransactions."Loan No." := '';
//                             SkyAgentsTransactions."Mobile No." := CustomerMobileNumber;
//                             SkyAgentsTransactions."Vendor Commission" := VendorCommission;
//                             SkyAgentsTransactions."Sacco Fee" := SaccoFee;
//                             SkyAgentsTransactions."Paybill Member ID" := '';
//                             SkyAgentsTransactions.Insert;

//                             ResponseMessage := 'Transaction Successful';
//                             Status := 'SUCCESS';
//                             SMSData += 'your cash withdrawal of KES ' + Format(TransactionAmount) + ' at ' + AgentAplication."Name of the Proposed Agent" + '(' + AgentUsername + ')' + ' has been processed successfully.';
//                             SMSData += LineBreak + 'Kindly collect KES ' + Format(TransactionAmount) + ' from the agent.';

//                             AgentSMS := 'Dear Agent,' + LineBreak + 'Kindly give KES ' + Format(TransactionAmount) + ' to ' + CustomerName;
//                             AgentSMS += LineBreak + 'Txn: ' + TransactionName;
//                             AgentSMS += LineBreak + 'Date: ' + TransactionDate;
//                             AgentSMS += LineBreak + 'Ref: ' + TransactionSessionID;
//                             SendAgentSMS := true;

//                             /*-----------------------START: Insert agent withdrwals transactions in the buffer----------------------------*/
//                             SkyAgentWithdrawalsBuffer.Init;
//                             SkyAgentWithdrawalsBuffer."Session ID" := TransactionSessionID;
//                             SkyAgentWithdrawalsBuffer."Trace ID" := CreateGuid;
//                             SkyAgentWithdrawalsBuffer."Transaction Date" := Dt2Date(CurrentDatetime);
//                             SkyAgentWithdrawalsBuffer."Account No" := CustomerAccountNumber;
//                             SkyAgentWithdrawalsBuffer.Description := CopyStr(TransactionNarration, 1, 50);
//                             SkyAgentWithdrawalsBuffer.Amount := TransactionAmount;
//                             SkyAgentWithdrawalsBuffer."Unit ID" := 'AGENCY';
//                             SkyAgentWithdrawalsBuffer."Transaction Type" := 'CASH_WITHDRAWAL';
//                             SkyAgentWithdrawalsBuffer."Transaction Date" := Dt2Date(CurrentDatetime);
//                             SkyAgentWithdrawalsBuffer.Source := SkyAgentWithdrawalsBuffer.Source::AGENCY;
//                             SkyAgentWithdrawalsBuffer."Agent Acount" := AgentAccNumber;
//                             SkyAgentWithdrawalsBuffer.Insert;
//                             /*-----------------------START: Insert agent withdrwals transactions in the buffer----------------------------*/
//                         end else begin
//                             ResponseMessage := 'Insufficient balance';
//                             Status := 'FAILED';
//                         end;
//                     end;
//                 end;
//             end else begin
//                 SMSData += 'your cash withdrawal of KES ' + Format(TransactionAmount) + ' from your ' + CustomerAccountName + ' at ' + AgentAplication."Name of the Proposed Agent" + '(' + AgentUsername + ')' + ' has Failed.';

//                 AgentSMS := 'Dear Agent,' + LineBreak + 'The ' + TransactionName + ' transaction of KES ' + Format(TransactionAmount) + ' for ' + CustomerName + ' has failed.';
//                 AgentSMS += LineBreak + 'Date: ' + TransactionDate;
//                 AgentSMS += LineBreak + 'Ref: ' + TransactionSessionID;
//                 SendAgentSMS := true;
//             end;

//         end
//         else
//             if TransactionType = 'CASH_DEPOSIT' then begin
//                 TransactionText += hr + br;
//                 TransactionText += 'Amount: KES ' + Format(TransactionAmount) + br;
//                 //TransactionText += 'Charge: KES '+FORMAT(TotalCharge+ExciseDuty)+br;
//                 TransactionText += 'Reference: ' + TransactionSessionID + br;
//                 if TransactionNarration <> '' then begin
//                     TransactionText += 'Narration: ' + TransactionNarration + br;
//                 end;
//                 TransactionText += 'Date: ' + TransactionDate + br;
//                 TransactionText += hr + br;

//                 /*------------------------------------------START: Deposit transaction--------------------------------------*/
//                 if Status = 'SUCCESS' then begin
//                     SavingsAccounts.Reset;
//                     SavingsAccounts.SetRange("No.", CustomerAccountNumber);
//                     if SavingsAccounts.FindFirst then begin
//                         SavingsAccounts.CalcFields("Balance (LCY)");
//                         if ((SavingsAccounts.Status <> SavingsAccounts.Status::Active) and (SavingsAccounts.Status <> SavingsAccounts.Status::New)) or (SavingsAccounts.Blocked = SavingsAccounts.Blocked::All)
//                         or (SavingsAccounts.Blocked = SavingsAccounts.Blocked::Debit) then begin
//                             ResponseMessage := 'Account is either blocked or inactive';
//                             Status := 'FAILED';
//                         end else begin
//                             //Insert into agency transactions
//                             SkyAgentsTransactions.Init;
//                             SkyAgentsTransactions."Entry No." := CreateGuid;
//                             SkyAgentsTransactions."Transaction ID" := TransactionSessionID;
//                             SkyAgentsTransactions."Session ID" := TransactionSessionID;
//                             SkyAgentsTransactions."Agent Code" := AgentCode;
//                             SkyAgentsTransactions."Transaction Type" := SkyAgentsTransactions."transaction type"::Deposit;
//                             SkyAgentsTransactions."Transaction Name" := TransactionName;
//                             SkyAgentsTransactions.Description := CopyStr(TransactionNarration, 1, 50);
//                             ;
//                             SkyAgentsTransactions."Transaction Date" := Dt2Date(CurrentDatetime);
//                             SkyAgentsTransactions."Transaction Time" := Dt2Time(CurrentDatetime);
//                             SkyAgentsTransactions."Member Account" := CustomerAccountNumber;
//                             SkyAgentsTransactions.Amount := TransactionAmount;
//                             SkyAgentsTransactions."Agent Account Number" := AgentAccNumber;
//                             SkyAgentsTransactions."Agent Commision Account" := AgentCommisionAccNumber;
//                             SkyAgentsTransactions."Loan No." := '';
//                             SkyAgentsTransactions."Mobile No." := CustomerMobileNumber;
//                             SkyAgentsTransactions."Member No" := MemberNumber;
//                             SkyAgentsTransactions."Vendor Commission" := VendorCommission;
//                             SkyAgentsTransactions."Sacco Fee" := SaccoFee;
//                             SkyAgentsTransactions."Paybill Member ID" := '';
//                             SkyAgentsTransactions.Insert;

//                             ResponseMessage := 'Transaction Successful';
//                             Status := 'SUCCESS';
//                             SMSData += 'your cash deposit of KES ' + Format(TransactionAmount) + ' to your ' + CustomerAccountName + ' at ' + AgentAplication."Name of the Proposed Agent" + '(' + AgentUsername + ')' + ' has been processed successfully.';
//                             SMSData += LineBreak + 'Kindly give KES ' + Format(TransactionAmount) + ' to the agent.';

//                             AgentSMS := 'Dear Agent,' + LineBreak + 'Kindly collect KES ' + Format(TransactionAmount) + ' from ' + CustomerName;
//                             AgentSMS += LineBreak + 'Txn: ' + TransactionName;
//                             AgentSMS += LineBreak + 'Date: ' + TransactionDate;
//                             AgentSMS += LineBreak + 'Ref: ' + TransactionSessionID;
//                             SendAgentSMS := true;
//                         end;
//                     end;
//                 end else begin
//                     SMSData += 'your cash deposit of KES ' + Format(TransactionAmount) + ' from your ' + CustomerAccountName + ' at ' + AgentAplication."Name of the Proposed Agent" + '(' + AgentUsername + ')' + ' has Failed.';

//                     AgentSMS := 'Dear Agent,' + LineBreak + 'The ' + TransactionName + ' transaction of KES ' + Format(TransactionAmount) + ' for ' + CustomerName + ' has failed.';
//                     AgentSMS += LineBreak + 'Date: ' + TransactionDate;
//                     AgentSMS += LineBreak + 'Ref: ' + TransactionSessionID;
//                     SendAgentSMS := true;
//                 end;
//                 /*------------------------------------------END:   Deposit transaction------------------------------------- */
//             end
//             else
//                 if TransactionType = 'LOAN_PAYMENT' then begin
//                     TransactionAccountText := '';
//                     TransactionAccountText += 'Loan: ' + CustomerLoanName + br;
//                     TransactionAccountText += 'Loan No.: ' + MaskFuction(CustomerLoanNumber) + br;

//                     TransactionText += hr + br;
//                     TransactionText += 'Amount: KES ' + Format(TransactionAmount) + br;
//                     //TransactionText += 'Charge: KES '+FORMAT(TotalCharge+ExciseDuty)+br;
//                     TransactionText += 'Reference: ' + TransactionSessionID + br;
//                     if TransactionNarration <> '' then begin
//                         TransactionText += 'Narration: ' + TransactionNarration + br;
//                     end;
//                     TransactionText += 'Date: ' + TransactionDate + br;
//                     TransactionText += hr + br;

//                     /*------------------------------------------START: Loan Repayment--------------------------------------*/
//                     if Status = 'SUCCESS' then begin
//                         //Insert into agency transactions
//                         SkyAgentsTransactions.Init;
//                         SkyAgentsTransactions."Entry No." := CreateGuid;
//                         SkyAgentsTransactions."Transaction ID" := TransactionSessionID;
//                         SkyAgentsTransactions."Session ID" := TransactionSessionID;
//                         SkyAgentsTransactions."Agent Code" := AgentCode;
//                         SkyAgentsTransactions."Transaction Type" := SkyAgentsTransactions."transaction type"::LoanRepayment;
//                         SkyAgentsTransactions."Transaction Name" := TransactionName;
//                         SkyAgentsTransactions.Description := CopyStr(TransactionNarration, 1, 50);
//                         ;
//                         SkyAgentsTransactions."Transaction Date" := Dt2Date(CurrentDatetime);
//                         SkyAgentsTransactions."Transaction Time" := Dt2Time(CurrentDatetime);
//                         SkyAgentsTransactions."Member Account" := CustomerAccountNumber;
//                         SkyAgentsTransactions."Member No" := MemberNumber;
//                         SkyAgentsTransactions.Amount := TransactionAmount;
//                         SkyAgentsTransactions."Agent Account Number" := AgentAccNumber;
//                         SkyAgentsTransactions."Agent Commision Account" := AgentCommisionAccNumber;
//                         SkyAgentsTransactions."Loan No." := CustomerLoanNumber;
//                         SkyAgentsTransactions."Mobile No." := CustomerMobileNumber;
//                         SkyAgentsTransactions."Vendor Commission" := VendorCommission;
//                         SkyAgentsTransactions."Sacco Fee" := SaccoFee;
//                         SkyAgentsTransactions."Paybill Member ID" := '';
//                         SkyAgentsTransactions.Insert;

//                         ResponseMessage := 'Transaction Successful';
//                         Status := 'SUCCESS';
//                         SMSData += 'your loan payment of KES ' + Format(TransactionAmount) + ' at ' + AgentAplication."Name of the Proposed Agent" + '(' + AgentUsername + ')' + ' has been processed successfully.';
//                         SMSData += LineBreak + 'Kindly give KES ' + Format(TransactionAmount) + ' to the agent.';

//                         AgentSMS := 'Dear Agent,' + LineBreak + 'Kindly collect KES ' + Format(TransactionAmount) + ' from ' + CustomerName;
//                         AgentSMS += LineBreak + 'Transaction: ' + TransactionName;
//                         AgentSMS += LineBreak + 'Date: ' + TransactionDate;
//                         AgentSMS += LineBreak + 'Ref: ' + TransactionSessionID;
//                         SendAgentSMS := true;
//                     end else begin
//                         SMSData += 'your ' + TransactionName + ' transaction of ' + TransactionAmountStylized + ' at ' + AgentAplication."Name of the Proposed Agent" + '(' + AgentUsername + ')' + ' has Failed.';

//                         AgentSMS := 'Dear Agent,' + LineBreak + 'The ' + TransactionName + ' transaction of KES ' + Format(TransactionAmount) + ' for ' + CustomerName + ' has failed.';
//                         AgentSMS += LineBreak + 'Date: ' + TransactionDate;
//                         AgentSMS += LineBreak + 'Ref: ' + TransactionSessionID;
//                         SendAgentSMS := true;
//                     end;
//                     /*------------------------------------------END:   Loan Repaymnet------------------------------------- */
//                 end
//                 else
//                     if TransactionType = 'ACCOUNT_BALANCE' then begin
//                         SavingsAccounts.Get(CustomerAccountNumber);
//                         SavingsAccounts.CalcFields("Balance (LCY)");
//                         TransactionText += hr + br;
//                         TransactionText += 'Balance: KES ' + Format(SavingsAccounts."Balance (LCY)" - (GetLessAccountBal(CustomerAccountNumber))) + br;
//                         TransactionText += 'Charge: KES ' + Format(TotalCharge + ExciseDuty) + br;
//                         TransactionText += 'Reference: ' + TransactionSessionID + br;
//                         if TransactionNarration <> '' then begin
//                             TransactionText += 'Narration: ' + TransactionNarration + br;
//                         end;
//                         TransactionText += 'Date: ' + TransactionDate + br;
//                         TransactionText += hr + br;
//                         /*------------------------------------------START: Account Balance--------------------------------------*/

//                         if Status = 'SUCCESS' then begin
//                             //Insert into agency transactions
//                             SkyAgentsTransactions.Init;
//                             SkyAgentsTransactions."Entry No." := CreateGuid;
//                             SkyAgentsTransactions."Transaction ID" := TransactionSessionID;
//                             SkyAgentsTransactions."Session ID" := TransactionSessionID;
//                             SkyAgentsTransactions."Agent Code" := AgentCode;
//                             SkyAgentsTransactions."Transaction Type" := SkyAgentsTransactions."transaction type"::Balance;
//                             SkyAgentsTransactions."Transaction Name" := TransactionName;
//                             SkyAgentsTransactions.Description := CopyStr(TransactionNarration, 1, 50);
//                             ;
//                             SkyAgentsTransactions."Transaction Date" := Dt2Date(CurrentDatetime);
//                             SkyAgentsTransactions."Transaction Time" := Dt2Time(CurrentDatetime);
//                             SkyAgentsTransactions."Member Account" := CustomerAccountNumber;
//                             SkyAgentsTransactions."Member No" := MemberNumber;
//                             SkyAgentsTransactions.Amount := TransactionAmount;
//                             SkyAgentsTransactions."Agent Account Number" := AgentAccNumber;
//                             SkyAgentsTransactions."Agent Commision Account" := AgentCommisionAccNumber;
//                             SkyAgentsTransactions."Loan No." := CustomerLoanNumber;
//                             SkyAgentsTransactions."Mobile No." := CustomerMobileNumber;
//                             SkyAgentsTransactions."Vendor Commission" := VendorCommission;
//                             SkyAgentsTransactions."Sacco Fee" := SaccoFee;
//                             SkyAgentsTransactions."Paybill Member ID" := '';
//                             SkyAgentsTransactions.Insert;

//                             ResponseMessage := 'Transaction Successful';
//                             Status := 'SUCCESS';
//                             SMSData += 'your account balance enquiry at ' + AgentAplication."Name of the Proposed Agent" + '(' + AgentUsername + ')' + ' has been processed successfully.';
//                             SMSData += LineBreak + 'Your account balance is KES ' + Format(SavingsAccounts."Balance (LCY)");
//                         end else begin
//                             SMSData += 'your account balance enquiry at ' + AgentAplication."Name of the Proposed Agent" + '(' + AgentUsername + ')' + ' has been has Failed.';
//                         end;
//                         /*------------------------------------------END:   Account Balance------------------------------------- */
//                     end
//                     else
//                         if TransactionType = 'LOAN_BALANCE' then begin
//                             TransactionAccountText := '';
//                             TransactionAccountText += 'Loan: ' + CustomerLoanName + br;
//                             TransactionAccountText += 'Loan No.: ' + MaskFuction(CustomerLoanNumber) + br;

//                             OutstandingBal := 0;
//                             OutstandingInt := 0;
//                             Arrears := 0;
//                             GetLoanBalance2(CustomerLoanNumber, OutstandingBal, OutstandingInt, Arrears);
//                             TransactionText += hr + br;
//                             TransactionText += 'Outstanding Bal: KES ' + Format(OutstandingBal) + br;
//                             TransactionText += 'Outstanding Int: KES ' + Format(OutstandingInt) + br;
//                             TransactionText += 'Arrears' + Format(Arrears) + br;
//                             TransactionText += 'Charge: KES ' + Format(TotalCharge + ExciseDuty) + br;
//                             TransactionText += 'Reference: ' + TransactionSessionID + br;
//                             if TransactionNarration <> '' then begin
//                                 TransactionText += 'Narration: ' + TransactionNarration + br;
//                             end;
//                             TransactionText += 'Date: ' + TransactionDate + br;
//                             TransactionText += hr + br;
//                             /*------------------------------------------START: Account Balance--------------------------------------*/
//                             TotalLoanBalance := OutstandingBal + OutstandingInt + Arrears;
//                             if Status = 'SUCCESS' then begin
//                                 //Insert into agency transactions
//                                 SkyAgentsTransactions.Init;
//                                 SkyAgentsTransactions."Entry No." := CreateGuid;
//                                 SkyAgentsTransactions."Transaction ID" := TransactionSessionID;
//                                 SkyAgentsTransactions."Session ID" := TransactionSessionID;
//                                 SkyAgentsTransactions."Agent Code" := AgentCode;
//                                 SkyAgentsTransactions."Transaction Type" := SkyAgentsTransactions."transaction type"::Balance;
//                                 SkyAgentsTransactions."Transaction Name" := TransactionName;
//                                 SkyAgentsTransactions.Description := CopyStr(TransactionNarration, 1, 50);
//                                 ;
//                                 SkyAgentsTransactions."Transaction Date" := Dt2Date(CurrentDatetime);
//                                 SkyAgentsTransactions."Transaction Time" := Dt2Time(CurrentDatetime);
//                                 SkyAgentsTransactions."Member Account" := CustomerAccountNumber;
//                                 SkyAgentsTransactions."Member No" := MemberNumber;
//                                 SkyAgentsTransactions.Amount := TransactionAmount;
//                                 SkyAgentsTransactions."Agent Account Number" := AgentAccNumber;
//                                 SkyAgentsTransactions."Agent Commision Account" := AgentCommisionAccNumber;
//                                 SkyAgentsTransactions."Loan No." := CustomerLoanNumber;
//                                 SkyAgentsTransactions."Mobile No." := CustomerMobileNumber;
//                                 SkyAgentsTransactions."Vendor Commission" := VendorCommission;
//                                 SkyAgentsTransactions."Sacco Fee" := SaccoFee;
//                                 SkyAgentsTransactions."Paybill Member ID" := '';
//                                 SkyAgentsTransactions.Insert;

//                                 ResponseMessage := 'Transaction Successful';
//                                 Status := 'SUCCESS';
//                                 SMSData += 'your loan balance enquiry at ' + AgentAplication."Name of the Proposed Agent" + '(' + AgentUsername + ')' + ' has been processed successfully.';
//                                 SMSData += LineBreak + 'Your loan balance is KES ' + Format(TotalLoanBalance);
//                             end else begin
//                                 SMSData += 'your loan balance enquiry at ' + AgentAplication."Name of the Proposed Agent" + '(' + AgentUsername + ')' + ' has Failed.';
//                             end;
//                             /*------------------------------------------END:   Loan Balance------------------------------------- */
//                         end
//                         else
//                             if TransactionType = 'ACCOUNT_STATEMENT' then begin
//                                 TransactionText += hr + br;
//                                 TransactionText += 'Charge: KES ' + Format(TotalCharge + ExciseDuty) + br;
//                                 TransactionText += 'Reference: ' + TransactionSessionID + br;
//                                 if TransactionNarration <> '' then begin
//                                     TransactionText += 'Narration: ' + TransactionNarration + br;
//                                 end;
//                                 TransactionText += 'Date: ' + TransactionDate + br;
//                                 //Account Balance
//                                 SavingsAccounts.Get(CustomerAccountNumber);
//                                 SavingsAccounts.CalcFields("Balance (LCY)");
//                                 Iterator := 0;
//                                 if Status = 'SUCCESS' then begin
//                                     SMSData += 'your account statement enquiry at ' + AgentAplication."Name of the Proposed Agent" + '(' + AgentUsername + ')' + ' has been processed successfully.';
//                                     SavingsLedgerEntry.Reset;
//                                     SavingsLedgerEntry.SetCurrentkey("Posting Date");
//                                     SavingsLedgerEntry.SetRange("Customer No.", CustomerAccountNumber);
//                                     if SavingsLedgerEntry.FindLast then begin
//                                         StatementText += hr + br;

//                                         repeat//***
//                                             PostingDateFormated := FormatDate(SavingsLedgerEntry."Posting Date");
//                                             StatementText += PostingDateFormated + ' ' + Format(SavingsLedgerEntry."Posting Time") + ', ';
//                                             StatementText += SavingsLedgerEntry.Description + ', ';
//                                             StatementText += 'KES ' + Format(SavingsLedgerEntry.Amount) + ';' + br;

//                                             if Iterator = 1 then
//                                                 SMSData += '[';

//                                             SMSData += Format(SavingsLedgerEntry."Posting Date") + ' ' + Format(SavingsLedgerEntry."Posting Time") + ';';
//                                             SMSData += SavingsLedgerEntry.Description + ';';
//                                             SMSData += 'KES ' + Format(SavingsLedgerEntry.Amount) + ';';
//                                             SMSData += 'Bal: KES ' + Format(SavingsAccounts."Balance (LCY)");

//                                             if Iterator = TransactionStatementCount then begin
//                                                 SMSData += ']';
//                                             end
//                                             else begin
//                                                 SMSData += '],';
//                                             end;
//                                             Iterator += 1;
//                                             SavingsLedgerEntry.Next(-1);
//                                         until Iterator = TransactionStatementCount;
//                                         StatementText += hr + br;
//                                     end;
//                                 end;
//                                 /*-----------------------------START: Register the transaction--------------------------------------*/
//                                 if Status = 'SUCCESS' then begin
//                                     //Insert into agency transactions
//                                     SkyAgentsTransactions.Init;
//                                     SkyAgentsTransactions."Entry No." := CreateGuid;
//                                     SkyAgentsTransactions."Transaction ID" := TransactionSessionID;
//                                     SkyAgentsTransactions."Session ID" := TransactionSessionID;
//                                     SkyAgentsTransactions."Agent Code" := AgentCode;
//                                     SkyAgentsTransactions."Transaction Type" := SkyAgentsTransactions."transaction type"::Ministatment;
//                                     SkyAgentsTransactions."Transaction Name" := TransactionName;
//                                     SkyAgentsTransactions.Description := CopyStr(TransactionNarration, 1, 50);
//                                     ;
//                                     SkyAgentsTransactions."Transaction Date" := Dt2Date(CurrentDatetime);
//                                     SkyAgentsTransactions."Transaction Time" := Dt2Time(CurrentDatetime);
//                                     SkyAgentsTransactions."Member Account" := CustomerAccountNumber;
//                                     SkyAgentsTransactions."Member No" := MemberNumber;
//                                     SkyAgentsTransactions.Amount := TransactionAmount;
//                                     SkyAgentsTransactions."Agent Account Number" := AgentAccNumber;
//                                     SkyAgentsTransactions."Agent Commision Account" := AgentCommisionAccNumber;
//                                     SkyAgentsTransactions."Loan No." := CustomerLoanNumber;
//                                     SkyAgentsTransactions."Mobile No." := CustomerMobileNumber;
//                                     SkyAgentsTransactions."Vendor Commission" := VendorCommission;
//                                     SkyAgentsTransactions."Sacco Fee" := SaccoFee;
//                                     SkyAgentsTransactions."Paybill Member ID" := '';
//                                     SkyAgentsTransactions.Insert;

//                                     ResponseMessage := 'Transaction Successful';
//                                     Status := 'SUCCESS';
//                                 end;
//                                 /*-----------------------------END:   Register the transaction--------------------------------------*/
//                             end;
//         AgentAplication.Get(AgentUsername);
//         CompanyInformation.Get;
//         if Status = 'SUCCESS' then begin
//             if not PostMpesaTransaction(TransactionSessionID) then begin
//                 Status := 'FAILED';
//                 ResponseMessage := 'Error during posting';
//             end;
//         end;
//         if Status = 'SUCCESS' then begin
//             if TransactionNarration <> '' then
//                 //SMSData += ' Narration: '+TransactionNarration;
//                 SMSData += LineBreak + 'Date: ' + TransactionDate;
//             SMSData += LineBreak + 'Ref: ' + TransactionSessionID;
//             //SMSData += ' Thnnk you for banking with us';

//             PrintData := '';
//             PrintData += cdata_open + logo + br;
//             PrintData += CompanyInformation.Name + br;
//             PrintData += hr + br;
//             PrintData += 'Center: ' + CompanyInformation."Phone No." + br;
//             PrintData += 'Center: ' + CompanyInformation."E-Mail" + br;
//             PrintData += hr + br;
//             PrintData += 'Title: ' + TransactionName + br;
//             PrintData += hr + br;
//             PrintData += 'Agency: ' + AgentAplication."Name of the Proposed Agent" + br;
//             PrintData += 'Location: ' + AgentAplication."Place of Business" + br;
//             PrintData += 'Agent ID: ' + AgentAplication."Agent Code" + br;
//             PrintData += 'Operator: ' + AgentAplication.Name + br;
//             PrintData += hr + br;
//             PrintData += 'Customer' + br;
//             PrintData += 'Name: ' + CustomerName + br;
//             PrintData += 'Phone Number: ' + CopyStr(CustomerMobileNumber, 1, 5) + '*****' + CopyStr(CustomerMobileNumber, 11, 3) + br;
//             PrintData += TransactionAccountText;
//             PrintData += TransactionText;
//             PrintData += StatementText;
//             PrintData += 'Footer: Thank you for banking with us' + br;
//             PrintData += 'Barcode: ' + TransactionSessionID + cdata_close;
//         end;
//         DisplayData := PrintData;

//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('print');
//         //        LocalJsonTextWriter.WriteValue(PrintData);
//         //        LocalJsonTextWriter.WritePropertyName('display');
//         //        LocalJsonTextWriter.WriteValue(DisplayData);
//         //        LocalJsonTextWriter.WritePropertyName('sms');
//         //        LocalJsonTextWriter.WriteValue(SMSData);
//         //        LocalJsonTextWriter.WritePropertyName('agent_sms');
//         //        LocalJsonTextWriter.WriteValue(AgentSMS);
//         //        LocalJsonTextWriter.WritePropertyName('send_customer_sms');
//         //        LocalJsonTextWriter.WriteValue(SendCustomerSMS);
//         //        LocalJsonTextWriter.WritePropertyName('send_agent_sms');
//         //        LocalJsonTextWriter.WriteValue(SendAgentSMS);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;



//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, Indent);

//     end;


//     procedure GetAmountTransacted(Transaction: Text; AccountNo: Code[20]; Date: Date; Type: Option Daily,Weekly,Monthly) Amt: Decimal
//     var
//         SaccoFee: Decimal;
//         VendorCommission: Decimal;
//         TransactionType: Option " ","Mpesa Withdrawal","Mpesa Deposit","Utility Payment","Loan Repayment","Balance Enquiry","Mini-Statement","Loan Disbursement","Account Transfer","Pay Loan From Account",Paybill,"Mobile App Login","Bank Transfer";
//         TotalCharge: Decimal;
//         SavAcc: Record "Savings Accounts";
//         MpesaTrans: Record "Sky Agents Transactions";
//         Continue: Boolean;
//         AccBal: Decimal;
//         SafcomCharges: Record "Staff Allowance Lines";
//         SafcomAcc: Code[20];
//         SafcomFee: Decimal;
//         TransactionDate: DateTime;
//         MemberID: Code[20];
//         PrePaymentGL: Code[20];
//         Loans: Record Loans;
//         LoanNo: Code[20];
//         MemberNo: Code[20];
//         SkyAgentWithdrawalsBuffer: Record "Sky Agent Withdrawals Buffer";
//     begin
//         Amt := 0;

//         if Transaction = 'WITHDRAWAL' then begin
//             SkyAgentWithdrawalsBuffer.Reset;
//             SkyAgentWithdrawalsBuffer.SetRange(SkyAgentWithdrawalsBuffer.Reversed, false);
//             SkyAgentWithdrawalsBuffer.SetRange(SkyAgentWithdrawalsBuffer."Account No", AccountNo);
//             if Type = Type::Daily then
//                 SkyAgentWithdrawalsBuffer.SetRange(SkyAgentWithdrawalsBuffer."Transaction Date", Date);
//             if Type = Type::Weekly then
//                 SkyAgentWithdrawalsBuffer.SetRange(SkyAgentWithdrawalsBuffer."Transaction Date", CalcDate('-CW', Date), CalcDate('CW', Date));
//             if Type = Type::Monthly then
//                 SkyAgentWithdrawalsBuffer.SetRange(SkyAgentWithdrawalsBuffer."Transaction Date", CalcDate('-CM', Date), CalcDate('CM', Date));
//             if SkyAgentWithdrawalsBuffer.Find('-') then begin
//                 SkyAgentWithdrawalsBuffer.CalcSums(Amount);
//                 Amt := SkyAgentWithdrawalsBuffer.Amount;
//             end;
//         end;
//     end;


//     procedure GetChargeAmount("Code": Code[20]; var ChargeAmt: Decimal; TransAmount: Decimal; var VendorCharge: Decimal; var SkyCharge: Decimal)
//     var
//         TransactionTypes: Record "Transaction Types";
//         TransCharges: Record "Transaction Charges";
//         TariffDetails: Record "Tiered Charges Lines";
//     begin

//         ChargeAmt := 0;
//         VendorCharge := 0;


//         TransactionTypes.Reset;
//         TransactionTypes.SetRange(Code, Code);
//         TransactionTypes.SetRange(Type, TransactionTypes.Type::"38");
//         if TransactionTypes.Find('-') then begin
//             TransCharges.Reset;
//             TransCharges.SetRange("Transaction Type", TransactionTypes.Code);
//             if TransCharges.Find('-') then begin
//                 //ChargeAcc := TransCharges."G/L Account";

//                 if TransCharges."Charge Type" = TransCharges."charge type"::"Flat Amount" then begin
//                     ChargeAmt := TransCharges."Charge Amount";
//                 end;
//                 if TransCharges."Charge Type" = TransCharges."charge type"::"% of Amount" then begin
//                     ChargeAmt := ROUND(TransCharges."Percentage of Amount" / 100 * TransAmount);
//                 end;
//                 if TransCharges."Charge Type" = TransCharges."charge type"::Staggered then begin

//                     TariffDetails.Reset;
//                     TariffDetails.SetRange(TariffDetails.Code, TransCharges."Staggered Charge Code");
//                     if TariffDetails.Find('-') then begin
//                         repeat
//                             if (TransAmount >= TariffDetails."Lower Limit") and (TransAmount <= TariffDetails."Upper Limit") then begin
//                                 if TariffDetails."Use Percentage" = true then begin
//                                     ChargeAmt := TransAmount * TariffDetails.Percentage * 0.01;
//                                 end
//                                 else begin
//                                     ChargeAmt := TariffDetails."Charge Amount";
//                                     VendorCharge := TariffDetails."External Vendor Charge";
//                                     SkyCharge := TariffDetails."Mobile Vendor Charge";
//                                 end;
//                             end
//                         until TariffDetails.Next = 0;
//                     end;
//                 end;



//             end;
//         end;
//     end;


//     procedure GetExciseRate() rate: Integer
//     var
//         GenSetup: Record "General Set-Up";
//     begin
//         GenSetup.Get;
//         GenSetup.TestField(GenSetup."Excise Duty (%)");
//         rate := GenSetup."Excise Duty (%)";
//     end;


//     procedure GetExciseDutyGL() account: Text[20]
//     var
//         GenSetup: Record "General Set-Up";
//     begin
//         GenSetup.Reset;
//         GenSetup.Get;
//         GenSetup.TestField(GenSetup."Excise Duty G/L");
//     end;


//     procedure PostMpesaTransaction(SessionID: Code[30]) Response: Boolean
//     var
//         SaccoFee: Decimal;
//         VendorCommission: Decimal;
//         TotalCharge: Decimal;
//         SavAcc: Record "Savings Accounts";
//         SaccoAccount: Code[20];
//         VendorAccount: Code[20];
//         SkyAgentsTransactions: Record "Sky Agents Transactions";
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
//     begin
//         Response := true;
//         SkyAgentsTransactions.Reset;
//         SkyAgentsTransactions.SetRange("Session ID", SessionID);
//         SkyAgentsTransactions.SetRange(Posted, false);
//         SkyAgentsTransactions.SetRange("Needs Change", false);
//         if SkyAgentsTransactions.FindFirst then begin
//             repeat
//                 GenSetup.Get;
//                 AgentCode := SkyAgentsTransactions."Agent Code";

//                 // Get Excise duty G/L
//                 ExciseDutyGL := GetExciseDutyGL();
//                 ExciseDutyRate := GetExciseRate();
//                 ExciseDuty := 0;
//                 Desc := SkyAgentsTransactions."Transaction Name";
//                 DescLoanNo := SkyAgentsTransactions."Loan No.";

//                 SaccoAccount := '';
//                 SaccoFee := 0;
//                 VendorAccount := '';
//                 VendorCommission := 0;
//                 SafcomAcc := '';
//                 SafcomFee := 0;
//                 PrePaymentGL := '';
//                 SMSAccount := '';
//                 SMSCharge := 0;

//                 AgentTarriffHeader.Reset;
//                 if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Withdrawal then
//                     AgentTarriffHeader.SetRange(Code, 'WITHDRAWAL')
//                 else
//                     if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Deposit then
//                         AgentTarriffHeader.SetRange(Code, 'DEPOSIT')
//                     else
//                         if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Balance then
//                             AgentTarriffHeader.SetRange(Code, 'BALANCE ENQ')
//                         else
//                             if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Ministatment then
//                                 AgentTarriffHeader.SetRange(Code, 'MINISTATEMENT')
//                             else
//                                 if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::LoanRepayment then
//                                     AgentTarriffHeader.SetRange(Code, 'LN_REPAYMENT');
//                 if AgentTarriffHeader.FindFirst then begin

//                     AgentTariffDetails.Reset;
//                     AgentTariffDetails.SetRange(Code, AgentTarriffHeader.Code);
//                     if AgentTariffDetails.FindFirst then begin
//                         SaccoComm := AgentTariffDetails."Sacco Comm";
//                         AgentCommision := AgentTariffDetails."Agent Comm";
//                         VendorCommission := AgentTariffDetails."Vendor Comm";
//                     end;
//                     //If Tiered
//                     if AgentTarriffHeader.Tiered then begin
//                         AgentTariffDetails.Reset;
//                         AgentTariffDetails.SetRange(Code, AgentTarriffHeader.Code);
//                         AgentTariffDetails.SetFilter("Lower Limit", '<=%1', SkyAgentsTransactions.Amount);
//                         AgentTariffDetails.SetFilter("Upper Limit", '>=%1', SkyAgentsTransactions.Amount);
//                         if AgentTariffDetails.FindFirst then begin
//                             SaccoComm := AgentTariffDetails."Sacco Comm";
//                             AgentCommision := AgentTariffDetails."Agent Comm";
//                             VendorCommission := AgentTariffDetails."Vendor Comm";
//                         end;
//                     end;

//                     SaccoCommAcc := AgentTarriffHeader."Sacco Comm Acc";
//                     AgentCommAcc := SkyAgentsTransactions."Agent Commision Account";
//                     VendorAccount := AgentTarriffHeader."Vendor Comm Acc";


//                     TotalCharge := SaccoComm + AgentCommision + VendorCommission;
//                     ExciseDuty := ROUND((SaccoFee) * ExciseDutyRate / 100);
//                 end
//                 else begin
//                     Response := false;
//                     //ERROR('Setup Missing for %1',SkyAgentsTransactions."Transaction Type");
//                 end;

//                 //ERROR('SafcomFee %1\SaccoFee %2',SafcomFee,SaccoFee);
//                 if SavAcc.Get(SkyAgentsTransactions."Member Account") then begin
//                     MemberName := SavAcc."No.";
//                     TransAmt := SkyAgentsTransactions.Amount;
//                     AccountToCharge := SkyAgentsTransactions."Member Account";


//                     if TransAmt >= 0 then begin
//                         if SavAcc.Blocked = SavAcc.Blocked::Debit then begin
//                             SkyAgentsTransactions."Needs Change" := true;
//                             SkyAgentsTransactions.Modify;
//                             Response := false;
//                         end;
//                     end;

//                     if TransAmt < 0 then begin
//                         if (SavAcc.Blocked <> SavAcc.Blocked::" ") then begin
//                             SkyAgentsTransactions."Needs Change" := true;
//                             SkyAgentsTransactions.Modify;
//                             Response := false;
//                         end;
//                     end;

//                     if (SavAcc.Blocked = SavAcc.Blocked::All) then begin
//                         SkyAgentsTransactions."Needs Change" := true;
//                         SkyAgentsTransactions.Modify;
//                         Response := false;
//                     end;

//                     //BUser.GET(USERID);

//                     //BUser.TESTFIELD("Cashier Journal Template");
//                     //BUser.TESTFIELD("Cashier Journal Batch");

//                     JTemplate := 'GENERAL';
//                     JBatch := 'DEFAULT';

//                     GenJournalBatch.Reset;
//                     GenJournalBatch.SetRange("Journal Template Name", JTemplate);
//                     GenJournalBatch.SetRange(Name, JBatch);
//                     if not GenJournalBatch.FindFirst then begin
//                         GenJournalBatch.Init;
//                         GenJournalBatch."Journal Template Name" := JTemplate;
//                         GenJournalBatch.Name := JBatch;
//                         GenJournalBatch.Description := 'Sky World Batch';
//                         GenJournalBatch.Init;
//                     end;

//                     DocNo := SkyAgentsTransactions."Transaction ID";
//                     PDate := SkyAgentsTransactions."Transaction Date";

//                     SavAcc.Reset;
//                     SavAcc.SetRange("Member No.", SkyAgentsTransactions."Member No");
//                     SavAcc.SetRange("Product Type", '505');
//                     if SavAcc.FindFirst then begin
//                         AccNo := SavAcc."No.";
//                     end;


//                     ExtDoc := '';
//                     LoanNo := '';
//                     TransType := Transtype::" ";
//                     Dim1 := SavAcc."Global Dimension 1 Code";
//                     Dim2 := SavAcc."Global Dimension 2 Code";
//                     SystCreated := true;
//                     //MESSAGE(AgentCommAcc);
//                     SaccoTrans.InitJournal(JTemplate, JBatch);

//                     if Response then begin
//                         if (SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Withdrawal) then begin
//                             //Debit member account
//                             SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, SkyAgentsTransactions."Member Account",
//                             CopyStr(Desc + '- Agent ID' + AgentCode + ':-' + DescLoanNo, 1, 50), Balacctype::"G/L Account", '', TransAmt, ExtDoc, LoanNo, TransType,
//                             Dim1, Dim2, SystCreated);
//                             //Credit agent account
//                             SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, SkyAgentsTransactions."Agent Account Number",
//                             CopyStr(Desc + '- Agent ID' + AgentCode + ':-' + DescLoanNo, 1, 50), Balacctype::"G/L Account", '', -TransAmt, ExtDoc, LoanNo, TransType,
//                             Dim1, Dim2, SystCreated);

//                         end else
//                             if (SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Deposit) then begin
//                                 //Credit member account
//                                 SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, SkyAgentsTransactions."Member Account",
//                                 CopyStr(Desc + '- Agent ID' + AgentCode + ':-' + DescLoanNo, 1, 50), Balacctype::"G/L Account", '', -TransAmt, ExtDoc, LoanNo, TransType,
//                                 Dim1, Dim2, SystCreated);
//                                 //Debit agent account
//                                 SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, SkyAgentsTransactions."Agent Account Number",
//                                 CopyStr(Desc + '- Agent ID' + AgentCode + ':-' + DescLoanNo, 1, 50), Balacctype::"G/L Account", '', TransAmt, ExtDoc, LoanNo, TransType,
//                                 Dim1, Dim2, SystCreated);

//                                 //Advice shares
//                                 SavAcc.Get(SkyAgentsTransactions."Member Account");
//                                 if SavAcc."Product Type" = '02' then begin
//                                     LoansProcess.AdviceShares(SavAcc, Abs(TransAmt), SavAcc."Monthly Contribution");
//                                 end;
//                             end;


//                         if TotalCharge > 0 then begin
//                             TotalCustomerCharge := AgentCommision + VendorCommission + SaccoComm + ExciseDuty;
//                             AccountToCharge := AccNo;

//                             SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AccountToCharge, CopyStr(Desc + ' Charges- Agent ID: ' + AgentCode + ':-' + DescLoanNo, 1, 50), Balacctype::"G/L Account",
//                                           '', TotalCustomerCharge, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated);//Debit
//                                                                                                                        //Agent Commision Credit
//                             SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Vendor, AgentCommAcc, CopyStr(Desc + '- Agent ID: ' + AgentCode + ':-' + DescLoanNo + ' Agent Comm', 1, 50), Balacctype::"G/L Account",
//                             '', -AgentCommision, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated);//Credit

//                             //Vendor (sky) Commision Credit
//                             SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Vendor, VendorAccount, CopyStr(Desc + '- Agent ID: ' + AgentCode + ':-' + DescLoanNo + ' Vendor Comm', 1, 50), Balacctype::"G/L Account",
//                             '', -VendorCommission, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated);//Credit

//                             //Sacco commision credit
//                             SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", SaccoCommAcc, CopyStr(Desc + '- Agent ID: ' + AgentCode + ':-' + DescLoanNo + ' Sacco Comm', 1, 50), Balacctype::"G/L Account",
//                                           '', -SaccoComm, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated);

//                             //Excise Duty credit
//                             SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", ExciseDutyGL, CopyStr('Excise Duty ' + Desc + '- Agent ID: ' + AgentCode + ':-' + DescLoanNo, 1, 50), Balacctype::"G/L Account",
//                                           '', -ExciseDuty, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated);

//                         end;


//                         if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::LoanRepayment then begin

//                             AccBal := GetAccountBalance(SavAcc."No.");
//                             RunBal := AccBal + SkyAgentsTransactions.Amount - (TotalCharge + ExciseDuty);

//                             if RunBal > 0 then begin
//                                 RunBal := SkyAgentsTransactions.Amount;
//                                 Loans.Reset;
//                                 Loans.SetRange("Loan No.", SkyAgentsTransactions."Loan No.");
//                                 Loans.SetRange("Member No.", SavAcc."Member No.");
//                                 if Loans.FindFirst then begin

//                                     Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Outstanding Bills");

//                                     IntRate := Loans.Interest / 12;

//                                     IntAmt := Loans."Outstanding Interest";

//                                     if Loans."Mobile Loan" then
//                                         IntAmt := 0;

//                                     if IntAmt > 0 then begin

//                                         if IntAmt > RunBal then
//                                             IntAmt := RunBal;

//                                         AccNo := SkyAgentsTransactions."Member Account";
//                                         AgentAccount := SkyAgentsTransactions."Agent Account Number";
//                                         ExtDoc := '';
//                                         LoanNo := Loans."Loan No.";
//                                         TransType := Transtype::"Interest Paid";
//                                         SystCreated := true;

//                                         SkyAgentsTransactions."Interest Paid" := IntAmt;
//                                         SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AgentAccount, CopyStr(Desc + '- Agent ID: ' + AgentCode + ':-' + DescLoanNo, 1, 50), Balacctype::"G/L Account",
//                                                       '', IntAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated);

//                                         AccNo := Loans."Loan Account";
//                                         SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, CopyStr(Desc + '- Agent ID: ' + AgentCode + ':-' + DescLoanNo, 1, 50), Balacctype::"G/L Account",
//                                                       '', -IntAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated);


//                                         RunBal -= IntAmt;

//                                     end;

//                                     //                      IF Loans."Non-Salaried" THEN
//                                     //                      IF Loans."Outstanding Penalty" > 0 THEN BEGIN
//                                     //                          IntAmt := Loans."Outstanding Penalty" ;
//                                     //                          IF IntAmt > RunBal THEN
//                                     //                              IntAmt := RunBal;
//                                     //
//                                     //                          AccNo := SkyAgentsTransactions."Member Account";
//                                     //                          AgentAccount := SkyAgentsTransactions."Agent Account Number";
//                                     //                          ExtDoc := '';
//                                     //                          LoanNo := Loans."Loan No.";
//                                     //                          TransType := TransType::"Penalty Paid";
//                                     //                          SystCreated := TRUE;
//                                     //
//                                     //                          //SkyAgentsTransactions."Interest Paid" := IntAmt;
//                                     //                          SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Savings,AgentAccount,COPYSTR(SkyAgentsTransactions.Description,1,50),BalAccType::"G/L Account",
//                                     //                                        '',IntAmt,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,SkyAgentsTransactions."Client Name");
//                                     //
//                                     //                          AccNo := Loans."Loan Account";
//                                     //                          SaccoTrans.JournalInsert(JTemplate,JBatch,DocNo,PDate,AcctType::Credit,AccNo,COPYSTR(SkyAgentsTransactions.Description,1,50),BalAccType::"G/L Account",
//                                     //                                        '',-IntAmt,ExtDoc,LoanNo,TransType,Dim1,Dim2,SystCreated,SkyAgentsTransactions."Client Name");
//                                     //
//                                     //
//                                     //                          RunBal -= IntAmt;
//                                     //
//                                     //                      END;

//                                     if Loans."Outstanding Balance" > 0 then begin
//                                         PrAmt := Loans."Outstanding Balance";
//                                         if PrAmt > RunBal then
//                                             PrAmt := RunBal;
//                                         Bills := PrAmt;

//                                         if PrAmt > Loans."Outstanding Bills" then
//                                             Bills := Loans."Outstanding Bills";

//                                         ProductFactory.Get(Loans."Loan Product Type");
//                                         AccNo := SkyAgentsTransactions."Member Account";
//                                         AgentAccount := SkyAgentsTransactions."Agent Account Number";
//                                         ExtDoc := '';
//                                         LoanNo := Loans."Loan No.";
//                                         TransType := Transtype::Repayment;
//                                         SystCreated := true;

//                                         SkyAgentsTransactions."Principal Paid" := PrAmt;

//                                         SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Savings, AgentAccount, CopyStr(Desc + '- Agent ID: ' + AgentCode + ':-' + DescLoanNo, 1, 50), Balacctype::"G/L Account",
//                                                       '', PrAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated);

//                                         AccNo := Loans."Loan Account";
//                                         SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, AccNo, CopyStr(Desc + '- Agent ID: ' + AgentCode + ':-' + DescLoanNo, 1, 50), Balacctype::"G/L Account",
//                                                       '', -PrAmt, ExtDoc, LoanNo, TransType, Dim1, Dim2, SystCreated);
//                                         //Bills
//                                         SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::Credit, Loans."Loan Account", CopyStr(Desc + '- Agent ID: ' + AgentCode + ':-' + DescLoanNo, 1, 50), Balacctype::"G/L Account",
//                                                       '', -Bills, ExtDoc, LoanNo, Transtype::Bills, Dim1, Dim2, SystCreated);
//                                         SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, Accttype::"G/L Account", ProductFactory."Billed Account", CopyStr(Desc + '- Agent ID: ' + AgentCode + ':-' + DescLoanNo, 1, 50), Balacctype::"G/L Account",
//                                                       '', Bills, ExtDoc, '', Transtype::" ", Dim1, Dim2, SystCreated);

//                                         RunBal -= PrAmt;

//                                         //Advide loan
//                                         SkyMbanking.AdviceLoan(Loans."Loan No.", false);

//                                     end;
//                                 end;
//                             end;
//                         end;




//                         //MARK BUFFER AS POSTED
//                         SkyAgentWithdrawalsBuffer.Reset;
//                         SkyAgentWithdrawalsBuffer.SetRange(SkyAgentWithdrawalsBuffer."Session ID", SkyAgentsTransactions."Transaction ID");
//                         SkyAgentWithdrawalsBuffer.SetRange(SkyAgentWithdrawalsBuffer."Account No", SkyAgentsTransactions."Member Account");
//                         SkyAgentWithdrawalsBuffer.SetRange(SkyAgentWithdrawalsBuffer.Amount, SkyAgentsTransactions.Amount);
//                         if SkyAgentWithdrawalsBuffer.Find('-') then begin

//                             SkyAgentWithdrawalsBuffer.Posted := true;
//                             SkyAgentWithdrawalsBuffer."Posting Date" := Today;
//                             SkyAgentWithdrawalsBuffer.Modify;
//                         end;


//                         //***msa
//                         SkyAgentsTransactions.Posted := true;
//                         SkyAgentsTransactions."Posted By" := UserId;
//                         SkyAgentsTransactions."Date Posted" := Today;
//                         SkyAgentsTransactions."Time Posted" := Time;
//                         SkyAgentsTransactions.Modify;


//                         Priority := 211;

//                         SaccoTrans.PostJournal(JTemplate, JBatch);
//                         if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Withdrawal then
//                             Priority := 211;



//                         if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::LoanRepayment then begin
//                             if Loans.Get(LoanNo) then begin
//                                 Loans.CalcFields("Outstanding Balance");
//                                 LT := Loans."Loan Product Type Name";
//                                 if LoanType.Get(Loans."Loan Product Type") then
//                                     LT := LoanType."USSD Product Name";

//                                 NewLoanBal := Loans."Outstanding Balance";
//                                 msg := Format(SkyAgentsTransactions."Transaction Type") + ' of KES ' + Format(SkyAgentsTransactions.Amount) + ' has been processed successfully. Interest Paid is ' + Format(SkyAgentsTransactions."Interest Paid") +
//                                 ', Principal Paid is ' + Format(SkyAgentsTransactions."Principal Paid") + ', New ' + LT + ' Balance is ' + Format(NewLoanBal);
//                             end;
//                         end;


//                         MobileNo := SavAcc."Transactional Mobile No";
//                         if MobileNo = '' then
//                             MobileNo := SavAcc."Mobile Phone No";

//                         if (SkyAgentsTransactions."Transaction Type" <> SkyAgentsTransactions."transaction type"::Ministatment) and (SkyAgentsTransactions."Transaction Type" <> SkyAgentsTransactions."transaction type"::Balance) then
//                             SendSmsWithID(Source::Agency, MobileNo, msg, Format(SkyAgentsTransactions."Transaction ID"), '', true, Priority, false, 'AGENT', SkyAgentsTransactions."Session ID", 'AGENT');
//                     end;//ending response true
//                 end
//                 else begin
//                     Response := false;
//                     if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Deposit then begin
//                         SavAcc.Reset;
//                         SavAcc.SetRange("ID No.", SkyAgentsTransactions."Member Account");
//                         SavAcc.SetRange("Product Type", '500');
//                         if SavAcc.FindFirst then begin
//                             SkyAgentsTransactions."Member Account" := SavAcc."No.";
//                             SkyAgentsTransactions."Paybill Member ID" := SavAcc."ID No.";
//                             SkyAgentsTransactions.Modify;

//                         end
//                         else begin
//                             SkyAgentsTransactions."Needs Change" := true;
//                             SkyAgentsTransactions.Modify;
//                         end;
//                     end
//                     else begin
//                         SkyAgentsTransactions."Needs Change" := true;
//                         SkyAgentsTransactions.Modify;
//                     end;
//                 end;
//             until SkyAgentsTransactions.Next = 0;
//         end;
//     end;


//     procedure GetAccountBalance(Account: Text[30]) AccountBal: Decimal
//     var
//         savAccList: Record "Savings Accounts";
//         periodicActivities: Codeunit "Periodic Activities";
//         AccountTypes: Record "Product Factory";
//         MNo: Code[20];
//     begin


//         AccountBal := 0;
//         savAccList.Reset;
//         savAccList.SetRange("No.", Account);
//         if savAccList.Find('-') then begin
//             savAccList.CalcFields("Balance (LCY)", "Uncleared Cheques", "Coop Transactions", "ATM Transactions", "Lien Placed", "Authorised Over Draft");
//             if AccountTypes.Get(savAccList."Product Type") then begin
//                 AccountBal := (savAccList."Balance (LCY)" + savAccList."Authorised Over Draft")
//                               - AccountTypes."Minimum Balance"
//                               - savAccList."Uncleared Cheques"
//                               - savAccList."Coop Transactions"
//                               - savAccList."Lien Placed"
//                               - savAccList."ATM Transactions";

//             end;
//         end;
//         exit(AccountBal);
//     end;


//     procedure SendSmsWithID(Source: Option NEW_MEMBER,NEW_ACCOUNT,LOAN_ACCOUNT_APPROVAL,DEPOSIT_CONFIRMATION,CASH_WITHDRAWAL_CONFIRM,LOAN_APPLICATION,LOAN_APPRAISAL,LOAN_GUARANTORS,LOAN_REJECTED,LOAN_POSTED,LOAN_DEFAULTED,SALARY_PROCESSING,TELLER_CASH_DEPOSIT,TELLER_CASH_WITHDRAWAL,TELLER_CHEQUE_DEPOSIT,FIXED_DEPOSIT_MATURITY,INTERACCOUNT_TRANSFER,ACCOUNT_STATUS,STATUS_ORDER,EFT_EFFECTED,ATM_APPLICATION_FAILED,ATM_COLLECTION,MBANKING,MEMBER_CHANGES,CASHIER_BELOW_LIMIT,CASHIER_ABOVE_LIMIT,INTERNETBANKING,CRM,MOBILE_PIN,WITHDRAWAL; Telephone: Text[200]; Textsms: Text[250]; Reference: Text[30]; AccNo: Text[30]; Chargeable: Boolean; Priority: Integer; ChargeMember: Boolean; RequestApplication: Text[30]; RequestCorrelationID: Text[50]; SourceApplication: Text[30])
//     var
//         EntryNo: Integer;
//         SkySMS: Record "Sky SMS Messages";
//         Category: Code[100];
//         GeneralLedgerSetup: Record "General Ledger Setup";
//     begin

//         EntryNo := EntryNo + 1;


//         if StrLen(Telephone) = 13 then begin
//             Telephone := CopyStr(Telephone, 2, 12);
//         end;

//         if StrLen(Telephone) = 10 then begin
//             if CopyStr(Telephone, 1, 1) = '0' then
//                 Telephone := '254' + CopyStr(Telephone, 2, 9);
//         end;

//         if StrLen(Telephone) = 9 then begin
//             if CopyStr(Telephone, 1, 1) = '7' then
//                 Telephone := '254' + Telephone
//         end;


//         Category := Format(Source);

//         Priority := GetSMSPriority(Category);

//         if Priority = 0 then
//             Priority := 250;

//         GeneralLedgerSetup.Get;

//         if StrLen(Telephone) = 12 then begin
//             SkySMS.Init;
//             SkySMS.originator_id := CreateGuid;
//             SkySMS.msg_id := 0;


//             SkySMS.msg_product_id := GeneralLedgerSetup."SMS Sender ID";
//             SkySMS.msg_provider_code := '0';
//             SkySMS.msg_charge := '';
//             SkySMS.msg_status_code := 10;
//             SkySMS.msg_status_description := 'New MSG';
//             SkySMS.msg_status_date := CurrentDatetime;
//             SkySMS.sender := GeneralLedgerSetup.Verdict;
//             SkySMS.receiver := Telephone;
//             SkySMS.msg := Textsms;
//             SkySMS.msg_type := 'MT';
//             SkySMS.msg_source_reference := '';
//             SkySMS.msg_destination_reference := '';
//             SkySMS.msg_xml_data := '<OTHER_DETAILS/>';
//             SkySMS.msg_category := Category;
//             SkySMS.msg_priority := Priority;

//             SkySMS.msg_send_count := 0;
//             SkySMS.schedule_msg := 'NO';
//             SkySMS.date_scheduled := CurrentDatetime;
//             SkySMS.msg_send_integrity_hash := '';
//             //SkySMS.msg_response_date:=CURRENTDATETIME;
//             //SkySMS.msg_response_xml_data:='';
//             //SkySMS.msg_response_integrity_hash:='';
//             SkySMS.transaction_date := CurrentDatetime;
//             SkySMS.date_created := CurrentDatetime;
//             SkySMS."SMS Date" := Today;
//             if Chargeable then
//                 SkySMS."Account To Charge" := AccNo;

//             SkySMS.msg_request_application := RequestApplication;
//             SkySMS.msg_request_correlation_id := RequestCorrelationID;
//             SkySMS.msg_source_application := SourceApplication;

//             SkySMS.transaction_id := 0;
//             SkySMS.server_id := 0;
//             SkySMS.msg_charge_applied := '';
//             SkySMS.msg_format := 'TEXT';
//             SkySMS.msg_command := 'BulkSMS';
//             SkySMS.msg_sensitivity := 'NORMAL';
//             SkySMS.msg_response_description := '';
//             SkySMS.msg_result_description := '';
//             SkySMS.msg_result_xml_data := '';
//             SkySMS.msg_result_date := CurrentDatetime;
//             SkySMS.msg_result_integrity_hash := '';
//             SkySMS.msg_result_submit_count := 0;
//             SkySMS.msg_result_submit_status := 'PENDING';
//             SkySMS.msg_result_submit_description := '';
//             SkySMS.msg_result_submit_date := CurrentDatetime;
//             SkySMS.sender_type := 'SENDER_ID';
//             SkySMS.receiver_type := 'MSISDN';
//             if Source = Source::MOBILE_PIN then begin
//                 SkySMS.msg_general_flag := 'NOT_MASKED';
//             end;
//             SkySMS."Charge Member" := ChargeMember;
//             if Source = Source::CASH_WITHDRAWAL_CONFIRM then
//                 SkySMS."Split Charge" := true;

//             SkySMS.Insert;

//         end;
//     end;

//     local procedure GetSMSPriority(Category: Text) Priority: Integer
//     begin
//         if (Category = 'ATM_COLLECTION') then
//             Priority := 211
//         else
//             if (Category = 'B2B_WITHDRAWAL') then
//                 Priority := 211
//             else
//                 if (Category = 'CASH_WITHDRAWAL_CONFIRM') then
//                     Priority := 211
//                 else
//                     if (Category = 'DEPOSIT_CONFIRMATION') then
//                         Priority := 220
//                     else
//                         if (Category = 'FIXED_DEPOSIT_MATURITY') then
//                             Priority := 240
//                         else
//                             if (Category = 'LOAN_APPLICATION') then
//                                 Priority := 230
//                             else
//                                 if (Category = 'LOAN_DEFAULTED') then
//                                     Priority := 240
//                                 else
//                                     if (Category = 'LOAN_GUARANTORS') then
//                                         Priority := 240
//                                     else
//                                         if (Category = 'LOAN_POSTED') then
//                                             Priority := 240
//                                         else
//                                             if (Category = 'LOW_FLOAT_ALERT') then
//                                                 Priority := 203
//                                             else
//                                                 if (Category = 'LOW_FLOAT_INFO') then
//                                                     Priority := 202
//                                                 else
//                                                     if (Category = 'LOW_FLOAT_MIN') then
//                                                         Priority := 200
//                                                     else
//                                                         if (Category = 'LOW_FLOAT_WARNING') then
//                                                             Priority := 204
//                                                         else
//                                                             if (Category = 'MAPP_ACTIVATION') then
//                                                                 Priority := 200
//                                                             else
//                                                                 if (Category = 'MAPP_DEACTIVATION') then
//                                                                     Priority := 205
//                                                                 else
//                                                                     if (Category = 'MBANKING') then
//                                                                         Priority := 220
//                                                                     else
//                                                                         if (Category = 'MEMBER_CHANGES') then
//                                                                             Priority := 240
//                                                                         else
//                                                                             if (Category = 'MOBILE_PIN') then
//                                                                                 Priority := 208
//                                                                             else
//                                                                                 if (Category = 'NEW_ACCOUNT') then
//                                                                                     Priority := 230
//                                                                                 else
//                                                                                     if (Category = 'NEW_MEMBER') then
//                                                                                         Priority := 230
//                                                                                     else
//                                                                                         if (Category = 'ONE_TIME_PASSWORD') then
//                                                                                             Priority := 200
//                                                                                         else
//                                                                                             if (Category = 'SALARY_PROCESSING') then
//                                                                                                 Priority := 245
//                                                                                             else
//                                                                                                 if (Category = 'WITHDRAWAL') then
//                                                                                                     Priority := 214
//                                                                                                 else
//                                                                                                     if (Category = 'LOAN_ACCOUNT_APPROVAL') then
//                                                                                                         Priority := 245
//                                                                                                     else
//                                                                                                         if (Category = 'LOAN_APPRAISAL') then
//                                                                                                             Priority := 230
//                                                                                                         else
//                                                                                                             if (Category = 'LOAN_REJECTED') then
//                                                                                                                 Priority := 225
//                                                                                                             else
//                                                                                                                 if (Category = 'TELLER_CASH_DEPOSIT') then
//                                                                                                                     Priority := 215
//                                                                                                                 else
//                                                                                                                     if (Category = 'TELLER_CAS') then
//                                                                                                                         Priority := 225
//                                                                                                                     else
//                                                                                                                         Priority := 250;
//     end;


//     procedure UpdateAuthAttempts("Action": Code[30]; Indent: Boolean; Username: Code[30]; Type: Text; "Count": Integer; Tag: Text; "Auth Action": Text; Validity: DateTime; ClearValidity: Boolean) Response: Text
//     var
//         SkyAgencyAuth: Record "Sky Agency Auth";
//         SavAcc: Record "Savings Accounts";
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//     begin
//         /*
//         Possible Auth Types:
//         ---------------------------
//         LOGIN
//         OTP
//         ---------------------------
//         */
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         //        if Indent then begin LocalJsonTextWriter.Formatting := JsonFormatting.Indented; end;
//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Update Authentication Attempts';
//         ResponseMessage := 'Update Authentication Attempts';
//         /*-------------------------------------------------------------------------------------*/


//         Status := 'ERROR';

//         SkyAgencyAuth.Reset;
//         SkyAgencyAuth.SetRange(SkyAgencyAuth.Username, Username);
//         if SkyAgencyAuth.FindFirst then begin
//             if (Type = 'LOGIN') then begin
//                 SkyAgencyAuth."Login Attempts Action" := "Auth Action";
//                 SkyAgencyAuth."Login Attempts Count" := Count;
//                 SkyAgencyAuth."Login Attempts Tag" := Tag;
//                 if (ClearValidity) then begin
//                     Clear(SkyAgencyAuth."Login Attempts Action Expiry");
//                 end
//                 else begin
//                     SkyAgencyAuth."Login Attempts Action Expiry" := Validity;
//                 end;
//                 SkyAgencyAuth.Modify;
//                 Status := 'SUCCESS';
//             end;
//             if (Type = 'OTP') then begin
//                 SkyAgencyAuth."OTP Attempts Action" := "Auth Action";
//                 SkyAgencyAuth."OTP Attempts Count" := Count;
//                 SkyAgencyAuth."OTP Attempts Tag" := Tag;
//                 if (ClearValidity) then begin
//                     Clear(SkyAgencyAuth."OTP Attempts Action Expiry");
//                 end
//                 else begin
//                     SkyAgencyAuth."OTP Attempts Action Expiry" := Validity;
//                 end;
//                 SkyAgencyAuth.Modify;
//                 Status := 'SUCCESS';
//             end;
//         end
//         else begin
//             Status := 'NOT_FOUND';
//         end;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;
//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, Indent);

//     end;


//     procedure GetUserLoginAttemptExpiry("Action": Code[30]; Indent: Boolean; Username: Code[30]; Type: Text) Response: Text
//     var
//         SkyAgencyAuth: Record "Sky Agency Auth";
//         CurrentTime: DateTime;
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         ExpiryDate: DateTime;
//     begin
//         /*
//         Possible Auth Types:
//         ---------------------------
//         LOGIN
//         OTP
//         ---------------------------
//         */
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         //        if Indent then begin LocalJsonTextWriter.Formatting := JsonFormatting.Indented; end;
//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         NOT_FOUND
//         ---------------------------
//         */
//         ResponseTitle := 'Update Authentication Attempts';
//         ResponseMessage := 'Update Authentication Attempts';
//         /*-------------------------------------------------------------------------------------*/


//         Status := 'ERROR';

//         ExpiryDate := CurrentDatetime;

//         SkyAgencyAuth.Reset;
//         SkyAgencyAuth.SetRange(SkyAgencyAuth.Username, Username);
//         if SkyAgencyAuth.FindFirst then begin
//             if (Type = 'LOGIN') then begin
//                 ExpiryDate := SkyAgencyAuth."Login Attempts Action Expiry";
//             end;
//             if (Type = 'OTP') then begin
//                 ExpiryDate := SkyAgencyAuth."OTP Attempts Action Expiry";
//             end;
//         end;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('expiry_date');
//         //        LocalJsonTextWriter.WriteValue(ExpiryDate);
//         //        LocalJsonTextWriter.WriteEndObject;
//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, Indent);

//     end;


//     procedure GetUserLoginAttemptAction("Action": Code[30]; Indent: Boolean; Username: Code[30]; Type: Text) Response: Code[10]
//     var
//         SkyAgencyAuth: Record "Sky Agency Auth";
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//     begin
//         Response := '';

//         SkyAgencyAuth.Reset;
//         SkyAgencyAuth.SetRange(SkyAgencyAuth.Username, Username);
//         if SkyAgencyAuth.FindFirst then begin
//             if (Type = 'LOGIN') then begin
//                 if (SkyAgencyAuth."Login Attempts Action" = 'SUSPEND') then begin
//                     if (SkyAgencyAuth."Login Attempts Action Expiry" > CurrentDatetime) then begin
//                         Response := 'SUSPENDED'
//                     end;
//                 end;
//             end;
//             if (Type = 'OTP') then begin
//                 if (SkyAgencyAuth."OTP Attempts Action" = 'SUSPEND') then begin
//                     if (SkyAgencyAuth."OTP Attempts Action Expiry" > CurrentDatetime) then begin
//                         Response := 'SUSPENDED'
//                     end;
//                 end;
//             end;
//         end;
//     end;


//     procedure GetUserLoginAttemptCount("Action": Code[30]; Indent: Boolean; Username: Code[30]; Type: Text) Response: Integer
//     var
//         SkyAgencyAuth: Record "Sky Agency Auth";
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//     begin
//         Response := 0;
//         SkyAgencyAuth.Reset;
//         SkyAgencyAuth.SetRange(SkyAgencyAuth.Username, Username);
//         if SkyAgencyAuth.FindFirst then begin
//             if (Type = 'LOGIN') then begin
//                 Response := SkyAgencyAuth."Login Attempts Count";
//             end;
//             if (Type = 'OTP') then begin
//                 Response := SkyAgencyAuth."OTP Attempts Count";
//             end;
//         end
//         else begin
//             Response := 0;
//         end;
//     end;


//     procedure TestFunction()
//     var
//         AgentTarriffHeader: Record "Agent Tarriff Header";
//     begin
//         AgentTarriffHeader.Reset;
//         AgentTarriffHeader.SetRange("Transaction Type", AgentTarriffHeader."transaction type"::Withdrawal);
//         if AgentTarriffHeader.FindFirst then begin
//             repeat
//                 Message('I was here');
//             until AgentTarriffHeader.Next = 0;
//         end;
//     end;


//     procedure GetUnhashedPINs() Response: Text
//     var
//         SkyAuth: Record "Sky Agency Auth";
//     begin
//         Response := 'ERROR';

//         SkyAuth.Reset;
//         SkyAuth.SetRange(SkyAuth."PIN Encrypted", false);
//         if SkyAuth.FindFirst then begin
//             Response := '<ACCOUNTS>';
//             repeat
//                 Response += '<ACCOUNT USERNAME="' + SkyAuth.Username + '" AGENT_CODE="' + SkyAuth."Agent Code" + '" PASSWORD="' + SkyAuth.Password + '"/>'
//             until SkyAuth.Next = 0;
//             Response += '</ACCOUNTS>';
//         end
//         else begin
//             Response := '<ACCOUNTS/>';
//         end;
//     end;


//     procedure SetHashedPIN(Username: Text; AgentCode: Text; Password: Text) Response: Text
//     var
//         SkyAuth: Record "Sky Agency Auth";
//         MobileNo: Text;
//     begin
//         Response := 'ERROR';
//         SkyAuth.Reset;
//         SkyAuth.SetRange(SkyAuth."PIN Encrypted", false);
//         SkyAuth.SetRange(SkyAuth.Username, Username);
//         SkyAuth.SetRange(SkyAuth."Agent Code", AgentCode);
//         if SkyAuth.Find('-') then begin
//             SkyAuth.Password := Password;
//             SkyAuth."PIN Encrypted" := true;
//             SkyAuth.Modify;
//             Response := 'SUCCESS';
//         end
//         else begin
//             Response := 'NOT_FOUND';
//         end;
//     end;


//     procedure RegisterVirtualMember("Action": Text; Indent: Boolean; Name: Text; "National ID Number": Text; "Mobile Number": Text; "Date of Birth": Date; "Entry Number": Text; SessionID: Text; DateFormatted: Text; AgentCode: Code[30]; "Postall Address": Text; "Employment Status": Text; Employer: Text; Region: Text; "Transaction Date": Date) Response: Text
//     var
//         SkyAuth: Record "Payment Line Staff";
//         SavAcc: Record "Savings Accounts";
//         MobileNo: Text;
//         VirtualMemberRegBuffer: Record "Virtual Member Reg Buffer";
//         RefereeMobileNo: Text;
//         SMS: Text;
//         SMSToDestination: Text;
//         Source: Option ,Agency;
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         PrintText: Text;
//         CompanyInformation: Record "Company Information";
//         AgentAplication: Record "Agent Applications";
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         //        if Indent then begin LocalJsonTextWriter.Formatting := JsonFormatting.Indented; end;

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'ERROR';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         MEMBER_EXISTS
//         ENTRY_EXISTS
//         ERROR
//         ---------------------------
//         */
//         AgentAplication.Get(AgentCode);
//         ResponseTitle := 'ERROR';
//         ResponseMessage := 'Member registration has failed';
//         /*-------------------------------------------------------------------------------------*/

//         //        LocalJsonTextWriter.WriteStartObject;

//         Status := 'ERROR';
//         ResponseTitle := 'ERROR';
//         MobileNo := '+' + "Mobile Number";
//         RefereeMobileNo := AgentAplication."Mobile No";
//         VirtualMemberRegBuffer.Reset;
//         VirtualMemberRegBuffer.SetRange(VirtualMemberRegBuffer."Mobile Number", MobileNo);
//         VirtualMemberRegBuffer.SetRange(VirtualMemberRegBuffer."Entry Number", "Entry Number");
//         if not VirtualMemberRegBuffer.Find('-') then begin
//             SavAcc.Reset;
//             SavAcc.SetRange(SavAcc."Mobile Phone No", MobileNo);
//             if not VirtualMemberRegBuffer.Find('-') then begin
//                 VirtualMemberRegBuffer.Reset;
//                 VirtualMemberRegBuffer."Entry Number" := "Entry Number";
//                 VirtualMemberRegBuffer."Date Created" := CurrentDatetime;
//                 VirtualMemberRegBuffer.Name := Name;
//                 VirtualMemberRegBuffer."Mobile Number" := MobileNo;
//                 VirtualMemberRegBuffer."National ID Number" := "National ID Number";
//                 VirtualMemberRegBuffer."Date of Birth" := "Date of Birth";
//                 VirtualMemberRegBuffer."Employment Status" := "Employment Status";
//                 VirtualMemberRegBuffer.Employer := Employer;
//                 VirtualMemberRegBuffer.Region := Region;
//                 VirtualMemberRegBuffer."Transaction Date" := Today;
//                 VirtualMemberRegBuffer."Agent Code" := AgentCode;
//                 VirtualMemberRegBuffer."Postal Address" := "Postall Address";

//                 SavAcc.Reset;
//                 SavAcc.SetRange(SavAcc."Mobile Phone No", RefereeMobileNo);
//                 if SavAcc.Find('-') then begin
//                     VirtualMemberRegBuffer."Referee Name" := SavAcc.Name;
//                     VirtualMemberRegBuffer."Referee Member Number" := SavAcc."Member No.";
//                     SMS := 'Dear ' + SavAcc.Name + ', the member registration details you submitted have been received. Entry No.: ' + "Entry Number";
//                     SendSmsWithID(Source::Agency, SavAcc."Mobile Phone No", SMS, "Entry Number", '', true, 211, false, 'AGENT', SessionID, 'AGENT');

//                     SMSToDestination := 'Dear ' + Name + ', ' + SavAcc.Name + ' has submitted your details for SACCO membership. Entry No.: ' + "Entry Number";
//                     SendSmsWithID(Source::Agency, "Mobile Number", SMSToDestination, "Entry Number", '', true, 211, false, 'AGENT', SessionID, 'AGENT');
//                 end
//                 else begin
//                     VirtualMemberRegBuffer."Referee Name" := '';
//                     VirtualMemberRegBuffer."Referee Member Number" := '';
//                     SMSToDestination := 'Dear ' + Name + ', self registration details you submitted have been received. Entry No.: ' + "Entry Number";
//                     SendSmsWithID(Source::Agency, "Mobile Number", SMSToDestination, "Entry Number", '', true, 211, false, 'AGENT', SessionID, 'AGENT');
//                 end;

//                 VirtualMemberRegBuffer.Insert;
//                 ResponseTitle := 'SUCCESS';
//                 Status := 'SUCCESS';
//                 ResponseMessage := 'Member has been registered succesfully';

//                 CompanyInformation.Get;
//                 AgentAplication.Get(AgentCode);

//                 PrintText := '';
//                 PrintText += '<logo/>';
//                 PrintText += '<br/>' + CompanyInformation.Name;
//                 PrintText += '<br/>';
//                 PrintText += '<hr/>';
//                 PrintText += '<br/>Center: ' + CompanyInformation."Phone No.";
//                 PrintText += '<br/>Center: ' + CompanyInformation."E-Mail";
//                 PrintText += '<br/>';
//                 PrintText += '<hr/>';
//                 PrintText += '<br/>Title: Member Registration';
//                 PrintText += '<br/>';
//                 PrintText += '<hr/>';
//                 PrintText += '<br/>Agency: ' + AgentAplication."Name of the Proposed Agent";
//                 PrintText += '<br/>Location: ' + AgentAplication."Place of Business";
//                 PrintText += '<br/>Agent ID: ' + AgentAplication."Agent Code";
//                 PrintText += '<br/>Operator: ' + AgentAplication.Name;
//                 PrintText += '<br/>';
//                 PrintText += '<hr/>';
//                 PrintText += '<br/>Customer';
//                 PrintText += '<br/>Name: ' + Name;
//                 PrintText += '<br/>Phone Number: ' + "Mobile Number";
//                 PrintText += '<br/>ID Number: ' + "National ID Number";
//                 PrintText += '<br/>Date Of Birth: ' + Format("Date of Birth");
//                 PrintText += '<br/>Referee: ' + AgentCode;
//                 PrintText += '<br/>Employment Status: ' + "Employment Status";
//                 PrintText += '<br/>Region: ' + Region;
//                 PrintText += '<br/>Postal Address: ' + "Postall Address";
//                 PrintText += '<br/>';
//                 PrintText += '<hr/>';
//                 PrintText += '<br/>Reference: ' + "Entry Number";
//                 PrintText += '<br/>Date: ' + DateFormatted;
//                 PrintText += '<br/>';
//                 PrintText += '<hr/>';
//                 PrintText += '<br/>Footer: Thank you for banking with us';
//                 PrintText += '<br/>Barcode: ' + "Entry Number";
//             end
//             else begin
//                 Status := 'MEMBER_EXISTS';
//                 ResponseTitle := 'MEMBER_EXISTS';
//                 ResponseMessage := 'Member Exists';
//             end;
//         end
//         else begin
//             Status := 'ENTRY_EXISTS';
//             ResponseTitle := 'ENTRY_EXISTS';
//             ResponseMessage := 'Entry exists';
//         end;

//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('print');
//         //        LocalJsonTextWriter.WriteValue(PrintText);
//         //        LocalJsonTextWriter.WriteEndObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, Indent);

//     end;


//     procedure UpdateVirtualMemberRegistration("Action": Text; "Image Entry Number": Text; "Image Path": Text; "Registration Entry Number": Text; "Image Type": Text; Indent: Boolean) Response: Text
//     var
//         VirtualMemberRegImages: Record "Virtual Member Reg Images";
//         MobileNo: Text;
//         VirtualMemberRegBuffer: Record "Virtual Member Reg Buffer";
//         RefereeMobileNo: Text;
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         //        if Indent then begin LocalJsonTextWriter.Formatting := JsonFormatting.Indented; end;

//         /*-------------------------------------------------------------------------------------*/
//         Status := 'ERROR';
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         MEMBER_EXISTS
//         ENTRY_EXISTS
//         ERROR
//         ---------------------------
//         */
//         ResponseTitle := 'ERROR';
//         ResponseMessage := 'Member registration has failed';
//         /*-------------------------------------------------------------------------------------*/

//         //        LocalJsonTextWriter.WriteStartObject;
//         Status := 'ERROR';
//         ResponseTitle := 'ERROR';

//         Response := 'ERROR';
//         VirtualMemberRegBuffer.Reset;
//         VirtualMemberRegBuffer.SetRange(VirtualMemberRegBuffer."Entry Number", "Registration Entry Number");
//         if VirtualMemberRegBuffer.Find('-') then begin
//             VirtualMemberRegImages.Reset;
//             VirtualMemberRegImages."Image Entry Number" := "Image Entry Number";
//             VirtualMemberRegImages."Image Path" := "Image Path";
//             VirtualMemberRegImages.Type := "Image Type";

//             VirtualMemberRegImages."Registration Entry Number" := "Registration Entry Number";
//             VirtualMemberRegImages.Modify;
//             ResponseTitle := 'SUCCESS';
//             Response := 'SUCCESS';
//             ResponseMessage := 'Update was a success';
//             Status := 'SUCCESS';
//         end
//         else begin
//             Response := 'ENTRY_DOES_NOT_EXIST';
//             ResponseTitle := 'ENTRY_DOES_NOT_EXIST';
//             ResponseMessage := 'The entry does not exist';
//             Status := 'ENTRY_DOES_NOT_EXIST';
//         end;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;

//         //Payload := LocalStringBuilder.ToString;
//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, Indent);

//     end;


//     procedure GetVirtualMemberRegistrationImagesPath() Response: Text
//     var
//         GeneralLedgerSetup: Record "General Ledger Setup";
//     begin
//         // GeneralLedgerSetup.GET;
//         // GeneralLedgerSetup.TESTFIELD("Virtual Members Images Path");
//         // Response := GeneralLedgerSetup."Virtual Members Images Path";
//     end;


//     procedure PerformAgentTransaction("Action": Code[50]; Indent: Boolean; AgentUsername: Text; AgentPassword: Text; AgentDebitNumber: Text; DebitAccountType: Text; AgentCreditNumber: Text; TransactionSessionID: Text; TransactionAmount: Decimal; TransactionAmountStylized: Text; TransactionStatementCount: Integer; TransactionNarration: Text; TransactionDate: Text; TransactionPrintReceipt: Boolean; DeviceIMEI: Text; DeviceSerialNumber: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         PrintData: Text;
//         DisplayData: Text;
//         SMSData: Text;
//         hr: label '<hr/>';
//         br: label '<br/>';
//         logo: label '<logo/>';
//         cdata_open: label '<![CDATA[';
//         cdata_close: label ']]>';
//         TransactionAccountText: Text;
//         TransactionText: Text;
//         StatementText: Text;
//         Iterator: Integer;
//         LineBreak: Text;
//         SkyAgencyAuth: Record "Sky Agency Auth";
//         SavingsAccounts: Record "Savings Accounts";
//         SkyAgentsTransactions: Record "Sky Agents Transactions";
//         AgentTarriffHeader: Record "Agent Tarriff Header";
//         SafcomFee: Decimal;
//         SaccoFee: Decimal;
//         VendorCommission: Decimal;
//         PrePaymentGL: Code[30];
//         SMSAccount: Code[30];
//         AmountTransacted: Decimal;
//         Type: Option Daily,Weekly,Monthly;
//         Limit: Decimal;
//         SafcomCharges: Record "Sky Safcom Corporate Charges";
//         TotalCharge: Decimal;
//         ExciseDuty: Decimal;
//         ExciseDutyRate: Decimal;
//         ExciseDutyGL: Code[30];
//         TransType: Option ,CASH_WITHDRAWAL,CASH_DEPOSIT,ACCOUNT_BALANCE,ACCOUNT_STATEMENT,LOAN_REPAYMENT;
//         SavingsLedgerEntry: Record "Savings Ledger Entry";
//         AgentAplication: Record "Agent Applications";
//         SkyAgentWithdrawalsBuffer: Record "Sky Agent Withdrawals Buffer";
//         Members: Record Members;
//         MemberNumber: Code[30];
//         Vendor: Record Vendor;
//         SkyAgencyCompanies: Record "Sky Agency Companies";
//         SkyAgencyDevices: Record "Sky Agency Devices";
//         CompanyInformation: Record "Company Information";
//         AgentCode: Code[30];
//         AgentCommisionAccNumber: Code[30];
//         AgentTariffDetails: Record "Agent Tariff Details";
//         AgentComm: Decimal;
//         SaccoAcc: Code[30];
//         VendorCommAcc: Code[30];
//         RequiresApproval: Boolean;
//         SkyAgentTransfer: Record "Sky Agent Transfer";
//         AgentName: Text;
//         AgentMemberNumber: Text;
//     begin
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         //        if Indent then begin LocalJsonTextWriter.Formatting := JsonFormatting.Indented; end;
//         /*-------------------------------------------------------------------------------------*/
//         Status := 'SUCCESS';
//         RequiresApproval := false;
//         /*
//         Possible Response Statuses:
//         ---------------------------
//         SUCCESS
//         ERROR
//         FAILED
//         LIMIT_EXEEDED
//         BLOCKED
//         ---------------------------
//         Possible Transaction Types:
//         CASH_WITHDRAWAL
//         CASH_DEPOSIT
//         ACCOUNT_BALANCE
//         ACCOUNT_STATEMENT
//         LOAN_PAYMENT
//         */

//         //        LocalJsonTextWriter.WriteStartObject;
//         ResponseTitle := 'Agent Transaction';
//         ResponseMessage := 'Dear user, an error occured while processing your request, kindly try again later.';
//         /*-------------------------------------------------------------------------------------*/

//         //Member number



//         if AgentAplication.Get(AgentUsername) then begin
//             ResponseMessage := 'Transaction Succesful';
//             Status := 'SUCCESS';
//             AgentName := AgentAplication."Name of the Proposed Agent";
//             SavingsAccounts.Get(AgentAplication.Account);
//             AgentMemberNumber := SavingsAccounts."Member No.";
//             AgentCode := AgentAplication."Agent Code";
//         end else begin
//             ResponseMessage := 'Incorrect Username or Password';
//             Status := 'FAILED';
//         end;

//         DebitAccountType := 'VENDOR';
//         if SavingsAccounts.Get(AgentDebitNumber) then begin
//             DebitAccountType := 'SAVINGS';
//         end;

//         //If agents want to move money from untility to FOSA then a manual posting is required
//         if SavingsAccounts.Get(AgentDebitNumber) then begin
//             if SavingsAccounts."Product Type" = '512' then begin
//                 RequiresApproval := true;
//             end;
//         end;

//         if AgentTarriffHeader.Get('TRANSFER') then begin
//             SkyAgentsTransactions.Reset;
//             SkyAgentsTransactions.SetRange("Transaction ID", TransactionSessionID);
//             if SkyAgentsTransactions.FindFirst then begin
//                 ResponseMessage := 'Transaction exists.';
//                 Status := 'FAILED';
//             end;
//             if RequiresApproval then begin
//                 SkyAgentTransfer.Reset;
//                 SkyAgentTransfer.SetRange("Transaction ID", TransactionSessionID);
//                 if SkyAgentTransfer.FindFirst then begin
//                     ResponseMessage := 'Transaction exists.';
//                     Status := 'FAILED';
//                 end;
//             end;
//         end;

//         if DebitAccountType = 'VENDOR' then begin
//             Vendor.Get(AgentDebitNumber);
//             if Status = 'SUCCESS' then begin
//                 if (Vendor.Blocked = Vendor.Blocked::All) or (Vendor.Blocked = Vendor.Blocked::Payment) then begin
//                     ResponseMessage := 'Your account account is blocked Acc No: ' + Vendor."No.";
//                     Status := 'BLOCKED';
//                 end;
//             end;
//             Vendor.CalcFields("Balance (LCY)");
//             if Status = 'SUCCESS' then begin
//                 if TransactionAmount > Vendor."Balance (LCY)" then begin
//                     ResponseMessage := 'Insufficient Balance';
//                     Status := 'FAILED';
//                 end;
//             end;
//         end else begin
//             SavingsAccounts.Get(AgentDebitNumber);
//             if Status = 'SUCCESS' then begin
//                 if (SavingsAccounts.Status <> SavingsAccounts.Status::Active) or (SavingsAccounts.Blocked = SavingsAccounts.Blocked::All) or (SavingsAccounts.Blocked = SavingsAccounts.Blocked::Debit) then begin
//                     ResponseMessage := 'Your account account is blocked Acc No: ' + SavingsAccounts."No.";
//                     Status := 'BLOCKED';
//                 end;
//             end;
//             SavingsAccounts.CalcFields("Balance (LCY)");
//             if Status = 'SUCCESS' then begin
//                 if TransactionAmount > SavingsAccounts."Balance (LCY)" then begin
//                     ResponseMessage := 'Insufficient Balance';
//                     Status := 'FAILED';
//                 end;
//             end;
//         end;
//         SavingsAccounts.Get(AgentCreditNumber);
//         if Status = 'SUCCESS' then begin
//             if (SavingsAccounts.Status <> SavingsAccounts.Status::Active) or (SavingsAccounts.Blocked = SavingsAccounts.Blocked::All) or (SavingsAccounts.Blocked = SavingsAccounts.Blocked::Credit) then begin
//                 ResponseMessage := 'Your account account is blocked Acc No: ' + SavingsAccounts."No.";
//                 Status := 'BLOCKED';
//             end;
//         end;

//         if Status = 'SUCCESS' then begin
//             if RequiresApproval then begin
//                 SkyAgentTransfer.Init;
//                 SkyAgentTransfer."Entry No." := CreateGuid;
//                 SkyAgentTransfer."Agent Code" := AgentUsername;
//                 SkyAgentTransfer."Transaction ID" := TransactionSessionID;
//                 SkyAgentTransfer."Session ID" := TransactionSessionID;
//                 SkyAgentTransfer."Transaction Type" := SkyAgentsTransactions."transaction type"::InternalAgentTransfer;
//                 SkyAgentTransfer.Description := CopyStr(TransactionNarration, 1, 50);
//                 SkyAgentTransfer."Transaction Date" := Dt2Date(CurrentDatetime);
//                 SkyAgentTransfer."Transaction Time" := Dt2Time(CurrentDatetime);
//                 SkyAgentTransfer."Agent From Account" := AgentDebitNumber;
//                 SkyAgentTransfer."Agent To Account" := AgentCreditNumber;
//                 SkyAgentTransfer."Member No" := AgentMemberNumber;
//                 SkyAgentTransfer.Amount := TransactionAmount;
//                 SkyAgentTransfer."Agent Name" := AgentName;
//                 SkyAgentTransfer."Debit Account Type" := DebitAccountType;
//                 SkyAgentTransfer."Loan No." := '';
//                 SkyAgentTransfer.Insert;
//                 PostAgentTransaction(TransactionSessionID);
//             end else begin
//                 //Insert into agency transactions
//                 SkyAgentsTransactions.Init;
//                 SkyAgentsTransactions."Entry No." := CreateGuid;
//                 SkyAgentsTransactions."Agent Code" := AgentUsername;
//                 SkyAgentsTransactions."Transaction ID" := TransactionSessionID;
//                 SkyAgentsTransactions."Session ID" := TransactionSessionID;
//                 SkyAgentsTransactions."Transaction Type" := SkyAgentsTransactions."transaction type"::InternalAgentTransfer;
//                 SkyAgentsTransactions.Description := CopyStr(TransactionNarration, 1, 50);
//                 SkyAgentsTransactions."Transaction Date" := Dt2Date(CurrentDatetime);
//                 SkyAgentsTransactions."Transaction Time" := Dt2Time(CurrentDatetime);
//                 SkyAgentsTransactions."Agent From Account" := AgentDebitNumber;
//                 SkyAgentsTransactions."Agent To Account" := AgentCreditNumber;
//                 SkyAgentsTransactions."Member No" := MemberNumber;
//                 SkyAgentsTransactions.Amount := TransactionAmount;
//                 SkyAgentsTransactions."Debit Account Type" := DebitAccountType;
//                 SkyAgentsTransactions."Loan No." := '';
//                 SkyAgentsTransactions.Insert;

//                 //post transaction
//                 PostAgentTransaction(TransactionSessionID)
//             end;
//         end;
//         if (RequiresApproval) and (Status = 'SUCCESS') then
//             ResponseMessage := 'Your request to transfer float was received successfully. Please contact your account Manager to finalise the transaction';
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);
//         //        LocalJsonTextWriter.WriteEndObject;



//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, Indent);

//     end;


//     procedure PostAgentTransaction(TrandsactionID: Code[30]): Boolean
//     var
//         SkyAgentsTransactions: Record "Sky Agents Transactions";
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
//         Dim1: Code[20];
//         Dim2: Code[20];
//         SystCreated: Boolean;
//         GenSetup: Record "General Set-Up";
//         GenJournalBatch: Record "Gen. Journal Batch";
//         GenJournalLine: Record "Gen. Journal Line";
//         SaccoTrans: Codeunit "Sacco Transactions";
//         SavAcc: Record "Savings Accounts";
//         TransAmt: Decimal;
//         LoanNo: Code[30];
//         SkyAgentTransfer: Record "Sky Agent Transfer";
//     begin
//         JTemplate := 'GENERAL';
//         JBatch := 'DEFAULT';
//         SaccoTrans.InitJournal(JBatch, JTemplate);

//         SkyAgentsTransactions.Reset;
//         SkyAgentsTransactions.SetRange("Transaction ID", TrandsactionID);
//         SkyAgentsTransactions.SetRange(Posted, false);
//         if SkyAgentsTransactions.FindFirst then begin
//             DocNo := SkyAgentsTransactions."Transaction ID";
//             PDate := SkyAgentsTransactions."Transaction Date";

//             SavAcc.Get(SkyAgentsTransactions."Agent To Account");
//             ExtDoc := '';
//             TransType := Transtype::" ";
//             Dim1 := SavAcc."Global Dimension 1 Code";
//             Dim2 := SavAcc."Global Dimension 2 Code";
//             SystCreated := true;
//             TransAmt := SkyAgentsTransactions.Amount;
//             LoanNo := '';

//             //Debit member account
//             AcctType := Accttype::Savings;
//             if SkyAgentsTransactions."Debit Account Type" = 'VENDOR' then AcctType := Accttype::Vendor;
//             SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType, SkyAgentsTransactions."Agent From Account",
//             CopyStr(SkyAgentsTransactions.Description, 1, 50), Balacctype::"G/L Account", '', TransAmt, ExtDoc, LoanNo, TransType,
//             Dim1, Dim2, SystCreated);


//             //Credit agent account
//             AcctType := Accttype::Savings;
//             SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType, SkyAgentsTransactions."Agent To Account",
//             CopyStr(SkyAgentsTransactions.Description, 1, 50), Balacctype::"G/L Account", '', -TransAmt, ExtDoc, LoanNo, TransType,
//             Dim1, Dim2, SystCreated);


//             SaccoTrans.PostJournal(JTemplate, JBatch);
//             SkyAgentsTransactions.Posted := true;

//             SkyAgentsTransactions."Posted By" := UserId;
//             SkyAgentsTransactions."Date Posted" := Today;
//             SkyAgentsTransactions."Time Posted" := Time;
//             SkyAgentsTransactions.Modify;
//             exit(true);
//         end else begin
//             SkyAgentTransfer.Reset;
//             SkyAgentTransfer.SetRange("Transaction ID", TrandsactionID);
//             SkyAgentTransfer.SetRange(Posted, false);
//             if SkyAgentTransfer.FindFirst then begin
//                 DocNo := SkyAgentTransfer."Transaction ID";
//                 PDate := SkyAgentTransfer."Transaction Date";

//                 SavAcc.Get(SkyAgentTransfer."Agent To Account");
//                 ExtDoc := '';
//                 TransType := Transtype::" ";
//                 Dim1 := SavAcc."Global Dimension 1 Code";
//                 Dim2 := SavAcc."Global Dimension 2 Code";
//                 SystCreated := true;
//                 TransAmt := SkyAgentTransfer.Amount;
//                 LoanNo := '';

//                 //Debit member account
//                 AcctType := Accttype::Savings;
//                 if SkyAgentTransfer."Debit Account Type" = 'VENDOR' then AcctType := Accttype::Vendor;
//                 SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType, SkyAgentTransfer."Agent From Account",
//                 CopyStr(SkyAgentTransfer.Description, 1, 50), Balacctype::"G/L Account", '', TransAmt, ExtDoc, LoanNo, TransType,
//                 Dim1, Dim2, SystCreated);


//                 //Credit agent account
//                 AcctType := Accttype::Savings;
//                 SaccoTrans.JournalInsert(JTemplate, JBatch, DocNo, PDate, AcctType, SkyAgentTransfer."Agent To Account",
//                 CopyStr(SkyAgentTransfer.Description, 1, 50), Balacctype::"G/L Account", '', -TransAmt, ExtDoc, LoanNo, TransType,
//                 Dim1, Dim2, SystCreated);


//                 SaccoTrans.PostJournal(JTemplate, JBatch);
//                 SkyAgentTransfer.Posted := true;

//                 SkyAgentTransfer."Posted By" := UserId;
//                 SkyAgentTransfer."Date Posted" := Today;
//                 SkyAgentTransfer."Time Posted" := Time;
//                 SkyAgentTransfer.Modify;
//                 exit(true);
//             end else
//                 exit(false);
//         end;
//     end;


//     procedure AgentMinistatement(EntryCode: Code[30]; TransactionID: Code[20]; StartDate: Date; EndDate: Date; StatementAccount: Code[20]; Pin: Text; AgentUsername: Text) Response: Text
//     var
//         SaccoFee: Decimal;
//         VendorCommission: Decimal;
//         TotalCharge: Decimal;
//         SavAcc: Record "Savings Accounts";
//         SaccoAccount: Code[20];
//         VendorAccount: Code[20];
//         PhoneNo: Code[20];
//         AccBal: Decimal;
//         VendorRec: Record Vendor;
//         JTemplate: Code[10];
//         JBatch: Code[10];
//         MobileTrans: Record "Sky Transactions";
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
//         Dim1: Code[10];
//         Dim2: Code[10];
//         SystCreated: Boolean;
//         SLedger: Record "Savings Ledger Entry";
//         LedgerCount: Integer;
//         CurrRecord: Integer;
//         DFilter: Text;
//         DebitCreditFlag: Code[10];
//         FirstEntry: Boolean;
//         ProdFact: Record "Product Factory";
//         TransactionDate: DateTime;
//         FileName: Text;
//         Stmt: Text;
//         AccountToCharge: Code[20];
//         MemberNo: Code[20];
//         RCount: Integer;
//         SkyAgencyAuth: Record "Sky Agency Auth";
//         Status: Boolean;
//         Vendor: Record Vendor;
//         VendorLedgerEntry: Record "Vendor Ledger Entry";
//         SavingsAccounts: Record "Savings Accounts";
//         TempFile: File;
//     begin

//         TransactionDate := CurrentDatetime;


//         Response := '';
//         Status := true;

//         if not SkyAgencyAuth.Get(AgentUsername) then begin
//             Response := 'INCORRECT_USERNAME';
//             Response := '<Response>';
//             Response += '<Status>AGENT_NOT_FOUND</Status>';
//             Response += '<StatusDescription>Agent Not found</StatusDescription>';
//             Response += '<Reference>' + TransactionID + '</Reference>';
//             Response += '</Response>';
//             Status := false;
//         end;

//         if Status then begin
//             SkyAgencyAuth.Reset;
//             SkyAgencyAuth.SetRange(Username, AgentUsername);
//             SkyAgencyAuth.SetRange(Password, Pin);
//             if not SkyAgencyAuth.FindFirst then begin
//                 Response := 'INCORRECT_PIN';
//                 Response := '<Response>';
//                 Response += '<Status>INCORRECT_PIN</Status>';
//                 Response += '<StatusDescription>Incorrect PIN</StatusDescription>';
//                 Response += '<Reference>' + TransactionID + '</Reference>';
//                 Response += '</Response>';
//                 Status := false;
//             end;
//         end;

//         Response += '<Response>';
//         if Status then begin
//             if SavAcc.Get(StatementAccount) then begin
//                 SLedger.Reset;
//                 SLedger.SetRange("Customer No.", SavAcc."No.");
//                 SLedger.SetFilter("Posting Date", '>=%1', StartDate);
//                 SLedger.SetFilter("Posting Date", '<=%1', EndDate);
//                 if SLedger.FindFirst then begin
//                     //REPORT.RUN(52185948,FALSE,FALSE,SLedger);
//                     FileName := 'O:\agent\' + TransactionID + '.pdf';
//                     Report.SaveAsPdf(Report::"Agent Transactions B64", FileName, SLedger);
//                     repeat
//                         SavingsAccounts.Reset;
//                         SavingsAccounts.SetRange("No.", SLedger."Customer No.");
//                         SavingsAccounts.SetFilter("Date Filter", '..' + Format(EndDate));
//                         if SavingsAccounts.FindFirst then begin
//                             SavingsAccounts.CalcFields("Balance (LCY)");
//                             AccBal := SavingsAccounts."Balance (LCY)";
//                         end;

//                         Response += '<Transaction>';
//                         Response += '<Date>' + Format(SLedger."Posting Date") + '</Date>';
//                         Response += '<Desc>' + SLedger.Description + '</Desc>';
//                         Response += '<Amount>' + Format(SLedger.Amount * -1) + '</Amount>';
//                         Response += '<Reference>' + Format(SLedger."Entry No.") + '</Reference>';
//                         Response += '<RunningBalance>' + Format(AccBal) + '</RunningBalance>';
//                         Response += '</Transaction>';

//                     until SLedger.Next = 0;
//                 end;
//             end else
//                 if Vendor.Get(StatementAccount) then begin
//                     VendorLedgerEntry.Reset;
//                     VendorLedgerEntry.SetRange("Vendor No.", Vendor."No.");
//                     VendorLedgerEntry.SetFilter("Posting Date", '>=%1', StartDate);
//                     VendorLedgerEntry.SetFilter("Posting Date", '<=%1', EndDate);
//                     if VendorLedgerEntry.FindFirst then begin
//                         repeat
//                             VendorRec.Reset;
//                             VendorRec.SetRange("No.", StatementAccount);
//                             VendorRec.SetFilter("Date Filter", '..' + Format(EndDate));
//                             if VendorRec.FindFirst then begin
//                                 VendorRec.CalcFields("Balance (LCY)");
//                                 AccBal := VendorRec."Balance (LCY)"
//                             end;
//                             Response += '<Transaction>';
//                             Response += '<Date>' + Format(VendorLedgerEntry."Posting Date") + '</Date>';
//                             Response += '<Desc>' + VendorLedgerEntry.Description + '</Desc>';
//                             Response += '<Amount>' + Format(VendorLedgerEntry.Amount * -1) + '</Amount>';
//                             Response += '<Reference>' + Format(VendorLedgerEntry."Entry No.") + '</Reference>';
//                             Response += '<RunningBalance>' + Format(AccBal) + '</RunningBalance>';
//                             Response += '</Transaction>';
//                         until VendorLedgerEntry.Next = 0;
//                     end;
//                 end else begin
//                     Response := '<Response>';
//                     Response += '<Status>INVALID_ACCOUNT</Status>';
//                     Response += '<StatusDescription>Invalid Account</StatusDescription>';
//                     Response += '<Reference>' + TransactionID + '</Reference>';
//                 end;
//         end;
//         Response += '</Response>';
//     end;


//     procedure AgentTransactions(EntryCode: Code[30]; TransactionID: Code[20]; StartDate: Date; EndDate: Date; Pin: Text; AgentUsername: Text; TransactionType: Text) Response: Text
//     var
//         SaccoFee: Decimal;
//         VendorCommission: Decimal;
//         TotalCharge: Decimal;
//         SavAcc: Record "Savings Accounts";
//         SaccoAccount: Code[20];
//         VendorAccount: Code[20];
//         PhoneNo: Code[20];
//         AccBal: Decimal;
//         VendorRec: Record Vendor;
//         JTemplate: Code[10];
//         JBatch: Code[10];
//         SkyAgentsTransactions: Record "Sky Agents Transactions";
//         DocNo: Code[20];
//         PDate: Date;
//         AcctType: Enum "Gen. Journal Account Type";
//         BalAccType: Enum "Gen. Journal Account Type";
//         AccNo: Code[20];
//         BalAccNo: Code[20];
//         TransType: Option "None",Registration,Withdrawal,Deposit,LoanRepayment,Transfer,Sharedeposit,Schoolfeespayment,Balance,Ministatment,Paybill," Memberactivation",MemberRegistration,InternalAgentTransfer;
//         ExtDoc: Code[20];
//         LoanNo: Code[20];
//         Dim1: Code[10];
//         Dim2: Code[10];
//         SystCreated: Boolean;
//         SLedger: Record "Savings Ledger Entry";
//         LedgerCount: Integer;
//         CurrRecord: Integer;
//         DFilter: Text;
//         DebitCreditFlag: Code[10];
//         FirstEntry: Boolean;
//         ProdFact: Record "Product Factory";
//         TransactionDate: DateTime;
//         FileName: Text;
//         Stmt: Text;
//         AccountToCharge: Code[20];
//         MemberNo: Code[20];
//         RCount: Integer;
//         SkyAgencyAuth: Record "Sky Agency Auth";
//         Status: Boolean;
//         Vendor: Record Vendor;
//         VendorLedgerEntry: Record "Vendor Ledger Entry";
//         SavingsAccounts: Record "Savings Accounts";
//         TempFile: File;
//     begin

//         TransactionDate := CurrentDatetime;


//         Response := '';
//         Status := true;

//         if not SkyAgencyAuth.Get(AgentUsername) then begin
//             Response := 'INCORRECT_USERNAME';
//             Response := '<Response>';
//             Response += '<Status>AGENT_NOT_FOUND</Status>';
//             Response += '<StatusDescription>Agent Not found</StatusDescription>';
//             Response += '<Reference>' + TransactionID + '</Reference>';
//             Response += '</Response>';
//             Status := false;
//         end;


//         if Status then begin
//             SkyAgencyAuth.Reset;
//             SkyAgencyAuth.SetRange(Username, AgentUsername);
//             SkyAgencyAuth.SetRange(Password, Pin);
//             if not SkyAgencyAuth.FindFirst then begin
//                 Response := 'INCORRECT_PIN';
//                 Response := '<Response>';
//                 Response += '<Status>INCORRECT_PIN</Status>';
//                 Response += '<StatusDescription>Incorrect PIN</StatusDescription>';
//                 Response += '<Reference>' + TransactionID + '</Reference>';
//                 Response += '</Response>';
//                 Status := false;
//             end;
//         end;

//         Response += '<Response>';
//         if Status then begin
//             if TransactionType = 'CASH_WITHDRAWAL' then
//                 TransType := Transtype::Withdrawal
//             else
//                 if TransactionType = 'CASH_DEPOSIT' then
//                     TransType := Transtype::Deposit
//                 else
//                     if TransactionType = 'ACCOUNT_BALANCE' then
//                         TransType := Transtype::Balance
//                     else
//                         if TransactionType = 'ACCOUNT_STATEMENT' then
//                             TransType := Transtype::Ministatment
//                         else
//                             if TransactionType = 'LOAN_PAYMENT' then
//                                 TransType := Transtype::LoanRepayment;

//             SkyAgentsTransactions.Reset;
//             SkyAgentsTransactions.SetRange("Transaction Type", TransType);
//             SkyAgentsTransactions.SetRange(Posted, true);
//             SkyAgentsTransactions.SetRange("Date Posted", StartDate, EndDate);
//             if SkyAgentsTransactions.FindFirst then begin
//                 repeat

//                     Response += '<Transaction>';
//                     Response += '<Date>' + Format(SkyAgentsTransactions."Date Posted") + '</Date>';
//                     Response += '<Desc>' + SkyAgentsTransactions.Description + '</Desc>';
//                     Response += '<Amount>' + Format(SkyAgentsTransactions.Amount) + '</Amount>';
//                     Response += '<Reference>' + Format(SkyAgentsTransactions."Entry No.") + '</Reference>';
//                     Response += '</Transaction>';

//                 until SkyAgentsTransactions.Next = 0;
//             end else begin
//                 Response += '<Status>NO_TRANSACTIONS_FOUND</Status>';
//                 Response += '<StatusDescription>No transactions found/StatusDescription>';
//                 Response += '<Reference>' + TransactionID + '</Reference>';

//             end;
//         end;
//         Response += '</Response>';
//     end;

//     local procedure FormatDate(Date: Date) DateText: Text
//     var
//         Day: Integer;
//         Month: Integer;
//         Year: Integer;
//         FormatedDate: Text;
//         MonthText: Text;
//     begin
//         Month := Date2dmy(Date, 2);
//         if Month = 1 then
//             MonthText := 'Jan' else
//             if Month = 2 then
//                 MonthText := 'Feb' else
//                 if Month = 3 then
//                     MonthText := 'Mar' else
//                     if Month = 4 then
//                         MonthText := 'Apr'
//                     else
//                         if Month = 5 then
//                             MonthText := 'May' else
//                             if Month = 6 then
//                                 MonthText := 'Jun' else
//                                 if Month = 7 then
//                                     MonthText := 'Jul' else
//                                     if Month = 8 then
//                                         MonthText := 'Aug'
//                                     else
//                                         if Month = 9 then
//                                             MonthText := 'Sep' else
//                                             if Month = 10 then
//                                                 MonthText := 'Oct' else
//                                                 if Month = 11 then
//                                                     MonthText := 'Nov'
//                                                 else
//                                                     if Month = 12 then MonthText := 'Dec';
//         FormatedDate := Format(Date2dmy(Date, 1)) + ' ' + MonthText + ' ' + Format(Date2dmy(Date, 3));
//         exit(FormatedDate);
//     end;

//     local procedure MaskFuction(Text: Text): Text
//     var
//         StringLength: Decimal;
//         LoopTimes: Decimal;
//         MaskedString: Text;
//         Masks: Text;
//         SubtractFigure: Decimal;
//         DecimalPart: Decimal;
//         IntegerPart: Decimal;
//         IntegerDevided: Decimal;
//     begin
//         StringLength := StrLen(Text);
//         SubtractFigure := 0.5 * StringLength;
//         DecimalPart := (SubtractFigure MOD 1);
//         IntegerPart := (SubtractFigure DIV 1);
//         IntegerDevided := ((IntegerPart / 2) DIV 1);

//         LoopTimes := StringLength - IntegerPart;
//         LoopTimes += 1;
//         MaskedString := CopyStr(Text, 1, (IntegerDevided));
//         Masks := '';
//         repeat
//             Masks += '*';
//             LoopTimes -= 1;
//         until LoopTimes = 0;
//         MaskedString := MaskedString + Masks + CopyStr(Text, StringLength - ((IntegerDevided) - 1), (IntegerDevided));
//         exit(MaskedString);
//     end;

//     local procedure GetLoanBalance(LoanNo: Code[20]) Arreas: Decimal
//     var
//         MobileNo: Code[20];
//         Loans: Record Loans;
//         LoanProduct: Record "Product Factory";
//         SavAcc: Record "Savings Accounts";
//         MemberNo: Code[20];
//         MaxLoan: Decimal;
//         Found: Boolean;
//         arrears: Decimal;
//         balance: Decimal;
//     begin
//         Loans.Reset;
//         Loans.SetRange("Loan No.", LoanNo);
//         if Loans.FindFirst then begin

//             Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Outstanding Bills");
//             if Loans."Outstanding Bills" < 0 then
//                 Loans."Outstanding Bills" := 0;
//             if Loans."Outstanding Interest" < 0 then
//                 Loans."Outstanding Interest" := 0;

//             Arreas := (Loans."Outstanding Bills" + Loans."Outstanding Interest");
//             balance := (Loans."Outstanding Balance" + Loans."Outstanding Interest");
//         end;
//     end;

//     local procedure GetLoanBalance2(LoanNo: Code[20]; var OutstandingBal: Decimal; var OutstandingInt: Decimal; var Arrears: Decimal)
//     var
//         MobileNo: Code[20];
//         Loans: Record Loans;
//         LoanProduct: Record "Product Factory";
//         SavAcc: Record "Savings Accounts";
//         MemberNo: Code[20];
//         MaxLoan: Decimal;
//         Found: Boolean;
//         balance: Decimal;
//     begin
//         Loans.Reset;
//         Loans.SetRange("Loan No.", LoanNo);
//         if Loans.FindFirst then begin

//             Loans.CalcFields("Outstanding Balance", "Outstanding Interest", "Outstanding Bills");
//             if Loans."Outstanding Bills" < 0 then
//                 Loans."Outstanding Bills" := 0;
//             if Loans."Outstanding Interest" < 0 then
//                 Loans."Outstanding Interest" := 0;

//             Arrears := (Loans."Outstanding Bills" + Loans."Outstanding Interest");
//             OutstandingBal := Loans."Outstanding Balance";
//             OutstandingInt := Loans."Outstanding Interest";
//         end;
//     end;


//     procedure GetTransactionLimits("Action": Text; TransactionType: Text) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SkyAgencyAuth: Record "Sky Agency Auth";
//         AgentCode: Code[30];
//         SkySearchOptions: Record "Sky Search Options";
//         AgentApplications: Record "Agent Applications";
//         AgentTarriffHeader: Record "Agent Tarriff Header";
//         AgentTariffDetails: Record "Agent Tariff Details";
//         MinAmount: Decimal;
//         MaxAmount: Decimal;
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
//         ResponseTitle := 'Transaction Limits';
//         ResponseMessage := 'Transaction Limits Fetched Successfully';
//         /*-------------------------------------------------------------------------------------*/

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('transaction_limits');
//         //        LocalJsonTextWriter.WriteStartArray;

//         if AgentTarriffHeader.Get(TransactionType) then begin
//             AgentTariffDetails.Reset;
//             AgentTariffDetails.SetRange(Code, AgentTarriffHeader.Code);
//             if AgentTariffDetails.FindFirst then begin
//                 MinAmount := AgentTariffDetails."Lower Limit";
//             end;
//             AgentTariffDetails.Reset;
//             AgentTariffDetails.SetRange(Code, AgentTarriffHeader.Code);
//             if AgentTariffDetails.FindLast then begin
//                 MaxAmount := AgentTariffDetails."Upper Limit";
//             end;


//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('minimum_amount');
//             //            LocalJsonTextWriter.WriteValue(Format(MinAmount));
//             //            LocalJsonTextWriter.WritePropertyName('maximum_amount');
//             //            LocalJsonTextWriter.WriteValue(Format(MaxAmount));
//             //            LocalJsonTextWriter.WriteEndObject;
//         end else begin
//             Status := 'FAILED';
//             ResponseTitle := 'Transaction Limits';
//             ResponseMessage := 'Transaction does not exist';
//         end;
//         //        LocalJsonTextWriter.WriteEndArray;
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


//     procedure GetAgentReport("Action": Code[50]; Indent: Boolean; AgentUsername: Text; AgentPassword: Text; FromDate: Date; ToDate: Date) Response: Text
//     var
//         //        LocalJsonTextWriter: code[100];//dotnet JsonTextWriter;
//         LocalStringBuilder: code[100];//dotnet StringBuilder;
//         LocalStringWriter: code[100];//dotnet StringWriter;
//         Status: Code[50];
//         Payload: code[100];//dotnet String;
//         ResponseTitle: Text;
//         ResponseMessage: Text;
//         Iterator: Integer;
//         SkyAgencyAuth: Record "Sky Agency Auth";
//         AgentCode: Code[30];
//         SavingsAccounts: Record "Savings Accounts";
//         AgentApplication: Record "Agent Applications";
//         ProductFactory: Record "Product Factory";
//         Vendor: Record Vendor;
//         SkyAgentsTransactions: Record "Sky Agents Transactions";
//         TotalWithdrawals: Decimal;
//         WithdrawalCount: Integer;
//         TotalDeposits: Decimal;
//         DepositsCount: Integer;
//         LoanRepayments: Decimal;
//         VendorLedgerEntry: Record "Vendor Ledger Entry";
//         CommOnAccBal: Decimal;
//         CommOnLoanBal: Decimal;
//         CommOnStatement: Decimal;
//         TransactionType: Text;
//         VenCommBal: Decimal;
//         FloatBal: Decimal;
//         TotalCredits: Decimal;
//         SavingsLedgerEntry: Record "Savings Ledger Entry";
//         TotalDebits: Decimal;
//         FileName: Text;
//         TempBlob: Record "Sky TempBlob";
//         // FileManagement: Codeunit "Sky File Management";
//         VariableBlobAT: Text;
//         VariableBlobCW: Text;
//         VariableBlobCD: Text;
//         VariableBlobLR: Text;
//         VariableBlobAB: Text;
//         VariableBlobLB: Text;
//         VariableBlobAS: Text;
//         TotalDebitsAndCredits: Decimal;
//         AgentAccountNo: Code[30];
//     begin
//         /*
//         Possible Account Types:
//         ---------------------------
//         WITHDRAWABLE - Available during customer cash withdrawal
//         DEPOSITABLE - Available during customer cash deposit
//         ALL - Allagent accounts plus FOSA & BOSA
//         TRANSFERRABLE_FROM - Available during agent float top up
//         TRANSFERRABLE_TO - Available during agent float top up
//         ---------------------------
//         */
//         //LocalStringBuilder := LocalStringBuilder.StringBuilder;
//         //        LocalStringWriter := LocalStringWriter.StringWriter(LocalStringBuilder);
//         //        LocalJsonTextWriter := LocalJsonTextWriter.JsonTextWriter(LocalStringWriter);
//         //        if Indent then begin LocalJsonTextWriter.Formatting := JsonFormatting.Indented; end;
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
//         ResponseTitle := 'Agent Report';
//         ResponseMessage := 'Agent Report Fetched Successfully';
//         /*-------------------------------------------------------------------------------------*/

//         if AgentApplication.Get(AgentUsername) then begin
//             ResponseMessage := 'Agent Found';
//             Status := 'SUCCESS';
//             //AgentCode := SkyAgencyAuth."Agent Code";
//         end else begin
//             ResponseMessage := 'Agent not found';
//             Status := 'FAILED';
//         end;


//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('data');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('tabs');
//         //        LocalJsonTextWriter.WriteStartArray;
//         if Status = 'SUCCESS' then begin
//             /*START: GENERATE REPORT*/
//             SkyAgentsTransactions.Reset;
//             SkyAgentsTransactions.SetRange("Agent Code", AgentUsername);
//             SkyAgentsTransactions.SetRange(Posted, true);
//             SkyAgentsTransactions.SetRange("Date Posted", FromDate, ToDate);
//             if SkyAgentsTransactions.FindFirst then begin
//                 FileName := 'C:\pdf\' + SkyAgentsTransactions."Agent Code" + 'AT.pdf';
//                 Report.SaveAsPdf(Report::"Agent Transactions B64", FileName, SkyAgentsTransactions);
//                 FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
//                 VariableBlobAT := Format(TempBlob.ToBase64String);
//             end;
//             /*END  : GENERATE REPORT*/
//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('id');
//             //            LocalJsonTextWriter.WriteValue('ALL_TRANSACTIONS');
//             //            LocalJsonTextWriter.WritePropertyName('title');
//             //            LocalJsonTextWriter.WriteValue('All Transactions');
//             //            LocalJsonTextWriter.WritePropertyName('caption');
//             //            LocalJsonTextWriter.WriteValue('AT');
//             //            LocalJsonTextWriter.WritePropertyName('pdf');
//             //            LocalJsonTextWriter.WriteValue(VariableBlobAT);
//             //            LocalJsonTextWriter.WriteEndObject;

//             /*START: GENERATE REPORT*/
//             SkyAgentsTransactions.Reset;
//             SkyAgentsTransactions.SetRange("Agent Code", AgentUsername);
//             SkyAgentsTransactions.SetRange(Posted, true);
//             SkyAgentsTransactions.SetRange("Transaction Type", SkyAgentsTransactions."transaction type"::Withdrawal);
//             SkyAgentsTransactions.SetRange("Date Posted", FromDate, ToDate);
//             if SkyAgentsTransactions.FindFirst then begin
//                 FileName := 'C:\pdf\' + SkyAgentsTransactions."Agent Code" + 'CW.pdf';
//                 Report.SaveAsPdf(Report::"Agent Transactions B64", FileName, SkyAgentsTransactions);
//                 FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
//                 VariableBlobCW := Format(TempBlob.ToBase64String);
//             end;
//             /*END  : GENERATE REPORT*/
//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('id');
//             //            LocalJsonTextWriter.WriteValue('CASH_WITHDRAWAL');
//             //            LocalJsonTextWriter.WritePropertyName('title');
//             //            LocalJsonTextWriter.WriteValue('Cash Withdrawal');
//             //            LocalJsonTextWriter.WritePropertyName('caption');
//             //            LocalJsonTextWriter.WriteValue('CW');
//             //            LocalJsonTextWriter.WritePropertyName('pdf');
//             //            LocalJsonTextWriter.WriteValue(VariableBlobCW);
//             //            LocalJsonTextWriter.WriteEndObject;

//             /*START: GENERATE REPORT*/
//             SkyAgentsTransactions.Reset;
//             SkyAgentsTransactions.SetRange("Agent Code", AgentUsername);
//             SkyAgentsTransactions.SetRange(Posted, true);
//             SkyAgentsTransactions.SetRange("Transaction Type", SkyAgentsTransactions."transaction type"::Deposit);
//             SkyAgentsTransactions.SetRange("Date Posted", FromDate, ToDate);
//             if SkyAgentsTransactions.FindFirst then begin
//                 FileName := 'C:\pdf\' + SkyAgentsTransactions."Agent Code" + 'CD.pdf';
//                 Report.SaveAsPdf(Report::"Agent Transactions B64", FileName, SkyAgentsTransactions);
//                 FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
//                 VariableBlobCD := Format(TempBlob.ToBase64String);
//             end;
//             /*END  : GENERATE REPORT*/
//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('id');
//             //            LocalJsonTextWriter.WriteValue('CASH_DEPOSIT');
//             //            LocalJsonTextWriter.WritePropertyName('title');
//             //            LocalJsonTextWriter.WriteValue('Cash Deposit');
//             //            LocalJsonTextWriter.WritePropertyName('caption');
//             //            LocalJsonTextWriter.WriteValue('CD');
//             //            LocalJsonTextWriter.WritePropertyName('pdf');
//             //            LocalJsonTextWriter.WriteValue(VariableBlobCD);
//             //            LocalJsonTextWriter.WriteEndObject;

//             /*START: GENERATE REPORT*/
//             SkyAgentsTransactions.Reset;
//             SkyAgentsTransactions.SetRange("Agent Code", AgentUsername);
//             SkyAgentsTransactions.SetRange(Posted, true);
//             SkyAgentsTransactions.SetRange("Transaction Type", SkyAgentsTransactions."transaction type"::LoanRepayment);
//             SkyAgentsTransactions.SetRange("Date Posted", FromDate, ToDate);
//             if SkyAgentsTransactions.FindFirst then begin
//                 FileName := 'C:\pdf\' + SkyAgentsTransactions."Agent Code" + 'LR.pdf';
//                 Report.SaveAsPdf(Report::"Agent Transactions B64", FileName, SkyAgentsTransactions);
//                 FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
//                 VariableBlobLR := Format(TempBlob.ToBase64String);
//             end;
//             /*END  : GENERATE REPORT*/
//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('id');
//             //            LocalJsonTextWriter.WriteValue('LOAN_REPAYMENT');
//             //            LocalJsonTextWriter.WritePropertyName('title');
//             //            LocalJsonTextWriter.WriteValue('Loan Repayment');
//             //            LocalJsonTextWriter.WritePropertyName('caption');
//             //            LocalJsonTextWriter.WriteValue('LR');
//             //            LocalJsonTextWriter.WritePropertyName('pdf');
//             //            LocalJsonTextWriter.WriteValue(VariableBlobLR);
//             //            LocalJsonTextWriter.WriteEndObject;

//             /*START: GENERATE REPORT*/
//             SkyAgentsTransactions.Reset;
//             SkyAgentsTransactions.SetRange("Agent Code", AgentUsername);
//             SkyAgentsTransactions.SetRange(Posted, true);
//             SkyAgentsTransactions.SetRange("Transaction Type", SkyAgentsTransactions."transaction type"::Balance);
//             SkyAgentsTransactions.SetRange("Transaction Name", 'Account Balance Enquiry');
//             SkyAgentsTransactions.SetRange("Date Posted", FromDate, ToDate);
//             if SkyAgentsTransactions.FindFirst then begin
//                 FileName := 'C:\pdf\' + SkyAgentsTransactions."Agent Code" + 'AB.pdf';
//                 Report.SaveAsPdf(Report::"Agent Transactions B64", FileName, SkyAgentsTransactions);
//                 FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
//                 VariableBlobAB := Format(TempBlob.ToBase64String);
//             end;
//             /*END  : GENERATE REPORT*/
//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('id');
//             //            LocalJsonTextWriter.WriteValue('ACCOUNT_BALANCE');
//             //            LocalJsonTextWriter.WritePropertyName('title');
//             //            LocalJsonTextWriter.WriteValue('Account Balance');
//             //            LocalJsonTextWriter.WritePropertyName('caption');
//             //            LocalJsonTextWriter.WriteValue('AB');
//             //            LocalJsonTextWriter.WritePropertyName('pdf');
//             //            LocalJsonTextWriter.WriteValue(VariableBlobAB);
//             //            LocalJsonTextWriter.WriteEndObject;

//             /*START: GENERATE REPORT*/
//             SkyAgentsTransactions.Reset;
//             SkyAgentsTransactions.SetRange("Agent Code", AgentUsername);
//             SkyAgentsTransactions.SetRange(Posted, true);
//             SkyAgentsTransactions.SetRange("Transaction Type", SkyAgentsTransactions."transaction type"::Balance);
//             SkyAgentsTransactions.SetRange("Transaction Name", 'Loan Balance Enquiry');
//             SkyAgentsTransactions.SetRange("Date Posted", FromDate, ToDate);
//             if SkyAgentsTransactions.FindFirst then begin
//                 FileName := 'C:\pdf\' + SkyAgentsTransactions."Agent Code" + 'LB.pdf';
//                 Report.SaveAsPdf(Report::"Agent Transactions B64", FileName, SkyAgentsTransactions);
//                 FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
//                 VariableBlobLB := Format(TempBlob.ToBase64String);
//             end;
//             /*END  : GENERATE REPORT*/
//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('id');
//             //            LocalJsonTextWriter.WriteValue('LOAN_BALANCE');
//             //            LocalJsonTextWriter.WritePropertyName('title');
//             //            LocalJsonTextWriter.WriteValue('Loan Balance');
//             //            LocalJsonTextWriter.WritePropertyName('caption');
//             //            LocalJsonTextWriter.WriteValue('LB');
//             //            LocalJsonTextWriter.WritePropertyName('pdf');
//             //            LocalJsonTextWriter.WriteValue(VariableBlobLB);
//             //            LocalJsonTextWriter.WriteEndObject;

//             /*START: GENERATE REPORT*/
//             SkyAgentsTransactions.Reset;
//             SkyAgentsTransactions.SetRange("Agent Code", AgentUsername);
//             SkyAgentsTransactions.SetRange(Posted, true);
//             SkyAgentsTransactions.SetRange("Transaction Type", SkyAgentsTransactions."transaction type"::Ministatment);
//             SkyAgentsTransactions.SetRange("Date Posted", FromDate, ToDate);
//             if SkyAgentsTransactions.FindFirst then begin
//                 FileName := 'C:\pdf\' + SkyAgentsTransactions."Agent Code" + 'AS.pdf';
//                 Report.SaveAsPdf(Report::"Agent Transactions B64", FileName, SkyAgentsTransactions);
//                 FileManagement.BLOBImportFromServerFile(TempBlob, FileName);
//                 VariableBlobAS := Format(TempBlob.ToBase64String);
//             end;
//             /*END  : GENERATE REPORT*/
//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('id');
//             //            LocalJsonTextWriter.WriteValue('ACCOUNT_STATEMENT');
//             //            LocalJsonTextWriter.WritePropertyName('title');
//             //            LocalJsonTextWriter.WriteValue('Account Statement');
//             //            LocalJsonTextWriter.WritePropertyName('caption');
//             //            LocalJsonTextWriter.WriteValue('AS');
//             //            LocalJsonTextWriter.WritePropertyName('pdf');
//             //            LocalJsonTextWriter.WriteValue(VariableBlobAS);
//             //            LocalJsonTextWriter.WriteEndObject;
//         end;
//         //        LocalJsonTextWriter.WriteEndArray;
//         //        LocalJsonTextWriter.WritePropertyName('statistics');
//         //        LocalJsonTextWriter.WriteStartArray;
//         if Status = 'SUCCESS' then begin

//             SkyAgentsTransactions.Reset;
//             SkyAgentsTransactions.SetRange("Agent Code", AgentUsername);
//             SkyAgentsTransactions.SetRange(Posted, true);
//             SkyAgentsTransactions.SetRange("Date Posted", FromDate, ToDate);
//             //SkyAgentsTransactions.SETFILTER("Date Posted",'<=%1',ToDate);
//             if SkyAgentsTransactions.FindFirst then begin
//                 repeat
//                     AgentAccountNo := SkyAgentsTransactions."Agent Account Number";
//                     if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Withdrawal then begin
//                         TotalWithdrawals += SkyAgentsTransactions.Amount;
//                         WithdrawalCount += 1;
//                     end else
//                         if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Deposit then begin
//                             TotalDeposits += SkyAgentsTransactions.Amount;
//                             DepositsCount += 1;
//                         end else
//                             if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::LoanRepayment then begin
//                                 LoanRepayments += SkyAgentsTransactions.Amount;
//                                 //DepositsCount += 1;
//                             end else
//                                 if (SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Balance) and (SkyAgentsTransactions."Transaction Name" = 'Account Balance Enquiry') then begin
//                                     VendorLedgerEntry.Reset;
//                                     VendorLedgerEntry.SetRange("Vendor No.", SkyAgentsTransactions."Agent Commision Account");
//                                     VendorLedgerEntry.SetRange("Document No.", SkyAgentsTransactions."Transaction ID");
//                                     if VendorLedgerEntry.FindFirst then begin
//                                         VendorLedgerEntry.CalcFields(Amount);
//                                         CommOnAccBal += VendorLedgerEntry.Amount;
//                                     end;
//                                 end else
//                                     if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Ministatment then begin
//                                         VendorLedgerEntry.Reset;
//                                         VendorLedgerEntry.SetRange("Vendor No.", SkyAgentsTransactions."Agent Commision Account");
//                                         VendorLedgerEntry.SetRange("Document No.", SkyAgentsTransactions."Transaction ID");
//                                         if VendorLedgerEntry.FindFirst then begin
//                                             VendorLedgerEntry.CalcFields(Amount);
//                                             CommOnStatement += VendorLedgerEntry.Amount;
//                                         end;
//                                     end else
//                                         if (SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Balance) and (SkyAgentsTransactions."Transaction Name" = 'Loan Balance Enquiry') then begin
//                                             VendorLedgerEntry.Reset;
//                                             VendorLedgerEntry.SetRange("Vendor No.", SkyAgentsTransactions."Agent Commision Account");
//                                             VendorLedgerEntry.SetRange("Document No.", SkyAgentsTransactions."Transaction ID");
//                                             if VendorLedgerEntry.FindFirst then begin
//                                                 VendorLedgerEntry.CalcFields(Amount);
//                                                 CommOnLoanBal += VendorLedgerEntry.Amount;
//                                             end;
//                                         end;
//                 until SkyAgentsTransactions.Next = 0;
//             end;
//             SavingsLedgerEntry.Reset;
//             SavingsLedgerEntry.SetRange("Customer No.", AgentAccountNo);
//             SavingsLedgerEntry.SetRange("Posting Date", FromDate, ToDate);
//             if SavingsLedgerEntry.FindFirst then begin

//                 SavingsLedgerEntry.CalcSums("Credit Amount (LCY)", "Debit Amount (LCY)", "Amount (LCY)");
//                 TotalCredits += SavingsLedgerEntry."Credit Amount (LCY)";
//                 TotalDebits += SavingsLedgerEntry."Debit Amount (LCY)";
//                 TotalDebitsAndCredits := SavingsLedgerEntry."Amount (LCY)";

//             end;
//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('tabs');
//             //            LocalJsonTextWriter.WriteValue('ALL_TRANSACTIONS');
//             //            LocalJsonTextWriter.WritePropertyName('title');
//             //            LocalJsonTextWriter.WriteValue('Total Credits');
//             //            LocalJsonTextWriter.WritePropertyName('value');
//             //            LocalJsonTextWriter.WriteValue(Format(Abs(TotalCredits)));
//             //            LocalJsonTextWriter.WritePropertyName('type');
//             //            LocalJsonTextWriter.WriteValue('currency');
//             //            LocalJsonTextWriter.WriteEndObject;

//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('tabs');
//             //            LocalJsonTextWriter.WriteValue('ALL_TRANSACTIONS');
//             //            LocalJsonTextWriter.WritePropertyName('title');
//             //            LocalJsonTextWriter.WriteValue('Total Debits');
//             //            LocalJsonTextWriter.WritePropertyName('value');
//             //            LocalJsonTextWriter.WriteValue(Format(Abs(TotalDebits)));
//             //            LocalJsonTextWriter.WritePropertyName('type');
//             //            LocalJsonTextWriter.WriteValue('currency');
//             //            LocalJsonTextWriter.WriteEndObject;

//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('tabs');
//             //            LocalJsonTextWriter.WriteValue('CASH_WITHDRAWAL');
//             //            LocalJsonTextWriter.WritePropertyName('title');
//             //            LocalJsonTextWriter.WriteValue('Total Amount Withdrawn');
//             //            LocalJsonTextWriter.WritePropertyName('value');
//             //            LocalJsonTextWriter.WriteValue(Format(TotalWithdrawals));
//             //            LocalJsonTextWriter.WritePropertyName('type');
//             //            LocalJsonTextWriter.WriteValue('currency');
//             //            LocalJsonTextWriter.WriteEndObject;


//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('tabs');
//             //            LocalJsonTextWriter.WriteValue('CASH_WITHDRAWAL');
//             //            LocalJsonTextWriter.WritePropertyName('title');
//             //            LocalJsonTextWriter.WriteValue('Count of Withdrawals');
//             //            LocalJsonTextWriter.WritePropertyName('value');
//             //            LocalJsonTextWriter.WriteValue(Format(WithdrawalCount));
//             //            LocalJsonTextWriter.WritePropertyName('type');
//             //            LocalJsonTextWriter.WriteValue('number');
//             //            LocalJsonTextWriter.WriteEndObject;


//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('tabs');
//             //            LocalJsonTextWriter.WriteValue('CASH_DEPOSIT');
//             //            LocalJsonTextWriter.WritePropertyName('title');
//             //            LocalJsonTextWriter.WriteValue('Total Amount Deposited');
//             //            LocalJsonTextWriter.WritePropertyName('value');
//             //            LocalJsonTextWriter.WriteValue(Format(TotalDeposits));
//             //            LocalJsonTextWriter.WritePropertyName('type');
//             //            LocalJsonTextWriter.WriteValue('currency');
//             //            LocalJsonTextWriter.WriteEndObject;


//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('tabs');
//             //            LocalJsonTextWriter.WriteValue('LOAN_REPAYMENT');
//             //            LocalJsonTextWriter.WritePropertyName('title');
//             //            LocalJsonTextWriter.WriteValue('Total Loans Repaid');
//             //            LocalJsonTextWriter.WritePropertyName('value');
//             //            LocalJsonTextWriter.WriteValue(Format(LoanRepayments));
//             //            LocalJsonTextWriter.WritePropertyName('type');
//             //            LocalJsonTextWriter.WriteValue('currency');
//             //            LocalJsonTextWriter.WriteEndObject;



//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('tabs');
//             //            LocalJsonTextWriter.WriteValue('ACCOUNT_BALANCE');
//             //            LocalJsonTextWriter.WritePropertyName('title');
//             //            LocalJsonTextWriter.WriteValue('Total Commission Earned');
//             //            LocalJsonTextWriter.WritePropertyName('value');
//             //            LocalJsonTextWriter.WriteValue(Format(Abs(CommOnAccBal)));
//             //            LocalJsonTextWriter.WritePropertyName('type');
//             //            LocalJsonTextWriter.WriteValue('currency');
//             //            LocalJsonTextWriter.WriteEndObject;


//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('tabs');
//             //            LocalJsonTextWriter.WriteValue('LOAN_BALANCE');
//             //            LocalJsonTextWriter.WritePropertyName('title');
//             //            LocalJsonTextWriter.WriteValue('Total Commission Earned');
//             //            LocalJsonTextWriter.WritePropertyName('value');
//             //            LocalJsonTextWriter.WriteValue(Format(Abs(CommOnLoanBal)));
//             //            LocalJsonTextWriter.WritePropertyName('type');
//             //            LocalJsonTextWriter.WriteValue('currency');
//             //            LocalJsonTextWriter.WriteEndObject;


//             //            LocalJsonTextWriter.WriteStartObject;
//             //            LocalJsonTextWriter.WritePropertyName('tabs');
//             //            LocalJsonTextWriter.WriteValue('ACCOUNT_STATEMENT');
//             //            LocalJsonTextWriter.WritePropertyName('title');
//             //            LocalJsonTextWriter.WriteValue('Total Commission Earned');
//             //            LocalJsonTextWriter.WritePropertyName('value');
//             //            LocalJsonTextWriter.WriteValue(Format(Abs(CommOnStatement)));
//             //            LocalJsonTextWriter.WritePropertyName('type');
//             //            LocalJsonTextWriter.WriteValue('currency');
//             //            LocalJsonTextWriter.WriteEndObject;
//         end;
//         //        LocalJsonTextWriter.WriteEndArray;

//         //        LocalJsonTextWriter.WritePropertyName('transactions');
//         //        LocalJsonTextWriter.WriteStartArray;
//         SkyAgentsTransactions.Reset;
//         SkyAgentsTransactions.SetCurrentkey("Date Posted", "Time Posted");
//         SkyAgentsTransactions.SetAscending("Date Posted", false);
//         SkyAgentsTransactions.SetAscending("Time Posted", false);
//         SkyAgentsTransactions.SetRange("Agent Code", AgentUsername);
//         SkyAgentsTransactions.SetRange(Posted, true);
//         SkyAgentsTransactions.SetRange("Date Posted", FromDate, ToDate);
//         //SkyAgentsTransactions.SETFILTER("Date Posted",'<=%1',ToDate);
//         if SkyAgentsTransactions.FindFirst then begin
//             repeat
//                 if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Withdrawal then
//                     TransactionType := 'CASH_WITHDRAWAL'
//                 else
//                     if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Deposit then
//                         TransactionType := 'CASH_DEPOSIT'
//                     else
//                         if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::LoanRepayment then
//                             TransactionType := 'LOAN_REPAYMENT'
//                         else
//                             if (SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Balance) and (SkyAgentsTransactions."Transaction Name" = 'Account Balance Enquiry') then
//                                 TransactionType := 'ACCOUNT_BALANCE'
//                             else
//                                 if (SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Balance) and (SkyAgentsTransactions."Transaction Name" = 'Loan Balance Enquiry') then
//                                     TransactionType := 'LOAN_BALANCE'
//                                 else
//                                     if SkyAgentsTransactions."Transaction Type" = SkyAgentsTransactions."transaction type"::Ministatment then
//                                         TransactionType := 'ACCOUNT_STATEMENT';

//                 //                LocalJsonTextWriter.WriteStartObject;
//                 //                LocalJsonTextWriter.WritePropertyName('id');
//                 //                LocalJsonTextWriter.WriteValue(SkyAgentsTransactions."Transaction ID");
//                 //                LocalJsonTextWriter.WritePropertyName('type');
//                 //                LocalJsonTextWriter.WriteValue(TransactionType);
//                 //                LocalJsonTextWriter.WritePropertyName('date');
//                 //                LocalJsonTextWriter.WriteValue(FormatDate(SkyAgentsTransactions."Date Posted") + ' ' + Format(SkyAgentsTransactions."Time Posted"));
//                 //                LocalJsonTextWriter.WritePropertyName('description');
//                 //                LocalJsonTextWriter.WriteValue(SkyAgentsTransactions.Description);
//                 //                LocalJsonTextWriter.WritePropertyName('amount');
//                 //                LocalJsonTextWriter.WriteValue(Format(SkyAgentsTransactions.Amount));
//                 //                LocalJsonTextWriter.WritePropertyName('currency');
//                 //                LocalJsonTextWriter.WriteValue('KES');

//                 //                LocalJsonTextWriter.WritePropertyName('display');
//                 //                LocalJsonTextWriter.WriteStartArray;
//                 //                LocalJsonTextWriter.WriteStartObject;
//                 //                LocalJsonTextWriter.WritePropertyName('title');
//                 //                LocalJsonTextWriter.WriteValue('Customer');
//                 //                LocalJsonTextWriter.WritePropertyName('value');
//                 //                LocalJsonTextWriter.WriteValue(FormatName(SkyAgentsTransactions."Member No"));
//                 //                LocalJsonTextWriter.WritePropertyName('type');
//                 //                LocalJsonTextWriter.WriteValue('text');
//                 //                LocalJsonTextWriter.WriteEndObject;


//                 //                LocalJsonTextWriter.WriteStartObject;
//                 //                LocalJsonTextWriter.WritePropertyName('title');
//                 //                LocalJsonTextWriter.WriteValue('Mobile Number');
//                 //                LocalJsonTextWriter.WritePropertyName('value');
//                 //                LocalJsonTextWriter.WriteValue(SkyAgentsTransactions."Mobile No.");
//                 //                LocalJsonTextWriter.WritePropertyName('type');
//                 //                LocalJsonTextWriter.WriteValue('text');
//                 //                LocalJsonTextWriter.WriteEndObject;

//                 VendorLedgerEntry.Reset;
//                 VendorLedgerEntry.SetRange("Vendor No.", SkyAgentsTransactions."Agent Commision Account");
//                 VendorLedgerEntry.SetFilter("Posting Date", '<=%1', SkyAgentsTransactions."Date Posted");
//                 if VendorLedgerEntry.FindFirst then begin
//                     VenCommBal := 0;
//                     repeat
//                         VendorLedgerEntry.CalcFields(Amount);
//                         //ERROR(FORMAT(VendorLedgerEntry.Amount));
//                         VenCommBal += VendorLedgerEntry.Amount;
//                     until VendorLedgerEntry.Next = 0;
//                 end;
//                 //                LocalJsonTextWriter.WriteStartObject;
//                 //                LocalJsonTextWriter.WritePropertyName('title');
//                 //                LocalJsonTextWriter.WriteValue('Reference');
//                 //                LocalJsonTextWriter.WritePropertyName('value');
//                 //                LocalJsonTextWriter.WriteValue(SkyAgentsTransactions."Transaction ID");
//                 //                LocalJsonTextWriter.WritePropertyName('type');
//                 //                LocalJsonTextWriter.WriteValue('text');
//                 //                LocalJsonTextWriter.WriteEndObject;

//                 SavingsAccounts.Reset;
//                 SavingsAccounts.SetRange("No.", SkyAgentsTransactions."Agent Account Number");
//                 SavingsAccounts.SetFilter("Date Filter", '..' + Format(SkyAgentsTransactions."Date Posted"));
//                 if SavingsAccounts.FindFirst then begin
//                     SavingsAccounts.CalcFields("Balance (LCY)");
//                     FloatBal := SavingsAccounts."Balance (LCY)";
//                 end;

//             //                LocalJsonTextWriter.WriteStartObject;
//             //                LocalJsonTextWriter.WritePropertyName('title');
//             //                LocalJsonTextWriter.WriteValue('Float Balance');
//             //                LocalJsonTextWriter.WritePropertyName('value');
//             //                LocalJsonTextWriter.WriteValue(Format(Abs(FloatBal)));
//             //                LocalJsonTextWriter.WritePropertyName('type');
//             //                LocalJsonTextWriter.WriteValue('currency');
//             //                LocalJsonTextWriter.WriteEndObject;

//             //                LocalJsonTextWriter.WriteEndArray;



//             //                LocalJsonTextWriter.WriteEndObject;
//             until SkyAgentsTransactions.Next = 0;
//         end;
//         //        LocalJsonTextWriter.WriteEndArray;

//         //uhswiusw
//         //        LocalJsonTextWriter.WritePropertyName('amount_totals');
//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('summary_total_amount');
//         //        LocalJsonTextWriter.WriteValue(Format(Abs(TotalCredits) + Abs(TotalDebits)));
//         //        LocalJsonTextWriter.WritePropertyName('transaction_total_amount');
//         //        LocalJsonTextWriter.WriteValue(Format(Abs(TotalWithdrawals) + Abs(TotalDeposits) + Abs(LoanRepayments)));
//         //        LocalJsonTextWriter.WritePropertyName('summary_totals');
//         //        LocalJsonTextWriter.WriteStartArray;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue('Total Credits');
//         //        LocalJsonTextWriter.WritePropertyName('value');
//         //        LocalJsonTextWriter.WriteValue(Format(Abs(TotalCredits)));
//         //        LocalJsonTextWriter.WritePropertyName('color');
//         //        LocalJsonTextWriter.WriteValue('#109d58');
//         //        LocalJsonTextWriter.WriteEndObject;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue('Total Debits');
//         //        LocalJsonTextWriter.WritePropertyName('value');
//         //        LocalJsonTextWriter.WriteValue(Format(Abs(TotalDebits)));
//         //        LocalJsonTextWriter.WritePropertyName('color');
//         //        LocalJsonTextWriter.WriteValue('#dd4b39');
//         //        LocalJsonTextWriter.WriteEndObject;

//         //        LocalJsonTextWriter.WriteEndArray;

//         //        LocalJsonTextWriter.WritePropertyName('transaction_totals');
//         //        LocalJsonTextWriter.WriteStartArray;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue('Total Withdrawals');
//         //        LocalJsonTextWriter.WritePropertyName('value');
//         //        LocalJsonTextWriter.WriteValue(Format(Abs(TotalWithdrawals)));
//         //        LocalJsonTextWriter.WritePropertyName('color');
//         //        LocalJsonTextWriter.WriteValue('#651FFF');
//         //        LocalJsonTextWriter.WriteEndObject;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue('Total Deposits');
//         //        LocalJsonTextWriter.WritePropertyName('value');
//         //        LocalJsonTextWriter.WriteValue(Format(Abs(TotalDeposits)));
//         //        LocalJsonTextWriter.WritePropertyName('color');
//         //        LocalJsonTextWriter.WriteValue('#0277BD');
//         //        LocalJsonTextWriter.WriteEndObject;

//         //        LocalJsonTextWriter.WriteStartObject;
//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue('Total Loan Repayments');
//         //        LocalJsonTextWriter.WritePropertyName('value');
//         //        LocalJsonTextWriter.WriteValue(Format(Abs(LoanRepayments)));
//         //        LocalJsonTextWriter.WritePropertyName('color');
//         //        LocalJsonTextWriter.WriteValue('#FF6F00');
//         //        LocalJsonTextWriter.WriteEndObject;

//         //        LocalJsonTextWriter.WriteEndArray;
//         //        LocalJsonTextWriter.WriteEndObject;

//         //        LocalJsonTextWriter.WriteEndObject;

//         //        LocalJsonTextWriter.WritePropertyName('title');
//         //        LocalJsonTextWriter.WriteValue(ResponseTitle);
//         //        LocalJsonTextWriter.WritePropertyName('message');
//         //        LocalJsonTextWriter.WriteValue(ResponseMessage);

//         //        LocalJsonTextWriter.WriteEndObject;


//         //Payload := LocalStringBuilder.ToString;

//         /*-------------------------------------------------------------------------------------*/
//         Response := GenerateJSONResponse(Action, Status, Payload, Indent);

//     end;


//     procedure FormatName(MemberNo: Code[30]) MemberName: Text
//     var
//         Members: Record Members;
//         NameWithoutSalutation: Text;
//         Firstname: Text;
//         SecondName: Text;
//         ThirdName: Text;
//     begin
//         if Members.Get(MemberNo) then begin
//             MemberName := Members."First Name" + ' ' + Members."Middle Name";

//             if Members."First Name" = '' then
//                 MemberName := Members."Middle Name" + ' ' + Members."Last Name"

//             else
//                 if Members."Middle Name" = '' then
//                     MemberName := Members."First Name" + ' ' + Members."Last Name"

//                 else
//                     if Members."Last Name" = '' then
//                         MemberName := Members."First Name" + ' ' + Members."Middle Name"

//                     else
//                         if (Members."First Name" = '') and (Members."Middle Name" = '') then
//                             MemberName := Members."Last Name"

//                         else
//                             if (Members."First Name" = '') and (Members."Last Name" = '') then
//                                 MemberName := Members."Middle Name"

//                             else
//                                 if (Members."Middle Name" = '') and (Members."Last Name" = '') then
//                                     MemberName := Members."First Name";
//         end;
//     end;

//     local procedure GetLessAccountBal(AccountNo: Code[30]) Less: Decimal
//     var
//         ATMTransactions: Record "ATM Transactions";
//         MinimumBal: Decimal;
//     begin
//         MinimumBal := 1000;
//         ATMTransactions.Reset;
//         ATMTransactions.SetRange("Account No", AccountNo);
//         ATMTransactions.SetRange(Posted, false);
//         ATMTransactions.SetRange(Reversed, false);
//         if ATMTransactions.FindFirst then begin
//             ATMTransactions.CalcSums(Amount);
//             Less := ATMTransactions.Amount + MinimumBal;
//         end;
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

//     // trigger Tempjobject::CollectionChanged(sender: Variant; e: dotnet NotifyCollectionChangedEventArgs)
//     // begin
//     // end;

//     // trigger Jsonarray::ListChanged(sender: Variant; e: dotnet ListChangedEventArgs)
//     // begin
//     // end;

//     // trigger Jsonarray::AddingNew(sender: Variant; e: dotnet AddingNewEventArgs)
//     // begin
//     // end;

//     // trigger Jsonarray::CollectionChanged(sender: Variant; e: dotnet NotifyCollectionChangedEventArgs)
//     // begin
//     // end;
// }

