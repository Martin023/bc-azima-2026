report 52187415 "Witheld Tax Obligations On PV"
{
    ApplicationArea = All;
    Caption = 'Witheld Tax Obligations On PV';
    UsageCategory = Lists;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/WitheldTaxObligationsOnPV.rdl';
    dataset
    {
        dataitem(WitheldTaxObligationsOnPV; "Witheld Tax Obligations On PV")
        {
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
            column(PaymentDate; "Payment Date")
            {
            }
            column(PaymentNo; "Payment No.")
            {
            }
            column(VendorNo; "Vendor No.")
            {
            }
            column(VendorName; "Vendor Name")
            {
            }
            column(VendorKRAPIN; "Vendor KRA PIN")
            {
            }
            column(VATwithheldAmount; "VAT withheld Amount")
            {
            }
            column(VATwitholdingTaxcode; "VAT witholding Tax code")
            {
            }
            column(WithholdingTaxAmount; "Withholding Tax Amount")
            {
            }
            column(WithholdingTaxCode; "Withholding Tax Code")
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(InvoceNo; "Invoice No.")
            {
            }
            column(InvoiceDate; "Invoice Date")
            {
            }
            trigger OnpreDataItem()
            begin
                WitheldTaxObligationsOnPV.reset();
                WitheldTaxObligationsOnPV.setrange("Payment Date", StartDate, EndDate);
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

    }

    trigger OnPreReport()
    begin
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address;
        CompanyAddress2 := CompanyInformation."Post Code" + ' ' + CompanyInformation.City + ' ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '.';


        if StartDate = 0D then
            StartDate := 19900101D;
        if EndDate = 0D then
            EndDate := Today;
    end;

    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyAddress2: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        StartDate: Date;
        EndDate: Date;

}
