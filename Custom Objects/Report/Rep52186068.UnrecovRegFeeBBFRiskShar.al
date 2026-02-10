namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52186068 "Unrecov. Reg Fee/BBF/Risk/Shar"
{
    ApplicationArea = All;
    Caption = 'Unrecov. Reg Fee/BBF/Risk/Shar';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Unrecov. Reg FeeBBFRiskShar.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {

        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", "Employer Code", "Member Class";
            DataItemTableView = Where(Status = filter(<> deceased & <> Closed));
            column(MemberNo; "No.")
            {
            }
            column(PayrollStaffNo; "Payroll/Staff No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Employer_Code; "Employer Code") { }

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
            column(ExpectedShareCapital; ExpectedShareCapital) { }
            column(ShareCapBal; ShareCapBal) { }
            column(UnrecoveredShareCap; UnrecoveredShareCap) { }
            column(BOSAProductCode; BOSAProductCode) { }
            column(BOSAProductName; BOSAProductName) { }
            column(BBFProductCode; BBFProductCode) { }
            column(BBFProductName; BOSAProductName) { }
            column(EntranceFeesCode; EntranceFeesCode) { }
            column(EntranceFeesName; EntranceFeesName) { }
            column(ExpectedEntrance; ExpectedEntrance) { }
            column(EntranceArrears; EntranceArrears) { }
            column(BBFExpected; BBFExpected) { }
            column(BBFArrears; BBFArrears) { }
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
                ProductCode := '';
                ProductName := '';
                BBFArrears := 0;
                BBFExpected := 0;
                RiskExpected := 0;
                EntranceArrears := 0;
                ExpectedEntrance := 0;
                ExpectedShareCapital := 0;
                ShareCapBal := 0;
                UnrecoveredShareCap := 0;

                MemberClass.Get(Members."Member Class");
                ExpectedShareCapital := MemberClass."Default Share Capital";
                ExpectedEntrance := MemberClass."Entrance Fee";

                if Members."Contribution Effective Date" <> 0D then begin
                    if Date2DMY(Members."Contribution Effective Date", 3) = Date2DMY(Today, 3) then
                        startdate := Members."Contribution Effective Date"
                    else
                        startdate := CalcDate('<CY>', Today)
                end;

                //if Members

                SavingsAccount.reset();
                SavingsAccount.setrange("Member No.", Members."No.");
                if SavingsAccount.FindFirst then begin
                    repeat
                        SavingsAccount.CalcFields("Balance (LCY)");
                        case
                            SavingsAccount."Product Category" of
                            SavingsAccount."Product Category"::"Benevolent (BBF)":
                                begin
                                    if not CheckMonthlyContribLogs(SavingsAccount."No.") then begin
                                        BBF += SavingsAccount."Balance (LCY)";
                                        BBFProductCode := SavingsAccount."Product Type";
                                        BBFProductName := Format(SavingsAccount."Product Category");
                                        BBFExpected += ((Today - startdate) div 30) * SavingsAccount."Monthly Contribution";
                                        BBFArrears += BBFExpected - SavingsAccount."Balance (LCY)";
                                    end
                                    else begin
                                        BBF += SavingsAccount."Balance (LCY)";
                                        BBFProductCode := SavingsAccount."Product Type";
                                        BBFProductName := Format(SavingsAccount."Product Category");
                                        BBFExpected += ((Today - startdate) div 30) * SavingsAccount."Monthly Contribution";
                                        BBFArrears += BBFExpected - SavingsAccount."Balance (LCY)";
                                    end;
                                end;
                            //Message('Start Date: %1', startdate);

                            SavingsAccount."Product Category"::"Entrance Fee":
                                begin
                                    EntranceFees := SavingsAccount."Balance (LCY)";
                                    EntranceFeesCode := SavingsAccount."Product Type";
                                    EntranceFeesName := FORMAT(SavingsAccount."Product Category");
                                    EntranceArrears := ExpectedEntrance - SavingsAccount."Balance (LCY)";

                                end;
                            SavingsAccount."Product Category"::Risk:
                                begin
                                    Risk := SavingsAccount."Balance (LCY)";
                                    RiskFeesCode := SavingsAccount."Product Type";
                                    RiskFeesName := FORMAT(SavingsAccount."Product Category");
                                    RiskExpected := (Today - startdate) * SavingsAccount."Monthly Contribution";
                                    RiskArrears := RiskExpected - SavingsAccount."Balance (LCY)";
                                    //Message('Start Date: %1', startdate);
                                end;

                            SavingsAccount."Product Category"::"Share Capital":
                                begin
                                    ShareCapBal := SavingsAccount."Balance (LCY)";
                                    UnrecoveredShareCap := ExpectedShareCapital - ShareCapBal;
                                end;
                        end;
                    until SavingsAccount.next = 0;
                end;
            end;

            trigger
                OnPreDataItem()
            begin
                Members.Reset();
                Members.setfilter("Contribution Effective Date", '>%1', AsAt);
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
                    field("As At"; AsAt)
                    {
                        ApplicationArea = All;
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

        if AsAt = 0D then
            AsAt := Today;
    end;

    procedure CheckMonthlyContribLogs(ProductID: Code[100]): Boolean
    begin
        MonthlyContribLogs.Reset();
        MonthlyContribLogs.SETRANGE("Product ID", ProductID);
        if MonthlyContribLogs.FindFirst() then exit(true) else exit(false);
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
        Productfactory: record "Product Factory";
        BBFArrears: Decimal;
        startdate: Date;
        RiskArrears: Decimal;
        BBFExpected: Decimal;
        RiskExpected: Decimal;
        EntranceArrears: Decimal;
        ExpectedEntrance: Decimal;
        MemberApp: Record "Member Application";
        EmployerName: Code[100];
        ExpectedShareCapital: Decimal;
        MemberClass: Record "Member Classes";
        ShareCapBal: Decimal;
        UnrecoveredShareCap: Decimal;
        MonthlyContribLogs: Record "Monthly Contrib Logs";
        AsAt: Date;
}

