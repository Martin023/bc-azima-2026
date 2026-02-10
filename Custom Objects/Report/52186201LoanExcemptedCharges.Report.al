report 52186201 "Loan Excempted Charges"
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Loan Excempted Charges';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Loan Excempted Charges.rdl';

    dataset
    {
        dataitem("Excempted Product Charges"; "Excempted Product Charges")
        {
            column(Loan_No; "Loan No.")
            {
            }
            column(Charge_Code; "Charge Code")
            {
            }
            column(Charge_Description; "Charge Description")
            {
            }
            column(Percentage; Percentage)
            {
            }
            column(Charge_Type; "Charge Type")
            {
            }
            column(Product_Code; "Product Code")
            {
            }
            column(Charge_Amount; "Charge Amount")
            {
            }
            column(Excempt; Excempt)
            {

            }
            column(Excempt_By; "Excempt By")
            {

            }
            column(CommunicationOnline; CommunicationOnline)
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
            column(LoanProcessingFee; LoanProcessingFee)
            {

            }
            column(TopUpBridgingInterest; TopUpBridgingInterest)
            {

            }
            column(TopUpPriIntBal; TopUpPriIntBal)
            {

            }
            column(TopUpDate; TopUpDate)
            {

            }
            column(TopUpLoanType; TopUpLoanType)
            {

            }
            column(TopUpOutstandingInterestBal; TopUpOutstandingInterestBal)
            {

            }
            column(TopUpLoanNo; TopUpLoanNo)
            {

            }
            column(TopUpOutstandingPrincipalBal; TopUpOutstandingPrincipalBal)
            {

            }
            column(TopUpProcessingFeeAmount; TopUpProcessingFeeAmount)
            {

            }
            column(TopUpBridgingAmount; TopUpBridgingAmount)
            {

            }
            column(EmpCode; EmpCode)
            {

            }
            column(MemberNo; MemberNo)
            {

            }
            column(LoanProductName; LoanProductName)
            {

            }
            column(LoanProductType; LoanProductType)
            {

            }
            column(DisbursementDate; DisbursementDate)
            {

            }
            column(AmountToDisburse; AmountToDisburse)
            {

            }


            trigger OnAfterGetRecord()
            begin

                LoanProcessingFee := 0;
                TopUpBridgingInterest := 0;
                TopUpPriIntBal := 0;
                TopUpOutstandingInterestBal := 0;

                Loans.Reset();
                Loans.SetRange("Loan No.", "Excempted Product Charges"."Loan No.");
                if Loans.FindFirst() then begin

                    MemberNo := Loans."Member No.";
                    EmpCode := Loans."Employer Code";
                    LoanProductType := Loans."Loan Product Type";
                    LoanProductName := Loans."Loan Product Type Name";
                    AmountToDisburse := Loans."Amount To Disburse";
                    DisbursementDate := Loans."Disbursement Date";

                    LoanTopUp.Reset();
                    LoanTopUp.SetRange("Loan No.", Loans."Loan No.");
                    if LoanTopUp.FindFirst() then begin
                        TopUpLoanType := LoanTopUp."Loan Type";
                        TopUpLoanNo := LoanTopUp."Loan Top Up";
                        TopUpOutstandingPrincipalBal := LoanTopUp."Principle Top Up";
                        TopUpOutstandingInterestBal := LoanTopUp."Interest Top Up";
                        TopUpPriIntBal := LoanTopUp."Total Top Up";
                    end;

                    ProductFactory.Reset();
                    ProductFactory.SetRange("Product ID", Loans."Loan Product Type");
                    if ProductFactory.FindFirst() then begin
                        LoanProductCharges.Reset();
                        LoanProductCharges.SetRange("Product Code", ProductFactory."Product ID");
                        LoanProductCharges.SetRange("Charge Type", LoanProductCharges."Charge Type"::General);
                        if LoanProductCharges.FindFirst() then begin
                            LoanProcessingFee := LoanProductCharges.Percentage;
                        end;
                    end;
                end;

                TopUpBridgingAmount := TopUpBridgingInterest * TopUpOutstandingPrincipalBal;
                TopUpProcessingFeeAmount := LoanProcessingFee * Loans."Amount To Disburse";
            end;

        }
    }

    requestpage
    {
        // layout
        // {
        //     area(Content)
        //     {
        //         group(FilterOptions)
        //         {
        //             field(StartDate; StartDate)
        //             {
        //                 ApplicationArea = All;
        //                 Caption = 'Start Date';
        //             }
        //             field(EndDate; EndDate)
        //             {
        //                 ApplicationArea = All;
        //                 Caption = 'End Date';
        //             }
        //         }
        //     }
        // }
    }

    var
        StartDate: Date;
        EndDate: Date;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        LoanCharges: Record "Loan Charges";
        LoanProductCharges: Record "Loan Product Charges";
        LoanTopUp: Record "Loans Top up";
        TopUpLoanType: Code[20];
        TopUpLoanNo: Code[20];
        TopUpOutstandingPrincipalBal: Decimal;
        TopUpOutstandingInterestBal: Decimal;
        TopUpPriIntBal: Decimal;
        TopUpBridgingInterest: Decimal;
        TopUpDate: Date;
        LoanProcessingFee: Decimal;
        ProductFactory: Record "Product Factory";
        TopUpBridgingAmount: Decimal;
        TopUpProcessingFeeAmount: Decimal;
        Loans: Record Loans;
        MemberNo: Code[20];
        EmpCode: Code[20];
        LoanProductName: Text[100];
        LoanProductType: Code[20];
        DisbursementDate: Date;
        AmountToDisburse: Decimal;

    trigger OnPreReport()
    begin
        // if (StartDate <> 0D) and (EndDate <> 0D) then
        //     Loans.SetRange("Disbursement Date", StartDate, EndDate);
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;
}