report 52186135 "Shares Commission"

{
    ApplicationArea = All;
    Caption = 'Shares Commission ';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Shares Commission .rdl';

    dataset
    {
        dataitem("Product Variations"; "Product Variations")
        {
            RequestFilterFields = "Recruited by Type", "Recruited By", "Posting Date";
            column(No; "No.")
            {
            }
            column(Posting_Date; "Posting Date")
            {

            }
            column(Effective_Date; "Effective Month")
            {

            }
            column(Amount_Off; "Amount Off")
            {

            }
            column(Recruited_by_Type; "Recruited by Type") { }
            column(RecruitedBy; "Recruited By")
            {
            }
            column(Amount_On; "Amount On")
            {

            }
            column(Product_Type; "Product Type")
            {

            }
            column(Variation_Type; "Variation Type")
            {

            }

            column(RecruitedByName; "Recruited By Name")
            {
            }
            column(RecruitedbyType; "Recruited by Type")
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

                // SavingsAccount.RESET;
                // SavingsAccount.SETRANGE("Member No.", Members."No.");
                // SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"Entrance Fee");
                // if SavingsAccount.Find('-') then begin
                //     SavingsAccount.CalcFields("Balance (LCY)");
                //     AmountContributed := SavingsAccount."Balance (LCY)";
                //     if AmountContributed < SavingsAccount."Monthly Contribution" then
                //         AmountContributed := 0;
                // end;

                // SavingsLedgerEntry.RESET;
                // SavingsLedgerEntry.SETRANGE("Member No.", Members."No.");
                // SavingsLedgerEntry.SetRange(Reversed, FALSE);
                // SavingsLedgerEntry.SetRange("Customer Posting Group", 'REG');
                // if SavingsLedgerEntry.FindLast() then
                //     ContributionDate := SavingsLedgerEntry."Posting Date";
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