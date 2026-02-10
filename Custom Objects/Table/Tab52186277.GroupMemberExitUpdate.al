table 52186277 "Group Member Exit & Update"
{
    Caption = '"Group Member Exit & Update"';
    DataClassification = ToBeClassified;
    LookupPageId = "Group Mem Exit & Update List";
    DrillDownPageId = "Group Mem Exit & Update List";


    fields
    {
        field(1; "No."; Code[50])
        {
            Caption = 'No';
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    MembNoSeries.Get;
                    NoSeriesMgt.TestManual(MembNoSeries."Driver No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Group No."; Code[50])
        {
            Caption = 'Group No.';
            TableRelation = Members."No." where("Account Type" = CONST("Group Account"));

            trigger OnValidate()
            var
                myInt: Integer;
                Members: Record "Members";
            begin
                if Members.Get("Group No.") then begin
                    "Group Name" := Members."Name";
                    "Phone Number" := Members."Phone No.";
                    "Registration No." := Members."Company Registration No.";
                    "KRA PIN" := Members."P.I.N Number";
                    "Group Status" := Members."Status";
                end;

                GroupEdit.Reset();
                GroupEdit.SetRange("Header No.", Rec."No.");
                if GroupEdit.Find('-') then
                    GroupEdit.DeleteAll();

                GroupEdit.Reset();
                GroupEdit.FindLast();
                EntryNo := GroupEdit."Entry No.";

                AccountSignatories.Reset();
                //AccountSignatories.SetRange("Account Type", AccountSignatories."Account Type"::Member);
                AccountSignatories.SetRange("Account No", Rec."Group No.");
                if AccountSignatories.FindSet() then begin
                    repeat
                        EntryNo := EntryNo + 1;

                        GroupEdit.Init();
                        GroupEdit."Entry No." := EntryNo;
                        GroupEdit."Header No." := Rec."No.";
                        GroupEdit."Group No." := AccountSignatories."Account No";
                        GroupEdit."Member No" := AccountSignatories."Member No.";
                        GroupEdit."Member Name" := AccountSignatories.Names;
                        GroupEdit."ID No." := AccountSignatories."ID Number";
                        GroupEdit."KRA PIN" := AccountSignatories."PIN Number";
                        GroupEdit."Phone No." := AccountSignatories."Phone No.";
                        GroupEdit.Designation := AccountSignatories.Type;
                        GroupEdit.Signatory := AccountSignatories.Signatory;
                        GroupEdit."Must Be Present" := AccountSignatories."Must Be Present";
                        GroupEdit."Account Type" := AccountSignatories."Account Type";
                        GroupEdit.Insert();
                    until AccountSignatories.Next = 0;
                end;
            end;
        }
        field(3; "Group Name"; Text[300])
        {
            Caption = 'Group Name';
        }
        field(4; "Phone Number"; Code[30])
        {
            Caption = 'Phone Number';
        }
        field(5; "Registration No."; Code[50])
        {
            Caption = 'Registration No.';
        }
        field(6; "KRA PIN"; Code[50])
        {
            Caption = 'KRA PIN';
        }
        field(7; "Group Status"; Enum "Member Status")
        {
            Caption = 'Status';
        }
        field(8; "Status"; Enum "Workflow Status Main Flags")
        {
            Caption = 'Status';
        }
        field(9; "Responsibility Center"; Code[50])
        {
            TableRelation = "Responsibility CenterBR";
        }
        field(10; "Global Dimension 1 Code"; Code[20])
        {
        }
        field(11; "Global Dimension 2 Code"; Code[50])
        {
        }
        field(12; "Created By"; Code[20])
        {
        }
        field(13; "Created At"; DateTime)
        {
        }
        field(14; Type; Option)
        {
            OptionMembers = " ","Group Closure","Individual Exit","Transfer","Group Edit", "New Group Member";

        }
        field(16; "User ID"; Code[50])
        {
        }
        field(17; "No. Series"; Code[50])
        {
        }
        field(18; "New Group No."; Code[50])
        {
            TableRelation = Members."No." where("Account Type" = CONST("Group Account"));
        }
        field(19; "New Group Name"; Text[200])
        {
            trigger OnValidate()
            var
                myInt: Integer;
                Members: Record Members;
            begin
                if Members.Get("New Group No.") then begin
                    if Rec."New Group No." = Rec."Group No." then begin
                        error('New Group No. cannot be the same as the Group No.');
                    end
                    else
                        "New Group Name" := Members."Name";
                end;
            end;
        }
        field(20; "Member No."; Code[50])
        {
            TableRelation = Members."No.";
            trigger OnValidate()
            var
                myInt: Integer;
                Members: Record Members;
            begin
                if Members.Get("Member No.") then begin
                    "Member Name" := Members."Name";
                end;
            end;
        }
        field(21; "Member Name"; Text[50])
        {
        }
        field(22; Posted; Boolean)
        {
            Caption = 'Posted';
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

    Var
        UserSetup: Record "User Setup";
        SeriesSetup: Record "Credit Nos. Series";
    begin
        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Driver No.");
            NoSeriesMgt.InitSeries(SeriesSetup."Driver No.", xRec."No. Series", 0D, "No.", "No. Series");

        end;
        "Created By" := userID;
        "Created at" := CurrentDateTime;

        "User ID" := UserId;
        "Created By" := UserId;

        if UserSetup.Get(UserId) then begin
            UserSetup.TestField(UserSetup."Global Dimension 1 Code");
            UserSetup.TestField(UserSetup."Global Dimension 2 Code");
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
            "Global Dimension 2 Code" := UserSetup."Global Dimension 2 Code";
            "Responsibility Center" := UserSetup."Responsibility Centre";
        end;
    end;

    var
        MembNoSeries: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        AccountSignatories: Record "Account Signatories";
        GroupEdit: Record "Group Members Edit";
        EntryNo: Integer;
}
