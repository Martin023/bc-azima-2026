#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185944 "Loan Recovery Variance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Loan Recovery Variance.rdl';

    dataset
    {
        dataitem(Loans; Loans)
        {
            DataItemTableView = where("Source Unit" = filter(FOSA));
            RequestFilterFields = "Loan No.", "Loan Product Type", "Member No.", "Member Class";
            column(ReportForNavId_1; 1)
            {
            }
            column(TotalLoanBalance; Loans."Total Loan Balance")
            {
            }
            column(LoanNo_Loans; Loans."Loan No.")
            {
            }
            column(ApplicationDate_Loans; Loans."Application Date")
            {
            }
            column(ID_No_; "ID No.")
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
            column(EmployerLoanNo; Loans."Employer Loan No.")
            {
            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            {
            }
            column(Loan_Product_Type; "Loan Product Type")
            {
            }
            column(Approved_Amount; "Approved Amount")
            {
            }
            column(EmployerCode; Loans."Employer Code")
            {
            }
            column(StaffNo; Loans."Staff No")
            {
            }
            column(MaturityDate; Loans."Expected Date of Completion")
            {
            }
            column(Disbursement_Date; "Disbursement Date")
            {
            }
            column(Frequecy; Loans."Repayment Frequency")
            {
            }
            column(Interest; Loans.Interest)
            {
            }
            column(Installments; Loans.Installments)
            {
            }
            column(RepayMode; Loans."Recovery Mode")
            {
            }
            column(FirstRepaymentDate; Loans."Repayment Start Date")
            {
            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {
            }
            column(Global_Dimension_2_Code; "Global Dimension 2 Code")
            {

            }
            column(DisbursementDate; Loans."Disbursement Date")
            {
            }
            column(Repayment; Loans.Repayment)
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
            column(PayDate; PayDate)
            {

            }
            column(RepayDate; RepayDate)
            {

            }
            column(Days_In_Arrears; "Days In Arrears")
            {

            }
            column(Amount_In_Arreas_SASRA; "Amount In Arreas SASRA")
            {

            }
            column(FosaBalance; FosaBalance)
            {

            }
            column(FOSAMainAcc; FOSAMainAcc)
            {

            }
            column(Variance; Variance)
            {

            }
            column(ActualRecovery; ActualRecovery)
            {

            }
            column(ExpectedAmt; ExpectedAmt)
            {

            }
            column(ProdIntRate; ProdIntRate)
            {

            }
            column(Installments_FallOff; "Installments FallOff")
            {

            }
            column(Total_Balance; "Total Balance")
            {

            }

            trigger OnAfterGetRecord()
            begin

                LoanRepaySchdl.Reset();
                LoanRepaySchdl.SetRange("Loan No.", Loans."Loan No.");
                LoanRepaySchdl.SetRange("Member No.", Loans."Member No.");
                if LoanRepaySchdl.FindFirst() then begin
                    PayDate := LoanRepaySchdl."Actual Loan Repayment Date";
                    RepayDate := LoanRepaySchdl."Repayment Date";
                    ExpectedAmt := LoanRepaySchdl."Monthly Repayment";
                    ActualRecovery := LoanRepaySchdl."Actual Repayment";
                    Variance := ExpectedAmt - ActualRecovery;
                    PrincipalAmt := LoanRepaySchdl."Principal Repayment";
                end;

                SavAcc.Reset();
                SavAcc.SetRange("Member No.", Loans."Member No.");
                SavAcc.SetRange("Product Category", SavAcc."Product Category"::"FOSA Account");
                if SavAcc.FindFirst() then begin
                    FOSAMainAcc := SavAcc."No.";
                    FosaBalance := SavAcc."Balance (LCY)";
                end;

                ProductFactory.Reset();
                ProductFactory.SetRange("Product ID", Loans."Loan Product Type");
                if ProductFactory.FindFirst() then begin
                    ProdIntRate := ProductFactory."Interest Rate (Min.)";
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

    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";

    end;

    var
        PrincipalAmt: Decimal;
        ProdIntRate: Decimal;
        SavAcc: Record "Savings Accounts";
        FOSAMainAcc: Code[100];
        FosaBalance: Decimal;
        Variance: Decimal;
        ExpectedAmt: Decimal;
        ActualRecovery: Decimal;
        CreditAccounts: Record "Credit Accounts";
        RepayDate: Date;
        ProductFactory: Record "Product Factory";
        PayDate: Date;
        LoanRepaySchdl: Record "Ideal Repayment Schedule";
        Members: Record Members;
        Company: Record "Company Information";
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
