report 52186132 "Sub Accounts Commission"
{
    ApplicationArea = All;
    Caption = 'Sub Accounts Commission ';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Sub Accounts Commission .rdl';

    dataset
    {
        dataitem("Savings Account Application"; "Savings Account Application")
        {
            RequestFilterFields = "No.", "Recruited by Type", "Recruited By", "Registration Date";
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Phone_No_; "Phone No.")
            {

            }
            column(Recruited_by_Type; "Recruited by Type")
            {

            }
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
            column(AmountContributed; AmountContributed)
            {

            }
            column(ContributionDate; ContributionDate)
            {

            }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(Application_Date; "Application Date")
            {

            }
            column(Account_Category; "Account Category")
            {

            }
            column(Account_Type; "Account Type")
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
            column(Member_No_; "Member No.")
            {

            }
            // dataitem(Members; Members)
            // {
            //     RequestFilterFields = "No.";
            //     DataItemLink = "No." = field("No.");

            //     column(No_;"No.")
            //     {

            //     }
            // }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                ContributionDate := 0D;
                AmountContributed := 0;
                /*
                                SavingsAccount.RESET;
                                SavingsAccount.SETRANGE("Member No.", "Member No.");
                                SavingsAccount.SetRange("Product Category", SavingsAccount."Product Category"::"Entrance Fee");
                                if SavingsAccount.Find('-') then begin
                                    SavingsAccount.CalcFields("Balance (LCY)");
                                    AmountContributed := SavingsAccount."Balance (LCY)";
                                    if AmountContributed < SavingsAccount."Monthly Contribution" then
                                        AmountContributed := 0;
                                end;

                                SavingsLedgerEntry.RESET;
                                SavingsLedgerEntry.SETRANGE("Member No.", "Member No.");
                                SavingsLedgerEntry.SetRange(Reversed, FALSE);
                                SavingsLedgerEntry.SetRange("Customer Posting Group", 'REG');
                                if SavingsLedgerEntry.FindLast() then
                                    ContributionDate := SavingsLedgerEntry."Posting Date";
                                    */
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
