namespace KenpipeCBS.KenpipeCBS;
using Microsoft.Foundation.Company;

codeunit 52185429 "Members Portal Link"
{
    trigger OnRun()
    begin
        if CompanyInfo.get() then
            if CompanyInfo."Members Portal Link" <> '' then
                Hyperlink(CompanyInfo."Members Portal Link")
            else
                Message('The members portal link has not been updated in company information.')
    end;

    var
        CompanyInfo: record "Company Information";
}
