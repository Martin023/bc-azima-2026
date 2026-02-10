report 52186020 "BOSA Accounts Fall-Off Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/BOSA Accounts Fall-Off.rdl';
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Deposit/Risk/BBF/Falloff Report';

    dataset
    {

        dataitem("Savings Accounts"; "Savings Accounts")
        {
            DataItemTableView = where("Product Category" = Filter("BOSA Deposits" | Risk | "Benevolent (BBF)"));
            column(IdentificationType; IdentificationType) { }
            column(IdentificationNo; IdentificationNo) { }
            column(EmployerCode; EmployerCode) { }

            column(No_SavingsAccounts; "Savings Accounts"."No.")
            {
            }
            column(Name_SavingsAccounts; "Savings Accounts".Name)
            {
            }
            column(PhoneNo_SavingsAccounts; "Savings Accounts"."Phone No.")
            {
            }
            column(GlobalDimension1Code_SavingsAccounts; "Savings Accounts"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_SavingsAccounts; "Savings Accounts"."Global Dimension 2 Code")
            {
            }
            column(Balance_SavingsAccounts; "Savings Accounts".Balance)
            {
            }
            column(Member_No_; "Savings Accounts"."Member No.")
            {
            }
            column(Product_Type; "Savings Accounts"."Product Type")
            {
            }
            column(Product_Name; "Savings Accounts"."Product Name")
            {
            }
            column(Status; "Savings Accounts".Status)
            {
            }
            column(Employer_Code; "Employer Code")
            {
            }
            column(Risk; Risk)
            {
            }
            column(ERisk; ERisk)
            {
            }
            column(VRisk; VRisk)
            {
            }
            column(BBF; BBF)
            {
            }
            column(EBBF; EBBF)
            {
            }
            column(VBBF; VBBF)
            {
            }
            column(BosaDep; BosaDep)
            {
            }
            column(EBosaDep; EBosaDep)
            {
            }
            column(VBosaDep; VBosaDep)
            {
            }
            column(Last_Transaction_Date; "Savings Accounts"."Last Transaction Date")
            {
            }
            column(BalanceLCY_SavingsAccounts; "Savings Accounts"."Balance (LCY)")
            {
            }
            column(PayrollStaffNo_SavingsAccounts; "Savings Accounts"."Payroll/Staff No.")
            {
            }
            column(IDNo_SavingsAccounts; "Savings Accounts"."ID No.")
            {
            }
            column(ATMTransactions_SavingsAccounts; "Savings Accounts"."ATM Transactions")
            {
            }
            column(ATMNo_SavingsAccounts; "Savings Accounts"."ATM No.")
            {
            }

            column(AccNo; "Savings Accounts".Balance)
            {
            }
            column(sno; SNo)
            {
            }
            column(Amount; Amount)
            {

            }
            column(Monthly_Contribution; "Monthly Contribution")
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
                SNo += 1;
                BBF := 0;
                Risk := 0;
                BosaDep := 0;
                EBBF := 0;
                ERisk := 0;
                EBosaDep := 0;
                VBBF := 0;
                VBosaDep := 0;
                VRisk := 0;
                CreatedBy := '';
                IdentificationType := '';
                IdentificationNo := '';
                EmployerCode := '';

                User.Reset;
                User.SetRange("User Name", Members."Created By");
                if User.Find('-') then begin
                    CreatedBy := User."Full Name";
                end;

                Members.Reset();
                Members.SetRange("No.", "Savings Accounts"."Member No.");
                if Members.Find('-') then begin
                    IdentificationType := Format(Members."Primary Identification Type");
                    IdentificationNo := Members."Primary Identification";
                    EmployerCode := Members."Employer Code";
                end;

                SavingAcc.Reset;
                SavingAcc.SetRange("Member No.", "Savings Accounts"."Member No.");
                SavingAcc.SetRange("Product Category", SavingAcc."Product Category"::"BOSA Deposits");
                if SavingAcc.Find('-') then begin
                    SavingAcc.CalcFields("Balance (LCY)");
                    BosaDep := SavingAcc.Balance;
                    // VBosaDep := ProdFact."Minimum Contribution" - SavingAcc.Balance;
                end;


                SavingAcc.Reset;
                SavingAcc.SetRange("Member No.", "Savings Accounts"."Member No.");
                SavingAcc.SetRange("Product Category", SavingAcc."Product Category"::"Benevolent (BBF)");
                if SavingAcc.Find('-') then begin
                    SavingAcc.CalcFields("Balance (LCY)");
                    BBF := SavingAcc.Balance;
                    // VBBF := ProdFact."Minimum Contribution" - SavingAcc.Balance;
                end;

                SavingAcc.Reset;
                SavingAcc.SetRange("Member No.", "Savings Accounts"."Member No.");
                SavingAcc.SetRange("Product Category", SavingAcc."Product Category"::Risk);
                if SavingAcc.Find('-') then begin
                    SavingAcc.CalcFields("Balance (LCY)");
                    Risk := SavingAcc.Balance;
                    // VRisk := ProdFact."Minimum Contribution" - SavingAcc.Balance;
                end;

                ProdFact.Reset();
                ProdFact.SetRange("Product Category", ProdFact."Product Category"::"Benevolent (BBF)");
                if ProdFact.FindFirst() then begin
                    EBBF := ProdFact."Minimum Contribution";
                end;


                ProdFact.Reset();
                ProdFact.SetRange("Product Category", ProdFact."Product Category"::"BOSA Deposits");
                if ProdFact.FindFirst() then begin
                    EBosaDep := ProdFact."Minimum Contribution";
                end;

                ProdFact.Reset();
                ProdFact.SetRange("Product Category", ProdFact."Product Category"::Risk);
                if ProdFact.FindFirst() then begin
                    ERisk := ProdFact."Minimum Contribution";
                end;

                VBosaDep := EBosaDep - BosaDep;
                VRisk := ERisk - Risk;
                VBBF := EBosaDep - BosaDep;

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
        SNo: Integer;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        ShowTotoDetail: Boolean;
        Amount: decimal;
        SavingAcc: Record "Savings Accounts";
        BBF: Decimal;
        Risk: Decimal;
        CreatedBy: Text;
        Members: Record Members;
        User: Record User;
        BosaDep: Decimal;
        EBosaDep: Decimal;
        ERisk: Decimal;
        EBBF: Decimal;
        VBosaDep: Decimal;
        VRisk: Decimal;
        VBBF: Decimal;
        ProdFact: Record "Product Factory";
        IdentificationType: Text;
        IdentificationNo: Code[100];
        EmployerCode: Code[50];

}
