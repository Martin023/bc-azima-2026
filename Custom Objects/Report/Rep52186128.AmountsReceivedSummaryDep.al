namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52186128 "Amounts Received Summary - Dep"
{
    ApplicationArea = All;
    Caption = 'Amounts Received Summary - Dep';
    DefaultLayout = RDLC;
    RDLClayout = './bc-azima-2026/Layout/Amounts Received Summary - Dep.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", "Employer Code", "Member Class", Status, Subflag;
            column(MembersNo; "No.") { }
            column(Status; Status) { }
            column(Subflag; Subflag) { }
            column(ActualExpectedAmt; ActualExpectedAmt) { }
            column(StartDate; StartDate) { }
            column(EndDate; EndDate) { }
            column(CurrentMonth; CurrentMonth) { }
            column(Month; Month) { }
            column(Year; Year) { }
            column(BOSAMonthyContribution; BOSAMonthyContribution) { }
            column(SharesMonthyContribution; SharesMonthyContribution) { }
            column(BBFMonthyContribution; BBFMonthyContribution) { }
            column(RiskMonthyContribution; RiskMonthyContribution) { }
            column(RiskExpectedAmount; RiskExpectedAmount) { }
            column(BBFExpectedAmount; BBFExpectedAmount) { }
            column(BOSAExpectedAmount; BOSAExpectedAmount) { }
            column(SharesExpectedAmount; SharesExpectedAmount) { }
            column(BOSACount; BOSACount) { }
            column(RiskCount; RiskCount) { }
            column(BBFCount; BBFCount) { }
            column(SharesCount; SharesCount) { }
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
            dataitem("Savings Accounts"; "Savings Accounts")
            {
                RequestFilterFields = "Member No.";
                DataItemLink = "Member No." = field("No.");
                DataItemTableView = where("Product Category" = filter("BOSA Deposits" | "Risk" | "Benevolent (BBF)" | "Share Capital"));
                column(No; "No.") { }
                column(MemberNo; "Member No.") { }
                column(Product_Category; "Product Category") { }
                column(Description; Description) { }
                column(MonthyContribution; MonthyContribution) { }
                column(AmountReceived; AmountReceived) { }
                column(ExpectedAmount; ExpectedAmount) { }
                column(RiskAccounts; RiskAccounts) { }
                column(BBFAccounts; BBFAccounts) { }
                column(BOSAAccounts; BOSAAccounts) { }
                column(ShareCapitalAccounts; ShareCapitalAccounts) { }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    Description := ' ';
                    AmountReceived := 0;
                    MonthyContribution := 0;
                    ExpectedAmount := 0;
                    CurrentMonth := 0;
                    NoOfMembers := 0;
                    Month := ' ';
                    Year := 0;
                    RiskAccounts := 0;
                    BBFAccounts := 0;
                    BOSAAccounts := 0;
                    ShareCapitalAccounts := 0;
                    BOSAMonthyContribution := 0;
                    SharesMonthyContribution := 0;
                    BBFMonthyContribution := 0;
                    RiskMonthyContribution := 0;
                    RiskExpectedAmount := 0;
                    BBFExpectedAmount := 0;
                    BOSAExpectedAmount := 0;
                    SharesExpectedAmount := 0;
                    BOSACount := 0;
                    RiskCount := 0;
                    BBFCount := 0;
                    SharesCount := 0;


                    Year := Date2DMY(EndDate, 3);
                    CurrentMonth := Date2DMY(EndDate, 2);
                    Month := GlobalFunctions.FormatDateMonth(CurrentMonth);
                    Message('Month: %1', Month);

                    //NoOfMembers := Members.Count;

                    ProductSetup.RESET;
                    ProductSetup.SetFilter("Product Category", '%1|%2|%3|%4', ProductSetup."Product Category"::"Risk", ProductSetup."Product Category"::"Benevolent (BBF)", ProductSetup."Product Category"::"BOSA Deposits", ProductSetup."Product Category"::"Share Capital");
                    if ProductSetup.FindSet() then begin
                        RiskCount := "Savings Accounts".COUNT;
                        if "Savings Accounts"."Product Category" = "Savings Accounts"."Product Category"::Risk then begin
                            MonthyContribution := "Savings Accounts"."Monthly Contribution";
                            if MonthyContribution = 0 then
                                if ProductSetup."Product Category" = ProductSetup."Product Category"::Risk then begin
                                    RiskMonthyContribution := ProductSetup."Minimum Contribution";
                                end;
                            RiskExpectedAmount := RiskMonthyContribution * NoOfMembers;
                        end;

                        if "Savings Accounts"."Product Category" = "Savings Accounts"."Product Category"::"Benevolent (BBF)" then begin
                            BBFCount := "Savings Accounts".Count;
                            MonthyContribution := "Savings Accounts"."Monthly Contribution";
                            if MonthyContribution = 0 then
                                if ProductSetup."Product Category" = ProductSetup."Product Category"::"Benevolent (BBF)" then begin
                                    BBFMonthyContribution := ProductSetup."Minimum Contribution";
                                end;
                            BBFExpectedAmount := BBFMonthyContribution * NoOfMembers;
                        end;

                        if "Savings Accounts"."Product Category" = "Savings Accounts"."Product Category"::"Share Capital" then begin
                            SharesCount := "Savings Accounts".COUNT;
                            MonthyContribution := "Savings Accounts"."Monthly Contribution";
                            if MonthyContribution = 0 then
                                if ProductSetup."Product Category" = ProductSetup."Product Category"::"Share Capital" then begin
                                    SharesMonthyContribution := ProductSetup."Minimum Contribution";
                                end;
                            SharesExpectedAmount := SharesMonthyContribution * NoOfMembers;
                        end;

                        if "Savings Accounts"."Product Category" = "Savings Accounts"."Product Category"::"BOSA Deposits" then begin
                            BOSACount := "Savings Accounts".COUNT;
                            MonthyContribution := "Savings Accounts"."Monthly Contribution";
                            if MonthyContribution = 0 then
                                if ProductSetup."Product Category" = ProductSetup."Product Category"::"BOSA Deposits" then begin
                                    BOSAMonthyContribution := ProductSetup."Minimum Contribution";
                                end;
                            BOSAExpectedAmount := BOSAMonthyContribution * NoOfMembers;
                        end;
                    end;

                    SavingsLedgerEntry.Reset;
                    SavingsLedgerEntry.SetRange("Customer No.", "Savings Accounts"."No.");
                    SavingsLedgerEntry.SetRange("Posting Date", CalcDate('-CM', Today), Today);
                    if SavingsLedgerEntry.Find('-') then begin
                        repeat
                            if "Savings Accounts"."Product Category" = "Savings Accounts"."Product Category"::Risk then begin
                                SavingsLedgerEntry.SetRange("Customer No.", "Savings Accounts"."No.");
                                SavingsLedgerEntry.CalcSums("Amount (LCY)");
                                AmountReceived := SavingsLedgerEntry."Amount (LCY)" * -1;
                                if AmountReceived >= MonthyContribution then begin
                                    Description := 'RECEIVED';
                                end
                                else if AmountReceived < MonthyContribution then begin
                                    Description := 'NOT RECEIVED';
                                end;
                            end;

                            if "Savings Accounts"."Product Category" = "Savings Accounts"."Product Category"::"Benevolent (BBF)" then begin
                                SavingsLedgerEntry.SetRange("Customer No.", "Savings Accounts"."No.");
                                SavingsLedgerEntry.CalcSums("Amount (LCY)");
                                AmountReceived := SavingsLedgerEntry."Amount (LCY)" * -1;
                                if AmountReceived < MonthyContribution then begin
                                    Description := 'NOT RECEIVED';
                                end
                                else if AmountReceived >= MonthyContribution then begin
                                    Description := 'RECEIVED';
                                end;
                            end;

                            if "Savings Accounts"."Product Category" = "Savings Accounts"."Product Category"::"BOSA Deposits" then begin
                                SavingsLedgerEntry.SetRange("Customer No.", "Savings Accounts"."No.");
                                SavingsLedgerEntry.CalcSums("Amount (LCY)");
                                AmountReceived := SavingsLedgerEntry."Amount (LCY)" * -1;
                                if AmountReceived < MonthyContribution then begin
                                    Description := 'NOT RECEIVED';
                                end
                                else if AmountReceived >= MonthyContribution then begin
                                    Description := 'RECEIVED';
                                end;
                            end;

                            if "Savings Accounts"."Product Category" = "Savings Accounts"."Product Category"::"Share Capital" then begin
                                SavingsLedgerEntry.SetRange("Customer No.", "Savings Accounts"."No.");
                                SavingsLedgerEntry.CalcSums("Amount (LCY)");
                                AmountReceived := SavingsLedgerEntry."Amount (LCY)" * -1;
                                if AmountReceived < MonthyContribution then begin
                                    Description := 'NOT RECEIVED';
                                end
                                else if AmountReceived >= MonthyContribution then begin
                                    Description := 'RECEIVED';
                                end;
                            end;
                        until SavingsLedgerEntry.Next = 0;
                    end
                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;

            begin
                AmountReceived := 0;
                MonthyContribution := 0;
                NoOfMembers := 0;
                ActualExpectedAmt := 0;


                NoOfMembers := Members.Count;
                //Message('No of Members: %1', NoOfMembers);

                ProductSetup.RESET;
                ProductSetup.SetFilter("Product Category", '%1|%2|%3', ProductSetup."Product Category"::"Risk", ProductSetup."Product Category"::"Benevolent (BBF)", ProductSetup."Product Category"::"BOSA Deposits");
                if ProductSetup.FindSet() then begin
                    MonthyContribution := ProductSetup."Minimum Contribution";
                end;

                // SavingsLedgerEntry.Reset();
                // SavingsLedgerEntry.SetRange("Customer No.", SavingsAccounts."No.");
                // SavingsLedgerEntry.SetFilter("Customer Posting Group", 'RISK', 'DEPOSIT', 'BBF');
                // SavingsLedgerEntry.SetRange("Reversed", FALSE);
                // SavingsLedgerEntry.SetCurrentKey("Posting Date");
                // SavingsLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                // if SavingsLedgerEntry.Find('-') then begin
                //     SavingsLedgerEntry.CalcSums("Amount (LCY)");
                //     AmountReceived := SavingsLedgerEntry."Amount (LCY)" * -1;
                // end;


            end;
            //}
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
                    field(StartDate; StartDate) { }
                    field(EndDate; EndDate) { }
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

    local procedure GetBOSADepositsAnalysis(SavingsAccountsTable: Record "Savings Accounts"; Var MonthlyContribution: Decimal; Var ExpectedAmount: Decimal; Var AmountReceived: Decimal; Var NoOfCases: Integer);
    begin
        NoOfCases := 0;
        NoOfCases := Members.Count;

        ProductSetup.RESET;
        ProductSetup.SETRANGE("Product Category", SavingsAccountsTable."Product Category");
        if ProductSetup.Find('-') then begin
            if ProductSetup."Minimum Contribution" <> 0 then
                MonthlyContribution := ProductSetup."Minimum Contribution"
            else
                MonthlyContribution := SavingsAccountsTable."Monthly Contribution";
            ExpectedAmount := MonthlyContribution * NoOfCases;
        end;
        //ProductSetup.GET(SavingsAccountsTable."Product Type");
    end;

    local procedure FormatMonth(Var MonthNo: Integer; MonthText: Text[250]);
    begin
        case MonthNo of
            1:
                Month := 'January';
            2:
                Month := 'February';
            3:
                Month := 'March';
            4:
                Month := 'April';
            5:
                Month := 'May';
            6:
                Month := 'June';
            7:
                Month := 'July';
            8:
                Month := 'August';
            9:
                Month := 'September';
            10:
                Month := 'October';
            11:
                Month := 'November';
            12:
                Month := 'December';
        end;
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        StartDate: Date;
        EndDate: Date;
        AmountReceived: Decimal;
        MonthyContribution: Decimal;
        ProductSetup: Record "Product Factory";
        Description: Text;
        NoOfMembers: Integer;
        ActualExpectedAmt: Decimal;
        ExpectedAmount: Decimal;
        CurrentMonth: Integer;
        Month: Text;
        Year: Integer;
        GlobalFunctions: Codeunit "Global Functions";
        RiskAccounts: Integer;
        BBFAccounts: Integer;
        BOSAAccounts: Integer;
        ShareCapitalAccounts: Integer;
        BOSAMonthyContribution: Decimal;
        SharesMonthyContribution: Decimal;
        BBFMonthyContribution: Decimal;
        RiskMonthyContribution: Decimal;
        RiskExpectedAmount: Decimal;
        BBFExpectedAmount: Decimal;
        BOSAExpectedAmount: Decimal;
        SharesExpectedAmount: Decimal;
        BOSACount: Integer;
        RiskCount: Integer;
        BBFCount: Integer;
        SharesCount: Integer;


}
