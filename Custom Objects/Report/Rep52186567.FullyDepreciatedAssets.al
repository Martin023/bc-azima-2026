report 52186567 "Fully Depreciated Assets"
{
    ApplicationArea = All;
    Caption = 'Fully Depreciated Assets';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = Rdlc;
    RDLCLayout = './bc-azima-2026/Layout/Fully Depreciated Assets.rdl';
    dataset
    {
        dataitem(FixedAsset; "Fixed Asset")
        {
            DataItemTableView = where(Acquired = filter(true));

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
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(AssetNo; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(FALocationCode; "FA Location Code")
            {
            }
            column(FALocationName; FALocationName)
            {
            }
            column(Acquired; Acquired)
            {
            }
            column(PurchaseDate; AcquisitionDate)
            {
            }
            column(Asset_Tag; "Asset Tag")
            {
            }
            column(BookValue; BookValue)
            {
            }
            trigger OnAfterGetRecord()
            begin
                FALocationName := '';

                DepreciationBook.reset;
                DepreciationBook.SetRange("FA No.", FixedAsset."No.");
                IF DepreciationBook.Find('-') then
                    DepreciationBook.CalcFields("Book Value");
                if DepreciationBook."Book Value" <> 0 then
                    currreport.skip;
                BookValue := DepreciationBook."Book Value";
                AcquisitionDate := DepreciationBook."Acquisition Date";

                FALocation.RESET;
                FALocation.SETRANGE("Code", FixedAsset."FA Location Code");
                if FALocation.FINDFIRST then
                    FALocationName := FALocation."Name";
            end;
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
        DepreciationBook: Record "FA Depreciation Book";
        BookValue: Decimal;
        FALocation: Record "FA Location";
        FALocationName: Text;
        AcquisitionDate: Date;
}
