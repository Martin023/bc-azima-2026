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
                Retainer := 0;
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
                CommsionSetup.Reset();
                CommsionSetup.SetRange(Type, CommsionSetup.type::Commission);
                CommsionSetup.SetRange("Commission Type", CommsionSetup."Commission Type"::"Member Recruitment");
                if CommsionSetup.FindSet() then begin
                    commsionlines.reset;
                    commsionlines.setrange("Transaction Type", CommsionSetup.Code);
                    if commsionlines.findset() then begin
                        repeat
                            if RecrutedMembers in [commsionlines."Minimum Amount" .. commsionlines."Maximum Amount"] then begin
                                CommissionOnNewMembers := commsionlines."Charge Amount" * RecrutedMembers;
                            end;
                        until commsionlines.Next() = 0;
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

}
