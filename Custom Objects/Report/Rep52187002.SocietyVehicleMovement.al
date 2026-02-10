report 52187002 "Society Vehicle Movement"
{
    ApplicationArea = All;
    Caption = 'Society Vehicle Movement';
    //UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Society Vehicle Movement.rdl';
    dataset
    {
        dataitem(VehicleMovement; "Vehicle Movement")
        {
            column(No; "No.")
            {
            }
            column(Driver_No_; "Driver No.")
            {
            }
            column(Staff_No_; "Driver Staff No.")
            {
            }
            column(Driver_Name; "Name of Driver")
            {
            }

            column(VehicleRegNo; "Vehicle Reg No.")
            {
            }
            column(TotalDistance; "Total Distance")
            {
            }
            column(PurposeofJourney; "Purpose of Journey")
            {
            }
            column(DateofTravel; "Date of Travel")
            {
            }
            column(ApplicationDate; "Application Date")
            {
            }
            column(PurposeofTravel; "Purpose of Travel")
            {
            }
            column(From; From)
            {
            }
            column(NameofDriver; "Name of Driver")
            {
            }
            column(Destination; Destination)
            {
            }
            column(ReturnDate; "Return Date")
            {
            }
            column(Departure_Date; "Departure Date")
            {
            }
            column(Departure_Time; "Departure Time")
            {
            }
            column(DestinationArrivalTime; "Arrival Time")
            {
            }
            column(Outward_Distance; "Outward Distance")
            {
            }
            column(Return_Distance; "Return Distance")
            {
            }
            column(Return_Date; "Return Date")
            {
            }
            column(Milage; "Mileage")
            {
            }
            column(Return_Departure_Time; "Return Departure Time")
            {
            }
            column(ReturnArrivalTime; "Return Arrival Time")
            {
            }
            column(Total_Distance; "Total Distance")
            {
            }

            column(CompanyVehicles_No; "Registration No.")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code; "Global Dimension 2 Code")
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
                //CompanyVehicles.Get(CompanyVehicles."Vehicle Status" = CompanyVehicles."Vehicle Status"::"Active");

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
