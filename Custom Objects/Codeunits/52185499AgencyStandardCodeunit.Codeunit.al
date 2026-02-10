#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52185499 "Agency Standard Codeunit"
{

    trigger OnRun()
    begin
        //MESSAGE(FORMAT(GetTransactionCharge(testtrans::Withdrawal,1000)));
        //MESSAGE(GetMemberAccountInfo('5050123278000'));
        //MESSAGE(GetLoansInfo('25112891',0));
        //MESSAGE(GetMemberAccountInfoALL('25112891',0));
        //MESSAGE(FORMAT(GetAccountAvailableBalance('5050123278000')));
        Message(GetPhotoAndSignature('0060192', 2));
        //MESSAGE(GetAgentAccountInfo('HSSL313440'));//313440
        //MESSAGE(FORMAT(GetAccountName('25112891',0)));
        //MESSAGE(FORMAT(GetMemberBalancesALL('25112891',0)));
        //MESSAGE(GetMinistatement('5050201754000',5));
        //MESSAGE(GetProducts(1,'10114538'));
        //MESSAGE(GetMemberRegistrationStatus('10114538'))25112891'
        //MESSAGE(FORMAT(GetMemberShareDeposit('25112891',1)));
        //MESSAGE(GetPhoneNumber('25112891',0));
        //MESSAGE(GetMemberShareDeposit('25112891',0));
        //MESSAGE(AgencyNewRegistration())//;
        //MESSAGE(GetAgentAccountInfo('HSSL0001'));
        //PostTransaction('test113','test4',20180113D,'',8000,FALSE,CURRENTDATETIME,'',0D,0D,132900T,'','',FALSE,'','',FALSE,0D,132900T,'','','',0,'','','','',testtrans::LoanRepayment,'','','','TEST','HRMS0001','LN00020084','','','','','','');
        //PostTransaction('test113','test4',20180113D,'',2000,FALSE,CURRENTDATETIME,'',0D,0D,132900T,'','',FALSE,'','',FALSE,0D,132900T,'','','',0,'','','','',testtrans::Withdrawal,'','','','TEST','HRMS0001','LN00020084','','','','','','');
    end;

    var
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        LineNo: Integer;
        TransChargesLines: Record "Tiered Charges Lines";
        TransType: Record "Transaction Types";
        Account: Record "Savings Accounts";
        ProdType: Record "Product Factory";
        AgentAccount: Record "Agent Applications";
        StringList: Text;
        AvailableBalance: Decimal;
        MinBalance: Decimal;
        TransactionalMobile: Text[30];
        ProductTypeCode: Code[20];
        SavingsAccountNo: Code[20];
        AccName: Text;
        SavLedger: Record "Savings Ledger Entry";
        Loans: Record Loans;
        LoanNo: Code[20];
        LoanType: Code[20];
        LoanBalance: Decimal;
        InterestBalance: Decimal;
        LoanTypeName: Text[50];
        AgentTrans: Record "Agent Transactions";
        AgentAcountName: Text[50];
        AgentProposedName: Text[50];
        AgentLcoationCode: Text[50];
        AgentAccountBal: Decimal;
        AgentCommisionBal: Decimal;
        Vend: Record Vendor;
        PhoneNo: Code[20];
        Member: Record Members;
        AllowedTrans: Option "Withdraw Only","Deposit Only","Withdraw & Deposit","No Transactions";
        AccProductType: Text;
        testtrans: Option "None",Registration,Withdrawal,Deposit,LoanRepayment,Transfer,Sharedeposit,Schoolfeespayment,Balance,Ministatment,Paybill," Memberactivation",MemberRegistration;
        ProductTypeName: Code[30];
        TheProducts: Text;
        ProductCategory: Option " ","Share Capital","Deposit Contribution","Fixed Deposit","Junior Savings","Registration Fee",Benevolent,"Unallocated Fund","Premier Club Reg Fee","Premier Club Account","Investment Account","Holiday Account";
        DepositContribution: label '02';
        NormalAccounts: label '505';
        ShareCapital: label '03';
        Benevolent: label '04';


    procedure GetTransactionCharge(TransactionType: Option " ",LoanApplication,Withdrawal,Deposit,LoanRepayment,Transfer,ShareDeposit,BioRegistration,Balance,MiniStatement,Paybill," MemberActivation",MemberRegistration,"Micro-Group"; TransactionAmount: Decimal): Decimal
    var
        TariffHeader: Record "Agent Tarriff Header";
        TariffDetails: Record "Agent Tariff Details";
        GeneralSetUp: Record "General Set-Up";
        ExciseDutyCharge: Decimal;
    begin
        GeneralSetUp.Get;
        GeneralSetUp.TestField("Excise Duty (%)");
        ExciseDutyCharge := 0;
        TariffHeader.Reset();
        TariffHeader.SetRange(TariffHeader."Trans Type Agents", TransactionType);
        if TariffHeader.FindFirst then begin
            TariffDetails.Reset();
            TariffDetails.SetRange(TariffDetails.Code, TariffHeader.Code, TariffHeader.Code);
            TariffDetails.SetFilter(TariffDetails."Lower Limit", '<=%1', TransactionAmount);
            TariffDetails.SetFilter(TariffDetails."Upper Limit", '>=%1', TransactionAmount);
            if TariffDetails.FindFirst then begin
                if TariffHeader."Charge Excise Duty" then
                    ExciseDutyCharge := GeneralSetUp."Excise Duty (%)" * 0.01 * TariffDetails."Charge Amount";
                exit(TariffDetails."Charge Amount" + ExciseDutyCharge);
            end;
        end;
        exit(0);
    end;


    procedure GetMemberAccountInfo(AccountNo: Code[20]): Text
    begin

        StringList := '';

        MinBalance := 0;
        AvailableBalance := 0;
        TransactionalMobile := '';
        ProductTypeCode := '';
        SavingsAccountNo := '';
        AccName := '';

        if Account.Get(AccountNo) then begin
            if Account.Status = Account.Status::Active then begin
                Account.CalcFields(Account.Balance, Account."Uncleared Cheques", Account."Authorised Over Draft", Account."Lien Placed", Account."ATM Transactions");

                ProductTypeCode := Account."Product Type";
                SavingsAccountNo := Account."No.";
                TransactionalMobile := Account."Transactional Mobile No";
                AccName := Account.Name;


                ProdType.Reset;
                ProdType.SetRange(ProdType."Product ID", Account."Product Type");
                if ProdType.Find('-') then begin
                    MinBalance := ProdType."Minimum Balance";
                    AvailableBalance := (Account.Balance + Account."Authorised Over Draft") - (MinBalance + Account."Uncleared Cheques" + Account."Lien Placed" + Account."ATM Transactions");
                end;

                StringList := SavingsAccountNo + ':::' + AccName + ':::' + ProductTypeCode + ':::' + Format(AvailableBalance) + ':::' + TransactionalMobile;
            end;
        end;
        exit(StringList);
    end;


    procedure GetLoansInfo(Identifier: Code[20]; IdentifierType: Integer): Text
    begin

        StringList := '';

        LoanNo := '';
        LoanType := 'NA';
        LoanTypeName := 'NA';
        LoanBalance := 0;
        InterestBalance := 0;



        Member.Reset;
        if IdentifierType = 1 then
            Member.SetRange(Member."Phone No.", Identifier)
        else
            if IdentifierType = 0 then
                Member.SetRange(Member."Primary Identification", Identifier);
        if Member.Find('-') then begin



            Loans.Reset;
            Loans.SetRange("Member No.", Member."No.");
            Loans.SetFilter("Outstanding Balance", '>0');
            if Loans.FindFirst then begin
                repeat

                    /*
                    Loans.RESET;
                    IF IdentifierType=1 THEN
                    Loans.SETRANGE("Member No.",Identifier)
                    ELSE IF IdentifierType=0 THEN
                    Loans.SETRANGE("ID No.",Identifier);
                    Loans.SETFILTER("Outstanding Balance",'>0');
                    IF Loans.FINDFIRST THEN BEGIN
                      REPEAT
                    */
                    Loans.CalcFields("Outstanding Balance", "Outstanding Interest");

                    LoanNo := Loans."Loan No.";
                    LoanType := Loans."Loan Product Type";
                    LoanTypeName := Loans."Loan Product Type Name";
                    LoanBalance := Loans."Outstanding Balance";
                    InterestBalance := Loans."Outstanding Interest";
                    if LoanType = '' then
                        LoanType := 'N/A';

                    if LoanTypeName = '' then
                        LoanTypeName := 'N/A';


                    StringList := StringList + LoanNo + ':::' + LoanType + ':::' + LoanTypeName + ':::' + Format(LoanBalance) + ':::' + Format(InterestBalance) + '||';

                until Loans.Next = 0;
            end;
        end;
        exit(StringList);

    end;


    procedure GetLoanMaximumAmount(AgentCode: Code[20]; IDNo: Code[20]; LoanProduct: Code[20]): Text
    var
        Loans: Record Loans;
        Members: Record Members;
        Qualified: Boolean;
        LRec: Record Loans;
        Defaulter: Boolean;
        MemberHasSameProduct: Boolean;
        SalaryLines: Record "Salary Lines";
        QualifiedAmount: Decimal;
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        NetSalary: Decimal;
        GeneralSetUp: Record "General Set-Up";
        NetQualifyingAmount: Decimal;
        ProductFactory: Record "Product Factory";
        SalaryHeader: Record "Salary Header";
        Sav: Record "Savings Accounts";
        AmountQualifiedAsPerShares: Decimal;
        NumberOfMembersWithThisID: Integer;
        MultWithSameID: label 'Multiple Members for this ID';
        Trans: label 'Loan Appraisal';
        Cnt: label 'Count';
    begin
        /*Qualified := FALSE;Defaulter := FALSE;MemberHasSameProduct := FALSE;NetQualifyingAmount := 0;NetSalary := 0;GeneralSetUp.GET;StringList:='';
        GeneralSetUp.TESTfield("Mobile Qualifying Amount %"); Rec.GeneralSetUp.TESTFIELD("Self Guarantee %");AmountQualifiedAsPerShares:=0;
        NumberOfMembersWithThisID := 0;
        IF ProductFactory.GET(LoanProduct) THEN BEGIN
              Members.RESET;
              Members.SETRANGE("ID No.",IDNo);
              Members.SETRANGE(Status,Members.Status::Active);
              IF Members.FINDFIRST THEN
                BEGIN
                    NumberOfMembersWithThisID := Members.COUNT;
                    IF NumberOfMembersWithThisID = 1 THEN BEGIN
        
        
                      Loans.RESET;
                      Loans.SETRANGE("Member No.",Members."No.");
                      Loans.SETFILTER(Status,'<>%1',Loans.Status::Rejected);
                      IF Loans.FINDFIRST THEN
                        REPEAT
                              Loans.CALCFIELDS("Outstanding Balance");
                              IF Loans.Defaulted THEN Defaulter := TRUE;
                              IF Loans."Loan Product Type" = LoanProduct THEN MemberHasSameProduct := TRUE;
                          UNTIL Loans.NEXT = 0;
        
                      IF NOT ProductFactory."Share Capital Loan" THEN BEGIN
                            SalaryHeader.RESET;
                            SalaryHeader.SETRANGE("Posting date",CALCDATE('-1M-CM',TODAY),CALCDATE('-1M+CM',TODAY));
                            SalaryHeader.SETRANGE("Income Type",ProductFactory."Loan Category");
                            SalaryHeader.SETRANGE(Posted,TRUE);
                            IF SalaryHeader.FINDFIRST THEN
                               REPEAT
                                    SalaryLines.RESET;
                                    SalaryLines.SETRANGE("Member No.",Members."No.");
                                    SalaryLines.SETRANGE("Posting Date",CALCDATE('-1M-CM',TODAY),CALCDATE('-1M+CM',TODAY));
                                    SalaryLines.SETRANGE(Posted,TRUE);
                                    SalaryLines.SETRANGE("Salary Header No.",SalaryHeader.No);
                                    IF SalaryLines.FINDLAST THEN
                                      BEGIN
        
        
                                          SavingsLedgerEntry.RESET;
                                          SavingsLedgerEntry.SETRANGE("Customer No.",SalaryLines."Account No.");
                                          SavingsLedgerEntry.SETRANGE("Document No.",SalaryLines."Salary Header No.");
                                          IF SavingsLedgerEntry.FINDFIRST THEN
                                              BEGIN
                                                  SavingsLedgerEntry.CALCSUMS(Amount);
                                                  NetSalary := SavingsLedgerEntry.Amount * -1;
                                                  IF NetSalary < 0 THEN NetSalary := 0;
                                                  NetQualifyingAmount := ROUND(NetSalary*GeneralSetUp."Mobile Qualifying Amount %"*0.01,1,'<');
                                                  IF NetQualifyingAmount > ProductFactory."Maximum Loan Amount" THEN
                                                     NetQualifyingAmount := ProductFactory."Maximum Loan Amount";
                                                END;
                                        END;
                              UNTIL SalaryHeader.NEXT = 0;
                       END;
        
                        IF ProductFactory."Share Capital Loan" THEN BEGIN
                            Sav.RESET;
                            Sav.SETRANGE("Member No.",Members."No.");
                            Sav.SETRANGE(Status,Sav.Status::Active);
                            Sav.SETRANGE("Product Category",Sav."Product Category"::"BOSA Deposits");
                            IF Sav.FINDFIRST THEN
                              BEGIN
                                  Sav.CALCFIELDS("Balance (LCY)");
                                  AmountQualifiedAsPerShares := ROUND(Sav."Balance (LCY)" * GeneralSetUp."Self Guarantee %" * 0.01,1,'<');
                                  IF AmountQualifiedAsPerShares > ProductFactory."Maximum Loan Amount" THEN
                                      AmountQualifiedAsPerShares := ProductFactory."Maximum Loan Amount";
                                  NetQualifyingAmount := AmountQualifiedAsPerShares;
                                END;
                          END;
        
        
                     END ELSE
                       LogErrorMessage(AgentCode,IDNo,Trans,CURRENTDATETIME,MultWithSameID+ Cnt +FORMAT(NumberOfMembersWithThisID),1);
               END;
        END;
        
        Qualified := (NOT Defaulter) AND (NOT MemberHasSameProduct) AND (NetQualifyingAmount>0);
        StringList := FORMAT(Qualified)+':::'+FORMAT(NetQualifyingAmount);
        EXIT(StringList);
        */

    end;


    procedure GetAgentAccountInfo(AgentCode: Code[20]): Text
    var
        AgentAccountNo: Code[20];
    begin

        StringList := '';

        AgentAccountNo := '';
        AgentAcountName := '';
        AgentProposedName := '';
        AgentCommisionBal := 0;
        AgentLcoationCode := '';
        AgentAccountBal := 0;


        AgentAccount.Reset;
        AgentAccount.SetRange(AgentAccount."Approval Status", AgentAccount."approval status"::Approved);
        AgentAccount.SetRange("Agent Code", AgentCode);
        if AgentAccount.FindFirst then begin

            if Account.Get(AgentAccount.Account) then begin
                Account.CalcFields(Account.Balance, Account."Uncleared Cheques", Account."Authorised Over Draft", Account."Lien Placed", Account."ATM Transactions");

                AgentAccountBal := Account.Balance;
            end;

            if Vend.Get(AgentAccount."Comm Account") then begin
                Vend.CalcFields(Balance);
                AgentCommisionBal := Vend.Balance;
            end;

            AgentAccountNo := AgentAccount.Account;
            AgentProposedName := AgentAccount."Name of the Proposed Agent";
            AgentAcountName := AgentAccount.Name;
            AgentLcoationCode := AgentAccount."Place of Business";
            AgentCommisionBal := AgentCommisionBal;

            ProdType.Reset;
            ProdType.SetRange(ProdType."Product ID", Account."Product Type");
            if ProdType.Find('-') then begin
                MinBalance := ProdType."Minimum Balance";

                AgentAccountBal := (Account.Balance + Account."Authorised Over Draft") - (MinBalance + Account."Uncleared Cheques" + Account."Lien Placed" + Account."ATM Transactions");

            end;
        end;

        StringList := AgentAccountNo + ':::' + AgentProposedName + ':::' + AgentAcountName + ':::' + AgentLcoationCode + ':::' + Format(AgentCommisionBal) + ':::' + Format(AgentAccountBal);

        exit(StringList);
    end;


    procedure GetMemberAccountInfoALL(Identifier: Code[50]; IdentifierType: Integer): Text
    begin
        StringList := '';

        MinBalance := 0;
        AvailableBalance := 0;
        TransactionalMobile := '';
        ProductTypeCode := '';
        SavingsAccountNo := '';
        AccName := '';
        AccProductType := '';
        //OldAccount:='';


        Account.Reset;
        Account.SetRange(Account.Status, Account.Status::Active);
        if IdentifierType = 1 then
            Account.SetRange("Mobile Phone No", Identifier)
        else
            if IdentifierType = 0 then
                Account.SetRange("ID No.", Identifier);
        if Account.Find('-') then begin
            repeat

                Account.CalcFields(Account.Balance, Account."Uncleared Cheques", Account."Authorised Over Draft", Account."Lien Placed", Account."ATM Transactions");

                ProductTypeCode := Account."Product Type";
                SavingsAccountNo := Account."No.";
                TransactionalMobile := Account."Mobile Phone No";
                AccName := Account.Name;
                AccProductType := Account."Customer Posting Group";
                //OldAccount:=Account."Old Account No";

                if TransactionalMobile = '' then
                    TransactionalMobile := 'N/A';
                ProdType.Reset;
                ProdType.SetRange(ProdType."Product ID", Account."Product Type");
                if ProdType.Find('-') then begin
                    MinBalance := ProdType."Minimum Balance";
                    AllowedTrans := ProdType."Allowed Transaction";
                    ProductTypeCode := ProdType."Product ID";// "Product Description";
                    AvailableBalance := (Account.Balance + Account."Authorised Over Draft") - (MinBalance + Account."Uncleared Cheques" + Account."Lien Placed" + Account."ATM Transactions");
                end;
                //IF AvailableBalance>0 THEN BEGIN
                StringList := StringList + SavingsAccountNo + ':::' + AccName + ':::' + PadStr(Format(ProductTypeCode), 10) + ':::' + Format(AvailableBalance) + ':::' + TransactionalMobile + ':::' + Format(AllowedTrans) + ':::' + AccProductType + '||';
            // END;
            until Account.Next = 0;
        end;


        exit(StringList);
    end;


    procedure GetAccountAvailableBalance(AccountNo: Code[20]): Decimal
    begin
        MinBalance := 0;
        AvailableBalance := 0;

        if Account.Get(AccountNo) then begin
            Account.CalcFields(Account.Balance, Account."Uncleared Cheques", Account."Authorised Over Draft", Account."Lien Placed", Account."ATM Transactions");

            ProdType.Reset;
            ProdType.SetRange(ProdType."Product ID", Account."Product Type");
            if ProdType.Find('-') then begin
                MinBalance := ProdType."Minimum Balance";

                AvailableBalance := (Account.Balance + Account."Authorised Over Draft") - (MinBalance + Account."Uncleared Cheques" + Account."Lien Placed" + Account."ATM Transactions");

            end;
        end;

        exit(AvailableBalance);
    end;


    procedure GetMinistatement(AccountNo: Code[20]; NoofEntries: Integer): Text
    var
        Pdate: Date;
        Descr: Text;
        Amnt: Decimal;
    begin

        StringList := '';

        SavLedger.Reset;
        SavLedger.SetRange("Customer No.", AccountNo);
        SavLedger.SetCurrentkey("Entry No.");
        SavLedger.SetAscending("Entry No.", false);
        SavLedger.SetRange(Reversed, false);
        if SavLedger.FindFirst then begin
            repeat
                if NoofEntries > 0 then begin
                    StringList := StringList + Format(SavLedger."Posting Date") + ':::' + SavLedger.Description + ':::' + Format(SavLedger.Amount) + '||';
                    NoofEntries := NoofEntries - 1;
                end;
            until SavLedger.Next = 0
        end;
        exit(StringList);
    end;


    procedure GetProducts(IdentifierType: Integer; IDNO: Code[10]): Text
    var
        ProductFactory: Record "Product Factory";
        CanCreateThisSavingsProduct: Text[3];
    begin
        StringList := '';
        ProductFactory.Reset;
        ProductFactory.SetRange(Status, ProductFactory.Status::Active);
        case IdentifierType of
            1:
                ProductFactory.SetRange("Product Class Type", ProductFactory."product class type"::Savings);
            2:
                begin
                    ProductFactory.SetRange("Product Class Type", ProductFactory."product class type"::Loan);
                    ProductFactory.SetRange("Mobile Loan", true);
                end;
        end;
        if ProductFactory.FindFirst then
            repeat
                if ProductFactory."Product Class Type" = ProductFactory."product class type"::Loan then
                    CanCreateThisSavingsProduct := 'N/A'
                else
                    CanCreateThisSavingsProduct := Format(CanCreateSavingsAccount(IDNO, ProductFactory."Product ID"));

                StringList += ProductFactory."Product ID" + ':::' + ProductFactory."Product Description" + ':::' + Format(CanCreateSavingsAccount(IDNO, ProductFactory."Product ID")) + '||';

            until ProductFactory.Next = 0;

        exit(StringList);
    end;


    procedure GetMemberRegistrationStatus(IdNo: Text): Text
    var
        AgentBiometricData: Record "Agent Biometric Data";
        MemberApplication: Record "Member Application";
        Members: Record Members;
        ImageData: Record "Image Data";
        MemberExists: Boolean;
        ApplicationIsPending: Boolean;
        BioExists: Boolean;
    begin
        StringList := '';
        MemberExists := false;
        ApplicationIsPending := false;
        BioExists := false;

        Member.Reset;
        Member.SetRange("Primary Identification", IdNo);
        Member.SetFilter(Status, '<>%1', Member.Status::Closed);
        if Member.FindFirst then begin
            MemberExists := true;
            // BioExists := Member."BSS Registered";
        end;

        MemberApplication.Reset;
        MemberApplication.SetRange(MemberApplication."Primary Identification", IdNo);
        if MemberApplication.Find('-') then
            repeat
                if (MemberApplication.Status in [MemberApplication.Status::Open, MemberApplication.Status::Pending,
                                                 MemberApplication.Status::Approved]) then
                    ApplicationIsPending := true;
            until MemberApplication.Next = 0;


        StringList := Format(MemberExists) + ':::' + Format(ApplicationIsPending) + ':::' + Format(BioExists);

        exit(StringList);
    end;


    procedure PostTransaction(DocumentNo: Code[20]; Description: Text[250]; TransDate: Date; AccNo: Code[20]; Amnt: Decimal; Posted: Boolean; TransTime: DateTime; BalAccount: Code[30]; DocDate: Date; DatePosted: Date; TimePosted: Time; AccStatus: Text[30]; Messages: Text[250]; NeedsChange: Boolean; ChangeTransNo: Code[20]; OldAccount: Code[50]; Changed: Boolean; DateChanged: Date; TimeChanged: Time; ChangedBy: Code[50]; ApprovedBy: Code[50]; OriginalAccountNo: Code[50]; AccntBal: Decimal; BranchCode: Code[20]; ActivityCode: Code[20]; Gdim1filter: Code[20]; Gdim2filter: Code[20]; TransType: Option ,Registration,Withdrawal,DEPOSIT,LoanRepayment,Transfer,Sharedeposit,Schoolfeespayment,Balance,Ministatment,Paybill,Memberactivation,MemberRegistration; AccountNo2: Code[20]; OTTN: Text[30]; TransLoc: Text[30]; TransBy: Text[30]; AgentCode: Text[30]; LoanNo: Code[20]; AccountName: Text[50]; PhoneNO: Text[30]; ID: Text; Society: Code[10]; MemberNoo: Code[10]; DeviceID: Text[50]): Boolean
    var
        Done: Boolean;
        PostAgent: Codeunit "Post Agent Transactions";
    begin
        Done := false;

        AgentTrans.Init;
        AgentTrans."Document No." := DocumentNo;
        AgentTrans.Description := Description;
        AgentTrans."Transaction Date" := TransDate;
        AgentTrans."Account No." := AccNo;
        AgentTrans.Amount := Amnt;
        AgentTrans.Posted := false;
        AgentTrans."Transaction Time" := TransTime;
        AgentTrans."Bal. Account No." := BalAccount;
        AgentTrans."Document Date" := DocDate;
        AgentTrans."Date Posted" := DatePosted;
        AgentTrans."Time Posted" := TimePosted;
        AgentTrans."Account Status" := AccStatus;
        AgentTrans.Messages := Messages;
        AgentTrans."Needs Change" := NeedsChange;
        AgentTrans."Change Transaction No" := ChangeTransNo;
        AgentTrans."Old Account No" := OldAccount;
        AgentTrans.Changed := Changed;
        AgentTrans."Date Changed" := DateChanged;
        AgentTrans."Time Changed" := TimeChanged;
        AgentTrans."Changed By" := ChangedBy;
        AgentTrans."Approved By" := ApprovedBy;
        AgentTrans."Original Account No" := OriginalAccountNo;
        AgentTrans."Account Balance" := AccntBal;
        AgentTrans."Branch Code" := BranchCode;
        AgentTrans."Activity Code" := ActivityCode;
        AgentTrans."Global Dimension 1 Filter" := Gdim1filter;
        AgentTrans."Global Dimension 2 Filter" := Gdim2filter;
        AgentTrans."Transaction Type" := TransType;
        AgentTrans."Account No 2" := AccountNo2;
        AgentTrans.OTTN := OTTN;
        AgentTrans."Transaction Location" := TransLoc;
        AgentTrans."Transaction By" := TransBy;
        AgentTrans."Agent Code" := AgentCode;
        AgentTrans."Loan No" := LoanNo;
        AgentTrans."Account Name" := AccountName;
        AgentTrans.Telephone := PhoneNO;
        AgentTrans."Id No" := ID;
        AgentTrans.Society := Society;
        AgentTrans."Member No" := MemberNoo;
        AgentTrans.DeviceID := DeviceID;

        if AgentTrans.Insert then
            PostAgent.InitAgencyPosting(AgentTrans."Document No.");

        Done := true;

        //CODEUNIT.RUN(52185703);

        exit(Done);
    end;


    procedure NewPostTransaction(DocumentNo: Code[20]; Description: Text[250]; TransDateTime: DateTime; AccNo: Code[20]; DestinationAccountNo: Code[20]; Amnt: Decimal; TransType: Option " ",LoanApplication,Withdrawal,Deposit,LoanRepayment,Transfer,ShareDeposit,BioRegistration,Balance,MiniStatement,Paybill,MemberActivation,MemberRegistration,"Micro-Group","Account-Opening"; Latitude: Decimal; Longitude: Decimal; AgentCode: Code[30]; LoanNo: Code[30]; ProductType: Code[20]; PhoneNo: Code[30]; Name: Text; Salutation: Text[10]; MaritalStatus: Integer; IdNo: Code[20]; Gender: Integer; DateOfBirth: DateTime; DeviceID: Text; MemberNo: Code[20]; BranchCode: Code[20]; Locality: Text; NearestMarket: Text; RegisterMsacco: Boolean; NextOfKinName: Text; NextOfKinRelationShip: Text[50]; NextOfKinID: Text[20]; NextOfKinPhone: Text[30]; JuniorAccName: Text; JuniorAccDOB: Date; PassportPhoto: Text; IDFront: Text; IDBack: Text; Signature: Text; FingerOne: Text; FingerTwo: Text; FingerThree: Text; FingerFour: Text; ApplicationFormFront: Text; ApplicationFormBack: Text; GroupCode: Text; TotalGroupLoanPaid: Decimal; TotalGroupLoanUnPaid: Decimal; TotalGroupSavingsPaid: Decimal; TotalGroupPaidAmount: Decimal; GroupTransVerifiedBy: Text; GroupVerifierPhoneNumber: Text; GroupTransInitializationTime: DateTime; GroupTransPostingTime: DateTime; TotalGroupPresentMembers: Integer; TotalGroupAbsentMembers: Integer; GroupImage: Text; GroupRemarks: Text; EMail: Text; PayrollNumber: Text; EmployerCode: Text; Field1: Text; Field2: Text; Field3: Text; Field4: Text; Field5: Text): Boolean
    var
        Done: Boolean;
        PostTrans: Codeunit "Post Agent Transactions";
        Mem: Record Members;
    begin
        if TransType = Transtype::MemberRegistration then begin
            Mem.Reset;
            Mem.SetRange("Primary Identification", IdNo);
            // Mem.SetRange("BSS Registered", true);
            if Mem.FindFirst then
                exit(false);
        end;

        AgentTrans.Init;
        AgentTrans."Document No." := DocumentNo;
        AgentTrans.Description := Description;
        AgentTrans."Transaction Date" := Dt2Date(TransDateTime);
        AgentTrans."Transaction Time" := TransDateTime;
        AgentTrans."Account No." := AccNo;
        AgentTrans.Amount := Amnt;
        AgentTrans."Transaction Type" := TransType;
        AgentTrans."Agent Code" := AgentCode;
        AgentTrans."Loan No" := LoanNo;
        AgentTrans.Telephone := PhoneNo;
        AgentTrans."Id No" := IdNo;
        AgentTrans."Account Name" := Name;
        AgentTrans.Gender := Gender;
        AgentTrans."Date Of Birth" := Dt2Date(DateOfBirth);
        AgentTrans."Member No" := MemberNo;
        AgentTrans."Global Dimension 1 Filter" := BranchCode;
        AgentTrans.DeviceID := DeviceID;
        AgentTrans.Latitude := Latitude;
        AgentTrans.Longitude := Longitude;
        AgentTrans.Salutation := Salutation;
        AgentTrans."Product Type" := ProductType;
        case MaritalStatus of
            1:
                AgentTrans."Marital Status" := AgentTrans."marital status"::Single;
            2:
                AgentTrans."Marital Status" := AgentTrans."marital status"::Married;
            3:
                AgentTrans."Marital Status" := AgentTrans."marital status"::Widower;
            4:
                AgentTrans."Marital Status" := AgentTrans."marital status"::Widow
        end;
        AgentTrans.Locality := Locality;
        AgentTrans."Nearest Market" := NearestMarket;
        AgentTrans."Auto Apply M-Banking" := RegisterMsacco;
        AgentTrans."Employer Code" := EmployerCode;
        AgentTrans."Payoll No" := PayrollNumber;
        AgentTrans."E-Mail" := EMail;

        if AgentTrans.Insert(true) then begin

            if AgentTrans."Transaction Type" in
              [AgentTrans."transaction type"::MemberRegistration, AgentTrans."transaction type"::BioRegistration] then begin
                CreateBiometricData(AgentTrans, PassportPhoto, IDFront, IDBack, Signature, FingerOne, FingerTwo, FingerThree, FingerFour, ApplicationFormBack, ApplicationFormFront);
                if AgentTrans."Transaction Type" = AgentTrans."transaction type"::MemberRegistration then
                    CreateNextOfKinDetails(DocumentNo, NextOfKinName, NextOfKinRelationShip, NextOfKinID, NextOfKinPhone);
            end;

            if AgentTrans."Transaction Type" = AgentTrans."transaction type"::"Micro-Group" then
                CreateGroupSchedule(DocumentNo, GroupCode, TotalGroupLoanPaid, TotalGroupLoanUnPaid, TotalGroupSavingsPaid, TotalGroupPaidAmount, GroupTransVerifiedBy,
                    GroupVerifierPhoneNumber, GroupTransInitializationTime, GroupTransPostingTime, TotalGroupPresentMembers, TotalGroupAbsentMembers, GroupImage, GroupRemarks);

            exit(PostTrans.InitAgencyPosting(DocumentNo));
        end;
    end;


    procedure GetAccountName(Identifier: Code[50]; IdentifierType: Integer): Text
    begin
        AccName := '';
        if IdentifierType in [0, 1] then begin
            Member.Reset;
            if IdentifierType = 1 then
                Member.SetRange(Member."Phone No.", Identifier)
            else
                if IdentifierType = 0 then
                    Member.SetRange(Member."Primary Identification", Identifier);
            if Member.Find('-') then begin
                AccName := Member.Name;
            end;
        end;

        if IdentifierType = 2 then begin
            Account.Reset;
            Account.SetRange("No.", Identifier);
            if Account.Find('-') then
                AccName := Account.Name
            else
                Account.Reset;
            //Account.SETRANGE("Old Account No",Identifier);
            if Account.Find('-') then begin
                AccName := Account.Name;
            end
            /*
            IF Account.GET(Identifier) THEN BEGIN
            AccName:=Account.Name;
            END;
            */
        end;
        exit(AccName);

    end;


    procedure GetMemberBalancesALL(Identifier: Code[50]; IdentifierType: Integer): Text
    begin
        StringList := '';

        MinBalance := 0;
        AvailableBalance := 0;
        TransactionalMobile := '';
        ProductTypeCode := '';
        SavingsAccountNo := '';
        AccName := '';


        Account.Reset;
        if IdentifierType = 1 then
            Account.SetRange("Mobile Phone No", Identifier)
        else
            if IdentifierType = 0 then
                Account.SetRange("ID No.", Identifier);
        if Account.Find('-') then begin
            repeat

                Account.CalcFields(Account.Balance, Account."Uncleared Cheques", Account."Authorised Over Draft", Account."Lien Placed", Account."ATM Transactions");

                ProductTypeCode := Account."Product Type";
                SavingsAccountNo := Account."No.";
                TransactionalMobile := Account."Mobile Phone No";
                AccName := Account.Name;


                ProdType.Reset;
                ProdType.SetRange(ProdType."Product ID", Account."Product Type");
                if ProdType.Find('-') then begin
                    MinBalance := ProdType."Minimum Balance";
                    AvailableBalance := (Account.Balance + Account."Authorised Over Draft") - (MinBalance + Account."Uncleared Cheques" + Account."Lien Placed" + Account."ATM Transactions");
                end;

                StringList := StringList + SavingsAccountNo + ':::' + ProductTypeCode + ':::' + Format(AvailableBalance) + '||';

            until Account.Next = 0;
        end;



        LoanNo := '';
        LoanType := '';
        LoanTypeName := '';
        LoanBalance := 0;
        InterestBalance := 0;



        Member.Reset;
        if IdentifierType = 1 then
            Member.SetRange(Member."Phone No.", Identifier)
        else
            if IdentifierType = 0 then
                Member.SetRange(Member."Primary Identification", Identifier);
        if Member.Find('-') then begin



            Loans.Reset;
            Loans.SetRange("Member No.", Member."No.");
            Loans.SetFilter("Outstanding Balance", '>0');
            if Loans.FindFirst then begin
                repeat
                    /*
                    Loans.RESET;
                    IF IdentifierType=1 THEN
                    Loans.SETRANGE("Member No.",Identifier)
                    ELSE IF IdentifierType=0 THEN
                    Loans.SETRANGE("ID No.",Identifier);
                    Loans.SETFILTER("Outstanding Balance",'>0');
                    IF Loans.FINDFIRST THEN BEGIN
                      REPEAT
                    */
                    Loans.CalcFields("Outstanding Balance", "Outstanding Interest");

                    LoanNo := Loans."Loan No.";
                    LoanType := Loans."Loan Product Type";
                    LoanTypeName := Loans."Loan Product Type Name";
                    LoanBalance := Loans."Outstanding Balance";
                    InterestBalance := Loans."Outstanding Interest";

                    StringList := StringList + LoanNo + ':::' + LoanTypeName + ':::' + Format(LoanBalance) + '||';

                until Loans.Next = 0;
            end;
        end;
        //MESSAGE('%1',StringList);

        exit(StringList);

    end;


    procedure GetPhoneNumber(Identifier: Code[50]; IdentifierType: Integer): Text
    begin
        PhoneNo := '';


        Member.Reset;
        if IdentifierType = 1 then
            Member.SetRange(Member."Phone No.", Identifier)
        else
            if IdentifierType = 0 then
                Member.SetRange(Member."Primary Identification", Identifier);
        if Member.Find('-') then begin
            PhoneNo := Member."Phone No.";
        end;


        if IdentifierType = 2 then begin
            if Account.Get(Identifier) then begin
                PhoneNo := Account."Mobile Phone No";
            end;
        end;


        exit(PhoneNo);
    end;


    procedure GetMemberShareDeposit(Identifier: Code[50]; IdentifierType: Integer): Text
    begin
        StringList := '';

        MinBalance := 0;
        AvailableBalance := 0;
        TransactionalMobile := '';
        ProductTypeCode := '';
        SavingsAccountNo := '';
        AccName := '';


        Account.Reset;
        if IdentifierType = 1 then
            Account.SetRange("Mobile Phone No", Identifier)
        else
            if IdentifierType = 0 then
                Account.SetRange("ID No.", Identifier);
        Account.SetRange("Global Dimension 1 Code", 'BOSA');
        if Account.Find('-') then begin
            repeat

                Account.CalcFields(Account.Balance, Account."Uncleared Cheques", Account."Authorised Over Draft", Account."Lien Placed", Account."ATM Transactions");

                ProductTypeCode := Account."Product Type";
                SavingsAccountNo := Account."No.";
                TransactionalMobile := Account."Mobile Phone No";
                AccName := Account.Name;


                if TransactionalMobile = '' then
                    TransactionalMobile := 'N/A';

                ProdType.Reset;
                ProdType.SetRange(ProdType."Product ID", Account."Product Type");
                if ProdType.Find('-') then begin
                    MinBalance := ProdType."Minimum Balance";
                    AllowedTrans := ProdType."Allowed Transaction";
                    AvailableBalance := (Account.Balance + Account."Authorised Over Draft") - (MinBalance + Account."Uncleared Cheques" + Account."Lien Placed" + Account."ATM Transactions");
                end;

                StringList := StringList + SavingsAccountNo + ':::' + AccName + ':::' + ProductTypeCode + ':::' + Format(AvailableBalance) + ':::' + TransactionalMobile + ':::' + Format(AllowedTrans) + '||';

            until Account.Next = 0;
        end;


        exit(StringList);
    end;


    procedure GetList(Identifier: Integer): Text
    var
        DimensionValue: Record "Dimension Value";
        RelationshipTypes: Record "Relationship Types";
        CountryRegion: Record "Country/Region";
        Employer: Record Customer;
    begin
        //Identifier 1 get branches;
        StringList := '';
        case Identifier of
            1:
                begin
                    DimensionValue.Reset;
                    DimensionValue.SetRange("Dimension Code", 'BRANCH');
                    if DimensionValue.FindFirst then
                        repeat
                            StringList += DimensionValue.Code + ':::' + DimensionValue.Name + '||'
                          until DimensionValue.Next = 0;
                end;
            //Identifier 2 get relationship types
            2:
                begin
                    RelationshipTypes.Reset;
                    if RelationshipTypes.FindFirst
                      then
                        repeat
                            StringList += RelationshipTypes.Relation + ':::' + 'N/A' + '||';
                        until RelationshipTypes.Next = 0;
                end;
            3:
                begin
                    CountryRegion.Reset;
                    if CountryRegion.FindFirst then
                        repeat
                            StringList += CountryRegion."County Phone Code" + ':::' + CountryRegion.Name + ':::' + CountryRegion.Code + '||';
                        until CountryRegion.Next = 0;
                end;
            4:
                begin
                    Employer.Reset;
                    Employer.SetRange("Account Type", Employer."account type"::Employer);
                    if Employer.FindFirst then
                        repeat
                            StringList += Employer."No." + ':::' + Employer.Name + '||';
                        until Employer.Next = 0;
                end;

        end;

        exit(StringList);
    end;


    procedure GetFilteredList(IdentifierType: Integer; FilterString: Text): Text
    var
        DimensionValue: Record "Dimension Value";
        RelationshipTypes: Record "Relationship Types";
        CountryRegion: Record "Country/Region";
        Employer: Record Customer;
    begin
        case IdentifierType of

            1:
                begin
                    Employer.Reset;
                    Employer.SetCurrentkey(Name);
                    Employer.SetFilter(Name, '@*' + FilterString + '*');
                    if Employer.FindFirst then
                        repeat

                            StringList += Employer."No." + ':::' + Employer.Name + '||';
                        until Employer.Next = 0;
                end;



        end;



        //Identifier 1 get branches;
        /*StringList := '';
        CASE Identifier OF
            1: BEGIN
                  DimensionValue.RESET;
                  DimensionValue.SETRANGE("Dimension Code",'BRANCH');
                  IF DimensionValue.FINDFIRST THEN
                    REPEAT
                        StringList += DimensionValue.Code+':::'+DimensionValue.Name+'||'
                      UNTIL DimensionValue.NEXT = 0;
               END;
        //Identifier 2 get relationship types
             2:BEGIN
                   RelationshipTypes.RESET;
                   IF RelationshipTypes.FINDFIRST
                     THEN
                       REPEAT
                          StringList += RelationshipTypes.Description+':::'+'N/A'+'||';
                         UNTIL RelationshipTypes.NEXT = 0;
               END;
               3:BEGIN
                    CountryRegion.RESET;
                    IF CountryRegion.FINDFIRST THEN
                        REPEAT
                            StringList += CountryRegion.Code+':::'+CountryRegion.Name+'||';
                          UNTIL CountryRegion.NEXT = 0;
                 END;
          END;
          */
        exit(StringList);

    end;


    procedure AgencyNewRegistration() Registrations: Text
    begin

        StringList := '';

        AgentAccount.Reset;
        AgentAccount.SetRange(AgentAccount."Sent To Server", AgentAccount."sent to server"::No);
        AgentAccount.SetRange(AgentAccount."Approval Status", AgentAccount."approval status"::Approved);
        if AgentAccount.Find('-') then begin
            repeat

                //StringList:=StringList+AgentAccount."Agent Code" + ':::' + AgentAccount.Name + ':::' + AgentAccount."Mobile No" + ':::' + FORMAT(AgentAccount."Internal Agent") +'||';
                StringList := StringList + AgentAccount."Agent Code" + ':::' + AgentAccount.Name + ':::' + AgentAccount."Mobile No" + ':::' +
                Format(AgentAccount."Internal Agent") + ':::' + AgentAccount."Place of Business" + ':::' + AgentAccount."Device ID" + ':::' + Format(AgentAccount."Is Admin") + '||';


            until AgentAccount.Next = 0;
        end;

        exit(StringList);
    end;


    procedure AgencyModRegistration(AgentCode: Code[15])
    begin
        AgentAccount.Reset;
        AgentAccount.SetRange(AgentAccount."Agent Code", AgentCode);
        if AgentAccount.Find('-') then begin
            AgentAccount."Sent To Server" := AgentAccount."sent to server"::Yes;
            AgentAccount.Modify;
        end;
    end;

    local procedure CreateBiometricData(AgentTrans: Record "Agent Transactions"; PassportPhoto: Text; IDFront: Text; IDBack: Text; Signature: Text; FingerOne: Text; FingerTwo: Text; FingerThree: Text; FingerFour: Text; ApplicationFormFront: Text; ApplicationFormBack: Text)
    var
        AgentBiometricData: Record "Agent Biometric Data";
        ByteOne: code[100];//dotnet Array;
        ImageOutStream: OutStream;
    begin
        AgentBiometricData.Init;
        AgentBiometricData.IDNO := AgentTrans."Id No";
        AgentBiometricData.DocumentNo := AgentTrans."Document No.";

        //images
        // AgentBiometricData.PassportPhoto.CreateOutstream(ImageOutStream);
        WriteBase64StringToImageStream(PassportPhoto, ImageOutStream);
        // AgentBiometricData.IDFront.CreateOutstream(ImageOutStream);
        WriteBase64StringToImageStream(IDFront, ImageOutStream);
        AgentBiometricData.IDBack.CreateOutstream(ImageOutStream);
        WriteBase64StringToImageStream(IDBack, ImageOutStream);
        // AgentBiometricData.Signature.CreateOutstream(ImageOutStream);
        WriteBase64StringToImageStream(Signature, ImageOutStream);
        AgentBiometricData.ApplicationFormFront.CreateOutstream(ImageOutStream);
        WriteBase64StringToImageStream(ApplicationFormFront, ImageOutStream);
        AgentBiometricData.ApplicationFormBack.CreateOutstream(ImageOutStream);
        WriteBase64StringToImageStream(ApplicationFormBack, ImageOutStream);

        //Fingerprints
        AgentBiometricData.FingerOne.CreateOutstream(ImageOutStream);
        WriteBase64StringToImageStream(FingerOne, ImageOutStream);
        AgentBiometricData.FingerTwo.CreateOutstream(ImageOutStream);
        WriteBase64StringToImageStream(FingerTwo, ImageOutStream);
        AgentBiometricData.FingerThree.CreateOutstream(ImageOutStream);
        WriteBase64StringToImageStream(FingerThree, ImageOutStream);
        AgentBiometricData.FingerFour.CreateOutstream(ImageOutStream);
        WriteBase64StringToImageStream(FingerFour, ImageOutStream);

        AgentBiometricData.Insert;
    end;

    local procedure WriteBase64StringToImageStream(Base64String: Text; ImageStream: OutStream)
    var
        Bytes: code[100];//dotnet Array;
        Convert: code[100];//dotnet Convert;
        MemoryStream: code[100];//dotnet MemoryStream;
    begin
        // Bytes := Convert.FromBase64String(Base64String);
        // MemoryStream := MemoryStream.MemoryStream(Bytes);
        // MemoryStream.WriteTo(ImageStream);
    end;

    local procedure ConvertThisInstreamToBase64String(ImageStream: InStream): Text
    var
        Bytes: code[100];//dotnet Array;
        Convert: code[100];//dotnet Convert;
        MemoryStream: code[100];//dotnet MemoryStream;
    begin
        // MemoryStream := MemoryStream.MemoryStream();
        // CopyStream(MemoryStream, ImageStream);
        // Bytes := MemoryStream.GetBuffer();
        // exit(Convert.ToBase64String(Bytes));
    end;

    local procedure FROMBASE64(Base64String: BigText; ImageStream: OutStream)
    var
        Bytes: code[100];//dotnet Array;
        Convert: code[100];//dotnet Convert;
        MemoryStream: code[100];//dotnet MemoryStream;
    begin
        // Bytes := Convert.FromBase64String(Base64String);
        // MemoryStream := MemoryStream.MemoryStream(Bytes);
        // MemoryStream.WriteTo(ImageStream);
    end;


    procedure CreateVirtualRegistration(IdNum: Text; Citizenship: Text; SerialNo: Text; Comments: Text; MpesaNamesMatched: Boolean; MpesaNames: Text; FullNames: Text; Gender: Text; IprsDateOfBirth: Date; Msisdn: Text; Picture: Text; IdIsValid: Boolean; AgentCode: Text) Done: Boolean
    var
        VirtualRegistrations: Record "Virtual Registrations";
        IDFrontOutstream: OutStream;
        IDBackOutstream: OutStream;
        MyPictureOutstream: OutStream;
        ReasonsPicOutstream: OutStream;
        BankCardOutstream: OutStream;
        FingerOneOutstream: OutStream;
        FingerTwoOutstream: OutStream;
        FingerThreeOutstream: OutStream;
        FingerFourOutstream: OutStream;
        BankCardPhotoOutstream: OutStream;
        Photo1Outstream: OutStream;
        Photo2Outstream: OutStream;
        Photo3Outstream: OutStream;
        BytesOne: code[100];//dotnet Array;
        BytesTwo: code[100];//dotnet Array;
        BytesThree: code[100];//dotnet Array;
        BytesFour: code[100];//dotnet Array;
        BytesFive: code[100];//dotnet Array;
        BytesSix: code[100];//dotnet Array;
        BytesSeven: code[100];//dotnet Array;
        BytesEight: code[100];//dotnet Array;
        BytesNine: code[100];//dotnet Array;
        Convert: code[100];//dotnet Convert;
        MemoryStreamOne: code[100];//dotnet MemoryStream;
        MemoryStreamTwo: code[100];//dotnet MemoryStream;
        MemoryStreamThree: code[100];//dotnet MemoryStream;
        MemoryStreamFour: code[100];//dotnet MemoryStream;
        MemoryStreamFive: code[100];//dotnet MemoryStream;
        MemoryStreamSix: code[100];//dotnet MemoryStream;
        MemoryStreamSeven: code[100];//dotnet MemoryStream;
        MemoryStreamEight: code[100];//dotnet MemoryStream;
        MemoryStreamNine: code[100];//dotnet MemoryStream;
        AgentTransactions: Record "Agent Transactions";
        RandomDigit: Text;
        BytesTen: code[100];//dotnet Array;
        BytesEleven: code[100];//dotnet Array;
        BytesTwelve: code[100];//dotnet Array;
        MemoryStreamTen: code[100];//dotnet MemoryStream;
        MemoryStreamEleven: code[100];//dotnet MemoryStream;
        MemoryStreamTwelve: code[100];//dotnet MemoryStream;
        ImageOutStream: OutStream;
        Found: Boolean;
        PostTrans: Codeunit "Post Agent Transactions";
        StringName: Text;
    begin
        Found := false;
        VirtualRegistrations.Reset;
        VirtualRegistrations.SetRange("ID/Passport", IdNum);
        if VirtualRegistrations.FindFirst then
            Found := true;

        if not Found then VirtualRegistrations.Init;

        VirtualRegistrations."ID/Passport" := IdNum;
        VirtualRegistrations.Citizenship := Citizenship;
        VirtualRegistrations."Application Date" := Today;
        VirtualRegistrations."Mpesa Names Matched" := MpesaNamesMatched;
        VirtualRegistrations."Mpesa Names" := MpesaNames;
        VirtualRegistrations."Full Names" := FullNames;
        StringName := FullNames;
        VirtualRegistrations."First Name" := PostTrans.SplitThisString(StringName, ' ');
        VirtualRegistrations."Second Name" := PostTrans.SplitThisString(StringName, ' ');
        VirtualRegistrations."Last Name" := PostTrans.SplitThisString(StringName, ' ') +
                                          PostTrans.SplitThisString(StringName, ' ');
        VirtualRegistrations."IPRS Date Of Birth" := IprsDateOfBirth;
        VirtualRegistrations.Msisdn := Msisdn;
        VirtualRegistrations."Application Date" := Today;
        VirtualRegistrations.Comments := Comments;
        VirtualRegistrations.IsVirtual := true;
        VirtualRegistrations.MyPicture.CreateOutstream(ImageOutStream);
        WriteBase64StringToImageStream(Picture, ImageOutStream);
        case Gender of
            'M':
                VirtualRegistrations.Gender := VirtualRegistrations.Gender::Male;
            'F':
                VirtualRegistrations.Gender := VirtualRegistrations.Gender::Female
        end;

        if not Found then
            VirtualRegistrations.Insert
        else
            VirtualRegistrations.Modify;

        exit(true);
    end;


    procedure GetMicroGroupDetails(GroupCode: Code[20]): Text
    var
        Micro_Fin_Transactions: Record "Payment Terms";
        Micro_Fin_Schedules: Record "Payment Terms";
        SavingsAccounts: Record "Savings Accounts";
        LoanApplic: Record Loans;
        // // NoSeriesMgt: Codeunit NoSeriesManagement;
        SalesSetup: Record "Banking No Setup";
        MicroSubform: Record "Payment Terms";
        BANKACC: Record "Bank Account";
        SavAccs: Record "Savings Accounts";
        grouptrans: Record "Payment Terms";
        Memb: Record Members;
        user: Record "User Setup";
        UserSetup: Record "User Setup";
        CredAccs: Record "Credit Accounts";
        Temp: Record "Banking User Template";
        Jtemplate: Code[20];
        TillNo: Code[20];
        ExpectedAmount: Decimal;
        TotalExpectedAmount: Decimal;
        TotalCount: Integer;
        MicroLoan: Record Loans;
        GroupName: Code[50];
    begin
        /*StringList := '';
        TotalExpectedAmount := 0;
        GroupName := '';
        IF Memb.GET(GroupCode) THEN
          GroupName := Memb.Name;
        
        MicroLoan.RESET;
        MicroLoan.SETRANGE("Group Code",GroupCode);
        MicroLoan.SETFILTER("Outstanding Balance",'>0');
        IF MicroLoan.FINDFIRST THEN
          REPEAT
               MicroLoan.CALCFIELDS("Outstanding Bills","Outstanding Interest");
               TotalExpectedAmount += MicroLoan."Outstanding Bills" + MicroLoan."Outstanding Interest";
             UNTIL MicroLoan.NEXT = 0;
        
        SavingsAccounts.RESET;
        SavingsAccounts.SETRANGE("Product Category",SavingsAccounts."Product Category"::"Micro Savings");
        SavingsAccounts.SETRANGE(SavingsAccounts."Group Account No",GroupCode);
        SavingsAccounts.SETRANGE(Status,SavingsAccounts.Status::Active);
        SavingsAccounts.SETRANGE("Group Account",FALSE);
        IF SavingsAccounts.FIND('-') THEN BEGIN
        TotalCount := SavingsAccounts.COUNT;
        REPEAT
        
            ExpectedAmount := 0;
            LoanApplic.RESET;
            LoanApplic.SETRANGE("Group Code",GroupCode);
            LoanApplic.SETFILTER("Outstanding Balance",'>0');
            LoanApplic.SETRANGE("Member No.",SavingsAccounts."Member No.");
            IF LoanApplic.FINDFIRST THEN BEGIN
                 REPEAT
                      LoanApplic.CALCFIELDS(LoanApplic."Outstanding Balance",LoanApplic."Outstanding Bills",LoanApplic."Outstanding Interest",LoanApplic."Ledger Fee Balance");
                      ExpectedAmount += LoanApplic."Outstanding Bills"+LoanApplic."Outstanding Interest";
                   UNTIL LoanApplic.NEXT = 0;
              END;
        
              StringList += GroupName+':::'+SavingsAccounts."Member No."+':::'+SavingsAccounts.Name+':::'+FORMAT(ExpectedAmount)+':::'+FORMAT(TotalExpectedAmount)+':::'+FORMAT(TotalCount)+'||'
        
          UNTIL SavingsAccounts.NEXT = 0;
        END;
        
        EXIT (StringList);*/

    end;

    local procedure CreateNextOfKinDetails(DocumentNo: Code[20]; NextOfKinName: Text; NextOfKinRelationShip: Text; NextOfKinID: Text; NextOfKinPhone: Text)
    var
        AgNOK: Record "Agent Next Of Kin Details";
    begin
        AgNOK.Init;
        AgNOK."Entry No" := 0;
        AgNOK."Document No" := DocumentNo;
        AgNOK."Next Of Kin Name" := NextOfKinName;
        AgNOK."Next Of Kin ID" := NextOfKinID;
        AgNOK."Next Of Kin RelationShip" := NextOfKinRelationShip;
        AgNOK."Next Of Kin Phone" := NextOfKinPhone;
        AgNOK.Insert;
    end;

    local procedure CreateGroupSchedule(DocumentNo: Code[20]; GroupCode: Text; TotalGroupLoanPaid: Decimal; TotalGroupLoanUnPaid: Decimal; TotalGroupSavingsPaid: Decimal; TotalGroupPaidAmount: Decimal; GroupTransVerifiedBy: Text; GroupVerifierPhoneNumber: Text; GroupTransInitializationTime: DateTime; GroupTransPostingTime: DateTime; TotalGroupPresentMembers: Integer; TotalGroupAbsentMembers: Integer; GroupImage: Text; GroupRemarks: Text)
    var
        AgentGroupSchedule: Record "Agent Group Schedule";
        ImageOutStream: OutStream;
    begin
        AgentGroupSchedule.Init;
        AgentGroupSchedule."Entry No" := 0;
        AgentGroupSchedule."Document No" := DocumentNo;
        AgentGroupSchedule."Group Code" := GroupCode;
        AgentGroupSchedule."Total Group Loan Paid" := TotalGroupLoanPaid;
        AgentGroupSchedule."Total Group Loan UnPaid" := TotalGroupLoanUnPaid;
        AgentGroupSchedule."Total Group Savings Paid" := TotalGroupSavingsPaid;
        AgentGroupSchedule."Total Group Paid Amount" := TotalGroupPaidAmount;
        AgentGroupSchedule."GroupTransaction Verified By" := GroupTransVerifiedBy;
        AgentGroupSchedule."Group Verifier Phone Number" := GroupVerifierPhoneNumber;
        AgentGroupSchedule."Group Trans Init Time" := GroupTransInitializationTime;
        AgentGroupSchedule."Group Trans Posting Time" := GroupTransPostingTime;
        AgentGroupSchedule."Group Present Members" := TotalGroupPresentMembers;
        AgentGroupSchedule."Group Absent Members" := TotalGroupAbsentMembers;
        AgentGroupSchedule."Group Image".CreateOutstream(ImageOutStream);
        WriteBase64StringToImageStream(GroupImage, ImageOutStream);
        AgentGroupSchedule."Group Remarks" := GroupRemarks;
        AgentGroupSchedule.Insert;
    end;


    procedure GetTheNameOfThisCode(CodeValue: Code[20]; Identifier: Integer): Text
    var
        Members: Record Members;
    begin
        case Identifier of
            1:
                if Members.Get(CodeValue) then
                    exit(Members.Name);
        end;
        exit('');
    end;


    procedure GetMyFingerPrint(Identifier: Text[40]; IdentifierType: Integer): Text
    var
        ImageData: Record "Image Data";
        ImageInStream: InStream;
        FingerPrint: Text;
    begin
        FingerPrint := '';
        ImageData.Reset;
        case IdentifierType of
            1:
                ImageData.SetRange("ID Number", Identifier);
            2:
                ImageData.SetRange("Member No", Identifier);
        end;
        if ImageData.FindFirst then begin
            ImageData.CalcFields(FingerOne, FingerTwo, FingerThree, FingerFour);
            ImageData.FingerOne.CreateInstream(ImageInStream);
            FingerPrint += ConvertThisInstreamToBase64String(ImageInStream) + ':::';
            ImageData.FingerTwo.CreateInstream(ImageInStream);
            FingerPrint += ConvertThisInstreamToBase64String(ImageInStream) + ':::';
            ImageData.FingerThree.CreateInstream(ImageInStream);
            FingerPrint += ConvertThisInstreamToBase64String(ImageInStream) + ':::';
            ImageData.FingerFour.CreateInstream(ImageInStream);
            FingerPrint += ConvertThisInstreamToBase64String(ImageInStream) + '||';
        end;
        exit(FingerPrint);
    end;


    procedure LogErrorMessage(AgentCode: Code[20]; DocumentNo: Code[20]; TransDescription: Text; DateTime: DateTime; ErrorMessage: Text; Source: Integer)
    var
        AgentErrorMessages: Record "Agent Error Messages";
    begin
        AgentErrorMessages.Init;
        AgentErrorMessages."Agent Code" := AgentCode;
        AgentErrorMessages."Document No" := DocumentNo;
        AgentErrorMessages."Transaction Description" := TransDescription;
        AgentErrorMessages.DateTime := DateTime;
        AgentErrorMessages."Error Message" := PadStr(ErrorMessage, 250);
        AgentErrorMessages.Source := Source;
        AgentErrorMessages.Insert;
    end;

    local procedure CanCreateSavingsAccount(IdNo: Code[10]; ProductType: Code[10]): Boolean
    var
        AllowMultipleAcntError: label 'Applicant already has %1, Kindly ensure this product allows multiple account creations to proceed.';
        SavingsAccounts: Record "Savings Accounts";
        ProductFactory: Record "Product Factory";
        Members: Record Members;
        MemberClass: Record "Member Classes";
        Sav: Record "Savings Accounts";
    begin
        ProductFactory.Get(ProductType);
        if (ProductFactory."Product Class Type" = ProductFactory."product class type"::Loan) then
            exit(false);

        Members.Reset;
        Members.SetRange("Primary Identification", IdNo);
        Members.SetRange(Status, Members.Status::Active);
        if Members.FindFirst then begin
            if Members.Count <> 1 then
                exit(false);
        end;

        SavingsAccounts.Reset;
        SavingsAccounts.SetRange(SavingsAccounts."Member No.", Members."No.");
        SavingsAccounts.SetRange(SavingsAccounts."Product Type", ProductFactory."Product ID");
        if SavingsAccounts.Find('-') then
            if not ProductFactory."Allow Multiple Accounts" then
                exit(false);

        /*MemberClass.RESET;
        MemberClass.SETRANGE(MemberClass."No.",ProductFactory."Member Category");
        IF MemberClass.FIND('-') THEN
          BEGIN
                Sav.RESET;
                Sav.SETRANGE(Sav."Member No.",Members."No.");
                Sav.SETRANGE(Sav."Product Category",Sav."Product Category"::"BOSA Deposits");
                IF Sav.FIND('-') THEN
                  BEGIN
                    Sav.CALCFIELDS(Balance,"Balance (LCY)");
                    IF Sav."Balance (LCY)"<MemberClass."Premier Club Min.Deposits" THEN
                       EXIT(FALSE);
                    END;
            END;*/

        exit(true);

    end;


    procedure GetLoanStatement(LoanNo: Code[20]; NoofEntries: Integer): Text
    var
        Pdate: Date;
        Descr: Text;
        Amnt: Decimal;
        CreditLedgerEntry: Record "Credit Ledger Entry";
    begin
        StringList := '';
        CreditLedgerEntry.Reset;
        CreditLedgerEntry.SetRange("Loan No", LoanNo);
        CreditLedgerEntry.SetCurrentkey("Entry No.");
        CreditLedgerEntry.SetAscending("Entry No.", false);
        CreditLedgerEntry.SetRange(Reversed, false);
        if CreditLedgerEntry.FindFirst then
            repeat
                if NoofEntries > 0 then begin
                    StringList += Format(CreditLedgerEntry."Posting Date") + ':::' + CreditLedgerEntry.Description + ':::' + Format(CreditLedgerEntry.Amount) + '||';
                end;
            until CreditLedgerEntry.Next = 0;
    end;


    procedure GetPhotoAndSignature(Identifier: Code[50]; IdentifierType: Integer): Text
    var
        ImageData: Record "Image Data";
        ImageInStream: InStream;
    begin
        ImageData.Reset;
        case IdentifierType of
            1:
                ImageData.SetRange("ID Number", Identifier);
            2:
                ImageData.SetRange("Member No", Identifier);
        end;
        if ImageData.FindFirst then begin
            ImageData.CalcFields(Picture, Signature);
            // if ImageData.Picture.Hasvalue then begin
            //     ImageData.Picture.CreateInstream(ImageInStream);
            //     //StringList += ConvertThisInstreamToBase64String(ImageInStream)+':::';//To prevent from loading Photos

            //     StringList += 'N/A:::';
            // end else
            //     StringList += 'N/A:::';
            // if ImageData.Signature.Hasvalue then begin
            //     ImageData.Signature.CreateInstream(ImageInStream);
            //     //StringList += ConvertThisInstreamToBase64String(ImageInStream)+'||' //To prevent from loading Photos

            //     StringList += 'N/A||';
            // end else
            //     StringList += 'N/A||';
        end;



        exit(StringList);
    end;


    procedure LogSentSmsMessage(AgentCode: Code[20]; DocumentNo: Code[20]; IdNo: Code[20]; DateTime: DateTime; TextMessage: Text; Source: Integer)
    var
        AgentSentSms: Record "Agent Sent Sms";
    begin
        AgentSentSms.Init;
        AgentSentSms."Agent Code" := AgentCode;
        AgentSentSms."Document No" := DocumentNo;
        AgentSentSms."ID Number" := IdNo;
        AgentSentSms.DateTime := DateTime;
        AgentSentSms."Text Message" := TextMessage;
        AgentSentSms."Source Transaction" := Source;
        AgentSentSms.Insert;
    end;


    procedure GetOptionalFields() CustomFields: Text
    var
        AgencySetup: Record "Agency Setup";
        Field1: Text;
        Field2: Text;
        Field3: Text;
        Field4: Text;
        Field5: Text;
    begin
        AgencySetup.Get;

        Field1 := 'Field 1';
        Field2 := 'Field 2';
        Field3 := 'Field 3';
        Field4 := 'Field 4';
        Field5 := 'Field 5';

        if AgencySetup."Registration Field 1 Caption" <> '' then Field1 := AgencySetup."Registration Field 1 Caption";
        if AgencySetup."Registration Field 2 Caption" <> '' then Field2 := AgencySetup."Registration Field 2 Caption";
        if AgencySetup."Registration Field 3 Caption" <> '' then Field3 := AgencySetup."Registration Field 3 Caption";
        if AgencySetup."Registration Field 4 Caption" <> '' then Field4 := AgencySetup."Registration Field 4 Caption";
        if AgencySetup."Registration Field 5 Caption" <> '' then Field5 := AgencySetup."Registration Field 5 Caption";

        CustomFields := Field1 + ':::' + Field2 + ':::' + Field3 + ':::' + Field4 + ':::' + Field5 + '||';
    end;


    procedure GetTransactionBreakDown(DocumentNo: Code[30]): Text
    var
        ATrans: Record "Agent Transactions";
        TariffHeader: Record "Agent Tarriff Header";
        TariffDetails: Record "Agent Tariff Details";
        AgentTransactionsCharged: Record "Agent Transactions Charged";
        GLEntry: Record "G/L Entry";
    begin
        StringList := '0:::0:::0:::0';

        GLEntry.Reset;
        GLEntry.SetRange(Reversed, false);
        GLEntry.SetRange("Document No.", DocumentNo);
        if GLEntry.FindFirst then begin

            ATrans.Reset;
            ATrans.SetRange("Document No.", DocumentNo);
            if ATrans.FindFirst then begin

                AgentTransactionsCharged.Reset;
                AgentTransactionsCharged.SetRange("Document No", DocumentNo);
                if AgentTransactionsCharged.FindFirst then
                    StringList := Format(AgentTransactionsCharged."Total Commission") + ':::' + Format(AgentTransactionsCharged."Sacco Commission") + ':::' +
                Format(AgentTransactionsCharged."Agent Comission") + ':::' + Format(AgentTransactionsCharged."Vendor Commission")


                else begin

                    TariffHeader.Reset();
                    TariffHeader.SetRange(TariffHeader."Trans Type Agents", ATrans."Transaction Type");
                    if TariffHeader.FindFirst then begin
                        TariffDetails.Reset();
                        TariffDetails.SetRange(TariffDetails.Code, TariffHeader.Code, TariffHeader.Code);
                        TariffDetails.SetFilter(TariffDetails."Lower Limit", '<=%1', ATrans.Amount);
                        TariffDetails.SetFilter(TariffDetails."Upper Limit", '>=%1', ATrans.Amount);
                        if TariffDetails.FindFirst then begin
                            StringList := Format(TariffDetails."Charge Amount") + ':::' + Format(TariffDetails."Sacco Comm") + ':::' + Format(TariffDetails."Agent Comm") + ':::' + Format(TariffDetails."Vendor Comm");
                        end;
                    end;


                end;
            end;
        end;

        exit(StringList);
    end;

    local procedure ValidateTransaction(AgentTrans: Record "Agent Transactions"): Decimal
    var
        AgencySetup: Record "Agency Setup";
        ATrans: Record "Agent Transactions";
        ErrCount: label 'Transaction Disallowed! The maximum number of %1 transactions today for account %2 is %3';
        ErrAmount: label 'Transaction Diasallowed! The maximum %1 amount for account %2 today is %3';
        Sav: Record "Savings Accounts";
    begin
        AgencySetup.Get;
        //IF Sav.GET(AgentTrans."Account No.") THEN
        //  IF NOT Sav."Allow Multiple Agent Trans" THEN

        begin

            // if "Transaction Type" in ["transaction type"::Deposit, "transaction type"::Withdrawal] then begin

            //     ATrans.Reset;
            //     ATrans.SetRange("Account No.", "Account No.");
            //     ATrans.SetRange("Transaction Type", AgentTrans."Transaction Type");
            //     ATrans.SetRange(Posted, true);
            //     ATrans.SetRange("Transaction Date", AgentTrans."Transaction Date");
            //     if ATrans.FindFirst then begin
            //         case ATrans."Transaction Type" of

            //             ATrans."transaction type"::Withdrawal:
            //                 begin

            //                     if ATrans.Count >= AgencySetup."Max Withdrawal Count" then
            //                         Error(ErrCount, "Transaction Type", "Account No.", AgencySetup."Max Withdrawal Count");
            //                     ATrans.CalcSums(Amount);
            //                     if ATrans.Amount >= AgencySetup."Max Withdrawal Amount" then
            //                         Error(ErrAmount, "Transaction Type", "Account No.", AgencySetup."Max Withdrawal Amount");
            //                 end;

            //             ATrans."transaction type"::Deposit:
            //                 begin

            //                     if ATrans.Count >= AgencySetup."Max Deposit Count" then
            //                         Error(ErrCount, "Transaction Type", "Account No.", AgencySetup."Max Deposit Count");
            //                     ATrans.CalcSums(Amount);
            //                     if ATrans.Amount >= AgencySetup."Max Deposit Amount" then
            //                         Error(ErrAmount, "Transaction Type", "Account No.", AgencySetup."Max Withdrawal Amount");

            //                 end;

            //         end;
            //     end;

            // end;

        end;
    end;
}
