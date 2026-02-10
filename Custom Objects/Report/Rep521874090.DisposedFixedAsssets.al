report 52187422 "Disposed Fixed Assets"
{
    ApplicationArea = All;
    Caption = 'Disposed Fixed Asssets';
    UsageCategory = ReportsAndAnalysis;
    Defaultlayout = rdlc;
    RDLCLayout = './bc-azima-2026/Layout/Disposed Fixed Asssets.rdl';
    dataset
    {
        dataitem(FixedAsset; "Fixed Asset")
        {
            DataItemTableView = where(status = filter(Disposed));

            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyAddress2; CompanyAddress2)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }

            column(AssetNo; "Asset No.")
            {
            }
            column(FAClassCode; "FA Class Code")
            {
            }
            column(Description; Description)
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(FASubclassCode; "FA Subclass Code")
            {
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
        CompanyAddress := CompanyInformation.Address;
        CompanyAddress2 := CompanyInformation."Post Code" + ' ' + CompanyInformation.City + ' ' + CompanyInformation."Country/Region Code";

        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + ' | Website: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyAddress2: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}

