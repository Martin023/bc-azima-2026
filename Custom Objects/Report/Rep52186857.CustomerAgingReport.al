report 52186857 "Customer Summary Aging Report"
{
    Caption = 'Customer Summary Aging Report';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/CustomerSummaryAging.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Account Type", Blocked, "Date Filter";
            CalcFields = "Balance (LCY)", "Last Transaction Date";
            column(No_Customer; "No.")
            {
            }
            column(Name_Customer; Name)
            {
            }
            column(BalanceLCY_Customer; "Balance (LCY)")
            {
            }
            column("Performing"; "0-30 Days Performing (1%)")
            {
            }
            column("Watch"; "31-90 Days Watch (5%)")
            {
            }
            column("Substandard"; "91-180 Days Substandard (25%)")
            {
            }
            column("Doubtful"; "181-360 Days Doubtful (50%)")
            {
            }
            column("Loss"; "Over 360 Days Loss (100%)")
            {
            }
            column(NoOfDays; NoOfDays)
            {
            }
            column(Last_Transaction_Date; "Last Transaction Date")
            {

            }
            column(Filters; Filters)
            {

            }
            column(CompanyInfoName; CompanyInfo.Name)
            {

            }
            column(CompanyInfoPic; CompanyInfo.Picture)
            {

            }

            trigger OnAfterGetRecord()
            begin
                if Customer."Last Transaction Date" = 0D then
                    CurrReport.Skip();
                "0-30 Days Performing (1%)" := 0;
                "31-90 Days Watch (5%)" := 0;
                "91-180 Days Substandard (25%)" := 0;
                "181-360 Days Doubtful (50%)" := 0;
                "Over 360 Days Loss (100%)" := 0;
                NoOfDays := MaximumDate - Customer."Last Transaction Date";
                if NoOfDays < 0 then
                    NoOfDays := 0;
                case NoOfDays of
                    0 .. 30:
                        "0-30 Days Performing (1%)" := Customer."Balance (LCY)"; //* 0.01;
                    31 .. 90:
                        "31-90 Days Watch (5%)" := Customer."Balance (LCY)"; //;* 0.05;
                    91 .. 180:
                        "91-180 Days Substandard (25%)" := Customer."Balance (LCY)"; //* 0.25;
                    181 .. 360:
                        "181-360 Days Doubtful (50%)" := Customer."Balance (LCY)";// * 0.50;
                    else
                        "Over 360 Days Loss (100%)" := Customer."Balance (LCY)";
                end;

            end;

            trigger OnPreDataItem()
            begin
                If Customer.GetFilter("Date Filter") = '' then
                    Customer.SetFilter("Date Filter", '..%1', Today);
                MaximumDate := Customer.GetRangeMax("Date Filter");
                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);
                Filters := Customer.GetFilters;

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
    var
        "0-30 Days Performing (1%)": Decimal;
        "31-90 Days Watch (5%)": Decimal;
        "91-180 Days Substandard (25%)": Decimal;
        "181-360 Days Doubtful (50%)": Decimal;
        "Over 360 Days Loss (100%)": Decimal;
        NoOfDays: Integer;
        MaximumDate: Date;
        Filters: Text;
        CompanyInfo: Record "Company Information";

}
