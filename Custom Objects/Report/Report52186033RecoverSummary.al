Report 52186078 "Recovery Fresh Loans Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Recovery Fresh Loans Summary.rdl';
    Caption = 'Recovery Fresh Loans Summary';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = const(true), "Total Balance" = filter(> 0), "Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Employer Code";
            column(ReportForNavId_1; 1)
            {
            }
            column(MemberNo_Loans; Loans."Member No.")
            {
            }
            column(Loan_Product_Type; "Loan Product Type")
            {
            }
            column(LastPDate; LastPDate)
            {

            }
            column(Interest; Interest)
            {

            }
            column(Days_In_Arrears; "Days In Arrears")
            {

            }
            column(Amount_In_Arreas; "Amount In Arreas SACCO")
            {

            }
            column(Outstanding_Balance; "Outstanding Balance")
            {

            }
            column(Outstanding_Interest; "Outstanding Interest")
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
            column(Difference; Difference)
            {
            }
            column(PaidAmount; PaidAmount)
            {
            }
            column(DepartName; DepartName)
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
                LastPDate := '';
                Department := '';
                Install := 0;
                DisBuseDateText := '';
                PaidAmount := 0;
                if Member.Get(Loans."Member No.") then
                    Department := Member."Employer Code";
                if Customer.Get(Department) then
                    DepartName := Customer.Name;
                CreditLedgerEntry.Reset;
                CreditLedgerEntry.SetRange(CreditLedgerEntry."Loan No", Loans."Loan No.");
                CreditLedgerEntry.SetRange(CreditLedgerEntry."Posting Date", Sdate, Edate);
                CreditLedgerEntry.SetFilter(CreditLedgerEntry."Transaction Type", '=%1|=%2', CreditLedgerEntry."transaction type"::Repayment, CreditLedgerEntry."transaction type"::"Interest Paid");
                if CreditLedgerEntry.FindFirst then begin
                    CreditLedgerEntry.CalcSums("Credit Amount");
                    PaidAmount := CreditLedgerEntry."Credit Amount";
                    LastPDate := GlobalFun.FormatDate(CreditLedgerEntry."Posting Date");
                    if LoansRec.Get(CreditLedgerEntry."Loan No") then begin
                        //Disbursement:=LoansRec."Disbursement Date";
                        //DisBuseDateText:=SkyHarambeePortal.FormatDate(Disbursement);
                        MemberName := LoansRec."Member Name";
                        BranchCode := LoansRec."Global Dimension 2 Code";
                        TotalBal := LoansRec."Total Balance";
                        MemberNum := LoansRec."Member No.";
                        StaffNO := LoansRec."Staff No";
                        ApprovedAmm := LoansRec."Approved Amount";
                        Recovery := Format(LoansRec."Recovery Mode");
                        ////Department:=LoansRec."Employer Code";
                        //Install:=LoansRec.Installments;
                        REPAY := LoansRec.Repayment;
                        Difference := PaidAmount - REPAY;
                    end;
                end else begin
                    MemberName := Loans."Member Name";
                    REPAY := Loans.Repayment;
                    MemberNum := Loans."Member No.";
                    Difference := PaidAmount - REPAY;
                    StaffNO := Loans."Staff No";
                    BranchCode := Loans."Global Dimension 2 Code";
                    TotalBal := Loans."Total Balance";
                    StaffNO := Loans."Staff No";
                    ApprovedAmm := Loans."Approved Amount";
                end;
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
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        StartDateText: Text;
        EndDateText: Text;
        GlobalFun: Codeunit "Global Functions";
        LoansRec: Record Loans;
        DisBuseDateText: Text;
        LastPDate: Text;
        StartingDate: Date;
        CreditLedgerEntry: Record "Credit Ledger Entry";
        LoanNum: Code[30];
        MemberName: Text;
        Department: Code[10];
        ApprovedAmm: Decimal;
        TotalBal: Decimal;
        MemberNum: Code[30];
        REPAY: Decimal;
        StaffNO: Code[30];
        Recovery: Text;
        CreditLedgerEntry2: Record "Credit Ledger Entry";
        Loan2Num: Code[30];
        FormatedDisbursementDate: Text;
        DisbursementMonth: Text;
        PrintedBy: Text;
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
        Member: Record Members;
        AmountPaid: Decimal;
        Difference: Decimal;
        Customer: Record Customer;
        DepartName: Text;
}

