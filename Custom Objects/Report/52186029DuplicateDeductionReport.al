#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186022 "Duplicate Deduction Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Duplicate Deduction Report.rdl';
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
            column(Posting_Date; "Posting Date")
            {

            }

            column(DuplicateProductName; DuplicateProductName)
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
                column(Amount; Amount)
                {

                }
                column(Name; Name)
                {

                }
                column(Product_Code; "Product Code")
                {

                }
                trigger OnAfterGetRecord()
                begin

                    ChckffLines.reset;
                    ChckffLines.SetRange("Member No.", "Checkoff Lines"."Member No.");
                    ChckffLines.SetRange("Account No.", "Checkoff Lines"."Account No.");

                    if not (ChckffLines.Count > 1) then
                        CurrReport.Skip();

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

        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyNam: Text;
        CommunicationOnline: Text;
        Company: Record "Company Information";
        ChckffLines: Record "Checkoff Lines";
        CheckoffPeriod: Date;
        EndDate: Date;
        SavAcc: Record "Savings Accounts";
        CompanyInformation: Record "Company Information";
        ProductSetup: Record "Product Factory";
        DuplicateProductName: Text;
        PostingMonth: Integer;
        PostingYear: Integer;


}
