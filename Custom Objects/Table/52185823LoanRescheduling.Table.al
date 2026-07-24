table 52185823 "Loan Rescheduling"
{
    DrillDownPageID = "Loan Rescheduling List";
    LookupPageID = "Loan Rescheduling List";

    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    NoSetup.Get();
                    NoSeriesMgt.TestManual(NoSetup."Loan Reschedule");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No."; Code[20])
        {
            TableRelation = Members."No.";

            trigger OnValidate()
            begin
                "Loan No." := '';
                "Outstanding Balance" := 0;
                "Outstanding Interest" := 0;
                "Remaining Installments" := 0;
                "Interest Limits" := '';
                InterestRate := 0;
                "Old Amortised" := 0;
                "New Amortised" := 0;
                "Original Installments" := 0;
                "Maximun Installments" := 0;
                "Account No." := '';
                "Current Interest Rate" := 0;
                "New Installments" := 0;

                if Mem.Get("Member No.") then begin
                    "Member Name" := Mem.Name;
                    "Captured By" := UserId;
                end;
            end;
        }
        field(3; "Member Name"; Text[50])
        {
            Editable = false;
        }
        field(4; "Loan No."; Code[20])
        {
            TableRelation = Loans."Loan No." WHERE("Member No." = FIELD("Member No."),
                                                    "Outstanding Balance" = FILTER(> 0));
            trigger OnValidate()
            var
                ProductSetup: Record "Product Factory";
                OriginalIns: Integer;
                LoansRec: Record Loans;
            begin
                Rec.TestField("Rescheduling Date");
                RemInstallments := 0;
                if Rec."Schedule Type" = Rec."Schedule Type"::Restructure then begin
                    LoansRec.Reset();
                    LoansRec.SetRange("Loan No.", Rec."Loan No.");
                    LoansRec.SetRange("Loan Rescheduled", true);
                    if LoansRec.FindFirst() then
                        Error('Loan has been Restructured');
                end;
                if Loan.Get("Loan No.") then begin

                    Loan.CalcFields(Loan."Outstanding Balance", Loan."Outstanding Interest");
                    "Outstanding Balance" := Loan."Outstanding Balance";
                    "Outstanding Interest" := Loan."Outstanding Interest";
                    "Old Amortised" := Loan.Repayment;
                    "Account No." := Loan."Loan Account";
                    Rec."Approved Amount" := Loan."Approved Amount";
                    "New Interest Rate" := Loan.Interest;
                    ///"Defaulter Status" := Loan."Interest Paid";
                    "Current Interest Rate" := Loan.Interest;


                    if ProdF.Get(Loan."Loan Product Type") then begin
                        "Maximun Installments" := ProdF."Ordinary Default Intallments";
                        MinInterest := ProdF."Interest Rate (Min.)";
                        MaxInterest := ProdF."Interest Rate (Max.)";
                        "Recovery Mode" := ProdF."Repay Mode";
                        Rec."Original Installments" := ProdF."Ordinary Default Intallments";
                        if Rec."Original Installments" = 0 then
                            "Original Installments" := Loan.Installments;
                        OriginalIns := "Original Installments";

                    end;

                    if MinInterest = MaxInterest then begin
                        "Interest Limits" := Format(MinInterest);
                    end else begin
                        "Interest Limits" := Format(MinInterest) + ' - ' + Format(MaxInterest);
                    end;
                    PaymentMethodsApplication.Reset;
                    PaymentMethodsApplication.SetRange("Loan No.", Loan."Loan No.");
                    if PaymentMethodsApplication.Find('-') then begin
                        PaymentMethodsApplication.DeleteAll;
                    end;
                    PaymentMethods.Reset;
                    PaymentMethods.SetRange("Loan No.", Loan."Loan No.");
                    if PaymentMethods.Find('-') then begin
                        repeat
                            PaymentMethodsApplication.Init;
                            PaymentMethodsApplication."Loan No." := PaymentMethods."Loan No.";
                            PaymentMethodsApplication."Payment Method" := PaymentMethods."Payment Method";
                            PaymentMethodsApplication."Member No." := "Member No.";
                            PaymentMethodsApplication.Amount := PaymentMethods.Amount;
                            PaymentMethodsApplication."Reschedule No" := "No.";
                            PaymentMethodsApplication.Insert;
                        until PaymentMethods.Next = 0;
                    end;
                    LoanSched.Reset;
                    LoanSched.SetRange(LoanSched."Loan No.", Rec."Loan No.");
                    LoanSched.SetFilter("Repayment Date", '>%1', rec."Rescheduling Date");
                    paidInstallments := LoanSched.Count;
                    "Remaining Installments" := OriginalIns - paidInstallments;

                    //Delete schedule if any.
                    LoanSched.Reset;
                    LoanSched.SetRange(LoanSched."Loan No.", "Loan No.");
                    if LoanSched.Find('-') then LoanSched.DeleteAll;

                    //Generate schedule.
                    GenerateSchedule();

                    //Check if Ever Rescheduled.
                    LoanRescheduling.Reset;
                    LoanRescheduling.SetRange(LoanRescheduling."Loan No.", "Loan No.");
                    LoanRescheduling.SetRange(LoanRescheduling.Rescheduled, true);
                    if LoanRescheduling.FindFirst then begin
                        repeat
                            RecreateOldSchedules(LoanRescheduling."No.");
                        until LoanRescheduling.Next = 0;
                    end;
                    //Check schedule details

                end;
            end;
        }
        field(5; "Outstanding Balance"; Decimal)
        {
            Editable = false;
        }
        field(6; "Outstanding Interest"; Decimal)
        {
            Editable = false;
        }
        field(7; Rescheduled; Boolean)
        {
            Editable = false;
        }
        field(8; "Remaining Installments"; Integer)
        {
            Editable = false;
        }
        field(9; "New Installments"; Integer)
        {

            trigger OnValidate()
            var
                Loansre: Record Loans;
                LoanPro: Record "Product Factory";
            begin
                TestField("Schedule Type");
                TestField("Rescheduling Date");

                PastInstallments := 0;
                if "Schedule Type" <> "Schedule Type"::Restructure then begin
                    // if "Original Installments" = "Maximun Installments" then begin
                    //     if "New Installments" > "Remaining Installments" then Error(Txt0001);
                    // end else begin
                    //     PastInstallments := "Original Installments" - "Remaining Installments";
                    //     if "New Installments" + PastInstallments > "Maximun Installments" then Error(Txt0002);
                    // end;
                    if "New Installments" > "Maximun Installments" then Error(Txt0002);
                end;
                if "Schedule Type" = "Schedule Type"::Restructure then begin
                    Loansre.Reset();
                    Loansre.SetRange(Loansre."Loan No.", Rec."Loan No.");
                    Loansre.SetRange(Posted, true);
                    if Loansre.FindFirst() then begin
                        LoanPro.Reset();
                        LoanPro.SetRange("Product ID", Loansre."Loan Product Type");
                        if LoanPro.FindFirst() then begin
                            PastInstallments := "Original Installments" - "Remaining Installments";
                            if "New Installments" > Loansre.Installments then
                                Message('The member will be required to add new guarantors');
                            if "New Installments" > LoanPro."Ordinary Default Intallments" then
                                Error(Txt0002);
                            if "New Installments" + paidInstallments > LoanPro."Ordinary Default Intallments" then
                                Error(Txt0002);
                        end;
                    end;

                end;

                if "Schedule Type" <> "Schedule Type"::"Interest Change" then GetNewRepayment;
            end;
        }
        field(10; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending,Approved,Rejected';
            OptionMembers = Open,Pending,Approved,Rejected;
        }
        field(11; "Old Amortised"; Decimal)
        {
            Editable = false;
        }
        field(12; "New Amortised"; Decimal)
        {

            trigger OnValidate()
            var
                loansRec: Record Loans;
                TotalBal: Decimal;
            begin
                TestField("Rescheduling Date");
                "New Installments" := 0;
                loansRec.Reset();
                loansRec.SetRange(loansRec."Loan No.", Rec."Loan No.");
                if loansRec.FindFirst() then begin
                    loansRec.CalcFields("Outstanding Balance", "Outstanding Interest", "Outstanding Bills");
                    TotalBal := loansRec."Outstanding Balance" + loansRec."Outstanding Interest" + loansRec."Outstanding Bills";
                    if "New Amortised" > TotalBal then Error('You cannot reschedule more than the outstanding balance');
                    "New Installments" := Round((TotalBal / Rec."New Amortised"), 1, '>');
                    if rec."New Installments" > Rec."Remaining Installments" then Error('You cannot reschedule more than the remaining number of installments');
                end;
            end;
        }
        field(13; "Account No."; Code[20])
        {
            Editable = false;
        }
        field(14; "Original Installments"; Integer)
        {
            Editable = false;
        }
        field(15; "Maximun Installments"; Integer)
        {
            Editable = false;
            Caption = 'Maximum Installments';
        }
        field(16; "Rescheduling Date"; Date)
        {
            Editable = true;

            trigger OnValidate()
            begin
                //TESTFIELD("Schedule Type");
            end;
        }
        field(17; "No. Series"; Code[10])
        {
        }
        field(45; "Responsibility Center"; Code[10])
        {
            Editable = true;
            TableRelation = "Responsibility CenterBR";
        }
        field(46; "Requested Repaymet"; Decimal)
        {
        }
        field(49; "Recovery Mode"; Enum "Loan Recovery Mode")
        {
            // OptionCaption = ' ,Checkoff,Salary,Dividend,Fixed Deposit,Internal STO, External STO';
            //  OptionMembers = " ",Checkoff,Salary,Dividend,"Fixed Deposit","Internal STO"," External STO";
        }
        field(50; "Defaulter Status"; Option)
        {
            OptionCaption = 'Active Loan,Loan at Debt Collector,Loan at Lawyer, Loan at CRB';
            OptionMembers = "Active Loan","Loan at Debt Collector","Loan at Lawyer"," Loan at CRB";
        }
        field(51; "Current Interest Rate"; Decimal)
        {
            Editable = false;
        }
        field(52; "New Interest Rate"; Decimal)
        {

            trigger OnValidate()
            begin

                if "New Interest Rate" <> 0 then begin
                    if LoansF.Get("Loan No.") then ProductFactory.Get(LoansF."Loan Product Type");
                    if ("New Interest Rate" < ProductFactory."Interest Rate (Min.)") then Error(IntMargins, 'Minimum', ProductFactory."Interest Rate (Min.)");
                    if ("New Interest Rate" > ProductFactory."Interest Rate (Max.)") then Error(IntMargins, 'Maximum', ProductFactory."Interest Rate (Max.)");
                end;

                //MESSAGE('Date %1',CALCDATE('<CM-1M+1D>',"Rescheduling Date"));

                GetNewRepayment;
            end;
        }
        field(53; "Interest Limits"; Code[20])
        {
            Editable = true;
        }
        field(54; "Schedule Type"; Option)
        {
            Editable = true;
            OptionMembers = " ",Reschedule,"Interest Change",Restructure,"Defaulter Loan Conversion";
            OptionCaption = ' ,Reschedule,Interest Change,Restructure,Defaulter Loan Conversion';
        }
        field(55; "Rescheduled By"; Text[30])
        {
            Editable = false;
        }
        field(56; "Date Commited"; Date)
        {
            Editable = true;
        }
        field(57; "Captured By"; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(58; "Date Rescheduled"; date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(59; "Approved By"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Rejected By"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Approved Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            NoSetup.Get();
            NoSetup.TestField(NoSetup."Loan Reschedule");
            "No." := NoSeriesMgt.GetNextNo(NoSetup."Loan Reschedule");
            // NoSeriesMgt.InitSeries(NoSetup."Loan Reschedule", xRec."No.", 0D, "No.", "No. Series");
        end;

        if UserSet.Get(UserId) then begin
            "Responsibility Center" := UserSet."Shortcut Dimension 3 Code";
        end;

        //"Rescheduled By" := UserId;
        "Rescheduling Date" := CalcDate('<CM>', Today);
    end;

    var
        LoanRescheduling: Record "Loan Rescheduling";
        MinInterest: Decimal;
        MaxInterest: Decimal;
        NoSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        Mem: Record Members;
        RemInstallments: Integer;
        Loan: Record Loans;
        ProdF: Record "Product Factory";
        ProductFactory: Record "Product Factory";
        LoanSched: Record "Ideal Repayment Schedule";
        PastInstallments: Integer;
        Txt0001: Label 'Installments cannot exceed the maximum installments defined for this product';
        Txt0002: Label 'Installments cannot exceed the maximum installments defined for this product';
        Loans: Record Loans;
        InstallmentsNew: Decimal;
        LoansR: Record Loans;
        LoansF: Record Loans;
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        paidInstallments: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        LoanRepaymentSchedule: Record "Ideal Repayment Schedule";
        LoanApp: Record Loans;
        PartialSched: Record "Partial Disbursement Schedule";
        Text0003: Label 'You can not reschedule more than the initial insatllment';
        UserSet: Record "User Setup";
        PaymentMethodsApplication: Record "Payment Methods Application";
        PaymentMethods: Record "Payment Methods";
        CreditAccounts: Record "Credit Accounts";
        GeneralSetUp: Record "General Set-Up";
        IntMargins: Label 'The new interest rate is not within the allowed margins. %1 %2';

    local procedure GetNewRepayment()
    begin
        Loans.Reset;
        Loans.SetRange("Loan No.", Rec."Loan No.");
        if Loans.Find('-') then begin

            GeneralSetUp.Get;

            LoanRepaymentSchedule.Reset;
            LoanRepaymentSchedule.SetRange("Repayment Date", CalcDate('<CM-1M+1D>', "Rescheduling Date"), 99991230D);
            LoanRepaymentSchedule.SetRange("Loan No.", Loans."Loan No.");
            if LoanRepaymentSchedule.Find('-') then LoanRepaymentSchedule.DeleteAll;

            Loans.CalcFields("Outstanding Balance", "Outstanding Interest");

            if "Schedule Type" = "Schedule Type"::Reschedule then begin
                InterestRate := Loans.Interest;
            end else
                if "Schedule Type" = "Schedule Type"::"Interest Change" then begin
                    InterestRate := "New Interest Rate";
                end
                else
                    if "Schedule Type" = "Schedule Type"::Restructure then begin
                        InterestRate := "New Interest Rate";
                    end;
            if "New Installments" > 0 then
                RepayPeriod := "New Installments"
            else
                RepayPeriod := "Original Installments";
            if "New Installments" > 0 then
                "New Installments" := Rec."New Installments"
            else
                "New Installments" := "Original Installments";
            LoanAmount := Loans."Outstanding Balance";
            LBalance := Loans."Outstanding Balance";
            RunDate := CalcDate('<CM>', "Rescheduling Date");

            repeat
                InstalNo := InstalNo + 1;

                if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::Amortised then begin
                    TotalMRepay := Round((InterestRate / 1200) / (1 - Power((1 + (InterestRate / 1200)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                    LInterest := Round(LBalance / 1200 * InterestRate, 0.0001, '>');
                    LPrincipal := TotalMRepay - LInterest;
                    Loans.Repayment := LInterest + LPrincipal;
                end;

                if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Straight Line" then begin
                    TestField("New Interest Rate");
                    LPrincipal := LoanAmount / RepayPeriod;
                    LInterest := (InterestRate / 1200) * LoanAmount;
                    Loans.Repayment := LPrincipal;
                end;

                if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Balance" then begin
                    TestField("New Interest Rate");
                    LPrincipal := LoanAmount / RepayPeriod;
                    LInterest := (InterestRate / 1200) * LBalance;
                    Loans.Repayment := LPrincipal;
                end;

                if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Flat" then begin
                    TestField("New Interest Rate");
                    LPrincipal := Round(LoanAmount / RepayPeriod, 1.0, '>');
                    LInterest := Round(((LoanAmount * InterestRate / 12 / 100) + (LPrincipal * InterestRate / 12 / 100)) / 2, 1.0, '>');
                    Loans.Repayment := LPrincipal;
                end;

                //Decrement the Balance
                LBalance := LBalance - LPrincipal;

                Evaluate(RepayCode, Format(InstalNo));

                LoanRepaymentSchedule.Init;
                LoanRepaymentSchedule."Repayment Code" := RepayCode;
                LoanRepaymentSchedule."Loan No." := Loans."Loan No.";
                LoanRepaymentSchedule."Loan Amount" := "Outstanding Balance";
                LoanRepaymentSchedule."Instalment No" := InstalNo;
                LoanRepaymentSchedule."Repayment Date" := RunDate;
                LoanRepaymentSchedule."Member No." := "Member No.";
                LoanRepaymentSchedule."Loan Category" := Loans."Loan Product Type";
                LoanRepaymentSchedule."Monthly Repayment" := LInterest + LPrincipal + GeneralSetUp."BDE Loan Above Target";
                LoanRepaymentSchedule."Monthly Interest" := LInterest;
                LoanRepaymentSchedule."Principal Repayment" := LPrincipal;
                // LoanRepaymentSchedule."Administartion Amount":=GeneralSetUp."BDE Loan Above Target";
                LoanRepaymentSchedule."Reset Doc No." := "No.";
                LoanRepaymentSchedule."Reset Schedule" := true;
                LoanRepaymentSchedule.Insert;

                //Repayment Frequency
                if Loans."Repayment Frequency" = Loans."Repayment Frequency"::Daily then
                    RunDate := CalcDate('1D', RunDate)
                else
                    if Loans."Repayment Frequency" = Loans."Repayment Frequency"::Weekly then
                        RunDate := CalcDate('1W', RunDate)
                    else
                        if Loans."Repayment Frequency" = Loans."Repayment Frequency"::Monthly then
                            RunDate := CalcDate('1M', RunDate)
                        else
                            if Loans."Repayment Frequency" = Loans."Repayment Frequency"::Quarterly then
                                RunDate := CalcDate('1Q', RunDate);
            //Repayment Frequency

            until InstalNo = "New Installments";

            if CreditAccounts.Get(Loans."Loan Account") then begin
                if ProdF.Get(CreditAccounts."Product Type") then begin
                    if "Schedule Type" <> "Schedule Type"::Restructure then begin
                        if (ProdF."Nature of Loan Type" <> ProdF."Nature of Loan Type"::Defaulter) and ("Original Installments" < InstalNo) then Error(Text0003);
                    end;
                end;
            end;

            "New Amortised" := LInterest + LPrincipal + GeneralSetUp."BDE Loan Above Target";
            "Outstanding Interest" := LInterest;


            Modify;
        end;
    end;

    local procedure GenerateSchedule()
    begin
        GrPrinciple := 0;
        GrInterest := 0;
        QCounter := 0;
        QCounter := 3;

        GeneralSetUp.Get;


        LoansR.Reset;
        LoansR.SetRange(LoansR."Loan No.", "Loan No.");
        if LoansR.Find('-') then begin

            LoanAmount := LoansR."Approved Amount";
            if LoansR."Loan Rescheduled" then begin
                if LoansR."New Interest Rate" <> 0 then InterestRate := LoansR."New Interest Rate";
            end else begin
                InterestRate := LoansR.Interest;
            end;
            if Rec."New Interest Rate" > 0 then
                InterestRate := "New Interest Rate"
            else
                InterestRate := InterestRate;
            RepayPeriod := LoansR.Installments;
            InitialInstal := LoansR.Installments;
            LBalance := LoansR."Approved Amount";
            if LoansR."Repayment Start Date" <> 0D then begin
                RunDate := LoansR."Repayment Start Date";
            end else
                if LoansR."Disbursement Date" <> 0D then begin
                    RunDate := LoansR."Disbursement Date";
                end else begin
                    RunDate := LoansR."Application Date";
                end;

            InstalNo := 0;

            //Repayment Frequency
            repeat
                InstalNo := InstalNo + 1;
                //Amortised
                if LoansR."Interest Calculation Method" = LoansR."Interest Calculation Method"::Amortised then begin
                    TotalMRepay := Round((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                    LInterest := Round(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                    LPrincipal := TotalMRepay - LInterest;
                end;

                //Straight Line
                if LoansR."Interest Calculation Method" = LoansR."Interest Calculation Method"::"Straight Line" then begin
                    LPrincipal := LoanAmount / RepayPeriod;
                    LInterest := (InterestRate / 12 / 100) * LoanAmount;
                end;

                //Reducing Balance OR Reducing Flat
                if (LoansR."Interest Calculation Method" = LoansR."Interest Calculation Method"::"Reducing Balance") or
                  (LoansR."Interest Calculation Method" = LoansR."Interest Calculation Method"::"Reducing Flat") then begin
                    LPrincipal := LoanAmount / RepayPeriod;
                    LInterest := (InterestRate / 12 / 100) * LBalance;
                end;

                if LoansR."Interest Calculation Method" = LoansR."Interest Calculation Method"::"Reducing Flat" then begin
                    LPrincipal := Round(LoanAmount / RepayPeriod, 1.0, '>');
                    LInterest := Round(((LoanAmount * InterestRate / 12 / 100) + (LPrincipal * InterestRate / 12 / 100)) / 2, 1.0, '>');
                end;


                //Grace Period
                if GrPrinciple > 0 then begin
                    LPrincipal := 0
                end else begin
                    LBalance := LBalance - LPrincipal;
                end;

                if GrInterest > 0 then LInterest := 0;

                GrPrinciple := GrPrinciple - 1;
                GrInterest := GrInterest - 1;

                Evaluate(RepayCode, Format(InstalNo));

                LoanSched.Init;
                LoanSched."Repayment Code" := RepayCode;
                LoanSched."Loan No." := LoansR."Loan No.";
                LoanSched."Loan Amount" := LoanAmount;
                LoanSched."Instalment No" := InstalNo;
                LoanSched."Repayment Date" := RunDate;
                LoanSched."Member No." := LoansR."Member No.";
                LoanSched."Loan Category" := LoansR."Loan Product Type";
                LoanSched."Monthly Repayment" := LInterest + LPrincipal + GeneralSetUp."BDE Loan Above Target";
                LoanSched."Monthly Interest" := LInterest;
                // LoanSched."Administartion Amount":=GeneralSetUp."BDE Loan Above Target";
                LoanSched."Principal Repayment" := LPrincipal;
                LoanSched.Insert;

                //Repayment Frequency
                if LoansR."Repayment Frequency" = LoansR."Repayment Frequency"::Daily then
                    RunDate := CalcDate('1D', RunDate)
                else
                    if LoansR."Repayment Frequency" = LoansR."Repayment Frequency"::Weekly then
                        RunDate := CalcDate('1W', RunDate)
                    else
                        if LoansR."Repayment Frequency" = LoansR."Repayment Frequency"::Monthly then
                            RunDate := CalcDate('1M', RunDate)
                        else
                            if LoansR."Repayment Frequency" = LoansR."Repayment Frequency"::Quarterly then
                                RunDate := CalcDate('1Q', RunDate)
                            else
                                if LoansR."Repayment Frequency" = LoansR."Repayment Frequency"::"Bi-Annual" then
                                    RunDate := CalcDate('6M', RunDate)
                                else
                                    if LoansR."Repayment Frequency" = LoansR."Repayment Frequency"::Yearly then
                                        RunDate := CalcDate('1Y', RunDate);

            until LBalance < 1
        end;
    end;

    local procedure RecreateOldSchedules(ReScheduleNo: Text)
    var
        ReschedulingList: Record "Loan Rescheduling";
        Loans: Record Loans;
        GeneralSetUp: Record "General Set-Up";
        LoanRepaymentSchedule: Record "Ideal Repayment Schedule";
        CreditAccounts: Record "Credit Accounts";
        ProdF: Record "Product Factory";
        Text0003: Label 'You can not reschedule more than the initial insatllment';
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
    begin
        //Check if Ever Rescheduled.
        ReschedulingList.Reset;
        ReschedulingList.SetRange(ReschedulingList."No.", ReScheduleNo);
        ReschedulingList.SetRange(ReschedulingList.Rescheduled, true);
        if ReschedulingList.FindFirst then begin

            Loans.Reset;
            Loans.SetRange(Loans."Loan No.", ReschedulingList."Loan No.");
            if Loans.Find('-') then begin

                GeneralSetUp.Get;

                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Loan No.", Loans."Loan No.");
                LoanRepaymentSchedule.SetRange("Repayment Date", ReschedulingList."Rescheduling Date", 99991230D);
                if LoanRepaymentSchedule.Find('-') then LoanRepaymentSchedule.DeleteAll;

                //Loans.CALCFIELDS("Outstanding Balance","Outstanding Interest");

                if ReschedulingList."Schedule Type" = ReschedulingList."Schedule Type"::Reschedule then begin
                    InterestRate := ReschedulingList."Current Interest Rate";
                end else
                    if ReschedulingList."Schedule Type" = ReschedulingList."Schedule Type"::"Interest Change" then begin
                        InterestRate := ReschedulingList."New Interest Rate";
                    end;

                RepayPeriod := ReschedulingList."New Installments";
                LoanAmount := ReschedulingList."Outstanding Balance";
                LBalance := ReschedulingList."Outstanding Balance";
                RunDate := CalcDate('<CM>', ReschedulingList."Rescheduling Date");

                repeat
                    InstalNo := InstalNo + 1;

                    if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::Amortised then begin
                        TotalMRepay := Round((InterestRate / 1200) / (1 - Power((1 + (InterestRate / 1200)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                        LInterest := Round(LBalance / 1200 * InterestRate, 0.0001, '>');
                        LPrincipal := TotalMRepay - LInterest;
                        Loans.Repayment := LInterest + LPrincipal;
                    end;

                    if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Straight Line" then begin
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 1200) * LoanAmount;
                        Loans.Repayment := LPrincipal;
                    end;

                    if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Balance" then begin
                        LPrincipal := LoanAmount / RepayPeriod;
                        LInterest := (InterestRate / 1200) * LBalance;
                        Loans.Repayment := LPrincipal;
                    end;

                    if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Flat" then begin
                        LPrincipal := Round(LoanAmount / RepayPeriod, 1.0, '>');
                        LInterest := Round(((LoanAmount * InterestRate / 12 / 100) + (LPrincipal * InterestRate / 12 / 100)) / 2, 1.0, '>');
                        Loans.Repayment := LPrincipal + LInterest;
                    end;
                    //Decrement the Balance
                    LBalance := LBalance - LPrincipal;

                    Evaluate(RepayCode, Format(InstalNo));

                    LoanRepaymentSchedule.Init;
                    LoanRepaymentSchedule."Repayment Code" := RepayCode;
                    LoanRepaymentSchedule."Loan No." := Loans."Loan No.";
                    LoanRepaymentSchedule."Loan Amount" := "Outstanding Balance";
                    LoanRepaymentSchedule."Instalment No" := InstalNo;
                    LoanRepaymentSchedule."Repayment Date" := RunDate;
                    LoanRepaymentSchedule."Member No." := "Member No.";
                    LoanRepaymentSchedule."Loan Category" := Loans."Loan Product Type";
                    LoanRepaymentSchedule."Monthly Repayment" := LInterest + LPrincipal + GeneralSetUp."BDE Loan Above Target";
                    LoanRepaymentSchedule."Monthly Interest" := LInterest;
                    LoanRepaymentSchedule."Principal Repayment" := LPrincipal;
                    // LoanRepaymentSchedule."Administartion Amount":=GeneralSetUp."BDE Loan Above Target";
                    LoanRepaymentSchedule."Reset Doc No." := ReschedulingList."No.";
                    LoanRepaymentSchedule."Reset Schedule" := true;
                    LoanRepaymentSchedule.Insert;

                    //Repayment Frequency
                    if Loans."Repayment Frequency" = Loans."Repayment Frequency"::Daily then
                        RunDate := CalcDate('1D', RunDate)
                    else
                        if Loans."Repayment Frequency" = Loans."Repayment Frequency"::Weekly then
                            RunDate := CalcDate('1W', RunDate)
                        else
                            if Loans."Repayment Frequency" = Loans."Repayment Frequency"::Monthly then
                                RunDate := CalcDate('1M', RunDate)
                            else
                                if Loans."Repayment Frequency" = Loans."Repayment Frequency"::Quarterly then
                                    RunDate := CalcDate('1Q', RunDate);
                //Repayment Frequency

                until InstalNo = ReschedulingList."New Installments";

                if CreditAccounts.Get(Loans."Loan Account") then begin
                    if ProdF.Get(CreditAccounts."Product Type") then begin
                        if "Schedule Type" <> "Schedule Type"::Restructure then begin
                            if (ProdF."Nature of Loan Type" <> ProdF."Nature of Loan Type"::Defaulter) and
                               (ReschedulingList."Original Installments" < InstalNo) then
                                Error(Text0003);
                        end;
                    end;
                end;
            end;
        end;
    end;
}

