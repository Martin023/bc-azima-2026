report 52187003 "Society Vehicle Request"
{
    ApplicationArea = All;
    Caption = 'Society Vehicle Request';
    //UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Society Vehicle Request.rdl';
    dataset
    {
        dataitem(MotorVehicleRequest; "Motor Vehicle Request")
        {
            column(No; "No.") { }
            column(Destination; Destination) { }
            column(Type_of_Travel; "Type of Travel") { }
            column(Driver_Name; "Driver Name") { }
            column(No_of_Staff_Traveling; "No. of Staff Traveling") { }
            column(Date_of_Request; "Date of Request") { }
            column(Date_of_Vehicle_Use; "Date of Travel") { }
            column(Vehicle_Purpose; "Vehicle Purpose") { }
            column(Driver_PF_No_; "Driver Staff No.") { }
            column(Driver_Staff_Name; "Driver Name") { }
            column(Allocated_Vehicle; "Allocated Vehicle") { }
            column(Registration_No_; "Registration No.") { }
            //StaffDetails
            column(Staff_PF_No_; "Staff No.") { }
            column(Travelling_Staff_Name; "Staff Name") { }
            column(Staff_Department; "Department Name") { }
            //Department
            column(Department_Name; "Department Name") { }
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
                //CompanyVehicles.Get(CompanyVehicles."Vehicle Status" = CompanyVehicles."Vehicle Status"::"Active");

                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
            end;

            trigger OnAfterGetRecord()
            begin
                if MotorVehicleRequest."No." <> '' then begin

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
