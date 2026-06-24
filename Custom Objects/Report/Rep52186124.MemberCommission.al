namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52186124 "Member Commission"
{
    ApplicationArea = All;
    Caption = 'Member Commission ';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Member Commission .rdl';

    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", "Recruited by Type", "Recruited By", "Date Approved";
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Recruited_by_Type; "Recruited by Type") { }
            column(RecruitedBy; "Recruited By")
            {
            }
            column(RecruitedByName; "Recruited By Name")
            {
            }
            column(RecruitedbyType; "Recruited by Type")
            {
            }
            column(RegistrationDate; "Registration Date")
            {
            }
            column(AmountContributed; AmountContributed) { }
            column(ContributionDate; ContributionDate) { }
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

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                ContributionDate := 0D;
                AmountContributed := 0;

                SavingsAccount.RESET;
                SavingsAccount.SETRANGE("Member No.", Members."No.");
                SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"Entrance Fee");
                if SavingsAccount.Find('-') then begin
                    SavingsAccount.CalcFields("Balance (LCY)");
                    AmountContributed := SavingsAccount."Balance (LCY)";
                    if AmountContributed < SavingsAccount."Monthly Contribution" then
                        AmountContributed := 0;
                end;
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
        myInt: Integer;
        CI: Record "Company Information";
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SavingsAccount: Record "Savings Accounts";
        AmountContributed: Decimal;
        SavingsLedgerEntry: Record "Savings Ledger Entry";
        ContributionDate: Date;

}
