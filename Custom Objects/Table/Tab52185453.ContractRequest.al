table 52185453 "Contract Request"
{
    Caption = 'Contract Request';
    DataClassification = ToBeClassified;
    LookupPageID = "Contract Request List";
    DrillDownPageID = "Contract Request List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Party to The Contract"; Text[100])
        {
            Caption = 'Party to The Contract';
        }
        field(3; "Contractor Type"; Option)
        {
            Description = 'Description';
            OptionCaption = ' ,Vendor,Customer';
            OptionMembers = " ",Vendor,Customer;

            trigger OnValidate()
            begin
                "Contractor Name" := '';
            end;
        }
        field(4; "Contractor Name"; Text[100])
        {
            Caption = 'Contractor Name';
        }
        field(5; "Contract Type"; Option)
        {
            Caption = 'Contract Type';
            OptionCaption = ' ,Service agreement, Lease, Annual maintenance, Non Disclosure Aagreement, Data Protection Aagreement';
            OptionMembers = " ","service agreement",lease,"annual maintenance","Non Disclosure Agreement","Data Protection Agreement";
        }

        field(6; "Type of Service"; Option)
        {
            Caption = 'Type of Service';
            OptionMembers = " ",Goods,Services;
        }
        field(7; "Contract Description"; Text[100])
        {
            Caption = 'Contract Description';
        }
        field(8; "Responsibility Center"; Code[50])
        {
        }
        field(9; "Global Dimension 1 Code"; Code[50])
        {
        }
        field(10; "Global Dimension 2 Code"; Code[50])
        {
        }
        field(11; "No. Series"; Code[20])
        {
            Caption = 'No Series';
        }
        field(12; "Created By"; Code[20])
        {
            Caption = 'Created By';
        }
        field(13; UserID; Code[20])
        {
            Caption = 'User ID';
        }
        field(14; "User ID"; Code[20])
        {
            Caption = 'User ID';
        }
        field(15; Status; Enum "Workflow Status Main Flags")
        {
            Caption = 'Status';
        }
        field(16; "Date of Request"; Date)
        {
            Caption = 'Date of Request';
        }
        field(17; "Start Date"; Date)
        {
        }
        field(18; "End Date"; Date)
        {
        }
        field(19; "Contract Period"; Text[100])
        {

        }
        field(20; "Termination Reason"; Text[250])
        {
        }
        field(21; "Termination Clause"; Text[250])
        {
        }
        field(22; "Renewal Clause"; TEXT[500])
        {
        }
        field(23; "Request Type"; Option)
        {
            OptionCaption = ' ,Drafting,Amendment,Vetting,Termination,Renewal';
            OptionMembers = " ",Drafting,Amendment,Vetting,Termination,Renewal;
            trigger OnValidate()
            begin
                "Contract No." := '';
                "Party to The Contract" := '';
                "Contract Type" := 0;
                "Contractor Name" := '';
                "Contractor Type" := 0;
                "Type of Service" := 0;
                "Contract Description" := '';
                "Date of Request" := 0D;
                "Start Date" := 0D;
                "End Date" := 0D;
                "Contract Period" := '';
                "Termination Reason" := '';
                "Termination Clause" := '';
                "Renewal Clause" := '';
            end;
        }
        field(25; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            TableRelation = Contracts."Contract No";
            // trigger OnValidate()
            // begin
            //     if Rec."Request Type" = Rec."Request Type"::Drafting then
            //         "Contract No." := '';
            // end;
        }
        field(26; "Contract Sum"; Decimal)
        {
            Caption = 'Contract Sum';
        }
        field(27; "Send/Forward to"; Code[50])
        {
            TableRelation = "Responsibility CenterBR";
        }

        field(28; "Originating Department"; Code[50])
        {
            Editable = false;
        }
        field(29; "Current Department"; Code[50])
        {
            Editable = false;
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
    begin
        UserID := DATABASE.UserId;
        if "No." = '' then begin
            NoseriesSetup.Get;
            NoseriesSetup.TestField(NoseriesSetup."Contract Request No.");
            "No." := NoSeriesMgt.GetNextNo(NoseriesSetup."Contract Request No.");
            // NoSeriesMgt.InitSeries(NoseriesSetup."Contract Request No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        UserSetup.Reset;
        UserSetup.SetRange(UserSetup."User ID", UserID);
        if UserSetup.Find('-') then
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
        UserId: Code[20];
        UserSetup: Record "User Setup";
        NoseriesSetup: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit "No. Series";
        CaseTracker: Record "CF Tracker";
        CFPage: Page "DMU CF Page";
        CFStations: Record "CF Station Actions";
        Comments: Record Comments;

}
