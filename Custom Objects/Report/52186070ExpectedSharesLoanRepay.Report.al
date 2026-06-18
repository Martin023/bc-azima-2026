#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186070 "Expected Loan Repayment"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Expected Loan Repayment.rdl';

    dataset
    {
        // Single-row dataitem for header/company info — runs ONCE
        dataitem(CompanyInformation; "Company Information")
        {
            DataItemTableView = sorting("Primary Key");
            MaxIteration = 1;

            column(CompanyInformation_Name; Name) { }
            column(CompanyInformation_Picture; Picture) { }  // BLOB emitted only once
            column(CompanyAddress; CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code") { }
            column(CompanyTelephone; 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2") { }
            column(CommunicationOnline; 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page") { }


            trigger OnPreDataItem()
            begin
                CalcFields(Picture);  // load BLOB here, once
            end;
        }

        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = filter(true));
            column(Loan_No_; "Loan No.")
            {
            }
            column(Member_No_; "Member No.")
            {
            }
            column(Member_Name; "Member Name")
            {
            }
            column(Loan_Account; "Loan Account")
            {
            }
            column(Staff_No; "Staff No")
            {
            }
            column(Repayment; Repayment)
            {
            }
            column(Total_Balance; "Total Balance")
            {

            }
            column(Employer_Code; "Employer Code")
            {
            }
            // column(CompanyInformation_Name; CompanyInformation.Name)
            // {
            // }
            // column(CompanyInformation_Picture; CompanyInformation.Picture)
            // {s
            // }
            // column(CompanyAddress; CompanyAddress)
            // {
            // }
            // column(CompanyTelephone; CompanyTelephone)
            // {
            // }
            // column(CommunicationOnline; CommunicationOnline)
            // {
            // }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(PriReceived; PriReceived)
            {
            }
            column(IntReceived; IntReceived)
            {
            }

            column(LoanIntOffset; LoanIntOffset)
            {
            }
            column(LoanPriOffset; LoanPriOffset)
            {
            }
            column(STOInt; STOInt)
            {
            }
            column(STOPri; STOPri)
            {
            }
            column(MobileIntRece; MobileIntRece)
            {
            }
            column(MobilePriRece; MobilePriRece)
            {
            }
            column(Variance; Variance)
            {
            }

            trigger OnPreDataItem()
            begin
                Loans.Setfilter("Disbursement Date", '..%2', EndDate);
                Loans.SetFilter("Date Filter", '..%2', EndDate);
            end;

            trigger OnAfterGetRecord()
            begin
                PriReceived := 0;
                IntReceived := 0;
                STOInt := 0;
                STOPri := 0;
                LoanIntOffset := 0;
                LoanPriOffset := 0;
                Variance := 0;
                MobileIntRece := 0;
                MobilePriRece := 0;

                if Loans.Repayment > Loans."Total Balance" then
                    Loans.Repayment := Loans."Total Balance";


                CreditLedgerEntr.Reset();
                CreditLedgerEntr.SetLoadFields("Posting Date", "Loan No", Amount, "Credit Amount");
                CreditLedgerEntr.Setfilter("Posting Date", '%1..%2', StartDate, EndDate);
                CreditLedgerEntr.SetRange("Loan No", Loans."Loan No.");
                CreditLedgerEntr.SetRange(Reversed, false);
                CreditLedgerEntr.SetFilter("Credit Amount", '>0');
                if CreditLedgerEntr.FindSet() then begin
                    repeat
                        case
                            CreditLedgerEntr."Transaction Type" of
                            CreditLedgerEntr."Transaction Type"::Repayment:
                                begin
                                    PriReceived := PriReceived + CreditLedgerEntr."Credit Amount";
                                    if Loans.get(CreditLedgerEntr."Loan No") then
                                        LoanPriOffset := LoanPriOffset + CreditLedgerEntr."Credit Amount";
                                    if STO.get(CreditLedgerEntr."Loan No") then
                                        STOPri := STOPri + CreditLedgerEntr."Credit Amount";
                                    MobileTransBuff.reset();
                                    MobileTransBuff.SetRange("Loan No.", Loans."Loan No.");
                                    MobileTransBuff.SetRange("Originator ID", CreditLedgerEntr."Document No.");
                                    if MobileTransBuff.findfirst then
                                        MobileIntRece := MobilePriRece + CreditLedgerEntr."Credit Amount";

                                end;
                            CreditLedgerEntr."Transaction Type"::"Interest Paid":
                                begin
                                    IntReceived := IntReceived + CreditLedgerEntr."Credit Amount";
                                    if Loans.get(CreditLedgerEntr."Loan No") then
                                        LoanIntOffset := LoanIntOffset + CreditLedgerEntr."Credit Amount";
                                    if STO.get(CreditLedgerEntr."Loan No") then
                                        STOInt := STOInt + CreditLedgerEntr."Credit Amount";

                                    MobileTransBuff.reset();
                                    MobileTransBuff.SetRange("Loan No.", Loans."Loan No.");
                                    MobileTransBuff.SetRange("Originator ID", CreditLedgerEntr."Document No.");
                                    if MobileTransBuff.findfirst then
                                        MobileIntRece := MobileIntRece + CreditLedgerEntr."Credit Amount";
                                end;
                        end;
                    until CreditLedgerEntr.Next() = 0;
                end;
                Variance := Loans.Repayment - (PriReceived + IntReceived);
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
                field(StartDate; StartDate)
                {
                    Caption = 'Start Date';
                    ApplicationArea = All;
                }
                field(Enddate; EndDate)
                {
                    Caption = 'End Date';
                    ApplicationArea = All;
                }
            }
        }

    }

    labels
    {
    }
    trigger OnPreReport()
    begin
        // if CompanyInformation.Get then
        //     CompanyInformation.CalcFields(CompanyInformation.Picture);
        // CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        // CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        // CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";

        if StartDate = 0D then Error('Start Date must be indicated');
        if EndDate = 0D then Error('End Date must be indicated');

    end;

    var

        // CompanyInformation: Record "Company Information";
        // CompanyAddress: Text;
        // CompanyTelephone: Text;
        // CommunicationOnline: Text;
        StartDate: Date;
        EndDate: Date;
        CreditLedgerEntr: record "Credit Ledger Entry";
        PriReceived: Decimal;
        IntReceived: Decimal;
        MobileTransBuff: record "Sky M-Banking Trans. Buffer";
        MobileIntRece: Decimal;
        MobilePriRece: Decimal;
        LoanPriOffset: Decimal;
        LoanIntOffset: Decimal;
        STOInt: Decimal;
        STOPri: Decimal;
        STO: record "Standing Order Header";
        Variance: Decimal;
}
