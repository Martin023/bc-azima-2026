#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185919 "Customer Numbers"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Cust Nos.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; Customer)
        {
            // RequestFilterFields = "Loan No", "Notice Category", "Notice Type", "Header No";
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Counter += 1;
                Customer."Digit Order" := Counter;
                Customer.Modify();
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

        actions
        {
        }
    }

    labels
    {
    }
    trigger OnPreReport()
    begin
        Counter := 0;
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyName := CompanyInformation.Name;
        BuldingName := CompanyInformation."Building Name";
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := CompanyInformation."Phone No." + ',' + CompanyInformation."Phone No. 2";
        CompanyEmail := CompanyInformation."E-Mail";

    end;

    var
        //Columns
        CompanyName: Text;
        BuldingName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;

        CompanyInformation: Record "Company Information";

        Counter: Integer;


}
