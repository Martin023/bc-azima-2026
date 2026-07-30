namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52186124 "Member Commission"
{
    ApplicationArea = All;
    Caption = 'Member Commission ';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Member Commission .rdl';

    dataset
    {
        dataitem(CompanyHeader; "Company Information")
        {
            DataItemTableView = sorting("Primary Key");
            MaxIteration = 1;

            column(CompanyInformation_Name; Name)
            {
            }
            column(CompanyInformation_Picture; Picture)
            {
            }

            trigger OnPreDataItem()
            begin
                CalcFields(Picture);  // load BLOB here, once
            end;
        }
        dataitem("Marketing Teams Header"; "Marketing Teams Header")
        {
            RequestFilterFields = "Payroll No.", "Member Name", "ID Number", "Branch Code";
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(Branch_Code; "Branch Code") { }
            column(Payroll_No_; "Payroll No.") { }
            column(Member_Name; "Member Name") { }
            column(NewMemberTarget; "Membership Target") { }
            column(RecrutedMembers; RecrutedMembers) { }
            column(NewPaidMembersRecruited; NewPaidMembersRecruited) { }
            column(FollowUpMembers; FollowUpMembers) { }
            column(EntranceFee; EntranceFee) { }
            column(ShareCapital; ShareCapital) { }
            column(Deposist; Deposist) { }
            column(CommissionOnNewMembers; CommissionOnNewMembers) { }
            column(MembersRejoined; MembersRejoined) { }
            column(RejoinedCommsion; RejoinedCommsion) { }
            column(CheckoffCommsion; CheckoffCommsion) { }
            column(MembersDormant; MembersDormant) { }
            column(DormantCommsion; DormantCommsion) { }
            column(AchievedShareCapitalPort; AchievedShareCapitalPort) { }
            column(CommssionOnShareCapital; CommssionOnShareCapital) { }
            column(AchievedDepositPort; AchievedDepositPort) { }
            column(CommssionOnAchievedDepositPort; CommssionOnAchievedDepositPort) { }
            column(InterestPaidOnLoans; InterestPaidOnLoans) { }
            column(CommissionOnIntPaid; CommissionOnIntPaid) { }
            column(FDTotal; FDTotal) { }
            column(SAYETotal; SAYETotal) { }
            column(SAYECommssion; SAYECommssion) { }
            column(JuniorTotal; JuniorTotal) { }
            column(CommsionOnJunior; CommsionOnJunior) { }
            column(HolidayTotal; HolidayTotal) { }
            column(CommsionOnHoliday; CommsionOnHoliday) { }
            column(Retainer; "Marketing Teams Header".Retainer) { }
            column(AggregateCommission; AggregateCommission) { }
            trigger OnAfterGetRecord()
            begin
                RecrutedMembers := 0;
                NewPaidMembersRecruited := 0;
                FollowUpMembers := 0;
                EntranceFee := 0;
                ShareCapital := 0;
                Deposist := 0;
                CommissionOnNewMembers := 0;
                MembersRejoined := 0;
                RejoinedCommsion := 0;
                CheckoffCommsion := 0;
                MembersDormant := 0;
                DormantCommsion := 0;
                AchievedShareCapitalPort := 0;
                CommssionOnShareCapital := 0;
                AchievedDepositPort := 0;
                CommssionOnAchievedDepositPort := 0;
                InterestPaidOnLoans := 0;
                CommissionOnIntPaid := 0;
                FDTotal := 0;
                SAYETotal := 0;
                SAYECommssion := 0;
                JuniorTotal := 0;
                CommsionOnJunior := 0;
                HolidayTotal := 0;
                CommsionOnHoliday := 0;
                AggregateCommission := 0;
                Members.reset;
                Members.SetLoadFields("No.", "Phone No.", Name, "Recruited By", "Member Class", "Registration Date", "Rejoinig Date");
                // if (StartDate <> 0D) then
                //     if Enddate <> 0D then
                Members.SetRange("Registration Date", StartDate, Enddate);
                // else Members.SetRange("Registration Date", StartDate);
                Members.SetRange("Recruited By", "Marketing Teams Header"."Payroll No.");
                if Members.FindSet() then begin
                    repeat
                    Members.CalcFields("FOSA Savings","BOSA Deposit","Share Capital");
                    if MemberClass.get(Members."Member Class") then begin
                        ProductSetUp.reset;
                        ProductSetUp.SetRange("Product ID",'191');
                        if ProductSetUp.FindFirst() then
                            FosaMinBal := ProductSetUp."Minimum Balance";

                        if (Members."BOSA Deposit" < MemberClass."Default BOSA Deposit")
                            and (Members."Share Capital" < MemberClass."Default Share Capital")
                                and (Members."FOSA Savings" < FosaMinBal) then
                                    CurrReport.skip;

                    end else CurrReport.skip;
                        
                        RecrutedMembers += 1;

                        SavingsAccount.Reset();
                        SavingsAccount.SetRange("Member No.", Members."No.");
                        SavingsAccount.SetAutoCalcFields("Balance (LCY)");
                        if SavingsAccount.FindSet() then begin
                            repeat
                                case
                                    SavingsAccount."Product Category" of
                                    SavingsAccount."Product Category"::"BOSA Deposits":
                                        Deposist += SavingsAccount."Balance (LCY)";
                                    SavingsAccount."Product Category"::"Fixed Deposit":
                                        FDTotal += SavingsAccount."Balance (LCY)";
                                    SavingsAccount."Product Category"::"Share Capital":
                                        ShareCapital += SavingsAccount."Balance (LCY)";
                                    SavingsAccount."Product Category"::SAYE:
                                        SAYETotal += SavingsAccount."Balance (LCY)";
                                    SavingsAccount."Product Category"::"Junior Account":
                                        JuniorTotal += SavingsAccount."Balance (LCY)";
                                    SavingsAccount."Product Category"::Holiday:
                                        HolidayTotal += SavingsAccount."Balance (LCY)";
                                    SavingsAccount."Product Category"::"Entrance Fee":
                                        EntranceFee += SavingsAccount."Balance (LCY)";
                                end;
                            until SavingsAccount.Next() = 0;
                        end;

                    until Members.Next() = 0;
                end;

                Loans.Reset();
                Loans.SetRange("Sales Agent", "Marketing Teams Header"."Payroll No.");
                Loans.SetRange(Posted, true);
                if Loans.FindSet() then begin
                    repeat
                        CreditLedgerEntr.Reset();
                        CreditLedgerEntr.SetRange("Loan No", Loans."Loan No.");
                        CreditLedgerEntr.SetRange(Reversed, false);
                        CreditLedgerEntr.setrange("Transaction Type", CreditLedgerEntr."Transaction Type"::"Interest Paid");
                        CreditLedgerEntr.SetCurrentKey("Entry No.");
                        creditledgerEntr.SetAscending("Entry No.",true);
                        if CreditLedgerEntr.findfirst() then
                            begin
                                if CreditLedgerEntr."Posting Date" in [Startdate..Enddate] then
                                    begin
                                        CreditLedgerEntr2.reset;
                                        CreditLedgerEntr2.SetRange("Document No.",CreditLedgerEntr."Document No.");
                                        if CreditLedgerEntr2.FindSet() then begin
                                            Clear(TotalRepaymentAmount);
                                            Clear(InterestPaidOnLoans);
                                            repeat
                                                case CreditLedgerEntr2."Transaction Type" of
                                                    CreditLedgerEntr2."Transaction Type"::Repayment:
                                                        TotalRepaymentAmount += CreditLedgerEntr2.Amount;
                                                    CreditLedgerEntr2."Transaction Type"::"Interest Paid":
                                                        InterestPaidOnLoans += CreditLedgerEntr2.Amount;
                                                end;
                                            until CreditLedgerEntr2.Next() = 0;

                                            if (TotalRepaymentAmount + InterestPaidOnLoans) >= Loans.Repayment then begin
                                                CommsionSetup.Reset();
                                                CommsionSetup.SetRange(Type, CommsionSetup.Type::Commission);
                                                CommsionSetup.SetRange("Commission Type", CommsionSetup."Commission Type"::"Interest Paid");
                                                if CommsionSetup.FindFirst() then begin
                                                    CommsionLines.Reset();
                                                    CommsionLines.SetRange("Transaction Type", CommsionSetup.Code);
                                                    if CommsionLines.FindFirst() then
                                                        CommissionOnIntPaid += CommsionLines."Percentage of Amount" * InterestPaidOnLoans / 100;
                                                end;
                                            end;
                                        end;
                                    end;
                                                     
                                end;
                       
                    until Loans.Next() = 0;
                end;

                CommsionSetup.Reset();
                CommsionSetup.SetRange(Type, CommsionSetup.type::Commission);
                CommsionSetup.SetRange("Commission Type", CommsionSetup."Commission Type"::"Member Recruitment");
                if CommsionSetup.findfirst() then begin
                    commsionlines.reset;
                    commsionlines.setrange("Transaction Type", CommsionSetup.Code);
                    if commsionlines.findset() then begin
                        repeat
                            if RecrutedMembers in [commsionlines."Minimum Amount" .. commsionlines."Maximum Amount"] then begin
                                CommissionOnNewMembers += commsionlines."Charge Amount" * RecrutedMembers;
                            end;
                        until commsionlines.Next() = 0;
                    end;
                end;

                AggregateCommission := CommissionOnNewMembers+CommissionOnIntPaid+retainer;
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
                    Caption = 'Date Filter';
                    field(StartDate; StartDate)
                    {
                        Caption = 'Start Date';
                    }
                    field(EndDate; Enddate)
                    {
                        Caption = 'Start Date';
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
        if CompanyInformation.Get then begin
            CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
            CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
            CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
        end;
        if Enddate = 0D then Enddate := Today;
    end;

    var
        CI: Record "Company Information";
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SavingsAccount: Record "Savings Accounts";
        AmountContributed: Decimal;
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        ContributionDate: Date;
        NewMemberTarget: Integer;
        RecrutedMembers: Integer;
        NewPaidMembersRecruited: Integer;
        FollowUpMembers: Integer;
        EntranceFee: Decimal;
        ShareCapital: Decimal;
        Deposist: Decimal;
        CommissionOnNewMembers: Decimal;
        MembersRejoined: Integer;
        RejoinedCommsion: Decimal;
        CheckoffCommsion: Decimal;
        MembersDormant: Decimal;
        DormantCommsion: Decimal;
        AchievedShareCapitalPort: Decimal;
        CommssionOnShareCapital: Decimal;
        AchievedDepositPort: Decimal;
        CommssionOnAchievedDepositPort: Decimal;
        InterestPaidOnLoans: Decimal;
        CommissionOnIntPaid: Decimal;
        FDTotal: Decimal;
        SAYETotal: Decimal;
        SAYECommssion: Decimal;
        JuniorTotal: Decimal;
        CommsionOnJunior: Decimal;
        HolidayTotal: Decimal;
        CommsionOnHoliday: Decimal;
        AggregateCommission: Decimal;
        Members: record Members;
        StartDate: Date;
        Enddate: Date;
        Loans: record Loans;
        CommsionSetup: record "Transaction Types";
        commsionlines: record "Transaction Charges";
        CreditLedgerEntr: record "Credit Ledger Entry";
        MemberClass: record "Member Classes";
        ProductSetUp: record "Product Factory";
        FosaMinBal : Decimal;
        TotalRepaymentAmount : Decimal;
        CreditLedgerEntr2: record "Credit Ledger Entry";
}
