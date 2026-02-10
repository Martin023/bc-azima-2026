#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186141 "FOSA Account Page List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/FOSA Account Page List.rdl';

    dataset
    {
        dataitem("Savings Accounts"; "Savings Accounts")
        {
            DataItemTableView = where("Product Category" = filter("Fosa Account"));
            RequestFilterFields = "Employer Code", "Member No.";
            column(No_; "No.")
            {

            }
            column(Old_Account_No; "Old Account No")
            {

            }
            column(Name; Name)
            {

            }
            column(Date_of_Birth; "Date of Birth")
            {

            }
            column(ID_No_; "ID No.")
            {

            }
            column(Payroll_Staff_No_; "Payroll/Staff No.")
            {

            }
            column(Product_Type; "Product Type")
            {

            }
            column(Product_Name; "Product Name")
            {

            }
            column(Salary_Through_FOSA; "Salary Through FOSA")
            {

            }
            column(Global_Dimension_2_Code; "Global Dimension 2 Code")
            {

            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {

            }
            column(Customer_Posting_Group; "Customer Posting Group")
            {

            }
            column(Blocked; Blocked)
            {

            }
            column(Phone_No_; "Phone No.")
            {

            }
            column(Balance__LCY_; "Balance (LCY)")
            {

            }
            column(ATM_Cards; "ATM Cards")
            {

            }
            column(Registration_Date; "Registration Date")
            {

            }
            column(Status; Status)
            {

            }
            column(Employer_Code; "Employer Code")
            {

            }
            column(BOSAAccNo; BOSAAccNo)
            {

            }
            column(DividendDefaulter; DividendDefaulter)
            {

            }
            column(NonSalariedAcc; NonSalariedAcc)
            {

            }
            column(FDMaturityInstructions; FDMaturityInstructions)
            {

            }
            column(FDDuration; FDDuration)
            {

            }
            column(FDMaturityDate; FDMaturityDate)
            {

            }
            column(FDType; FDType)
            {

            }
            column(FDStatus; FDStatus)
            {

            }
            column(UntranferedInterest; UntranferedInterest)
            {

            }
            column(InterestEarned; InterestEarned)
            {

            }
            column(LastTransDate; LastTransDate)
            {

            }
            column(LastWithdrawalDate; LastWithdrawalDate)
            {

            }
            column(CardNo; CardNo)
            {

            }
            column(ATMExpiryDate; ATMExpiryDate)
            {

            }
            column(BusinessLoanNo; BusinessLoanNo)
            {

            }
            column(ATMNo; ATMNo)
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


            trigger OnAfterGetRecord()
            begin
                SavingLedgerEntry.Reset();
                SavingLedgerEntry.SetRange("Customer No.", "Savings Accounts"."No.");
                if SavingLedgerEntry.FindLast() then begin
                    LastTransDate := SavingLedgerEntry."Posting Date";
                    CashierTrans.Reset();
                    CashierTrans.SetRange("Account No", SavingLedgerEntry."Customer No.");
                    CashierTrans.SetRange(No, SavingLedgerEntry."Document No.");
                    CashierTrans.SetRange(Type, CashierTrans.Type::"Cash Withdrawal");
                    if CashierTrans.FindLast() then begin
                        LastWithdrawalDate := CashierTrans."Date Posted";
                    end;
                end;

                FDContract.Reset();
                FDContract.SetRange("Member No.", "Savings Accounts"."Member No.");
                FDContract.SetRange("Fixed Deposit Account No.", "Savings Accounts"."No.");
                if FDContract.FindFirst() then begin
                    FDMaturityInstructions := FDContract."FD Maturity Instructions";
                    FDDuration := FDContract."FD Duration";
                    FDMaturityDate := FDContract."FD Maturity Date";
                    FDType := FDContract."Fixed Deposit Type";
                    FDStatus := FDContract."Fixed Deposit Status";
                    UntranferedInterest := FDContract."Untranfered Interest";
                    InterestEarned := FDContract."Untranfered Interest";
                end;

                ATMLinking.Reset();
                ATMLinking.SetRange("Account No", "Savings Accounts"."No.");
                if ATMLinking.FindFirst() then begin
                    CardNo := ATMLinking."Card No";
                    ATMNo := ATMLinking."Card No";
                    ATMExpiryDate := ATMLinking."Card Expiry Date";

                end;

                SavAcc.Reset();
                SavAcc.SetRange("No.", "Savings Accounts"."No.");
                SavAcc.SetRange("Member No.", "Savings Accounts"."Member No.");
                SavAcc.SetRange("Product Category", SavAcc."Product Category"::"BOSA Deposits");
                if SavAcc.FindFirst() then begin
                    BOSAAccNo := SavAcc."No.";
                end;

                Loans.Reset();
                Loans.SetRange("Member No.", "Savings Accounts"."No.");
                Loans.SetRange("Source Unit", Loans."Source Unit"::"BUSINESS LOANS");
                if Loans.FindFirst() then begin
                    BusinessLoanNo := Loans."Loan No.";
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
        CompanyInformation: Record "Company Information";
        Loans: Record Loans;
        FDContract: Record "Fixed Deposit Contract";
        SavAcc: Record "Savings Accounts";
        FDMaturityInstructions: Option;
        FDDuration: DateFormula;
        FDMaturityDate: Date;
        FDType: Code[100];
        FDStatus: Option;
        UntranferedInterest: Decimal;
        InterestEarned: Decimal;
        LastTransDate: Date;
        LastWithdrawalDate: Date;
        ATMStorage: Record "ATM Card Storage";
        ATMLinking: Record "ATM Linking Applications";
        CardNo: Code[100];
        ATMNo: Code[100];
        ATMExpiryDate: Date;
        BusinessLoanNo: Code[100];
        NonSalariedAcc: Boolean;
        DividendDefaulter: Code[100];
        BOSAAccNo: Code[100];
        SavingLedgerEntry: Record "Savings Ledger Entry";
        CashierTrans: Record "Cashier Transactions";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyNam: Text;
        CommunicationOnline: Text;
        Company: Record "Company Information";

}
