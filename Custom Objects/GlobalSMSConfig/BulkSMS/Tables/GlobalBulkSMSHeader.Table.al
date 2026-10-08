table 52185982 "Global Bulk SMS Header"
{
    Caption = 'Global Bulk SMS Header';
    DataClassification = CustomerContent;
    LookupPageId = "Global Bulk SMS List";
    DrillDownPageId = "Global Bulk SMS List";

    fields
    {
        field(1; "Campaign No."; Code[20])
        {
            Caption = 'Campaign No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                NoSetup: Record "Credit Nos. Series";
                NoSeriesMgt: Codeunit "No. Series";
                RecRef: RecordRef;
                FldRef: FieldRef;
                NoSeriesCode: Code[20];
            begin
                if "Campaign No." <> xRec."Campaign No." then begin
                    if not NoSetup.Get() then
                        Error('Credit Nos. Series setup not found. Please set up number series in Member Nos. Series page.');

                    RecRef.GetTable(NoSetup);
                    FldRef := RecRef.Field(159);
                    NoSeriesCode := FldRef.Value;

                    if NoSeriesCode = '' then
                        Error('Global Bulk SMS number series not configured.\Please go to Member Nos. Series page and set up the "Global Bulk SMS Nos" field with a valid number series.');

                    "Campaign No." := NoSeriesMgt.GetNextNo(NoSeriesCode);
                    "No. Series" := '';
                end;
            end;
        }

        field(2; "Campaign Name"; Text[100])
        {
            Caption = 'Campaign Name';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Campaign Name" = '' then
                    Error('Campaign Name cannot be blank.');
            end;
        }

        field(3; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }

        field(4; "Message Template"; Text[2000])
        {
            Caption = 'Message Template';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Message Template" = '' then
                    Error('Message Template cannot be blank.');

                if StrLen("Message Template") > 1600 then
                    if not Confirm('Message is over 1600 characters and may result in multiple SMS charges. Continue?') then
                        Error('');
            end;
        }

        field(5; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionMembers = Draft,Generating,Ready,Sending,Completed,Cancelled;
            OptionCaption = 'Draft,Generating,Ready,Sending,Completed,Cancelled';
            Editable = false;

            trigger OnValidate()
            begin
                "Status Date" := CurrentDateTime();
                "Status By" := CopyStr(UserId(), 1, MaxStrLen("Status By"));
            end;
        }

        field(6; "Filter Summary"; Text[500])
        {
            Caption = 'Filter Summary';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(7; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(8; "Created DateTime"; DateTime)
        {
            Caption = 'Created DateTime';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(9; "Generated DateTime"; DateTime)
        {
            Caption = 'Generated DateTime';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(10; "Sent DateTime"; DateTime)
        {
            Caption = 'Sent DateTime';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(11; "Status By"; Code[50])
        {
            Caption = 'Status By';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(12; "Status Date"; DateTime)
        {
            Caption = 'Status Date';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(13; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "No. Series";
        }

        field(20; "Total Recipients"; Integer)
        {
            Caption = 'Total Recipients';
            FieldClass = FlowField;
            CalcFormula = count("Global Bulk SMS Line" where("Campaign No." = field("Campaign No.")));
            Editable = false;
        }

        field(21; "Sent Count"; Integer)
        {
            Caption = 'Sent Count';
            FieldClass = FlowField;
            CalcFormula = count("Global Bulk SMS Line" where("Campaign No." = field("Campaign No."), Status = const(Sent)));
            Editable = false;
        }

        field(22; "Failed Count"; Integer)
        {
            Caption = 'Failed Count';
            FieldClass = FlowField;
            CalcFormula = count("Global Bulk SMS Line" where("Campaign No." = field("Campaign No."), Status = const(Failed)));
            Editable = false;
        }

        field(23; "Pending Count"; Integer)
        {
            Caption = 'Pending Count';
            FieldClass = FlowField;
            CalcFormula = count("Global Bulk SMS Line" where("Campaign No." = field("Campaign No."), Status = const(Pending)));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Campaign No.")
        {
            Clustered = true;
        }
        key(Status; Status, "Created DateTime")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Campaign No.", "Campaign Name", Status)
        {
        }
    }

    trigger OnInsert()
    var
        NoSetup: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit "No. Series";
        RecRef: RecordRef;
        FldRef: FieldRef;
        NoSeriesCode: Code[20];
    begin
        if "Campaign No." = '' then begin
            if not NoSetup.Get() then
                Error('Credit Nos. Series setup not found. Please set up number series in Member Nos. Series page before creating Global Bulk SMS campaigns.');

            RecRef.GetTable(NoSetup);
            FldRef := RecRef.Field(159);
            NoSeriesCode := FldRef.Value;

            if NoSeriesCode = '' then
                Error('Global Bulk SMS number series not configured.\Please go to Member Nos. Series page and set up the "Global Bulk SMS Nos" field with a valid number series (e.g., create GBSMS series in No. Series setup).');

            "Campaign No." := NoSeriesMgt.GetNextNo(NoSeriesCode);
        end;

        "Created By" := CopyStr(UserId(), 1, MaxStrLen("Created By"));
        "Created DateTime" := CurrentDateTime();
        Status := Status::Draft;
        "Status By" := "Created By";
        "Status Date" := "Created DateTime";

        TestField("Campaign Name");
        TestField("Message Template");
    end;

    trigger OnModify()
    begin
        if Status in [Status::Sending, Status::Completed] then
            Error('Cannot modify campaign with status %1.', Status);
    end;

    trigger OnDelete()
    var
        GlobalBulkSMSLine: Record "Global Bulk SMS Line";
        GlobalBulkSMSFilter: Record "Global Bulk SMS Filter";
        GlobalBulkSMSTokenMap: Record "Global Bulk SMS Token Map";
    begin
        if Status = Status::Sending then
            Error('Cannot delete campaign that is currently sending.');

        if Status = Status::Completed then
            if not Confirm('This campaign has been sent. Delete anyway?') then
                Error('');

        GlobalBulkSMSLine.SetRange("Campaign No.", "Campaign No.");
        GlobalBulkSMSLine.DeleteAll(true);

        GlobalBulkSMSFilter.SetRange("Campaign No.", "Campaign No.");
        GlobalBulkSMSFilter.DeleteAll(true);

        GlobalBulkSMSTokenMap.SetRange("Campaign No.", "Campaign No.");
        GlobalBulkSMSTokenMap.DeleteAll(true);
    end;

    procedure CheckEditAllowed()
    begin
        if Status in [Status::Sending, Status::Completed] then
            Error('Cannot edit campaign with status %1. Please create a new campaign.', Status);
        // Allows editing when: Draft, Generating (for recovery), Ready, Cancelled
    end;

    procedure SetStatusGenerating()
    begin
        Status := Status::Generating;
        Modify(true);
        Commit();
    end;

    procedure SetStatusReady()
    begin
        Status := Status::Ready;
        "Generated DateTime" := CurrentDateTime();
        Modify(true);
    end;

    procedure SetStatusSending()
    begin
        TestField(Status, Status::Ready);
        CalcFields("Total Recipients");
        if "Total Recipients" = 0 then
            Error('Cannot send campaign with no recipients.');

        Status := Status::Sending;
        Modify(true);
        Commit();
    end;

    procedure SetStatusCompleted()
    begin
        Status := Status::Completed;
        "Sent DateTime" := CurrentDateTime();
        Modify(true);
    end;

    procedure SetStatusCancelled()
    begin
        if not (Status in [Status::Ready, Status::Sending]) then
            Error('Can only cancel campaigns that are Ready or Sending.');

        Status := Status::Cancelled;
        Modify(true);
    end;

    procedure ResetToDraft()
    begin
        if not (Status in [Status::Ready, Status::Cancelled, Status::Generating]) then
            Error('Can only reset Ready, Cancelled, or Generating campaigns to Draft.');

        Status := Status::Draft;
        "Generated DateTime" := 0DT;
        "Sent DateTime" := 0DT;
        Modify(true);
    end;
}
