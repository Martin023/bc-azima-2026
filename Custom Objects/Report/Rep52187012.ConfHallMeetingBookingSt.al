report 52187012 "Conf Hall & Meeting Booking St"
{
    ApplicationArea = All;
    Caption = 'Conf Hall & Meeting Booking St';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Conference Hall & Meeting Booking St.rdl';
    dataset
    {
        dataitem(ConferenceMeetingRoomsT; "Conference & Meeting Rooms-T")
        {
            column(StatusoftheBooking; "Status of the Booking")
            {
            }
            column(No; "No.")
            {
            }
            column(NoofAttendees; "No. of Attendees")
            {
            }
            column(SpecialRequirements; "Special Requirements")
            {
            }
            column(StaffclientcompanyDetails; "Staff/client/company Details")
            {
            }
            column(DateofMeetingFunction; "Date of Meeting/Function")
            {
            }
            column(DepartmentClientCompanyName; "Department/Client/Company Name")
            {
            }
            column(DurationofMeetingFucntion; "Duration of Meeting/Fucntion")
            {
            }
            column(StartTimeofMeetingFunction; "Start Time of Meeting/Function")
            {
            }
            column(TypeofMeeting; "Type of Meeting/Function")
            {
            }
            column(Meeting_Room; "Meeting Room")
            {
            }
            column(Amount; Amount)
            {
            }
            CoLUMN(ConfroomNo; ConfroomNo)
            {
            }
            column(ConfroomName; ConfroomName)
            {
            }
            column(ConferenceRoomStatus; ConferenceRoomStatus)
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
                ConferenceAndMeetingRoomList.RESET;
                ConferenceAndMeetingRoomList.SETRANGE("No.", ConferenceMeetingRoomsT."Meeting Room");
                If ConferenceAndMeetingRoomList.find('-') then begin
                    ConfroomNo := ConferenceAndMeetingRoomList."No.";
                    ConfroomName := ConferenceAndMeetingRoomList."Room Name";
                    ConferenceRoomStatus := FORMAT(ConferenceAndMeetingRoomList."Room Status");
                end;

            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
            end;
            //     dataitem("Conf & Meeting Rooms List"; "Conf & Meeting Rooms List")
            // {
            //     column(ConfroomNo; "No.")
            //     {
            //     }
            //     column(ConfroomName; "Room Name")
            //     {
            //     }
            //     column(ConferenceRoomCapacity; "Room Status")
            //     {
            //     }
            //     trigger OnAfterGetRecord()
            //     var
            //         ConfRoomNo: Record "Conf & Meeting Rooms List";
            //     begin
            //         ConfRoomNo.Get("No.");
            //         if ConfRoomNo.Find('-') then begin

            //         end;

            //     end;



            // }
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
        ConferenceAndMeetingRoomList: Record "Conf & Meeting Rooms List";
        ConfroomNo: Code[50];
        ConfroomName: Text[300];
        ConferenceRoomStatus: Text[150];
}
