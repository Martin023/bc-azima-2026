report 52185427 "Available Parking Slots"
{
    ApplicationArea = All;
    Caption = 'Available Parking Slots';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Available Parking Slots.rdl';
    dataset
    {
        dataitem(ParkingListTable; "Parking List Table")
        {
            RequestFilterFields = No, "Parking Slot Status";
            // DataItemTableView = "Parking Slot Status" = CONST (Available);
            column(AvailableB1; "Available B1")
            {
            }
            column(AvailableB2; "Available B2")
            {
            }
            column(AvailableB3; "Available B3")
            {
            }
            column(ParkingArea; "Parking Area")
            {
            }
            column(ParkingSlotNumber; "Parking Slot Number")
            {
            }
            column(ParkingSlotStatus; "Parking Slot Status")
            {
            }
            column(No; No)
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
