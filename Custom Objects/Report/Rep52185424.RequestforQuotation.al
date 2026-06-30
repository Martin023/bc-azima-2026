namespace AZIMA.AZIMA;

report 52185424 "Request for Quotation"
{
    Caption = 'Request for Quotation (RFQ)';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'RequestForQuotationLayout.rdlc';

    dataset
    {
        dataitem("Purchase Header"; Microsoft.Purchases.Document."Purchase Header")
        {
            DataItemTableView = WHERE("Document Type" = CONST(Quote));

            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyAddress; CompanyInfo.Address) { }
            column(CompanyAddress2; CompanyInfo."Address 2") { }
            column(CompanyCity; CompanyInfo.City) { }
            column(CompanyPhone; CompanyInfo."Phone No.") { }
            column(CompanyEmail; CompanyInfo."E-Mail") { }
            column(CompanyHomePage; CompanyInfo."Home Page") { }
            column(CompanyLogo; CompanyInfo.Picture) { }

            column(QuoteNo; "No.") { }
            column(DocumentDate; "Document Date") { }
            column(VendorName; Vend.Name) { }
            column(VendorAddress; Vend.Address) { }
            column(VendorAddress2; Vend."Address 2") { }
            column(VendorCity; Vend.City) { }
            column(VendorEmail; Vend."E-Mail") { }
            column(PreparedBy; UserId()) { }

            dataitem("Purchase Line"; Microsoft.Purchases.Document."Purchase Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"),
                               "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                column(ItemNo; "No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(UnitOfMeasure; "Unit of Measure") { }
            }

            trigger OnAfterGetRecord()
            begin
                if not Vend.Get("Buy-from Vendor No.") then
                    Clear(Vend);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("Include Company Logo"; IncludeCompanyLogo)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Company Logo';
                    }
                }
            }
        }
    }

    var
        CompanyInfo: Record Microsoft.Foundation.Company."Company Information";
        Vend: Record Microsoft.Purchases.Vendor.Vendor;
        IncludeCompanyLogo: Boolean;

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;
}