#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185946 "Junior Saving Account Balances"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Junior Saving Account Balances.rdl';

    dataset
    {
        dataitem("Savings Accounts"; "Savings Accounts")
        {
            DataItemTableView = where("Product Type" = filter(511));
            RequestFilterFields = "Global Dimension 1 Code", "Balance (LCY)", "Product Type", "Account Category", "Fixed Deposit Status", "Fixed Deposit Type", "FD Maturity Date", "FD Duration", "FD Maturity Instructions", "Fixed Deposit Amount";

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
            column(Contribution; Contribution)
            {
            }
            column(SNo; "SNo.")
            {
            }
            column(LastTransactionDate; "Savings Accounts"."Last Transaction Date")
            {
            }
            column(MonthlyContribution; "Savings Accounts"."Monthly Contribution")
            {
            }
            column(FixedDepositStatus_SavingsAccounts; "Savings Accounts"."Fixed Deposit Status")
            {
            }
            column(PhoneNo_SavingsAccounts; "Savings Accounts"."Phone No.")
            {
            }
            column(Balance_SavingsAccounts; "Savings Accounts".Balance)
            {
            }
            column(BalanceLCY_SavingsAccounts; "Savings Accounts"."Balance (LCY)")
            {
            }
            column(Status_SavingsAccounts; "Savings Accounts".Status)
            {
            }
            column(EmployerCode_SavingsAccounts; "Savings Accounts"."Employer Code")
            {
            }
            column(DateofBirth_SavingsAccounts; "Savings Accounts"."Date of Birth")
            {
            }
            column(PayrollStaffNo_SavingsAccounts; "Savings Accounts"."Payroll/Staff No.")
            {
            }
            column(IDNo_SavingsAccounts; "Savings Accounts"."ID No.")
            {
            }
            column(MobilePhoneNo_SavingsAccounts; "Savings Accounts"."Mobile Phone No")
            {
            }
            column(Gender_SavingsAccounts; "Savings Accounts".Gender)
            {
            }
            column(AccountCategory_SavingsAccounts; "Savings Accounts"."Account Category")
            {
            }
            column(ProductType_SavingsAccounts; "Savings Accounts"."Product Type")
            {
            }
            column(MemberNo_SavingsAccounts; "Savings Accounts"."Member No.")
            {
            }
            column(ProductName_SavingsAccounts; "Savings Accounts"."Product Name")
            {
            }
            column(FixedDepositType_SavingsAccounts; "Savings Accounts"."Fixed Deposit Type")
            {
            }
            column(FDMaturityDate_SavingsAccounts; "Savings Accounts"."FD Maturity Date")
            {
            }
            column(NegInterestRate_SavingsAccounts; "Savings Accounts"."Neg. Interest Rate")
            {
            }
            column(FDDuration_SavingsAccounts; "Savings Accounts"."FD Duration")
            {
            }
            column(FDMaturityInstructions_SavingsAccounts; "Savings Accounts"."FD Maturity Instructions")
            {
            }
            column(FixedDepositcertno_SavingsAccounts; "Savings Accounts"."Fixed Deposit cert. no")
            {
            }
            column(FixedDepositAmount_SavingsAccounts; "Savings Accounts"."Fixed Deposit Amount")
            {
            }
            column(SavingsAccountNo_SavingsAccounts; "Savings Accounts"."Savings Account No.")
            {
            }
            column(FDDateRenewed_SavingsAccounts; "Savings Accounts"."FD Date Renewed")
            {
            }
            column(No_SavingsAccounts; "Savings Accounts"."No.")
            {
            }
            column(Name_SavingsAccounts; "Savings Accounts".Name)
            {
            }
            column(GlobalDimension1Code_SavingsAccounts; "Savings Accounts"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_SavingsAccounts; "Savings Accounts"."Global Dimension 2 Code")
            {
            }
            column(ShowTotoDetail; ShowTotoDetail)
            {
            }
            column(DateofBirth; "Savings Accounts"."Date of Birth")
            {
            }
            column(MobilePhoneNo; "Savings Accounts"."Mobile Phone No")
            {
            }
            dataitem(Members; members)
            {
                DataItemLink = "No." = field("Member No.");
                column(ReportForNavId_37; 37)
                {
                }
                column(Parent_Name; Members.Name)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                "SNo." += 1;
                Contribution := 0;
                SavingsLedgerEntry.Reset;
                SavingsLedgerEntry.SetRange("Customer No.", "Savings Accounts"."No.");
                SavingsLedgerEntry.SetFilter("Document No.", "Savings Accounts".GetFilter("Savings Accounts"."Document No. Filter"));
                if SavingsLedgerEntry.Find('-') then begin
                    SavingsLedgerEntry.CalcSums("Amount (LCY)");
                    Contribution := Abs(SavingsLedgerEntry."Amount (LCY)");
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
                field(ShowTotoDetail; ShowTotoDetail)
                {
                    ApplicationArea = Basic;
                    Caption = 'ShowTotoDetail';
                }
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
        "SNo.": Integer;
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        Contribution: Decimal;
        ShowTotoDetail: Boolean;
}
