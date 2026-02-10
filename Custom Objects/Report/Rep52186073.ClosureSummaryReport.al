report 52186073 "Membership Closure Summary"
{
    ApplicationArea = All;
    Caption = 'Membership Closure Summary Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/ClosureSummaryReport.rdl';
    dataset
    {
        dataitem(Date; "Date")
        {
            DataItemTableView = where("Period Type" = const(Month));
            column(PeriodNo; "Period No.")
            {
            }
            column(PeriodName; "Period Name")
            {
            }
            column(PeriodStart; "Period Start")
            {
            }
            column(PeriodType; "Period Type")
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {

            }
            column(CompanyInfoPic; CompanyInfo.Picture)
            {

            }
            column(Year; Year)
            {

            }
            dataitem("Membership Closure"; "Membership Closure")
            {
                DataItemTableView = where(Posted = const(true));
                column(ClosingDate_MembershipClosure; "Closing Date")
                {
                }
                column(ClosureType_MembershipClosure; "Closure Type")
                {
                }
                column(MemberSavings_MembershipClosure; "Member Savings")
                {
                }
                column(TotalLoan_MembershipClosure; "Total Loan")
                {
                }
                column(TotalInterest_MembershipClosure; "Total Interest")
                {
                }
                column(PartialDepositRefundable_MembershipClosure; "Partial Deposit Refundable")
                {
                }
                column(DepositRefundable_MembershipClosure; "Deposit Refundable")
                {
                }
                column(TotalFullDeposits; TotalFullDeposits)
                {
                }
                column(TotalFullLiabilities; TotalFullLiabilities)
                {
                }
                column(TotalFullNetAmount; TotalFullNetAmount)
                {
                }
                column(TotalPartialDeposits; TotalPartialDeposits)
                {
                }
                column(TotalPartialLiabilities; TotalPartialLiabilities)
                {
                }
                column(TotalPartialNetAmount; TotalPartialNetAmount)
                {
                }

                trigger OnPreDataItem()
                begin
                    "Membership Closure".SetRange("Closing Date", Date."Period Start", Date."Period End");
                end;

                trigger OnAfterGetRecord()
                begin
                    TotalPartialDeposits := 0;
                    TotalFullDeposits := 0;
                    TotalPartialLiabilities := 0;
                    TotalFullLiabilities := 0;
                    TotalFullNetAmount := 0;
                    TotalPartialNetAmount := 0;
                    case "Closure Type" of
                        "Closure Type"::"Withdrawal - 1st Partial", "Closure Type"::"Withdrawal - 2nd Partial":
                            begin
                                TotalPartialDeposits := "Membership Closure"."Deposit Refundable";
                                TotalPartialLiabilities := "Membership Closure"."Total Loan";
                                TotalPartialNetAmount := TotalPartialDeposits - TotalPartialLiabilities;
                            end;
                        "Closure Type"::"Withdrawal - Normal":
                            begin
                                TotalFullDeposits := "Membership Closure"."Deposit Refundable";
                                TotalFullLiabilities := "Membership Closure"."Total Loan";
                                TotalFullNetAmount := TotalPartialDeposits - TotalPartialLiabilities;
                            end;
                    end;
                end;
            }
            trigger OnPreDataItem()
            begin
                if Year = 0 then
                    Year := Date2DMY(Today, 3);
                Date.SetRange("Period Start", DMY2Date(1, 1, Year), DMY2Date(31, 12, Year));
            end;
        }

    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(Filters)
                {
                    field(Year; Year)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.CalcFields(Picture);
    end;

    var
        Year: Integer;
        CompanyInfo: Record "Company Information";
        Filters: Text;
        TotalFullDeposits: Decimal;
        TotalFullLiabilities: Decimal;
        TotalFullNetAmount: Decimal;
        TotalPartialDeposits: Decimal;
        TotalPartialLiabilities: Decimal;
        TotalPartialNetAmount: Decimal;


}