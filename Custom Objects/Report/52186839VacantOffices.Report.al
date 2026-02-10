#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 52186839 "Vacant Offices Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Vacant Offices Report.rdl';

    dataset
    {
        dataitem(Unit; Unit)
        {
            DataItemTableView = where("Unit Status" = filter(Vacant));
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
            column(SCount; SNo)
            {
            }
            column(Property_No_; "Property No.")
            {
            }
            column(Property_Name; "Property Name")
            {
            }
            column(Floor_Code; "Floor Code")
            {
            }
            column(Unit_Code; "Unit Code")
            {
            }
            column(TenantName; TenantName)
            {
            }
            column(TenantNo; TenantNo)
            {

            }
            column(TDate; TDate)
            {
            }
            column(LeaseStatus; LeaseStatus)
            {
            }
            column(Unit_Status; "Unit Status")
            {
            }
            column(Unit_Type_Name; "Unit Type Name")
            {
            }
            column(Area_Square_ft; "Area Square ft")
            {
            }
            column(ShowTotoDetail; ShowTotoDetail)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SNo += 1;

                Lease.Reset();
                Lease.SetRange("Property No.", Unit."Property No.");
                Lease.SetRange("Floor No.", Unit."Floor Code");
                Lease.SetRange("Unit Code", Unit."Unit Code");
                if Lease.FindFirst() then begin
                    TenantNo := Lease."Tenant No.";
                    TenantName := Lease."Tenant Name";
                    TDate := Lease."Expiry Date";
                    Narration := Lease.Narration;
                    LeaseStatus := Lease."Lease Status";
                end;

            end;
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
        SNo: Integer;
        ShowTotoDetail: Boolean;
        Customer: Record Customer;
        Lease: Record Lease;
        TenantName: Text[100];
        TenantNo: Code[100];
        DateVacated: Date;
        TDate: Date;
        Narration: Text[100];
        LeaseStatus: Option;
}
