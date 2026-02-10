#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
report 52186052 "Employer Comparison Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Employer Comparison.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Checkoff Header"; "Checkoff Header")
        {
            DataItemTableView = where(Posted = const(true));
            RequestFilterFields = "Employer Code", "Document No.";
            column(No_; "No.")
            {
            }
            column(Date_Entered; "Date Entered")
            {
            }
            column(Entered_By; "Entered By")
            {

            }
            column(Description; Description)
            {

            }
            column(Document_No_; "Document No.")
            {

            }
            column(Posting_Period; "Posting Period")
            {
            }
            column(Posted; Posted)
            {
            }
            column(Amount; Amount)
            {

            }
            column(Posting_Date; "Posting Date")
            {

            }
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
            dataitem("Checkoff Lines"; "Checkoff Lines")
            {
                DataItemLink = "Checkoff Header" = field("No.");

                column(Member_No_; "Member No.")
                {

                }
                column(AmountLines; Amount)
                {

                }
                column(Name; Name)
                {

                }
                column(Product_Code; "Product Code")
                {

                }
                column(ExpShares; ExpShares)
                {

                }
                column(ExpBBF; ExpBBF)
                {

                }
                column(ExpRisk; ExpRisk)
                {

                }
                column(ExpLoanRepay; ExpLoanRepay)
                {

                }
                column(Employer_Code; "Employer Code")
                {

                }
                column(CustName; CustName)
                {

                }
                trigger OnAfterGetRecord()
                begin

                    Customer.Reset();
                    Customer.SetRange("No.", "Checkoff Lines"."Employer Code");
                    if Customer.FindFirst() then
                        CustName := Customer.Name;

                    SavAcc.Reset();
                    SavAcc.SetRange("No.", "Checkoff Lines"."Account No.");
                    SavAcc.SetRange("Employer Code", "Checkoff Lines"."Employer Code");
                    SavAcc.SetRange("Product Category", SavAcc."Product Category"::"BOSA Deposits");
                    if SavAcc.FindFirst() then begin
                        ExpShares := SavAcc."Monthly Contribution";
                        if ExpShares = 0 then begin
                            ProductSetup.Reset();
                            ProductSetup.SetRange("Product Category", ProductSetup."Product Category"::"BOSA Deposits");
                            if ProductSetup.FindFirst() then
                                ExpShares := ProductSetup."Minimum Contribution";
                        end;
                        Prorata := CustomCuesCodeunit.Prorata(SavAcc."No.", '1');
                        if Prorata > ExpShares then
                            ExpShares := Prorata
                        else
                            ExpShares += ExpShares;

                    end;

                    SavAcc.Reset();
                    SavAcc.SetRange("No.", "Checkoff Lines"."Account No.");
                    SavAcc.SetRange("Employer Code", "Checkoff Lines"."Employer Code");
                    SavAcc.SetRange("Product Category", SavAcc."Product Category"::"Benevolent (BBF)");
                    if SavAcc.FindFirst() then begin
                        ExpBBF := SavAcc."Monthly Contribution";
                        if ExpBBF = 0 then begin
                            ProductSetup.Reset();
                            ProductSetup.SetRange("Product Category", ProductSetup."Product Category"::"Benevolent (BBF)");
                            if ProductSetup.FindFirst() then
                                ExpBBF += ProductSetup."Minimum Contribution";
                        end;
                    end;


                    SavAcc.Reset();
                    SavAcc.SetRange("No.", "Checkoff Lines"."Account No.");
                    SavAcc.SetRange("Employer Code", "Checkoff Lines"."Employer Code");
                    SavAcc.SetRange("Product Category", SavAcc."Product Category"::Risk);
                    if SavAcc.FindFirst() then begin
                        ExpRisk := SavAcc."Monthly Contribution";
                        if ExpRisk = 0 then begin
                            ProductSetup.Reset();
                            ProductSetup.SetRange("Product Category", ProductSetup."Product Category"::Risk);
                            if ProductSetup.FindFirst() then
                                ExpRisk += ProductSetup."Minimum Contribution";
                        end;
                    end;

                    Loans.Reset();
                    Loans.SetRange("Loan No.", "Checkoff Lines"."Loan No.");
                    Loans.SetRange("Employer Code", "Checkoff Lines"."Employer Code");
                    if Loans.FindFirst() then begin
                        ExpLoanRepay += Loans.Repayment;
                    end;

                end;
            }

        }

    }


    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(StartDate; CheckoffPeriod)
                {
                    Caption = 'Checkoff Period';
                    TableRelation = "Interest Due Period"."Interest Due Date";
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
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
        CustName: Text[100];
        Customer: Record Customer;
        ExpLoanRepay: Decimal;
        Loans: Record Loans;

        ExpRisk: Decimal;
        ExpBBF: Decimal;
        CustomCuesCodeunit: Codeunit CustomCuesCodeunit;
        Prorata: Decimal;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyNam: Text;
        CommunicationOnline: Text;
        Company: Record "Company Information";
        ChckffLines: Record "Checkoff Lines";
        CheckoffPeriod: Date;
        SavAcc: Record "Savings Accounts";
        CompanyInformation: Record "Company Information";
        ProductSetup: Record "Product Factory";
        ExpShares: Decimal;

}
