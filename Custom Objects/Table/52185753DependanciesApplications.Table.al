table 52185753 "Dependancies Applications"
{
    LookupPageID = "Dependancies Applications List";
    DrillDownPageId = "Dependancies Applications List";
    fields
    {
        field(1; "No."; Code[30])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SeriesSetup.Get();
                    NoSeriesMgt.TestManual(SeriesSetup."Dependancy Application Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Application Date"; Date)
        {
            Editable = false;
        }
        field(3; "Application Time"; Time)
        {
            Editable = false;
        }

        field(4; "No. Series"; Code[20])
        {
            Editable = false;
        }
        field(5; "Account Type"; Option)
        {
            OptionMembers = " ","Single Member Account","Business Loan Account","Joint Account","Group Account";
        }
        field(6; "Member No."; Code[20])
        {
            TableRelation = IF ("Account Type" = CONST("Single Member Account")) Members where("Account Type" = const("Single Member Account"))
            ELSE
            IF ("Account Type" = CONST("Group Account")) Members where("Account Type" = const("Group Account"))
            else
            if ("Account Type" = const("Group Account")) "Savings Accounts" where("Product Category" = filter("FOSA Account"))
            else
            if ("Account Type" = const("Joint Account")) "Savings Accounts" where("Product Category" = filter("FOSA Account"));


            trigger OnValidate()
            var
                NextofkinApp: Record "Next of KIN Application";
                NOK: Record "Next of KIN";
                SavAcc: Record "Savings Accounts";
                Signatory: Record "Account Signatories";
                SigApp: Record "Signatory Application";
            begin

                // CalcFields(Name);
                SigApp.Reset();
                SigApp.SetRange("Account No", SavAcc."No.");
                if SigApp.FindSet() then SigApp.DeleteAll();
                Signatory.Reset();
                Signatory.SetRange("Account No", SavAcc."No.");
                if Signatory.FindSet() then begin
                    repeat
                        SigApp.Init();
                        SigApp."Account No" := "No.";
                        SigApp."Account Type" := Signatory."Account Type";
                        SigApp."Date Of Birth" := Signatory."Date Of Birth";
                        SigApp."First Name" := Signatory."F Name";
                        SigApp."ID Number" := Signatory."ID Number";
                        SigApp."Second Name" := Signatory."L Name";
                        SigApp."Member No." := Signatory."Member No.";
                        SigApp.Picture := Signatory.Picture;
                        SigApp.Signature := Signatory.Signature;
                        SigApp."Staff/Payroll" := Signatory."Staff/Payroll";
                        SigApp."Must be Present" := Signatory."Must be Present";
                        SigApp."Must Sign" := Signatory."Must Sign";
                        SigApp."PIN Number" := Signatory."PIN Number";
                        SigApp.Names := Signatory.Names;
                        SigApp."Entry No" := Signatory."Entry No";
                        SigApp.Signatory := Signatory.Signatory;
                        SigApp."Phone No." := Signatory."Phone No.";
                        SigApp."Expiry Date" := Signatory."Expiry Date";
                        SigApp.Type := Signatory.Type;
                        SigApp."Account Type" := Signatory."Account Type";
                        SigApp."Other Names" := Signatory."S Name";
                        SigApp.Insert(true);
                        Clear(SigApp);
                    until Signatory.Next() = 0;
                end;


                CalcFields(Name);
                NextofkinApp.Reset();
                NextofkinApp.SetRange("Record ID", "No.");
                if NextofkinApp.FindSet() then NextofkinApp.DeleteAll();
                NOK.Reset();
                NOK.SetRange("Record ID", "Member No.");
                //NOK.SetRange(Deceased, false);
                if NOK.FindSet() then begin
                    repeat
                        NextofkinApp.Init();
                        NextofkinApp."Record ID" := "No.";
                        NextofkinApp."Identification Type" := NOK."Identification Type";
                        NextofkinApp.Identification := NOK.Identification;
                        NextofkinApp.Name := NOK.Name;
                        NextofkinApp.Relationship := NOK.Relationship;
                        NextofkinApp."Is a Beneficiary" := NOK."Is a Beneficiary";
                        NextofkinApp."Is Next of Kin" := NOK."Is Next of Kin";
                        NextofkinApp."Is Nominee" := NOK."Is Nominee";
                        NextofkinApp."Is Contact Person" := NOK."Is Contact Person";
                        NextofkinApp."Date of Birth" := NOK."Date of Birth";
                        NextofkinApp.Address := NOK.Address;
                        NextofkinApp.Telephone := NOK.Telephone;
                        NextofkinApp.Email := NOK.Email;
                        NextofkinApp.Allocation := NOK.Allocation;
                        NextofkinApp.Removed := NOK.Removed;
                        NextofkinApp."From Member Register" := true;
                        NextofkinApp.Insert(true);
                        Clear(NextofkinApp);
                    until NOK.Next() = 0;
                end;
            end;
        }
        field(7; Name; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Members.Name where("No." = field("Member No.")));
        }
        field(8; Description; Text[100])
        {
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(10; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(11; "Responsibility Center"; Code[20])
        {
            Description = 'LookUp to Responsibility Center BR';
            TableRelation = "Responsibility CenterBR";
        }
        field(12; "Created By"; Code[60])
        {
            Editable = false;
        }
        field(13; Created; Boolean)
        {
            Editable = false;
        }
        field(14; Status; Enum "Workflow Status Main Flags")
        {
            Editable = false;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if (xRec.Status = Status::Deffered) and (Rec.Status = Status::Approved) then Error('This record cannot be approved. Please reaopen it first');

                if (Rec.Status = Status::Rejected) or (Rec.Status = Status::Deffered) then
                    GlobalFunctions.CommentsManagement(Rec."No.");
            end;
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
        field(20; "CRM No"; Code[50])
        {
            Editable = false;
        }
        field(21; "M-Smart No"; Code[50])
        {
            Editable = false;
        }
        field(22; "Auto Assign Task"; Boolean)
        {
            Editable = false;
        }
        field(50; "Source Application"; Option)
        {
            OptionMembers = "BC","CRM","Mwalimu Smart","Member Portal";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        DepartMent: Enum "Responsibility Center Enum";

    begin
        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Dependancy Application Nos.");
            NoSeriesMgt.InitSeries(SeriesSetup."Dependancy Application Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        "Application Date" := Today;
        "Created By" := UserId;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end;

        // if "Source Application" <> "Source Application"::"Member Portal" then begin
        //     if "Auto Assign Task" then begin
        //         if not GlobalFunctions.AreUsersPresent(DepartMent::RECORDS, SubDepartment::"Dependancy Edits") then
        //             Error('There are no users present for module loan recovery');
        //         GlobalFunctions.AssignUserTasks(DepartMent::RECORDS, SubDepartment::"Dependancy Edits", "No.");
        //     end else begin
        //         if GlobalFunctions.IsCurrentUserPresent(DepartMent::RECORDS, SubDepartment::"Dependancy Edits", UserId) then begin
        //             GlobalFunctions.InsertUserTasks(DepartMent::RECORDS, SubDepartment::"Dependancy Edits", Rec."No.", UserId);
        //         end else begin
        //             if GlobalFunctions.IsCurrentUserPresent(DepartMent::FOSA, SubDepartment::"Dependancy Edits", UserId) then begin
        //                 GlobalFunctions.InsertUserTasks(DepartMent::FOSA, SubDepartment::"Dependancy Edits", Rec."No.", UserId);
        //             end else
        //                 Error('You are not currently listed as the present user to perform this task');
        //         end;
        //     end;
        // end;
    end;

    trigger OnModify()
    var
        theApplication: Record "Dependancies Applications";
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
        SeriesSetup: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        GlobalFunctions: Codeunit "Global Functions";
        SubDepartment: Enum "Sub Module";
}

