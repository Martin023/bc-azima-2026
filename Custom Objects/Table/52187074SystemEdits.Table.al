namespace System.IO;


using Microsoft.Finance.Dimension;
using System.Environment;
using System.Reflection;
using System.Security.AccessControl;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.NoSeries;
using System.Security.User;
using Microsoft.Foundation.AuditCodes;

table 52187074 "System Edits"
{
    ReplicateData = false;
    LookupPageId = "System Edits List";
    DrillDownPageId = "System Edits List";

    fields
    {
        field(1; "No."; Code[30])
        {
            Editable = false;
        }
        field(2; "No. Series"; Code[30])
        {
            Caption = 'No. Series';
        }

        field(3; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            NotBlank = true;
            TableRelation = "System Edits Tables" where(Activated = const(true));


            trigger OnValidate()
            begin
                if ConfigMgt.IsSystemTable("Table ID") then
                    Error(Text001, "Table ID");

                if "Table ID" <> xRec."Table ID" then
                    "Page ID" := ConfigMgt.FindPage("Table ID");

                // if "No." = '' then
                //     NoSeriesMgt.InitSeries('EDITS', xRec."No. Series", 0D, "No.", "No. Series");
                if "No." = '' then begin
                    SeriesSetup.Get;
                    SeriesSetup.TestField(SeriesSetup."System Edits");
                    NoSeriesMgt.InitSeries(SeriesSetup."System Edits", xRec."No. Series", 0D, "No.", "No. Series");
                end;
                Message(SystemEditsCodeunit.Setfilters("Table ID", "No.", false, ''));

            end;
        }
        field(4; "Table Name"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Name" where("Object Type" = const(Table),
                                                                        "Object ID" = field("Table ID")));
            Caption = 'Table Name';
            Editable = false;
            FieldClass = FlowField;
        }

        field(5; "Table Caption"; Text[250])
        {
            CalcFormula = lookup("System Edits Tables"."Table Caption" where("Table ID" = field("Table ID")));
            Caption = 'Table Caption';
            Editable = false;
            FieldClass = FlowField;
        }

        field(6; "No. of Fields to Filter"; Integer)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("System Edits Filters" where("Record ID" = field("No.")));
        }

        field(7; "No. of Fields Available"; Integer)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("System Edits Fields" where("Record ID" = field("No.")));
        }


        field(8; Comments; Text[250])
        {
            Caption = 'Comments';
        }

        field(10; "Innitiating Officer"; Code[100])
        {
            Caption = 'Created by User ID';
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
            TableRelation = User."User Name";
        }
        field(31; "Editing Officer"; Code[50])
        {
            Caption = 'Created by User ID';
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
            TableRelation = User."User Name";
        }
        field(9; "Approving Officer"; Code[50])
        {
            Caption = 'Approved by User ID';
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
            TableRelation = User."User Name";
        }


        field(11; "Page ID"; Integer)
        {
            Caption = 'Page ID';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Page));

            trigger OnLookup()
            begin
                ConfigValidateMgt.LookupPage("Page ID");
                Validate("Page ID");
            end;
        }
        field(12; Status; enum "Workflow Status Main Flags")
        {
            Editable = false;

            trigger OnValidate()
            var
                Action: Option SetFilter,PostChanges;
                RecRef: RecordRef;
                SystemEditsCard: page "System Edits Card";
                CRMMemberEdit: Record "CRM Member Edit";
                MSmartMemberEdit: Record "M-Smart Member Edit";
                GeneralSetUp: Record "General Set-Up";
            begin
                GeneralSetUp.Get();
                if Status = Rec.Status::Approved then begin
                    Rec."Approving Officer" := UserId;
                end;
                if Status = Rec.Status::Pending then begin
                    Rec."Editing Officer" := UserId;
                end;

                if (xRec.Status = Status::Deffered) and (Rec.Status = Status::Approved) then Error('This record cannot be approved. Please reaopen it first');

                if (Rec.Status = Status::Rejected) or (Rec.Status = Status::Deffered) then
                    GlobalFunctions.CommentsManagement(Rec."No.");

                if GeneralSetUp."AutoCompletion on approval" then begin
                    if Status = Rec.Status::Approved then begin
                        Message(SystemEditsCodeunit.SetFilterFields(Rec."Table ID", Rec."No.", Action::PostChanges, RecRef, RecRef));

                        if Rec."Table ID" = 52185700 then
                            SystemEditsCard.SMSMemberOnChange(Rec);

                        Rec.Posted := true;
                        Rec."Posted By" := UserId;
                        Rec."Posting Date" := CurrentDateTime;
                        if CRMMemberEdit.Get(Rec."CRM No") then begin
                            CRMMemberEdit."Change Complete" := true;
                            CRMMemberEdit.Status := CRMMemberEdit.Status::Approved;
                            CRMMemberEdit.Modify(true);
                        end;
                        if MSmartMemberEdit.Get(Rec."M-Smart No") then begin
                            MSmartMemberEdit."Change Complete" := true;
                            MSmartMemberEdit.Status := MSmartMemberEdit.Status::Approved;
                            MSmartMemberEdit.Modify(true);
                        end;
                        Rec.Modify();
                    end;
                end;
            end;
        }
        field(13; Posted; Boolean)
        {
            Editable = false;


        }
        field(14; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
            end;
        }
        field(15; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
            end;
        }
        field(16; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility CenterBR";
            Editable = false;
        }
        field(17; "Application Date"; DateTime)
        {
            Editable = false;
        }
        field(18; "Posted By"; Code[50])
        {
            Editable = false;
        }
        field(19; "Posting Date"; DateTime)
        {
            Editable = false;
        }
        field(20; "Edits Reason"; Code[50])
        {
            TableRelation = "System Edit Reasons" where("Responsibility Center" = field("Responsibility Center"));
            trigger OnValidate()
            var
            begin
                CalcFields("Reason Description");
            end;
        }
        field(21; "Reason Description"; text[200])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("System Edit Reasons".Description where(Code = field("Edits Reason")));
            Editable = false;
        }
        field(22; "CRM No"; Code[50])
        {
            Editable = false;
        }
        field(23; "Request Source"; Option)
        {
            OptionMembers = "Business Central",CRM,"M-Smart","M-Portal";
        }
        field(24; "Responsible Officer"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."User ID" where("Record ID" = field("No.")));
        }
        field(25; "Supervisor ID"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."Supervisor ID" where("Record ID" = field("No.")));
        }
        field(26; "Old Picture 1"; Blob)
        {
            SubType = Bitmap;
        }

        field(27; "Old Picture 2"; BLOB)
        {
            SubType = Bitmap;
        }
        field(28; "New Picture 1"; BLOB)
        {
            SubType = Bitmap;
        }
        field(29; "New Picture 2"; BLOB)
        {
            SubType = Bitmap;
        }
        field(30; "M-Smart No"; Code[50])
        {
            Editable = false;
        }
        FIELD(32; "Posting Time"; time)
        {

        }
        field(33; "Application Time"; time)
        {

        }
        field(34; "M-Portal No"; Code[50])
        {
            Editable = false;
        }

    }


    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

    end;

    trigger OnInsert()
    var
        SubDepartments: Enum "Sub Module";
        GlobalFunctions: Codeunit "Global Functions";
        CRMEdit: Record "CRM Member Edit";
        MSmartEdit: Record "M-Smart Member Edit";
    begin
        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."System Edits");
            NoSeriesMgt.InitSeries(SeriesSetup."System Edits", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Innitiating Officer" := UserId;

        "Application Date" := CurrentDateTime;
        "Application Time" := Time;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            UserSetup.TestField("Responsibility Centre");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end else
            Error('You must be set up in user setup');

        if "CRM No" = '' then begin
            GlobalFunctions.InsertUserTasks(DepartMent::RECORDS, SubDepartmentS::"Members Edits(BC)", Rec."No.", UserID);

            if MSmartEdit.Get("M-Smart No") then begin
                MSmartEdit.CalcFields("Responsible Officer", "Supervisor ID");
                GlobalFunctions.InsertUserTasks(DepartMent::RECORDS, SubDepartmentS::"Member Edits(M-Smart)", Rec."No.", MSmartEdit."Responsible Officer");
            end;
        end else begin
            if CRMEdit.Get("CRM No") then begin
                CRMEdit.CalcFields("Responsible Officer", "Supervisor ID");
                GlobalFunctions.InsertUserTasks(DepartMent::RECORDS, SubDepartmentS::"Members Edits(BC)", Rec."No.", CRMEdit."Responsible Officer");
            end;
        end;
    end;

    trigger OnModify()
    var
        theApplication: Record "System Edits";
    begin
        theApplication.SetRange("No.", Rec."No.");

        if theApplication.FindFirst then begin
            if (
            ((Rec."M-Smart No" <> '') or (Rec."CRM No" <> '')) and
            (theApplication.Status <> Rec.Status)
            ) then begin
                case Rec.Status of
                    Rec.Status::Open:
                        begin
                            UpdateCRMMemberEdits('Open');
                            UpdateMSmartMemberEdits('Open');
                        end;
                    Rec.Status::Pending:
                        begin
                            UpdateCRMMemberEdits('Send');
                            UpdateMSmartMemberEdits('Send');
                        end;
                    Rec.Status::Archived:
                        begin
                            UpdateCRMMemberEdits('Archive');
                            UpdateMSmartMemberEdits('Archive');
                        end;
                    Rec.Status::Deffered:
                        begin
                            UpdateCRMMemberEdits('Defer');
                            UpdateMSmartMemberEdits('Defer');
                        end;
                    Rec.Status::Approved:
                        begin
                            UpdateCRMMemberEdits('Approve');
                            UpdateMSmartMemberEdits('Approve');
                        end;
                    Rec.Status::Rejected:
                        begin
                            UpdateCRMMemberEdits('Reject');
                            UpdateMSmartMemberEdits('Reject');
                        end;
                    Rec.Status::Cancelled:
                        begin
                            UpdateCRMMemberEdits('Cancel');
                            UpdateMSmartMemberEdits('Cancel');
                        end;
                    else
                end;
            end;
        end;
    end;

    local procedure UpdateCRMMemberEdits(WorkflowAction: Text)
    var
        CRMMemberEdit: Record "CRM Member Edit";
    begin
        // Message('Updating CRM Member Edit %1 to workflow action %2', Rec."CRM No", WorkflowAction);
        if CRMMemberEdit.Get(Rec."CRM No") then begin
            case WorkflowAction of
                'Open':
                    begin
                        CRMMemberEdit.Status := CRMMemberEdit.Status::Open;
                    end;
                'Send':
                    begin
                        CRMMemberEdit.Status := CRMMemberEdit.Status::Pending;
                    end;
                'Approve':
                    begin
                        CRMMemberEdit."Change Complete" := true;
                        CRMMemberEdit.Status := CRMMemberEdit.Status::Approved;
                    end;
                'Reject':
                    begin
                        CRMMemberEdit.Status := CRMMemberEdit.Status::Rejected;
                    end;
                'Defer':
                    begin
                        CRMMemberEdit.Status := CRMMemberEdit.Status::Deffered;
                    end;
                'Archive':
                    begin
                        CRMMemberEdit.Status := CRMMemberEdit.Status::Archived;
                    end;
                'Cancel':
                    begin
                        CRMMemberEdit.Status := CRMMemberEdit.Status::Cancelled;
                    end;
            end;
            CRMMemberEdit.Modify(true);
        end else begin
            // Message('Unknown CRM Member Edit %1', Rec."CRM No");
        end;

    end;

    local procedure UpdateMSmartMemberEdits(WorkflowAction: Text)
    var
        MSmartMemberEdit: Record "M-Smart Member Edit";
    begin
        // Message('Updating M-Smart Member Edit %1 to workflow action %2', Rec."M-Smart No", WorkflowAction);
        if MSmartMemberEdit.Get(Rec."M-Smart No") then begin
            case WorkflowAction of
                'Open':
                    begin
                        MSmartMemberEdit.Status := MSmartMemberEdit.Status::Open;
                    end;
                'Send':
                    begin
                        MSmartMemberEdit.Status := MSmartMemberEdit.Status::Pending;
                    end;
                'Approve':
                    begin
                        MSmartMemberEdit."Change Complete" := true;
                        MSmartMemberEdit.Status := MSmartMemberEdit.Status::Approved;
                    end;
                'Reject':
                    begin
                        MSmartMemberEdit.Status := MSmartMemberEdit.Status::Rejected;
                    end;
                'Defer':
                    begin
                        MSmartMemberEdit.Status := MSmartMemberEdit.Status::Deffered;
                    end;
                'Archive':
                    begin
                        MSmartMemberEdit.Status := MSmartMemberEdit.Status::Archived;
                    end;
                'Cancel':
                    begin
                        MSmartMemberEdit.Status := MSmartMemberEdit.Status::Cancelled;
                    end;
            end;
            MSmartMemberEdit.Modify(true);
        end else begin
            // Message('Unknown M-Smart Member Edit %1', Rec."M-Smart No");
        end;

    end;

    var
        ConfigValidateMgt: Codeunit "Config. Validate Management";
        ConfigMgt: Codeunit "Config. Management";
        ConfigPackageMgt: Codeunit "Config. Package Management";
        Text001: Label 'You cannot use system table %1 in the package.';
        SeriesSetup: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SystemEditsCodeunit: Codeunit "System Editss";
        CreditNoSeries: Record "Credit Nos. Series";
        UserSetup: Record "User Setup";
        GlobalFunctions: Codeunit "Global Functions";
        DepartMent: Enum "Responsibility Center Enum";

}

