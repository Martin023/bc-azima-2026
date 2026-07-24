namespace KenpipeCBS.KenpipeCBS;
using Microsoft.Foundation.Company;

report 52186207 "Loan Insurance Report"
{
    ApplicationArea = All;
    Caption = 'Loan Insurance Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Loan Insurance Register.rdl';
    dataset
    {
        dataitem(Loans; Loans)
        {
            CalcFields = "Total Loan Balance";
            DataItemTableView = where("Total Loan Balance" = filter(> 0));
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

            column(Loan_Principle_Repayment; "Loan Principle Repayment")
            {

            }
            column(Posted; Posted)
            {

            }
            column(Loan_Interest_Repayment; "Loan Interest Repayment")
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
            column(Picture; Company.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyNam; CompanyNam)
            {
            }
            column(OutstnBal; Loans."Outstanding Balance")
            {

            }

            column(LNInterest; Loans."Outstanding Interest")
            {

            }
            column(Total_Loan_Balance; Loans."Total Loan Balance")
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {

            }
            column(CommunicationOnline; CommunicationOnline)
            {

            }
            column(ID_No_; "ID No.")
            {

            }
            column(FosaAcc; FosaAcc)
            {
            }
            column(Disbursement_Date; "Disbursement Date")
            {
            }
            column(DepositBal; DepositBal) { }
            column(RemainingPeriod; RemainingPeriod) { }
            trigger OnpreDataItem()
            begin
                Loans.reset();
                Loans.setrange("Disbursement Date", StartDate, EndDate);
            end;

            trigger OnAfterGetRecord()
            begin
                RemainingPeriod := 0;
                if Memb.get(Loans."Member No.") then begin
                    MemberDOB := Memb."Date of Birth";
                    if "ID No." = '' then
                        "ID No." := Memb."Primary Identification";
                end
                else
                    MemberDOB := 0D;
                // SavAcc.reset();
                // SavAcc.setrange("Member No.", Loans."Member No.");
                // SavAcc.setrange(SavAcc."Product Type", '191');
                // if SavAcc.FindFirst() then
                //     FosaAcc := SavAcc."No."
                // else
                //     FosaAcc := '';
                SavAcc.reset();
                SavAcc.setrange("Member No.", Loans."Member No.");
                SavAcc.setrange(SavAcc."Product Category", SavAcc."Product Category"::"BOSA Deposits");
                if SavAcc.FindFirst() then begin
                    savAcc.CalcFields(Balance);
                    DepositBal := SavAcc.Balance;
                end;

                LoanRepaySched.reset();
                LoanRepaySched.SetRange("Loan No.", Loans."Loan No.");
                LoanRepaySched.setfilter("Repayment Date", '>%1', EndDate);
                if LoanRepaySched.findset() then
                    RemainingPeriod := LoanRepaySched.count();

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(StartDate; StartDate)
                    {
                        Caption = 'Start Date';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the start date for the report.';
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'End Date';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the end date for the report.';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
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

        if (StartDate = 0D) or (EndDate = 0D) then
            error('Please enter Start and End Date.');
    end;

    var
        MemberDOB: Date;
        IntrTopped: Decimal;
        GlobalFun: Codeunit "Global Functions";
        CompanyNam: Text;
        CommunicationOnline: Text;
        ProrataAmount: Decimal;

        Company: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        Memb: record Members;
        SavAcc: Record "Savings Accounts";
        FosaAcc: Code[30];
        StartDate: Date;
        EndDate: Date;
        DepositBal: Decimal;
        RemainingPeriod: Integer;
        LoanRepaySched: record "Ideal Repayment Schedule";
}
