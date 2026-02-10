Report 52187406 "Posted Loans Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Posted Loans Report';
    RDLCLayout = './bc-kenpipe-2024/Layout/Posted Loans Resport.rdl';

    dataset
    {


        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = const(true), "Total Balance" = filter(> 0), "Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Employer Code", "Source Unit";
            column(memberN; memberN)
            {
            }
            column(StaffNO; StaffNO)
            {
            }
            column(EmplCode; EmplCode)
            {
            }
            column(Loan2Num; Loan2Num)
            {
            }

            column(ApprovedAmt; ApprovedAmt)
            {
            }
            column(RPayAmt; RPayAmt)
            {
            }
            column(TBal; TBal)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(ShareCap; "Share Boosted Amount")
            {
            }
            column(DepositBoost; "Loans - Deposit Purchase")
            {
            }
            column(CompanyNam; CompanyNam)
            {
            }
            column(Interest; Interest)
            {

            }
            column(Brthdate; Brthdate)
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
            column(StartingDate; StartingDate)
            {

            }
            column(DisburseD; DisburseD)
            {

            }
            column(EndingDate; EndingDate)
            {

            }
            column(Member_Name; MemberName)
            {

            }
            column(OUtstBal; OUtstBal)
            {

            }

            column(Recovery; Recovery)
            {
            }
            column(BranchCode; BranchCode)
            {
            }
            column(Installments; Install)
            {
            }
            trigger OnPreDataItem()
            var
                StartingDate: Date;
            begin
                if loans."Disbursement Date" <> 0D then
                    Loans.SetFilter(Loans."Disbursement Date", '%1..%2', Sdate, Edate);
            end;

            trigger OnAfterGetRecord()
            var
                memberss: Record Members;

            begin
                Loan2Num := '';
                DisburseD := '';
                memberN := '';
                StaffNO := '';
                EmplCode := '';
                BranchCode := '';
                OUtstBal := 0;
                Recovery := '';
                Install := 0;
                ApprovedAmt := 0;
                MemberName := '';
                LoansREcc.Reset();
                LoansREcc.SetRange("Loan No.", Loans."Loan No.");
                LoansREcc.SetFilter("Disbursement Date", '%1..%2', StartingDate, EndingDate);
                if LoansREcc.FindFirst() then begin
                    LoansREcc.CalcFields(LoansREcc."Total Balance", LoansREcc."Outstanding Balance", LoansREcc."Outstanding Interest");
                    Loan2Num := LoansREcc."Loan No.";
                    MemberName := LoansREcc."Member Name";
                    ApprovedAmt := LoansREcc."Approved Amount";
                    RPayAmt := LoansREcc.Repayment;
                    Install := LoansREcc.Installments;
                    BranchCode := LoansREcc."Global Dimension 1 Code";
                    Recovery := Format(LoansREcc."Recovery Mode");
                    StaffNO := LoansREcc."Staff No";
                    OUtstBal := LoansREcc."Outstanding Balance";
                    memberN := LoansREcc."Member No.";
                    DisburseD := GlobalsFunc.FormatDate(LoansREcc."Disbursement Date");
                    EmplCode := LoansREcc."Employer Code";
                    TBal := LoansREcc."Total Balance";
                    memberss.Reset();
                    memberss.SetRange(memberss."No.", LoansREcc."Member No.");
                    if memberss.FindFirst() then begin
                        Brthdate := GlobalsFunc.FormatDate(memberss."Date of Birth");
                    end;
                end;
                if memberN = '' then
                    CurrReport.Skip();



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
                field(StartingDate; StartingDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Starting Date';
                }
                field(EndingDate; EndingDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Ending Date';

                }
            }

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
        Sdate := StartingDate;
        Edate := EndingDate;

    end;

    var
        DisbursementDate: Option " ",January,February,March,April,May,June,July,August,September,October,November,December;
        EndDate: Date;
        CompanyInformation: Record "Company Information";
        Sdate: Date;
        EmplCode: Code[30];
        OUtstBal: Decimal;
        TBal: Decimal;
        Edate: Date;
        CompanyNam: Text;
        CompanyAddress: Text;
        memberN: Code[30];
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        GlobalsFunc: Codeunit "Global Functions";

        StartingDate: Date;
        CreditLedgerEntry: Record "Credit Ledger Entry";
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
        DisburseD: Text;
        EndingDate: Date;
        Disburse: Integer;
        LoansREcc: Record Loans;
        Brthdate: Text;
        PaidAmount: Decimal;
        SelectYear: Integer;
        TestCase: Text;
        BranchCode: Code[30];
        Install: Integer;
        MemberName: Text;
        ApprovedAmt: Decimal;
        ApprovedDate: Text;
        RPayAmt: Decimal;
}

