report 52186831 "Shares, BBF & Risk Analysis"
{
    ApplicationArea = All;
    Caption = 'Shares, BBF & Risk Analysis';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Shares_BBF_Risk_Analysis.rdl';
    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", Status;
            column(No_Members; "No.")
            {
            }
            column(Status_Members; Status)
            {
            }
            column(Filters; Filters)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(CompPic; CompInfo.Picture)
            {
            }
            dataitem(SavingsAccounts; "Savings Accounts")
            {
                DataItemLink = "Member No." = field("No.");
                CalcFields = "Balance (LCY)";
                DataItemTableView = where("Product Category" = filter("Bosa Deposits" | "Benevolent (BBF)" | Risk));
                column(No; "No.")
                {
                }
                column(Name; Name)
                {
                }
                column(MonthlyContribution; "Monthly Contribution")
                {
                }
                column(ExpectedAmount; ExpectedAmount)
                {
                }
                column(ActualAmount; ActualAmount)
                {
                }

                column(ProductCategory_SavingsAccounts; "Product Category")
                {
                }
                column(NoOfCasesReceived; NoOfCasesReceived)
                {

                }
                column(NoOfCasesNotReceived; NoOfCasesNotReceived)
                {

                }

                trigger OnPreDataItem()
                begin
                    SetRange("Date Filter", StartDate, EndDate);
                end;

                trigger OnAfterGetRecord()
                begin
                    ExpectedAmount := NoofMonths * SavingsAccounts."Monthly Contribution";
                    ActualAmount := "Balance (LCY)";
                    NoOfCasesNotReceived := 0;
                    NoOfCasesReceived := 0;
                    if ActualAmount > 0 then
                        NoOfCasesReceived := 1
                    else
                        NoOfCasesNotReceived := 1;

                    /* case "Product Category" of
                        "Product Category"::"Bosa Deposits":
                            begin
                                BosaDepositsExpected := NoofMonths * SavingsAccounts."Monthly Contribution";
                                BosaDepositsActual := "Balance (LCY)";
                                BosaDepositsCount := 1;
                            end;
                        "Product Category"::"Benevolent (BBF)":
                            begin
                                BBFExpected := NoofMonths * SavingsAccounts."Monthly Contribution";
                                BBFActual := "Balance (LCY)";
                                BBFCount := 1;
                            end;
                        "Product Category"::Risk:
                            begin
                                RiskExpected := NoofMonths * "Monthly Contribution";
                                RiskActual := "Balance (LCY)";
                                RiskCount := 1;
                            end;
                    end; */
                end;

            }
            trigger OnPreDataItem()
            begin
                Filters := Members.GetFilters;
                NoofMonths := Round((EndDate - StartDate) / 30, 1, '=');
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
                group(Filters)
                {
                    field(StartDate; StartDate)
                    {
                        Caption = 'Start Date';
                        ApplicationArea = All;
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'End Date';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            if StartDate = 0D then
                                Error('Start Date cannot be empty');
                            if StartDate > EndDate then
                                Error('End Date cannot be less than Start Date');
                        end;
                    }
                }
            }
        }

    }

    trigger OnPreReport()
    begin
        if (StartDate = 0D) or (EndDate = 0D) then
            Error('Start Date and End Date cannot be empty');
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
        StartDate: Date;
        EndDate: Date;
        Filters: Text;
        NoofMonths: Integer;
        BosaDepositsExpected: Decimal;
        BosaDepositsActual: Decimal;
        BBFExpected: Decimal;
        BBFActual: Decimal;
        RiskExpected: Decimal;
        RiskActual: Decimal;
        BosaDepositsCount: Integer;
        BBFCount: Integer;
        RiskCount: Integer;
        ExpectedAmount: Decimal;
        ActualAmount: Decimal;
        NoOfCasesReceived: Decimal;
        NoOfCasesNotReceived: Decimal;

}
