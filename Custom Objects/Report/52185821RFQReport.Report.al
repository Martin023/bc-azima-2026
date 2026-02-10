#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52185821 "RFQ Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/RFQ Report.rdl';

    dataset
    {
        dataitem(QuotationRequestVendorsii; "Quotation Request Vendors")
        {
            RequestFilterFields = "Requisition Document No.";
            column(ReportForNavId_4; 4)
            {
            }
            column(DocumentType_QuotationRequestVendorsii; QuotationRequestVendorsii."Document Type")
            {
            }
            column(RequisitionDocumentNo_QuotationRequestVendorsii; QuotationRequestVendorsii."Requisition Document No.")
            {
            }
            column(VendorNo_QuotationRequestVendorsii; QuotationRequestVendorsii."Vendor No.")
            {
            }
            column(VendorName_QuotationRequestVendorsii; QuotationRequestVendorsii."Vendor Name")
            {
            }
            column(VendorAddress2; QuotationRequestVendorsii.Address)
            {
            }
            column(VCity; QuotationRequestVendorsii.City)
            {
            }
            column(Vphone; QuotationRequestVendorsii."Phone number")
            {
            }
            column(VPostalCode; QuotationRequestVendorsii."Postal Code")
            {
            }
            dataitem("Purchase Quote Header"; "Purchase Quote Header")
            {
                DataItemLink = "No." = field("Requisition Document No.");
                column(ReportForNavId_1102755000; 1102755000)
                {
                }
                column(No_PurchaseQuoteHeader; "Purchase Quote Header"."No.")
                {
                }
                column(ShiptoCode_PurchaseQuoteHeader; "Purchase Quote Header"."Ship-to Code")
                {
                }
                column(ShiptoName_PurchaseQuoteHeader; "Purchase Quote Header"."Ship-to Name")
                {
                }
                column(ShiptoAddress_PurchaseQuoteHeader; "Purchase Quote Header"."Ship-to Address")
                {
                }
                column(LocationCode_PurchaseQuoteHeader; "Purchase Quote Header"."Location Code")
                {
                }
                column(ShortcutDimension1Code_PurchaseQuoteHeader; "Purchase Quote Header"."Shortcut Dimension 1 Code")
                {
                }
                column(ShortcutDimension2Code_PurchaseQuoteHeader; "Purchase Quote Header"."Shortcut Dimension 2 Code")
                {
                }
                column(PostingDescription_PurchaseQuoteHeader; "Purchase Quote Header"."Posting Description")
                {
                }
                column(ExpectedClosingDate_PurchaseQuoteHeader; "Purchase Quote Header"."Expected Closing Date")
                {
                }
                column(CompayInfoName; CompanyInfo.Name)
                {
                }
                column(CompayInfoPicture; CompanyInfo.Picture)
                {
                }
                column(PostingDate_PurchaseQuoteHeader; "Purchase Quote Header"."Posting Date")
                {
                }
                column(ReleasedBy_PurchaseQuoteHeader; "Purchase Quote Header"."Released By")
                {
                }
                column(ReleaseDate_PurchaseQuoteHeader; "Purchase Quote Header"."Release Date")
                {
                }
                column(ExpiryDate; "Purchase Quote Header"."Tender Expiry Date")
                {
                }
                column(Reference; "Purchase Quote Header".Reference)
                {
                }
                //dataitem(52185930;52185930)
                // dataitem(QuotationRequestVendors; "Quotation Request Vendors")
                // {
                //     DataItemLink = "Document Type" = field("Document Type"), "Requisition Document No." = field("No.");
                //     column(ReportForNavId_1102755001; 1102755001)
                //     {
                //     }
                //     column(VendorNo_QuotationRequestVendors; "Quotation Request Vendors"."Vendor No.")
                //     {
                //     }
                //     column(VendorName_QuotationRequestVendors; "Quotation Request Vendors"."Vendor Name")
                //     {
                //     }

                //     trigger OnAfterGetRecord()
                //     begin
                //         Vendor.Get("Quotation Request Vendors"."Vendor No.");
                //     end;
                // }
                // dataitem(52185927;52185927)
                // {
                //     DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                //     column(ReportForNavId_1102755002; 1102755002)
                //     {
                //     }
                //     column(Type_PurchaseQuoteLine; "Purchase Quote Line".Type)
                //     {
                //     }
                //     column(No_PurchaseQuoteLine; "Purchase Quote Line"."No.")
                //     {
                //     }
                //     column(Description_PurchaseQuoteLine; "Purchase Quote Line".Description)
                //     {
                //     }
                //     column(UnitofMeasure_PurchaseQuoteLine; "Purchase Quote Line"."Unit of Measure")
                //     {
                //     }
                //     column(Quantity_PurchaseQuoteLine; "Purchase Quote Line".Quantity)
                //     {
                //     }
                //     column(LineNo_PurchaseQuoteLine; "Purchase Quote Line"."Line No.")
                //     {
                //     }
                //     column(Purchase_Quote_LineUnit_Price; "Purchase Quote Line"."Unit Price (LCY)")
                //     {
                //     }
                //     column(RFNo; "Purchase Quote Line"."PRF No")
                //     {
                //     }
                // }
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        Vendor: Record Vendor;
        QuotationRequestVendors: Record "Quotation Request Vendors";
}
