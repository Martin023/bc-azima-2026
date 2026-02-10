Report 52186105 "Deposit FOSA List Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Deposit FOSA List New.rdl';

    dataset
    {
        dataitem("Savings Accounts"; "Savings Accounts")
        {
            column(No_savacc; "No.")
            {

            }
            column(Name_Savacc; Name)
            {

            }
            column(Member_No_; "Member No.")
            {

            }
            column(ID_No_; "ID No.")
            {

            }
            column(Status; Status)
            {

            }
            column(Product_Type; "Product Type")
            {

            }
            column(Product_Name; "Product Name")
            {

            }
            column(Registration_Date; "Registration Date")
            {

            }
            column(Global_Dimension_1_Code_Savacc; "Global Dimension 1 Code")
            {

            }
            column(Balance__LCY_Savacc; "Balance (LCY)")
            {

            }
            column(AccNo; AccNo)
            {

            }
            column(CustID; CustID)
            {

            }
            column(CustName; CustName)
            {

            }
            column(ProductCode; ProductCode)
            {

            }
            column(ProductDesc; ProductDesc)
            {

            }
            column(DepositType; DepositType)
            {

            }
            column(CreationDate; CreationDate)
            {

            }
            column(Branch; Branch)
            {

            }
            column(EmpCode; EmpCode)
            {

            }
            column(LastTransAmt; LastTransAmt)
            {

            }
            column(LastTransDate; LastTransDate)
            {

            }
            column(DocNo; DocNo)
            {

            }
            column(Narration; Narration)
            {

            }
            column(CurrentBalance; CurrentBalance)
            {

            }
            column(IntRate; IntRate)
            {

            }
            column(AccruedInterest; AccruedInterest)
            {

            }
            column(ExpiryDate; ExpiryDate)
            {

            }
            column(DurationDays; DurationDays)
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
                AccNo := "Savings Accounts"."No.";
                CustID := "Savings Accounts"."Member No.";
                CustName := "Savings Accounts".Name;
                ProductCode := "Savings Accounts"."Product Type";
                ProductDesc := "Savings Accounts"."Product Name";
                DepositType := "Savings Accounts"."Product Category";
                CreationDate := "Savings Accounts"."Registration Date";
                Branch := "Savings Accounts"."Global Dimension 1 Code";
                EmpCode := "Savings Accounts"."Employer Code";
                CurrentBalance := "Savings Accounts"."Balance (LCY)";

                SavingLedgerEntry.Reset();
                SavingLedgerEntry.SetRange("Customer No.", "Savings Accounts"."No.");
                // SavingLedgerEntry.SetFilter();
                SavingLedgerEntry.CalcSums("Credit Amount (LCY)");
                CurrentBalance := SavingLedgerEntry."Credit Amount (LCY)";


                SavingLedgerEntry.Reset();
                SavingLedgerEntry.SetRange("Customer No.", "Savings Accounts"."No.");
                if SavingLedgerEntry.FindLast() then begin
                    LastTransDate := SavingLedgerEntry."Posting Date";
                    LastTransAmt := SavingLedgerEntry."Credit Amount (LCY)";
                    DocNo := SavingLedgerEntry."Document No.";
                    Narration := SavingLedgerEntry.Description;

                end;

                FDContract.Reset();
                FDContract.SetRange("Fixed Deposit Account No.", "Savings Accounts"."No.");
                FDContract.SetRange("Member No.", "Savings Accounts"."Member No.");
                if FDContract.FindFirst() then begin
                    IntRate := FDContract."Neg. Interest Rate";
                    AccruedInterest := FDContract."Untranfered Interest";
                    ExpiryDate := FDContract."FD Maturity Date";
                    // DurationDays := Abs("FD Maturity Date" - FDContract."Application Date");
                end;

                FDType.Reset();
                FDType.SetRange(Code, FDContract."Fixed Deposit Type");
                if FDType.FindFirst() then begin
                    FDCalcLines.Reset();
                    FDCalcLines.SetRange(Code, FDType.Code);
                    if FDCalcLines.Find('-') then begin
                        IntRate := FDCalcLines."Interest Rate";
                    end;
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
                field(StartDate; StartDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Start Date';
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'End Date';
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
        StartDate: Date;
        EndDate: Date;
        Company: Record "Company Information";
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        AccNo: Code[40];
        CustID: Code[50];
        CustName: Text[100];
        Status: Option;
        ProductCode: Code[40];
        ProductDesc: Text[100];
        DepositType: Option;
        CreationDate: Date;
        Branch: Code[40];
        OpeningOfficer: Code[50];
        CurrentBalance: Decimal;
        LastTransDate: Date;
        LastTransAmt: Decimal;
        DocNo: Code[50];
        Narration: Text[200];
        EmpCode: Code[30];
        IntRate: Decimal;
        AccruedInterest: Decimal;
        DurationDays: Integer;
        ExpiryDate: Date;
        SavingLedgerEntry: Record "Savings Ledger Entry";
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        FDContract: Record "Fixed Deposit Contract";
        FDType: Record "Fixed Deposit Type";
        FDCalcLines: Record "FD Interest Calculation Rules";
}

