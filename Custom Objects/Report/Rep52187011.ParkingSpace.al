report 52187011 "Parking Space"
{
    ApplicationArea = All;
    Caption = 'Parking Space - Internal';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Parking Space.rdl';
    dataset
    {
        dataitem(ParkingSpace; "Parking Space")
        {
            RequestFilterFields = Client;
            column(Client; Client) { }
            //column(ParkingNo; "No.") { }
            column(Staff_No_; "Staff No.") { }
            column(Staff_PF_Number; "Staff PF Number") { }
            column(Vehicle_Registration_No_; "Vehicle Registration No.") { }

            column(AvailableParkingSlots; "Available Parking Slots")
            {
            }
            column(ExpectedPaymentamounts; "Expected Payment amounts")
            {
            }
            column(ExpectedPyamentDate; "Expected Pyament Date")
            {
            }
            column(ExternalClientDetails; "External Client Details")
            {
            }
            column(LastPaymentAmount; "Last Payment Amount")
            {
            }
            column(LastPaymentDate; "Last Payment Date")
            {
            }
            column(No; "No.")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(ParkingAreaAllocated; "Parking Area Allocated")
            {
            }
            column(ParkingSlotNumberAllocated; "Parking Slot Number Allocated")
            {
            }
            column(StaffDepartment; "Staff Department")
            {
            }
            column(StaffFullName; "Staff Full Name")
            {
            }
            column(StaffTelephoneNumber; "Staff Telephone Number")
            {
            }
            column(TenantPaymentSchedule; "Tenant Payment Schedule")
            {
            }
            column(VehicleRegistrationNo; "Vehicle Registration No.")
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


    var
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
