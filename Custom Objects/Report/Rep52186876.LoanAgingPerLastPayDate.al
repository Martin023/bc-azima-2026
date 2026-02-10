#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
report 52186876 "Loan Ageing Per Last Pay Date"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Loan Aging Last Pay Date.rdl';
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Loan Ageing Per Last Pay Date';

    dataset
    {
        dataitem(Loans; Loans)
        {
            CalcFields = "Loans Category-SASRA", "Outstanding Balance", "Last Pay Date";
            DataItemTableView = sorting("Loan No.") where(Posted = const(True), "Outstanding Balance" = filter(<> 0));
            RequestFilterFields = "Employer Code", "Source Unit", "Outstanding Balance", "Date Filter";
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            //column(CurrReport_PAGENO; CurrReport.PageNo)
            //{
            //}
            column(USERID; UserId)
            {
            }
            column(Loans__Loan__No__; Loans."Loan No.")
            {
            }
            column(MemberNO; Loans."Member No.")
            {
            }
            column(Loans__Loan_Product_Type_; "Loan Product Type")
            {
            }
            column(Loans_Loans__Staff_No_; Loans."Staff No")
            {
            }
            column(Loans__Client_Name_; Loans."Member Name")
            {
            }
            column(Loans_Loans__Outstanding_Balance_; Loans."Outstanding Balance")
            {
            }
            column(V2Month_; "2Month")
            {
            }
            column(V3Month_; "3Month")
            {
            }
            column(Over3Month; Over3Month)
            {
            }
            column(V1Month_; "1Month")
            {
            }
            column(V0Month_; "0Month")
            {
            }
            column(Loans_Loans__Outstanding_Balance__Control1000000016; Loans."Outstanding Balance")
            {
            }
            column(Loans__Approved_Amount_; "Approved Amount")
            {
            }
            column(V1MonthC_; "1MonthC")
            {
            }
            column(V2MonthC_; "2MonthC")
            {
            }
            column(V3MonthC_; "3MonthC")
            {
            }
            column(Over3MonthC; Over3MonthC)
            {
            }
            column(NoLoans; NoLoans)
            {
            }
            column(GrandTotal; GrandTotal)
            {
            }
            column(V0Month__Control1102760031; "0Month")
            {
            }
            column(V1Month__Control1102760032; "1Month")
            {
            }
            column(V2Month__Control1102760033; "2Month")
            {
            }
            column(V3Month__Control1102760034; "3Month")
            {
            }
            column(Over3Month_Control1102760035; Over3Month)
            {
            }
            column(V0MonthC_; "0MonthC")
            {
            }
            column(Loans_Aging_Analysis__SASRA_Caption; Loans_Aging_Analysis__SASRA_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loans__Loan__No__Caption; Loans.FieldCaption("Loan No."))
            {
            }
            column(Loan_TypeCaption; Loan_TypeCaptionLbl)
            {
            }
            column(Staff_No_Caption; Staff_No_CaptionLbl)
            {
            }
            column(Loans__Client_Name_Caption; Loans.FieldCaption("Member Name"))
            {
            }
            column(Oustanding_BalanceCaption; Oustanding_BalanceCaptionLbl)
            {
            }
            column(PerformingCaption; PerformingCaptionLbl)
            {
            }
            column(V1___30_Days_Caption; V1___30_Days_CaptionLbl)
            {
            }
            column(V0_Days_Caption; V0_Days_CaptionLbl)
            {
            }
            column(WatchCaption; WatchCaptionLbl)
            {
            }
            column(V31___180_Days_Caption; V31___180_Days_CaptionLbl)
            {
            }
            column(SubstandardCaption; SubstandardCaptionLbl)
            {
            }
            column(V181___360_Days_Caption; V181___360_Days_CaptionLbl)
            {
            }
            column(DoubtfulCaption; DoubtfulCaptionLbl)
            {
            }
            column(Over_360_DaysCaption; Over_360_DaysCaptionLbl)
            {
            }
            column(LossCaption; LossCaptionLbl)
            {
            }
            column(TotalsCaption; TotalsCaptionLbl)
            {
            }
            column(CountCaption; CountCaptionLbl)
            {
            }
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            column(RelationshipManager; RelationManager)
            {
            }
            column(CompanyNam; company.Name)
            {
            }
            column(CompanyPic; company.Picture)
            {
            }
            column(Loan_Product_Type_Name; Loans."Loan Product Type Name")
            {
            }
            column(EmployerCode; Loans."Employer Code")
            {
            }
            column(EmployerName; employername)
            {
            }
            column(AsAtDate; AsAtDate)
            {
            }
            column(Last_Pay_Date; "Last Pay Date")
            {

            }
            column(NoOfDays; NoOfDays)
            {
            }
            column(Requested_Amount; "Requested Amount")
            {
            }

            trigger OnAfterGetRecord()
            begin
                "0Month" := 0;
                "1Month" := 0;
                "2Month" := 0;
                "3Month" := 0;
                Over3Month := 0;
                "Amount Paid" := 0;
                CountDays := 0;
                ExpectedRepayment := 0;
                if Loans."Last Pay Date" <> 0D then
                    NoOfDays := Loans."Last Pay Date" - AsAt
                else
                    NoOfDays := 0;
                if NoOfDays < 0 then NoOfDays := 0;
                if Loans."Outstanding Balance" > 0 then begin

                    case NoOfDays of
                        0:
                            begin
                                "0Month" := Loans."Outstanding Balance";
                                "0MonthC" := "0MonthC" + 1;
                            end;
                        1 .. 30:
                            begin
                                "1Month" := Loans."Outstanding Balance";
                                "1MonthC" := "1MonthC" + 1;
                            end;
                        30 .. 180:
                            begin
                                "2Month" := Loans."Outstanding Balance";
                                "2MonthC" := "2MonthC" + 1;
                            end;
                        180 .. 360:
                            begin
                                "3Month" := Loans."Outstanding Balance";
                                "3MonthC" := "3MonthC" + 1;
                            end;
                        else begin
                            Over3Month := Loans."Outstanding Balance";
                            Over3MonthC := Over3MonthC + 1;
                        end;
                    end;
                end;


                GrandTotal := GrandTotal + Loans."Outstanding Balance";


                if ("1Month" + "2Month" + "3Month" + Over3Month) > 0 then
                    NoLoans := NoLoans + 1;

                if HREmployees.Get(Loans."Relationship Manager") then
                    RelationManager := HREmployees."First Name" + '' + HREmployees."Middle Name" + '' + HREmployees."Last Name"
                else
                    RelationManager := '';


                Cust.Reset;
                Cust.SetRange("No.", Loans."Employer Code");
                if Cust.FindFirst then
                    employername := Cust.Name;
            end;

            trigger OnPreDataItem()
            begin
                company.Get();
                company.CalcFields(Picture);

                CurrReport.CreateTotals("0Month", "1Month", "2Month", "3Month", Over3Month);
                GrandTotal := 0;

                AsAtDate := Loans.GetFilter("Date Filter");
                AsAt := Today;
                if Loans.GetRangeMax("Date Filter") <> 0D then
                    AsAt := Loans.GetRangeMax("Date Filter");
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
            }
        }

        actions
        {
        }
    }

    labels
    {
        /// label(PerformingCaption;"Performing 0 Days"){}
    }

    var
        "1Month": Decimal;
        "2Month": Decimal;
        "3Month": Decimal;
        Over3Month: Decimal;
        ShowLoan: Boolean;
        AsAt: Date;
        LastDueDate: Date;
        DFormula: DateFormula;
        "0MonthC": Integer;
        "1MonthC": Integer;
        "2MonthC": Integer;
        "3MonthC": Integer;
        Over3MonthC: Integer;
        NoLoans: Integer;
        PhoneNo: Text[30];
        Cust: Record Customer;
        "StaffNo.": Text[30];
        Deposits: Decimal;
        GrandTotal: Decimal;
        "0Month": Decimal;
        LoanProduct: Record "Account Closure Line";
        FirstMonthDate: Date;
        EndMonthDate: Date;
        Loans_Aging_Analysis__SASRA_CaptionLbl: label 'Loans Aging Analysis (SASRA)';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Staff_No_CaptionLbl: label 'Staff No.';
        Oustanding_BalanceCaptionLbl: label 'Oustanding Balance';
        PerformingCaptionLbl: label 'Performing';
        V1___30_Days_CaptionLbl: label '(1 - 30 Days)';
        V0_Days_CaptionLbl: label '(0 Days)';
        WatchCaptionLbl: label 'Watch';
        V31___180_Days_CaptionLbl: label '(31 - 180 Days)';
        SubstandardCaptionLbl: label 'Substandard';
        V181___360_Days_CaptionLbl: label '(181 - 360 Days)';
        DoubtfulCaptionLbl: label 'Doubtful';
        Over_360_DaysCaptionLbl: label 'Over 360 Days';
        LossCaptionLbl: label 'Loss';
        TotalsCaptionLbl: label 'Totals';
        CountCaptionLbl: label 'Count';
        Grand_TotalCaptionLbl: label 'Grand Total';
        LossDate: Date;
        CountDays: Integer;
        "Amount Paid": Decimal;
        ExpectedRepayment: Decimal;
        DefaultedAmount: Decimal;
        HREmployees: Record "HR Employees";
        RelationManager: Text;
        company: Record "Company Information";
        EmployerCode: Code[100];
        employername: Text[100];
        AsAtDate: Text[50];
        NoOfDays: Integer;
}
