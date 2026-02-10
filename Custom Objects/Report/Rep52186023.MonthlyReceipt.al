namespace ALProject.ALProject;
using Microsoft.Foundation.Company;
using System.Utilities;

report 52186391 "Monthly Receipt "
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Monthly Receipt Per Product.rdl';

    dataset
    {
        dataitem(Integer; Integer)
        {
            // CalcFields = "Balance (LCY)";
            // column(No; "No.")
            // {
            // }
            // column(Name; Name)
            // {
            // }
            // column(PayrollStaffNo; "Payroll/Staff No.")
            // {
            // }
            column(BBF; BBF)
            {

            }
            column(Risk; Risk)
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
            column(ShareCap; ShareCap)
            {

            }
            column(BosaDeposits; BosaDeposits)
            {

            }
            column(BOSANoOfMembers; BOSANoOfMembers)
            {

            }
            column(RiskNoOfMembers; RiskNoOfMembers)
            {

            }
            column(BBFNoOfMembers; BBFNoOfMembers)
            {

            }
            column(ShareCapNoOfMembers; ShareCapNoOfMembers)
            {

            }
            column(UnpaidBosaDeposits; UnpaidBosaDeposits)
            {

            }
            column(UnpaidBBF; UnpaidBBF)
            {

            }
            column(UnpaidRisk; UnpaidRisk)
            {

            }
            column(UnpaidBBFCount; UnpaidBBFCount)
            {

            }
            column(UnpaidRiskCount; UnpaidRiskCount)
            {

            }
            column(UnpaidBosaDepositsCount; UnpaidBosaDepositsCount)
            {

            }
            column(TotalBBF; TotalBBF)
            {

            }
            column(TotalBBFCount; TotalBBFCount)
            {

            }
            column(TotalDeposits; TotalDeposits)
            {

            }
            column(TotalDepositsCount; TotalDepositsCount)
            {

            }
            column(TotalRisk; TotalRisk)
            {

            }
            column(TotalRiskCount; TotalRiskCount)
            {

            }
            column(UnpaidBBFActive; UnpaidBBFActive)
            {

            }
            column(UnpaidBBFClosed; UnpaidBBFClosed)
            {

            }
            column(UnpaidBBFDeceased; UnpaidBBFDeceased)
            {

            }
            column(UnpaidBBFDormant; UnpaidBBFDormant)
            {

            }
            column(UnpaidBBFNew; UnpaidBBFNew)
            {

            }
            column(UnpaidBBFCountActive; UnpaidBBFCountActive)
            {

            }
            column(UnpaidBBFCountClosed; UnpaidBBFCountClosed)
            {

            }
            column(UnpaidBBFCountDeceased; UnpaidBBFCountDeceased)
            {

            }
            column(UnpaidBBFCountDormant; UnpaidBBFCountDormant)
            {

            }
            column(UnpaidBBFCountNew; UnpaidBBFCountNew)
            {

            }
            column(UnpaidBosaDepositsActive; UnpaidBosaDepositsActive)
            {

            }
            column(UnpaidBosaDepositsClosed; UnpaidBosaDepositsClosed)
            {

            }
            column(UnpaidBosaDepositsNew; UnpaidBosaDepositsNew)
            {

            }
            column(UnpaidBosaDepositsCountNew; UnpaidBosaDepositsCountNew)
            {

            }
            column(UnpaidBosaDepositsDeceased; UnpaidBosaDepositsDeceased)
            {

            }
            column(UnpaidBosaDepositsDormant; UnpaidBosaDepositsDormant)
            {

            }
            column(UnpaidBosaDepositsCountActive; UnpaidBosaDepositsCountActive)
            {

            }
            column(UnpaidBosaDepositsCountClosed; UnpaidBosaDepositsCountClosed)
            {

            }
            column(UnpaidBosaDepositsCountDeceased; UnpaidBosaDepositsCountDeceased)
            {

            }
            column(UnpaidBosaDepositsCountDormant; UnpaidBosaDepositsCountDormant)
            {

            }
            column(UnpaidRiskActive; UnpaidRiskActive)
            {

            }
            column(UnpaidRiskClosed; UnpaidRiskClosed)
            {

            }
            column(UnpaidRiskDeceased; UnpaidRiskDeceased)
            {

            }
            column(UnpaidRiskDormant; UnpaidRiskDormant)
            {

            }
            column(UnpaidRiskNew; UnpaidRiskNew)
            {

            }
            column(UnpaidRiskCountActive; UnpaidRiskCountActive)
            {

            }
            column(UnpaidRiskCountClosed; UnpaidRiskCountClosed)
            {

            }
            column(UnpaidRiskCountDeceased; UnpaidRiskCountDeceased)
            {

            }
            column(UnpaidRiskCountDormant; UnpaidRiskCountDormant)
            {

            }
            column(UnpaidRiskCountNew; UnpaidRiskCountNew)
            {

            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin

                UnpaidBBF := 0;
                UnpaidBosaDeposits := 0;
                UnpaidRisk := 0;
                BosaDeposits := 0;
                Risk := 0;
                BBF := 0;


                SavingsAccount.reset();
                if SavingsAccount.FindFirst then begin
                    repeat
                        SavingsAccount.SetFilter("Date Filter", '%1..%2', startDate, Enddate);
                        SavingsAccount.CalcFields("Balance (LCY)");
                        case SavingsAccount."Product Category" of
                            SavingsAccount."Product Category"::"BOSA Deposits":
                                begin
                                    if SavingsAccount."Balance (LCY)" > 0 then begin
                                        BosaDeposits += GetAccountCredits(SavingsAccount."No.");
                                        BOSANoOfMembers += 1;
                                    end else begin
                                        if CustomCuesCodeunit.Prorata(SavingsAccount."Member No.", '1') > 0 then
                                            UnpaidBosaDeposits += CustomCuesCodeunit.Prorata(SavingsAccount."Member No.", '1')
                                        else
                                            UnpaidBosaDeposits += ProdFactory."Minimum Contribution";
                                        UnpaidBosaDepositsCount += 1;
                                        if Members.Get(SavingsAccount."Member No.") then begin
                                            if Members.Status = Members.Status::Active then begin
                                                UnpaidBosaDepositsCountActive += 1;
                                                UnpaidBosaDepositsActive += CustomCuesCodeunit.Prorata(SavingsAccount."Member No.", '1');
                                            end;
                                            if Members.Status = Members.Status::Dormant then begin
                                                UnpaidBosaDepositsCountDormant += 1;
                                                UnpaidBosaDepositsDormant += CustomCuesCodeunit.Prorata(SavingsAccount."Member No.", '1');
                                            end;
                                            if Members.Status = Members.Status::New then begin
                                                UnpaidBosaDepositsCountNew += 1;
                                                UnpaidBosaDepositsNew += CustomCuesCodeunit.Prorata(SavingsAccount."Member No.", '1');
                                            end;
                                            if Members.Status = Members.Status::Closed then begin
                                                UnpaidBosaDepositsCountClosed += 1;
                                                UnpaidBosaDepositsClosed += CustomCuesCodeunit.Prorata(SavingsAccount."Member No.", '1');
                                            end;
                                            if Members.Status = Members.Status::Deceased then begin
                                                UnpaidBosaDepositsCountDeceased += 1;
                                                UnpaidBosaDepositsDeceased += CustomCuesCodeunit.Prorata(SavingsAccount."Member No.", '1');
                                            end;
                                        end;
                                    end;
                                end;
                            SavingsAccount."Product Category"::"Benevolent (BBF)":
                                begin

                                    if SavingsAccount."Balance (LCY)" > 0 then begin
                                        BBF += GetAccountCredits(SavingsAccount."No.");
                                        BBFNoOfMembers += 1;
                                    end else begin
                                        UnpaidBBF += ProdFactory.GetMonthlyContrib(SavingsAccount."Product Type", Enddate);
                                        UnpaidBBFCount += 1;

                                        if Members.Get(SavingsAccount."Member No.") then begin
                                            if Members.Status = Members.Status::Active then begin
                                                UnpaidBBFCountActive += 1;
                                                UnpaidBBFActive += ProdFactory.GetMonthlyContrib(SavingsAccount."Product Type", Enddate);
                                            end;
                                            if Members.Status = Members.Status::Dormant then begin
                                                UnpaidBBFCountDormant += 1;
                                                UnpaidBBFDormant += ProdFactory.GetMonthlyContrib(SavingsAccount."Product Type", Enddate);
                                            end;
                                            if Members.Status = Members.Status::New then begin
                                                UnpaidBBFCountNew += 1;
                                                UnpaidBBFNew += ProdFactory.GetMonthlyContrib(SavingsAccount."Product Type", Enddate);
                                            end;
                                            if Members.Status = Members.Status::Closed then begin
                                                UnpaidBBFCountClosed += 1;
                                                UnpaidBBFClosed += ProdFactory.GetMonthlyContrib(SavingsAccount."Product Type", Enddate);
                                            end;
                                            if Members.Status = Members.Status::Deceased then begin
                                                UnpaidBBFCountDeceased += 1;
                                                UnpaidBBFDeceased += ProdFactory.GetMonthlyContrib(SavingsAccount."Product Type", Enddate);
                                            end;
                                        end;

                                    end;

                                end;
                            SavingsAccount."Product Category"::Risk:
                                begin

                                    if SavingsAccount."Balance (LCY)" > 0 then begin
                                        Risk += GetAccountCredits(SavingsAccount."No.");
                                        RiskNoOfMembers += 1;
                                    end else begin
                                        UnpaidRisk += ProdFactory.GetMonthlyContrib(SavingsAccount."Product Type", Enddate);
                                        UnpaidRiskCount += 1;

                                        if Members.Get(SavingsAccount."Member No.") then begin
                                            if Members.Status = Members.Status::Active then begin
                                                UnpaidRiskCountActive += 1;
                                                UnpaidRiskActive += ProdFactory.GetMonthlyContrib(SavingsAccount."Product Type", Enddate);
                                            end;
                                            if Members.Status = Members.Status::Dormant then begin
                                                UnpaidRiskCountDormant += 1;
                                                UnpaidRiskDormant += ProdFactory.GetMonthlyContrib(SavingsAccount."Product Type", Enddate);
                                            end;
                                            if Members.Status = Members.Status::New then begin
                                                UnpaidRiskCountNew += 1;
                                                UnpaidRiskNew += ProdFactory.GetMonthlyContrib(SavingsAccount."Product Type", Enddate);
                                            end;
                                            if Members.Status = Members.Status::Closed then begin
                                                UnpaidRiskCountClosed += 1;
                                                UnpaidRiskClosed += ProdFactory.GetMonthlyContrib(SavingsAccount."Product Type", Enddate);
                                            end;
                                            if Members.Status = Members.Status::Deceased then begin
                                                UnpaidRiskCountDeceased += 1;
                                                UnpaidRiskDeceased += ProdFactory.GetMonthlyContrib(SavingsAccount."Product Type", Enddate);
                                            end;
                                        end;
                                    end;

                                end;
                        end;
                    until SavingsAccount.next = 0;
                end;

                TotalDeposits := BosaDeposits + UnpaidBosaDeposits;
                TotalDepositsCount := BOSANoOfMembers + UnpaidBosaDepositsCount;

                TotalBBF := BBF + UnpaidBBF;
                TotalBBFCount := BBFNoOfMembers + UnpaidBBFCount;

                TotalRisk := Risk + UnpaidRisk;
                TotalRiskCount := RiskNoOfMembers + UnpaidRiskCount;
            end;

            trigger OnPreDataItem()
            begin
                if startDate = 0D then
                    startDate := 19900101D;

                if Enddate = 0D then
                    Enddate := Today;

                Integer.Reset();
                Integer.SetRange(Number, 1);
            end;
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
                group("Date Filter")
                {
                    field(startDate; startDate)
                    {
                        Caption = 'Start Date';
                        ShowMandatory = true;

                    }
                    field(Enddate; Enddate)
                    {
                        Caption = 'End Date';
                        ShowMandatory = true;
                    }
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

        BosaDeposits := 0;
        BBF := 0;
        ShareCap := 0;
        Risk := 0;
    end;

    procedure GetAccountCredits(SavingAccNo: code[50]): Decimal
    begin
        SavingLedgerEntry.reset;
        SavingLedgerEntry.setrange("Posting Date", startDate, Enddate);
        //SavingLedgerEntry.SetFilter("Date Filter",Datefi);
        SavingLedgerEntry.SetRange("Customer No.", SavingAccNo);
        SavingLedgerEntry.setrange(Reversed, false);
        SavingLedgerEntry.setfilter("Credit Amount (LCY)", '<>%1', 0);
        SavingLedgerEntry.CalcSums("Credit Amount (LCY)");
        exit(SavingLedgerEntry."Credit Amount (LCY)");
    end;

    // procedure MemStatus(MemNo: Code[20])
    // begin

    //     if Members.Get(MemNo) then begin
    //         if Members.Status = Members.Status::Active then begin

    //             else if Members.Status = Members.Status::Dormant then begin

    //             end
    //             else
    //                 if Members.Status = Members.Status::Closed then begin
    //                     if Members.Subflag = Members.Subflag::"First time" then
    //                         MemClose.Add('FTIME', 1)
    //                     else
    //                         MemClose.Add('REJOIN', 1)
    //                 end

    //         end
    //         else begin
    //             MemActive.Add('FTIME', 0);
    //             MemActive.Add('REJOIN', 0)
    //         end;
    //         exit(MemActive);
    //     end;

    procedure GetMembershipNoofMonths(Members: Record Members): Integer
    var
        MembershipMonths: Integer;
    begin
        MembershipMonths := 0;
        MembershipMonths := Round((Today - Members."Registration Date") DIV 30, 1, '<');
        exit(MembershipMonths);
    end;

    procedure GetUnpaidAmount(SavingAccNo: Code[50]): Decimal
    var
        SavingLedgerEntry: Record "Savings Ledger Entry";
        ExpectedAmount: Decimal;
        ActualAmount: Decimal;
    begin
        // Calculate expected amount (this is an example, adjust as needed)
        ExpectedAmount := ProdFactory."Minimum Contribution"; // Replace with actual calculation based on your business rules

        // Calculate actual amount paid
        SavingLedgerEntry.Reset();
        SavingLedgerEntry.SetRange("Customer No.", SavingAccNo);
        SavingLedgerEntry.SetRange("Posting Date", startDate, Enddate);
        SavingLedgerEntry.SetRange(Reversed, false);
        SavingLedgerEntry.CalcSums("Credit Amount (LCY)");
        ActualAmount := SavingLedgerEntry."Credit Amount (LCY)";

        // Return the difference if actual is less than expected
        if ActualAmount < ExpectedAmount then
            exit(ExpectedAmount - ActualAmount)
        else
            exit(0);
    end;

    var
        CompanyInformation: record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        CustomCuesCodeunit: Codeunit CustomCuesCodeunit;

        BBF: decimal;
        Risk: Decimal;
        ShareCap: decimal;
        BosaDeposits: decimal;
        SavingLedgerEntry: record "Savings Ledger Entry";
        SavingsAccount: Record "Savings Accounts";
        CreditLedgerEntry: record "Credit Ledger Entry";
        PostingDate: date;
        startDate: date;
        Enddate: date;
        BOSANoOfMembers: Integer;
        RiskNoOfMembers: Integer;
        ShareCapNoOfMembers: Integer;
        BBFNoOfMembers: Integer;
        UnpaidBosaDeposits: Decimal;
        UnpaidBBF: Decimal;
        UnpaidRisk: Decimal;
        UnpaidLoanRepayments: Decimal;
        ProdFactory: Record "Product Factory";
        UnpaidBosaDepositsCount: Integer;
        UnpaidRiskCount: Integer;
        UnpaidBBFCount: Integer;
        TotalRiskCount: Integer;
        TotalBBFCount: Integer;
        TotalDepositsCount: Integer;
        TotalRisk: Decimal;
        TotalBBF: Decimal;
        TotalDeposits: Decimal;
        Members: Record Members;
        UnpaidBosaDepositsCountDeceased: Integer;
        UnpaidBosaDepositsCountClosed: Integer;
        UnpaidBosaDepositsCountNew: Integer;
        UnpaidBosaDepositsCountDormant: Integer;
        UnpaidBosaDepositsCountActive: Integer;
        UnpaidBosaDepositsDeceased: Decimal;
        UnpaidBosaDepositsClosed: Decimal;
        UnpaidBosaDepositsNew: Decimal;
        UnpaidBosaDepositsDormant: Decimal;
        UnpaidBosaDepositsActive: Decimal;
        UnpaidBBFCountActive: Integer;
        UnpaidBBFCountDormant: Integer;
        UnpaidBBFCountNew: Integer;
        UnpaidBBFCountClosed: Integer;
        UnpaidBBFCountDeceased: Integer;
        UnpaidBBFActive: Decimal;
        UnpaidBBFNew: Decimal;
        UnpaidBBFClosed: Decimal;
        UnpaidBBFDormant: Decimal;
        UnpaidBBFDeceased: Decimal;
        UnpaidRiskActive: Integer;
        UnpaidRiskDormant: Integer;
        UnpaidRiskNew: Integer;
        UnpaidRiskClosed: Integer;
        UnpaidRiskDeceased: Integer;
        UnpaidRiskCountActive: Decimal;
        UnpaidRiskCountDormant: Decimal;
        UnpaidRiskCountNew: Decimal;
        UnpaidRiskCountDeceased: Decimal;
        UnpaidRiskCountClosed: Decimal;
}
