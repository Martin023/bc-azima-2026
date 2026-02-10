#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185424 "Generate Loans Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Generate Loans Schedule.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Outstanding Balance" = filter(> 0));//, "Disbursement Date" = filter(<> ""), "Repayment Start Date" = filter(<> ""), "Loan No." = const(LN00104522));
            column(ReportForNavId_2; 2)
            {
            }

            trigger OnAfterGetRecord()
            var
                ProductFactory: Record "Product Factory";
            begin

                RSchedule.Reset;
                RSchedule.SetRange(RSchedule."Loan No.", "Loan No.");
                RSchedule.DeleteAll;

                QCounter := 0;
                QCounter := 3;

                LoansR.Reset;
                LoansR.SetRange(LoansR."Loan No.", "Loan No.");
                if LoansR.Find('-') then begin

                    LoansR.TestField("Disbursement Date");
                    LoansR.TestField("Repayment Start Date");

                    LoanAmount := LoansR."Approved Amount";
                    InterestRate := LoansR.Interest;
                    RepayPeriod := LoansR.Installments;
                    InitialInstal := LoansR.Installments;
                    LBalance := LoansR."Approved Amount";
                    RunDate := "Repayment Start Date";

                    InstalNo := 0;

                    repeat
                        InstalNo := InstalNo + 1;

                        if "Interest Calculation Method" = "interest calculation method"::Amortised then begin
                            LoansR.TestField(Interest);
                            LoansR.TestField(Installments);
                            TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                            LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                            LPrincipal := TotalMRepay - LInterest;
                            Repayment := LPrincipal + LInterest;
                        end;

                        if "Interest Calculation Method" = "interest calculation method"::"Straight Line" then begin
                            LoansR.TestField(Interest);
                            LoansR.TestField(Installments);
                            LPrincipal := LoanAmount / RepayPeriod;
                            LInterest := (InterestRate / 12 / 100) * LoanAmount;
                        end;

                        if "Interest Calculation Method" = "interest calculation method"::"Reducing Balance" then begin
                            LoansR.TestField(Interest);
                            LoansR.TestField(Installments);
                            LPrincipal := LoanAmount / RepayPeriod;
                            LInterest := (InterestRate / 12 / 100) * LBalance;
                        end;

                        if "Interest Calculation Method" = "interest calculation method"::"Reducing Flat" then begin
                            LoansR.TestField(Repayment);
                            if LBalance < Repayment then
                                LPrincipal := LBalance
                            else
                                LPrincipal := Repayment;
                            LInterest := Interest;
                        end;

                        if GrPrinciple > 0 then begin
                            LPrincipal := 0
                        end else begin
                            LBalance := LBalance - LPrincipal;

                        end;

                        if GrInterest > 0 then
                            LInterest := 0;

                        GrPrinciple := GrPrinciple - 1;
                        GrInterest := GrInterest - 1;
                        Evaluate(RepayCode, Format(InstalNo));

                        RSchedule.Init;
                        RSchedule."Repayment Code" := RepayCode;
                        RSchedule."Loan No." := "Loan No.";
                        RSchedule."Loan Amount" := LoanAmount;
                        RSchedule."Instalment No" := InstalNo;
                        RSchedule."Repayment Date" := RunDate;
                        RSchedule."Member No." := "Member No.";
                        RSchedule."Loan Category" := "Loan Product Type";
                        RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                        RSchedule."Monthly Interest" := LInterest;
                        RSchedule."Principal Repayment" := LPrincipal;
                        RSchedule.Insert;

                        if "Repayment Frequency" = "repayment frequency"::Daily then
                            RunDate := CalcDate('1D', RunDate)
                        else
                            if "Repayment Frequency" = "repayment frequency"::Weekly then
                                RunDate := CalcDate('1W', RunDate)
                            else
                                if "Repayment Frequency" = "repayment frequency"::Monthly then
                                    RunDate := CalcDate('1M', RunDate)
                                else
                                    if "Repayment Frequency" = "repayment frequency"::Quarterly then
                                        RunDate := CalcDate('1Q', RunDate)
                                    else
                                        if "Repayment Frequency" = "repayment frequency"::"Bi-Annual" then
                                            RunDate := CalcDate('6M', RunDate)
                                        else
                                            if "Repayment Frequency" = "repayment frequency"::Yearly then
                                                RunDate := CalcDate('1Y', RunDate);
                    until LBalance < 1
                end;
                //Loans.Modify;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CustM: Record "Members";
        LoansR: Record Loans;
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
        RSchedule: Record "Ideal Repayment Schedule";
        LoanApp: Record Loans;
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
        Members: Record "Members";
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
}
