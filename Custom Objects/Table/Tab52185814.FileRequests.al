table 52185814 "File Requests"
{
    Caption = 'File Requests';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Request Number"; Code[20])
        {
            Editable = false;
            trigger OnValidate()
            begin
                if "Request Number" <> xRec."Request Number" then begin
                    SeriesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."File Request");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "File Number"; Code[50])
        {
            TableRelation = IF ("File Type" = CONST("Member File")) "Members"."No.";
            trigger OnValidate()
            begin
                if Cust.Get("File Number") then begin
                    "Member Name" := Cust.Name;
                    "ID No." := Cust."Primary Identification";
                    "Staff No" := Cust."Payroll/Staff No.";

                end;

            end;
        }
        field(3; "Folio Number"; Code[60])
        {
            Caption = 'Volume No.';
        }
        field(4; "Move to"; Code[10])
        {
            TableRelation = "File Stations"."Station Code";

            trigger OnValidate()
            begin
                APPSET.SetRange("Station Code", Rec."Move to");
                if APPSET.Find('-') then begin
                    APPSET.TestField("Responsibility Centre");
                    Rec."Sent To" := APPSET.Description;
                    Rec."Responsibility Centre" := APPSET."Responsibility Centre";
                end;
                //VALIDATE("Office Name");
                /*FileMovementTracker.RESET;
                FileMovementTracker.SETRANGE(FileMovementTracker."Member No.","File Number");
                IF FileMovementTracker.FIND('+') THEN BEGIN
                IF FileMovementTracker.Stage = "Move to" THEN
                ERROR('File already in %1',FileMovementTracker.Station);
                END;*/

                //restrict movement to same department
                UserStations.Reset;
                UserStations.SetRange("User Id", UserId);
                if UserStations.Find('-') then
                    if UserStations."Station Code" = "Move to" then Error('You cannot move a file to your Section');

            end;
        }
        field(5; "File Request Remarks"; Text[50])
        {
            TableRelation = "File Movement Remarks".Description;
        }
        field(6; "File Request User ID"; Code[60])
        {
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(7; "File Request Time"; Time)
        {
        }
        field(8; "Current File Location"; Code[10])
        {
            CalcFormula = Max("File Location"."Section Code" WHERE("Member No." = FIELD("File Number"),
                                                                    "Current Location" = FILTER(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(36; "Current Responsibility Centre"; Code[20])
        {
            TableRelation = "Responsibility CenterBR";
            Editable = false;

        }
        field(9; "File Request Date"; Date)
        {
        }
        field(10; "File received date"; Date)
        {
        }
        field(11; "File received Time"; Time)
        {
        }
        field(12; "File Received by"; Code[60])
        {
        }
        field(13; "File Received"; Boolean)
        {
        }
        field(14; "Action"; Option)
        {
            OptionCaption = 'Open ,Issued,Received,Forwarded';
            OptionMembers = "Open ",Issued,Received,Forwarded;
        }
        field(15; "Member Name"; Code[100])
        {
            Editable = false;
        }
        field(16; "Office Name"; Text[50])
        {
            Editable = false;
            Enabled = true;
        }
        field(17; "Sent To"; Code[60])
        {
            Editable = false;
        }
        field(18; "File Recalled"; Boolean)
        {
        }
        field(19; "ID No."; Code[20])
        {
            Editable = false;
        }
        field(20; Overdue; Boolean)
        {
            Editable = false;
            trigger OnValidate()
            var
                MyNotification: Notification;
            begin
                if Rec.Overdue = true then begin
                    MyNotification.Message := 'This File Request is Overdue, you may recall it.';
                    MyNotification.Scope := NotificationScope::LocalScope;
                    MyNotification.Send();
                end;
            end;
        }
        field(22; "No. Series"; Code[10])
        {
            Editable = false;
        }
        field(23; "Loan No"; Code[20])
        {
            TableRelation = Loans."Loan No." WHERE("Member No." = FIELD("Folio Number"));

            trigger OnValidate()
            begin

            end;
        }
        field(24; "Staff No"; Code[20])
        {
            Caption = 'TSC/PF No.';
            Editable = false;
        }
        field(25; "Other  Doc  No"; Code[20])
        {
        }
        field(26; "File  Forwarded"; Boolean)
        {
        }
        field(27; Narration; Text[50])
        {
        }
        field(28; Status; Option)
        {
            OptionCaption = 'Open,Requested,Rejected,Closed';
            OptionMembers = "Open",Requested,Rejected,Closed;
        }
        field(29; "File Requested By"; Code[50])
        {
            Editable = false;
        }
        field(30; "File Creation Date"; Date)
        {
            Editable = false;
        }
        field(31; Create; Boolean)
        {
            Editable = false;
        }
        field(32; "File Issued"; Boolean)
        {
            Editable = false;
        }
        field(33; "Member Status"; Enum "Member Status")
        {
            CalcFormula = Lookup(Members.Status WHERE("No." = FIELD("File Number")));
            Editable = false;
            FieldClass = FlowField;
            // OptionCaption = ' ,New,Active,Dormant,Frozen,Withdrawal Applicant,Withdrawn,Deceased,Defaulter,Closed,Withdrawn Shareholder';
            // OptionMembers = " ",New,Active,Dormant,Frozen,"Withdrawal Applicant",Withdrawn,Deceased,Defaulter,Closed,"Withdrawn Shareholder";
        }
        field(34; "File Type"; Option)
        {
            OptionMembers = "Member File","Policy File";
            OptionCaption = 'Member File,Policy File';
            trigger OnValidate()
            begin
                "File Number" := '';
                "Member Name" := '';
                "ID No." := '';
                "Staff No" := '';
            end;
        }

        field(35; "Responsibility Centre"; Code[20])
        {
            TableRelation = "Responsibility CenterBR";
            Caption = 'Dest. Responsibility Center';
            Editable = false;

        }
        field(40; "Request Type"; Option)
        {
            OptionMembers = "Normal","Request File";
            OptionCaption = 'Normal,Request File';
            trigger OnValidate()
            begin

            end;
        }

    }


    keys
    {
        key(Key1; "Request Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Request Number", "File Number", "Member Name")
        {

        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin

        if "Request Number" = '' then begin

            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."File Request");
            "Request Number" := NoSeriesMgt.GetNextNo(SeriesSetup."File Request");
            // NoSeriesMgt.InitSeries(SeriesSetup."File Request", xRec."No. Series", 0D, "Request Number", "No. Series");

        end;
        userSetup.get(UserId);
        "Current Responsibility Centre" := userSetup."Responsibility Centre";
        "Responsibility Centre" := userSetup."Responsibility Centre";
        "File Request Date" := today;
        "File Request Time" := Time;
        "File Request User ID" := UserId;
        "File Requested By" := UserId;
    end;

    var
        ElectrolZonesAreaSvrCenter: Record "Electrol Zones/Area Svr Center";
        MembNoSeries: Record "Banking No Setup";
        NoSeriesMgt: Codeunit "No. Series";
        SegmentCountyDividendSignat: Record "Segment/County/Dividend/Signat";
        Cust: Record Members;
        APPSET: Record "File Stations";
        FileMovementTracker: Record "File Location";
        FileTracker: Record "File Tracker";
        UserStations: Record "User Stations";
        userSetup: Record "User Setup";
        SeriesSetup: Record "Credit Nos. Series";
}

