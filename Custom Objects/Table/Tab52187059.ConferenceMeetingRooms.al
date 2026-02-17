table 52187059 "Conference & Meeting Rooms-T"
{
    Caption = 'Conference & Meeting Rooms';
    DataClassification = ToBeClassified;
    DrillDownPageId = "MNS Conf & Meetings Appl List";
    LookupPageId = "MNS Conf & Meetings Appl List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeriesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."Conference/Meeting Room No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Department/Client/Company Name"; Text[100])
        {
            Caption = 'Department/Client/Company Name';
        }
        field(3; "Staff/client/company Details"; Text[100])
        {
            Caption = 'Details of staff/client/company requesting';
        }
        field(4; "Type of Meeting/Function"; Option)
        {
            Caption = 'Type of Meeting/Function';
            OptionCaption = ' ,Internal,External,Other';
            OptionMembers = " ","Internal","External";
        }
        field(5; "Date of Meeting/Function"; Date)
        {
            Caption = 'Date of Meeting/Function';
            trigger OnValidate()
            begin

                LeaveCalender.RESET;
                LeaveCalender.SetRange("Current Leave Calendar", true);
                if LeaveCalender.FindFirst() then begin
                    if "Date of Meeting/Function" < LeaveCalender."Start Date" then begin
                        error('Date of Meeting/Function cannot be in the past year');
                    end
                    else if "Date of Meeting/Function" > LeaveCalender."End Date" then begin
                        error('Date of Meeting/Function cannot be in the future years');
                    end;
                end;

                if "Date of Meeting/Function" < TODAY then begin
                    error('Date of Meeting/Function cannot be in the past');
                end;
            end;
        }
        field(6; "Start Time of Meeting/Function"; Time)
        {
            Caption = 'Start Time of Meeting/Function';
        }
        field(7; "Duration of Meeting/Fucntion"; Duration)
        {
            Caption = 'Duration of Meeting/Fucntion';
        }
        field(8; "No. of Attendees"; Integer)
        {
            Caption = 'No. of Attendees';
        }
        field(10; "Special Requirements"; Text[100])
        {
            Caption = 'Special Requirements';
        }
        field(11; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
        }
        field(12; "Status"; Enum "Workflow Status Main Flags")
        {
        }
        field(9; "Status of the Booking"; Option)
        {
            Caption = 'Status of Booking';
            OptionCaption = 'Open,Accepted, Declined,Tentative,Closed';
            OptionMembers = "Open",Accepted,Declined,Tentative,Closed;
        }
        field(13; "Meeting Room"; Text[100])
        {
            Caption = 'Meeting Room Code';
            TableRelation = "Conf & Meeting Rooms List"."No.";
            trigger OnValidate()
            begin
                ConferenceAndMeetingRoom.RESET();
                ConferenceAndMeetingRoom.SetRange("Meeting Room", Rec."Meeting Room");
                ConferenceAndMeetingRoom.SetRange(Status, ConferenceAndMeetingRoom.Status::Approved);
                ConferenceAndMeetingRoom.SetRange("Status of the Booking", "Status of the Booking"::Accepted);
                IF ConferenceAndMeetingRoom.FindSet() THEN BEGIN
                    IF ((Rec."Date of Meeting/Function" >= ConferenceAndMeetingRoom."Date of Meeting/Function") AND (Rec."Date of Meeting/Function" <= ConferenceAndMeetingRoom."Event End Date")) THEN BEGIN
                        ERROR('Meeting Room has been reserved for the same date from ' + FORMAT(ConferenceAndMeetingRoom."Date of Meeting/Function") + 'to ' + FORMAT(ConferenceAndMeetingRoom."Event End Date") + '.');
                    END;
                END
                else
                    //IF NOT ConferenceAndMeetingRoom.Find('-') THEN BEGIN
                        ConfAndMeetingRoomList.RESET();
                        ConfAndMeetingRoomList.SetRange("No.", Rec."Meeting Room");
                        IF ConfAndMeetingRoomList.Find('-') THEN BEGIN
                            Rec."Meeting Room Name" := ConfAndMeetingRoomList."Room Name";
                        END;
                    //END;


                //     ConferenceAndMeetingRoom.RESET();
                //     //ConferenceAndMeetingRoom.SetRange(Status, ConferenceAndMeetingRoom.Status::Approved);
                //     ConferenceAndMeetingRoom.SetRange("Meeting Room", Rec."Meeting Room");
                //     ConferenceAndMeetingRoom.SetRange("Status of the Booking", "Status of the Booking"::Accepted);
                //     ConferenceAndMeetingRoom.SetRange("Date of Meeting/Function", Rec."Date of Meeting/Function");
                //     if ConferenceAndMeetingRoom.Find('-') then begin
                //         //if ConferenceAndMeetingRoom."Status of the Booking" = ConferenceAndMeetingRoom."Status of the Booking"::Accepted then begin
                //             //if Rec."Date of Meeting/Function" = ConferenceAndMeetingRoom."Date of Meeting/Function" then begin
                //                 error('Meeting Room has been reserved for the same date ' + Format(ConferenceAndMeetingRoom."Date of Meeting/Function") + '.');
                //             //end;
                //             // else
                //             if Rec."Date of Meeting/Function" <> ConferenceAndMeetingRoom."Date of Meeting/Function" then begin
                //                 repeat
                //                     Message('Meeting Room: %1', Rec."Meeting Room" + ' ' + 'has been reserved for the date, ' + Format(ConferenceAndMeetingRoom."Date of Meeting/Function") + ' by ' + ConferenceAndMeetingRoom."Department/Client/Company Name" + ' Meeting starts at ' + Format(ConferenceAndMeetingRoom."Start Time of Meeting/Function") + '.');
                //                 until ConferenceAndMeetingRoom.Next = 0;

                //                 ConfAndMeetingRoomList.Reset();
                //                 ConfAndMeetingRoomList.SetRange("No.", Rec."Meeting Room");
                //                 if ConfAndMeetingRoomList.Find('-') then begin
                //                     Rec."Meeting Room Name" := ConfAndMeetingRoomList."Room Name";
                //                 end;
                //             end;
                //         //end
                //         // else begin
                //         //     ConfAndMeetingRoomList.Reset();
                //         //     ConfAndMeetingRoomList.SetRange("No.", Rec."Meeting Room");
                //         //     if ConfAndMeetingRoomList.Find('-') then begin
                //         //         Rec."Meeting Room Name" := ConfAndMeetingRoomList."Room Name";
                //         //     end;
                //         // end;
                //     end
                //     else
                //         if NOT ConferenceAndMeetingRoom.Find('-') then begin
                //             ConfAndMeetingRoomList.Reset();
                //             ConfAndMeetingRoomList.SetRange("No.", Rec."Meeting Room");
                //             if ConfAndMeetingRoomList.Find('-') then begin
                //                 Rec."Meeting Room Name" := ConfAndMeetingRoomList."Room Name";
                //             end;
                //         end;
            end;
        }
        field(14; "Meeting Room Name"; Text[100])
        {
            Caption = 'Meeting Room Name';
        }
        field(15; "Created by"; Code[50])
        {
            Caption = 'Created by';
        }
        field(16; "Created at"; DateTime)
        {
            Caption = 'Created at';

        }
        field(17; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            trigger OnValidate()
            begin

            end;
        }
        field(18; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin

            end;
        }
        // field(19; "Resposibility Center"; Code[10])
        // {
        //     Caption = 'Resposibility Center';
        //     TableRelation = "Responsibility CenterBR";
        // }
        field(20; "Staff Requesting"; Code[50])
        {
            Caption = 'Staff Requesting';
            TableRelation = "HR Employees"."No.";
            trigger OnValidate()
            begin
                //     HREmployees.RESET;
                //     HREmployees.Get(Code);
                //     if HREmployees.Find('-') then
                //         "Staff Name" := HREmployees."First Name" + ' ' + HREmployees."Middle Name" + ' ' + HREmployees."Last Name";
                HREmp.Reset;
                HREmp.Get("Staff Requesting");
                "Staff Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
            end;
        }
        field(21; "Staff Name"; Code[100])
        {
        }
        field(22; "Address"; Code[200]) { }
        field(23; "Contact Person"; Code[20]) { }
        field(24; "Contact No."; Code[20]) { }
        field(25; "Floor Location"; Code[20]) { }
        field(26; "Room Name"; Code[20]) { }
        field(27; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility CenterBR";
        }
        field(28; "Room Status"; Option)
        {
            OptionCaption = 'Available,Booked';
            OptionMembers = Available,Booked;
        }
        // field(29; "Booking Status"; Option)
        // {
        //     OptionMembers = Underway,Closed;
        // }
        field(30; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
        field(31; Department; Code[20])
        {
            TableRelation = "Responsibility CenterBR";
        }
        field(32; "Send/Forward to"; Code[50])
        {
            TableRelation = "Responsibility CenterBR";
        }

        field(33; "Originating Department"; Code[50])
        {
            Editable = false;
        }
        field(34; "Current Department"; Code[50])
        {
            Editable = false;
        }
        field(35; "Event End Date"; Date)
        {
            Caption = 'Event End Date';
        }
        field(36; Amount; Decimal)
        {
            Caption = 'Amount';
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }

    }
    Trigger OnInsert()
    begin

        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Conference/Meeting Room No.");
            "No." := NoSeriesMgt.GetNextNo(SeriesSetup."Conference/Meeting Room No.");
            // NoSeriesMgt.InitSeries(SeriesSetup."Conference/Meeting Room No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        Rec."Created at" := CURRENTDATETIME;
        Rec."Created By" := UserId;

        "User ID" := UserId;
        "Created By" := UserId;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
            UserSetup.TestField("Responsibility Centre");
            "Originating Department" := UserSetup."Responsibility Centre";
            "Current Department" := UserSetup."Responsibility Centre";
            CFPage.InsertTracker("No.", "Originating Department", true, UserId, CurrentDateTime);
        end;
    end;

    var
        NoSeriesMgt: Codeunit "No. Series";
        SeriesSetup: Record "Credit Nos. Series";
        ConfAndMeetingRoomList: Record "Conf & Meeting Rooms List";
        ConferenceAndMeetingRoom: Record "Conference & Meeting Rooms-T";
        HREmp: Record "HR Employees";
        UserSetup: Record "User Setup";
        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;
        LeaveCalender: Record "HR Leave Calendar";
        AdminBookingPlanner: Record "Admin Bookings Planner";

    procedure InsertToBookingPlanner(var Rec: Record "Conference & Meeting Rooms-T")
    begin
        if Rec.Status = Status::Approved then begin
            if Confirm('Do you want to log the booking into the Calendar?') then begin
                AdminBookingPlanner.Init();
                AdminBookingPlanner."Booking No." := Rec."No.";
                AdminBookingPlanner."Event Date" := Rec."Date of Meeting/Function";
                AdminBookingPlanner."Event End Date" := Rec."Event End Date";
                AdminBookingPlanner."Meeting Room" := Rec."Meeting Room";
                AdminBookingPlanner."Start Time" := Rec."Start Time of Meeting/Function";
                AdminBookingPlanner."Meeting Duration" := Rec."Duration of Meeting/Fucntion";
                AdminBookingPlanner."No. of Atendees" := Rec."No. of Attendees";
                AdminBookingPlanner."Special Requirements" := Rec."Special Requirements";
                AdminBookingPlanner."Meeting Type" := Format(Rec."Type of Meeting/Function");
                AdminBookingPlanner.Insert(true);
            end;
            Message('Booking has been logged into the Calendar.');
        end;
    end;

    procedure GetBookingDetailsForCalendar(var Rec: Record "Conference & Meeting Rooms-T")
    var
        myInt: Integer;
        ConferenceMeetingRoomsT: Record "Conference & Meeting Rooms-T";
        BookingDescription: Text;
        BookingCalender: Record "Admin Booking Calendar";

    begin
        ConferenceMeetingRoomsT.TestField(Status, ConferenceMeetingRoomsT.Status::Approved);
        if Confirm('Do you want to log the booking details into the calendar?') then begin
            ConferenceMeetingRoomsT.RESET;
            ConferenceMeetingRoomsT.SetRange(ConferenceMeetingRoomsT."No.", Rec."No.");
            if ConferenceMeetingRoomsT.FindFirst() then begin
                BookingDescription := 'Meeting Room: ' + ConferenceMeetingRoomsT."Meeting Room" + ' - ' + ConferenceMeetingRoomsT."Meeting Room Name" + ' - ' + ConferenceMeetingRoomsT."Staff Name" + ' - ' + ConferenceMeetingRoomsT."Department/Client/Company Name" + ' - ' + ConferenceMeetingRoomsT."Staff/client/company Details" + ' - ' + Format(ConferenceMeetingRoomsT."Type of Meeting/Function") + ' - ' + Format(ConferenceMeetingRoomsT."Start Time of Meeting/Function") + ' - ' + ConferenceMeetingRoomsT."Special Requirements";
                IF BookingDescription <> ' ' then begin
                    BookingCalender.Init();
                    BookingCalender.Description := BookingDescription;
                    BookingCalender.Insert(true);
                end;
                Message(BookingDescription);
                Message('Booking details have been logged into the Calendar.');
            end;
        end;
    end;
}
