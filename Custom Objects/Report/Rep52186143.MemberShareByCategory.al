namespace MNS.MNS;
using Microsoft.Foundation.Company;

report 52186143 "Member Share By Category"
{
    ApplicationArea = All;
    Caption = 'Member Share By Category';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Member Share By Category.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Members; Members)
        {
            RequestFilterFields = "No.", "Employer Code", Status, Religion;
            column(MemberNo; "No.") { }
            column(MemberName; Name) { }
            column(Age; MemberAge) { }
            column(EmployerCode; "Employer Code") { }
            column(Employer_Name; "Employer Name") { }
            column(Gender; Gender) { }
            column(Religion; Religion) { }
            column(Employment_Designation; "Employment Designation") { }
            column(BOSADeposits; BOSADeposits) { }
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
                BOSADeposits := 0;

                MemberAge := 0;
                Days := 0;

                EmployerName := '';
                if Members."Date of Birth" <> 0D then begin
                    Days := Today - Members."Date of Birth";
                    MemberAge := ROUND((Days / 365.2364), 1, '<') //Denis takes into Account Leap Year
                end
                else
                    MemberAge := 0;

                SavingsAccount.RESET;
                SavingsAccount.SETRANGE("Member No.", Members."No.");
                SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"BOSA Deposits");
                if SavingsAccount.Find('-') then begin
                    SavingsAccount.CalcFields("Balance (LCY)");
                    BOSADeposits := SavingsAccount."Balance (LCY)";
                end
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
                group(GroupName)
                {
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
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;


    Var
        CompanyInformation: Record "Company Information";
        EmployerName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        SavingsAccount: Record "Savings Accounts";
        BOSADeposits: Decimal;
        Days: Integer;
        MemberAge: Integer;
}
