#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185742 "Loan SMS Notice"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Loan No.";


            trigger OnAfterGetRecord()
            begin
                GenLedgerSetup.Get();
                HesabuYote := HesabuYote + 1;
                SavingsAccountBalance := 0;
                WeekCount := 0;
                Overdues := 0;
                ExpectedRepay := 0;
                SchedRep := 0;
                IntBF := 0;
                ExpBal := 0;
                IntDue := 0;
                VarianceAmt := 0;
                AmtPaid := 0;
                IntPaid := 0;
                ExpBalShedule := 0;
                TotalAmtPaid := 0;
                LoanType.Reset;
                LoanType.SetRange("Product ID", Loans."Loan Product Type");
                if LoanType.Find('-') then begin
                    Loans.CalcFields("Loans Category-SASRA");
                    if (Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Perfoming)
                      and (Loans."Demand Letter Status" <> Loans."demand letter status"::" ") then begin
                        Loans."Demand Letter Date" := 0D;
                        Loans."Demand Letter Status" := Loans."demand letter status"::" ";
                    end;
                    Cust.Reset;
                    Cust.SetRange("No.", Loans."Member No.");
                    Cust.SetFilter(Status, '%1|%2|%3|%4', Cust.Status::Active, Cust.Status::Dormant, Cust.Status::New);
                    if Cust.Find('-') then begin
                        LoaneePhone := Cust."Phone No.";
                        if (Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Doubtful)
                        or (Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Substandard)
                       or (Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Loss)
                            then begin
                            Loans.CalcFields("Outstanding Balance", "Outstanding Interest");
                            Loans.CalcFields("Loans Category-SASRA");
                            if Loans."Demand Letter Date" = 0D then
                                NoticeDate := Today
                            else
                                NoticeDate := Loans."Demand Letter Date";

                            NextNoticeDate := CalcDate(GenLedgerSetup."Defaulter Notice Period", NoticeDate);
                            if NoticeDate <= Today then begin

                                Loans.CalcFields("Outstanding Balance", "Outstanding Interest");
                                if Loans."Loan Product Type" <> '133' then begin
                                    "Demand Letter Date" := NextNoticeDate;
                                    LoanType.Modify;
                                    if Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Substandard then begin
                                        "Demand Letter Status" := "demand letter status"::"Notice 1";
                                        "Demand Letter Date" := NextNoticeDate;
                                        GrandOutst := 0;
                                        GrandOutst := (Loans."Outstanding Balance" + Loans."Outstanding Interest");
                                        if Cust.Get(Loans."Member No.") then begin
                                            Descript := 'Polite reminder. Your ' +
                                            LoanType."Product Description" + ', is in arrears of '
                                            + Format(GrandOutst) + '.Please make arrangement to regularize payments. ' + 'Call 0709943435/420/440/439/412/428/417';

                                            msg := Descript;

                                            SendSMSC.SendSms(SmsSource::LOAN_DEFAULTED, Cust."Phone No.", msg, Format(Loans."Loan No."), '', true, 0, false, 'CBS', Cust."No.", 'CBS');

                                            LineNo := LineNo + 1000;

                                        end;
                                    end else
                                        if Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Doubtful then begin
                                            "Demand Letter Status" := "demand letter status"::"Notice 2";
                                            "Demand Letter Date" := NextNoticeDate;
                                            GrandOutst := 0;
                                            GrandOutst := (Loans."Outstanding Balance" + Loans."Outstanding Interest");
                                            if Cust.Get(Loans."Member No.") then begin
                                                Descript := 'Polite reminder. Your ' +
                                                LoanType."Product Description" + ', is in default of '
                                                + Format(GrandOutst) + '.Regularize by paying the arrears within 14 days else your guarantors shall be attached. ' + 'Call 0709943435/420/440/439/412/428/417';
                                                SendSMSC.SendSms(SmsSource::LOAN_DEFAULTED, Cust."Phone No.", msg, Format(Loans."Loan No."), '', true, 0, false, 'CBS', Cust."No.", 'CBS');

                                                LineNo := LineNo + 1000;

                                            end;
                                        end else
                                            if (Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Loss) then begin
                                                "Demand Letter Status" := "demand letter status"::"Notice 3";
                                                "Demand Letter Date" := NextNoticeDate;
                                                GrandOutst := 0;
                                                GrandOutst := (Loans."Outstanding Balance" + Loans."Outstanding Interest");
                                                if Cust.Get(Loans."Member No.") then begin
                                                    Descript := 'Polite reminder. Your ' +
                                                    LoanType."Product Description" + ', is in default of '
                                                    + Format(GrandOutst) + '.and your guarantors shall be attached. ' + 'Call 0709943435/420/440/439/412/428/417';
                                                    SendSMSC.SendSms(SmsSource::LOAN_DEFAULTED, Cust."Phone No.", msg, Format(Loans."Loan No."), '', true, 0, false, 'CBS', Cust."No.", 'CBS');

                                                    LineNo := LineNo + 1000;

                                                end;
                                            end;
                                    if Loans."Loan Product Type" <> '133' then begin
                                        /*IF (Loans."Loans Category-SASRA"=Loans."Loans Category-SASRA"::Doubtful)
                                       OR (Loans."Loans Category-SASRA"=Loans."Loans Category-SASRA"::Loss) THEN BEGIN*/
                                        if Loans."Loans Category-SASRA" = Loans."loans category-sasra"::Substandard then begin
                                            Guarantors.Reset;
                                            Guarantors.SetRange("Loan No", Loans."Loan No.");
                                            Guarantors.SetRange(Substituted, false);
                                            Guarantors.SetRange("Self Guarantee", false);
                                            if Guarantors.Find('-') then begin
                                                repeat
                                                    GrandOutst := 0;
                                                    GrandOutst := (Loans."Outstanding Balance" + Loans."Outstanding Interest");
                                                    if Cust.Get(Guarantors."Member No") then begin
                                                        Descript := 'Please note the loan you guaranteed ' + Loans."Member Name" + ':' + LoaneePhone
                                                          + ' is in default. Loanee has been given 14 Days to clear else you will be attached ' + 'Call 0709943435/420/440/439/412/428/417';
                                                        if Cust."Phone No." <> '' then
                                                            SendSMSC.SendSms(SmsSource::LOAN_DEFAULTED, Cust."Phone No.", msg, Format(Loans."Loan No."), '', true, 0, false, 'CBS', Cust."No.", 'CBS');
                                                        LineNo := LineNo + 1000;
                                                    end;
                                                until Guarantors.Next = 0;
                                            end;
                                        end;
                                    end
                                end else begin
                                    Loans.CalcFields("Outstanding Balance", "Outstanding Interest");
                                    if Loans."Loan Product Type" = '133' then begin
                                        "Demand Letter Date" := NextNoticeDate;
                                        LoanType.Modify;
                                        if (Loans."Loans Category-SASRA" <> Loans."loans category-sasra"::Perfoming) or
                                          (Loans."Loans Category-SASRA" <> Loans."loans category-sasra"::Watch)
                                           then begin
                                            "Demand Letter Status" := "demand letter status"::"Notice 1";
                                            "Demand Letter Date" := NextNoticeDate;
                                            GrandOutst := 0;
                                            GrandOutst := (Loans."Outstanding Balance" + Loans."Outstanding Interest");
                                            if Cust.Get(Loans."Member No.") then begin
                                                Descript := 'Polite reminder. Your ' +
                                                LoanType."Product Description" + ', is in arrears of '
                                                + Format(GrandOutst) + '.Please make arrangement to regularize payments. ' + 'Call 0709943435/420/440/439/412/428/417';
                                                SendSMSC.SendSms(SmsSource::LOAN_DEFAULTED, Cust."Phone No.", msg, Format(Loans."Loan No."), '', true, 0, false, 'CBS', Cust."No.", 'CBS');

                                                LineNo := LineNo + 1000;

                                            end;
                                        end;
                                    end;
                                end;
                                Loans.Modify;
                            end;
                        end;
                    end else begin
                        /*Cust.RESET;
                        Cust.SETRANGE("No.",Loans."Member No.");
                        Cust.SETFILTER(Status,'<>%1&<>%2&<>%3&<>%4',Cust.Status::Active,Cust.Status::Dormant,Cust.Status::New,Cust.Status::"Withdrawal Applicant");
                        IF Cust.FIND('-') THEN BEGIN
                        IF Loans."Loan Product Type"<>'133' THEN BEGIN
                          IF (Loans."Loans Category-SASRA"=Loans."Loans Category-SASRA"::Doubtful)
                         OR (Loans."Loans Category-SASRA"=Loans."Loans Category-SASRA"::Loss)
                              THEN BEGIN
                        Guarantors.RESET;
                        Guarantors.SETRANGE("Loan No",Loans."Loan No.");
                        Guarantors.SETRANGE(Substituted,FALSE);
                        IF Guarantors.FIND('-') THEN BEGIN
                          REPEAT
                        GrandOutst:=0;
                        GrandOutst:=(Loans."Outstanding Balance"+Loans."Outstanding Interest");
                        IF Cust.GET(Guarantors."Member No") THEN BEGIN
                        Descript:='Please note the loan you guaranteed '+ Loans."Member Name"+':'+LoaneePhone
                          + ' is in default. Loanee has been given 14 Days to clear else you will be attached '+'Call 07099434434/428/439/429/412/421' ;
                          IF Cust."Phone No."<>'' THEN
                        Mgnt.SendSms(SmsSource::"Loan defaulted",Cust."Phone No.",Descript,Loans."Loan No.",Cust."No.",FALSE);
                        LineNo:=LineNo+1000;
                        END;
                        UNTIL Guarantors.NEXT=0;
                        END;
                        END;
                        END;
                        END;*/
                    end;
                end;

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
        HesabuYaSiku: Integer;
        HesabuYote: Integer;
        SendSMS: Boolean;
        SendSMSC: Codeunit SendSms;
        iEntryNo: Integer;
        Cust: Record "Members";
        GenLedgerSetup: Record "General Set-Up";
        MessageFailed: Boolean;
        StrTel: Text[30];
        LoanType: Record "Product Factory";
        LoanPType: Text[50];
        Charges: Record "Transaction Types";
        Vend: Record "Savings Accounts";
        Description: Text[30];
        Mgnt: Codeunit SendSms;
        msg: Text;
        SMSSource: enum "SMS Source";
        Descript: Text[250];
        DefaulterCharges: Decimal;
        Temp: Record "Banking User Template";
        Jtemplate: Code[10];
        JBatch: Code[10];
        Dim1: Code[10];
        Dim2: Code[10];
        JournalPosting: Codeunit "Journal Posting";
        LineNo: Integer;
        CompInfo: Record "Company Information";
        GrandOutst: Decimal;
        IssueDate: Date;
        SavingsAccounts: Record "Savings Accounts";
        SavingsAccountBalance: Decimal;
        WeekCount: Decimal;
        "As At(Date)": Date;
        ExpectedRepay: Decimal;
        Overdues: Decimal;
        IntBF: Decimal;
        GroupName: Text[30];
        V: Integer;
        ExpBal: Decimal;
        RepSched: Record "Ideal Repayment Schedule";
        LnRepSched: Record "Ideal Repayment Schedule";
        SchedRep: Decimal;
        VarianceAmt: Decimal;
        CreditLedgers: Record "Credit Ledger Entry";
        IntDue: Decimal;
        ExpBalShedule: Decimal;
        IntPaid: Decimal;
        AmtPaid: Decimal;
        TotalAmtPaid: Decimal;
        GroupAcc: Record "Members";
        AccountName: Text[250];
        CustM: Record "Members";
        NextNoticeDate: Date;
        NoticeDate: Date;
        Guarantors: Record "Loan Guarantors and Security";
        LoaneePhone: Code[15];
}
