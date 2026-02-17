table 52187161 "M-Banking Whitelist App"
{
    Caption = 'M-Banking Whitelist Applications';
    DataClassification = ToBeClassified;

    DrillDownPageId = "M-Banking Whitelist List";
    LookupPageId = "M-Banking Whitelist List";

    fields
    {
        field(1; "No."; Code[50])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(2; "Member No."; Text[50])
        {
            TableRelation = Members."No.";
            Caption = 'Member No.';
            Editable = false;
            trigger OnValidate()
            var
                theMember: record Members;
                GFunc: Codeunit "Global Functions";
            begin
                theMember.Reset;

                theMember.SetRange("No.", Rec."Member No.");
                theMember.SetLoadFields("No.", Subflag, "Transactional Mobile Number", Name, "Primary Identification Type", "Primary Identification", "Secondary Identification Type", "Secondary Identification");
                if theMember.FindFirst then begin
                    // Check if member is eligible for mobile banking
                    if GFunc.CheckMemberSubflagTransactionAbility(theMember."No.") then begin
                        // (Mandatory: Transactional Mobile Number, Full Name, ID Number)
                        if theMember."Transactional Mobile Number" = '' then begin
                            Error('Member No. %1 has missing transactional mobile number', theMember."No.");
                        end;
                        if theMember.Name = '' then begin
                            Error('Member No. %1 has missing full names', theMember.Name);
                        end;
                        if theMember."Primary Identification" = '' then begin
                            Error('Member No. %1 has missing primary identification information', theMember.Name);
                        end;

                        // Prefill
                        "Transactional Mobile No." := theMember."Transactional Mobile Number";
                        "Full Names" := theMember.Name;
                        "Primary Identification Type" := theMember."Primary Identification Type";
                        "Primary Identification" := theMember."Primary Identification";
                        Status := Status::Open;
                    end else begin
                        Error('Member with No. %1 is not eligible for mobile banking. Sub flag/status = %2', theMember."No.", theMember.Subflag);
                    end;
                end else begin
                    Error('Member with No. %1 not found!', Rec."Member No.");
                end;
            end;
        }
        field(3; "Transactional Mobile No."; Text[25])
        {
            Caption = 'Transactional Mobile No.';
            Editable = false;
        }
        field(4; "Full Names"; Text[100])
        {
            Caption = 'Full Names';
            Editable = false;
        }
        field(5; "Primary Identification Type"; Enum "Identification Type")
        {
            Caption = 'Primary Identification Type';
            Editable = false;
        }
        field(6; "Primary Identification"; Text[100])
        {
            Caption = 'Primary Identification';
            Editable = false;
        }
        field(7; Status; Enum "Workflow Status Main Flags")
        {
            Caption = 'Status';
            Editable = false;
        }
        field(8; "Is Whitelisted"; Boolean)
        {
            Caption = 'Is Whitelisted?';
            Editable = true;
        }
        field(9; "Whitelist Reference ID"; Text[50])
        {
            Caption = 'Whitelist Reference ID';
            Editable = true;
        }

        field(10; "CRM Created By"; Code[100])
        {
            Caption = 'CRM Created By';
            Editable = false;
        }

        field(11; "CRM Originating Branch"; Code[50])
        {
            Caption = 'CRM Originating Branch';
            Editable = false;
        }

        field(12; "CRM Notes"; text[1000])
        {
            Caption = 'CRM Notes';
            Editable = false;
        }

        field(13; "Approved By"; Code[50])
        {
            Caption = 'Approved/Rejected By';
            Editable = false;
        }
        field(14; "Approval Date"; Date)
        {
            Caption = 'Approved/Rejected By';
            Editable = false;
        }
        field(22; "Approval Time"; Time)
        {
        }
        field(15; "No. Series"; Code[50])
        {
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            trigger OnValidate()
            var
                DimVal: Record "Dimension Value";
            begin
                DimVal.reset;
                DimVal.SetRange(Code, "Global Dimension 1 Code");
                if DimVal.find('-') then
                    "Branch Name" := DimVal.Name;
            end;
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            trigger OnValidate()
            var
                DimVal: Record "Dimension Value";
            begin
                DimVal.reset;
                DimVal.SetRange(Code, "Global Dimension 2 Code");
                if DimVal.find('-') then
                    "Activity Name" := DimVal.Name;
            end;
        }
        field(18; "Branch Name"; Text[50])
        {
        }
        field(19; "Activity Name"; Text[50])
        {
        }
        field(20; "Application Date"; Date)
        {
        }
        field(21; "Application Time"; Time)
        {
        }

        field(23; "Responsible Officer"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."User ID" where("Record ID" = field("No.")));
        }
        field(24; "Supervisor ID"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."Supervisor ID" where("Record ID" = field("No.")));
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        MBWApp: record "M-Banking Whitelist App";
        GlobalFunctions: Codeunit "Global Functions";
        DepartMent: Enum "Responsibility Center Enum";
        SubDepartments: Enum "Sub Module";

        theSMS: Text;
        theMember: Record members;
        SkySMS: Codeunit SendSms;
        SMSSource: Enum "SMS Source";
        SkySendEmail: Codeunit "Sky Send Email";
    begin
        MBWApp.Reset();
        MBWApp.SetRange(MBWApp."Member No.", Rec."Member No.");
        MBWApp.SetFilter(Status, '%1|%2', MBWApp.Status::Open, MBWApp.Status::Pending);
        if MBWApp.FindFirst() then begin
            Error('Member has a similar application of number %1 at status %2', MBWApp."No.", MBWApp.Status);
        end;

        if "No." = '' then begin
            // SeriesSetup.Get;
            // SeriesSetup.TestField(SeriesSetup."CRM Mbanking Whitelist No.");
            // NoSeriesMgt.InitSeries(SeriesSetup."CRM Mbanking Whitelist No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Application Date" := Today;
        "Application Time" := Time;

        // if not GlobalFunctions.AssignUserTasks(DepartMent::FOSA, SubDepartments::"M-Hela Whitelist", "No.") then
        //     Message('Auto asign of tasks to users has failed. Please make sure that you have present users or contact your system administrator');


        // SMS to applicant
        theSMS := 'Dear applicant, your MwalimuHela Mobile Banking Application request has been received successfully and is being processed. REF ' + "No.";

        theMember.Reset;
        theMember.SetRange("No.", "Member No.");

        if theMember.FindFirst then begin
            SkySMS.SendSms(
                SMSSource::CRM,
                theMember."Phone No.",
                theSMS,
                CreateGuid(),
                '',
                false,
                0,
                false,
                'CBS',
                "No.",
                'CBS'
            );

            // EMAIL
            SkySendEmail.QueueOutgoingEmail(
                theMember."E-Mail",
                'MwalimuHela Mobile Banking Application Request',
                theSMS,
                'TEXT',
                'MHELA APPLICATION',
                'CRM'
            );
        end;
    end;

    trigger OnModify()
    var
        thisApp: Record "M-Banking Whitelist App";
    begin
        thisApp.Reset();

        thisApp.SetRange("No.", Rec."No.");

        if thisApp.FindFirst then begin
            // Track Status Change
            IF (thisApp.Status <> Status) then begin
                if (Status = Status::Approved) or (Status = Status::Rejected) then begin
                    "Approved By" := UserId;
                    "Approval Date" := Today;
                    "Approval Time" := Time;
                end;
            end;
        end;
    end;

    var
        SeriesSetup: Record "Credit Nos. Series";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt: Codeunit "No. Series";
}
