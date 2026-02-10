report 52187397 "FA reg addition audit trail"
{
    ApplicationArea = All;
    Caption = 'Fixed Asset Register addition audit trail';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Fixed Asset Register addition audit trail.rdl';
    dataset
    {
        dataitem(FixedAsset; "Fixed Asset")
        {
            DataItemTableView = where(Acquired = filter(true));
            RequestFilterFields = "No.", "Purchase Date", "Purchase Price", "Purchase Vendor/Company", "Global Dimension 2 Code";
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
            column(AssetNo; "No.")
            {
            }
            column(Description; Description)
            {
            }
            column(FAClassCode; "FA Class Code")
            {
            }
            column(VendorNo; "Vendor No.")
            {
            }
            column(VendorName; "Vendor Name")
            {
            }
            column(Purchase_Date; "Purchase Date")
            {
            }
            column(CommunicationOnline; CommunicationOnline)
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            column(PurchasePrice; "Purchase Price")
            {
            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {

            }
            column(Global_Dimension_2_Code; "Global Dimension 2 Code")
            {
            }
            column(No; No)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(FAAdditions; FAAdditions)
            {
            }
            dataitem(FADepreciationBook; "FA Depreciation Book")
            {
                DataItemLink = "FA No." = field("No.");
                column(Depreciation_Starting_Date; "Depreciation Starting Date")
                {

                }
                column(Depreciation_Method; "Depreciation Method")
                {

                }
            }



            trigger OnAfterGetRecord()
            begin
                FAAdditions := 0;
                No += 1;
                // DepreciationBook.reset();
                // DepreciationBook.setrange("FA No.", FixedAsset."No.");
                // if DepreciationBook.findfirst then begin
                FALedgerEntries.reset();
                //FALedgerEntries.setrange("Depreciation Book Code", DepreciationBook."Depreciation Book Code");
                //FALedgerEntries.setrange("Part of Book Value", true);
                FALedgerEntries.SetRange("FA No.", FixedAsset."No.");
                FALedgerEntries.setrange("FA Posting Type", FALedgerEntries."FA Posting Type"::"Acquisition Cost");
                FALedgerEntries.SetFilter("FA Posting Date", '%1..%2', StartDate, EndDate);

                if FALedgerEntries.findfirst then begin
                    FALedgerEntries.calcsums(Amount);
                    FAAdditions := FALedgerEntries.Amount;
                end;
            end;

            trigger OnpreDataItem()
            begin
                if StartDate = 0D then StartDate := 19900101D;
                if EndDate = 0D then EndDate := Today;
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
                group("Date Filter")
                {
                    field("Start Date:"; StartDate)
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = True;
                    }
                    field("End Date:"; EndDate)
                    {
                        ApplicationArea = Basic;
                        ShowMandatory = true;
                    }
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

        No := 0;
        if StartDate = 0D then StartDate := 19900101D;
        if EndDate = 0D then EndDate := Today;
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyAddress2: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        StartDate: Date;
        EndDate: Date;
        No: integer;
        DepreciationBook: record "FA Depreciation Book";
        FALedgerEntries: record "FA Ledger Entry";
        FAAdditions: Decimal;
}
