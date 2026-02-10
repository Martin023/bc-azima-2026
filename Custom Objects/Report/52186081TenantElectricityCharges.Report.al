#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186081 "Tenants Electricity Charges"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Tenants Electricity Charges.rdl';

    dataset
    {
        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {
            // RequestFilterFields = "Tenant No.", "Property Name", "Floor No.";
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
            column(No_; "No.")
            {
            }
            column(Description; Description)
            {

            }
            // column(un)
            // {
            // }
            // column(Tenant_Name; "Tenant Name")
            // {
            // }
            // column(Property_Name; "Property Name")
            // {
            // }
            // column(Floor_No_; "Floor No.")
            // {
            // }
            // column(Unit_Code; "Unit Code")
            // {
            // }
            // column(Document_Type; "Document Type")
            // {
            // }

            dataitem("Lease Line"; "Lease Line")
            {
                DataItemLink = "Lease No." = field("No.");

                column(Charge_No_; "Charge No.")
                {

                }
                column(Charge_Name; "Charge Name")
                {

                }
                column(Total_Amount_Inclusive_VAT; "Total Amount Inclusive VAT")
                {

                }
            }

            trigger OnAfterGetRecord()
            begin
                SNo += 1;
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
                // field(ShowTotoDetail; ShowTotoDetail)
                // {
                //     ApplicationArea = Basic;
                //     Caption = 'ShowTotoDetail';
                // }
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
        SNo: Integer;
        ShowTotoDetail: Boolean;
}
