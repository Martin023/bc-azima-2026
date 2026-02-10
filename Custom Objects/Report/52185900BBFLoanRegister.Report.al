#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185900 "BBF Loan Register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/BBF Loan Register.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            //DataItemTableView = where(Posted = filter(Yes));
            RequestFilterFields = "Application Date", "Employer Code", "Member No.", "Loan Product Type";

            column(LoanNo_Loans; Loans."Loan No.")
            {
            }
            column(ApplicationDate_Loans; Loans."Application Date")
            {
            }

            column(LoanProductType_Loans; Loans."Loan Product Type")
            {
            }
            column(LoanProductTypeName_Loans; Loans."Loan Product Type Name")
            {
            }
            column(MemberNo_Loans; Loans."Member No.")
            {
            }
            column(MemberName_Loans; Loans."Member Name")
            {
            }
            column(Installemnt; Loans.Installments)
            {
            }
            column(RequestedAmount; Loans."Requested Amount")
            {
            }
            column(ApprovedAmount; Loans."Approved Amount")
            {
            }
            column(OutBal; Loans."Outstanding Balance")
            {
            }
            column(OutInt; Loans."Outstanding Interest")
            {
            }
            column(OutBill; Loans."Outstanding Bills")
            {
            }
            column(Picture; Company.Picture)
            {
            }
            column(Address; Company.Address)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(EmployerLoanNo; Loans."Employer Loan No.")
            {
            }
            column(StaffNo_Loans; Loans."Staff No")
            {
            }
            column(BatchNo_Loans; Loans."Batch No.")
            {
            }
            column(DisbursementDate_Loans; Loans."Disbursement Date")
            {
            }
            column(dob; DOB)
            {
            }
            column(IDNo; IDNo)
            {
            }
            column(Gender; Gender)
            {
            }
            column(ReaminingInstallments; ReaminingInstallments)
            {
            }
            column(Interest_Loans; Loans.Interest)
            {
            }

            trigger OnAfterGetRecord()
            begin

                Member.Reset;
                if Member.Get(Loans."Member No.") then begin
                    DOB := Member."Date of Birth";
                    IDNo := Member."Primary Identification";

                    if Member.Gender = Member.Gender::Female then
                        Gender := 'F';
                    if Member.Gender = Member.Gender::Male then
                        Gender := 'M';
                end;

                if GenerateSheduleB then begin
                    LoanRescheduling.Reset;
                    LoanRescheduling.SetRange(LoanRescheduling."Loan No.", "Loan No.");
                    LoanRescheduling.SetRange(LoanRescheduling.Rescheduled, true);
                    if not LoanRescheduling.Find('-') then begin
                        LRepaymentSchedule.Reset;
                        LRepaymentSchedule.SetRange(LRepaymentSchedule."Loan No.", "Loan No.");
                        if LRepaymentSchedule.Find('-') then LRepaymentSchedule.DeleteAll;
                        //GenerateSchedule(Loans);
                    end;
                end;

                ReaminingInstallments := 0;
                Schedule.Reset;
                Schedule.SetRange("Loan No.", Loans."Loan No.");
                Schedule.SetFilter("Repayment Date", '>=%1', Today);
                if Schedule.FindFirst then
                    ReaminingInstallments := Schedule.Count;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field("Generate Shedule"; GenerateSheduleB)
                {
                    ApplicationArea = Basic;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        Company.Get;
        //Company.CALCFIELDS(Company.Picture);
    end;

    var
        ProductType: Text;
        MemberBiodata: Text;
        Company: Record "Company Information";
        Member: Record "Members";
        DOB: Date;
        IDNo: Code[30];
        Gender: Text;
        Schedule: Record "Ideal Repayment Schedule";
        ReaminingInstallments: Integer;
        LoanRescheduling: Record "Loan Rescheduling";
        LRepaymentSchedule: Record "Ideal Repayment Schedule";
        GenerateSheduleB: Boolean;

    local procedure GenerateSchedule(Loans: Record Loans)
    var
        RSchedule: Record "Ideal Repayment Schedule";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        RepaymentDate: Date;
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
        GeneralSetUp: Record "General Set-Up";
        GenSetup: Record "General Set-Up";
        LoansR: Record Loans;
    begin
        begin
            if (Loans.Interest = 0) or (Loans.Installments = 0) or (Loans."Disbursement Date" = 0D) then begin
                //do nothing
            end else begin
                QCounter := 0;
                QCounter := 3;

                GenSetup.Get;

                LoansR.Reset;
                LoansR.SetRange(LoansR."Loan No.", Loans."Loan No.");
                if LoansR.Find('-') then begin

                    Loans.TestField("Disbursement Date");

                    LoanAmount := LoansR."Approved Amount";
                    if LoansR."Loan Rescheduled" then begin

                        InterestRate := LoansR.Interest;
                    end else
                        InterestRate := LoansR.Interest;
                    RepayPeriod := LoansR.Installments;
                    InitialInstal := LoansR.Installments;
                    LBalance := LoansR."Approved Amount";
                    //RunDate:="Repayment Start Date";
                    RunDate := CalcDate('1M', CalcDate('<CM>', Loans."Disbursement Date"));

                    InstalNo := 0;

                    //Repayment Frequency
                    repeat
                        InstalNo := InstalNo + 1;

                        //kma
                        if Loans."Interest Calculation Method" = Loans."interest calculation method"::Amortised then begin
                            Loans.TestField(Interest);
                            Loans.TestField(Installments);
                            TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -(RepayPeriod))) * (LoanAmount), 0.0001, '>');
                            LInterest := ROUND(LBalance / 100 / 12 * InterestRate, 0.0001, '>');
                            LPrincipal := TotalMRepay - LInterest;
                        end;

                        if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Straight Line" then begin
                            Loans.TestField(Interest);
                            Loans.TestField(Installments);
                            LPrincipal := LoanAmount / RepayPeriod;
                            LInterest := (InterestRate / 12 / 100) * LoanAmount;
                            //Grace Period Interest
                            //LInterest:=(LInterest*InitialInstal)/(InitialInstal-InitialGraceInt);
                        end;

                        if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Reducing Balance" then begin
                            Loans.TestField(Interest);
                            Loans.TestField(Installments);
                            LPrincipal := LoanAmount / RepayPeriod;
                            LInterest := (InterestRate / 12 / 100) * LBalance;
                        end;

                        if Loans."Interest Calculation Method" = Loans."interest calculation method"::"Reducing Flat" then begin
                            Loans.TestField(Interest);
                            Loans.TestField(Installments);
                            LPrincipal := ROUND(LoanAmount / RepayPeriod, 1.0, '>');
                            LInterest := ROUND(((LoanAmount * InterestRate / 12 / 100) + (LPrincipal * InterestRate / 12 / 100)) / 2, 1.0, '>');
                            Loans.Repayment := LPrincipal + LInterest;
                        end;
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
                        RSchedule."Loan No." := Loans."Loan No.";
                        RSchedule."Loan Amount" := LoanAmount;
                        RSchedule."Instalment No" := InstalNo;
                        RSchedule."Repayment Date" := RunDate;
                        RSchedule."Member No." := Loans."Member No.";
                        RSchedule."Loan Category" := Loans."Loan Product Type";
                        RSchedule."Monthly Repayment" := LInterest + LPrincipal;
                        ;
                        RSchedule."Monthly Interest" := LInterest;
                        RSchedule."Principal Repayment" := LPrincipal;
                        RSchedule.Insert;


                        //Repayment Frequency
                        if Loans."Repayment Frequency" = Loans."repayment frequency"::Daily then
                            RunDate := CalcDate('1D', RunDate)
                        else
                            if Loans."Repayment Frequency" = Loans."repayment frequency"::Weekly then
                                RunDate := CalcDate('1W', RunDate)
                            else
                                if Loans."Repayment Frequency" = Loans."repayment frequency"::Monthly then
                                    RunDate := CalcDate('1M', RunDate)
                                else
                                    if Loans."Repayment Frequency" = Loans."repayment frequency"::Quarterly then
                                        RunDate := CalcDate('1Q', RunDate)
                                    else
                                        if Loans."Repayment Frequency" = Loans."repayment frequency"::"Bi-Annual" then
                                            RunDate := CalcDate('6M', RunDate)
                                        else
                                            if Loans."Repayment Frequency" = Loans."repayment frequency"::Yearly then
                                                RunDate := CalcDate('1Y', RunDate);

                    until LBalance < 1
                end;
            end;
        end;
    end;
}
