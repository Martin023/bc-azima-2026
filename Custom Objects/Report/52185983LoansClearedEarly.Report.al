#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185983 "Loans Cleared Early"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Loans Cleared Early.rdl';
    Caption = 'Closed Loans Report';

    dataset
    {
        dataitem(Loans; Loans)
        {
            CalcFields = "Outstanding Balance";
            DataItemTableView = where(Posted = filter(true), "Outstanding Balance" = filter(<= 0));
            RequestFilterFields = "Employer Code", "Source Unit", "Member No.";
            column(CName; CompanyNam)
            {
            }
            column(CAddress; CompanyAddress)
            {
            }
            column(CPicture; Company.Picture)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {

            }
            column(Loan_Account; "Loan Account")
            {

            }
            column(LoanNo; Loans."Loan No.")
            {
            }
            column(LoanType; Loans."Loan Product Type")
            {
            }
            column(ApprovedAmount; Loans."Approved Amount")
            {
            }
            column(ExpectedCompletionDate; ExpectDate)
            {
            }
            column(DateCleared; DateCleared)
            {
            }
            column(MemberNo; Loans."Member No.")
            {
            }
            column(MemberName; Loans."Member Name")
            {
            }
            column(Recovery_Mode; "Recovery Mode")
            {

            }
            column(Responsible_Officer; "Responsible Officer")
            {

            }
            column(Staff_No; "Staff No")
            {

            }
            column(Employer_Code; "Employer Code")
            {

            }
            column(EmplyName; EmplyName)
            {

            }
            column(Loan_Product_Type_Name; "Loan Product Type Name")
            {

            }

            column(Interest; Interest)
            {

            }
            column(Installments; Installments)
            {

            }
            column(Member_No_; "Member No.")
            {

            }
            column(Member_Name; "Member Name")
            {

            }
            column(Amount_To_Disburse; "Amount To Disburse")
            {

            }
            column(DisDate; DisDate)
            {

            }
            column(OutSt; OutSt)
            {

            }
            column(AppComme; AppComme)
            {

            }
            trigger OnAfterGetRecord()
            begin
                DateCleared := '';
                DisDate := '';
                EmplyName := '';
                OutSt := 0;
                AppComme := '';
                LoansRec.Reset();
                LoansRec.SetRange("Loan No.", Loans."Loan No.");
                if LoansRec.FindFirst() then begin
                    LoansRec.CalcFields(LoansRec."Outstanding Balance");
                    OutSt := LoansRec."Outstanding Balance";
                end;
                LoanAppraisal.Reset();
                LoanAppraisal.SetRange("Loan No.", Loans."Loan No.");
                if LoanAppraisal.FindLast() then begin
                    AppComme := LoanAppraisal.Comment;

                end;
                if Cust.get(Loans."Employer Code") then begin
                    EmplyName := Cust.Name;
                end;
                if Loans."Disbursement Date" <> 0D then begin
                    DisDate := GlobalFunc.FormatDate(Loans."Disbursement Date");
                    ExpectDate := GlobalFunc.FormatDate(Loans."Expected Date of Completion");
                end;
                if Loans."Expected Date of Completion" >= Today then begin
                    if Loans."Outstanding Balance" <= 0 then begin
                        CreditLedgerEntry.Reset;
                        CreditLedgerEntry.SetRange(CreditLedgerEntry."Customer No.", Loans."Loan Account");
                        CreditLedgerEntry.SetRange(CreditLedgerEntry."Loan No", Loans."Loan No.");
                        CreditLedgerEntry.SetRange(CreditLedgerEntry."Transaction Type", CreditLedgerEntry."transaction type"::Repayment);
                        if CreditLedgerEntry.Find('+') then begin
                            DateCleared := GlobalFunc.FormatDate((CreditLedgerEntry."Posting Date"));
                        end;
                    end;
                end else
                    CurrReport.Skip;
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
        Company.Get;
        Company.CalcFields(Company.Picture);
        CompanyNam := Company.Name;
        CompanyAddress := Company.Address + ' -Post Code: ' + Company."Post Code" + ' -City:' + Company.City + ' Region: ' + Company."Country/Region Code";
        CompanyTelephone := 'Tel: ' + Company."Phone No." + ' -Office Tel: ' + Company."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + Company."E-Mail" + '- Website: ' + Company."Home Page";
    end;

    var
        DateCleared: Text;
        CreditLedgerEntry: Record "Credit Ledger Entry";
        Company: Record "Company Information";
        Cust: Record Customer;
        LoansRec: Record Loans;
        AppComme: Text;
        DisDate: Text;
        GlobalFunc: Codeunit "Global Functions";
        LoanAppraisal: Record "Loan Appraisal Comments";
        CompanyTelephone: Text;
        CompanyAddress: Text;
        CompanyNam: Text;
        OutSt: Decimal;
        CommunicationOnline: Text;
        ExpectDate: Text;
        EmplyName: Text;
}
