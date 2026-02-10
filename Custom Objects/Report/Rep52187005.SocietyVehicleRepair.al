report 52187005 "Society Vehicle Repair"
{
    ApplicationArea = All;
    Caption = 'Society Vehicle Repair';
    //UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Society Vehicle Repair.rdl';
    dataset
    {
        dataitem(MaintainMachneVehicles; "Maintain Machne/Vehicles")
        {

            column(AssetNo; "Asset No.")
            {
            }
            column(CarRegistrationNumber; "Registration No.")
            {
            }
            column(DescriptionofRepair; "Description of Repair")
            {
            }
            column(RepairDate; "Repair Date")
            {
            }
            column(RepairCost; "Repair Cost")
            {
            }
            column(RepairGarageWorkshop; "Repair Garage/Workshop")
            {
            }
            column(RepairNo; "No.")
            {
            }
            column(DriverStaffNo; "Driver PF No.")
            {
            }
            column(DriverName; "Driver Name")
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
            trigger OnAfterGetRecord()
            begin

            end;

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
