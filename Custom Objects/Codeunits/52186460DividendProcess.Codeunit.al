#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 52186460 "Dividend Process"
{

    trigger OnRun()
    begin
        //**generateDivdends();
    end;

    var
        Text002: label 'Generating Dividend: #1#########\';
        Text003: label 'Member Name: #2#############\';
        DividendProgression: Record "Dividend Progression";
        DividendSetUp: Record "Dividend SetUp";
        StartDate: Date;
        EndDate: Date;
        DateFilter: Text;
        ProductFactory: Record "Product Factory";
        SavingsAccounts: Record "Savings Accounts";
        DivPayMode: Code[20];
        DividendInstructions: Record "Dividend Instructions - Member";
        Text004: label 'Div-';
        Loans: Record Loans;
        YearDateFilter: Text;
        BalanceDateFilter: Text;
        GrossAmount: Decimal;
        GeneralSetUp: Record "General Set-Up";
        Year: Integer;
        PreviousYear: Integer;
        DividendPostingBufferII: Record "Dividend Posting Buffer";
        Mydeduction: Decimal;
        TransAmt: Decimal;
        LoansProcess: codeunit "Loans Process";
        GlobalFunc: Codeunit "Global Functions";
        RunLoan: Boolean;
        SavingsIncentives: Record "Savings Accounts";
        RegistrationProcess: Codeunit "Registration Process";
        SavingsArrears: Decimal;

    procedure getDividendRate(DividendsSimulationHeader: Record "Dividend Simulation Header")
    var
        DividendAccount: Code[20];
        DividendCalculationBuffer: Record "Dividend Simulation Lines";
    begin
        DividendCalculationBuffer.Reset;
        DividendCalculationBuffer.SetRange(DividendCalculationBuffer."Document No.", DividendsSimulationHeader."No.");
        if DividendCalculationBuffer.FindSet then
            DividendCalculationBuffer.DeleteAll;

        getDividendSetup;

        getSavingsContribution(StartDate, EndDate, DividendsSimulationHeader."G/L Account", 12, '1',
                               DividendsSimulationHeader."Product Type", DividendsSimulationHeader."No.");
    end;


    procedure getSavingsContribution(StartDate: Date; EndDate: Date; DividendAccount: Code[20]; CalculationPeriod: Integer; SimulationNo: Code[20]; ProductType: Code[10]; DocumentNo: Code[10])
    var
        GLAccount: Record "G/L Account";
        DividendCalculationBuffer: Record "Dividend Simulation Lines";
        i: Integer;
        LineNo: Integer;
        x: Integer;
        NewMonth: Date;
    begin
        getDividendSetup;

        x := CalculationPeriod;
        for i := 1 to CalculationPeriod do begin
            GLAccount.Reset;
            LineNo += 1;
            if i = 1 then begin
                EndDate := CalcDate('CM', StartDate);
                GLAccount.SetRange(GLAccount."Date Filter", 0D, EndDate);
            end else
                GLAccount.SetRange(GLAccount."Date Filter", StartDate, NewMonth);
            GLAccount.SetRange(GLAccount."No.", DividendAccount);
            if GLAccount.FindFirst then
                GLAccount.CalcFields(GLAccount."Net Change");

            //with DividendCalculationBuffer do 
            begin
                DividendCalculationBuffer.Init;
                DividendCalculationBuffer."No." := SimulationNo;
                DividendCalculationBuffer."Entry No" := LineNo;
                DividendCalculationBuffer."G/L Account" := DividendAccount;
                DividendCalculationBuffer."Start Date" := StartDate;
                DividendCalculationBuffer."End Date" := EndDate;
                DividendCalculationBuffer.Amount := Abs(GLAccount."Net Change");
                DividendCalculationBuffer."Weighted Amount" := DividendCalculationBuffer.Amount * (x / CalculationPeriod);
                DividendCalculationBuffer."Product Type" := ProductType;
                DividendCalculationBuffer."Document No." := DocumentNo;
                DividendCalculationBuffer.Insert;
            end;

            NewMonth := CalcDate('1M', EndDate);
            EndDate := CalcDate('CM', NewMonth);
            x := x - 1;
        end;
    end;

    procedure MyProcedure()
    var
        myInt: Integer;
    begin

    end;

    procedure generateDivdends(DividendAccount: Record "Savings Accounts")
    var
        GrossDiv: Decimal;
        WTaxDiv: Decimal;
        NetDiv: Decimal;
        FromDate: Date;
        ToDate: Date;
        EntrNo: Integer;
        diaProgress: Dialog;
        MemberNo: label 'Member No: ';
        MemberName: label 'Name: ';
        intProgress: Integer;
        timProgress: Time;
        intProgressI: Integer;
        intProgressTotal: Integer;
        CustMembr: Record Members;
        SavingsAcc: Record "Savings Accounts";
        GeneratingDividends: label 'Generating Dividend :';
        Counter1: Integer;
        Counter2: Integer;
        GrossDividend: Decimal;
        WeightedShareDep: Decimal;
        MembershipClosure: Record "Membership closure";
        QualifyingShares: Decimal;
        StartDateToFeed: date;
        EndDateToFeed: date;
        I: Integer;
        AccountBal: Decimal;
        GSetup: Record "General Set-Up";
        GlobalFunctions: Codeunit "Global Functions";
        TheMember: Record members;
    begin
        GSetup.GET;
        getDividendSetup;
        DividendSetUp.Get;
        EndDate := DividendSetUp."End Date";
        StartDate := DividendSetUp."Start Date";
        YearDateFilter := '';
        //Interest On Deposits
        ProductFactory.RESET;
        ProductFactory.SETRANGE("Product ID", DividendAccount."Product Type");
        ProductFactory.SETRANGE("Product Class Type", ProductFactory."Product Class Type"::Savings);
        ProductFactory.SETFILTER("Dividend Calc. Method", '<>%1', ProductFactory."Dividend Calc. Method"::" ");
        IF ProductFactory.FIND('-') THEN BEGIN

            intProgressTotal := DividendAccount.COUNT;
            YearDateFilter := '..' + FORMAT(EndDate);

            if TheMember.Get(DividendAccount."Member No.") then begin
                CASE ProductFactory."Dividend Calc. Method" OF
                    ProductFactory."Dividend Calc. Method"::"Flat Rate":
                        BEGIN
                            DateFilter := '..' + FORMAT(DividendSetUp."End Date");
                            DividendAccount.SETFILTER("Date Filter", DateFilter);
                            DividendAccount.SETFILTER("Balance (LCY)", '>0');
                            DividendAccount.CALCFIELDS("Balance (LCY)");
                            GrossDiv := ROUND(((ProductFactory."Interest Rate (Min.)" / 100) * DividendAccount."Balance (LCY)"), 0.01, '<');
                            WTaxDiv := ROUND((GrossDiv * (ProductFactory."WithHolding Tax" / 100)), 0.01, '<');
                            if GlobalFunctions.TaxExcemptions(DividendAccount."Member No.") = true then
                                WTaxDiv := 0;
                            NetDiv := GrossDiv - WTaxDiv;
                            EntrNo += 1;
                            CreateDividendLines(
                            DividendAccount."No.", TODAY, DividendAccount."Product Type", DividendAccount."Product Name", DividendAccount."Member No.",
                            DividendAccount."Balance (LCY)", DividendAccount."Balance (LCY)", GrossDiv, WTaxDiv, NetDiv,
                            DividendSetUp."End Date", CalcDate('-CY', DividendSetUp."End Date"), ProductFactory."Dividend Calc. Method", EntrNo, DivPayMode, DividendAccount."Balance (LCY)", TheMember);
                        end;

                    ProductFactory."Dividend Calc. Method"::Prorated:
                        BEGIN
                            FromDate := StartDate;
                            YearDateFilter := '..' + FORMAT(EndDate);
                            ToDate := CALCDATE('-1D', StartDate);
                            // Message('StartDate %1, EndDate %2', StartDate, EndDate);
                            // Message(format(Date2dmy(StartDate, 3)));
                            if Date2dmy(StartDate, 3) = 2025 then
                                DateFilter := format(20250504D) + '..' + FORMAT(CALCDATE('CM', StartDate))
                            else
                                DateFilter := '..' + FORMAT(CALCDATE('CM', StartDate));
                            EntrNo := 1000;
                            if Date2dmy(StartDate, 3) = 2025 then begin
                                FOR i := 8 DOWNTO 1 DO BEGIN
                                    if i = 8 then begin
                                        ToDate := CALCDATE('CM', StartDate);
                                    end;
                                    DividendAccount.RESET;
                                    DividendAccount.SETFILTER("Date Filter", DateFilter);
                                    DividendAccount.CALCFIELDS("Balance (LCY)");
                                    QualifyingShares := DividendAccount."Balance (LCY)";
                                    GrossDiv := ROUND(((ProductFactory."Interest Rate (Min.)" / 100) * QualifyingShares * (i / 12)), 0.01, '<');
                                    WTaxDiv := ROUND((GrossDiv * (ProductFactory."WithHolding Tax" / 100)), 0.01, '<');
                                    if GlobalFunctions.TaxExcemptions(DividendAccount."Member No.") = true then
                                        WTaxDiv := 0;
                                    NetDiv := GrossDiv - WTaxDiv;
                                    EntrNo += 1;

                                    //IF CustMembr.GET(DividendAccount."Member No.") THEN
                                    //DivPayMode := CustMembr."Dividend Payment Method";

                                    AccountBal := 0;
                                    // DividendAccount.RESET;
                                    // DividendAccount.SETFILTER("Date Filter", DateFilter);//, '..%1', ToDate);
                                    // DividendAccount.CALCFIELDS("Balance (LCY)");
                                    // GSetup.TESTFIELD("Minimum Div Earning Amount");
                                    //IF DividendAccount."Balance (LCY)" >= ProductFactory."Interest Calc Min Balance" THEN
                                    CreateDividendLines(DividendAccount."No.", TODAY, DividendAccount."Product Type", DividendAccount."Product Name", DividendAccount."Member No.",
                                        QualifyingShares, DividendAccount."Balance (LCY)", GrossDiv, WTaxDiv, NetDiv,
                                        ToDate, CALCDATE('-CM', ToDate), ProductFactory."Dividend Calc. Method", EntrNo, DivPayMode, DividendAccount."Balance (LCY)", TheMember);
                                    ToDate := CALCDATE('1M+CM', ToDate);
                                    FromDate := CALCDATE('-CM', ToDate);
                                    DateFilter := Format(FromDate) + '..' + Format(ToDate);
                                END;
                            end
                            else begin
                                FOR i := 12 DOWNTO 1 DO BEGIN
                                    if i = 12 then ToDate := CALCDATE('CM', StartDate);
                                    DividendAccount.RESET;
                                    DividendAccount.SETFILTER("Date Filter", DateFilter);
                                    DividendAccount.CALCFIELDS("Balance (LCY)");
                                    QualifyingShares := DividendAccount."Balance (LCY)";
                                    GrossDiv := ROUND(((ProductFactory."Interest Rate (Min.)" / 100) * QualifyingShares * (i / 12)), 0.01, '<');
                                    WTaxDiv := ROUND((GrossDiv * (ProductFactory."WithHolding Tax" / 100)), 0.01, '<');
                                    if GlobalFunctions.TaxExcemptions(DividendAccount."Member No.") = true then
                                        WTaxDiv := 0;
                                    NetDiv := GrossDiv - WTaxDiv;
                                    EntrNo += 1;

                                    //IF CustMembr.GET(DividendAccount."Member No.") THEN
                                    //DivPayMode := CustMembr."Dividend Payment Method";

                                    AccountBal := 0;
                                    // DividendAccount.RESET;
                                    // DividendAccount.SETFILTER("Date Filter", DateFilter);//, '..%1', ToDate);
                                    // DividendAccount.CALCFIELDS("Balance (LCY)");
                                    // GSetup.TESTFIELD("Minimum Div Earning Amount");
                                    //IF DividendAccount."Balance (LCY)" >= ProductFactory."Interest Calc Min Balance" THEN
                                    CreateDividendLines(DividendAccount."No.", TODAY, DividendAccount."Product Type", DividendAccount."Product Name", DividendAccount."Member No.",
                                        QualifyingShares, DividendAccount."Balance (LCY)", GrossDiv, WTaxDiv, NetDiv,
                                        ToDate, CALCDATE('-CM', ToDate), ProductFactory."Dividend Calc. Method", EntrNo, DivPayMode, DividendAccount."Balance (LCY)", TheMember);
                                    ToDate := CALCDATE('1M+CM', ToDate);
                                    FromDate := CALCDATE('-CM', ToDate);
                                    DateFilter := Format(FromDate) + '..' + Format(ToDate);
                                END;
                            end;
                        END;
                END;

            END;
        end;
    end;

    procedure generateProvision(DividendAccount: Record "Savings Accounts"; I: Integer; DocumentNo: Code[20])
    var
        GrossDiv: Decimal;
        WTaxDiv: Decimal;
        NetDiv: Decimal;
        FromDate: Date;
        ToDate: Date;
        EntrNo: Integer;
        diaProgress: Dialog;
        MemberNo: label 'Member No: ';
        MemberName: label 'Name: ';
        intProgress: Integer;
        timProgress: Time;
        intProgressI: Integer;
        intProgressTotal: Integer;
        CustMembr: Record Members;
        SavingsAcc: Record "Savings Accounts";
        GeneratingDividends: label 'Generating Dividend :';
        Counter1: Integer;
        Counter2: Integer;
        GrossDividend: Decimal;
        WeightedShareDep: Decimal;
        MembershipClosure: Record "Membership closure";
        StartDateToFeed: date;
        EndDateToFeed: date;
    begin
        getDividendSetup;

        //Interest On Deposits
        ProductFactory.Reset;
        ProductFactory.SetRange("Product ID", DividendAccount."Product Type");
        ProductFactory.SetRange("Product Class Type", ProductFactory."product class type"::Savings);
        ProductFactory.SetFilter("Dividend Calc. Method", '<>%1', ProductFactory."dividend calc. method"::" ");
        if ProductFactory.FINDFIRST then begin
            IF ProductFactory."Product ID" = DividendAccount."Product Type" THEN BEGIN
                intProgressTotal := DividendAccount.Count;
                YearDateFilter := '..' + Format(EndDate);
                BalanceDateFilter := '..' + FORMAT(CALCDATE('11M+CM', StartDate));
                DividendAccount.SETFILTER("Date Filter", BalanceDateFilter);
                DividendAccount.CALCFIELDS("Balance (LCY)");
                if CustMembr.Get(DividendAccount."Member No.") then begin
                    //if member statuses are closed

                    if (DividendAccount."Balance (LCY)" > 0) then begin
                        case ProductFactory."Dividend Calc. Method" of
                            ProductFactory."dividend calc. method"::"Flat Rate":
                                begin
                                    IF I = 12 THEN BEGIN
                                        DateFilter := '..' + FORMAT(CALCDATE('CM', StartDate));
                                        StartDateToFeed := 0D;
                                        EndDateToFeed := CALCDATE('CM', StartDate);
                                    END ELSE BEGIN
                                        StartDateToFeed := StartDate;
                                        EndDateToFeed := CALCDATE('CM', StartDate);
                                        DateFilter := FORMAT(StartDate) + '..' + FORMAT(CALCDATE('CM', StartDate));
                                    END;

                                    DividendAccount.SetFilter("Date Filter", DateFilter);
                                    DividendAccount.SetFilter("Balance (LCY)", '>0');
                                    DividendAccount.CalcFields("Balance (LCY)");
                                    GrossDiv := (ProductFactory."Interest Rate (Min.)" / 100) * DividendAccount."Balance (LCY)";
                                    WTaxDiv := GrossDiv * (ProductFactory."WithHolding Tax" / 100);
                                    NetDiv := GrossDiv - WTaxDiv;
                                    EntrNo += 1;
                                    if CustMembr.Get(DividendAccount."Member No.") then begin
                                        //DivPayMode := CustMembr."Dividend Payment Method";Method";
                                        //      IF (CustMembr.Status=CustMembr.Status::Closed) AND (CustMembr."Withdrawal Date"<DividendSetUp."Start Date") OR (CustMembr."Withdrawal Date"=0D)
                                        //         OR (CustMembr.Status=CustMembr.Status::Withdrawal) AND (CustMembr."Withdrawal Date"<DividendSetUp."Start Date") OR (CustMembr."Withdrawal Date"=0D)
                                        //        THEN BEGIN
                                        //        GrossDiv:=0;WTaxDiv:=0;NetDiv:=0;
                                        //        END;
                                    end;
                                    CreateDividendProvision(
                                    DividendAccount."No.", Today, DividendAccount."Product Type", DividendAccount."Product Name", DividendAccount."Member No.",
                                    DividendAccount."Balance (LCY)", DividendAccount."Balance (LCY)", GrossDiv, WTaxDiv, NetDiv,
                                    EndDate, StartDate, ProductFactory."Dividend Calc. Method", EntrNo, DivPayMode, I, DocumentNo);
                                end;

                            ProductFactory."dividend calc. method"::Prorated:
                                begin

                                    DividendAccount.CALCFIELDS("Balance (LCY)");
                                    // FOR I := 12 DOWNTO 1 DO BEGIN
                                    GrossDiv := 0;
                                    WeightedShareDep := 0;
                                    WTaxDiv := 0;
                                    NetDiv := 0;
                                    StartDateToFeed := 0D;
                                    EndDateToFeed := 0D;
                                    IF I = 12 THEN BEGIN
                                        DateFilter := '..' + FORMAT(CALCDATE('CM', StartDate));
                                        StartDateToFeed := 0D;
                                        EndDateToFeed := CALCDATE('CM', StartDate);
                                    END ELSE BEGIN
                                        StartDateToFeed := StartDate;
                                        EndDateToFeed := CALCDATE('CM', StartDate);
                                        DateFilter := FORMAT(StartDate) + '..' + FORMAT(CALCDATE('CM', StartDate));
                                    END;

                                    DividendAccount.RESET;
                                    DividendAccount.SETFILTER("Date Filter", DateFilter);
                                    DividendAccount.CALCFIELDS("Balance (LCY)");
                                    GrossDiv := ((ProductFactory."Interest Rate (Min.)" / 100) * DividendAccount."Balance (LCY)") * (I / 12);
                                    WeightedShareDep := ((DividendAccount."Balance (LCY)") * (I / 12));
                                    WTaxDiv := GrossDiv * (ProductFactory."WithHolding Tax" / 100);
                                    NetDiv := GrossDiv - WTaxDiv;
                                    EntrNo += 1;

                                    // IF CustMembr.GET(MemberNo) THEN BEGIN
                                    //     DivPayMode := CustMembr."Dividend Payment Method";
                                    // END;
                                    CreateDividendProvision(DividendAccount."No.", Today, DividendAccount."Product Type", DividendAccount."Product Name", DividendAccount."Member No.",
                                                    DividendAccount."Balance (LCY)", DividendAccount."Balance (LCY)", GrossDiv, WTaxDiv, NetDiv,
                                                    ToDate, FromDate, ProductFactory."Dividend Calc. Method", EntrNo, DivPayMode, I, DocumentNo);





                                    IF I <> 12 THEN
                                        StartDate := CALCDATE('1M', StartDate);
                                END;
                        END;

                    end;
                end;
            end;

        end;
    end;



    procedure CreateDividendLines(AccountNo: Code[20]; ProcessingDate: Date; ProductID: Code[20]; ProductName: Text; MemberNo: Code[20]; QualifyingShares: Decimal; DivShares: Decimal; GrossDiv: Decimal; DivWHoldingTax: Decimal; NetDiv: Decimal; DivEndDate: Date; DivStartDate: Date; DivCalcMethod: Option " ","Flat Rate",Prorated; EntrNo: Integer; PayMode: Code[20]; I: Decimal;
    var TheMember: Record Members)
    var
        // CustMembr: Record Members;
        DivYear: Integer;
    begin
        // TODO: Review this call
        // if CustMembr.Get(MemberNo) then begin
        //** IF CustMembr."Dividend Action"=CustMembr."Dividend Action"::Pay THEN BEGIN
        EntrNo += 1;
        DividendProgression.Init;
        DividendProgression."Entry No." := EntrNo;
        DividendProgression."Account No" := AccountNo;
        DividendProgression."Processing Date" := ProcessingDate;
        DividendProgression."Product Type" := ProductID;
        DividendProgression."Product Name" := PadStr(ProductName, 20);
        DividendProgression."Member No" := MemberNo;
        DividendProgression."Qualifying Shares" := QualifyingShares;
        DividendProgression.Shares := DivShares;
        DividendProgression."Gross Dividends" := GrossDiv;
        DividendProgression."Witholding Tax" := DivWHoldingTax;
        DividendProgression."Net Dividends" := NetDiv;
        DividendProgression."Start Date" := DivStartDate;
        DividendProgression."End Date" := DivEndDate;
        DividendProgression."Dividend Calc. Method" := DivCalcMethod;
        DividendProgression.Month := Date2DMY(DivEndDate, 2);
        DividendProgression."Month Name" := Format(DivEndDate, 0, '<Month Text>');
        DividendProgression."Payment Mode" := PayMode;
        //DividendProgression.Forfeited := ReverseForfeited(TheMember, DivEndDate);
        DividendProgression."Employer Code" := TheMember."Employer Code";
        //DivYear := DATE2DWY(20220101D,3);
        //MESSAGE(FORMAT(DivYear));
        DividendProgression.Year := Date2dmy(StartDate, 3);
        //MESSAGE('StartDate %1, Year %2',StartDate,DividendProgression.Year);
        if DividendProgression."Qualifying Shares" <> 0 then
            DividendProgression.Insert;
        //**END;
        // end;
    end;

    procedure CreateDividendProvision(AccountNo: Code[20]; ProcessingDate: Date; ProductID: Code[20]; ProductName: Text; MemberNo: Code[20]; QualifyingShares: Decimal; DivShares: Decimal; GrossDiv: Decimal; DivWHoldingTax: Decimal; NetDiv: Decimal; DivEndDate: Date; DivStartDate: Date; DivCalcMethod: Option " ","Flat Rate",Prorated; EntrNo: Integer; PayMode: Code[20]; I: Integer; DocumentNo: Code[20])
    var
        CustMembr: Record Members;
        DivYear: Integer;
        DividendProvision: Record "Dividend Provision";
    begin
        if CustMembr.Get(MemberNo) then begin
            //** IF CustMembr."Dividend Action"=CustMembr."Dividend Action"::Pay THEN BEGIN
            EntrNo += 1;
            DividendProvision.Init;
            DividendProvision."Entry No." := EntrNo;
            DividendProvision."Account No" := AccountNo;
            DividendProvision."Processing Date" := ProcessingDate;
            DividendProvision."Product Type" := ProductID;
            DividendProvision."Product Name" := PadStr(ProductName, 20);
            DividendProvision."Member No" := MemberNo;
            DividendProvision."Qualifying Shares" := QualifyingShares;
            DividendProvision.Shares := DivShares;
            DividendProvision."Gross Dividends" := GrossDiv;
            DividendProvision."Witholding Tax" := DivWHoldingTax;
            DividendProvision."Net Dividends" := NetDiv;
            DividendProvision."Start Date" := DividendSetUp."Start Date";
            DividendProvision."End Date" := DivEndDate;
            DividendProvision."Dividend Calc. Method" := DivCalcMethod;
            DividendProvision."Payment Mode" := PayMode;
            DividendProvision.Month := I;
            DividendProvision."Dividends No." := DocumentNo;
            //DivYear := DATE2DWY(20220101D,3);
            //MESSAGE(FORMAT(DivYear));
            DividendProvision.Year := Date2dmy(StartDate, 3);
            //MESSAGE('StartDate %1, Year %2',StartDate,DividendProgression.Year);
            if DividendProvision."Qualifying Shares" <> 0 then
                DividendProvision.Insert;
            //**END;
        end;
    end;


    procedure GenerateDividendPostingEntries(CustMemberNo: Code[20]; PostingOptions: Option All,"BOSA Deposists","Share Capital")
    var
        DividendProgression: Record "Dividend Progression";
        DividendInstructionsMember: Record "Dividend Instructions - Member";
        DividendInstructionsAmount: Decimal;
        SavingsAccounts: Record "Savings Accounts";
        RunBal: Decimal;
        SCapitalDiff: Decimal;
        Dim1: Code[10];
        Dim2: Code[10];
        TopupShares: label 'Topup Share Capital :-';
        DividendEarned: Text;
        DividendDeductions: label 'Dividend Deductions :-';
        LoanInterest: label 'Loan I :-';
        LoanBills: label 'Loan Bill :-';
        LoanPrincipal: label 'Loan P :-';
        LoanApps: Record Loans;
        InterestonLoan: Decimal;
        PrincipalonLoan: Decimal;
        Defaulter: Boolean;
        DividendInstructionsExists: Boolean;
        DividendPostingBuffer: Record "Dividend Posting Buffer";
        EntrNo: Integer;
        CustMembr: Record Members;
        "==": Integer;
        TransactionCharges: Record "Transaction Charges";
        ChargeAmount: Decimal;
        TChargeAmount: Decimal;
        TariffDetails: Record "Tiered Charges Lines";
        GeneralSetUp: Record "General Set-Up";
        TransactionCharge: Text;
        ExciseDuty: label 'Excise Duty :-';
        TCharges: Decimal;
        GeneratepostLines: label 'Create Posting Lines :';
        SavingsAccountNo: Code[50];
        SavingsProductID: Code[10];
        SavingsProductName: Text;
        TotalNetAmount: Decimal;
        SavingsAcc: Record "Savings Accounts";
        CapitaliazeAcc: Code[20];
        DepContAccType: Code[10];
        SharesAccType: Code[10];
        DividendProgression1: Record "Dividend Progression";
        ShareCapAcc: Code[20];
        Pdate: Date;
        Account: record "Savings Accounts";
        AcctNo: Code[20];
        AccNo: Code[20];
        AccType: Enum "Gen. Journal Account Type";
        BalAccType: Enum "Gen. Journal Account Type";
        BalAccNo: Code[20];
        Amt: Decimal;
        Descr: Text;
        Transtype: Enum "Transaction Types";
        Loans: Record Loans;
        Interest: Decimal;
        Principle: Decimal;
        GlobalDim1: Code[20];
        GlobalDim2: Code[20];
        SavProd: Record "Product Factory";
        RecType: Option Loan,Savings;
        Err0001: Label 'Amount must be equal to Total pay';

        BankOfficeSetup: record "Banking No Setup";
        DocNo: Code[20];

        AcctType: Enum "Gen. Journal Account Type";

        ExtDoc: Code[20];
        LoanNo: Code[20];

        SystCreated: Boolean;
        TransAmt: Decimal;
        Description: Text;
        Jtemplate: Code[30];
        JBatch: Code[30];
        Amount: decimal;
        SavingsAcc3: Record "Savings Accounts";
        MembClosure: Record "Membership closure";
        DividendInstructionsReco: Decimal;
        TotRecovDIV: Decimal;
        TotRecovDEF: Decimal;
        IntReco: Decimal;
        loancap: Decimal;
        IntPaid: Decimal;
        Eexciseduty: Decimal;
        PercIncentives: Decimal;
        ForfeitedAmount: Decimal;
        DividendProgressionF: Record "Dividend Progression";
        PFac: Record "Product Factory";
        LoanRecovered: Text;
        Length: Integer;
        MemberClass: Record "Member Classes";
        RequiredShares: Decimal;
        Members: Record Members;
        DocumentNO: Code[20];
        DividendAmount: Decimal;
        RebatesAmount: Decimal;
        TotalExcess: Decimal;
        LoanArr: record Loans;
    begin
        DividendSetUp.get();
        Year := DATE2DMY(today, 3);
        PreviousYear := DATE2DMY(DividendSetUp."End Date", 3);
        DocumentNO := 'DIVPAY_' + Format((PreviousYear));
        DividendAmount := 0;
        RebatesAmount := 0;
        DividendPostingBuffer.RESET;
        IF DividendPostingBuffer.FINDLAST THEN
            EntrNo := DividendPostingBuffer."Entry No.";
        getDividendSetup;
        IF CustMembr.GET(CustMemberNo) THEN BEGIN
            DividendEarned := Format((PreviousYear)) + ' DIVIDEND PAYMENT -';
            TransactionCharge := Format((PreviousYear)) + ' Dividend Processing Fee -';
            GlobalDim1 := CustMembr."Global Dimension 1 Code";
            GlobalDim2 := CustMembr."Global Dimension 2 Code";
            ForfeitedAmount := 0;
            //Identify Loan Defaulter
            GeneralSetUp.GET();
            //Identify Members without Dividend Instructions
            DividendInstructionsExists := FALSE;
            DividendInstructionsMember.RESET;
            DividendInstructionsMember.SETRANGE(DividendInstructionsMember."Member No.", CustMembr."No.");
            DividendInstructionsMember.SETFILTER("Account No.", '<>%1', '');
            DividendInstructionsMember.SETLOADFIELDS("Member No.");
            IF DividendInstructionsMember.FINDFIRST THEN
                DividendInstructionsExists := TRUE; //Identify Members without Dividend Instructions

            SavingsAccounts.RESET;
            SavingsAccounts.SETRANGE(SavingsAccounts."Member No.", CustMembr."No.");
            SavingsAccounts.SetRange("Product Type", 'ODS');
            SavingsAccounts.SETLOADFIELDS("No.", "Product Type", "Product Name");
            IF SavingsAccounts.FINDFIRST THEN BEGIN
                SavingsAccountNo := SavingsAccounts."No.";
                SavingsProductID := SavingsAccounts."Product Type";
                SavingsProductName := SavingsAccounts."Product Name";
            END;

            SavingsAcc.RESET;
            SavingsAcc.SETRANGE("Member No.", CustMembr."No.");
            SavingsAcc.SETRANGE("Product Category", SavingsAcc."Product Category"::"BOSA Deposits");
            SavingsAcc.SETLOADFIELDS("No.");
            IF SavingsAcc.FINDFIRST THEN BEGIN
                CapitaliazeAcc := SavingsAcc."No.";
            END;

            // Get Share Capital Account
            ShareCapAcc := '';
            SavingsAcc.RESET();
            SavingsAcc.SETRANGE("Member No.", CustMembr."No.");
            SavingsAcc.SETRANGE("Product Category", SavingsAcc."Product Category"::"Share Capital");
            SavingsAcc.SETLOADFIELDS("No.", "Product Type");
            IF SavingsAcc.FINDFIRST THEN BEGIN
                SharesAccType := SavingsAcc."Product Type";
                ShareCapAcc := SavingsAcc."No.";
            END;
            IF (SavingsAccountNo = '') THEN SavingsAccountNo := CapitaliazeAcc;//
                                                                               // Member Dividend earned
            DividendAmount := 0;
            RebatesAmount := 0;
            DividendProgression.RESET();
            DividendProgression.SETRANGE(DividendProgression."Member No", CustMembr."No.");
            DividendProgression.SETRANGE(Year, PreviousYear);
            DividendProgression.SETRANGE(Forfeited, false);
            DividendProgression.SETFILTER("Product Type", 'DCS');
            DividendProgression.SETLOADFIELDS("Net Dividends"); // Load only required field
            DividendProgression.CALCSUMS(DividendProgression."Net Dividends");
            RebatesAmount := DividendProgression."Net Dividends";

            DividendProgression.RESET();
            DividendProgression.SETRANGE("Member No", CustMembr."No.");
            DividendProgression.SETRANGE(Year, PreviousYear);
            DividendProgression.SETRANGE(Forfeited, false);
            DividendProgression.SETFILTER("Product Type", 'SCS');
            DividendProgression.SETLOADFIELDS("Net Dividends");
            IF DividendProgression.FINDFIRST THEN BEGIN
                DividendProgression.CALCSUMS(DividendProgression."Net Dividends");
                DividendAmount := DividendProgression."Net Dividends";
            END ELSE
                DividendAmount := 0;

            RunBal := 0;
            Eexciseduty := 0;
            ForfeitedAmount := 0;

            DividendProgression.RESET();
            DividendProgression.SETRANGE("Member No", CustMembr."No.");
            DividendProgression.SETRANGE(Year, PreviousYear);
            DividendProgression.SETRANGE(Forfeited, false);

            // Apply filters based on PostingOptions
            CASE PostingOptions OF
                PostingOptions::"BOSA Deposists":
                    DividendProgression.SETFILTER("Product Type", 'DCS');
                PostingOptions::"Share Capital":
                    DividendProgression.SETRANGE("Product Type", 'SCS');
            END;
            DividendProgression.SETLOADFIELDS("Net Dividends", "Gross Dividends", "Witholding Tax");
            IF DividendProgression.FINDFIRST THEN BEGIN
                DividendProgression.CALCSUMS("Net Dividends", "Gross Dividends", "Witholding Tax");

                RunBal := ROUND(DividendProgression."Net Dividends", 0.01, '=');
                TotalNetAmount := RunBal;
                GrossAmount := ROUND(DividendProgression."Gross Dividends", 0.01, '=');

                IF GrossAmount > 0 THEN BEGIN
                    SHareCapAcc := '';
                    EntrNo += 1;
                    DividendPostingBuffer.INIT;
                    DividendPostingBuffer."Entry No." := EntrNo;
                    DividendPostingBuffer."Posting Date" := TODAY;
                    DividendPostingBuffer."Document No." := DocumentNO;
                    DividendPostingBuffer."Account Type" := DividendPostingBuffer."Account Type"::"G/L Account";
                    DividendPostingBuffer."Account No." := GeneralSetUp."Dividend Payable Account";
                    if PostingOptions = PostingOptions::"BOSA Deposists" then
                        DividendPostingBuffer.Description := PADSTR(Format(PreviousYear) + ' REBATES PAYMENT-' + CustMembr."No.", 50) else
                        DividendPostingBuffer.Description := PADSTR(Format(PreviousYear) + ' DIVIDEND PAYMENT-' + CustMembr."No.", 50);
                    DividendPostingBuffer."Member No." := CustMembr."No.";
                    DividendPostingBuffer.Amount := GrossAmount;
                    DividendPostingBuffer."Debit Amount" := GrossAmount;
                    DividendPostingBuffer."Credit Amount" := 0;
                    DividendPostingBuffer."Product Type Name" := PADSTR(CustMembr.Name, 20);
                    DividendPostingBuffer."Shortcut Dimension 1 Code" := GlobalDim1;
                    DividendPostingBuffer."Shortcut Dimension 2 Code" := GlobalDim2;
                    DividendPostingBuffer.Year := PreviousYear;

                    IF DividendPostingBuffer.Amount <> 0 THEN
                        DividendPostingBuffer.INSERT;
                    //--------------------------------------------------------CAPITALIZE
                    IF (GrossAmount) <= DividendSetUp."Minimum Capitalized" THEN BEGIN
                        // Credit FOSA Acc
                        EntrNo += 1;
                        DividendPostingBuffer.INIT;
                        DividendPostingBuffer."Entry No." := EntrNo;
                        DividendPostingBuffer."Posting Date" := TODAY;
                        DividendPostingBuffer."Document No." := DocumentNO;
                        DividendPostingBuffer."Account Type" := DividendPostingBuffer."Account Type"::Savings;
                        DividendPostingBuffer."Account No." := SavingsAccountNo;
                        if PostingOptions = PostingOptions::"BOSA Deposists" then
                            DividendPostingBuffer.Description := PADSTR(Format(PreviousYear) + ' REBATES PAYMENT <1K ' + CustMembr."No.", 50) else
                            DividendPostingBuffer.Description := PADSTR(Format(PreviousYear) + ' DIVIDEND PAYMENT <1K ' + CustMembr."No.", 50);
                        DividendPostingBuffer."Member No." := CustMembr."No.";
                        DividendPostingBuffer.Amount := -GrossAmount;
                        DividendPostingBuffer."Debit Amount" := 0;
                        DividendPostingBuffer."Credit Amount" := GrossAmount;
                        DividendPostingBuffer."Product Type Name" := PADSTR(CustMembr.Name, 20);
                        DividendPostingBuffer."Shortcut Dimension 1 Code" := GlobalDim1;
                        DividendPostingBuffer."Shortcut Dimension 2 Code" := GlobalDim2;
                        DividendPostingBuffer.Year := PreviousYear;

                        IF DividendPostingBuffer.Amount <> 0 THEN
                            DividendPostingBuffer.INSERT;

                        GrossAmount -= ROUND(DividendProgression."Witholding Tax", 0.01, '=');

                        EntrNo += 1;
                        DividendPostingBuffer.INIT;
                        DividendPostingBuffer."Entry No." := EntrNo;
                        DividendPostingBuffer."Posting Date" := TODAY;
                        DividendPostingBuffer."Document No." := DocumentNO;
                        DividendPostingBuffer."Account Type" := DividendPostingBuffer."Account Type"::Savings;
                        DividendPostingBuffer."Account No." := CapitaliazeAcc;
                        if PostingOptions = PostingOptions::"BOSA Deposists" then
                            DividendPostingBuffer.Description := PADSTR(Format(PreviousYear) + ' REBATES PAYMENT <1K ' + CustMembr."No.", 50) else
                            DividendPostingBuffer.Description := PADSTR(Format(PreviousYear) + ' DIVIDEND PAYMENT <1K ' + CustMembr."No.", 50);
                        DividendPostingBuffer."Member No." := CustMembr."No.";
                        DividendPostingBuffer.Amount := -GrossAmount;//ROUND(DividendProgression."Gross Dividends",0.01,'=');
                        DividendPostingBuffer."Debit Amount" := 0;//ROUND(DividendPostingBuffer.Amount,0.01,'=');
                        DividendPostingBuffer."Credit Amount" := GrossAmount;
                        DividendPostingBuffer."Product Type Name" := PADSTR(CustMembr.Name, 20);
                        DividendPostingBuffer."Shortcut Dimension 1 Code" := GlobalDim1;
                        DividendPostingBuffer."Shortcut Dimension 2 Code" := GlobalDim2;
                        DividendPostingBuffer.Year := PreviousYear;
                        IF DividendPostingBuffer.Amount <> 0 THEN
                            DividendPostingBuffer.INSERT;

                        EntrNo += 1;
                        DividendPostingBuffer.INIT;
                        DividendPostingBuffer."Entry No." := EntrNo;
                        DividendPostingBuffer."Posting Date" := TODAY;
                        DividendPostingBuffer."Document No." := DocumentNO;
                        DividendPostingBuffer."Account Type" := DividendPostingBuffer."Account Type"::Savings;
                        DividendPostingBuffer."Account No." := SavingsAccountNo;
                        if PostingOptions = PostingOptions::"BOSA Deposists" then
                            DividendPostingBuffer.Description := PADSTR(Format(PreviousYear) + ' REBATES PAYMENT <1K ' + CustMembr."No.", 50) else
                            DividendPostingBuffer.Description := PADSTR(Format(PreviousYear) + ' DIVIDEND PAYMENT <1K ' + CustMembr."No.", 50);
                        // DividendPostingBuffer.Description := PADSTR(Format(PreviousYear) + ' DIVIDEND PAYMENT <1K ' + CustMembr."No.", 50);
                        DividendPostingBuffer."Member No." := CustMembr."No.";
                        DividendPostingBuffer.Amount := GrossAmount;//ROUND(DividendProgression."Gross Dividends",0.01,'=');
                        DividendPostingBuffer."Debit Amount" := GrossAmount;//ROUND(DividendPostingBuffer.Amount,0.01,'=');
                        DividendPostingBuffer."Credit Amount" := 0;
                        DividendPostingBuffer."Product Type Name" := PADSTR(CustMembr.Name, 20);
                        DividendPostingBuffer."Shortcut Dimension 1 Code" := GlobalDim1;
                        DividendPostingBuffer."Shortcut Dimension 2 Code" := GlobalDim2;
                        DividendPostingBuffer.Year := PreviousYear;
                        IF DividendPostingBuffer.Amount <> 0 THEN
                            DividendPostingBuffer.INSERT;

                        GrossAmount -= ABS(DividendPostingBuffer.Amount);

                        //--------------------------------------------------------CAPITALIZE

                    END ELSE BEGIN
                        if DividendSetUp."Transaction Type" <> '' then begin
                            ChargeAmount := 0;
                            TransactionCharges.RESET;
                            TransactionCharges.SETRANGE(TransactionCharges."Transaction Type", DividendSetUp."Transaction Type");
                            IF TransactionCharges.FindFirst() THEN BEGIN
                                REPEAT
                                    IF TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::"% of Amount" THEN
                                        ChargeAmount += (GrossAmount * TransactionCharges."Percentage of Amount") * 0.01
                                    ELSE
                                        ChargeAmount += TransactionCharges."Charge Amount";

                                    IF TransactionCharges."Charge Type" = TransactionCharges."Charge Type"::Staggered THEN BEGIN
                                        TransactionCharges.TESTFIELD(TransactionCharges."Staggered Charge Code");
                                        TariffDetails.RESET;
                                        TariffDetails.SETRANGE(TariffDetails.Code, TransactionCharges."Staggered Charge Code");
                                        IF TariffDetails.FIND('-') THEN BEGIN
                                            REPEAT
                                                IF (GrossAmount >= TariffDetails."Lower Limit") AND (GrossAmount <= TariffDetails."Upper Limit") THEN BEGIN
                                                    IF TariffDetails."Use Percentage" THEN
                                                        ChargeAmount += GrossAmount * TariffDetails.Percentage * 0.01
                                                    ELSE
                                                        ChargeAmount += TariffDetails."Charge Amount";
                                                END;
                                            UNTIL TariffDetails.NEXT = 0;
                                        END;
                                    END;
                                UNTIL TransactionCharges.NEXT = 0;
                                TCharges := ChargeAmount;
                            END;
                        end; //-----OTHER MEMBERS CAPITALIZING 

                    END; //Member Dividend earned

                    //++++++++++++++++++++Charges
                    GeneralSetUp.Get();
                    Eexciseduty := GeneralSetUp."Excise Duty (%)" * TCharges * 0.01;
                    IF (GrossAmount - DividendProgression."Witholding Tax") > DividendSetUp."Minimum Capitalized" THEN BEGIN
                        EntrNo += 1;
                        DividendPostingBuffer.INIT;
                        DividendPostingBuffer."Entry No." := EntrNo;
                        DividendPostingBuffer."Posting Date" := TODAY;
                        DividendPostingBuffer."Document No." := DocumentNO;
                        DividendPostingBuffer."Account Type" := DividendPostingBuffer."Account Type"::Savings;
                        DividendPostingBuffer."Account No." := SavingsAccountNo;
                        if PostingOptions = PostingOptions::"BOSA Deposists" then
                            DividendPostingBuffer.Description := PADSTR('REBATES ' + DividendEarned + CustMembr."No.", 50) else
                            //DividendPostingBuffer.Description := PADSTR(Format(PreviousYear) + ' DIVIDEND PAYMENT <1K ' + CustMembr."No.", 50);
                        DividendPostingBuffer.Description := PADSTR(DividendEarned + CustMembr."No.", 50);
                        DividendPostingBuffer."Member No." := CustMembr."No.";
                        DividendPostingBuffer.Amount := -(GrossAmount - DividendInstructionsReco);
                        DividendPostingBuffer."Debit Amount" := 0;
                        DividendPostingBuffer."Credit Amount" := GrossAmount;
                        DividendPostingBuffer."Loan No" := '';
                        DividendPostingBuffer."Product Type" := SavingsProductID;
                        DividendPostingBuffer."Product Type Name" := PADSTR(SavingsProductName, 20);
                        DividendPostingBuffer."Shortcut Dimension 1 Code" := GlobalDim1;
                        DividendPostingBuffer."Shortcut Dimension 2 Code" := GlobalDim2;
                        DividendPostingBuffer.Year := PreviousYear;
                        IF DividendPostingBuffer.Amount <> 0 THEN
                            DividendPostingBuffer.INSERT;

                        EntrNo += 1;
                        DividendPostingBuffer.INIT;
                        DividendPostingBuffer."Entry No." := EntrNo;
                        DividendPostingBuffer."Posting Date" := TODAY;
                        DividendPostingBuffer."Document No." := DocumentNO;
                        DividendPostingBuffer."Account Type" := DividendPostingBuffer."Account Type"::"G/L Account";
                        DividendPostingBuffer."Account No." := GeneralSetUp."Withholding Tax Account";
                        if PostingOptions = PostingOptions::"BOSA Deposists" then
                            DividendPostingBuffer.Description := PADSTR('REBATES' + ' Withholding Tax - 5% -' + CustMembr."No.", 50) else
                            //DividendPostingBuffer.Description := PADSTR('Withholding Tax - 5% -' + CustMembr."No.", 50);
                        DividendPostingBuffer.Description := PADSTR('Withholding Tax - 5% -' + CustMembr."No.", 50); //*
                        DividendPostingBuffer."Member No." := CustMembr."No.";
                        DividendPostingBuffer.Amount := -ROUND(DividendProgression."Witholding Tax", 0.01, '=');
                        DividendPostingBuffer."Debit Amount" := 0;
                        DividendPostingBuffer."Credit Amount" := ROUND(DividendProgression."Witholding Tax", 0.01, '=');
                        DividendPostingBuffer."Product Type Name" := PADSTR(CustMembr.Name, 20);
                        DividendPostingBuffer."Shortcut Dimension 1 Code" := GlobalDim1;
                        DividendPostingBuffer."Shortcut Dimension 2 Code" := GlobalDim2;
                        DividendPostingBuffer.Year := PreviousYear;
                        IF DividendPostingBuffer.Amount <> 0 THEN
                            DividendPostingBuffer.INSERT;

                        //FOSA Withholding Tax
                        EntrNo += 1;
                        DividendPostingBuffer.INIT;
                        DividendPostingBuffer."Entry No." := EntrNo;
                        DividendPostingBuffer."Posting Date" := TODAY;
                        DividendPostingBuffer."Document No." := DocumentNO;
                        DividendPostingBuffer."Account Type" := DividendPostingBuffer."Account Type"::Savings;
                        DividendPostingBuffer."Account No." := SavingsAccountNo;
                        DividendPostingBuffer."Product Type" := SavingsProductID;
                        if PostingOptions = PostingOptions::"BOSA Deposists" then
                            DividendPostingBuffer.Description := PADSTR('REBATES Withholding Tax - 5% -' + CustMembr."No.", 50) else
                            DividendPostingBuffer.Description := PADSTR('Withholding Tax - 5% -' + CustMembr."No.", 50); //*
                        DividendPostingBuffer."Member No." := CustMembr."No.";
                        DividendPostingBuffer.Amount := ROUND(DividendProgression."Witholding Tax", 0.01, '=');
                        DividendPostingBuffer."Debit Amount" := ROUND(DividendProgression."Witholding Tax", 0.01, '=');
                        DividendPostingBuffer."Credit Amount" := 0;
                        DividendPostingBuffer."Product Type Name" := PADSTR(CustMembr.Name, 20);
                        DividendPostingBuffer."Shortcut Dimension 1 Code" := GlobalDim1;
                        DividendPostingBuffer."Shortcut Dimension 2 Code" := GlobalDim2;
                        DividendPostingBuffer.Year := PreviousYear;
                        IF DividendPostingBuffer.Amount <> 0 THEN
                            DividendPostingBuffer.INSERT;
                        //Debit Charges
                        EntrNo += 1;
                        DividendPostingBuffer.INIT;
                        DividendPostingBuffer."Entry No." := EntrNo;
                        DividendPostingBuffer."Posting Date" := TODAY;
                        DividendPostingBuffer."Document No." := DocumentNO;
                        DividendPostingBuffer."Account Type" := DividendPostingBuffer."Account Type"::Savings;
                        DividendPostingBuffer."Account No." := SavingsAccountNo;
                        if PostingOptions = PostingOptions::"BOSA Deposists" then
                            DividendPostingBuffer.Description := PADSTR('REBATES ' + TransactionCharge + CustMembr."No.", 50) else
                            DividendPostingBuffer.Description := PADSTR(TransactionCharge + CustMembr."No.", 50);
                        DividendPostingBuffer."Member No." := CustMembr."No.";
                        DividendPostingBuffer.Amount := TCharges;
                        DividendPostingBuffer."Debit Amount" := TCharges;
                        DividendPostingBuffer."Credit Amount" := 0;
                        DividendPostingBuffer."Loan No" := '';
                        DividendPostingBuffer."Product Type" := SavingsProductID;
                        DividendPostingBuffer."Product Type Name" := PADSTR(SavingsProductName, 20);
                        DividendPostingBuffer."Shortcut Dimension 1 Code" := GlobalDim1;
                        DividendPostingBuffer."Shortcut Dimension 2 Code" := GlobalDim2;
                        DividendPostingBuffer."Bal. Account Type" := DividendPostingBuffer."Bal. Account Type"::"G/L Account";
                        DividendPostingBuffer."Bal. Account No." := TransactionCharges."G/L Account";
                        DividendPostingBuffer.Year := PreviousYear;
                        IF DividendPostingBuffer.Amount <> 0 THEN
                            DividendPostingBuffer.INSERT;
                        RunBal -= ABS(TCharges);

                        EntrNo += 1;
                        DividendPostingBuffer.INIT;
                        DividendPostingBuffer."Entry No." := EntrNo;
                        DividendPostingBuffer."Posting Date" := TODAY;
                        DividendPostingBuffer."Document No." := DocumentNO;
                        DividendPostingBuffer."Account Type" := DividendPostingBuffer."Account Type"::Savings;
                        DividendPostingBuffer."Account No." := SavingsAccountNo;
                        if PostingOptions = PostingOptions::"BOSA Deposists" then
                            DividendPostingBuffer.Description := PADSTR('REBATES ' + TransactionCharge + 'Excise Duty ' + CustMembr."No.", 50) else
                            DividendPostingBuffer.Description := PADSTR(TransactionCharge + 'Excise Duty ' + CustMembr."No.", 50);
                        DividendPostingBuffer."Member No." := CustMembr."No.";
                        DividendPostingBuffer.Amount := Eexciseduty;
                        DividendPostingBuffer."Debit Amount" := Eexciseduty;
                        DividendPostingBuffer."Credit Amount" := 0;
                        DividendPostingBuffer."Loan No" := '';
                        DividendPostingBuffer."Product Type" := SavingsProductID;
                        DividendPostingBuffer."Product Type Name" := PADSTR(SavingsProductName, 20);
                        DividendPostingBuffer."Shortcut Dimension 1 Code" := GlobalDim1;
                        DividendPostingBuffer."Shortcut Dimension 2 Code" := GlobalDim2;
                        DividendPostingBuffer."Bal. Account Type" := DividendPostingBuffer."Bal. Account Type"::"G/L Account";
                        DividendPostingBuffer."Bal. Account No." := GeneralSetUp."Excise Duty G/L";
                        DividendPostingBuffer.Year := PreviousYear;
                        IF DividendPostingBuffer.Amount <> 0 THEN
                            DividendPostingBuffer.INSERT;
                        RunBal -= ABS(Eexciseduty);
                    END;

                    //New Deve
                    // IF (GrossAmount - (TCharges + Eexciseduty)) <= DividendSetUp."Minimum Capitalized" THEN BEGIN
                    IF (GrossAmount - DividendProgression."Witholding Tax") <= DividendSetUp."Minimum Capitalized" THEN BEGIN
                        EntrNo += 1;
                        DividendPostingBuffer.INIT;
                        DividendPostingBuffer."Entry No." := EntrNo;
                        DividendPostingBuffer."Posting Date" := TODAY;
                        DividendPostingBuffer."Document No." := DocumentNO;
                        DividendPostingBuffer."Account Type" := DividendPostingBuffer."Account Type"::Savings;
                        DividendPostingBuffer."Account No." := SavingsAccountNo;
                        if PostingOptions = PostingOptions::"BOSA Deposists" then
                            DividendPostingBuffer.Description := PADSTR('REBATES ' + DividendEarned + CustMembr."No.", 50) else
                            DividendPostingBuffer.Description := PADSTR(DividendEarned + CustMembr."No.", 50);
                        DividendPostingBuffer."Member No." := CustMembr."No.";
                        DividendPostingBuffer.Amount := -(GrossAmount - DividendInstructionsReco);
                        DividendPostingBuffer."Debit Amount" := 0;
                        DividendPostingBuffer."Credit Amount" := GrossAmount;
                        DividendPostingBuffer."Loan No" := '';
                        DividendPostingBuffer."Product Type" := SavingsProductID;
                        DividendPostingBuffer."Product Type Name" := PADSTR(SavingsProductName, 20);
                        DividendPostingBuffer."Shortcut Dimension 1 Code" := GlobalDim1;
                        DividendPostingBuffer."Shortcut Dimension 2 Code" := GlobalDim2;
                        DividendPostingBuffer.Year := PreviousYear;
                        IF DividendPostingBuffer.Amount <> 0 THEN
                            DividendPostingBuffer.INSERT;

                        //Withholding Tax
                        EntrNo += 1;
                        DividendPostingBuffer.INIT;
                        DividendPostingBuffer."Entry No." := EntrNo;
                        DividendPostingBuffer."Posting Date" := TODAY;
                        DividendPostingBuffer."Document No." := DocumentNO;
                        DividendPostingBuffer."Account Type" := DividendPostingBuffer."Account Type"::"G/L Account";
                        DividendPostingBuffer."Account No." := GeneralSetUp."Withholding Tax Account";
                        if PostingOptions = PostingOptions::"BOSA Deposists" then
                            DividendPostingBuffer.Description := PADSTR('REBATES ' + 'Withholding Tax - 5% -' + CustMembr."No.", 50) else
                            DividendPostingBuffer.Description := PADSTR('Withholding Tax - 5% -' + CustMembr."No.", 50); //*
                        DividendPostingBuffer."Member No." := CustMembr."No.";
                        DividendPostingBuffer.Amount := -ROUND(DividendProgression."Witholding Tax", 0.01, '=');
                        DividendPostingBuffer."Debit Amount" := 0;
                        DividendPostingBuffer."Credit Amount" := ROUND(DividendProgression."Witholding Tax", 0.01, '=');
                        DividendPostingBuffer."Product Type Name" := PADSTR(CustMembr.Name, 20);
                        DividendPostingBuffer."Shortcut Dimension 1 Code" := GlobalDim1;
                        DividendPostingBuffer."Shortcut Dimension 2 Code" := GlobalDim2;
                        DividendPostingBuffer.Year := PreviousYear;
                        IF DividendPostingBuffer.Amount <> 0 THEN
                            DividendPostingBuffer.INSERT;

                        //FOSA Withholding Tax
                        EntrNo += 1;
                        DividendPostingBuffer.INIT;
                        DividendPostingBuffer."Entry No." := EntrNo;
                        DividendPostingBuffer."Posting Date" := TODAY;
                        DividendPostingBuffer."Document No." := DocumentNO;
                        DividendPostingBuffer."Account Type" := DividendPostingBuffer."Account Type"::Savings;
                        DividendPostingBuffer."Account No." := SavingsAccountNo;
                        DividendPostingBuffer."Product Type" := SavingsProductID;
                        if PostingOptions = PostingOptions::"BOSA Deposists" then
                            DividendPostingBuffer.Description := PADSTR('REBATES ' + 'Withholding Tax - 5% -' + CustMembr."No.", 50) else
                            DividendPostingBuffer.Description := PADSTR('Withholding Tax - 5% -' + CustMembr."No.", 50); //*
                        DividendPostingBuffer."Member No." := CustMembr."No.";
                        DividendPostingBuffer.Amount := ROUND(DividendProgression."Witholding Tax", 0.01, '=');
                        DividendPostingBuffer."Debit Amount" := ROUND(DividendProgression."Witholding Tax", 0.01, '=');
                        DividendPostingBuffer."Credit Amount" := 0;
                        DividendPostingBuffer."Product Type Name" := PADSTR(CustMembr.Name, 20);
                        DividendPostingBuffer."Shortcut Dimension 1 Code" := GlobalDim1;
                        DividendPostingBuffer."Shortcut Dimension 2 Code" := GlobalDim2;
                        DividendPostingBuffer.Year := PreviousYear;
                        IF DividendPostingBuffer.Amount <> 0 THEN
                            DividendPostingBuffer.INSERT;
                        //End of witholding Tax


                        EntrNo += 1;
                        DividendPostingBuffer.INIT;
                        DividendPostingBuffer."Entry No." := EntrNo;
                        DividendPostingBuffer."Posting Date" := TODAY;
                        DividendPostingBuffer."Document No." := DocumentNO;
                        DividendPostingBuffer."Account Type" := DividendPostingBuffer."Account Type"::Savings;
                        DividendPostingBuffer."Account No." := SavingsAccountNo;
                        if PostingOptions = PostingOptions::"BOSA Deposists" then
                            DividendPostingBuffer.Description := PADSTR('REBATES ' + TransactionCharge + ' ' + CustMembr."No.", 50) else
                            DividendPostingBuffer.Description := PADSTR(TransactionCharge + ' ' + CustMembr."No.", 50);
                        DividendPostingBuffer."Member No." := CustMembr."No.";
                        DividendPostingBuffer.Amount := TCharges;
                        DividendPostingBuffer."Debit Amount" := TCharges;
                        DividendPostingBuffer."Credit Amount" := 0;
                        DividendPostingBuffer."Loan No" := '';
                        DividendPostingBuffer."Product Type" := SavingsProductID;
                        DividendPostingBuffer."Product Type Name" := PADSTR(SavingsProductName, 20);
                        DividendPostingBuffer."Shortcut Dimension 1 Code" := GlobalDim1;
                        DividendPostingBuffer."Shortcut Dimension 2 Code" := GlobalDim2;
                        DividendPostingBuffer."Bal. Account Type" := DividendPostingBuffer."Bal. Account Type"::"G/L Account";
                        DividendPostingBuffer."Bal. Account No." := TransactionCharges."G/L Account";
                        DividendPostingBuffer.Year := PreviousYear;
                        IF DividendPostingBuffer.Amount <> 0 THEN
                            DividendPostingBuffer.INSERT;
                        RunBal -= ABS(TCharges);

                        //Excise Duty
                        EntrNo += 1;
                        DividendPostingBuffer.INIT;
                        DividendPostingBuffer."Entry No." := EntrNo;
                        DividendPostingBuffer."Posting Date" := TODAY;
                        DividendPostingBuffer."Document No." := DocumentNO;
                        DividendPostingBuffer."Account Type" := DividendPostingBuffer."Account Type"::Savings;
                        DividendPostingBuffer."Account No." := SavingsAccountNo;
                        if PostingOptions = PostingOptions::"BOSA Deposists" then
                            DividendPostingBuffer.Description := PADSTR('REBATES ' + TransactionCharge + 'Excise Duty ' + CustMembr."No.", 50) else
                            DividendPostingBuffer.Description := PADSTR(TransactionCharge + 'Excise Duty ' + CustMembr."No.", 50);
                        DividendPostingBuffer."Member No." := CustMembr."No.";
                        DividendPostingBuffer.Amount := Eexciseduty;
                        DividendPostingBuffer."Debit Amount" := Eexciseduty;
                        DividendPostingBuffer."Credit Amount" := 0;
                        DividendPostingBuffer."Loan No" := '';
                        DividendPostingBuffer."Product Type" := SavingsProductID;
                        DividendPostingBuffer."Product Type Name" := PADSTR(SavingsProductName, 20);
                        DividendPostingBuffer."Shortcut Dimension 1 Code" := GlobalDim1;
                        DividendPostingBuffer."Shortcut Dimension 2 Code" := GlobalDim2;
                        DividendPostingBuffer."Bal. Account Type" := DividendPostingBuffer."Bal. Account Type"::"G/L Account";
                        DividendPostingBuffer."Bal. Account No." := TransactionCharges."G/L Account";
                        DividendPostingBuffer.Year := PreviousYear;
                        IF DividendPostingBuffer.Amount <> 0 THEN
                            DividendPostingBuffer.INSERT;
                        RunBal -= ABS(Eexciseduty);
                    END else begin

                        TotRecovDIV := 0;
                        //++++++++++++++++++++++++++++++++++++++++++++++++Dividend Loan
                        LoanRecovered := '';
                        LoanApps.RESET();
                        LoanApps.SETRANGE("Member No.", CustMembr."No.");
                        LoanApps.SETRANGE("Recovery Mode", LoanApps."Recovery Mode"::Dividend);
                        LoanApps.SETFILTER("Total Balance", '>0');
                        LoanApps.SETLOADFIELDS("Loan No.", "Outstanding Interest", "Outstanding Balance", "Loan Account", "Loan Product Type", "Loan Product Type Name");
                        LoanApps.SETAUTOCALCFIELDS("Outstanding Interest", "Outstanding Balance");
                        IF LoanApps.FINDSET THEN BEGIN
                            REPEAT
                                IF LoanApps."Outstanding Interest" > 0 THEN BEGIN
                                    EntrNo += 1;
                                    DividendPostingBuffer.INIT;
                                    DividendPostingBuffer."Entry No." := EntrNo;
                                    DividendPostingBuffer."Posting Date" := TODAY;
                                    DividendPostingBuffer."Document No." := DocumentNO;
                                    DividendPostingBuffer."Account Type" := DividendPostingBuffer."Account Type"::Credit;
                                    DividendPostingBuffer."Account No." := LoanApps."Loan Account";
                                    DividendPostingBuffer.Description := PADSTR(LoanInterest + ' ' + SavingsAccounts."No." + ' LNo:' + LoanApps."Loan No.", 50); //*
                                    DividendPostingBuffer."Member No." := CustMembr."No.";
                                    IF RunBal > LoanApps."Outstanding Interest" THEN
                                        DividendPostingBuffer.Amount := -ROUND(LoanApps."Outstanding Interest", 0.01, '=')
                                    ELSE
                                        DividendPostingBuffer.Amount := -RunBal;
                                    DividendPostingBuffer."Debit Amount" := 0;
                                    DividendPostingBuffer."Credit Amount" := ABS(DividendPostingBuffer.Amount);//-GrossAmount;//ROUND(DividendPostingBuffer.Amount,0.01,'=');
                                    DividendPostingBuffer."Loan No" := LoanApps."Loan No.";
                                    DividendPostingBuffer."Transaction Type" := DividendPostingBuffer."Transaction Type"::"Interest Paid";
                                    DividendPostingBuffer."Product Type" := LoanApps."Loan Product Type";
                                    DividendPostingBuffer."Product Type Name" := PADSTR(LoanApps."Loan Product Type Name", 20);
                                    DividendPostingBuffer."Shortcut Dimension 1 Code" := GlobalDim1;
                                    DividendPostingBuffer."Shortcut Dimension 2 Code" := GlobalDim2;
                                    DividendPostingBuffer.Year := PreviousYear;
                                    IF DividendPostingBuffer.Amount <> 0 THEN
                                        DividendPostingBuffer.INSERT;
                                    RunBal -= ROUND(ABS(DividendPostingBuffer.Amount), 0.01, '=');
                                    TotRecovDIV += ROUND(ABS(DividendPostingBuffer.Amount), 0.01, '=');
                                    //GrossAmount-=ROUND(ABS(DividendPostingBuffer.Amount),0.01,'=');
                                END;

                                IF LoanApps."Outstanding Balance" > 0 THEN BEGIN

                                    EntrNo += 1;
                                    DividendPostingBuffer.INIT;
                                    DividendPostingBuffer."Entry No." := EntrNo;
                                    DividendPostingBuffer."Posting Date" := TODAY;
                                    DividendPostingBuffer."Document No." := DocumentNO;
                                    DividendPostingBuffer."Account Type" := DividendPostingBuffer."Account Type"::Credit;
                                    DividendPostingBuffer."Account No." := LoanApps."Loan Account";
                                    DividendPostingBuffer.Description := PADSTR(LoanPrincipal + ' ' + SavingsAccounts."No." + ' LNo:' + LoanApps."Loan No.", 50); //*
                                    DividendPostingBuffer."Member No." := CustMembr."No.";
                                    IF RunBal > LoanApps."Outstanding Balance" THEN
                                        DividendPostingBuffer.Amount := -ROUND(LoanApps."Outstanding Balance", 0.01, '=')
                                    ELSE
                                        DividendPostingBuffer.Amount := -RunBal;
                                    DividendPostingBuffer."Debit Amount" := 0;
                                    DividendPostingBuffer."Credit Amount" := ABS(DividendPostingBuffer.Amount);//-GrossAmount;//ROUND(DividendPostingBuffer.Amount,0.01,'=');
                                    DividendPostingBuffer."Loan No" := LoanApps."Loan No.";
                                    DividendPostingBuffer."Transaction Type" := DividendPostingBuffer."Transaction Type"::Repayment;
                                    DividendPostingBuffer."Product Type" := LoanApps."Loan Product Type";
                                    DividendPostingBuffer."Shortcut Dimension 1 Code" := GlobalDim1;
                                    DividendPostingBuffer."Shortcut Dimension 2 Code" := GlobalDim2;
                                    DividendPostingBuffer.Year := PreviousYear;
                                    IF DividendPostingBuffer.Amount <> 0 THEN
                                        DividendPostingBuffer.INSERT;

                                    RunBal -= ABS(DividendPostingBuffer.Amount);
                                    TotRecovDIV += ROUND(ABS(DividendPostingBuffer.Amount), 0.01, '=');
                                    //GrossAmount-=ABS(DividendPostingBuffer.Amount);
                                END;
                                LoanRecovered := LoanApps."Loan No." + ' ,';
                            UNTIL LoanApps.NEXT = 0;

                            if LoanRecovered <> '' then begin
                                Length := StrLen(LoanRecovered);
                                if (Length > 0) and (CopyStr(LoanRecovered, Length, 1) = ',') then
                                    LoanRecovered := CopyStr(LoanRecovered, 1, Length - 1);
                            end;

                            //Div Loan Recovery from FOSA Account
                            EntrNo += 1;
                            DividendPostingBuffer.INIT;
                            DividendPostingBuffer."Entry No." := EntrNo;
                            DividendPostingBuffer."Posting Date" := TODAY;
                            DividendPostingBuffer."Document No." := DocumentNO;
                            DividendPostingBuffer."Account Type" := DividendPostingBuffer."Account Type"::Savings;
                            DividendPostingBuffer."Account No." := SavingsAccountNo;
                            DividendPostingBuffer.Description := CopyStr(('Advance on Rebates Recovery ' + LoanRecovered), 1, 50);//PADSTR(TransactionCharge + CustMembr."No."+'-'+CustMembr.Name,50);
                            DividendPostingBuffer."Member No." := CustMembr."No.";
                            DividendPostingBuffer.Amount := TotRecovDIV;
                            DividendPostingBuffer."Debit Amount" := TotRecovDIV;
                            DividendPostingBuffer."Credit Amount" := 0;
                            DividendPostingBuffer."Loan No" := '';
                            DividendPostingBuffer."Product Type" := SavingsProductID;
                            DividendPostingBuffer."Product Type Name" := PADSTR(SavingsProductName, 20);
                            DividendPostingBuffer."Shortcut Dimension 1 Code" := GlobalDim1;
                            DividendPostingBuffer."Shortcut Dimension 2 Code" := GlobalDim2;
                            //DividendPostingBuffer."Bal. Account Type":=DividendPostingBuffer."Bal. Account Type"::"G/L Account";
                            //DividendPostingBuffer."Bal. Account No.":=TransactionCharges."G/L Account";
                            DividendPostingBuffer.Year := PreviousYear;
                            IF DividendPostingBuffer.Amount <> 0 THEN
                                DividendPostingBuffer.INSERT;
                            //Div Loan Recovery from Prime
                        END;//End Dividend Loan
                        TotRecovDEF := 0;
                        //IF Defaulter=TRUE THEN BEGIN      
                        IF DividendSetUp."Defaulter Recovery" THEN BEGIN
                            //START OF LOANS
                            //Calc Arr
                            LoanArr.Reset();
                            LoanArr.SetFilter("Loan Product Type", '<>FGL&<>BGL');
                            LoanArr.SetRange("Member No.", CustMembr."No.");
                            LoanArr.CalcFields("Total Balance");
                            LoanArr.SetFilter("Total Balance", '>0');
                            if LoanArr.FindSet() then begin
                                repeat
                                    loansProcess.CalculateLoanArrears(LoanArr, LoanArr."Amount In Arreas SACCO", LoanArr."Amount In Arreas SASRA", Today, true);
                                until LoanArr.next = 0;
                            end;

                            LoanRecovered := '';
                            PFac.RESET();
                            PFac.SETRANGE("Product Class Type", PFac."Product Class Type"::Loan);
                            PFac.SetFilter("Product ID", '<>BGL&<>FGL');
                            //PFac.SETRANGE("Excempt from Div. recovery", false);
                            PFac.SETCURRENTKEY("Recovery Priority", "Source Unit");
                            IF PFac.FINDFIRST THEN BEGIN
                                REPEAT
                                    LoanApps.RESET();
                                    LoanApps.SETRANGE("Member No.", CustMembr."No.");
                                    LoanApps.SETRANGE("Loan Product Type", PFac."Product ID");
                                    LoanApps.SETFILTER("Recovery Mode", '<>%1', LoanApps."Recovery Mode"::Dividend);
                                    LoanApps.SETFILTER("Total Balance", '>0');
                                    LoanApps.SetFilter("Amount In Arreas SACCO", '>0');
                                    LoanApps.SETCURRENTKEY("Loans Category-SASRA", "Source Unit", "Recovery Priority");
                                    LoanApps.SETASCENDING("Loans Category-SASRA", false);
                                    IF LoanApps.FINDFIRST THEN BEGIN
                                        REPEAT
                                            LoanApps.CalcFields(LoanApps."Outstanding Interest", LoanApps."Outstanding Balance", LoanApps."Loans Category-SASRA", "Amount In Arreas SACCO");
                                            if LoanApps."Outstanding Interest" > 0 then begin
                                                IntReco := 0;
                                                EntrNo += 1;
                                                DividendPostingBuffer.INIT;
                                                DividendPostingBuffer."Entry No." := EntrNo;
                                                DividendPostingBuffer."Posting Date" := TODAY;
                                                DividendPostingBuffer."Document No." := DocumentNO;
                                                DividendPostingBuffer."Account Type" := DividendPostingBuffer."Account Type"::Credit;
                                                DividendPostingBuffer."Account No." := LoanApps."Loan Account";
                                                DividendPostingBuffer.Description := PADSTR(LoanInterest + ' DFTL ' + SavingsAccounts."No." + ' LNo:' + LoanApps."Loan No.", 50); //*
                                                DividendPostingBuffer."Member No." := CustMembr."No.";
                                                IF RunBal > LoanApps."Outstanding Interest" THEN
                                                    DividendPostingBuffer.Amount := -ROUND(LoanApps."Outstanding Interest", 0.01, '=')
                                                ELSE
                                                    DividendPostingBuffer.Amount := -RunBal;//ROUND(RunBal,0.01,'=');
                                                DividendPostingBuffer."Debit Amount" := 0;
                                                DividendPostingBuffer."Credit Amount" := ABS(DividendPostingBuffer.Amount);
                                                DividendPostingBuffer."Loan No" := LoanApps."Loan No.";
                                                DividendPostingBuffer."Transaction Type" := DividendPostingBuffer."Transaction Type"::"Interest Paid";
                                                DividendPostingBuffer."Product Type" := LoanApps."Loan Product Type";
                                                DividendPostingBuffer."Product Type Name" := PADSTR(LoanApps."Loan Product Type Name", 20);
                                                DividendPostingBuffer."Shortcut Dimension 1 Code" := GlobalDim1;
                                                DividendPostingBuffer."Shortcut Dimension 2 Code" := GlobalDim2;
                                                DividendPostingBuffer.Year := PreviousYear;
                                                IF DividendPostingBuffer.Amount <> 0 THEN
                                                    DividendPostingBuffer.INSERT;



                                                RunBal -= ROUND(ABS(DividendPostingBuffer.Amount), 0.01, '=');
                                                IntReco += ROUND(ABS(DividendPostingBuffer.Amount), 0.01, '=');
                                                TotRecovDEF += ROUND(ABS(DividendPostingBuffer.Amount), 0.01, '=');
                                                LoanApps."Amount In Arreas SACCO" := LoanApps."Amount In Arreas SACCO" - IntReco;
                                            end;

                                            if (LoanApps."Amount In Arreas SACCO") > LoanApps."Outstanding Balance" then LoanApps."Amount In Arreas SACCO" := LoanApps."Outstanding Balance";
                                            IF LoanApps."Amount In Arreas SACCO" > 0 THEN BEGIN
                                                LoanApps."Amount In Arreas SACCO" := LoanApps."Amount In Arreas SACCO" - GetAlreadyRecoveredAmount(LoanApps."Loan No.", DocumentNO, RecType::Loan);

                                                EntrNo += 1;
                                                DividendPostingBuffer.INIT;
                                                DividendPostingBuffer."Entry No." := EntrNo;
                                                DividendPostingBuffer."Posting Date" := TODAY;
                                                DividendPostingBuffer."Document No." := DocumentNO;
                                                DividendPostingBuffer."Account Type" := DividendPostingBuffer."Account Type"::Credit;
                                                DividendPostingBuffer."Account No." := LoanApps."Loan Account";
                                                DividendPostingBuffer.Description := PADSTR(LoanPrincipal + ' DFTL ' + SavingsAccounts."No." + ' LNo:' + LoanApps."Loan No.", 50); //*
                                                DividendPostingBuffer."Member No." := CustMembr."No.";

                                                IF RunBal > LoanApps."Amount In Arreas SACCO" THEN BEGIN
                                                    IF (LoanApps."Amount In Arreas SACCO" - IntReco) >= 0 THEN
                                                        DividendPostingBuffer.Amount := -ROUND((LoanApps."Amount In Arreas SACCO" - IntReco), 0.01, '=')//ROUND(LoanApps."Outstanding Bills",0.01,'=')
                                                    ELSE
                                                        DividendPostingBuffer.Amount := -ROUND((LoanApps."Amount In Arreas SACCO"), 0.01, '=')
                                                END ELSE
                                                    DividendPostingBuffer.Amount := -RunBal;

                                                DividendPostingBuffer."Debit Amount" := 0;
                                                DividendPostingBuffer."Credit Amount" := ABS(DividendPostingBuffer.Amount);
                                                DividendPostingBuffer."Loan No" := LoanApps."Loan No.";
                                                DividendPostingBuffer."Transaction Type" := DividendPostingBuffer."Transaction Type"::Repayment;
                                                DividendPostingBuffer."Product Type" := LoanApps."Loan Product Type";
                                                DividendPostingBuffer."Product Type Name" := PADSTR(LoanApps."Loan Product Type Name", 20);
                                                DividendPostingBuffer."Shortcut Dimension 1 Code" := GlobalDim1;
                                                DividendPostingBuffer."Shortcut Dimension 2 Code" := GlobalDim2;
                                                DividendPostingBuffer.Year := PreviousYear;
                                                IF DividendPostingBuffer.Amount <> 0 THEN
                                                    DividendPostingBuffer.INSERT;


                                                RunBal -= ABS(DividendPostingBuffer.Amount);
                                                TotRecovDEF += ROUND(ABS(DividendPostingBuffer.Amount), 0.01, '=');
                                                //GrossAmount-=ABS(DividendPostingBuffer.Amount);
                                            END;
                                            LoanRecovered += LoanApps."Loan No." + ' ,';
                                        until LoanApps.Next = 0;
                                    END;
                                //MESSAGE('Member No :%1 Loan No :%2 Balance :%3 RunBal :%4',CustMembr."No.",LoanApps."Loan No.",LoanApps."Outstanding Balance",RunBal);
                                UNTIL PFac.NEXT = 0;
                            end;
                            //Loan Recovery From FOSA
                            // Message(LoanRecovered);
                            if LoanRecovered <> '' then begin
                                Length := StrLen(LoanRecovered);
                                if (Length > 0) and (CopyStr(LoanRecovered, Length, 1) = ',') then
                                    LoanRecovered := CopyStr(LoanRecovered, 1, Length - 1);
                            end;
                            EntrNo += 1;
                            DividendPostingBuffer.INIT;
                            DividendPostingBuffer."Entry No." := EntrNo;
                            DividendPostingBuffer."Posting Date" := TODAY;
                            DividendPostingBuffer."Document No." := DocumentNO;
                            DividendPostingBuffer."Account Type" := DividendPostingBuffer."Account Type"::Savings;
                            DividendPostingBuffer."Account No." := SavingsAccountNo;
                            if PostingOptions = PostingOptions::"BOSA Deposists" then
                                DividendPostingBuffer.Description := CopyStr(('REBATES: REC ' + LoanRecovered), 1, 50) else
                                DividendPostingBuffer.Description := CopyStr(('REC:- ' + LoanRecovered), 1, 50);
                            DividendPostingBuffer."Member No." := CustMembr."No.";
                            DividendPostingBuffer.Amount := TotRecovDEF;
                            DividendPostingBuffer."Debit Amount" := TotRecovDEF;
                            DividendPostingBuffer."Credit Amount" := 0;
                            DividendPostingBuffer."Loan No" := '';
                            DividendPostingBuffer."Product Type" := SavingsProductID;
                            DividendPostingBuffer."Product Type Name" := PADSTR(SavingsProductName, 20);
                            DividendPostingBuffer."Shortcut Dimension 1 Code" := GlobalDim1;
                            DividendPostingBuffer."Shortcut Dimension 2 Code" := GlobalDim2;
                            //DividendPostingBuffer."Bal. Account Type":=DividendPostingBuffer."Bal. Account Type"::"G/L Account";
                            //DividendPostingBuffer."Bal. Account No.":=TransactionCharges."G/L Account";
                            DividendPostingBuffer.Year := PreviousYear;
                            IF DividendPostingBuffer.Amount <> 0 THEN
                                DividendPostingBuffer.INSERT;
                            //Loan Recovery From Prime
                        END;

                        //END;//Recovery Defaulter Loans
                    end;
                END; //OTHER MEMBERS  NOT CAPITALIZING

                if (CustMembr.Subflag = CustMembr.Subflag::Defaulter) then begin
                    TotalExcess := 0;
                    DividendPostingBuffer.reset;
                    DividendPostingBuffer.setrange("Account No.", SavingsAccountNo);
                    DividendPostingBuffer.SetRange("Document No.", DocumentNO);
                    DividendPostingBuffer.CalcSums(Amount);
                    if DividendPostingBuffer.Amount < 0 then begin
                        SavingsAcc.RESET();
                        SavingsAcc.SETRANGE("Member No.", CustMembr."No.");
                        SavingsAcc.SETRANGE("Product Category", SavingsAcc."Product Category"::"BOSA Deposits");
                        SavingsAcc.SETLOADFIELDS("No.");

                        IF SavingsAcc.FINDFIRST THEN BEGIN
                            CapitaliazeAcc := SavingsAcc."No.";
                        END;
                        TotalExcess := DividendPostingBuffer.Amount;

                        EntrNo += 1;
                        DividendPostingBuffer.INIT;
                        DividendPostingBuffer."Entry No." := EntrNo;
                        DividendPostingBuffer."Posting Date" := TODAY;
                        DividendPostingBuffer."Document No." := DocumentNO;
                        DividendPostingBuffer."Account Type" := DividendPostingBuffer."Account Type"::Savings;
                        DividendPostingBuffer."Account No." := SavingsAccountNo;
                        if PostingOptions = PostingOptions::"BOSA Deposists" then
                            DividendPostingBuffer.Description := PADSTR('REBATES ' + format(PreviousYear) + ' to Deposit/Defaulter.', 50) else
                            DividendPostingBuffer.Description := PADSTR(Format(PreviousYear) + ' DIV to Deposit/Defaulter.', 50);
                        DividendPostingBuffer."Member No." := CustMembr."No.";
                        DividendPostingBuffer.Amount := ABS(TotalExcess);
                        DividendPostingBuffer."Debit Amount" := ABS(TotalExcess);
                        DividendPostingBuffer."Credit Amount" := 0;
                        DividendPostingBuffer."Product Type" := SavingsProductID;
                        DividendPostingBuffer."Product Type Name" := PADSTR(SavingsProductName, 20);
                        DividendPostingBuffer."Shortcut Dimension 1 Code" := GlobalDim1;
                        DividendPostingBuffer."Shortcut Dimension 2 Code" := GlobalDim2;
                        DividendPostingBuffer."Loan No" := '';
                        DividendPostingBuffer."Bal. Account Type" := DividendPostingBuffer."Bal. Account Type"::"G/L Account";
                        DividendPostingBuffer."Bal. Account No." := '';
                        DividendPostingBuffer.Year := PreviousYear;
                        IF DividendPostingBuffer.Amount <> 0 THEN
                            DividendPostingBuffer.INSERT;

                        //Credit FOSA Account
                        EntrNo += 1;
                        DividendPostingBuffer.INIT;
                        DividendPostingBuffer."Entry No." := EntrNo;
                        DividendPostingBuffer."Posting Date" := TODAY;
                        DividendPostingBuffer."Document No." := DocumentNO;
                        DividendPostingBuffer."Account Type" := DividendPostingBuffer."Account Type"::Savings;
                        DividendPostingBuffer."Account No." := CapitaliazeAcc;
                        if PostingOptions = PostingOptions::"BOSA Deposists" then
                            DividendPostingBuffer.Description := PADSTR('BLN ' + format(PreviousYear) + ' DIV to Deposit/Defaulter.', 50) else
                            DividendPostingBuffer.Description := PADSTR(Format(PreviousYear) + ' DIV to Deposit/Defaulter.', 50);
                        DividendPostingBuffer."Member No." := CustMembr."No.";
                        DividendPostingBuffer.Amount := TotalExcess;
                        DividendPostingBuffer."Debit Amount" := 0;
                        DividendPostingBuffer."Credit Amount" := TotalExcess;
                        DividendPostingBuffer."Product Type" := SavingsAcc."Product Type";
                        DividendPostingBuffer."Product Type Name" := PADSTR(SavingsAcc."Product Name", 20);
                        DividendPostingBuffer."Shortcut Dimension 1 Code" := GlobalDim1;
                        DividendPostingBuffer."Shortcut Dimension 2 Code" := GlobalDim2;
                        DividendPostingBuffer."Loan No" := '';
                        DividendPostingBuffer."Bal. Account Type" := DividendPostingBuffer."Bal. Account Type"::"G/L Account";
                        DividendPostingBuffer."Bal. Account No." := '';
                        DividendPostingBuffer.Year := PreviousYear;
                        IF DividendPostingBuffer.Amount <> 0 THEN
                            DividendPostingBuffer.INSERT;

                    end;
                end;
            END;
        end;
    end;

    procedure GetAlreadyRecoveredAmount(AccountNo: Code[20]; DocumentNos: Code[20]; RecType: Option Loan,Savings) RecoveredAmount: Decimal
    var
        DividendPostingBuffer: Record "Dividend Posting Buffer";
        RecoveredAmt: Decimal;
    begin
        DividendPostingBuffer.Reset();
        DividendPostingBuffer.SetRange(Posted, true);
        DividendPostingBuffer.setrange("Document No.", DocumentNos);
        if RecType = RecType::Loan then
            DividendPostingBuffer.SetRange("Loan No", AccountNo) else
            DividendPostingBuffer.SetRange("Account No.", AccountNo);
        DividendPostingBuffer.CalcSums(Amount);
        RecoveredAmt := abs(DividendPostingBuffer.Amount);
        exit(RecoveredAmt);
    end;

    procedure DividendPostJournal(JTemplate: Code[10]; JBatch: Code[10]) Posted: Boolean
    var
        DividendPostingBuffer: Record "Dividend Posting Buffer";
        GenJournalLine: Record "Gen. Journal Line";
    begin
        Posted := false;
        DividendPostingBuffer.Reset;
        DividendPostingBuffer.SetRange("Dividend Template Name", JTemplate);
        DividendPostingBuffer.SetRange("Dividend Batch Name", JBatch);
        if DividendPostingBuffer.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
            Posted := true;


        end;
    end;



    procedure CompletePosting(Template: Code[20]; Batch: Code[20])
    var
        GenJLine: Record "Gen. Journal Line";
    begin
        GenJLine.Reset;
        GenJLine.SetRange(GenJLine."Journal Template Name", Template);
        GenJLine.SetRange(GenJLine."Journal Batch Name", Batch);
        // if GenJLine.Find('-') then
    end;


    procedure getDividendSetup()
    begin
        DividendSetUp.Get;
        DividendSetUp.TestField(DividendSetUp."Start Date");
        DividendSetUp.TestField(DividendSetUp."End Date");

        StartDate := DividendSetUp."Start Date";
        EndDate := DividendSetUp."End Date";
    end;

    procedure getDividendSetupV2(var DividendSetUp: Record "Dividend SetUp")
    begin
        DividendSetUp.TestField(DividendSetUp."Start Date");
        DividendSetUp.TestField(DividendSetUp."End Date");

        StartDate := DividendSetUp."Start Date";
        EndDate := DividendSetUp."End Date";
    end;

    local procedure GetDividendInstructions(MemberNo: Code[20])
    var
        DividendInstructions: Record "Dividend Instructions - Member";
    begin
    end;

    //Dividend Provisions
    procedure GenerateDividendProvisions(SavingsInterestHeader: Record "Dividends Provision Header")
    var
        InterestBuffer: Record "Dividend Provision";
        InterestBuffer2: Record "Dividend Provision";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        SavingsAccounts: Record "Savings Accounts";
        FromDateS: Text[100];
        ToDateS: Text[100];
        DateFilter: Text[100];
        ProductFactory: Record "Product Factory";
        ProductFactoryCode: Code[20];
        InterestRate: Decimal;
        PayableAccount: Code[20];
        ExpenseAccount: Code[20];
        BankingUserTemplate: Record "Banking User Template";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        JTemp: Code[20];
        JBatch: Code[20];
        PageEditable: Boolean;
        Members: Record Members;
        ErrNotApproved: label 'This document has not been approved';
        ErrNoEntries: label 'This Document has no Lines to post';
        MSGEntriesGenerated: label 'Entries Generated Successfully';
        MSGConfirmation: label 'Confirm dividends provision for period starting %1 and Ending %2';
        ErrPosted: label 'This document has already been posted';
        IntDays: Integer;
        BalAccount: Record "Savings Accounts";
        Bal: Decimal;
        Account: Record "Savings Accounts";
        IntRate: Decimal;
        LowestBal: Decimal;
        MinBal: Boolean;
        RIntDays: Integer;
        AsAt: Date;
        StartDate: Date;
        AccruedInt: Decimal;
        Turn: Integer;
        diaProgress: Dialog;
        intProgress: Integer;
        timProgress: Time;
        intProgressI: Integer;
        intProgressTotal: Integer;
        Counter1: Integer;
        GeneratingDividends: label 'Generating Interest :';
        Counter2: Integer;
        PercentComplete: Decimal;
        MonthDays: Integer;
    begin
        //with SavingsInterestHeader do
        begin
            SavingsInterestHeader.TestField(Posted, false);
            SavingsInterestHeader.TestField("Start Date");
            SavingsInterestHeader.TestField("End Date");
            SavingsInterestHeader.TestField(Description);
            SavingsInterestHeader.TestField("Responsibility Center");
            SavingsInterestHeader.TestField("Shortcut Dimension 1 Code");
            SavingsInterestHeader.TestField("Document No.");
            SavingsInterestHeader.TestField("Shortcut Dimension 2 Code");
            AsAt := SavingsInterestHeader."Start Date";
            //Turn:=0;
            IntDays := 0;
            RIntDays := 0;
            MonthDays := 0;

            if not Confirm(MSGConfirmation, true, SavingsInterestHeader."Start Date", SavingsInterestHeader."End Date") then
                exit;
            //Delete entries
            InterestBuffer2.Reset;
            InterestBuffer2.SetRange(InterestBuffer2."Dividends No.", SavingsInterestHeader."No.");
            InterestBuffer2.DeleteAll;

            Counter2 := Members.Count * 1;
            diaProgress.Open('@1@@@@@@@@@@@\#2############');
            Evaluate(FromDateS, Format(SavingsInterestHeader."Start Date"));
            Evaluate(ToDateS, Format(SavingsInterestHeader."End Date"));
            //if DATE2DMY(SavingsInterestHeader."Start Date", 2) = 1 then
            DateFilter := '..' + ToDateS;// else
                                         //   DateFilter := FromDateS + '..' + ToDateS;
                                         //MonthDays := (CalcDate('<CM>', SavingsInterestHeader."Start Date") - SavingsInterestHeader."Start Date") + 1;
            SavingsAccounts.Reset;
            SavingsAccounts.SetFilter(SavingsAccounts."Date Filter", DateFilter);
            if SavingsInterestHeader."Employer Code" <> '' then
                SavingsAccounts.SetRange("Employer Code", SavingsInterestHeader."Employer Code");
            if SavingsInterestHeader."Product Type" <> '' then
                SavingsAccounts.SetRange("Product Type", SavingsInterestHeader."Product Type");
            if SavingsAccounts.Find('-') then begin
                repeat
                    if ProductFactory.Get(SavingsAccounts."Product Type") then begin

                        ProductFactoryCode := ProductFactory."Product ID";
                        if (ProductFactory."Product Class Type" = ProductFactory."product class type"::Savings) //and (ProductFactory."Product Category" = ProductFactory."product category"::" ")
                          and (ProductFactory."Dividend Calc. Method" <> ProductFactory."Dividend Calc. Method"::" ") then begin//Product Factory Prime

                            //Ensure necessary setups are done
                            ProductFactory.TestField("Interest Rate (Min.)");
                            ProductFactory.TestField("Interest Payable Account");
                            ProductFactory.TestField("Interest Expense Account");

                            Counter1 += 1;
                            PercentComplete := ROUND(Counter1 / Counter2 * 10000, 1);
                            diaProgress.Update(1, PercentComplete);
                            diaProgress.Update(2, PercentComplete);
                            SavingsAccounts.CalcFields(SavingsAccounts.Balance);
                            if SavingsAccounts.Balance > 0 then begin
                                //  IntDays := (SavingsInterestHeader."End Date" - SavingsInterestHeader."Start Date") + 1;
                                //  RIntDays := IntDays;
                                InterestRate := ProductFactory."Interest Rate (Min.)";
                                InterestBuffer.Init;
                                InterestBuffer."Dividends No." := SavingsInterestHeader."No.";
                                InterestBuffer."Account No" := SavingsAccounts."No.";
                                InterestBuffer."Member No" := SavingsAccounts."Member No.";
                                InterestBuffer."Product Name" := SavingsAccounts."Product Name";
                                InterestBuffer.Month := DATE2DMY(SavingsInterestHeader."End Date", 2);
                                InterestBuffer.Year := DATE2DMY(SavingsInterestHeader."End Date", 3);
                                InterestBuffer."Payable Account" := ProductFactory."Interest Payable Account";
                                InterestBuffer."Expense Account" := ProductFactory."Interest Expense Account";
                                InterestBuffer."Qualifying Shares" := SavingsAccounts.Balance;
                                InterestBuffer."Gross Dividends" := SavingsAccounts.Balance * ((InterestRate * 30) / 36000);
                                InterestBuffer."Product Type" := ProductFactoryCode;
                                InterestBuffer."Interest Rate" := InterestRate;

                                if InterestBuffer."Gross Dividends" <> 0 then
                                    InterestBuffer.Insert(true);
                            end;

                        end;
                    end;
                until SavingsAccounts.Next = 0;
            end;
            diaProgress.Close;
        end;
        Message(MSGEntriesGenerated);

    end;

    procedure ReverseForfeited(var TheMember: Record members; ActionDate: date): Boolean
    var
        // Mem: Record members;
        Forfeit: Boolean;
    begin
        Forfeit := false;
        // if Mem.Get(MemberNo) then begin
        if (TheMember.Subflag = TheMember.Subflag::Rejoined) and (TheMember."Rejoinig Date" <> 0D) then begin
            if TheMember."Rejoinig Date" > ActionDate then
                Forfeit := true;
        end;

        if Forfeit = false
        then begin
            Forfeit := ReverseDividends(TheMember, ActionDate);
        end;
        // end;
        exit(Forfeit);

    end;

    procedure ReverseDividends(var TheMember: Record members; ActionDate: date): Boolean
    var
        // Mem: Record members;
        ReverseEntries: Boolean;
        MembClosure: Record "Membership Closure";
        SinkFund: Record "SinkFund Report Information";
    begin
        ReverseEntries := false;
        // if Mem.get(MemberNo) then begin
        if (TheMember.Status = TheMember.Status::Deceased) then begin

            SinkFund.reset;
            SinkFund.SetRange("Member No", TheMember."No.");
            SinkFund.SetRange(Posted, true);
            if SinkFund.Find('-') then begin
                if SinkFund."Date of Death" < ActionDate then
                    ReverseEntries := true else
                    ReverseEntries := false;
            end else
                ReverseEntries := true;

        end;

        if (TheMember.Subflag = TheMember.Subflag::Withdrawal) then begin

            MembClosure.RESET;
            MembClosure.SETRANGE(Posted, TRUE);
            MembClosure.SETRANGE("Member No.", TheMember."No.");
            MembClosure.SetFilter("Closing Date", '..%1', ActionDate);
            IF MembClosure.FIND('-') THEN
                ReverseEntries := true;

        end;
        exit(ReverseEntries);

        // end;
    end;


    procedure PostDividendsProvisions(SavingsInterestHeader: Record "Dividends Provision Header")
    var
        InterestBuffer: Record "Dividend Provision";
        InterestBuffer2: Record "Dividend Provision";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        PeriodicActivities: Codeunit "Periodic Activities";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        SavingsAccounts: Record "Savings Accounts";
        FromDateS: Text[100];
        ToDateS: Text[100];
        DateFilter: Text[100];
        gLentries: Record "G/L Entry";
        ProductFactory: Record "Product Factory";
        ProductFactoryCode: Code[20];
        InterestRate: Decimal;
        PayableAccount: Code[20];
        ExpenseAccount: Code[20];
        BankingUserTemplate: Record "Banking User Template";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        JTemp: Code[20];
        JBatch: Code[20];
        PageEditable: Boolean;
        Members: Record Members;
        ErrNotApproved: label 'This document has not been approved';
        ErrNoEntries: label 'This Document has no Lines to post';
        MSGEntriesGenerated: label 'Entries Generated Successfully';
        MSGConfirmation: label 'Confirm interest Generation for period starting %1 and Ending %2';
        ErrPosted: label 'This document has already been posted';
    begin

        if SavingsInterestHeader.Posted = true then
            Error(ErrPosted);
        if SavingsInterestHeader.Status <> SavingsInterestHeader.Status::Approved then
            Error(ErrNotApproved);

        if not Confirm('Do you want to post the journal lines?') = true then exit;

        begin

            gLentries.Reset();
            gLentries.SetRange("Document No.", SavingsInterestHeader."Document No.");
            gLentries.SetRange("Posting Date", SavingsInterestHeader."Posting Date");
            if not gLentries.Find('-') then begin
                SavingsInterestHeader.CalcFields("Distributed Amount");
                if SavingsInterestHeader."Distributed Amount" = 0 then
                    Error(ErrNoEntries);
                if BankingUserTemplate.Get(UserId) then begin
                    JTemp := BankingUserTemplate."Interest Account Template";
                    JBatch := BankingUserTemplate."Interest Account Batch";
                end;

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", JTemp);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                if GenJournalLine.Find('-') then
                    GenJournalLine.DeleteAll;
                ProductFactory.reset;
                ProductFactory.SetRange("Product Class Type", ProductFactory."Product Class Type"::Savings);
                if ProductFactory.Find('-') then begin
                    repeat
                        InterestBuffer.Reset;
                        InterestBuffer.SetRange(InterestBuffer."Dividends No.", SavingsInterestHeader."No.");
                        InterestBuffer.SetRange("Product Type", ProductFactory."Product ID");
                        InterestBuffer.CalcSums("Gross Dividends");
                        if InterestBuffer."Gross Dividends" <> 0 then begin
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := JTemp;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := ProductFactory."Interest Expense Account";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := SavingsInterestHeader."Document No.";
                            GenJournalLine."Posting Date" := SavingsInterestHeader."Posting Date";
                            GenJournalLine.Description := CopyStr((SavingsInterestHeader.Description + '-' + ProductFactory."Product ID" + ProductFactory."Product Description"), 1, 50);
                            GenJournalLine.Amount := InterestBuffer."Gross Dividends";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := ProductFactory."Interest Payable Account";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Shortcut Dimension 1 Code" := SavingsInterestHeader."Shortcut Dimension 1 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine."Shortcut Dimension 2 Code" := SavingsInterestHeader."Shortcut Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                        end;
                    until ProductFactory.Next = 0;
                end;

                //Post New
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", JTemp);
                GenJournalLine.SetRange("Journal Batch Name", JBatch);
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post New", GenJournalLine);
                end;
                Message('Posted Successfully');
                SavingsInterestHeader.Posted := true;
                InterestBuffer.Posted := true;
                SavingsInterestHeader."Posted By" := UserId;
                SavingsInterestHeader."Posting Date" := Today;
                SavingsInterestHeader.Modify;
            end else begin
                Message('Posted Successfully');
                SavingsInterestHeader.Posted := true;
                InterestBuffer.Posted := true;
                SavingsInterestHeader."Posted By" := UserId;
                SavingsInterestHeader."Posting Date" := Today;
                SavingsInterestHeader.Modify;
            end;
        end;
    end;

}

