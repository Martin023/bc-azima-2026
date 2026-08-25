namespace AZIMA.AZIMA;
using Microsoft.Sales.Customer;

report 52185532 "Member Balances Report"
{
    ApplicationArea = All;
    Caption = 'Member Balances Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './bc-azima-2026/Layout/Member Balances Report.rdl';


    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "Employer Code", "Payroll/Staff No.", "Global Dimension 1 Code";
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(PayrollStaffNo; "Payroll/Staff No.")
            {
            }
            column(EmployerCode; "Employer Code")
            {
            }
            column(MemberDeposits; MemberDeposits) { }
            column(MFIDeposits; MFIDeposits) { }
            column(ShareCapital; ShareCapital) { }
            column(FosaShares; FosaShares) { }
            column(ASL; ASL) { }
            column(ML; ML) { }
            column(JPL; JPL) { }
            column(SAD; SAD) { }
            column(SP; SP) { }
            column(PA; PA) { }
            column(MF; MF) { }
            column(EL; EL) { }
            column(SL; SL) { }
            column(NLB; NLB) { }
            column(NLA; NLA) { }
            column(JL; JL) { }
            column(MS; MS) { }
            column(ASMB; ASMB) { }
            column(JHL; JHL) { }
            column(JHZ2; JHZ2) { }
            column(SDL; SDL) { }
            column(Sno; Sno) { }
            column(CL; CL) { }
            column(TotalLoans; TotalLoans) { }
            column(Gender; Gender) { }
            column(Primary_Identification; "Primary Identification") { }
            column(Date_of_Birth; "Date of Birth") { }
            Column(CustomerName; CustomerName) { }
            column(TotalInterest; TotalInterest) { }


            trigger OnafterGetRecord()
            begin
                CustomerName := '';
                ShareCapital := 0;
                MemberDeposits := 0;
                MFIDeposits := 0;
                FosaShares := 0;
                ASL := 0;
                ML := 0;
                JPL := 0;
                SAD := 0;
                SP := 0;
                PA := 0;
                MF := 0;
                EL := 0;
                SL := 0;
                NLB := 0;
                NLA := 0;
                JL := 0;
                MS := 0;
                ASMB := 0;
                JHL := 0;
                JHZ2 := 0;
                SDL := 0;
                CL := 0;
                Sno += 1;
                SavingsAccounts.reset;
                SavingsAccounts.setrange("Member No.", Members."No.");
                SavingsAccounts.setfilter("Date Filter", '..%1', Enddate);
                SavingsAccounts.SetAutoCalcFields("Balance (LCY)");
                if SavingsAccounts.Findset() then begin
                    repeat
                        Case
                         SavingsAccounts."Product Category" of
                            SavingsAccounts."Product Category"::"BOSA Deposits":
                                MemberDeposits += SavingsAccounts."Balance (LCY)";
                            SavingsAccounts."Product Category"::"Share Capital":
                                ShareCapital += SavingsAccounts."Balance (LCY)";
                            SavingsAccounts."Product Category"::"Chama Investment Account":
                                MFIDeposits += SavingsAccounts."Balance (LCY)";
                        End;
                    until SavingsAccounts.next() = 0;
                end;

                Customer.Reset();
                Customer.SetRange("No.", Members."Employer Code");
                if Customer.FindFirst() then
                    CustomerName := Customer.Name;

                Loans.Reset();
                loans.SetRange("Member No.", Members."No.");
                loans.SetFilter("Date Filter", '..%1', Enddate);
                Loans.SetAutoCalcFields("Outstanding Balance", "Outstanding Interest");
                if Loans.Findset() then begin
                    repeat
                        case
                            Loans."Loan Product Type" of
                            '012':
                                ASL += Loans."Outstanding Balance";
                            '013':
                                ML += Loans."Outstanding Balance";
                            '016':
                                JPL += Loans."Outstanding Balance";
                            '017':
                                SAD += Loans."Outstanding Balance";
                            '019':
                                SP += Loans."Outstanding Balance";
                            '065':
                                NLB += Loans."Outstanding Balance";
                            '066':
                                NLA += Loans."Outstanding Balance";
                            '068':
                                JL += Loans."Outstanding Balance";
                            '069':
                                MS += Loans."Outstanding Balance";
                            '070':
                                ASMB += Loans."Outstanding Balance";
                            '071':
                                JHL += Loans."Outstanding Balance";
                            '073':
                                JHZ2 += Loans."Outstanding Balance";
                            '074':
                                SDL += Loans."Outstanding Balance";
                            '062':
                                EL += Loans."Outstanding Balance";
                            '072':
                                CL += Loans."Outstanding Balance";

                        end;
                        TotalInterest += Loans."Outstanding Interest";
                        TotalLoans += Loans."Outstanding Balance";
                    until Loans.next() = 0;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(EndDate; EndDate)
                    {
                        caption = 'As at date';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }



    var
        MemberDeposits: Decimal;
        MFIDeposits: Decimal;
        ShareCapital: Decimal;
        FosaShares: Decimal;
        ASL: Decimal;
        ML: Decimal;
        JPL: Decimal;
        SAD: Decimal;
        SP: Decimal;
        PA: Decimal;
        MF: Decimal;
        EL: Decimal;
        SL: Decimal;
        NLB: Decimal;
        NLA: Decimal;
        JL: Decimal;
        MS: Decimal;
        ASMB: Decimal;
        JHL: Decimal;
        JHZ2: Decimal;
        SDL: Decimal;
        Sno: Integer;
        CL: decimal;

        SavingsAccounts: record "Savings Accounts";
        Loans: record Loans;
        StartDate: Date;
        EndDate: Date;
        Customer: record Customer;
        TotalLoans: Decimal;
        CustomerName: text[100];
        TotalInterest: Decimal;


    trigger OnPreReport()
    begin
        If EndDate = 0D then Enddate := Today;
    end;


}
