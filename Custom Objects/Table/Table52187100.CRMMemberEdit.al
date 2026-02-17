table 52187100 "CRM Member Edit"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Open CRM Member Edits";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeriesSetup.Get;
                    NoSeriesMgt.TestManual(SeriesSetup."CRM Member Edit App Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "No. Series"; Code[20])
        {
            Editable = false;
        }
        field(3; "Member No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Members;
            // Editable = false;

            trigger OnValidate()
            begin
                CalcFields("Member Name");
            end;
        }
        field(4; "Member Name"; Text[80])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Name where("No." = field("Member No.")));
        }

        field(5; "Edit Information"; Text[1000])
        {
            DataClassification = ToBeClassified;
            // Editable = false;
        }

        field(6; Status; Enum "Workflow Status Main Flags")
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(7; "CRM No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(8; "CRM Created By"; Code[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(9; "CRM Branch"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Responsibility Center"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(12; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Responsible Officer"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."User ID" where("Record ID" = field("No.")));
        }
        field(16; "Supervisor ID"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("User Tasks"."Supervisor ID" where("Record ID" = field("No.")));
        }
        field(17; "Change Complete"; Boolean)
        {
            Editable = false;
        }
        field(18; "Type of Edit"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Biodata,BBF,Nominee,"Picture & Signature";
        }
        field(19; "Sent Back to CRM"; Boolean)
        {
            Editable = False;
        }
        field(20; "Member Status"; enum "Member Status")
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Status where("No." = field("Member No.")));
        }
        field(21; "ID No"; Code[20])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Primary Identification" where("No." = field("Member No.")));
        }

        field(22; "Approved By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "Approval Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(24; "Delegate Zone"; Code[20])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Delegates Zone" where("No." = field("Member No.")));
        }

        field(25; "Employer"; Code[100])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Members."Employer Code" where("No." = field("Member No.")));
        }
        field(26;"Application Time";Time)
        {

        }
        field(27;"Approval Time";Time)
        {

        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "CRM No.")
        {
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        SeriesSetup: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit "No. Series";
        GlobalFunctions: Codeunit "Global Functions";
        UserSet: Record "User Setup";
        CrmMemberedit: Record "CRM Member Edit";

    trigger OnInsert()
    var
        UserSetup: Record "User Setup";
        SubDepartments: Enum "Sub Module";
        theSMS: Text;
        theMember: Record members;
    begin
        CrmMemberedit.Reset();
        CrmMemberedit.SetRange(CrmMemberedit."Member No.", Rec."Member No.");
        CrmMemberedit.SetFilter(Status, '%1|%2', CrmMemberedit.Status::Open, CrmMemberedit.Status::Pending);
        CrmMemberedit.SetRange("Type of Edit", Rec."Type of Edit");
        if CrmMemberedit.FindFirst() then begin
            Error('Member has a similar application of number %1 at status %2', CrmMemberedit."No.", CrmMemberedit.Status);
        end;
        //    Productva.Reset();
        //         Productva.SetRange(Productva."Member No.", Rec."Member No.");
        //         Productva.SetFilter(Status, '%1|%2', Productva.Status::Open, Productva.Status::"Pending Approval");
        //         if Productva.FindFirst() then begin
        //             ProCo := Productva.Count;
        //             if ProCo > 1 then begin
        //                 Error('Member has existing application of No. %1', Productva."No.");
        //             end;
        //         end;
        if "No." = '' then begin

            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."CRM Member Edit App Nos.");
            "No." := NoSeriesMgt.GetNextNo(SeriesSetup."CRM Member Edit App Nos.");
            // NoSeriesMgt.InitSeries(SeriesSetup."CRM Member Edit App Nos.", xRec."No. Series", 0D, "No.", "No. Series");

        end;

        if UserSet.Get(UserId) then begin
            "Responsibility Center" := UserSet."Shortcut Dimension 3 Code";
        end;

        "Application Date" := Today;
        "Application Time":=Time;
        "Created By" := UserId;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end;

        if not GlobalFunctions.AssignUserTasks(DepartMent::RECORDS, SubDepartments::"Member Edits(CRM)", "No.") then
            Message('Auto asign of tasks to users has failed. Please make sure that you have present users or contact your system administrator');



        // SMS to applicant
        theSMS := 'Dear applicant, your membership edit request has been received successfully and is being processed. REF ' + "No.";

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
                'Member Edit Application',
                theSMS,
                'TEXT',
                'ME APPLICATION',
                'CRM'
            );
        end;
    end;

    trigger OnModify()
    var
        thisApp: Record "CRM Member Edit";
        theSMS: Text;
        theMember: Record members;
    begin
        thisApp.Reset;

        thisApp.SetRange("No.", Rec."No.");

        if thisApp.FindFirst then begin
            if thisApp.Status <> Rec.Status then begin
                if Rec.Status = Rec.Status::Approved then begin
                    Rec."Approved By" := UserId;
                    Rec."Approval Date" := Today;
                    Rec."Approval Time":=Time;
                end;

                // SMS to applicant
                case Status of
                    Status::Approved:
                        theSMS := 'Dear applicant, your membership edit request has been approved. REF ' + "No.";
                    Status::Rejected:
                        theSMS := 'Dear applicant, your membership edit request has been rejected. REF ' + "No.";
                end;

                if theSMS <> '' then begin
                    theMember.Reset;
                    theMember.SetRange("No.", "Member No.");

                    if theMember.FindFirst then begin
                        if theSMS <> '' then begin
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
                                'Member Edit Application',
                                theSMS,
                                'TEXT',
                                'ME APPLICATION',
                                'CRM'
                            );
                        end;
                    end;
                end;
            end;
        end;
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    var
        SkySMS: CodeUnit SendSms;
        SkySendEmail: Codeunit "Sky Send Email";
        SMSSource: enum "SMS Source";
        DepartMent: Enum "Responsibility Center Enum";
}