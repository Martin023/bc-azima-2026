namespace AZIMA.AZIMA;

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

            trigger OnafterGetRecord()
            begin
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

                Sno += 1;
                SavingsAccounts.reset;
                SavingsAccounts.setrange("Member No.", Members."No.");
                SavingsAccounts.setfilter("Date Filter", '..%1', Enddate);
                SavingsAccounts.SetAutoCalcFields(Balance);
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

                Loans.Reset();
                loans.SetRange("Member No.", Members."No.");
                loans.SetFilter("Date Filter", '..%1', Enddate);
                Loans.SetAutoCalcFields("Outstanding Balance");
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

                        end;
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

        SavingsAccounts: record "Savings Accounts";
        Loans: record Loans;
        StartDate: Date;
        EndDate: Date;


    trigger OnPreReport()
    begin
        If EndDate = 0D then Enddate := Today;
    end;


}
