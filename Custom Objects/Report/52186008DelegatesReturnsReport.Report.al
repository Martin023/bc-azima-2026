#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186008 "Delegates Returns Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Delegates Returns Report.rdl';

    dataset
    {
        //dataitem(52186056;52186056)
        dataitem("Delegates Minutes Header"; "Delegates Minutes Header")
        {
            RequestFilterFields = Year, Month;
            column(ReportForNavId_1; 1)
            {
            }
            column(PrintedBy; PrintedBy)
            {
            }
            column(PrintedAt; PrintedAt)
            {
            }
            column(BookNo; BookNo)
            {
            }
            column(TotalBranchMembers; TotalBranchMembers)
            {
            }
            column(BranchName; BranchName)
            {
            }
            column(MonthText; MonthText)
            {
            }
            column(Date; Date)
            {
            }
            column(Defaulters; Defaulters)
            {
            }
            column(MortgageLoan; MortgageLoan)
            {
            }
            column(NewLoans; NewLoans)
            {
            }
            column(NewMembers; NewMembers)
            {
            }
            column(Rejoiner; Rejoiner)
            {
            }
            column(SalaryAccount; SalaryAccount)
            {
            }
            column(TotoAccounts; TotoAccounts)
            {
            }
            column(VariationUp; VariationUp)
            {
            }
            column(WafanisiAccounts; WafanisiAccounts)
            {
            }
            column(Withdrawals; Withdrawals)
            {
            }
            column(ElectoralRegion_DelegatesMinutesHeader; "Delegates Minutes Header"."Electoral Region")
            {
            }
            column(ElectoralName_DelegatesMinutesHeader; "Delegates Minutes Header"."Electoral Name")
            {
            }
            column(TotalCount; TotalCount)
            {
            }
            column(Month; Month)
            {
            }
            column(Year; Year)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Defaulters := 0;
                MortgageLoan := 0;
                NewLoans := 0;
                NewMembers := 0;
                Rejoiner := 0;
                SalaryAccount := 0;
                TotoAccounts := 0;
                TotalCount := 0;
                VariationUp := 0;
                WafanisiAccounts := 0;
                Withdrawals := 0;
                TotalBranchMembers := 0;
                //DelegatesMinutesHeader
                DelegatesMonthlyReturns.Reset;
                DelegatesMonthlyReturns.SetRange("Header No", "Delegates Minutes Header".Code);
                DelegatesMonthlyReturns.SetRange("Caption Type", 'TOTAL_BRANCH_MEMBERS');
                if DelegatesMonthlyReturns.FindFirst then
                    TotalBranchMembers := DelegatesMonthlyReturns."Total Branch Members";


                DelegatesMonthlyReturns.Reset;
                DelegatesMonthlyReturns.SetRange("Header No", "Delegates Minutes Header".Code);
                if DelegatesMonthlyReturns.FindFirst then begin
                    repeat
                        DelegatesMonthlyReturns.CalcFields("Records Submitted");

                        if DelegatesMonthlyReturns."Caption Type" = 'DEFAULTERS' then
                            Defaulters := DelegatesMonthlyReturns."Records Submitted";

                        if DelegatesMonthlyReturns."Caption Type" = 'MORTGAGE_LOAN' then
                            MortgageLoan := DelegatesMonthlyReturns."Records Submitted";

                        if DelegatesMonthlyReturns."Caption Type" = 'NEW_LOANS' then
                            NewLoans := DelegatesMonthlyReturns."Records Submitted";

                        if DelegatesMonthlyReturns."Caption Type" = 'NEW_MEMBERS' then
                            NewMembers := DelegatesMonthlyReturns."Records Submitted";

                        if DelegatesMonthlyReturns."Caption Type" = 'REJOINERS' then
                            Rejoiner := DelegatesMonthlyReturns."Records Submitted";

                        if DelegatesMonthlyReturns."Caption Type" = 'SALARY_ACCOUNTS' then
                            SalaryAccount := DelegatesMonthlyReturns."Records Submitted";

                        if DelegatesMonthlyReturns."Caption Type" = 'TOTO_ACCOUNTS' then
                            TotoAccounts := DelegatesMonthlyReturns."Records Submitted";

                        if DelegatesMonthlyReturns."Caption Type" = 'VARIATION_UP' then
                            VariationUp := DelegatesMonthlyReturns."Records Submitted";

                        if DelegatesMonthlyReturns."Caption Type" = 'WAFANISI_ACCOUNTS' then
                            WafanisiAccounts := DelegatesMonthlyReturns."Records Submitted";

                        if DelegatesMonthlyReturns."Caption Type" = 'WITHDRAWALS' then
                            Withdrawals := DelegatesMonthlyReturns."Records Submitted";

                        if DelegatesMonthlyReturns."Caption Type" = 'TOTAL_BRANCH_MEMBERS' then
                            TotalBranchMembers := DelegatesMonthlyReturns."Total Branch Members";
                    until DelegatesMonthlyReturns.Next = 0;
                    TotalCount := Defaulters + MortgageLoan + NewLoans + NewMembers + Rejoiner + SalaryAccount + TotoAccounts + VariationUp + WafanisiAccounts + Withdrawals;
                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        MonthInt: Integer;
        YearInt: Integer;
    begin
        Company.Get;
        Company.CalcFields(Picture);
        PrintedBy := CopyStr(UserId, StrPos(UserId, '\') + 1, StrLen(UserId));
        // PrintedAt := SkyHarambeePortal.FormatDateTimeReverse(CurrentDatetime);
        Year := "Delegates Minutes Header".GetFilter(Year);
        Month := "Delegates Minutes Header".GetFilter(Month);
        if (Month = '') and (Year = '') then Error('Year and Month should have a value');
        if (Year = '') then Error('Year should have a value');
        if (Month = '') then Error('Month should have a value');
        Evaluate(MonthInt, Month);
        Evaluate(YearInt, Year);

        if MonthInt > 12 then Error('Month cannot be greater than 12');
        if YearInt > Date2dmy(Today, 3) then Error('Year cannot be greater than %1.', Format(Date2dmy(Today, 3)));
    end;

    var
        BookNo: Code[10];
        PrintedBy: Code[50];
        PrintedAt: Text;
        // SkyHarambeePortal: Codeunit "Sky Harambee Portal";
        DelegatesReturnsLines: Record "Delegates Returns Lines";
        LinesCount: Integer;
        Company: Record "Company Information";
        LinesMemberNumbers: Text;
        DelegatesMonthlyReturns: Record "Delegates Monthly Returns";
        TotalBranchMembers: Integer;
        BranchName: Text;
        MonthText: Text;
        Date: Text;
        DelegateRegion: Record "Delegate Region";
        DelegatesMinutesHeader: Record "Delegates Minutes Header";
        Defaulters: Integer;
        MortgageLoan: Integer;
        NewLoans: Integer;
        NewMembers: Integer;
        Rejoiner: Integer;
        SalaryAccount: Integer;
        VariationUp: Integer;
        TotoAccounts: Integer;
        WafanisiAccounts: Integer;
        Withdrawals: Integer;
        TotalCount: Integer;
        Month: Text;
        Year: Text;
}
