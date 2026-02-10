report 52186106 "Unsurrendered Imprest Aging"
{
    Caption = 'Customer Summary Aging Report';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Unsurrendered Imprest Aging.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Account Type", Blocked, "Date Filter";
            CalcFields = "Balance (LCY)", "Last Transaction Date";
            DataItemTableView = where("Account Type" = const("Staff Imprest"), "Balance (LCY)" = filter(> 0));

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
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;

    var
        "0-30 Days Performing (1%)": Decimal;
        "31-90 Days Watch (5%)": Decimal;
        "91-180 Days Substandard (25%)": Decimal;
        "181-360 Days Doubtful (50%)": Decimal;
        "Over 360 Days Loss (100%)": Decimal;
        NoOfDays: Integer;
        MaximumDate: Date;
        Filters: Text;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}


