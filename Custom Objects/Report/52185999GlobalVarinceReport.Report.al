// #pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185999 "Global Variance Report"
{
    ApplicationArea = all;
    DefaultLayout = RDLC;
    Caption = 'Monthly Global Deposit Variance Report';
    RDLCLayout = './bc-azima-2026/Layout/Global Variance Report.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Members"; "Members")
        {
            //CalcFields = "Balance (LCY)";
            // DataItemTableView = where("Product Category" = filter("BOSA Deposits" | "Benevolent (BBF)" | "Risk" | "Share Capital"));
            RequestFilterFields = "No.", "Employer Code";
            // column(AccNo; "No.") { }
            column(Member_No_; Members."No.") { }
            column(Name; Name) { }
            column(PayrollNo; Members."Payroll/Staff No.") { }
            column(Member_Age; Members.Age) { }
            column(StartDate; StartDate) { }
            column(EndDate; EndDate) { }
            column(No_Of_Months; PeriodMonths) { }

            column(Employer_Code; Members."Employer Code") { }
            column(Employer_Name; members."Employer Name") { }
            column(Member_Status; Members.Status) { }
            column(Member_Substatus; Members.Subflag) { }

            column(BBFAccno; BBFAccno) { }
            column(ExpectedMonthlyBBF; ExpectedMonthlyBBF) { }
            column(ExpectedBBFInPeriod; ExpectedBBFInPeriod) { }
            column(ActualReceivedBBF; ActualReceivedBBF) { }

            column(BBFVariance; BBFVariance) { }
            column(BBFArrears; BBFArrears) { }
            column(BBFBalance; BBFBalance) { }


            // Risk
            column(RiskAcc; RiskAcc) { }
            column(ExpectedMonthlyRisk; ExpectedMonthlyRisk) { }
            column(ExpectedRiskInPeriod; ExpectedRiskInPeriod) { }
            column(ActualReceivedRisk; ActualReceivedRisk) { }
            column(RiskVariance; RiskVariance) { }
            column(RiskArrears; RiskArrears) { }
            column(RiskBalance; RiskBalance) { }


            // DEPOSISTS
            column(DepositAcc; DepositAcc) { }
            column(Expec_MonthyDeposit_Prorata; ExpecedMonthyDEPOSIT) { }
            column(Expec_DepositForPeriod; ExpectedDEPOSIT) { }

            column(ReceivedDeposit; ReceivedDEPOSIT) { }
            column(DepositVariance; DepositVariance) { }
            column(DepositBalance; DepositBalance) { }

            //sHARE
            column(ShareCap_Acc; ShareAcc) { }
            column(ExpectedShareCap_; ExpectedShares) { }
            column(ReceivedShareCap_; ReceivedShares) { }
            column(ShareCap_Variance; Sharesvariance) { }
            column(ShareCap_Balance; ShareCapBalance) { }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                PeriodMonths := 0;
                BalBetweenPeriod := 0;
                BalAsAtStart := 0;
                BalAsAtEnd := 0;
                TODAYYear := 0;
                // Intializations
                ShareCapVariance := 0;
                ExpecedMonthyDEPOSIT := 0;
                ActualReceivedRisk := 0;
                ExpectedRiskInPeriod := 0;
                ExpectedMonthlyBBF := 0;
                ExpectedBBFInPeriod := 0;
                BBFArrears := 0;
                ActualReceivedBBF := 0;
                BBFBalance := 0;
                BBFVariance := 0;
                ExpectedShares := 0;
                ReceivedShares := 0;
                Sharesvariance := 0;
                DepositVariance := 0;
                DepositBalance := 0;
                ReceivedDEPOSIT := 0;
                ExpectedDEPOSIT := 0;
                RiskVariance := 0;
                RiskBalance := 0;
                ExpectedMonthlyRisk := 0;
                ExpectedAmount := 0;
                Variance := 0;
                ShareCapBalance := 0;


                TODAYYear := Date2DMY(Today, 3);

                Savingsaccounts.Reset();
                Savingsaccounts.SetRange("Member No.", Members."No.");
                Savingsaccounts.setfilter("Product Category", '%1|%2|%3|%4', Savingsaccounts."Product Category"::"BOSA Deposits", Savingsaccounts."Product Category"::"Benevolent (BBF)", Savingsaccounts."Product Category"::"Risk", Savingsaccounts."Product Category"::"Share Capital");
                Savingsaccounts.SetLoadFields("No.", "Product Category", "Balance (LCY)", "Monthly Contribution");
                //SavingsAccounts.SetFilter("Date Filter");
                if Savingsaccounts.FindSet() then begin
                    repeat
                        BalAsAtStart := 0;
                        BalAsAtEnd := 0;
                        BalBetweenPeriod := 0;
                        PeriodMonths := 0;

                        StartDate := CalcDate('<-CM>', EndDate);

                        "SavingsAccounts".CalcFields("Balance (LCY)");

                        BalBetweenPeriod := GetAccBalanceAtstart(SavingsAccounts."No.", StartDate, EndDate);

                        if Members."Employer Name" = '' then begin
                            if Employers.get(Members."Employer Code") then
                                Members."Employer Name" := Employers.Name;
                        end;
                        if Members.Age = 0 then
                            if Members."Date of Birth" <> 0D then begin
                                Members.Age := ROUND(((Today - Members."Date of Birth") / 365.2364), 1, '<')
                            end;
                        // end;
                        // if members.Status = Members.status::Closed then begin
                        //     if members."Closure Date" <> 0D then begin
                        //         if Members."Closure Date" in [StartDate .. EndDate] then
                        //             PeriodMonths := Round((Members."Closure Date" - StartDate) / 30, 1, '<');
                        //     end;
                        // end;

                        /// Expected BBF AND RISK
                        if ("SavingsAccounts"."Product Category" = "SavingsAccounts"."Product Category"::"Benevolent (BBF)") then begin
                            ExpectedMonthlyBBF := ProductFactory.GetMonthlyContrib(SavingsAccounts."Product Type", EndDate);
                            ExpectedBBFInPeriod := ProductFactory.GetMonthlyContrib(SavingsAccounts."Product Type", EndDate);
                            BBFArrears := ProductFactory.GetRiskBBfArrears("SavingsAccounts"."No.");
                            BBFAccno := "SavingsAccounts"."No.";

                            if (Members.Status = Members.status::Deceased) or (Members.Status = Members.status::Closed) then begin
                                ExpectedMonthlyBBF := 0;
                                ExpectedBBFInPeriod := 0;
                                //BBFArrears := 0;
                            end;
                            ActualReceivedBBF := BalBetweenPeriod;
                            BBFBalance := "SavingsAccounts"."Balance (LCY)";
                            BBFVariance := ExpectedBBFInPeriod - ActualReceivedBBF;

                        end;
                        if ("SavingsAccounts"."Product Category" = "SavingsAccounts"."Product Category"::Risk) then begin
                            ExpectedMonthlyRisk := ProductFactory.GetMonthlyContrib(SavingsAccounts."Product Type", EndDate);
                            ExpectedRiskInPeriod := ProductFactory.GetMonthlyContrib(SavingsAccounts."Product Type", EndDate);
                            //RiskArrears := RegnProcess.CalculateSavingArrears(Rec."Member No.", '5', PeriodRange, Today))
                            RiskArrears := ProductFactory.GetRiskBBfArrears("SavingsAccounts"."No.");


                            RiskAcc := "SavingsAccounts"."No.";
                            ActualReceivedRisk := BalBetweenPeriod;
                            RiskBalance := "SavingsAccounts"."Balance (LCY)";
                            RiskVariance := ExpectedRiskInPeriod - ActualReceivedRisk;
                            if (Members.Status = Members.status::Deceased) or (Members.Status = Members.status::Closed) then begin
                                ExpectedMonthlyRisk := 0;
                                ExpectedRiskInPeriod := 0;
                                //RiskArrears := 0;
                                RiskVariance := 0;
                            end;
                        end;

                        if "SavingsAccounts"."Product Category" = "SavingsAccounts"."Product Category"::"BOSA Deposits" THEN begin
                            Prorata := CustomCuesCodeunit.Prorata(Members."No.", '1');
                            if Prorata = 0 then
                                Prorata := "SavingsAccounts"."Monthly Contribution";
                            if Prorata = 0 then begin
                                if ProductFactory.get(SavingsAccounts."Product Type") then
                                    Prorata := ProductFactory."Minimum Contribution";
                            end;

                            ExpecedMonthyDEPOSIT := Prorata;
                            ExpectedDEPOSIT := Prorata;

                            DepositAcc := "SavingsAccounts"."No.";
                            ReceivedDEPOSIT := BalBetweenPeriod;
                            DepositBalance := "SavingsAccounts"."Balance (LCY)";
                            DepositVariance := ExpectedDEPOSIT - ReceivedDEPOSIT;
                            if (Members.Status = Members.status::Deceased) or (Members.Status = Members.status::Closed) then begin
                                ExpectedMonthyDEPOSIT := 0;
                                ExpectedDEPOSIT := 0;
                                DepositVariance := 0;
                            end;
                        end;


                        if "SavingsAccounts"."Product Category" = "SavingsAccounts"."Product Category"::"Share Capital" then begin
                            ShareAcc := "SavingsAccounts"."No.";
                            if MemberClass.get(Members."Member Class") then
                                ExpectedShares := MemberClass."Share Capital"
                            else
                                ExpectedShares := 30000;
                            // BalBetweenPeriod := "SavingsAccounts"."Balance (LCY)";
                            ReceivedShares := "SavingsAccounts"."Balance (LCY)";
                            Sharesvariance := ExpectedShares - ReceivedShares;
                            // if (Members.Status = Members.status::Deceased) or (Members.Status = Members.status::Closed) and (ReceivedShares <> 0) then begin
                            //     ExpectedShares := 0;
                            //     Sharesvariance := 0;
                            // end;
                            ShareCapBalance := "SavingsAccounts"."Balance (LCY)";

                            if ((Members.Status = Members.status::Deceased) or (Members.Status = Members.status::Closed)) and (ShareCapBalance = 0) then begin
                                ExpectedShares := 0;
                                Sharesvariance := 0;
                            end;
                        end;
                    until SavingsAccounts.next = 0;
                end;

            end;
            //Global Variance report for BOSA deposits, risk, BBF, share capital, 
            //(Payroll number, Mno, Expected Amount, Actual received, Variance). 
            //The user should be able to generate the desired report period e.g., monthly 
            // trigger OnPreDataItem()
            // begin
            //     CompanyInformation.Get;
            //     //  CompanyInformation.CalcFields(Picture);
            // end;

        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                // field(StartDate; StartDate)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'Start Date';
                // }
                field(EndDate; EndDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'As At';
                }
            }
        }
    }
    // procedure GetMembershipNoofMonths(Members: Record Members): Integer
    // var
    //     MembershipMonths: Integer;
    // begin
    //     MembershipMonths := 0;

    //     Members.Reset();
    //     Members.SetRange("No.", "SavingsAccounts"."Member No.");
    //     if Members.find('-') then
    //         if Members."Registration Date" <> 0D then
    //             MembershipMonths := Round((Today - Members."Registration Date") DIV 30, 1, '<');
    //     exit(MembershipMonths);
    // end;

    trigger OnPreReport()
    begin
        //if StartDate = 0D then Error('Kindly set the start date');
        //if EndDate = 0D then Error('Kindly set the end date');

        // if StartDate = 0D then
        //     StartDate := 20000101D;

        if EndDate = 0D then
            Enddate := Today;

        // if CompanyInformation.Get then
        //     CompanyInformation.CalcFields(CompanyInformation.Picture);
        // CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        // CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        // CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        // Members: Record Members;
        PayrollNo: Code[50];
        MemberClass: Record "Member Classes";
        DefaultShareCapital: Decimal;
        ShareCapVariance: Decimal;
        //CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        PeriodMonths: Integer;
        StartDate: Date;
        EndDate: Date;
        BalAsAtEnd: Decimal;
        BalAsAtStart: Decimal;
        BalBetweenPeriod: Decimal;
        StartDateFilter: Text;
        EndDateFilter: Text;
        TODAYYear: Integer;
        Prorata: Decimal;
        CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
        Variance: Decimal;
        EmployerName: Text;
        ExpectedAmount: Decimal;
        ProductFactory: record "Product Factory";
        Employers: record Customer;
        ExpectedMonthlyBBF: Decimal;
        ExpectedBBFInPeriod: Decimal;
        BBFArrears: Decimal;
        ActualReceivedBBF: Decimal;
        BBFBalance: Decimal;
        BBFVariance: Decimal;
        ExpectedMonthlyRisk: Decimal;
        ExpectedRiskInPeriod: Decimal;
        RiskArrears: Decimal;
        ActualReceivedRisk: Decimal;
        RiskBalance: Decimal;
        RiskVariance: Decimal;
        ExpecedMonthyDEPOSIT: Decimal;
        ExpectedDEPOSIT: Decimal;
        ExpectedMonthyDEPOSIT: Decimal;
        ReceivedDEPOSIT: Decimal;
        DepositBalance: Decimal;
        DepositVariance: Decimal;
        ExpectedShares: Decimal;
        ReceivedShares: Decimal;
        Sharesvariance: Decimal;
        ShareAcc: code[50];
        BBFAccno: code[50];
        RiskAcc: code[50];
        DepositAcc: code[50];
        SavingsAccounts: record "Savings Accounts";
        RegnProcess: Codeunit "Registration Process";
        SavingsAccII: Record "Savings Accounts";
        ShareCapBalance: Decimal;

    procedure GetAccBalanceAtstart(AcctNo: code[50]; StartDate: Date; EndDate: Date): Decimal;
    begin
        // if StartDate = 0D then
        //     StartDate := 20000101D;
        if EndDate = 0D then
            EndDate := Today;
        StartDate := CalcDate('<-CM>', EndDate);

        // StartDateFilter := '..' + Format(StartDate);
        SavingsAccII.Reset();
        SavingsAccII.SetRange("No.", AcctNo);
        SavingsAccII.SetFilter("Date Filter", '%1..%2', StartDate, EndDate);
        SavingsAccII.SetLoadFields("Balance (LCY)");
        if SavingsAccII.FindFirst() then begin
            SavingsAccII.CalcFields("Balance (LCY)");
            exit(SavingsAccII."Balance (LCY)");
        end
        else
            exit(0);

    end;

    // procedure GetAccBalanceAtEnd(AcctNo: code[50]; EndDate: Date): Decimal;
    // begin
    //     if EndDate = 0D then
    //         EndDate := Today;

    //     EndDateFilter := '..' + Format(EndDate);
    //     SavingsAccII.Reset();
    //     SavingsAccII.SetRange("No.", AcctNo);
    //     SavingsAccII.SetFilter("Date Filter", EndDateFilter);
    //     SavingsAccII.CalcFields("Balance (LCY)");
    //     exit(SavingsAccII."Balance (LCY)");
    // end;
}

















// Report 52185999 "Update STO Income Type"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './bc-azima-2026/Layout/Update STO Income Type.rdl';

//     dataset
//     {
//         dataitem("Standing Order Header"; "Standing Order Header")
//         {
//             RequestFilterFields = "Income Type", Status;
//             column(ReportForNavId_1; 1)
//             {
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 if Members.Get("Standing Order Header"."Member No.") then begin
//                     if Members."Employer Code" = '99' then CurrReport.Skip;
//                     "Standing Order Header"."Income Type" := "Standing Order Header"."income type"::Salary;
//                     "Standing Order Header".Modify;
//                 end;
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     var
//         Members: Record "Members";
// }

