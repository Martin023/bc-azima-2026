report 52186062 "Purchase Order"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/Purchase Order.rdl';
    Caption = 'Purchase Order (Azima LPO)';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.";
            RequestFilterHeading = 'Purchase Order';

            column(No_; "No.")
            {
            }
            column(DocumentDate; Format("Document Date", 0, 4))
            {
            }
            column(PaymentTermsCode; "Payment Terms Code")
            {
            }
            column(ShipmentMethodCode; "Shipment Method Code")
            {
            }
            column(BuyFromVendorName; "Buy-from Vendor Name")
            {
            }
            column(VendorAddress_; VendorAddress)
            {
            }
            column(VendorEmail_; VendorEmail)
            {
            }
            column(VendorPhoneNo_; VendorPhoneNo)
            {
            }
            column(VendorKRAPin_; VendorKRAPin)
            {
            }
            column(CompanyName_; CompanyInformation.Name)
            {
            }
            column(CompanyPicture_; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress_; CompanyAddress)
            {
            }
            column(CompanyTelephone_; CompanyTelephone)
            {
            }
            column(CompanyMobile_; CompanyMobile)
            {
            }
            column(CompanyEmailWeb_; CompanyEmailWeb)
            {
            }

            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.") where(Type = filter(<> " "));

                column(LineNo_; LineNoCounter)
                {
                }
                column(ItemNo_; "No.")
                {
                }
                column(Description_; Description)
                {
                }
                column(Description2_; "Description 2")
                {
                }
                column(Quantity_; Quantity)
                {
                }
                column(UnitCost_; "Unit Cost")
                {
                }
                column(LineAmount_; "Line Amount")
                {
                }
                column(LineDiscountAmount_; "Line Discount Amount")
                {
                }
                column(AmountInclVAT_; "Amount Including VAT")
                {
                }
                column(VATAmount_; VATAmount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    // Skip empty/comment lines instead of printing blank rows
                    if ("Line Amount" = 0) and (Quantity = 0) then
                        CurrReport.Skip();

                    LineNoCounter += 1;
                    VATAmount := "Amount Including VAT" - "Line Amount";
                end;

                trigger OnPreDataItem()
                begin
                    LineNoCounter := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Clear(VendorAddress);
                Clear(VendorEmail);
                Clear(VendorPhoneNo);
                Clear(VendorKRAPin);

                if Vendor.Get("Buy-from Vendor No.") then begin
                    VendorEmail := Vendor."E-Mail";
                    VendorPhoneNo := Vendor."Phone No.";
                    VendorKRAPin := Vendor."KRA Pin No.";
                    VendorAddress := DelChr(
                        Vendor.Address + ' ' + Vendor."Address 2" + ', ' + Vendor.City,
                        '>', ' ,');
                end;
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
                // "No." and "Buy-from Vendor No." are auto-added via RequestFilterFields
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
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);

        CompanyAddress := DelChr(
            CompanyInformation.Address + ', ' + CompanyInformation."Post Code" + ' ' + CompanyInformation.City,
            '>', ' ,');
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No.";
        CompanyMobile := CompanyInformation."Phone No. 2";
        CompanyEmailWeb := 'Email: ' + CompanyInformation."E-Mail" + '   Web: ' + CompanyInformation."Home Page";
    end;

    var
        CompanyInformation: Record "Company Information";
        Vendor: Record Vendor;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyMobile: Text;
        CompanyEmailWeb: Text;
        VendorAddress: Text;
        VendorEmail: Text;
        VendorPhoneNo: Text;
        VendorKRAPin: Text;
        VATAmount: Decimal;
        LineNoCounter: Integer;
}