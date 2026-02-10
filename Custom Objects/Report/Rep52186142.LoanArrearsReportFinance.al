namespace MNS.MNS;
using Microsoft.Foundation.Company;
using Microsoft.Sales.Customer;

report 52186142 "Loan Arrears Report - Finance"
{
    ApplicationArea = All;
    Caption = 'Loan Arrears Report - Finance';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Loan Arrears Finance Report.rdl';

    //Arrears report for different accounts (loan, share, risk, BBF, interest); 
    //(Expected-Paid; variance/arrears; Interest expected- Actual paid + unrealized interest). 
    //Loan number, loan type, Mno no, PF number, Name, employer code, ID number, amount applied for, amount disbursed

    dataset
    {
        dataitem(Loans; Loans)
        {
            //DataItemTableView = where(Posted = const(true));
            RequestFilterFields = "Loan No.", "Member No.", "Employer Code", "Loan Product Type", "Disbursement Date", "Source Unit";
            column(LoanNo_Loans; Loans."Loan No.")
            {
            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            {
            }
            column(Source_Unit; "Source Unit") { }
            column(MemberNo; Loans."Member No.") { }
            column(MemberName; Loans."Member Name") { }
            column(PFNumber; MemberPFNumber) { }
            column(Employer_Code; "Employer Code") { }
            column(EmployerName; EmployerName) { }
            column(ID_No; "ID No.") { }
            column(Loans_Category_SASRA; "Loans Category-SASRA") { }
            column(Amount_Applied_For; "Requested Amount") { }
            column(Amount_Disbursed; "Approved Amount") { }
            column(Amount_To_Disburse; "Amount To Disburse") { }
            column(Outstanding_Balance; "Outstanding Balance") { }
            column(Outstanding_Interest; "Outstanding Interest") { }
            column(Application_Date; Appdate) { }
            column(ApprovedDate; ApprovedDate) { }
            column(ExpectedDate; ExpectedDate) { }
            column(StartDate; StartDate) { }
            column(EndDate; EndDate) { }
            column(ActualPaid; ActualPaid) { }
            column(Repayment; Loans.Repayment)
            {
            }
            column(PrincipalArrears; PrincipalArrears) { }
            column(Loan_Principle_Repayment; "Loan Principle Repayment")
            {
            }
            column(Loan_Interest_Repayment; "Loan Interest Repayment")
            {
            }
            column(LastInPaid; LastInPaid)
            {
            }
            column(LastPrRep; LastPrRep)
            {
            }
            column(Status; Status)
            {
            }
            column(LatPaydate; lastP)
            {
            }
            column(LoansCategorySASRA_Loans; Loans."Loans Category-SASRA")
            {
            }
            column(LoanProductType_Loans; Loans."Loan Product Type")
            {
            }
            column(ID_No_; "ID No.")
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
            column(OutstnBal; OutstnBal)
            {

            }
            column(LNInterest; LNInterest)
            {

            }
            column(EmployerLoanNo; Loans."Employer Loan No.")
            {
            }
            column(BatchNo_Loans; Loans."Batch No.")
            {
            }
            column(ShareBoostedAmount; Loans."Share Boosted Amount")
            {
            }
            column(ShareBoostedAmount1; Loans."Loans - Deposit Purchase")
            {
            }
            column(EmployerCode; Loans."Employer Code")
            {
            }
            column(AmntTp; AmntTp)
            {
            }
            column(ProductType; ProductType)
            {
            }
            column(OutstandingBills_Loans; Loans."Outstanding Bills")
            {
            }
            column(AccountCategory; AccountCategory)
            {
            }

            column(Loan_Appraised_By; "Loan Appraised By")
            {

            }
            column(Posted_By; "Posted By")
            {

            }
            column(Requested_Amount; "Requested Amount")
            {

            }
            column(Member_Age; "Member Age")
            {

            }
            column(PrincToppeD; PrincToppeD)
            {

            }
            column(IntrTopped; IntrTopped)
            {

            }
            column(Installments; Installments)
            {

            }
            column(Interest; Interest)
            {

            }
            column(ProrataAmount; ProrataAmount)
            {

            }
            column(Main_Sector_Description; "Main Sector Description")
            {

            }
            column(DepositBoost; DepositBoost)
            {

            }
            column(TopUpComms; TopUpComms)
            {

            }
            column(TpUpfee; TpUpfee)
            {

            }
            column(MemberDeposits; MemberDeposits)

            { }
            column(VRepayment; VRepayment)
            {

            }
            column(VInterest; VInterest)
            {

            }

            trigger OnAfterGetRecord()
            begin
                MemberDeposits := 0;
                AmntTp := 0;
                EmployerName := '';
                ProductType := '';
                LastInPaid := 0;
                LastPrRep := 0;
                Appdate := '';
                LNInterest := 0;
                ExpectedDate := '';
                TopUpComms := 0;
                IntrTopped := 0;
                lastP := '';
                LastInPaid := 0;
                ApprovedDate := '';
                PrincToppeD := 0;
                OutstnBal := 0;
                MemberPFNumber := '';
                ActualPaid := 0;
                PrincipalArrears := 0;

                Members.RESET;
                Members.SETRANGE("No.", Loans."Member No.");
                Members.SetLoadFields("Payroll/Staff No.", "Employer Name");
                if Members.Find('-') then begin
                    MemberPFNumber := Members."Payroll/Staff No.";
                    EmployerName := Members."Employer Name";
                end;

                CalcFields("Outstanding Balance", "Outstanding Interest");
                LNInterest := "Outstanding Interest";
                OutstnBal := "Outstanding Balance";
                //(Expected-Paid; variance/arrears; Interest expected- Actual paid + unrealized interest). 

                if Loans."Expected Date of Completion" <> 0D then begin
                    ExpectedDate := GlobalFunc.FormatDate(Loans."Expected Date of Completion");
                    ApprovedDate := GlobalFunc.FormatDate(Loans."Approval Date");
                end;
                if "Application Date" <> 0D then
                    Appdate := GlobalFunc.FormatDate(Loans."Application Date");
                SetFilter("Date Filter", Format(StartDate) + '..' + Format(EndDate));
                CalcFields("Interest Paid", "Principle Paid");

                ActualPaid := "Principle Paid";
                Repayment := 0;
                RSchedule.Reset();
                RSchedule.SetRange("Loan No.", "Loan No.");
                RSchedule.SetRange("Repayment Date", CalcDate('-40Y', Today), EndDate);
                RSchedule.CalcSums("Principal Repayment");
                Repayment := RSchedule."Principal Repayment";

                PrincipalArrears := Repayment - ActualPaid;
                LastInPaid := "Interest Paid";
                SavingAcc.Reset();
                SavingAcc.SetRange("Member No.", Loans."Member No.");
                SavingAcc.SetRange("Product Category", SavingAcc."Product Category"::"BOSA Deposits");
                SavingAcc.SetLoadFields(Balance);
                if SavingAcc.FindFirst() then begin
                    SavingAcc.CalcFields(Balance);
                    MemberDeposits := SavingAcc.Balance;
                end;

                VRepayment := Loans.Repayment - LastPrRep;
                VInterest := Loans."Outstanding Interest" - LastInPaid;
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
                    ApplicationArea = All;
                    Caption = 'Start Date';
                    ToolTip = 'Specifies the Start Date';
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                    ToolTip = 'Specifies the End Date';
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
        Company.CALCFIELDS(Company.Picture);

        CompanyNam := Company.Name;
        CompanyAddress := Company.Address + ' -Post Code: ' + Company."Post Code" + ' -City:' + Company.City + ' Region: ' + Company."Country/Region Code";
        CompanyTelephone := 'Tel: ' + Company."Phone No." + ' -Office Tel: ' + Company."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + Company."E-Mail" + '- Website: ' + Company."Home Page";
    end;

    var
        ProductType: Text;
        IntrTopped: Decimal;
        TopUpComms: Decimal;
        PrincToppeD: Decimal;
        ExpectedDate: Text;
        LNInterest: Decimal;
        OutstnBal: Decimal;
        MemberBiodata: Text;
        SavingAcc: Record "Savings Accounts";
        ApprovedDate: Text;
        Appdate: Text;
        lastP: Text;
        LatPaydate: Date;
        GlobalFunc: Codeunit "Global Functions";
        LastPrRep: Decimal;

        LastInPaid: Decimal;

        DepositBoost: Text;
        TpUpfee: Decimal;
        MemberDeposits: Decimal;
        CompanyNam: Text;

        ProrataAmount: Decimal;

        Company: Record "Company Information";
        AmntTp: Decimal;
        Days: Integer;
        OtherCommitementsClearance: Record "Other Commitements Clearance";
        EmployerName: Text;
        AccountCategory: Enum "Account Category";
        Member: Record "Members";
        VRepayment: Decimal;
        VInterest: Decimal;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        MemberPFNumber: Text;
        Members: Record "Members";
        StartDate: Date;
        EndDate: Date;
        ActualPaid: Decimal;
        PrincipalArrears: Decimal;
        RSchedule: Record "Ideal Repayment Schedule";
}
