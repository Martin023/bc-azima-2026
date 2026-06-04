table 52186184 Comments
{
    DrillDownPageID = "Comments List";
    LookupPageID = "Comments List";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(2; Comment; Text[500])
        {

        }
        field(3; "Commented By"; code[100])
        {
            Editable = false;
        }
        field(6; Date; DateTime)
        {
            Editable = false;
        }
        field(7; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Editable = false;
        }
        field(8; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Editable = false;
        }
        field(9; "Responsibility Center"; code[30])
        {
            TableRelation = "Responsibility CenterBR";
            Editable = false;
        }
        field(10; "Header No."; code[50])
        {
            Editable = false;
        }
        field(11; Types; Option)
        {
            OptionMembers = Comment,History,"Member Flagging";
        }
        field(12; "Viewd By Somebody Else"; Boolean)
        {
            Editable = false;
        }
        field(13; "Disable Flag"; Boolean)
        {
            trigger OnValidate()
            begin
                "Last Modified At" := CurrentDateTime;
                "Last Modified By" := UserId;
            end;
        }
        field(14; "Last Modified By"; Code[100])
        {
            Editable = false;
        }
        field(15; "Last Modified At"; DateTime)
        {
            Editable = false;
        }
        field(16; "Expires At"; date)
        {
        }
        field(17;"Reminder Date"; date)
        {
            trigger OnValidate()
            var
                UserSetUp: Record "User Setup";
            begin
                TestField("Disable Flag", false);
                if "Reminder Date" < Today then
                    Error('Reminder date cannot be in the past');
                if "Expires At" <> 0D then
                    if "Reminder Date" > "Expires At" then
                        Error('Reminder date cannot be later than expiry date');
                    if "E-mail" = '' then begin
                        if UserSetUp.Get("Commented By") then
                            Rec."E-mail" := UserSetUp."E-mail";
                        if Rec."E-mail" = '' then
                            Error('Cannot set reminder date without an email address. Please update in your user setup.');
                    end;
                        
                
            end;
        }
        field(18; "Reminder Sent"; Boolean)
        {
        }
        field(19; "E-mail"; Text[100])
        {

        }

    }

    keys
    {
        key(Key1; "Entry No.", "Header No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        UserSetUp: Record "User Setup";
    begin
        UserSetUp.Reset();
        UserSetUp.SetRange("User ID", UserId);
        if UserSetUp.FindFirst() then begin
            UserSetUp.TestField("Global Dimension 1 Code");
            UserSetUp.TestField("Global Dimension 2 Code");
            UserSetUp.TestField("Responsibility Centre");
            Rec."Global Dimension 1 Code" := UserSetUp."Global Dimension 1 Code";
            Rec."Global Dimension 2 Code" := UserSetUp."Global Dimension 2 Code";
            Rec."Responsibility Center" := UserSetUp."Responsibility Centre";
            Rec."Commented By" := UserId;
            Date := CurrentDateTime;
            Rec."E-mail" := UserSetUp."E-mail";
        end else
            Error('You must be set up in user setup to create a comment');

        // TODO: Endpoint to update CRM with comments
        // 1. Member application
        // 2. Loan application
        // 3. Share transfer
    end;

    trigger OnDelete()
    var
        myInt: Integer;
    begin
        if "Viewd By Somebody Else" then
            Error('You cannot delete this comment because it has been viewed by another user');
    end;


}

