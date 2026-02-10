#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185605 "Dividend Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Dividend Statement.rdl';

    dataset
    {
        dataitem(DividendProgression; "Dividend Progression")
        {
            RequestFilterFields = Year, "Member No", "Start Date", "End Date";
            column(ReportForNavId_1; 1)
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
            column(StartDate_DividendProgression; DividendProgression."End Date")
            {
            }
            column(ProductType_DividendProgression; DividendProgression."Product Type")
            {
            }
            column(ProductName_DividendProgression; DividendProgression."Product Name")
            {
            }
            column(QualifyingShares_DividendProgression; DividendProgression."Qualifying Shares")
            {
            }
            column(Shares_DividendProgression; DividendProgression.Shares)
            {
            }
            column(GrossDividends_DividendProgression; DividendProgression."Gross Dividends")
            {
            }
            column(WitholdingTax_DividendProgression; DividendProgression."Witholding Tax")
            {
            }
            column(NetDividends_DividendProgression; DividendProgression."Net Dividends")
            {
            }
            column(No_Members; DividendProgression."Member No")
            {
            }
            column(EndDate_DividendProgression; DividendProgression."End Date")
            {
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
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
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        MNo: Code[50];
        MName: Text;
        MPayrollNo: Code[10];
        MIDNumber: Code[10];
        MEmployer: Code[10];
}
