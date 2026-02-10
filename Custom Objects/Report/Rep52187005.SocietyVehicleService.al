report 52187006 "Society Vehicle Service"
{
    ApplicationArea = All;
    Caption = 'Society Vehicle Service';
    //UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Society Vehicle Service.rdl';
    dataset
    {
        dataitem("Company Vehicles"; "Company Vehicles")
        {
            Column(VehicleNo; "No.")
            {

            }
            column(Registration_No_; "Registration No.")
            {

            }
            // column(CompanyPicture; CompanyInformation.Picture){}
            // column(ConpamyName; CompanyInformation.Name){}
            // column(CompanyAddress; CompanyInformation.Address){}
            // column(CompanyWebsite; CompanyInformation.Website){}
            // column(CompanyEmail; CompanyInformation."E-Mail"){} 
            // column(CompanyPhone; CompanyInformation."Phone No."){}
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

            dataitem(MotorVehicleServicing; "Vehicle Servicing Table")
            {
                DataItemLink = "Registration No." = FIELD("Registration No.");
                //RequestFilterFields = "Registration No.";
                column(ServiceNo; "No.") { }
                column(AssetNo; "Asset No.")
                {
                }
                column(CarRegistrationNumber; "Registration No.")
                {
                }
                // column(Description; Description)
                // {
                // }
                column(ServiceDate; "Service Date")
                {
                }
                // column(Service_Vendor_No_;"Service Vendor No.")
                // {
                // }
                column(Service_Garage_Workshop; "Service Garage/Workshop") { }
                column(Servicedescription; "Service Description")
                {
                }
                column(Supervisor_Name; "Supervisor Name") { }
                column(Supervisor_Staff_No_; "Supervisor Staff No.") { }
                column(Last_service_date; "Last service date") { }
                column(Next_Service_Date; "Next Service Date") { }
                column(Next_Service_Mileage; "Next Service Mileage") { }
                trigger OnAfterGetRecord()
                begin
                    ServiceNo := '';
                    CarRegistrationNumber := '';
                    ServiceDate := 0D;
                    Servicedescription := '';
                    Service_Garage_Workshop := '';
                    Supervisor_Staff_No_ := '';
                    Supervisor_Name := '';
                    Last_service_date := 0D;
                    Next_Service_Mileage := 0;

                    MotorVehicleServicing.Reset();
                    MotorVehicleServicing.SetRange("Registration No.", "Registration No.");
                    if MotorVehicleServicing.Find('-') then begin
                        repeat
                            ServiceNo := MotorVehicleServicing."No.";
                            CarRegistrationNumber := MotorVehicleServicing."Registration No.";
                            ServiceDate := MotorVehicleServicing."Service Date";
                            Servicedescription := MotorVehicleServicing."Service description";
                            Service_Garage_Workshop := MotorVehicleServicing."Service Garage/Workshop";
                            Supervisor_Staff_No_ := MotorVehicleServicing."Supervisor Staff No.";
                            Supervisor_Name := MotorVehicleServicing."Supervisor Name";
                            Last_service_date := MotorVehicleServicing."Service Date";
                            Next_Service_Mileage := MotorVehicleServicing."Next Service Mileage";

                        until MotorVehicleServicing.Next = 0;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    CompanyInformation.Get;
                    CompanyInformation.CalcFields(Picture);
                end;
            }
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
        Customer: Record Customer;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        ServiceNo: CODE[50];
        CarRegistrationNumber: CODE[50];
        ServiceDate: DATE;
        Servicedescription: TEXT[2000];
        Service_Garage_Workshop: TEXT[250];
        Supervisor_Staff_No_: CODE[50];
        Supervisor_Name: CODE[50];
        Last_service_date: DATE;
        Next_Service_Mileage: Decimal;

}
