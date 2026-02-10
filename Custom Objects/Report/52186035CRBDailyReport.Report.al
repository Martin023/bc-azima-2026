#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings

//Put date filter on when transaction happened
//Defaulted Loans should not be here Complete

Report 52186035 "CRB Daily Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/CRB Daily Report.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            RequestFilterFields = "Member No.", "Employer Code", "Source Unit", "Loans Category-SASRA", "Days In Arrears", "Application Date", "Disbursement Date", "Loan Product Type";

            DataItemTableView = where(Posted = const(true), Defaulted = const(false));
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(SnapShotDate; SnapShotDate)
            {
                // Complete
            }
            column(ClientType; ClientType)
            {
                // Complete
            }
            column(Surname; Surname)
            {
                // Complete
            }
            column(ForeName1; ForeName1)
            {
                // Complete
            }
            column(ForeName2; ForeName2)
            {
                // Complete
            }
            column(ForeName3; ForeName3)
            {
                // Complete
            }
            column(CompanyName; CompanyName)
            {
                // Complete
            }
            column(PrimaryIdentificationType; PrimaryIdentificationType)
            {
                // Complete
            }
            column(PrimaryIdentification; PrimaryIdentification)
            {
                // Complete
            }
            column(AccountNo; AccountNo)
            {
                // Complete
            }
            column(CurrencyOfFacility; CurrencyOfFacility)
            {
                // Complete
            }
            column(OriginalAmount; OriginalAmount)
            {
                // Complete
            }
            column(PaymentAmount; PaymentAmount)
            {
                // Complete
            }
            column(PaymentDate; PaymentDate)
            {
                // Complete
            }
            column(CurrentBal; CurrentBal)
            {
                // Complete
            }
            column(InstallmentsInArrears; InstallmentsInArrears)
            {
                // Complete
            }
            column(DaysInArrears; ("Days In Arrears"))
            {
                // Complete
            }
            column(AccountStatus; AccountStatus)
            {
                // Complete
            }
            trigger OnAfterGetRecord()
            begin
                TotalBal := 0;
                Loans.CalcFields("Days In Arrears", "Outstanding Balance", "Outstanding Interest");

                if RunForCurrentDate then begin
                    CreditLedgerEntry.Reset();
                    CreditLedgerEntry.SetRange("Customer No.", Loans."Loan Account");
                    CreditLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                    CreditLedgerEntry.SetFilter("Transaction Type", '=%1|=%2', CreditLedgerEntry."Transaction Type"::"Interest Paid", CreditLedgerEntry."Transaction Type"::Repayment);
                    CreditLedgerEntry.SetRange(Reversed, false);
                    if not CreditLedgerEntry.FindFirst() then
                        CurrReport.Skip();
                end else begin
                    if ("Outstanding Balance" = 0) and ("Outstanding Interest" = 0) then
                        CurrReport.Skip();
                end;

                intProgressI += 1;
                if (intProgressI >= NoOfRecsProgress) OR (TIME - TimeProgress > 1000) then begin
                    NoOfProgressed := NoOfProgressed + intProgressI;
                    diaProgress.UPDATE(1, ROUND(NoOfProgressed / intProgressTotal * 10000, 1));
                    intProgressI := 0;
                    TimeProgress := TIME;
                end;

                if "Days In Arrears" <= 0 then
                    "Days In Arrears" := 0;

                if Members.Get(Loans."Member No.") then begin
                    Surname := Members."Other Names";
                    IF Surname = '' then Surname := Members."Middle Name";
                    IF Surname = '' then Surname := Members."First Name";
                    ForeName1 := Members."First Name";
                    ForeName2 := Members."Middle Name";
                    ForeName3 := Members."Other Names";

                    // LoanRecoveryHeader.GetLoanBalances(Loans."Loan No.", OutInt, OutBal, TotalBal);

                    LoanTable.Reset();
                    LoanTable.SetRange("Loan No.", Loans."Loan No.");
                    if LoanTable.FindFirst() then begin
                        LoanTable.CalcFields("Outstanding Balance", "Outstanding Interest");
                        TotalBal := LoanTable."Outstanding Balance" + LoanTable."Outstanding Interest";
                    end;


                    InstallmentsInArrears := Round(Loans."Days In Arrears" / 30, 1, '=');
                    if TotalBal <= 0 then
                        InstallmentsInArrears := 0;

                    if Loans."Expected Date of Completion" <> 0D then
                        ExpectedDateOfPayment := GlobalFunctions.FormatDate(Loans."Expected Date of Completion");
                    AccountStatus := 'H';
                    if TotalBal > 0 then
                        AccountStatus := 'F';
                end;


                SnapShotDate := GlobalFunctions.DateFormatCRB(Today);
                ClientType := 'A';

                if Members."Primary Identification Type" = Members."Primary Identification Type"::"ID Number" then begin
                    PrimaryIdentificationType := '001';
                    PrimaryIdentification := Members."Primary Identification";

                    if StrLen(PrimaryIdentification) = 4 then
                        PrimaryIdentification := '0' + PrimaryIdentification;

                end;
                if Members."Primary Identification Type" = Members."Primary Identification Type"::"Passport No" then begin
                    PrimaryIdentificationType := '002';
                    PrimaryIdentification := Members."Primary Identification";
                end;

                AccountNo := Loans."Loan No.";
                CurrencyOfFacility := 'KES';

                OriginalAmount := GlobalFunctions.FormatCRBAmounts(Loans."Approved Amount");

                CreditLedgerEntry.Reset();
                CreditLedgerEntry.SetRange("Customer No.", Loans."Loan Account");
                CreditLedgerEntry.SetFilter("Transaction Type", '=%1|=%2', CreditLedgerEntry."Transaction Type"::"Interest Paid", CreditLedgerEntry."Transaction Type"::Repayment);
                CreditLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                CreditLedgerEntry.SetRange(Reversed, false);
                if CreditLedgerEntry.Find('-') then begin
                    PaymentDate := GlobalFunctions.DateFormatCRB(CreditLedgerEntry."Posting Date");
                    CreditLedgerEntry.CalcSums("Credit Amount");
                    PaymentAmount := GlobalFunctions.FormatCRBAmounts(CreditLedgerEntry."Credit Amount");
                end;

                CurrentBal := GlobalFunctions.FormatCRBAmounts(TotalBal);
            end;

            trigger OnPostDataItem()
            begin
                diaProgress.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                if Format(GetFilter("Date Filter")) = '' then begin
                    StartDate := 19000101D;
                    EndDate := Today;
                end else begin
                    StartDate := Loans.GetRangeMin("Date Filter");
                    EndDate := Loans.GetRangeMax("Date Filter");
                end;

                intProgressTotal := COUNT;

                intProgressI := 0;
                TimeProgress := TIME;
                NoOfRecsProgress := intProgressTotal DIV 100;
                NoOfProgressed := 0;

                diaProgress.OPEN(Generating + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@', intProgress);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {

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
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";

        SnapShotDate := GlobalFunctions.FormatDate(Today);
        ClientType := 'MEMBER';
        CompanyName := CompanyInformation.Name;
        CurrencyOfFacility := 'KES';
    end;

    var
        //Colums
        SnapShotDate: Text;
        ClientType: Code[50];
        Surname: Text;
        ForeName1: Text;
        ForeName2: Text;
        ForeName3: Text;
        CompanyName: Text;
        PrimaryIdentificationType: Text;
        PrimaryIdentification: Code[50];//Mandatory
        AccountNo: Code[50];//Mandatory
        CurrencyOfFacility: Code[50];
        OriginalAmount: Decimal;
        PaymentAmount: Decimal;
        PaymentDate: Text;
        CurrentBal: Decimal;
        InstallmentsInArrears: Integer;
        DaysInArrears: Integer;
        AccountStatus: Code[50];


        //Other Variables
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Members: Record Members;
        GlobalFunctions: Codeunit "Global Functions";
        ProductFactory: Record "Product Factory";
        RepaymentSchedule: Record "Ideal Repayment Schedule";
        LoanRecoveryHeader: Record "Loan Recovery Header";
        OutInt: Decimal;
        OutBal: Decimal;
        TotalBal: Decimal;
        TotalLoanBal: Decimal;
        AmountInArrears: Decimal;
        ExpectedDateOfPayment: Text;
        AmountPaid: Decimal;
        CreditLedgerEntry: Record "Credit Ledger Entry";
        RunForCurrentDate: Boolean;


        DateFilter: Text;

        StartDate: Date;
        EndDate: Date;

        LoanTable: Record Loans;

        //Progress Variables
        intProgressTotal: Integer;
        intProgressI: Integer;
        TimeProgress: TIME;
        NoOfRecsProgress: Decimal;
        NoOfProgressed: Integer;
        Generating: Label 'Task Progress ...';
        diaProgress: Dialog;
        intProgress: Integer;


}
