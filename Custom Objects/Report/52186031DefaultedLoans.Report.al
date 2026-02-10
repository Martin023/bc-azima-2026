Report 52186031 "Defaulted Fresh Loans"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Defaulted Fresh Loans.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = const(true), "Total Balance" = filter(> 0), "Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Employer Code";
            column(ReportForNavId_1; 1)
            {
            }
            column(MemberDeposits; MemberDeposits)
            {

            }
            column(MemberNo_Loans; Loans."Member No.")
            {
            }
            column(StaffNo_Loans; Loans."Staff No")
            {
            }
            column(EmployerCode_Loans; Loans."Employer Code")
            {
            }
            column(DisbursementDate_Loans; Loans."Disbursement Date")
            {
            }
            column(LoanNo_Loans; Loans."Loan No.")
            {
            }
            column(ApprovedAmount_Loans; Loans."Approved Amount")
            {
            }
            column(Repayment_Loans; Loans.Repayment)
            {
            }
            column(RecoveryMode_Loans; Loans."Recovery Mode")
            {
            }
            column(TotalBalance_Loans; Loans."Total Balance")
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CompanyNam; CompanyNam)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(picture; CompanyInformation.Picture)
            {
            }
            column(StartDateText; StartDateText)
            {
            }
            column(EndDateText; EndDateText)
            {
            }
            column(DisBuseDateText; DisBuseDateText)
            {
            }
            column(LoanNum; LoanNum)
            {
            }
            column(MemberName; MemberName)
            {
            }
            column(ApprovedAmm; ApprovedAmm)
            {
            }
            column(TotalBal; TotalBal)
            {
            }
            column(Department; Department)
            {
            }
            column(MemberNum; MemberNum)
            {
            }
            column(REPAY; REPAY)
            {
            }
            column(Recovery; Recovery)
            {
            }
            column(Staffno; StaffNO)
            {
            }
            column(Loan2Num; Loan2Num)
            {
            }
            column(DisbursementDate; DisbursementDate)
            {
            }
            column(DisbursementMonth; DisbursementMonth)
            {
            }
            column(PrintedBY; PrintedBy)
            {
            }
            column(SelectYear; SelectYear)
            {
            }
            column(BranchCode; BranchCode)
            {
            }
            column(install; Install)
            {
            }

            trigger OnAfterGetRecord()
            var
                Disbursement: Date;
                StartingDate: Date;
            begin
                LoanNum := '';
                Recovery := '';
                StaffNO := '';
                MemberNum := '';
                Disbursement := 0D;
                MemberName := '';
                BranchCode := '';
                TotalBal := 0;
                ApprovedAmm := 0;
                Department := '';
                Install := 0;
                DisbrsDate := '';
                MemberDeposits := 0;
                DisBuseDateText := '';
                PaidAmount := 0;
                if Loans."Disbursement Date" <> 0D then
                    DisbrsDate := GloabalFunc.FormatDate(Loans."Disbursement Date");
                SavingsAcc.Reset();
                SavingsAcc.SetRange("Member No.", Loans."Member No.");
                SavingsAcc.setrange(SavingsAcc."Product Category", SavingsAcc."Product Category"::"BOSA Deposits");
                if SavingsAcc.FindFirst() then begin
                    SavingsAcc.CalcFields(SavingsAcc."Balance (LCY)");
                    MemberDeposits := SavingsAcc."Balance (LCY)";
                end;
                CreditLedgerEntry.Reset;
                CreditLedgerEntry.SetRange(CreditLedgerEntry."Loan No", Loans."Loan No.");
                CreditLedgerEntry.SetRange(CreditLedgerEntry."Posting Date", Sdate, Edate);
                CreditLedgerEntry.SetFilter(CreditLedgerEntry."Transaction Type", '=%1|=%2', CreditLedgerEntry."transaction type"::Repayment, CreditLedgerEntry."transaction type"::"Interest Paid");
                if not CreditLedgerEntry.FindFirst then begin
                    if LoansRec.Get(Loans."Loan No.") then begin
                        Disbursement := LoansRec."Disbursement Date";
                        //DisBuseDateText:=SkyHarambeePortal.FormatDate(Disbursement);
                        MemberName := LoansRec."Member Name";
                        BranchCode := LoansRec."Global Dimension 2 Code";
                        TotalBal := LoansRec."Total Balance";
                        MemberNum := LoansRec."Member No.";
                        StaffNO := LoansRec."Staff No";
                        ApprovedAmm := LoansRec."Approved Amount";
                        Recovery := Format(LoansRec."Recovery Mode");
                        Department := LoansRec."Employer Code";
                        Install := LoansRec.Installments;
                        REPAY := LoansRec.Repayment;
                    end;
                end;
                if MemberNum = '' then CurrReport.Skip;
            end;

            trigger OnPreDataItem()
            var
                StartingDate: Date;
            begin
                Loans.SetRange(Loans."Disbursement Date", StartDD, EndingDate);
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
                field("Disbursement Date"; DisbursementDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Disbursement Month';
                }
                field("Select Year"; SelectYear)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        // IF STRLEN(SelectYear)<>4 THEN  ERROR('Not a valid year');
                        if SelectYear > Date2dmy(Today, 3) then Error('select a valid year');
                        TestCase := Format(SelectYear);
                        if (StrLen(TestCase) <> 4) then Error('Select a valid year');
                    end;
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
    var
        StartingDate: Date;
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyNam := CompanyInformation.Name;
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
        if DisbursementDate = Disbursementdate::January then begin
            Disburse := 1;
            FormatedDisbursementDate := 'JANUARY';
            Endmonthdate := 31;
        end;
        if DisbursementDate = Disbursementdate::February then begin
            Disburse := 2;
            FormatedDisbursementDate := 'FEBRUARY';
            if SelectYear / 4 = 0 then
                Endmonthdate := 29 else
                if SelectYear / 4 <> 0 then
                    Endmonthdate := 28;
        end;
        if DisbursementDate = Disbursementdate::March then begin
            Disburse := 3;
            FormatedDisbursementDate := UpperCase('March');
            Endmonthdate := 31;
        end;
        if DisbursementDate = Disbursementdate::April then begin
            Disburse := 4;
            FormatedDisbursementDate := UpperCase('April');
            Endmonthdate := 30;
        end;
        if DisbursementDate = Disbursementdate::May then begin
            Disburse := 5;
            FormatedDisbursementDate := 'May';
            Endmonthdate := 31;
        end;
        if DisbursementDate = Disbursementdate::June then begin
            Disburse := 6;
            FormatedDisbursementDate := UpperCase('June');
            Endmonthdate := 30
        end;
        if DisbursementDate = Disbursementdate::July then begin
            Disburse := 7;
            FormatedDisbursementDate := UpperCase('July');
            Endmonthdate := 31;
        end;
        if DisbursementDate = Disbursementdate::August then begin
            Disburse := 8;
            FormatedDisbursementDate := UpperCase('August');
            Endmonthdate := 31;
        end;
        if DisbursementDate = Disbursementdate::September then begin
            Disburse := 9;
            FormatedDisbursementDate := UpperCase('September');
            Endmonthdate := 30;
        end;
        if DisbursementDate = Disbursementdate::October then begin
            FormatedDisbursementDate := UpperCase('October');
            Disburse := 10;
            Endmonthdate := 31
        end;
        if DisbursementDate = Disbursementdate::November then begin
            Disburse := 11;
            FormatedDisbursementDate := UpperCase('November');
            Endmonthdate := 30;
        end;
        if DisbursementDate = Disbursementdate::December then begin
            Disburse := 12;
            FormatedDisbursementDate := UpperCase('December');
            Endmonthdate := 31;
        end;
        if DisbursementDate <> Disbursementdate::" " then
            DisbursementMonth := FormatedDisbursementDate;
        StartDD := Dmy2date(1, Disburse, SelectYear);
        EndingDate := Dmy2date(Endmonthdate, Disburse, SelectYear);
        Sdate := CalcDate('1M-CM', StartDD);
        Edate := CalcDate('1M+CM', EndingDate);
        ;
    end;

    var
        DisbursementDate: Option " ",January,February,March,April,May,June,July,August,September,October,November,December;
        EndDate: Date;
        CompanyInformation: Record "Company Information";
        CompanyNam: Text;
        DisbrsDate: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        //SkyHarambeePortal: Codeunit UnknownCodeunit52185428;
        StartDateText: Text;
        EndDateText: Text;
        LoansRec: Record Loans;
        MemberDeposits: Decimal;
        DisBuseDateText: Text;
        StartingDate: Date;
        CreditLedgerEntry: Record "Credit Ledger Entry";
        LoanNum: Code[30];
        MemberName: Text;
        Department: Code[30];
        ApprovedAmm: Decimal;
        TotalBal: Decimal;
        MemberNum: Code[30];
        REPAY: Decimal;
        StaffNO: Code[30];
        Recovery: Text;
        CreditLedgerEntry2: Record "Credit Ledger Entry";
        GloabalFunc: Codeunit "Global Functions";
        Loan2Num: Code[30];
        FormatedDisbursementDate: Text;
        DisbursementMonth: Text;
        PrintedBy: Text;
        SavingsAcc: Record "Savings Accounts";
        Day: Integer;
        Month: Integer;
        Year: Integer;
        Endmonthdate: Integer;
        StartDD: Date;
        EndingDate: Date;
        Disburse: Integer;
        LoansREcc: Record Loans;
        PaidAmount: Decimal;
        Sdate: Date;
        Edate: Date;
        SelectYear: Integer;
        TestCase: Text;
        BranchCode: Code[30];
        Install: Integer;
}

