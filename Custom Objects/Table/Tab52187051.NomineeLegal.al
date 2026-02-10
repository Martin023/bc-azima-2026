table 52187051 "Nominee Legal"
{
    Caption = 'Nominee Legal';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    MembNoSeries.Get;
                    NoSeriesMgt.TestManual(MembNoSeries."Nominee Legal No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            TableRelation = Members."No."; 
            //WHERE("Status" = CONST(Active));
            trigger OnValidate()
            begin
                Members.RESET();
                Members.SetRange("No.", "Member No.");
                if Members.Find('-') then begin
                    "Member Name" := Members.Name;
                end;

                NomineeLines.Reset();
                NomineeLines.SetRange("No.", "No.");
                if NomineeLines.FindSet() then 
                    NomineeLines.DeleteAll();
                
                NextofKin.RESET();
                NextofKin.SetRange("Record ID", Members."No.");
                NextofKin.SetRange("Is Nominee", True);
                if NextofKin.FindSet() then begin
                    
                    repeat
                        NomineeLines.INIT();
                        NomineeLines."No." := "No.";
                        NomineeLines."Nominee Name" := NextofKin.Name;
                        NomineeLines."Nominee Identification" := NextofKin."Identification";
                        NomineeLines."Allocation" := NextofKin.Allocation;
                        NomineeLines.Removed := NextofKin.Removed;
                        NomineeLines.Deceased := NextofKin.Deceased;
                        NomineeLines.Insert();
                    until NextofKin.Next() = 0;
                end;
            end;
        }

        field(3; "Member Name"; Text[50])
        {
            Caption = 'Member Name';
        }
        // field(4; "Nominee Name"; Text[50])
        // {
        //     Caption = 'Nominee Name';
        // }
        // field(12; "Percentage Allocated"; Decimal){}
        field(5; "Created By"; Code[50])
        {
            Caption = 'Created By';
        }
        field(6; "Created at"; DateTime)
        {
            Caption = 'Created Date';
        }
        field(7; "Comments"; Text[250])
        {
            Caption = 'Comments';
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            trigger OnValidate()
            begin

            end;
        }
        field(9; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            trigger OnValidate()
            begin

            end;
        }
        field(10; "Responsibility Centre"; Code[20])
        {
            Description = 'LookUp to Responsibility Center BR';
            TableRelation = "Responsibility Center";
        }
        field(11; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series".Code;
        }
        field(13; Status; Option)
        {
            OptionMembers = "Open",Pending,Approved,Rejected;
        }
        field(3969; "User ID"; Code[50])
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
    Trigger OnInsert()

    var
        UserSetup: Record "User Setup";
        SeriesSetup: Record "Credit Nos. Series";
    begin
        if "No." = '' then begin
            SeriesSetup.Get;
            SeriesSetup.TestField(SeriesSetup."Nominee Legal No.");
            NoSeriesMgt.InitSeries(SeriesSetup."Nominee Legal No.", xRec."No. Series", 0D, "No.", "No. Series");
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
            "Responsibility Centre" := UserSetup."Responsibility Centre";
        end;
    end;

    var
        MembNoSeries: Record "Credit Nos. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Members: Record "Members";
        NextofKin: Record "Next of KIN";
        NomineeLines: Record "Nominee Lines Table";

}
