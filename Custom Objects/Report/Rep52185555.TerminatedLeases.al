report 52185555 "Terminated Leases"
{
    ApplicationArea = All;
    Caption = 'Terminated Leases';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Terminated Leases.rdl';
    dataset
    {
        dataitem(Lease; Lease)
        {
            RequestFilterFields = "No.", "Tenant No.", "Date Registered", "Termination Date";
            DataItemTableView = WHERE(Terminated = CONST(TRUE), "Lease Status" = CONST(Terminated));
            column(No; "No.")
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
            column(Lease_Status; "Lease Status")
            {
            }
            column(ExpiryDate; "Expiry Date")
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
            column(Lease_Commence_Date; "Lease Commence Date")
            {

            }
            column(Property_No_; "Property No.")
            {

            }
            column(Property_Name; "Property Name")
            {

            }
            column(Unit_Type; "Unit Type")
            {

            }
            column(Termination_Date; "Termination Date")
            {

            }
            column(End_Remarks; "End Remarks")
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
