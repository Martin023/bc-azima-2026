#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185931 "Summary Unlocated A/C"
{
    DefaultLayout = RDLC;
    Caption = 'Unallocated Fund Report';
    RDLCLayout = './bc-kenpipe-2024/Layout/Summary Unlocated AC.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Savings Accounts"; "Savings Accounts")
        {
            RequestFilterFields = "Member No.", "Employer Code", "Balance (LCY)";
            DataItemTableView = where("Product Category" = const("Unallocated Fund"), "Balance (LCY)" = filter(> 0));
            column(UnallocatedAcc; "No.") { }
            column(Mem_No; "Member No.") { }
            column(MemName; Name) { }
            column(Balance__LCY_; "Balance (LCY)") { }
            column(BBFContr; BBFContr) { }
            column(BBFBal; BBFBal) { }
            column(ExpectedBBF; ExpectedBBF) { }
            column(PaidBBF; PaidBBF) { }
            column(BBFArrears; BBFArrears) { }
            column(RiskContr; RiskContr) { }
            COLUMN(ExpectedRiskAmount; ExpectedRiskAmount) { }
            column(PaidRiskAmount; PaidRiskAmount) { }
            column(RiskBal; RiskBal) { }
            column(RiskArrears; RiskArrears) { }
            column(UnallocatedAmount; UnallocatedAmount) { }
            column(LoanAmountinArreas; LoanAmountinArreas) { }
            column(TotalArrears; TotalArrears) { }
            column(NetAllocatedAmt; NetAllocatedAmt) { }
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
                StartDate: Date;
                EndDate: Date;
            begin
                LoanAmountinArreas := 0;
                UnallocatedAmount := 0;
                ExpectedRiskAmount := 0;
                PaidRiskAmount := 0;
                ExpectedBBF := 0;
                PaidBBF := 0;
                BBFBal := 0;
                TodayYear := 0;
                RegistrationYears := 0;
                CurrentYear := ' ';
                BBFArrears := 0;
                BBFContr := 0;
                RiskContr := 0;
                RiskArrears := 0;
                GlobalMonthlyContr := 0;
                UnallocatedAcc := '';
                "Savings Accounts".CalcFields("Balance (LCY)");
                if MemberFact.Get("Savings Accounts"."Member No.")
                then begin
                    MemberFact.CalcFields(BBF, "BBF Contribution", Risk, "Risk Contribution");
                    BBFContr := MemberFact."BBF Contribution";
                    BBFBal := MemberFact.BBF;
                    RiskContr := MemberFact."Risk Contribution";
                    RiskBal := MemberFact.Risk;

                end;
                // SavingsAccounts.RESET;
                //     SavingsAccounts.SetFilter("Member No.", "Savings Accounts"."Member No.");
                //     SavingsAccounts.SetFilter("Product Category", '%1|%2|%3', SavingsAccounts."Product Category"::Risk, SavingsAccounts."Product Category"::"Benevolent (BBF)", SavingsAccounts."Product Category"::"Unallocated Fund");
                //     if SavingsAccounts.Find('-') then begin
                //         repeat
                //             if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::Risk then begin
                //                 GetAll(SavingsAccounts, RiskContr, RiskArrears, ExpectedRiskAmount, PaidRiskAmount, RiskBal);
                //             end;
                //             if SavingsAccounts."Product Category" = SavingsAccounts."Product Category"::"Benevolent (BBF)" then begin
                //                 GetAll(SavingsAccounts, BBFContr, BBFArrears, ExpectedBBF, PaidBBF, BBFBal);
                //             end;
                //         until SavingsAccounts.Next = 0;
                //     end;
                Month := Date2DMY(Today, 2);
                Evaluate(MonthFormula, (Format(Month) + 'M'));
                ExpectedBBF := 150 * Month;//Temporary solution to be corrected
                ExpectedRiskAmount := 400 * Month; //Temporary solution to be corrected
                BBFArrears := RegnProcess.CalculateSavingArrears("Savings Accounts"."Member No.", '4', MonthFormula, Today);
                RiskArrears := RegnProcess.CalculateSavingArrears("Savings Accounts"."Member No.", '5', MonthFormula, Today);

                Loans.Reset();
                Loans.SetRange("Member No.", "Savings Accounts"."Member No.");
                Loans.SetFilter("Total Balance", '>%1', 0);
                Loans.SetFilter("Amount In Arreas SACCO", '>%1', 0);
                loans.SetLoadFields("Amount In Arreas SACCO");
                Loans.SetAutoCalcFields("Amount In Arreas SACCO");
                if Loans.FindSet then begin
                    repeat
                        LoanAmountinArreas += Loans."Amount In Arreas SACCO";
                    until Loans.Next = 0;
                end;

                TotalArrears := LoanAmountinArreas + BBFArrears + RiskArrears;
                NetAllocatedAmt := "Savings Accounts"."Balance (LCY)" - TotalArrears;

            end;
        }
    }



    requestpage
    {
        SaveValues = true;

        layout
        {
            // area(Content)
            // {
            //     group(Balances)
            //     {
            //         field(Balance; UnallocatedAmount)
            //         {
            //             Caption = 'Unallocated Amount';
            //             ApplicationArea = All;
            //         }
            //     }
            // }
        }

        actions
        {
        }
    }

    labels
    {
    }
    // procedure GetMembershipNoofMonths(Members: Record Members): Integer
    // var
    //     MembershipMonths: Integer;
    // begin
    //     MembershipMonths := 0;
    //     MembershipMonths := Round((Today - Members."Registration Date") DIV 30, 1, '<');
    //     exit(MembershipMonths);
    // end;

    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    // local procedure GetDifferenceInMonths(StartDate: Date; EndDate: date): Integer
    // var
    //     Counter: Integer;
    // begin
    //     Counter := 1;
    //     repeat
    //         StartDate := CalcDate('1M', StartDate);
    //         counter += 1;
    //     until StartDate = EndDate;
    //     exit(Counter);
    // end;

    // local procedure GetAll(SavingsAccounts: Record "Savings Accounts"; var MonthlyContr: Decimal; var Arrears: Decimal; var ExpectedAmounts: Decimal; var ReceivedAmt: Decimal; var ActualAccBal: Decimal)
    // begin
    //     StartDate := 0D;
    //     EndDate := 0D;

    //     StartDate := Members."Contribution Effective Date";
    //     if StartDate = 0D then
    //         StartDate := Members."Registration Date";
    //     if StartDate = 0D then
    //         StartDate := CalcDate('-CY', Today);

    //     if Date2DMY(StartDate, 3) = Date2DMY(Today, 3) then
    //         StartDate := CalcDate('-CY', StartDate)
    //     else
    //         StartDate := CalcDate('-CY', Today);
    //     EndDate := CalcDate('-1M-CM', Today);

    //     ProductSetup.GET(SavIngsAccounts."Product Type");
    //     if ProductSetup."Minimum Contribution" <> 0 then
    //         MonthlyContr := ProductSetup."Minimum Contribution"
    //     else
    //         MonthlyContr := SavingsAccounts."Monthly Contribution";

    //     SavingsLedgerEntries.Reset();
    //     SavingsLedgerEntries.SetRange("Member No.", SavingsAccounts."Member No.");
    //     SavingsLedgerEntries.SetRange("Posting Date", CalcDate('-CY', Today), Today);
    //     SavingsLedgerEntries.SetRange("Customer No.", SavingsAccounts."No.");
    //     if SavingsLedgerEntries.Find('-') then begin
    //         SavingsLedgerEntries.CalcSums(Amount);
    //         ReceivedAmt := SavingsLedgerEntries.Amount * -1;
    //     end;

    //     if Date2DMY(StartDate, 3) = Date2DMY(EndDate, 3) then begin
    //         if Date2DMY(StartDate, 2) <> Date2DMY(EndDate, 2) then begin
    //             ExpectedAmounts := (GetDifferenceInMonths(StartDate, EndDate)) * MonthlyContr;
    //             Arrears := ExpectedAmounts - ReceivedAmt
    //         end
    //         else
    //             Arrears := 0;
    //     end else begin
    //         Arrears := 0;
    //     end;
    //     SavingsAccounts.CalcFields("Balance (LCY)");
    //     ActualAccBal := SavingsAccounts."Balance (LCY)";
    // end;

    var
        company: Record "Company Information";
        cust: Record Customer;
        CustName: Text;
        Loans: Record Loans;
        LoanAmountinArreas: Decimal;
        SavingsLedgerEntries: Record "Savings Ledger Entry";
        UnallocatedAmount: Decimal;
        SavingsAccounts: Record "Savings Accounts";
        //Members: Record Members;
        ExpectedRiskAmount: Decimal;
        PaidRiskAmount: Decimal;
        ExpectedBBF: Decimal;
        PaidBBF: Decimal;
        ProductSetup: Record "Product Factory";
        //RiskVariance: Decimal;
        //BBFVariance: Decimal;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        LoanNo: Code[20];
        LoanType: Code[20];
        IndividualLoanArears: Decimal;
        RiskContr: Decimal;
        BBFArrears: Decimal;
        BBFContr: Decimal;
        RiskArrears: Decimal;
        TodayYear: Integer;
        RegistrationYears: Integer;
        CurrentYear: Text;
        StartDate: Date;
        EndDate: Date;
        AsAt: Date;
        BBFBal: Decimal;
        RiskBal: Decimal;
        GlobalMonthlyContr: Decimal;
        UnallocatedAcc: Code[50];
        TotalArrears: Decimal;
        NetAllocatedAmt: Decimal;
        RegnProcess: Codeunit "Registration Process";
        Month: Integer;
        MonthFormula: DateFormula;
        MemberFact: Record "Member FactBox";
}
