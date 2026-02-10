namespace MNS.MNS;
using System.Environment;
using System.Utilities;
using Microsoft.Foundation.Company;

report 52186076 "Conference Booking Calendar"
{
    ApplicationArea = All;
    Caption = 'Conference Booking Calendar';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './bc-azima-2026/Layout/Conference Booking Calendar.rdl';
    // DefaultLayout = Word;
    // WordLayout = './bc-azima-2026/Layout/Conference Booking Calendar.docx';

    dataset
    {
        dataitem(DateVirtual; 2000000007)
        {
            column(VirtualStartDate; "Period Start") { }
            column(Period_Name; "Period Name") { } //Day of the week name
            column(Period_Type; "Period Type") { }
            column(Period_No_; "Period No.") { } //Day of the week No.
            column(Period_End; "Period End") { }
            column(Dayoftheweek; Dayoftheweek) { }
            dataitem(ConferenceMeetingRoomsT; "Conference & Meeting Rooms-T")
            {
                DataItemTableView = where(Status = Const(Approved));
                DataItemLinkReference = DateVirtual;
                DataItemLink = "Date of Meeting/Function" = field("Period Start");
                column(No; "No.")
                {
                }
                column(MeetingRoom; "Meeting Room")
                {
                }
                column(MeetingRoomName; "Meeting Room Name")
                {
                }
                column(TypeofMeetingFunction; "Type of Meeting/Function")
                {
                }
                column(Status; Status)
                {
                }
                column(ContactPerson; "Contact Person")
                {
                }
                column(ContactNo; "Contact No.")
                {
                }
                column(DateofMeetingFunction; "Date of Meeting/Function")
                {
                }
                column(Department; Department)
                {
                }
                column(OriginatingDepartment; "Originating Department")
                {
                }
                column(RoomName; "Room Name")
                {
                }
                column(RoomStatus; "Room Status")
                {
                }
                column(SpecialRequirements; "Special Requirements")
                {
                }
                column(StaffName; "Staff Name")
                {
                }
                column(StaffRequesting; "Staff Requesting")
                {
                }
                column(StaffclientcompanyDetails; "Staff/client/company Details")
                {
                }
                column(StartTimeofMeetingFunction; "Start Time of Meeting/Function")
                {
                }
                column(StatusoftheBooking; "Status of the Booking")
                {
                }
                column(DepartmentClientCompanyName; "Department/Client/Company Name")
                {
                }
                column(DurationofMeetingFucntion; "Duration of Meeting/Fucntion")
                {
                }
                column(NoofAttendees; "No. of Attendees")
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
                column(StartDate; StartDate) { }
                column(EndDate; EndDate) { }
                //column(TypeofMeeting; TypeofMeeting) { }
                column(Requester; Requester) { }
                column(RequesterName; RequesterName) { }
                column(Year; Year) { }
                column(Month; Month) { }
                column(FormatedMonth; FormatedMonth) { }
                // trigger OnAfterGetRecord()
                // var
                //     myInt: Integer;
                // begin

                // TypeofMeeting := ' ';
                // RequesterName := ' ';
                // Requester := ' ';
                // Year := 0;
                // FormatedMonth := ' ';

                // Month := Date2DMY(ConferenceMeetingRoomsT."Date of Meeting/Function", 2);
                // Year := Date2DMY(ConferenceMeetingRoomsT."Date of Meeting/Function", 3);

                // IF Month = 1 THEN FormatedMonth := 'Jan';
                // IF Month = 2 THEN FormatedMonth := 'Feb';
                // IF Month = 3 THEN FormatedMonth := 'Mar';
                // IF Month = 4 THEN FormatedMonth := 'Apr';
                // IF Month = 5 THEN FormatedMonth := 'May';
                // IF Month = 6 THEN FormatedMonth := 'June';
                // IF Month = 7 THEN FormatedMonth := 'July';
                // IF Month = 8 THEN FormatedMonth := 'Aug';
                // IF Month = 9 THEN FormatedMonth := 'Sept';
                // IF Month = 10 THEN FormatedMonth := 'Oct';
                // IF Month = 11 THEN FormatedMonth := 'Nov';
                // IF Month = 12 THEN FormatedMonth := 'Dec';

                // if ConferenceMeetingRoomsT."Type of Meeting/Function" = "Type of Meeting/Function"::External then begin
                //     //TypeofMeeting := 'External';
                //     Requester := ConferenceMeetingRoomsT."Department/Client/Company Name";
                //     RequesterName := ConferenceMeetingRoomsT."Contact Person";
                // end
                // else
                //     if ConferenceMeetingRoomsT."Type of Meeting/Function" = "Type of Meeting/Function"::Internal then begin
                //         Requester := ConferenceMeetingRoomsT.Department + ' ' + 'Department';
                //         RequesterName := ConferenceMeetingRoomsT."Staff Name";
                //     end;
                //end;
                //}
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;

                begin
                    TypeofMeeting := ' ';
                    RequesterName := ' ';
                    Requester := ' ';
                    Year := 0;
                    FormatedMonth := ' ';

                    // Month := Date2DMY(ConferenceMeetingRoomsT."Date of Meeting/Function", 2);
                    // Year := Date2DMY(ConferenceMeetingRoomsT."Date of Meeting/Function", 3);

                    Month := Date2DMY(DateVirtual."Period Start", 2);
                    Year := Date2DMY(DateVirtual."Period Start", 3);

                    //if ConferenceMeetingRoomsT."Date of Meeting/Function" = DateVirtual."Period Start" then begin
                    IF Month = 1 THEN FormatedMonth := 'Jan';
                    IF Month = 2 THEN FormatedMonth := 'Feb';
                    IF Month = 3 THEN FormatedMonth := 'Mar';
                    IF Month = 4 THEN FormatedMonth := 'Apr';
                    IF Month = 5 THEN FormatedMonth := 'May';
                    IF Month = 6 THEN FormatedMonth := 'June';
                    IF Month = 7 THEN FormatedMonth := 'July';
                    IF Month = 8 THEN FormatedMonth := 'Aug';
                    IF Month = 9 THEN FormatedMonth := 'Sept';
                    IF Month = 10 THEN FormatedMonth := 'Oct';
                    IF Month = 11 THEN FormatedMonth := 'Nov';
                    IF Month = 12 THEN FormatedMonth := 'Dec';

                    if ConferenceMeetingRoomsT."Type of Meeting/Function" = ConferenceMeetingRoomsT."Type of Meeting/Function"::External then begin
                        //TypeofMeeting := 'External';
                        Requester := ConferenceMeetingRoomsT."Department/Client/Company Name";
                        RequesterName := ConferenceMeetingRoomsT."Contact Person";
                    end
                    else
                        if ConferenceMeetingRoomsT."Type of Meeting/Function" = ConferenceMeetingRoomsT."Type of Meeting/Function"::Internal then begin
                            Requester := ConferenceMeetingRoomsT.Department + ' ' + 'Department';
                            RequesterName := ConferenceMeetingRoomsT."Staff Name";
                        end;
                end;
                //end;
            }

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                //ConferenceMeetingRoomsT.SetFilter("Date of Meeting/Function", '%1..%2', StartDate, EndDate);
                DateVirtual.SetFilter("Period Start", '%1..%2', StartDate, EndDate);
                DateVirtual.SetRange("Period Type", "Period Type"::Date);
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
                field(StartDate; StartDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Start Date';
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'End Date';
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        if StartDate = 0D then Error('Kindly set the start date');
        if EndDate = 0D then Error('Kindly set the end date');
        if CompanyInformation.Get then
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
        CompanyTelephone := 'Tel: ' + CompanyInformation."Phone No." + ' -Office Tel: ' + CompanyInformation."Phone No. 2";
        CommunicationOnline := 'E-mail: ' + CompanyInformation."E-Mail" + '- Website: ' + CompanyInformation."Home Page";
    end;


    var
        StartDate: Date;
        EndDate: Date;
        CompanyInformation: Record "Company Information";
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CommunicationOnline: Text;
        TypeofMeeting: Text;
        RequesterName: Text;
        Requester: Text;
        Year: Integer;
        Month: Integer;
        FormatedMonth: Text;
        Dayoftheweek: Option "Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday";
}
