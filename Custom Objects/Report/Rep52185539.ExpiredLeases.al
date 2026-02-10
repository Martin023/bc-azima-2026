report 52185539 "Expired Leases"
{
    ApplicationArea = All;
    Caption = 'Expired Leases';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Expired Leases.rdl';
    dataset
    {
        dataitem(Lease; Lease)
        {
            //DataItemTableView = where(Expired = CONST(TRUE));
            DataItemTableView = WHERE(Status = CONST(Approved), "Lease Status" = Const(Expired));
            RequestFilterFields = "No.";
            column(No; "No.")
            {
            }
            column(Lease_Status; "Lease Status")
            {
            }
            column(TenantNo; "Tenant No.")
            {
            }
            column(TenantName; "Tenant Name")
            {
            }
            column(UnitCode; "Unit Code")
            {
            }
            column(UnitDescription; "Unit Description")
            {
            }
            column(Areasquareft; "Area square ft")
            {
            }
            column(DateRegistered; "Date Registered")
            {
            }
            column(EscalationForLeases; "Escalation For Leases")
            {
            }
            column(EscalationFrequency; "Escalation Frequency")
            {
            }
            column(Expired; Expired)
            {
            }
            column(ExpiryDate; "Expiry Date")
            {
            }
            column(Lease_Commence_Date; "Lease Commence Date")
            {
            }
            column(FloorNo; "Floor No.")
            {
            }
            column(FloorName; "Floor Name")
            {
            }
            column(LeasePeriod; "Lease Period")
            {
            }
            column(Terminated; Terminated)
            {
            }
            column(Property_Name; "Property Name")
            {

            }
            column(Unit_Type; "Unit Type")
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
            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
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
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;


    Var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
