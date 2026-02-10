page 52186341 "Loan Calculator"
{
    PageType = Card;
    SourceTable = "Loan Calculator";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Employer Code"; Rec."Employer Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Deposit Contribution"; Rec."Deposit Contribution")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Loan Product Type"; Rec."Loan Product Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Requested Amount"; Rec."Requested Amount")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Loan Span"; Rec."Loan Span")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Loan Product Type Name"; Rec."Loan Product Type Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Max. Loan Allowed"; Rec."Max. Loan Allowed")
                {
                    ApplicationArea = Basic, Suite;
                }

                field(Interest; Rec.Interest)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }


                field("Deposits Multiplied"; Rec."Deposits Multiplied")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field(Installments; Rec.Installments)
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("Loan Repayment"; Rec."Loan Principle Repayment")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                field("Loan Interest Repayment"; Rec."Loan Interest Repayment")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
                group("Salary Details")
                {
                }
                field("Basic Salary"; Rec."Basic Salary")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Earnings"; Rec."Total Earnings")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Total Deductions"; Rec."Total Deductions")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Net Income"; Rec."Net Income")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("1/3 of Basic"; Rec."1/3 of Basic")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Amount Available for Borrowing"; Rec."Amount Available for Borrowing")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Salary Qualification"; rec."Salary Qualification")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Deposit Qualification"; rec."Deposit Qualification")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Recommended Amount"; Rec."Recommended Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Calculate Qualification")
            {
                ApplicationArea = all;
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                    ProductFactory: Record "Product Factory";
                    TariffDetails: Record "Tiered Charges Lines";
                    DisposableIncome: Decimal;
                    Thirdbasic: Decimal;
                    LoansREc: Record Loans;
                    RelatedProduct: Record "Related Product";
                    SelfGuaranteedBal: Decimal;
                    offseBa: Boolean;
                    MultP: Integer;
                    CurrLoanBal: Decimal;
                    OffsetBalance: Decimal;
                    TopupRepayments: Decimal;
                    MemberDeposits: Decimal;
                    RelatedBal: Decimal;
                    SavingsAcc: Record "Savings Accounts";
                    Deposit_Multiplier: Decimal;
                begin
                    Rec.TestField("Member No.");
                    Rec.TestField("Requested Amount");
                    ProductFactory.Get(Rec."Loan Product Type");
                    DisposableIncome := 0;
                    Thirdbasic := 0;
                    SavingsAcc.Reset();
                    SavingsAcc.SetRange("Member No.", Rec."Member No.");
                    SavingsAcc.SetRange("Product Category", SavingsAcc."Product Category"::"BOSA Deposits");
                    if SavingsAcc.FindFirst() then begin
                        SavingsAcc.CalcFields(SavingsAcc."Balance (LCY)");
                        MemberDeposits := SavingsAcc."Balance (LCY)";
                    end;
                    Thirdbasic := (1 / 3) * Rec."Basic Salary";
                    Rec."1/3 of Basic" := Thirdbasic;
                    DisposableIncome := ((Rec."Basic Salary" + Rec."Total Earnings") - (Rec."Total Deductions" + Thirdbasic));
                    Rec."Net Income" := ((Rec."Basic Salary" + Rec."Total Earnings") - (Rec."Total Deductions"));
                    Rec."Salary Qualification" := DisposableIncome;
                    // if ProductFactory."Source Unit" = ProductFactory."Source Unit"::"HR LOANS" then begin
                    //     Rec."Salary Qualification" := DisposableIncome * ProductFactory."Staff Salary Multiplier"
                    // end else begin
                    //     LoansREc.Reset();
                    //     LoansREc.SetRange(LoansREc."Member No.", Rec."Member No.");
                    //     LoansREc.SetRange(Posted, true);
                    //     LoansREc.SetFilter(LoansREc."Approved Amount", '>%1', Rec."Requested Amount");
                    //     if LoansREc.FindFirst() then begin
                    //         if ProductFactory.Get(Rec."Loan Product Type") then begin
                    //             if ProductFactory."Loan Exclusive Factor" <> '' then begin
                    //                 SavAcc.Reset;
                    //                 SavAcc.SetRange("Member No.", Rec."Member No.");
                    //                 SavAcc.SetRange("Product Category", SavAcc."Product Category"::"BOSA Deposits");
                    //                 if SavAcc.Find('-') then begin
                    //                     SavAcc.CalcFields(Balance);
                    //                     TariffDetails.Reset;
                    //                     TariffDetails.SetRange(TariffDetails.Code, ProductFactory."Loan Exclusive Factor");
                    //                     if TariffDetails.Find('-') then begin
                    //                         repeat
                    //                             if (SavAcc.Balance >= TariffDetails."Lower Limit") and (SavAcc.Balance <= TariffDetails."Upper Limit") then begin
                    //                                 if TariffDetails."Use Percentage" = true then begin
                    //                                     Rec."Salary Qualification" := DisposableIncome * TariffDetails.Percentage * 0.01;
                    //                                 end else begin
                    //                                     Rec."Salary Qualification" := TariffDetails."Charge Amount" * DisposableIncome;
                    //                                 end;
                    //                             end;
                    //                         until TariffDetails.Next = 0;
                    //                     end;
                    //                 end;

                    //             end;
                    //         end;
                    //     end else
                    //         if ProductFactory.get(Rec."Loan Product Type") then begin
                    //             if ProductFactory."Loan Prorata Factor" <> '' then begin
                    //                 SavAcc.Reset;
                    //                 SavAcc.SetRange("Member No.", Rec."Member No.");
                    //                 SavAcc.SetRange("Product Category", SavAcc."Product Category"::"BOSA Deposits");
                    //                 if SavAcc.Find('-') then begin
                    //                     SavAcc.CalcFields(Balance);
                    //                     TariffDetails.Reset;
                    //                     TariffDetails.SetRange(TariffDetails.Code, ProductFactory."Loan Prorata Factor");
                    //                     if TariffDetails.Find('-') then begin
                    //                         repeat
                    //                             if (SavAcc.Balance >= TariffDetails."Lower Limit") and (SavAcc.Balance <= TariffDetails."Upper Limit") then begin
                    //                                 if TariffDetails."Use Percentage" = true then begin
                    //                                     Rec."Salary Qualification" := DisposableIncome * TariffDetails.Percentage * 0.01;
                    //                                 end else begin
                    //                                     Rec."Salary Qualification" := TariffDetails."Charge Amount" * DisposableIncome;
                    //                                 end;
                    //                             end;
                    //                         until TariffDetails.Next = 0;
                    //                     end;
                    //                 end;

                    //             end;
                    //         end;
                    // end;

                    LoansREc.Reset;
                    LoansREc.SetRange(LoansREc."Member No.", Rec."Member No.");
                    LoansREc.SetRange(LoansREc.Posted, true);
                    LoansREc.SetFilter("Outstanding Balance", '>0');
                    LoansREc.SetRange("Self Guarantee", true);
                    if LoansREc.Find('-') then begin
                        repeat
                            LoansREc.CalcFields(LoansREc."Outstanding Balance");
                            SelfGuaranteedBal := SelfGuaranteedBal + LoansREc."Outstanding Balance";
                        until LoansREc.Next = 0;
                    end;
                    LoansREc.Reset();
                    LoansREc.SetRange(LoansREc."Member No.", Rec."Member No.");
                    LoansREc.SetRange(Posted, true);
                    LoansREc.SetFilter("Outstanding Balance", '>%1', 0);
                    LoansREc.SetRange("Source Unit", LoansREc."Source Unit"::BOSA);
                    if LoansREc.FindFirst() then begin
                        repeat
                            LoansTopup.Reset();
                            LoansTopup.SetRange(LoansTopup."Loan Top Up", LoansREc."Loan No.");
                            if not LoansTopup.FindFirst() then begin
                                offseBa := true;
                            end;
                        until LoansREc.Next() = 0;
                    end;
                    RelatedProduct.Reset;
                    RelatedProduct.SetRange("Product Code", ProductFactory."Product ID");
                    if RelatedProduct.Find('-') then begin
                        repeat
                            LoansREc.CalcFields("Total Loan Balance");
                            LoansREc.Reset;
                            LoansREc.SetRange(LoansREc."Member No.", Rec."Member No.");
                            LoansREc.SetRange(LoansREc.Posted, true);
                            LoansREc.SetRange(LoansREc."Loan Product Type", RelatedProduct."Related Product Code");
                            LoansREc.SetFilter("Total Loan Balance", '>0');
                            //Loan.SETFILTER("Outstanding Balance",'>0');
                            if LoansREc.Find('-') then begin
                                repeat
                                    if ProductFactory.Get(rec."Loan Product Type") then
                                        //if ProductFactory."Ordinary Deposits Multiplier" >= 4 then
                                        MultP := ProductFactory."Ordinary Deposits Multiplier";// 4;
                                    LoansREc.CalcFields("Outstanding Balance", "Outstanding Interest");
                                    RelatedBal := RelatedBal + LoansREc."Outstanding Balance" + LoansREc."Outstanding Interest";
                                until LoansREc.Next = 0;
                            end;
                            //Topped up loans relatedhyu product
                            LoansTopup.Reset;
                            LoansTopup.SetRange(LoansTopup."Loan No.", Rec."Loan No.");
                            LoansTopup.SetRange(LoansTopup."Client Code", Rec."Member No.");
                            LoansTopup.SetRange(LoansTopup."Loan Type", RelatedProduct."Related Product Code");
                            if LoansTopup.FindFirst() then begin
                                repeat
                                    CurrLoanBal := CurrLoanBal + LoansTopup."Monthly Repayment";
                                    OffsetBalance := OffsetBalance + LoansTopup."Outstanding Balance";
                                until LoansTopup.Next = 0;
                            end;
                        until RelatedProduct.Next = 0;
                    end;
                    if ProductFactory.Get(Rec."Loan Product Type") then
                        if offseBa = true then
                            Deposit_Multiplier := (MemberDeposits + Rec."Deposit Purchase") * ProductFactory."Subsequent Multiplier"
                        else
                            if MultP >= 40000 then begin
                                if ProductFactory.Get(Rec."Loan Product Type") then
                                    Deposit_Multiplier := (MemberDeposits + rec."Deposit Purchase") * ProductFactory."Ordinary Deposits Multiplier";
                            end else begin
                                if ProductFactory.Get(Rec."Loan Product Type") then begin
                                    Deposit_Multiplier := (MemberDeposits + Rec."Deposit Purchase") * ProductFactory."Ordinary Deposits Multiplier";
                                end;
                            end;
                    if ProductFactory."Source Unit" = ProductFactory."Source Unit"::"HR LOANS" then
                        Rec."Deposit Qualification" := ProductFactory."Staff Salary Multiplier" * MemberDeposits
                    else
                        rec."Deposit Qualification" := Deposit_Multiplier;
                    RelatedBal := RelatedBal - OffsetBalance;
                    if RelatedBal < 0 then
                        RelatedBal := 0;
                    //MESSAGE('OffsetBalance %1 RelatedBal %2',OffsetBalance,RelatedBal);
                    if offseBa = true then
                        Rec."Deposit Qualification" := (Deposit_Multiplier - RelatedBal)
                    else
                        Rec."Deposit Qualification" := Rec."Deposit Qualification" - (RelatedBal + SelfGuaranteedBal);
                    if Rec."Salary Qualification" < Rec."Deposit Qualification" then
                        Rec."Recommended Amount" := Rec."Salary Qualification"
                    else
                        Rec."Recommended Amount" := Rec."Deposit Qualification";
                    if Rec."Requested Amount" < Rec."Recommended Amount" then
                        Rec."Recommended Amount" := Rec."Requested Amount";
                    Rec.Modify();
                    Message('Calculations Done');

                end;
            }
            action("Generate Repayment  Schedule")
            {
                ApplicationArea = Basic, Suite;
                Image = ReceivableBill;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //Delete schedule
                    RSchedule.Reset;
                    RSchedule.SetRange(RSchedule."Loan No.", Rec."Loan No.");
                    RSchedule.DeleteAll;

                    QCounter := 0;
                    QCounter := 3;
                    LoansR.Reset;
                    LoansR.SetRange(LoansR."Loan No.", Rec."Loan No.");
                    if LoansR.Find('-') then begin

                        Rec.TestField("Disbursement Date");
                        Rec.TestField("Repayment Start Date");


                        LoanAmount := LoansR."Recommended Amount";//"Approved Amount";
                        InterestRate := LoansR.Interest;
                        RepayPeriod := LoansR.Installments;
                        InitialInstal := LoansR.Installments;
                        LBalance := LoansR."Recommended Amount";//"Approved Amount";
                        RunDate := Rec."Repayment Start Date";

                        InstalNo := 0;
                        //Repayment Frequency
                        repeat
                            InstalNo := InstalNo + 1;
                            //kma
                            if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::Amortised then begin
                                Rec.TestField(Interest);
                                Rec.TestField(Installments);
                                TotalMRepay := Round((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                                LInterest := Round(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                                LPrincipal := TotalMRepay - LInterest;
                            end;

                            if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Straight Line" then begin
                                Rec.TestField(Interest);
                                Rec.TestField(Installments);
                                LPrincipal := LoanAmount / RepayPeriod;
                                LInterest := (InterestRate / 12 / 100) * LoanAmount;
                                //Grace Period Interest
                                //LInterest:=(LInterest*InitialInstal)/(InitialInstal-InitialGraceInt);
                            end;

                            if (Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Reducing Balance") or
                              (Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Reducing Flat") then begin
                                Rec.TestField(Interest);
                                Rec.TestField(Installments);
                                LPrincipal := LoanAmount / RepayPeriod;
                                LInterest := Round((InterestRate / 12 / 100) * LBalance, 1.0, '>');
                            end;
                            /*
                            IF "Interest Calculation Method"="Interest Calculation Method"::"Straight Line" THEN BEGIN
                            TESTFIELD(Repayment);
                            IF LBalance < Repayment THEN
                            LPrincipal:=LBalance
                            ELSE
                            LPrincipal:=Repayment;
                            LInterest:=Interest;
                            END;
                            */
                            //kma



                            //Grace Period
                            if GrPrinciple > 0 then begin
                                LPrincipal := 0
                            end else begin
                                //IF "Instalment Period" <> InPeriod THEN
                                LBalance := LBalance - LPrincipal;

                            end;

                            if GrInterest > 0 then
                                LInterest := 0;

                            GrPrinciple := GrPrinciple - 1;
                            GrInterest := GrInterest - 1;

                            Evaluate(RepayCode, Format(InstalNo));

                            RSchedule.Init;
                            RSchedule."Repayment Code" := RepayCode;
                            RSchedule."Loan No." := Rec."Loan No.";
                            RSchedule."Loan Amount" := LoanAmount;
                            RSchedule."Instalment No" := InstalNo;
                            RSchedule."Repayment Date" := RunDate;
                            RSchedule."Member No." := Rec."Member No.";
                            RSchedule."Loan Category" := Rec."Loan Product Type";
                            RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                            RSchedule."Monthly Interest" := LInterest;
                            RSchedule."Principal Repayment" := LPrincipal;
                            RSchedule.Insert;


                            //Repayment Frequency
                            if Rec."Repayment Frequency" = Rec."Repayment Frequency"::Daily then
                                RunDate := CalcDate('1D', RunDate)
                            else
                                if Rec."Repayment Frequency" = Rec."Repayment Frequency"::Weekly then
                                    RunDate := CalcDate('1W', RunDate)
                                else
                                    if Rec."Repayment Frequency" = Rec."Repayment Frequency"::Monthly then
                                        RunDate := CalcDate('1M', RunDate)
                                    else
                                        if Rec."Repayment Frequency" = Rec."Repayment Frequency"::Quarterly then
                                            RunDate := CalcDate('1Q', RunDate)
                                        else
                                            if Rec."Repayment Frequency" = Rec."Repayment Frequency"::"Bi-Annual" then
                                                RunDate := CalcDate('6M', RunDate)
                                            else
                                                if Rec."Repayment Frequency" = Rec."Repayment Frequency"::Yearly then
                                                    RunDate := CalcDate('1Y', RunDate);

                        until LBalance < 1

                    end;

                    Commit;
                    // LoanApp.Reset;
                    // LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                    // if LoanApp.Find('-') then
                    // REPORT.Run(52186072, true, false, LoanApp);
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No.", Rec."Loan No.");
                    if LoanApp.Find('-') then begin
                        LoansTbl.Reset;
                        LoansTbl.SetRange(LoansTbl."Loan No.", Rec."Loan No.");
                        if LoansTbl.FindFirst() then begin
                            REPORT.Run(Report::"Ideal Repayment Schedule", true, false, LoansTbl);
                        end;
                    end;

                end;
            }
        }
    }

    var
        CustMembr: Record Members;
        LoanProcess: Codeunit "Loans Process";
        UpdateMember: Codeunit "DCS Management";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        // CustomApprovals: Codeunit "Custom Approvals Codeunit";
        GetScore: Codeunit "DCS Management";
        LoansR: Record "Loan Calculator";
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
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        LoansTbl: Record Loans;
        RSchedule: Record "Loan Repayment Schedule-Calc";
        LoanApp: Record "Loan Calculator";
        PartialSched: Record "Partial Disbursement Schedule";
        AppraisalDetailsSetup: Record "Appraisal Salary Set-up";
        AppraisalSalDetails: Record "Appraisal Salary Details";
        LReq: Record "Loan Mandatory Requirements";
        LoanGua: Record "Loan Guarantors and Security";
        Coll: Record "Loan Collateral";
        Found: Boolean;
        SavAcc: Record "Savings Accounts";
        ApplDocs: Record "Product Documents";
        LoanReqDocs: Record "Loan Required Documents";
        BusinessIncome: Record "Business Income";
        SendSMS: Codeunit SendSms;
        SourceType: Option "New Member","New Account","Loan Account Approval","Deposit Confirmation","Cash Withdrawal Confirm","Loan Application","Loan Appraisal","Loan Guarantors","Loan Rejected","Loan Posted","Loan defaulted","Salary Processing","Teller Cash Deposit"," Teller Cash Withdrawal","Teller Cheque Deposit","Fixed Deposit Maturity","InterAccount Transfer","Account Status","Status Order","EFT Effected"," ATM Application Failed","ATM Collection",MSACCO,"Member Changes";
        Members: Record Members;
        LoansTopup: Record "Loans Top up";
        ExternalComm: Record "Other Commitements Clearance";
        TotalOffset: Decimal;
        ProdFac: Record "Product Factory";
        Vend: Record Vendor;
        GLAcc: Record "G/L Account";
        PaymentMethods: Record "Payment Methods";
        LoanRepay: Decimal;
        RepMethods: Record "Payment Methods";
        CompInfo: Record "Company Information";
        EndDateSalo: Date;
        SalProc: Record "Salary Lines";
        BusAppr: Record "Financial Appraisal setup";
        BusApprDet: Record "Business Loan Appraisal";
        TotalLoans: Decimal;
        GenSetup: Record "General Set-Up";
        Cust: Record Customer;
        "******************************************************Controls": Integer;
        ApplicationDetailsEdit: Boolean;
        DisbursementEdit: Boolean;
        ApprovedEdit: Boolean;
}

