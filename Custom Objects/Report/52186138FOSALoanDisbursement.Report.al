#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186140 "FOSA Loan Disbursement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/FOSA Loan Disbursement.rdl';

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
            column(Repayment; Loans.Repayment)
            {
            }
            column(CRM_Application_No_; "CRM Application No.")
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

            column(Status; Status)
            {

            }
            column(Total_Disbursed; "Total Disbursed")
            {

            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            {

            }
            column(Disbursement_Date; "Disbursement Date")
            {

            }
            column(Disbursement_Account_No; "Disbursement Account No")
            {

            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {

            }
            column(Amount_To_Disburse; "Amount To Disburse")
            {

            }

            column(ApplicationDate_Loans; Loans."Application Date")
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
            column(StaffNo; Loans."Staff No")
            {
            }

            column(OutstandingBills_Loans; Loans."Outstanding Bills")
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
            column(Main_Sector_Description; "Main Sector Description")
            {

            }
            column(Loans_Category_SASRA; "Loans Category-SASRA")
            {

            }
            column(FirstInstallDate; FirstInstallDate)
            {

            }
            column(NextInstallDate; NextInstallDate)
            {

            }
            column(FosaAccount; FosaAccount)
            {

            }

            trigger OnAfterGetRecord()
            begin

                SavingAcc.Reset();
                SavingAcc.SetRange("Member No.", Loans."Member No.");
                SavingAcc.SetRange("Product Category", SavingAcc."Product Category"::"FOSA Account");
                if SavingAcc.FindFirst() then begin
                    FosaAccount := SavingAcc."No.";
                end;

                LoanRepaySchedule.Reset();
                LoanRepaySchedule.SetRange("Member No.", Loans."Member No.");
                LoanRepaySchedule.SetRange("Loan No.", Loans."Loan No.");
                if LoanRepaySchedule.FindFirst() then begin
                    FirstInstallDate := LoanRepaySchedule."Repayment Date";
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
        FosaAccount: Code[100];
        FirstInstallDate: Date;
        NextInstallDate: Date;
        LoanRepaySchedule: Record "Ideal Repayment Schedule";
        Creditledger: Record "Credit Ledger Entry";
        SavingAcc: Record "Savings Accounts";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyNam: Text;
        CommunicationOnline: Text;
        Company: Record "Company Information";

}
