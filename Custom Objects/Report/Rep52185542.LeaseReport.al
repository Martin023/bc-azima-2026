report 52185542 "Lease Report"
{
    ApplicationArea = All;
    Caption = 'Lease Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Lease Report.rdl';
    dataset
    {
        dataitem(Lease; Lease)
        {
            RequestFilterFields = "No.", "Tenant No.", "Property No.", "Lease Status";
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
            column(Unit_Type; "Unit Type")
            {

            }
            column(Property_No_; "Property No.")
            {

            }
            column(Property_Name; "Property Name")
            {

            }
            column(Date_Renewed; "Date Renewed")
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
            column(Lease_Status; "Lease Status")
            {
            }
            column(Termination_Date; "Termination Date")
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

            trigger OnAfterGetRecord()
            begin
                MonthstoExpire := 0;
                ExpiryDate := Lease."Expiry Date";
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
        MonthstoExpire: Integer;
        ExpiryDate: DATE;
}
