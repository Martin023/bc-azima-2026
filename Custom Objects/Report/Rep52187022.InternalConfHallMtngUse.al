report 52187022 "Internal Conf Hall & Mtng Use"
{
    ApplicationArea = All;
    Caption = 'Internal Conf Hall & Mtng Use';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-kenpipe-2024/Layout/Internal Conf Hall & Mtng Use.rdl';
    dataset

    {
        dataitem(ConferenceMeetingRoomsT; "Conference & Meeting Rooms-T")
        {
            RequestFilterFields = "Type of Meeting/Function";
            column(No; "No.")
            {
            }
            column(DateofMeetingFunction; "Date of Meeting/Function")
            {
            }

            column(DepartmentClientCompanyName; "Department/Client/Company Name")
            {
            }
            // column(DurationofMeetingFucntion; "Duration of Meeting/Fucntion")
            // {
            // }
            column(Duration_of_Meeting_Fucntion; "Duration of Meeting/Fucntion")
            {
            }
            column(Address; Address)
            {
            }
            column(Contact_Person; "Contact Person")
            {
            }
            column(Contact_No_; "Contact No.")
            {
            }

            column(NoofAttendees; "No. of Attendees")
            {
            }
            column(SpecialRequirements; "Special Requirements")
            {
            }
            column(Amount; Amount)
            {
            }
            // column(ClientDetails; "Staff/client/company Details")
            // {
            // }
            // column(StaffClientCompanyName; "Department/Client/Company Name")
            // {
            // }
            column(StartTimeofMeetingFunction; "Start Time of Meeting/Function")
            {
            }
            column(Meeting_Room; "Meeting Room")
            {

            }
            column(Meeting_Room_Name; "Meeting Room Name")
            {
            }
            column(Department; Department)
            {
            }

            column(Status; Status)
            {
            }
            column(StatusoftheBooking; "Status of the Booking")
            {
            }
            // column(TypeofMeetingFunction; "Type of Meeting/Function")
            // {
            // }
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
            }
            column(Staff_Requesting; "Staff Requesting")
            {
            }
            column(Staff_Name; "Staff Name")
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
