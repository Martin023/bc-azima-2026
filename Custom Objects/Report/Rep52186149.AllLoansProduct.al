report 52186149 "All Loans Product"
{
    ApplicationArea = All;
    Caption = 'All Loan Products';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/All Loan Products.rdl';
    dataset
    {
        dataitem("Product Factory"; "Product Factory")
        {
            RequestFilterFields = "Product ID";
            column(Product_id; "Product ID")
            {
            }
            column(Product_description; "Product Description")
            {
            }

            column(Product_Class_Type; "Product Class Type")
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
            column(CompPic; CompInfo.Picture)
            {
            }

            trigger OnPreDataItem()
            begin
                "Product Factory".SETRANGE("Product Class Type", "Product Class Type"::Loan);

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
            }
        }

    }

    trigger OnPreReport()
    begin

        if CompInfo.Get then
            CompInfo.CalcFields(CompInfo.Picture);
        CompanyAddress := CompInfo.Address + ' -Post Code: ' + CompInfo."Post Code" + ' -City:' + CompInfo.City + ' Region: ' + CompInfo."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompInfo."Phone No." + ' -Office Tel: ' + CompInfo."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompInfo."E-Mail" + '- Website: ' + CompInfo."Home Page";
    end;

    var
        CompInfo: Record "Company Information";
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;


}
