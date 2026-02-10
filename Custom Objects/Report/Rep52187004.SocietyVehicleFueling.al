report 52187004 "Society Vehicle Fueling"
{
    ApplicationArea = All;
    Caption = 'Society Vehicle Fueling';
    //UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Society Vehicle Fueling.rdl';

    dataset
    {
        dataitem(HRFuelManagementHeader; "HR Fuel Management Header")
        {
            column(No_; "No.")
            {
            }
            column(VehicleNo; "Vehicle No.")
            {
            }
            column(Vehicle_Registration_No_; "Vehicle Registration No.")
            {
            }
            column(Name_Vehicle; "Name Vehicle")
            {
            }
            column(Vehicle_Type; "Type of Vehicle")
            {
            }
            column(DriverPFNo; "Driver Staff No.")
            {
            }
            column(Driver_No_; "Driver No.")
            {
            }
            column(Driver_Name; "Driver Name")
            {
            }
            column(Type_Of_Payment; "Type Of Payment")
            {
            }
            column(Fuel_Type; "Fuel Type")
            {
            }
            column(Date_of_Fuleing; "Date of Fueling")
            {
            }
            column(Fuel_Balance; "Fuel Balance")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(Cost; Cost)
            {
            }
            column(Motor_Vehicle_Fuel_Ceiling; "Motor Vehicle Fuel Ceiling")
            {
            }
            column(Petrol_Station_Name; "Petrol Station Name")
            {
            }
            column(Fuel_Card_Number; "Card No")
            {
            }
            column(Cash_Paid; "Cash Paid")
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
        Customer: Record Customer;
        EmployerName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
}
