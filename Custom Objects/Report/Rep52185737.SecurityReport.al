namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52185737 "Security Report"
{
    ApplicationArea = All;
    Caption = 'Security Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Security Report.rdl';

    dataset
    {
        dataitem(SecuritiesRegister; "Securities Register")
        {
            RequestFilterFields = "Lending Unit", "Loan No.", "Account No.", "Status of the fees";
            column(No_; "No.")
            {
            }
            column(Collateral_Ref_No_; "Collateral Ref No.")
            {
            }
            column(Collateral_Reg_No_; "Collateral Reg No.")
            {
            }
            column(Collateral_Owner; "Collateral Owner")
            {
            }
            column(Collateral_Type; "Collateral Type")
            {
            }
            column(Amount_to_be_Charged; "Amount to be Charged")
            {
            }
            column(DateofIssueanceofInstructions; DateofIssueanceofInstructions)
            {
            }
            column(LoanNo; "Loan No.")
            {
            }
            column(LoanName; "Loan Name")
            {
            }
            column(LoanAmount; "Loan Amount")
            {
            }
            column(BOSADepositBalance; BOSADepositBalance)
            {
            }
            column(FixedDepositBalance; FixedDepositBalance)
            {
            }
            column(BusinessSavingsBalance; BusinessSavingsBalance)
            {
            }
            column(LoansOutstandingBalance; LoansOutstandingBalance)
            {
            }
            column(LoanOfferLetterDate; "Loan Offer Letter Date")
            {
            }
            column(LendingUnit; "Lending Unit")
            {
            }
            column(AccountName; "Account Name")
            {
            }
            column(AccountNo; "Account No.")
            {
            }
            column(AmounttobeCharged; "Amount to be Charged")
            {
            }
            column(Forced_Sale_Value; "Forced Sale Value")
            {
            }
            column(ChargeType; "Charge Type")
            {
            }
            // column(ChargorPhoneNo; "Chargor Phone No.")
            // {
            // }
            // column(ChargorOwnerIDNo; "Chargor/Owner ID No")
            // {
            // }
            // column(ChargorOwnerKRAPIN; "Chargor/Owner KRA PIN")
            // {
            // }
            // column(ChargorOwnerName; "Chargor/Owner Name")
            // {
            // }
            // column(CollateralDescription; "Collateral Description")
            // {
            // }
            // column(CollateralDischarged; "Collateral Discharged")
            // {
            // }
            column(CollateralLimit; "Collateral Limit")
            {
            }
            // column(CollateralMultiplier; "Collateral Multiplier")
            // {
            // }
            column(CollateralName; "Collateral Name")
            {
            }
            column(CollateralOwner; "Collateral Owner")
            {
            }
            column(CollateralRefNo; "Collateral Ref No.")
            {
            }
            column(CollateralRegNo; "Collateral Reg No.")
            {
            }
            column(CollateralType; "Collateral Type")
            {
            }
            column(CollateralValue; "Market Value")
            {
            }
            column(LawFirmHanldingtheMatter; "Law Firm Hanlding the Matter")
            {
            }
            column(Fees_Payable_to_the_firm; "Fees Payable to the firm")
            {
            }
            column(Statusofthefees; "Status of the fees")
            {
            }
            column(Valuer_Name; "Valuer Name")
            {
            }
            column(Market_Value; "Market Value")
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


            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                LoansOutstandingBalance := 0;
                BOSADepositBalance := 0;
                FixedDepositBalance := 0;
                BusinessSavingsBalance := 0;
                DateofIssueanceofInstructions := 0D;

                Loans.RESET;
                Loans.SETRANGE("Loan No.", SecuritiesRegister."Loan No.");
                if Loans.Find('-') then begin
                    Loans.CalcFields("Outstanding Balance");
                    LoansOutstandingBalance := Loans."Outstanding Balance";
                    RequestedAmount := Loans."Requested Amount";
                end;

                SavingsAccount.RESET;
                SavingsAccount.SETRANGE("Member No.", SecuritiesRegister."Account No.");
                SavingsAccount.Setrange("Product Category", SavingsAccount."Product Category"::"BOSA Deposits");
                if SavingsAccount.Find('-') then begin
                    SavingsAccount.CalcFields("Balance (LCY)");
                    BOSADepositBalance := SavingsAccount."Balance (LCY)";
                end;

                SavingsAccount.RESET;
                SavingsAccount.SETRANGE("Member No.", SecuritiesRegister."Account No.");
                SavingsAccount.Setrange("Product Category", SavingsAccount."Product Category"::"Fixed Deposit");
                if SavingsAccount.Find('-') then begin
                    SavingsAccount.CalcFields("Balance (LCY)");
                    FixedDepositBalance := SavingsAccount."Balance (LCY)";
                end;

                SavingsAccount.RESET;
                SavingsAccount.SETRANGE("Member No.", SecuritiesRegister."Account No.");
                SavingsAccount.Setrange("Product Category", SavingsAccount."Product Category"::"Business Deposits");
                if SavingsAccount.Find('-') then begin
                    SavingsAccount.CalcFields("Balance (LCY)");
                    BusinessSavingsBalance := SavingsAccount."Balance (LCY)";
                end;

                Perfection.RESET;
                Perfection.SETRANGE("Loan No.", SecuritiesRegister."Loan No.");
                if Perfection.Find('-') then begin
                    DateofIssueanceofInstructions := Perfection."Date of Issuance Instructions";
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
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
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

    Var

        CompanyInformation: Record "Company Information";
        EmployerName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        Loans: Record Loans;
        SavingsAccount: Record "Savings Accounts";
        LoansOutstandingBalance: Decimal;
        BOSADepositBalance: Decimal;
        FixedDepositBalance: Decimal;
        BusinessSavingsBalance: Decimal;
        Perfection: Record "Security Perfection";
        DateofIssueanceofInstructions: Date;
        RequestedAmount: Decimal;
}
