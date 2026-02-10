report 52186137 "Change Paypoint Commission"
{
    ApplicationArea = All;
    Caption = 'Change Paypoint Commission Report';
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Change Paypoint Commission Report.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Salary Agreement"; "Salary Agreement")
        {
            //DataItemTableView = where(app = filter(Savings));
            RequestFilterFields = "With Effect From";

            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(No; No)
            {

            }
            column(Amount; Amount)
            {

            }
            column(With_Effect_From; "With Effect From")
            {

            }
            column(Recruited_By; "Recruited By")
            {

            }
            column(Recruited_By_Name; "Recruited By Name")
            {

            }
            column(Recruited_by_Type; "Recruited by Type")
            {

            }
            column(Member_No; "Member No")
            {

            }
            column(Member_Name; "Member Name")
            {

            }
            column(Member_Status; "Member Status")
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
            column(RecruitedBy; "Recruited By")
            {
            }
            column(AmountContributed; AmountContributed)
            {

            }
            column(ContributionDate; ContributionDate)
            {

            }

            trigger OnAfterGetRecord()
            begin
                //Amount_On := 0;
                //Amount_Off := 0;
                Variance := 0;


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
        Variance: decimal;
        Amount_On: Decimal;
        Amount_Off: Decimal;
        Members: Record Members;
        yInt: Integer;
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
