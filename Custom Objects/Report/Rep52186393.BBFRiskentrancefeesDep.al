namespace ALProject.ALProject;
using Microsoft.Foundation.Company;

report 52186393 "BBF_Risk_entr fees_Dep Falloff"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/BBF_Risk_Entrance_Summary.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", "Employer Code", "Member Class";
            column(MemberNo; "No.")
            {
            }
            column(PayrollStaffNo; "Payroll/Staff No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Employer_Code; "Employer Name") { }

            column(Primary_Identification_Type; "Primary Identification Type") { }
            Column(Risk; Risk)
            {

            }
            column(EntranceFees; EntranceFees)
            {

            }
            column(BosaDeposits; BosaDeposits)
            {

            }
            column(BBF; BBF)
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
            column(Primary_Identification; "Primary Identification") { }
            column(BOSAProductCode; BOSAProductCode) { }
            column(BOSAProductName; BOSAProductName) { }
            column(BBFProductCode; BBFProductCode) { }
            column(BBFProductName; BOSAProductName) { }
            column(EntranceFeesCode; EntranceFeesCode) { }
            column(EntranceFeesName; EntranceFeesName) { }
            column(ExpectedEntrance; ExpectedEntrance) { }
            column(EntranceArrears; EntranceArrears) { }
            column(BBFContr; BBFContr) { }
            column(BBFExpected; BBFExpected) { }
            column(BBFArrears; BBFArrears) { }
            column(RiskContr; RiskContr) { }
            column(RiskFeesCode; RiskFeesCode) { }
            column(RiskFeesName; RiskFeesName) { }
            column(RiskExpected; RiskExpected) { }
            column(RiskArrears; RiskArrears) { }
            column(ProductName; ProductName) { }
            column(ProductCode; ProductCode) { }
            column(MinimumContribution; MinimumContribution) { }
            column(ExpectedAmount; ExpectedAmount) { }
            column(AmountReceived; AmountReceived) { }
            column(AmountNotReceived; AmountNotReceived) { }
            column(OutstandingBalance; OutstandingBalance) { }

            //Deposit, risk, BBF Fall – off report (No funds received). Mno., Payroll number, Name, employer code, ID number, product code, product name, 
            //expected amount, outstanding balance. A summary report per deposit category (Deposit, BBF, Risk) 
            //showing Number of members, expected amount, amount received, amount not received, total amount

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin

                BosaDeposits := 0;
                BBF := 0;
                EntranceFees := 0;
                Risk := 0;
                ProductCode := ' ';
                ProductName := ' ';
                TodayYear := 0;
                RegistrationYears := 0;
                BBFArrears := 0;
                CurrentYear := ' ';
                BBFExpected := 0;
                RiskExpected := 0;
                EntranceArrears := 0;
                ExpectedEntrance := 0;
                BBFContr := 0;
                RiskContr := 0;


                TodayYear := Date2DMY(Today, 3);
                RegistrationYears := Date2DMY(Members."Registration Date", 3);
                CurrentYear := Format(TodayYear) + '-01-01';
                Evaluate(StartDate, CurrentYear);



                //Productfactory.SETRANGE("Product Category", Productfactory."Product Category"::"Entrance Fee");


                SavingsAccount.reset();
                SavingsAccount.setrange("Member No.", Members."No.");
                if SavingsAccount.FindFirst then begin

                    repeat
                        Productfactory.Get(SavingsAccount."Product Type");
                        case
                            Productfactory."Product Category" of
                            Productfactory."Product Category"::"Entrance Fee":
                                begin
                                    ExpectedEntrance := Productfactory."Minimum Contribution";
                                    Message('Expected Entrance: %1', ExpectedEntrance);
                                end;
                            Productfactory."Product Category"::Risk:
                                begin
                                    RiskContr := Productfactory."Minimum Contribution";
                                    Message('Risk Contribution: %1', RiskContr);
                                end;
                            Productfactory."Product Category"::"Benevolent (BBF)":
                                begin
                                    BBFContr := Productfactory."Minimum Contribution";
                                    Message('BBF Contribution: %1', BBFContr);
                                end;
                        end;
                        SavingsAccount.CalcFields("Balance (LCY)");
                        case
                            SavingsAccount."Product Category" of
                            SavingsAccount."Product Category"::"Benevolent (BBF)":
                                begin
                                    BBF := SavingsAccount."Balance (LCY)";
                                    //BBFProductCode := SavingsAccount."Product Type";
                                    //BBFProductName := Format(SavingsAccount."Product Category");
                                    if RegistrationYears = TodayYear then
                                        BBFExpected := ((Today - Members."Contribution Effective Date") div 30) * BBFContr
                                    else
                                        BBFExpected := (Today - startdate) * BBFContr;
                                    BBFArrears := BBFExpected - SavingsAccount."Balance (LCY)";
                                    //Message('Start Date: %1', startdate);

                                end;
                            SavingsAccount."Product Category"::"Entrance Fee":
                                begin
                                    EntranceFees := SavingsAccount."Balance (LCY)";
                                    //EntranceFeesCode := SavingsAccount."Product Type";
                                    //EntranceFeesName := FORMAT(SavingsAccount."Product Category");
                                    //ExpectedEntrance := SavingsAccount."Monthly Contribution";
                                    EntranceArrears := ExpectedEntrance - SavingsAccount."Balance (LCY)";

                                end;
                            SavingsAccount."Product Category"::Risk:
                                begin
                                    Risk := SavingsAccount.Balance;
                                    //RiskFeesCode := SavingsAccount."Product Type";
                                    //RiskFeesName := FORMAT(SavingsAccount."Product Category");
                                    if RegistrationYears = TodayYear then
                                        RiskExpected := ((Today - Members."Contribution Effective Date") div 30) * RiskContr
                                    else
                                        RiskExpected := (Today - startdate) * RiskContr;
                                    RiskArrears := RiskExpected - SavingsAccount."Balance (LCY)";
                                    //Message('Start Date: %1', startdate);
                                end;
                        end;
                    until SavingsAccount.next = 0;

                end;

                // SavingsAccount.RESET();
                // SavingsAccount.SETRANGE("Member No.", Members."No.");
                // SavingsAccount.SetFilter(SavingsAccount."Product Category", '%1|%2|%3', SavingsAccount."Product Category"::"BOSA Deposits", SavingsAccount."Product Category"::"Benevolent (BBF)", SavingsAccount."Product Category"::Risk);
                // if SavingsAccount.Find('-') then begin
                //     repeat
                //         ProductCode := SavingsAccount."Product Type";
                //         ProductName := Format(SavingsAccount."Product Category");
                //         MinimumContribution := SavingsAccount."Monthly Contribution";
                //         OutstandingBalance := SavingsAccount."Balance (LCY)";
                //         ExpectedAmount := SavingsAccount."Monthly Contribution" * GetMembershipNoofMonths(Members);
                //         SavingsLedgerEntries.RESET;
                //         //SavingsLedgerEntries.SetRange("Customer Posting Group", 'UNALLOCATE');
                //         SavingsLedgerEntries.SetRange("Member No.", Members."No.");
                //         SavingsLedgerEntries.SetRange(Reversed, false);
                //         if SavingsLedgerEntries.Find('-') then begin
                //             repeat
                //                 SavingsLedgerEntries.CalcSums(Amount);
                //                 AmountReceived := SavingsLedgerEntries.Amount;
                //                 AmountNotReceived := ExpectedAmount - AmountReceived;
                //             until SavingsLedgerEntries.Next = 0;
                //         end;
                //     Until SavingsAccount.Next() = 0;
                // end;

                MemberApp.Reset();
                MemberApp.SetRange("Member No.", Members."No.");
                if MemberApp.find('-') then begin
                    EmployerName := MemberApp."Employer Name";
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
    procedure GetMembershipNoofMonths(Members: Record Members): Integer
    var
        MembershipMonths: Integer;
    begin
        MembershipMonths := 0;
        MembershipMonths := Round((Today - Members."Registration Date") DIV 30, 1, '<');
        exit(MembershipMonths);
    end;


    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;

        BBF: decimal;
        Risk:
                                Decimal;
        EntranceFees:
                                decimal;
        BosaDeposits:
                                decimal;
        SavingsAccount:
                                record "Savings Accounts";
        BOSAProductCode: Code[100];
        BOSAProductName: Code[100];
        BBFProductCode: Code[100];
        BBFProductName: Code[100];
        EntranceFeesCode: Code[100];
        EntranceFeesName: Code[100];
        RiskFeesCode: Code[100];
        RiskFeesName: Code[100];
        ProductName: Code[100];
        ProductCode: Code[100];
        MinimumContribution: Decimal;
        ExpectedAmount: Decimal;
        SavingsLedgerEntries: Record "Savings Ledger Entry";
        AmountReceived: Decimal;
        AmountNotReceived: Decimal;
        OutstandingBalance: Decimal;
        TodayYear: Integer;
        RegistrationYears: Integer;
        Productfactory: record "Product Factory";
        BBFArrears: Decimal;
        CurrentYear: Text;
        startdate: Date;
        RiskArrears: Decimal;
        BBFExpected: Decimal;
        RiskExpected: Decimal;
        EntranceArrears: Decimal;
        ExpectedEntrance: Decimal;
        MemberApp: Record "Member Application";
        EmployerName: Code[100];
        BBFContr: Decimal;
        RiskContr: Decimal;
}
