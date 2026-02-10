#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52187408 "Loan TAT Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Loan Listings Report.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where(Posted = const(true), "Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Employer Code", "Source Unit", "Member No.", "Loan Product Type";
            column(LoanNo_Loans; Loans."Loan No.")
            {
            }
            column(Status; Status)
            {

            }
            column(IntrTopped; IntrTopped)
            {

            }
            column(PrincToppeD; PrincToppeD)
            {

            }
            column(DisbursementD; DisbursementD)
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
            column(Repayment_Start_Date; repayStartD)
            {

            }
            column(Fosabal; Fosabal)
            {

            }
            column(Loan_Principle_Repayment; "Loan Principle Repayment")
            {

            }
            column(Loan_Interest_Repayment; "Loan Interest Repayment")
            {

            }
            column(Responsible_Officer; "Responsible Officer")
            {

            }
            column(LastInPaid; LastInPaid)
            {

            }
            column(LastPrRep; LastPrRep)
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
            column(Share_Boosted_Amount; Loans."Share Boosted Amount")
            {
            }
            column(ShareCashBoost; Loans."Loans - Deposit Purchase")
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
            column(Installments; Installments)
            {

            }
            column(Interest; Interest)
            {

            }
            column(ProrataAmount; ProrataAmount)
            {

            }

            column(Sub_Sector_Level2_Description; "Sub Sector Level2 Description")
            {

            }
            column(Loans_Category_SASRA; "Loans Category-SASRA")
            {

            }
            column(DepositBoost; DepositBoost)
            {

            }
            column(TpUpfee; TpUpfee)
            {

            }
            column(MemberDeposits; MemberDeposits)

            { }
            column(Source_Unit; "Source Unit")
            {

            }
            column(Staff_No; "Staff No")
            {

            }
            column(Days_In_Arrears; "Days In Arrears")
            {

            }
            column(AmountOn; AmountOn)
            {

            }
            column(AmtOFF; AmtOFF)
            {

            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {

            }
            column(Global_Dimension_2_Code; "Global Dimension 2 Code")
            {

            }
            column(ProrataAmt; ProrataAmt)
            {

            }
            column(Loan_BDE; "Relation Officer")
            { }
            trigger OnAfterGetRecord()
            begin
                MemberDeposits := 0;
                AmntTp := 0;
                EmployerName := '';
                ProductType := '';
                LastInPaid := 0;
                LastPrRep := 0;
                Appdate := '';
                ExpectedDate := '';
                DisbursementD := '';
                PrincToppeD := 0;
                IntrTopped := 0;
                AmntTp := 0;
                ProrataAmt := 0;
                OutstnBal := 0;
                repayStartD := '';
                Fosabal := 0;
                SavingAcc.Reset();
                SavingAcc.SetRange("Member No.", Loans."Member No.");
                SavingAcc.SetRange("Product Category", SavingAcc."Product Category"::"BOSA Deposits");
                if SavingAcc.Find('-') then begin
                    ProrataAmt := CustomCuesCodeunit.Prorata(SavingAcc."Member No.", SavingAcc."Product Type");
                end;
                if Loans."Repayment Start Date" <> 0D then
                    repayStartD := GlobalFunc.FormatDate(Loans."Repayment Start Date");

                if Loans."Disbursement Date" <> 0D then
                    DisbursementD := GlobalFunc.FormatDate(Loans."Disbursement Date");
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


                SavingAcc.Reset();
                SavingAcc.SetRange("Member No.", Loans."Member No.");
                SavingAcc.SetRange("No.", Loans."Disbursement Account No");
                if SavingAcc.FindFirst() then begin
                    SavingAcc.CalcFields(Balance);
                    Fosabal := SavingAcc.Balance;
                end;
                //Sharks
                LoansTopup.Reset;
                LoansTopup.SetRange("Loan No.", "Loan No.");
                if LoansTopup.Find('-') then begin
                    LoansTopup.CalcSums("Total Top Up", "Interest Top Up", "Principle Top Up");
                    AmntTp := LoansTopup."Total Top Up";
                    PrincToppeD := LoansTopup."Principle Top Up";
                    IntrTopped := PrincToppeD * 0.05;

                end;

                OtherCommitementsClearance.Reset;
                OtherCommitementsClearance.SetRange("Loan No.", Loans."Loan No.");
                if OtherCommitementsClearance.Find('-') then begin
                    OtherCommitementsClearance.CalcSums(Amount);
                    AmntTp := AmntTp + OtherCommitementsClearance.Amount;
                end;

                Days := 0;
                AmountOn := 0;
                AmtOFF := 0;
                AccountCategory := AccountCategory::" ";
                if Loans."Disbursement Date" <> 0D then
                    Days := Today - Loans."Disbursement Date";
                if ProductFactory.Get(Loans."Loan Product Type") then
                    ProductType := ProductFactory."Product Description";
                if Customer.Get(Loans."Employer Code") then
                    EmployerName := Customer.Name;
                if Member.Get(Loans."Member No.") then
                    AccountCategory := Member."Account Category";
                Checkofline.Reset();
                Checkofline.SetRange("Loan No.", Loans."Loan No.");
                Checkofline.SetRange(Type, Checkofline.Type::Credit);
                if Checkofline.FindLast() then begin
                    AmountOn := Checkofline."Amount On";
                    AmtOFF := Checkofline."Amount Off";
                end;
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
        PrincToppeD: Decimal;
        repayStartD: Text;
        AmtOFF: Decimal;
        Checkofline: Record "Checkoff Advice Line";
        AmountOn: Decimal;
        ExpectedDate: Text;
        Creditledger: Record "Credit Ledger Entry";
        LoanreX: Record loans;
        LNInterest: Decimal;
        Fosabal: Decimal;
        OutstnBal: Decimal;
        MemberBiodata: Text;
        CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
        SavingAcc: Record "Savings Accounts";
        ProrataAmt: Decimal;
        ApprovedDate: Text;
        Appdate: Text;
        lastP: Text;
        LatPaydate: Date;
        GlobalFunc: Codeunit "Global Functions";
        LastPrRep: Decimal;
        DisbursementD: Text;
        CompanyAddress: Text;
        LastInPaid: Decimal;
        CompanyTelephone: Text;
        DepositBoost: Text;
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
