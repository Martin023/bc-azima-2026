report 52187017 "Parking Report - External"
{
    ApplicationArea = All;
    Caption = 'Parking Report - External';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Parking Report - External.rdl';
    dataset
    {
        dataitem(ParkingSpace; "Parking Space")
        {
            RequestFilterFields = "No.", Client;
            column(AvailableParkingSlots; "Available Parking Slots")
            {
            }
            column(BookingStatus; "Booking Status")
            {
            }
            column(Client; Client)
            {
            }
            column(CreatedBy; "Created By")
            {
            }
            column(Createdat; "Created at")
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
            column(ExternalClientNo; "External Client No.")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(LastPaymentAmount; "Last Payment Amount")
            {
            }
            column(LastPaymentDate; "Last Payment Date")
            {
            }
            column(NewParkingArea; "New Parking Area")
            {
            }
            column(NewParkingAreaAllocated; "New Parking Area Allocated")
            {
            }
            column(NewParkingSlot; "New Parking Slot")
            {
            }
            column(NewParkingSlotNumber; "New Parking Slot Number")
            {
            }
            column(NewVehicleRegistrationNo; "New Vehicle Registration No.")
            {
            }
            column(No; "No.")
            {
            }
            column(ParkingArea; "Parking Area")
            {
            }
            column(ParkingAreaAllocated; "Parking Area Allocated")
            {
            }
            column(ParkingSlot; "Parking Slot")
            {
            }
            column(ParkingSlotNumberAllocated; "Parking Slot Number Allocated")
            {
            }
            column(ReallocationReasons; "Reallocation Reasons")
            {
            }
            column(Realocated; Realocated)
            {
            }
            column(StaffDepartment; "Staff Department")
            {
            }
            column(StaffFullName; "Staff Full Name")
            {
            }
            column(StaffNo; "Staff No.")
            {
            }
            column(StaffPFNumber; "Staff PF Number")
            {
            }
            column(StaffTelephoneNumber; "Staff Telephone Number")
            {
            }
            column(Status; Status)
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
