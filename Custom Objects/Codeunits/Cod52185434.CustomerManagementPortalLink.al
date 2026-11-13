namespace kenpipe.kenpipe;
using Microsoft.Foundation.Company;

codeunit 85434 "Customer Management Portal Url"
{
    trigger OnRun()
    begin
        if CompanyInfo.get() then
            if CompanyInfo."Customer Management Portal Url" <> '' then
                Hyperlink(CompanyInfo."Customer Management Portal Url")
            else
                Message('The Customer Management portal link has not been updated in company information.')
    end;

    var
        CompanyInfo: record "Company Information";
}
