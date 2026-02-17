table 52186080 "File Tracker"
{

    fields
    {
        field(1; "Request Number"; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "File Number"; Code[50])
        {
            //TableRelation = IF ("File Type" = CONST("Member File")) "Members"."No.";
            TableRelation = "Files Table"."Entry No." WHERE("File Type" = field("File Type"));
            trigger OnValidate()
            begin
                FilesTable.RESET;
                FilesTable.SETRANGE(FilesTable."Entry No.", "File Number");
                if FilesTable.FIND('-') then begin
                    "Member Name" := FilesTable."File Name/Descrption";
                    "ID No." := FilesTable."File/Member No.";
                    "Staff No" := FilesTable."File Custodian";
                end;
                // if Cust.Get("File Number") then begin
                //     "Member Name" := Cust.Name;
                //     "ID No." := Cust."Primary Identification";
                //     "Staff No" := Cust."Payroll/Staff No.";
                // end;

                //not to allow  more than one record of a file
                // FileTracker.Reset;
                // FileTracker.SetRange("File Number", "File Number");
                // if FileTracker.Find('-') then
                //     Error('File has an existing Record');
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
        field(5; "File Movement Remarks"; Text[50])
        {
            TableRelation = "File Movement Remarks".Description;
        }
        field(6; "File MVT User ID"; Code[60])
        {
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(7; "File MVT Time"; Time)
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
        field(9; "File MVT Date"; Date)
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
                // //MEMBER WITH AN EXISTING APPLICATION
                // FileT.RESET;
                // FileT.SETRANGE(FileT."File Number","File Number");
                // FileT.SETRANGE(FileT."Loan No","Loan No");
                // //MESSAGE('%1',"Loan No");
                // FileT.SETRANGE(FileT."File Received by",'');
                //
                // IF FileT.FIND('-') THEN BEGIN
                // REPEAT
                // IF FileT."Request Number" <> "Request Number" THEN
                //
                // ERROR('File already has an existing application. Let the previous file be received before proceeding.');
                // UNTIL FileT.NEXT = 0;
                // END;
                // //MEMBER WITH AN EXISTING LOAN APPLICATION
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
            OptionCaption = 'Being Processed,Processed,Forwarded,Archived';
            OptionMembers = "Being Processed",Processed,Forwarded,Archived;
        }
        field(29; "File Created By"; Code[50])
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
        field(34; "File Type"; Enum "File Types")
        {
            // OptionMembers = "Member File","Policy File","Administrative Files","Business Loans File","Personnel Files","HR Files";
            // OptionCaption = 'Member File,Policy File, Administrative Files, Business Loans File, Personnel Files, HR Files';
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
        field(41; "File Request No."; Code[10])
        {
            TableRelation = "File Requests"."Request Number" where(Status = filter("Requested"));
            trigger OnValidate()
            var
                FileReq: Record "File Requests";
            begin
                if FileReq.get("File Request No.") then begin
                    "File Number" := FileReq."File Number";
                    "File Type" := FileReq."Request Type";
                    "Member Name" := FileReq."Member Name";
                    "ID No." := FileReq."ID No.";
                end;

            end;
        }
        field(42; "File Request Date"; Date)
        {
        }
        field(43; "File Requested By"; Code[200])
        {
        }
        field(44; "File Request Remarks"; Code[200])
        {
            TableRelation = "File Movement Remarks".Description;
        }
        field(45; "File Request Status"; Option)
        {
            OptionCaption = 'Open, Requested,Issued,Received,Forwarded';
            OptionMembers = Open,"Requested",Issued,Received,Forwarded,Closed;
        }
        field(46; "File Request Time"; Time)
        {
        }
        field(47; "File Request User ID"; Code[200])
        {
        }
        field(48; "File Request Number"; Code[20])
        {
            Editable = false;
            trigger OnValidate()
            begin
                if "File Request Number" <> xRec."File Request Number" then begin
                    SeriesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."File Request");
                    "No. Series" := '';
                end;
            end;
        }
        field(49; "Volume Entry No."; Code[50])
        {
            TableRelation = "File Volumes"."Volume Entry No.";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                FileVolumes.RESET;
                FileVolumes.SETRANGE(FileVolumes."Volume Entry No.", "Volume Entry No.");
                if FileVolumes.FIND('-') then
                    Rec."File No." := FileVolumes."File No.";
                Rec."File Name" := FileVolumes."Member Name";
                Rec."File Volume No." := FileVolumes."File Volume No.";
                Rec."File Status" := FORMAT(FileVolumes."Volume Status");
                Rec."Batch" := FileVolumes.Batch;
                ///Rec.Town := FileVolumes.Town;
                if FileVolumes."Volume Status" = FileVolumes."Volume Status"::Archived then begin
                    FileBatching.RESET;
                    FileBatching.Setrange(Batch, Rec.Batch);
                    if FileBatching.Find('-') then begin
                        Rec."Floor No." := FileBatching."Floor No.";
                        Rec.Building := FileBatching."Building Name";
                        Rec.Town := FileBatching.Town;
                    end;
                end;
            end;
        }
        field(50; "File No."; Code[50])
        {
            ;
        }
        field(51; "File Name"; Code[100])
        {
        }
        field(53; "File Volume No."; Code[50])
        {
        }
        field(54; "Date Closed"; Date)
        {
        }
        field(55; "Date Overdue"; Date)
        {
        }
        field(56; "File Status"; Code[50])
        {
        }
        field(57; Building; Code[50])
        {
        }
        field(58; "Floor No."; Code[50])
        {
        }
        field(59; Town; Code[50])
        {
        }
        field(60; Batch; Code[50])
        {
        }
        field(61; "Returned By"; Code[50])
        {
        }
        field(62; "Return Date"; Date)
        {
        }
        field(63; "Return To Archive"; Boolean)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Confirm('Do you want to return this file to the Archives') then begin
                    Rec."Return To Archive" := true;
                    Rec."Return Date" := today;
                    Rec."Returned By" := UserId;
                end;

            end;
        }
    }

    keys
    {
        key(Key1; "File Request Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        if "File Request Number" = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."File Request");
            "File Request Number" := NoSeriesMgt.GetNextNo(SeriesSetup."File Request");
            // NoSeriesMgt.InitSeries(SeriesSetup."File Request", xRec."No. Series", 0D, "File Request Number", "No. Series");
        end;
        userSetup.get(UserId);
        "Current Responsibility Centre" := userSetup."Responsibility Centre";
        //userSetup.get(UserId);
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
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
        SeriesSetup: Record "Credit Nos. Series";
        SegmentCountyDividendSignat: Record "Segment/County/Dividend/Signat";
        Cust: Record Members;
        APPSET: Record "File Stations";
        FileMovementTracker: Record "File Location";
        FileTracker: Record "File Tracker";
        UserStations: Record "User Stations";
        userSetup: Record "User Setup";
        FileVolumes: Record "File Volumes";
        FileBatching: Record "Batching Process Table";
        FilesTable: Record "Files Table";

}

