report 52186394 "Expected BOSA Contributions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Expected BOSA Contributions.rdl';

    dataset
    {

        dataitem("Savings Accounts"; "Savings Accounts")
        {
            DataItemTableView = where("Product Category" = Filter("BOSA Deposits" | Risk | "Benevolent (BBF)"));

            column(ReportForNavId_1; 1)
            {
            }
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
            column(ERisk; ERisk)
            {
            }
            column(EBBF; EBBF)
            {
            }
            column(ERegFee; ERegFee)
            {
            }
            column(EBosaDep; EBosaDep)
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

            dataitem(Members; Members)
            {
                DataItemLink = "No." = field("Member No.");
                column(MemStatus; Status)
                {

                }
                column(Registration_Date; "Registration Date")
                {

                }
                column(Name; Name)
                {

                }
            }

            trigger OnAfterGetRecord()
            begin
                SNo += 1;
                EBBF := 0;
                ERisk := 0;
                EBosaDep := 0;
                CreatedBy := '';

                User.Reset;
                User.SetRange("User Name", Members."Created By");
                if User.Find('-') then begin
                    CreatedBy := User."Full Name";
                end;

                ProdFact.Reset();
                ProdFact.SetRange("Product Category", "Savings Accounts"."Product Category"::"Entrance Fee");
                if ProdFact.FindFirst() then begin
                    ERegFee := ProdFact."Minimum Contribution";
                end;

                ProdFact.Reset();
                ProdFact.SetRange("Product Category", "Savings Accounts"."Product Category"::"Benevolent (BBF)");
                if ProdFact.FindFirst() then begin
                    EBBF := ProdFact."Minimum Contribution";
                end;


                ProdFact.Reset();
                ProdFact.SetRange("Product Category", "Savings Accounts"."Product Category"::"BOSA Deposits");
                if ProdFact.FindFirst() then begin
                    EBosaDep := ProdFact."Minimum Contribution";
                end;

                ProdFact.Reset();
                ProdFact.SetRange("Product Category", "Savings Accounts"."Product Category"::Risk);
                if ProdFact.FindFirst() then begin
                    ERisk := ProdFact."Minimum Contribution";
                end;

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
        ERegFee: Decimal;
        Risk: Decimal;
        CreatedBy: Text;
        SavAcc: Record "Savings Accounts";
        User: Record User;
        BosaDep: Decimal;
        EBosaDep: Decimal;
        ERisk: Decimal;
        EBBF: Decimal;
        VBosaDep: Decimal;
        VRisk: Decimal;
        VBBF: Decimal;
        ProdFact: Record "Product Factory";

}
