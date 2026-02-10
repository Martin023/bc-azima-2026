namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52185793 "Secured Loans Report"
{
    ApplicationArea = All;
    Caption = 'Secured Loans Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Secured Loans Report.rdl';


    dataset
    {
        dataitem(LoanGuarantorsandSecurity; "Loan Guarantors and Security")
        {
            RequestFilterFields = "Loan No", "Source Unit", "Guarantor Type";
            column(LoanNo; "Loan No")
            {
            }

            column(MemberNo; "Member No")
            {
            }
            column(LoaneeName; "Loanee Name")
            {
            }
            column(LoanBalance; "Loan Balance")
            {
            }
            column(ProportionGuaranteed; "Proportion Guaranteed")
            {
            }
            column(TotalSum; "Total Sum")
            {
            }
            column(AccountNo; "Account No.")
            {
            }
            column(MemberGuaranteed; "Member Guaranteed")
            {
            }
            column(GuarantorType; "Guarantor Type")
            {
            }
            column(CollateralRegNo; "Collateral Reg. No.")
            {
            }
            column(CollateralValue; "Collateral Value")
            {
            }
            column(OutstandingBalance; "Outstanding Balance")
            {
            }
            column(ApplicationDate; ApplicationDate) { }
            column(ApprovalDate; ApprovalDate) { }
            column(AmountApplied; AmountApplied) { }
            column(AmountApproved; AmountApproved) { }
            column(DisbursementDate; DisbursementDate) { }
            column(ForceSaleValue; ForceSaleValue) { }
            column(SourceUnit; "Source Unit") { }
            column(CollareralBalance; CollateralBalance) { }
            column(CBalance; CBalance) { }
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

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                ApplicationDate := 0D;
                ApprovalDate := 0D;
                DisbursementDate := 0D;
                AmountApplied := 0;
                AmountApproved := 0;
                ForceSaleValue := 0;
                CollateralBalance := 0;

                Loans.RESET;
                Loans.SetRange("Loan No.", LoanGuarantorsandSecurity."Loan No");
                if Loans.Find('-') then begin
                    repeat
                        ApplicationDate := Loans."Application Date";
                        ApprovalDate := Loans."Approval Date";
                        DisbursementDate := Loans."Disbursement Date";
                        AmountApplied := Loans."Requested Amount";
                        AmountApproved := Loans."Approved Amount";

                        //LoanGuarantorsandSecurity.Reset();
                        LoanGuarantorsandSecurity.SetRange("Loan No", Loans."Loan No.");
                        if LoanGuarantorsandSecurity.Find('-') then begin
                            LoanGuarantorsandSecurity.CalcSums("Amount Guaranteed", "Loan Balance");
                            CollateralBalance := LoanGuarantorsandSecurity."Amount Guaranteed" - LoanGuarantorsandSecurity."Outstanding Balance";
                            CBalance := AmountApproved - LoanGuarantorsandSecurity."Amount Guaranteed";
                        end;
                    until Loans.Next() = 0;
                end;

                SecurityRegister.RESET;
                SecurityRegister.SetRange("No.", LoanGuarantorsandSecurity."Collateral Reg. No.");
                if SecurityRegister.Find('-') then begin
                    repeat
                        ForceSaleValue := SecurityRegister."Forced Sale Value";
                    until SecurityRegister.Next() = 0;
                end;



            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
            end;

        }

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
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Loans: Record Loans;
        ApplicationDate: Date;
        ApprovalDate: Date;
        DisbursementDate: Date;
        AmountApplied: Decimal;
        AmountApproved: Decimal;
        SecurityRegister: Record "Securities Register";
        ForceSaleValue: Decimal;
        CollateralBalance: Decimal;
        CBalance: Decimal;
}
