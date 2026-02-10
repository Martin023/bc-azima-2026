#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186027 "Loan Arrears Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Loan Arrears Report.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = const(true));
            RequestFilterFields = "Employer Code", "Member No.", "Loan Product Type", "Disbursement Date";
            column(LoanNo_Loans; Loans."Loan No.")
            {
            }
            column(Repayment; Loans.Repayment)
            {
            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
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
            column(Amount_To_Disburse; "Amount To Disburse")
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
            column(ID_No_; "ID No.")
            {

            }
            column(Staff_No; "Staff No")
            {

            }
            column(Employer_Code; "Employer Code")
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
                LoanreX.Reset();
                LoanreX.SetRange(LoanreX."Loan No.", Loans."Loan No.");
                if LoanreX.FindFirst() then begin
                    LoanreX.CalcFields("Outstanding Balance", "Outstanding Interest");
                    LNInterest := LNInterest + LoanreX."Outstanding Interest";
                    OutstnBal := OutstnBal + LoanreX."Outstanding Balance";
                end;
                if Loans."Expected Date of Completion" <> 0D then begin
                    ExpectedDate := GlobalFunc.FormatDate(Loans."Expected Date of Completion");
                    ApprovedDate := GlobalFunc.FormatDate(Loans."Approval Date");
                end;
                if "Application Date" <> 0D then
                    Appdate := GlobalFunc.FormatDate(Loans."Application Date");
                Creditledger.Reset();
                Creditledger.SetRange("Loan No", Loans."Loan No.");
                Creditledger.SetRange("Transaction Type", Creditledger."Transaction Type"::Repayment);
                if Creditledger.FindLast() then begin
                    LatPaydate := Creditledger."Posting Date";
                    LastPrRep := Creditledger.Amount;
                    if LatPaydate <> 0D then
                        lastP := GlobalFunc.FormatDate(LatPaydate);
                end;
                Creditledger.Reset();
                Creditledger.SetRange("Loan No", Loans."Loan No.");
                Creditledger.SetRange("Transaction Type", Creditledger."Transaction Type"::"Interest Paid");
                if Creditledger.FindLast() then begin
                    LastInPaid := Creditledger.Amount;
                end;
                SavingAcc.Reset();
                SavingAcc.SetRange("Member No.", Loans."Member No.");
                SavingAcc.SetRange("Product Category", SavingAcc."Product Category"::"BOSA Deposits");
                if SavingAcc.FindFirst() then begin
                    SavingAcc.CalcFields(Balance);
                    MemberDeposits := SavingAcc.Balance;
                end;

                VRepayment := Loans.Repayment - LastPrRep;
                VInterest := Loans."Outstanding Interest" - LastInPaid;
                // LoansTopup.Reset;
                // LoansTopup.SetRange("Loan No.", "Loan No.");
                // LoansTopup.SetRange("Client Code", Loans."Member No.");
                // if LoansTopup.Find('-') then begin
                //     LoansTopup.CalcSums("Total Top Up", "Principle Top Up", "Interest Top Up");
                //     AmntTp := LoansTopup."Total Top Up";
                //     IntrTopped := LoansTopup."Interest Top Up";
                //     PrincToppeD := LoansTopup."Principle Top Up";
                //     TopUpComms := LoansTopup.Commision;
                // end;

                // OtherCommitementsClearance.Reset;
                // OtherCommitementsClearance.SetRange("Loan No.", Loans."Loan No.");
                // if OtherCommitementsClearance.Find('-') then begin
                //     OtherCommitementsClearance.CalcSums(Amount);
                //     AmntTp := AmntTp + OtherCommitementsClearance.Amount;
                // end;

                // Days := 0;
                // if Loans."Disbursement Date" <> 0D then
                //     Days := Today - Loans."Disbursement Date";
                // if ProductFactory.Get(Loans."Loan Product Type") then
                //     ProductType := ProductFactory."Product Description";
                // if Customer.Get(Loans."Employer Code") then
                //     EmployerName := Customer.Name;
                // if Member.Get(Loans."Member No.") then
                //     AccountCategory := Member."Account Category";
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
        IntrTopped: Decimal;
        TopUpComms: Decimal;
        PrincToppeD: Decimal;
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

        LastInPaid: Decimal;

        DepositBoost: Text;
        TpUpfee: Decimal;
        MemberDeposits: Decimal;
        CompanyNam: Text;

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
        VRepayment: Decimal;
        VInterest: Decimal;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
