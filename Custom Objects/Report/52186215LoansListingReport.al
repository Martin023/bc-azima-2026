#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186215 "Loans Listing_Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Loan Register.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = const(true));
            RequestFilterFields = "Employer Code", "Member No.", "Loan Product Type", "Disbursement Date";
            column(LoanNo_Loans; Loans."Loan No.")
            {
            }
            column(Responsible_Officer; "Responsible Officer")
            {

            }
            column(MemberDOB; MemberDOB)
            {

            }
            column(Repayment; Loans.Repayment)
            {
            }
            column(CRM_Application_No_; "CRM Application No.")
            {

            }
            column(Expected_Date_of_Completion; ExpectedDate)
            {

            }
            column(Loan_Principle_Repayment; "Loan Principle Repayment")
            {

            }
            column(Posted; Posted)
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
            column(Approval_Date; ApprovedDate)
            {

            }
            column(ApplicationDate_Loans; Loans."Application Date")
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
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyNam; CompanyNam)
            {
            }
            column(OutstnBal; OutstnBal)
            {

            }
            column(LNInterest; LNInterest)
            {

            }
            column(CompanyTelephone; CompanyTelephone)
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
            column(StaffNo; Loans."Staff No")
            {
            }
            column(Days; Days)
            {
            }
            column(ProductType; ProductType)
            {
            }
            column(EmployerName; EmployerName)
            {
            }
            column(OutstandingBills_Loans; Loans."Outstanding Bills")
            {
            }
            column(AccountCategory; AccountCategory)
            {
            }
            column(Application_Date; Appdate)
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
            column(Loans_Category_SASRA; "Loans Category-SASRA")
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
            column(Disbursement_Date; "Disbursement Date")
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
        MemberDOB: Text;
        IntrTopped: Decimal;
        GlobalFun: Codeunit "Global Functions";
        TopUpComms: Decimal;
        PrincToppeD: Decimal;
        CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
        ExpectedDate: Text;
        Creditledger: Record "Credit Ledger Entry";
        LoanreX: Record loans;
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
        CompanyAddress: Text;
        LastInPaid: Decimal;
        CompanyTelephone: Text;
        DepositBoost: Text;
        MembersRec: Record Members;
        TpUpfee: Decimal;
        MemberDeposits: Decimal;
        CompanyNam: Text;
        CommunicationOnline: Text;
        ProrataAmount: Decimal;

        Company: Record "Company Information";
        LoansTopup: Record "Loans Top up";
        AmntTp: Decimal;
        Days: Integer;
        OtherCommitementsClearance: Record "Other Commitements Clearance";
        Customer: Record Customer;
        EmployerName: Text;
        ProductFactory: Record "Product Factory";
        AccountCategory: Enum "Account Category";
        Member: Record "Members";
}
