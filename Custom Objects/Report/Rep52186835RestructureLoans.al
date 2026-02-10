report 52186835 "Restructured Loans report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Restructured Loans report.rdl';
    dataset
    {
        dataitem("Loan Rescheduling"; "Loan Rescheduling")
        {
            RequestFilterFields = Status, Rescheduled;

            column(Loan_No_; "Loan No.")
            {
            }
            column(Member_No_; "Member No.")
            {
            }
            column(Member_Name; "Member Name")
            {

            }
            column(LoanType; LoanType)
            {

            }
            column(LoanProductName; LoanProductName)
            {

            }
            column(Employername; Employername)
            {

            }
            column(AppDate; AppDate)
            {

            }
            column(DOB; DOB)
            {

            }
            column(CompleDate; CompleDate)
            {

            }
            column(Original_Installments; "Original Installments")
            {

            }
            column(New_Installments; "New Installments")
            {

            }
            column(CommunicationOnline; CommunicationOnline)
            {

            }
            column(CompanyAddress; CompanyAddress)
            {

            }
            column(CompanyNam; CompanyNam)
            {

            }
            column(CompanyPic; CompanyInformation.Picture)
            {

            }
            column(InterestR; InterestR)
            {

            }
            column(ProrataAmt; ProrataAmt)
            {

            }
            column(AmtToped; AmtToped)
            {

            }
            column(Linterest; Linterest)
            {

            }
            column(Remaining_Installments; "Remaining Installments")
            {

            }
            column(ReQamt; ReQamt)
            {

            }
            column(ApprdAmt; ApprdAmt)
            {

            }
            column(LoaMaxperiod; LoaMaxperiod)
            {

            }
            column(LastPrRep; LastPrRep)
            {

            }
            column(lastP; lastP)
            {

            }
            column(LastInPaid; LastInPaid)
            {

            }
            column(ExpPramt; ExpPramt)
            {

            }
            column(ExpInterest; ExpInterest)
            {

            }
            column(LNBalance; LNBalance)
            {

            }
            column(MemberDeposits; MemberDeposits)
            {

            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                LoanProductName := '';
                LoanType := '';
                DOB := '';
                AppDate := '';
                LoanType := '';
                LoanProductName := '';
                Employername := '';
                Linterest := 0;
                AmtToped := 0;
                ProrataAmt := 0;
                LNBalance := 0;
                lastP := '';
                LastPrRep := 0;
                InterestR := 0;
                LastInPaid := 0;
                MemberDeposits := 0;
                ExpPramt := 0;
                LoanProductName := '';
                LoanType := '';
                DOB := '';
                LoaMaxperiod := 0;
                ReQamt := 0;
                ExpInterest := 0;
                InterestR := 0;
                ApprdAmt := 0;
                Loansrec.Reset();
                Loansrec.SetRange("Loan No.", "Loan Rescheduling"."Loan No.");
                if Loansrec.FindFirst() then begin
                    Loansrec.CalcFields(Loansrec."Outstanding Balance");
                    LoanType := Loansrec."Loan Product Type";
                    LoanProductName := Loansrec."Loan Product Type Name";
                    AppDate := GlobalFunc.FormatDate(Loansrec."Application Date");
                    CompleDate := GlobalFunc.FormatDate(Loansrec."Expected Date of Completion");
                    InterestR := Loansrec.Interest;
                    ReQamt := Loansrec."Requested Amount";
                    ExpPramt := Loansrec."Loan Principle Repayment";
                    ExpInterest := Loansrec."Loan Interest Repayment";
                    LNBalance := Loansrec."Outstanding Balance";
                    ApprdAmt := Loansrec."Approved Amount";
                    if productFac.Get(Loansrec."Loan Product Type") then begin
                        LoaMaxperiod := productFac."Ordinary Default Intallments";
                    end;
                    SavingAcc.Reset();
                    SavingAcc.SetRange("Member No.", Loansrec."Member No.");
                    SavingAcc.SetRange("Product Category", SavingAcc."Product Category"::"BOSA Deposits");
                    if SavingAcc.FindFirst() then begin
                        SavingAcc.CalcFields(Balance);
                        MemberDeposits := SavingAcc.Balance;
                    end;
                    Creditledger.Reset();
                    Creditledger.SetRange("Loan No", Loansrec."Loan No.");
                    Creditledger.SetRange("Transaction Type", Creditledger."Transaction Type"::Repayment);
                    if Creditledger.FindLast() then begin
                        LatPaydate := Creditledger."Posting Date";
                        LastPrRep := Creditledger.Amount;
                        if LatPaydate <> 0D then
                            lastP := GlobalFunc.FormatDate(LatPaydate);
                    end;
                    Creditledger.Reset();
                    Creditledger.SetRange("Loan No", Loansrec."Loan No.");
                    Creditledger.SetRange("Transaction Type", Creditledger."Transaction Type"::"Interest Paid");
                    if Creditledger.FindLast() then begin
                        LastInPaid := Creditledger.Amount;
                    end;
                end;
                if MemberRec.Get("Loan Rescheduling"."Member No.") then begin
                    if Cust.get(MemberRec."Employer Code") then
                        Employername := Cust.Name;
                    DOB := GlobalFunc.FormatDate(MemberRec."Date of Birth");
                end;
                AmtToped := 0;
                LInterest := ("Loan Rescheduling"."New Interest Rate" / 12 / 100) * "Loan Rescheduling"."Outstanding Balance";
                SavingAcc.Reset();
                SavingAcc.SetRange(SavingAcc."Member No.", "Loan Rescheduling"."Member No.");
                SavingAcc.SetRange(SavingAcc."Product Category", SavingAcc."Product Category"::"BOSA Deposits");
                if SavingAcc.FindLast() then
                    ProrataAmt := CustomCuesCodeunit.Prorata(SavingAcc."Member No.", SavingAcc."Product Type");
                Topuploan.Reset();
                Topuploan.SetRange("Loan No.", "Loan Rescheduling"."Loan No.");
                Topuploan.SetRange("Client Code", "Loan Rescheduling"."Member No.");
                if Topuploan.FindFirst() then begin
                    repeat
                        AmtToped := AmtToped + Topuploan."Principle Top Up";
                    until Topuploan.Next() = 0;
                end;
            end;
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        CompanyInformation.GET();
        CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
        CompanyNam := CompanyInformation.Name;
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        myInt: Integer;
        Loansrec: Record Loans;
        MemberDeposits: Decimal;
        LNBalance: Decimal;
        SavingAcc: Record "Savings Accounts";
        LastInPaid: Decimal;
        CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
        LatPaydate: Date;
        ExpPramt: Decimal;
        ExpInterest: Decimal;
        lastP: Text;
        Linterest: Decimal;
        LastPrRep: Decimal;
        LoaMaxperiod: Integer;
        CheckOflines: Record "Checkoff Advice Line";
        CompanyAddress: Text;
        Topuploan: Record "Loans Top up";
        CompanyNam: Text;
        CompanyTelephone: Text;
        AmtToped: Decimal;
        ProrataAmt: Decimal;
        ApprdAmt: Decimal;
        Creditledger: Record "Credit Ledger Entry";
        AppDate: Text;
        MemberRec: Record Members;
        CompanyInformation: Record "Company Information";
        CompleDate: Text;
        DOB: Text;
        GlobalFunc: Codeunit "Global Functions";
        CommunicationOnline: Text;
        Employername: Text;
        LoanType: Code[20];
        Cust: Record Customer;
        ReQamt: Decimal;
        InterestR: Decimal;
        LoanProductName: Text;
        productFac: Record "Product Factory";

}