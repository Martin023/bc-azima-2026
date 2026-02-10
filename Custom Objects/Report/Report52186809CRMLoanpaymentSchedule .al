#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186084 "CRM Loan RePayment Schedule"
{
    DefaultLayout = RDLC;
    Caption = 'CRM Loan RePayment Schedule';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-kenpipe-2024/Layout/CRM Loan RePayment Schedule.rdl';
    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Loan No.";
            column(ReportForNavId_4645; 4645)
            {
            }
            column(Loans_Loans_Interest; Loans.Interest)
            {
                DecimalPlaces = 2 : 2;
            }
            column(Loans_Loans__Approved_Amount_; Loans."Approved Amount")
            {
            }
            column(Loan_Product_Type; "Loan Product Type")
            {

            }
            column(Loans_Loans__Loan_Product_Type_Name_; Loans."Loan Product Type Name")
            {
            }
            column(Loans_Loans__Client_Name_; Loans."Member Name")
            {
            }
            column(Loans_Loans__Client_Code_; Loans."Member No.")
            {
            }
            column(Loans__Repayment_Method_; Loans."Interest Calculation Method")
            {
            }

            column(Loans_Loans__Loan__No__; Loans."Loan No.")
            {
            }

            column(COMPANY_NAME; COMPANYNAME)
            {
            }
            column(Address; CompanyInformation.Address)
            {
            }
            column(Picture; CompanyInformation.Picture)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {

            }
            column(CompanyTelephone; CompanyTelephone)
            {

            }
            column(LoanBal; LoanBal)
            {

            }
            dataitem("Ideal Repayment Schedule"; "Ideal Repayment Schedule")
            {
                DataItemLink = "Loan No." = field("Loan No.");
                DataItemTableView = sorting("Loan No.", "Member No.", "Repayment Date");
                RequestFilterFields = "Member No.", "Loan Category";
                column(ReportForNavId_9169; 9169)
                {
                }
                column(ROUND__Monthly_Repayment__10_____; ROUND("Monthly Repayment"))
                {
                }
                column(FORMAT__Repayment_Date__0_4_; Format("Repayment Date", 0, 4))
                {
                }
                column(ROUND__Principal_Repayment__10_____; ROUND("Principal Repayment"))
                {
                }
                column(ROUND__Monthly_Interest__10_____; ROUND("Monthly Interest"))
                {
                }
                column(LoanBalance; ROUND(LoanBalance))
                {
                }
                column(PrinciplPaid; PrinciplPaid)
                {

                }
                column(InterrePaid; InterrePaid)
                {

                }
                column(ActualPaidAmt; ActualPaidAmt)
                {

                }
                column(VarianceAmt; VarianceAmt)
                {

                }
                column(Loan_Repayment_Schedule__Repayment_Code_; "Repayment Code")
                {
                }
                column(ROUND__Monthly_Repayment__10______Control1000000043; ROUND("Monthly Repayment", 10, '='))
                {
                }
                column(ROUND__Principal_Repayment__10______Control1000000014; ROUND("Principal Repayment", 10, '='))
                {
                }
                column(ROUND__Monthly_Interest__10______Control1000000015; ROUND("Monthly Interest", 10, '='))
                {
                }
                column(Monthly_RepaymentCaption; Monthly_RepaymentCaptionLbl)
                {
                }
                column(InterestCaption; InterestCaptionLbl)
                {
                }
                column(Principal_RepaymentCaption; Principal_RepaymentCaptionLbl)
                {
                }
                column(Due_DateCaption; Due_DateCaptionLbl)
                {
                }
                column(Loan_BalanceCaption; Loan_BalanceCaptionLbl)
                {
                }
                column(Loan_RepaymentCaption; Loan_RepaymentCaptionLbl)
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(Loan_Repayment_Schedule_Loan_No_; "Loan No.")
                {
                }
                column(Loan_Repayment_Schedule_Member_No_; "Member No.")
                {
                }
                column(Loan_Repayment_Schedule_Repayment_Date; "Repayment Date")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    StartDate := 0D;
                    EndDate := 0D;
                    ActualPaidAmt := 0;
                    PrinciplPaid := 0;
                    ActBal := 0;
                    InterrePaid := 0;
                    VarianceAmt := 0;
                    StartDate := CalcDate('-cm', "Ideal Repayment Schedule"."Repayment Date");
                    EndDate := CalcDate('CM', "Ideal Repayment Schedule"."Repayment Date");
                    LoanBal := 0;

                    i := i + 1;
                    if i = 1 then
                        startCalDate := CalcDate('-cm', "Ideal Repayment Schedule"."Repayment Date");

                    TotalPrincipalRepayment := TotalPrincipalRepayment + "Ideal Repayment Schedule"."Principal Repayment";
                    if "Ideal Repayment Schedule"."Reset Schedule" then begin

                        if "Ideal Repayment Schedule"."Reset Doc No." = PreviousDocNo then begin
                            //MESSAGE('%1',TotalPrincipalRepayment);
                            TotalPrincipalRepayment2 := TotalPrincipalRepayment2 + "Ideal Repayment Schedule"."Principal Repayment";
                            i2 := i2 + 1;
                            if i2 = 1 then
                                LoanBalance := "Ideal Repayment Schedule"."Loan Amount"
                            else
                                LoanBalance := "Ideal Repayment Schedule"."Loan Amount" - TotalPrincipalRepayment2 + "Ideal Repayment Schedule"."Principal Repayment";
                        end else begin
                            i2 := 1;
                            //TotalPrincipalRepayment2:="Ideal Repayment Schedule"."Principal Repayment";
                            TotalPrincipalRepayment2 := TotalPrincipalRepayment2 + "Ideal Repayment Schedule"."Principal Repayment";
                            LoanBalance := "Ideal Repayment Schedule"."Loan Amount" - TotalPrincipalRepayment2 + "Ideal Repayment Schedule"."Principal Repayment";
                            //MESSAGE('%1',PreviousDocNO);
                        end;
                    end else begin
                        if i = 1 then
                            LoanBalance := "Ideal Repayment Schedule"."Loan Amount"
                        else begin
                            LoanBalance := "Ideal Repayment Schedule"."Loan Amount" - TotalPrincipalRepayment + "Ideal Repayment Schedule"."Principal Repayment";
                        end;
                    end;
                    if i = 1 then begin

                        CreditLedger.Reset();
                        CreditLedger.SetRange(CreditLedger."Loan No", Loans."Loan No.");
                        CreditLedger.SetRange("Posting Date", StartDate, EndDate);
                        CreditLedger.SetRange("Transaction Type", CreditLedger."Transaction Type"::Repayment);
                        if CreditLedger.Find('-') then begin
                            CreditLedger.CalcSums("Credit Amount");
                            PrinciplPaid := CreditLedger."Credit Amount";
                        end;

                    end else begin
                        CreditLedger.Reset();
                        CreditLedger.SetRange(CreditLedger."Loan No", Loans."Loan No.");
                        CreditLedger.SetRange("Posting Date", StartDate, EndDate);
                        CreditLedger.SetRange("Transaction Type", CreditLedger."Transaction Type"::Repayment);
                        if CreditLedger.Find('-') then begin
                            CreditLedger.CalcSums("Credit Amount");
                            PrinciplPaid := CreditLedger."Credit Amount";
                        end;

                    end;
                    if i = 1 then begin
                        CreditLedger.Reset();
                        CreditLedger.SetRange(CreditLedger."Loan No", Loans."Loan No.");
                        CreditLedger.SetRange("Posting Date", StartDate, EndDate);
                        CreditLedger.SetRange("Transaction Type", CreditLedger."Transaction Type"::"Interest Paid");
                        if CreditLedger.Find('-') then begin
                            CreditLedger.CalcSums("Credit Amount");
                            InterrePaid := CreditLedger."Credit Amount";
                        end;

                    end else begin
                        CreditLedger.Reset();
                        CreditLedger.SetRange(CreditLedger."Loan No", Loans."Loan No.");
                        CreditLedger.SetRange("Posting Date", StartDate, EndDate);
                        CreditLedger.SetRange("Transaction Type", CreditLedger."Transaction Type"::"Interest Paid");
                        if CreditLedger.Find('-') then begin
                            CreditLedger.CalcSums("Credit Amount");
                            InterrePaid := CreditLedger."Credit Amount";
                        end;

                    end;
                    if i = 1 then begin
                        LoansRec.Reset();
                        LoansRec.SetRange("Loan No.", Loans."Loan No.");
                        if LoansRec.Find('-') then begin
                            LoanBal := LoansRec."Approved Amount" - (InterrePaid + PrinciplPaid);
                        end;
                    end else begin
                        CreditLedger.Reset();
                        CreditLedger.SetRange(CreditLedger."Loan No", Loans."Loan No.");
                        CreditLedger.SetRange("Posting Date", startCalDate, EndDate);
                        CreditLedger.SetFilter(CreditLedger."Transaction Type", '=%1|=%2', CreditLedger."Transaction Type"::"Interest Paid", CreditLedger."Transaction Type"::Repayment);
                        if CreditLedger.Find('-') then begin
                            CreditLedger.CalcSums("Credit Amount");
                            ActBal := CreditLedger."Credit Amount";
                        end;
                        LoansRec.Reset();
                        LoansRec.SetRange("Loan No.", Loans."Loan No.");
                        LoansRec.SetFilter("Date Filter", '..%1', EndDate);
                        if LoansRec.Find('-') then begin
                            LoansRec.CalcFields(LoansRec."Outstanding Balance", LoansRec."Outstanding Interest");
                            LoanBal := LoansRec."Outstanding Balance" + LoansRec."Outstanding Interest";
                            LoanBal := LoanBal - ActBal
                        end;

                    end;
                    ActualPaidAmt := PrinciplPaid + InterrePaid;
                    VarianceAmt := ActualPaidAmt - "Ideal Repayment Schedule"."Monthly Repayment";
                    CumInterest := CumInterest + "Ideal Repayment Schedule"."Monthly Interest";
                    CumMonthlyRepayment := CumMonthlyRepayment + "Ideal Repayment Schedule"."Monthly Repayment";
                    CumPrincipalRepayment := CumPrincipalRepayment + "Ideal Repayment Schedule"."Principal Repayment";
                end;

                trigger OnPreDataItem()
                begin

                end;
            }
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
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompName := CompanyInformation.Name;
        Address := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";


    end;

    trigger OnPostReport()
    var
        myInt: Integer;
    begin

    end;

    var
        LastFieldNo: Integer;

        FooterPrinted: Boolean;
        startCalDate: Date;
        VarianceAmt: Decimal;
        LoanBal: Decimal;
        ActBal: Decimal;
        LoansRec: Record Loans;
        CreditLedger: Record "Credit Ledger Entry";
        PrinciplPaid: Decimal;
        StartDate: Date;
        EndDate: Date;
        InterrePaid: Decimal;
        ActualPaidAmt: Decimal;
        TotalFor: label 'Total for ';
        CommunicationOnline: Text[100];
        CompanyTelephone: Text[100];
        Address: Text[100];
        CompName: Text[100];
        Duration: Integer;
        CompanyInformation: Record "Company Information";
        MemberLoan: Record Customer;
        IssuedDate: Date;
        LoanCategory: Record "Loan Charges";
        i: Integer;
        LoanBalance: Decimal;
        CumInterest: Decimal;
        CumMonthlyRepayment: Decimal;
        CumPrincipalRepayment: Decimal;
        j: Integer;
        LoanApp: Record Loans;
        GroupName: Text[70];
        TotalPrincipalRepayment: Decimal;
        Rate: Decimal;
        BankDetails: Text[250];
        Cust: Record Customer;
        Intallments__Months_CaptionLbl: label 'Intallments (Months)';
        Disbursment_DateCaptionLbl: label 'Disbursment Date';
        Current_InterestCaptionLbl: label 'Current Interest';
        Loan_AmountCaptionLbl: label 'Loan Amount';
        Loan_ProductCaptionLbl: label 'Loan Product';
        Loan_No_CaptionLbl: label 'Loan No.';
        Account_No_CaptionLbl: label 'Account No.';
        Monthly_RepaymentCaptionLbl: label 'Monthly Repayment';
        InterestCaptionLbl: label 'Interest';
        Principal_RepaymentCaptionLbl: label 'Principal Repayment';
        Due_DateCaptionLbl: label 'Due Date';
        Loan_BalanceCaptionLbl: label 'Loan Balance';
        Loan_RepaymentCaptionLbl: label 'Loan Repayment';
        TotalCaptionLbl: label 'Total';
        i2: Integer;
        TotalPrincipalRepayment2: Decimal;
        PreviousDocNo: Code[10];
}
